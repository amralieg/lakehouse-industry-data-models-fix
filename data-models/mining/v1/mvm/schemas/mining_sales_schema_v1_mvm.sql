-- Schema for Domain: sales | Business: Mining | Version: v1_mvm
-- Generated on: 2026-05-05 14:20:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`sales` COMMENT 'Owns the commercial sales pipeline and commodity trading lifecycle including spot and term offtake agreements, price negotiations, shipment nominations, revenue forecasting, and benchmark pricing (Platts, TSI). Tracks commodity volumes and sales performance against LOM production forecasts.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`offtake_agreement` (
    `offtake_agreement_id` BIGINT COMMENT 'Primary key for offtake_agreement',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Long-term offtake agreements are assigned to cost centres representing specific mine sites for revenue allocation, cost recovery tracking, and life-of-mine financial planning. Essential for mine-level',
    `counterparty_id` BIGINT COMMENT 'Reference to the buyer counterparty (steel mill, smelter, energy company) who is party to this offtake agreement.',
    `credit_limit_id` BIGINT COMMENT 'Foreign key linking to customer.credit_limit. Business justification: Credit risk management requires tracking which approved credit limit covers each offtake agreement at execution. Mining credit controllers monitor agreement-level credit utilization against approved l',
    `delivery_destination_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_destination. Business justification: Offtake agreements contractually specify the delivery/discharge destination. Linking to the registered delivery_destination enables contract management validation, logistics planning, and port capacit',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Offtake agreements are executed by a specific legal entity as the contracting party. Required for revenue recognition under IFRS 15, contract liability reporting, and ensuring the correct legal entity',
    `lom_plan_id` BIGINT COMMENT 'Foreign key linking to mine.lom_plan. Business justification: Offtake agreements are negotiated based on LOM production capacity and reserve life. Commercial teams align contracted volumes with mine production forecasts to ensure deliverability over multi-year c',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Offtake agreements are negotiated against a specific mine sites production — specifying loading port, commodity specifications, and annual volumes tied to that sites capacity. Commercial managers an',
    `ore_reserve_id` BIGINT COMMENT 'Foreign key linking to exploration.ore_reserve. Business justification: Offtake agreements are negotiated and underwritten based on declared ore reserves. Buyers require reserve certification before committing to long-term purchase contracts. This link is essential for co',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Offtake agreements are commercially structured around a specific orebodys reserve status, commodity type, and life-of-mine tonnage. Commercial and legal teams reference the orebody when setting contr',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to customer.payment_term. Business justification: Offtake agreements define contractual payment terms referencing the payment_term master. Currently payment_term_days is a plain integer — normalizing to a FK enables contract management, credit risk',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to sales.price_index. Business justification: offtake_agreement has benchmark_index (STRING) which is a code reference to the price_index master used in the pricing mechanism. Adding price_index_id FK allows proper normalization. The benchmark_in',
    `pricing_basis_id` BIGINT COMMENT 'Foreign key linking to product.pricing_basis. Business justification: Contractual pricing structure: mining offtake agreements are built around a defined pricing_basis (quotational period, provisional percentage, index reference, freight terms). The pricing_mechanism an',
    `pricing_configuration_id` BIGINT COMMENT 'Foreign key linking to product.pricing_configuration. Business justification: Contractual pricing configuration: mining offtake agreements specify exact bonus/penalty rates, rejection limits, and provisional pricing percentages that are formally defined in pricing_configuration',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Offtake agreements are allocated to profit centres for segment reporting, commodity-level profitability analysis, and strategic planning. Required for IFRS segment disclosure and management reporting.',
    `resource_statement_id` BIGINT COMMENT 'Foreign key linking to geology.resource_statement. Business justification: Offtake agreements are reviewed and renegotiated against published resource/reserve statements during annual JORC reporting cycles. The resource_statement provides the audited tonnage and grade basis ',
    `royalty_agreement_id` BIGINT COMMENT 'Foreign key linking to tenement.royalty_agreement. Business justification: Offtake agreement pricing and net-back calculations must account for the royalty agreement governing the tenement. Commercial teams model royalty costs when structuring offtake pricing. Mining deal st',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Offtake agreements contractually specify the exact saleable product (grade, form, specification) being supplied. Essential for contract compliance tracking, quality certificate preparation, pricing fo',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Contractual quality definition: every mining offtake agreement is anchored to a product specification defining guaranteed grades, penalty/bonus thresholds, and rejection limits. This is the foundation',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Long-term offtake agreements require reserve backing from specific tenements for project financing and bankability. Lenders and offtake partners require certification that contracted volumes are suppo',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Offtake agreements in project-financed mining are tied to specific WBS elements for capital project revenue tracking and project finance covenant compliance. Required for project-level P&L reporting a',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the offtake agreement, used in commercial correspondence and invoicing.',
    `agreement_type` STRING COMMENT 'Classification of the offtake agreement structure: term (long-term fixed volume), spot (one-off shipment), framework (umbrella with call-offs), or master (multi-commodity parent).. Valid values are `term|spot|framework|master`',
    `annual_volume_tonnes` DECIMAL(18,2) COMMENT 'Annual contracted volume in metric tonnes for term agreements. Null for spot agreements.',
    `arbitration_clause` BOOLEAN COMMENT 'Indicates whether the agreement includes an arbitration clause for dispute resolution (e.g., ICC, LCIA, SIAC arbitration).',
    `base_price_usd_per_tonne` DECIMAL(18,2) COMMENT 'Base or reference price per metric tonne in USD for fixed-price agreements, or the floor/ceiling price for index-linked agreements.',
    `contracted_volume_tonnes` DECIMAL(18,2) COMMENT 'Total volume of commodity contracted under this agreement, measured in metric tonnes. For term agreements, this is the aggregate volume over the agreement tenure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this offtake agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the agreement pricing and invoicing (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `delivery_basis` STRING COMMENT 'Incoterms delivery basis defining the point at which risk and cost transfer from seller to buyer: FOB (Free on Board), CIF (Cost Insurance and Freight), CFR (Cost and Freight), DAP (Delivered at Place), EXW (Ex Works).. Valid values are `FOB|CIF|CFR|DAP|EXW`',
    `effective_date` DATE COMMENT 'Date on which the offtake agreement becomes legally binding and operative.',
    `expiry_date` DATE COMMENT 'Date on which the offtake agreement terminates or expires. Null for evergreen or open-ended agreements.',
    `force_majeure_clause` BOOLEAN COMMENT 'Indicates whether the agreement includes a force majeure clause allowing suspension or termination due to unforeseeable events (natural disasters, strikes, regulatory changes).',
    `governing_law` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of the agreement (e.g., Western Australia, England and Wales, New York).',
    `loading_port` STRING COMMENT 'Name of the port or terminal from which the commodity will be shipped (e.g., Port Hedland, Dampier, Newcastle).',
    `lom_alignment_flag` BOOLEAN COMMENT 'Indicates whether this offtake agreement is aligned with and tracked against the Life of Mine production forecast for revenue planning.',
    `maximum_shipment_size_tonnes` DECIMAL(18,2) COMMENT 'Maximum cargo size per shipment in metric tonnes, as stipulated in the agreement.',
    `minimum_shipment_size_tonnes` DECIMAL(18,2) COMMENT 'Minimum cargo size per shipment in metric tonnes, as stipulated in the agreement (e.g., Panamax 60,000 tonnes, Capesize 150,000 tonnes).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this offtake agreement record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional commercial notes, special terms, or amendments related to the offtake agreement.',
    `offtake_agreement_status` STRING COMMENT 'Current lifecycle status of the offtake agreement: draft (under negotiation), active (in force), suspended (temporarily paused), expired (reached end date), terminated (cancelled before expiry).. Valid values are `draft|active|suspended|expired|terminated`',
    `payment_term_days` STRING COMMENT 'Number of days from invoice date or bill of lading date within which payment is due (e.g., 30, 60, 90 days).',
    `price_adjustment_formula` STRING COMMENT 'Mathematical formula or business rule for calculating price adjustments based on quality, moisture, impurities, or market conditions.',
    `pricing_mechanism` STRING COMMENT 'Method by which the commodity price is determined: index-linked (tied to Platts, TSI, LME), fixed (agreed price), benchmark (reference price with adjustments), or formula (custom calculation).. Valid values are `index_linked|fixed|benchmark|formula`',
    `quality_penalty_clause` BOOLEAN COMMENT 'Indicates whether the agreement includes penalties or price adjustments for commodity quality deviations from specification.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiry by which a party must provide notice of intent to renew or terminate.',
    `renewal_option` STRING COMMENT 'Terms governing renewal of the agreement upon expiry: automatic (auto-renews unless terminated), mutual_consent (both parties must agree), buyer_option (buyer can extend), seller_option (seller can extend), none (no renewal).. Valid values are `automatic|mutual_consent|buyer_option|seller_option|none`',
    `shipment_frequency` STRING COMMENT 'Expected frequency of shipments under the agreement (e.g., monthly, quarterly, as-nominated).',
    `signed_date` DATE COMMENT 'Date on which the offtake agreement was executed and signed by all parties.',
    `tenure_years` DECIMAL(18,2) COMMENT 'Duration of the agreement in years, calculated from effective date to expiry date. Null for spot agreements.',
    CONSTRAINT pk_offtake_agreement PRIMARY KEY(`offtake_agreement_id`)
) COMMENT 'Master record of long-term and spot offtake agreements with commodity buyers (steel mills, smelters, energy companies). Captures agreement type (term/spot), commodity, contracted volumes, pricing mechanism (index-linked, fixed, benchmark), delivery basis (FOB/CIF), tenure, renewal terms, and counterparty reference. SSOT for all commercial sales contracts governing commodity sales.';

CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`commodity_order` (
    `commodity_order_id` BIGINT COMMENT 'Unique identifier for the commodity sales order. Primary key for the commodity order entity.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Individual commodity orders are allocated to cost centres for revenue recognition, mine-site level sales tracking, and production-sales reconciliation. Essential for operational financial management a',
    `counterparty_id` BIGINT COMMENT 'Reference to the buyer counterparty to whom the commodity is being sold. Links to the customer counterparty master.',
    `delivery_destination_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_destination. Business justification: Each commodity order specifies where cargo must be delivered. Normalizing delivery_destination (currently plain text) to a FK enables order management, port capacity planning, and logistics coordina',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Commodity orders are fulfilled from a specific mine site. Order management, logistics scheduling, and site-level revenue reporting all require knowing the supplying mine site. The existing production_',
    `offtake_agreement_id` BIGINT COMMENT 'Reference to the parent term offtake agreement under which this order was raised. Null for spot orders that are not tied to a long-term contract.',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to sales.price_index. Business justification: commodity_order has benchmark_index (STRING) which is a code reference to the price_index master used for pricing. Adding price_index_id FK allows proper normalization. The benchmark_index string colu',
    `pricing_configuration_id` BIGINT COMMENT 'Foreign key linking to product.pricing_configuration. Business justification: Order price calculation: mining commodity orders apply a specific pricing_configuration to determine provisional and final prices including grade adjustments. The plain pricing_basis field is a denorm',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Short-term commodity orders drive production scheduling. Mine planners schedule extraction and processing to meet specific order delivery windows and grade specifications. Essential for order fulfillm',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Commodity orders need profit centre attribution for revenue reporting by business segment. Mining finance requires orders attributed to profit centres for monthly revenue actuals reporting, budget var',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Orders specify the exact saleable product being purchased, not just commodity type. Required for order fulfillment, stockpile allocation, quality certificate matching, pricing accuracy, and ensuring s',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Order quality compliance: mining commodity orders are placed against a contractual product specification (guaranteed Fe%, moisture%, size). The plain quality_specification text field is a denormalizat',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Commodity orders in project-financed mining operations are linked to WBS elements for project-level revenue tracking and capital project covenant compliance. Required when offtake is structured as par',
    `cancellation_reason` STRING COMMENT 'Explanation for why the order was cancelled. Null if the order has not been cancelled. Used for root cause analysis and process improvement.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the order was cancelled. Null if the order has not been cancelled. Used to track order cancellations and their timing.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Timestamp when the order was confirmed and became a binding commitment. Marks the transition from draft to confirmed status.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this commodity order record was first created in the system. Part of the audit trail for order lifecycle tracking.',
    `delivery_terms` STRING COMMENT 'Incoterms delivery terms defining the point at which risk and cost transfer from seller to buyer. Common terms include Free on Board (FOB), Cost Insurance and Freight (CIF), Cost and Freight (CFR).. Valid values are `FOB|CIF|CFR|DAP|DDP|EXW`',
    `delivery_window_end` DATE COMMENT 'End date of the delivery window during which the commodity must be shipped or delivered to the buyer. Defines the latest acceptable delivery date.',
    `delivery_window_start` DATE COMMENT 'Start date of the delivery window during which the commodity must be shipped or delivered to the buyer. Defines the earliest acceptable delivery date.',
    `final_price` DECIMAL(18,2) COMMENT 'Final settled price per unit after all adjustments for assay, quality, and market conditions. Null until final pricing is determined.',
    `lom_forecast_period` STRING COMMENT 'Reference to the Life of Mine (LOM) production forecast period against which this order is tracked. Used to reconcile actual sales commitments against long-term production plans.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this order record. Used for accountability and audit purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this commodity order record was last modified. Tracks the most recent update to the order details.',
    `order_notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information related to this order. Used for operational coordination and audit trail.',
    `order_number` STRING COMMENT 'Externally visible business identifier for the commodity order. Used in communications with buyers, logistics providers, and internal reporting.',
    `order_quantity` DECIMAL(18,2) COMMENT 'Committed volume of commodity to be delivered under this order. Measured in the unit of measure specified in the order.',
    `order_status` STRING COMMENT 'Current lifecycle status of the commodity order. Tracks progression from initial commitment through delivery and invoicing. [ENUM-REF-CANDIDATE: draft|confirmed|nominated|in_transit|delivered|invoiced|cancelled — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Discriminator indicating whether this order is raised under a term offtake agreement or executed as a spot trade. Term orders are part of long-term contracts; spot orders are immediate market transactions.. Valid values are `term|spot`',
    `order_value` DECIMAL(18,2) COMMENT 'Total monetary value of the order calculated as order quantity multiplied by the applicable price (provisional or final). Represents the gross revenue commitment for this order.',
    `price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the commodity price is denominated. Most mining commodities are priced in USD.. Valid values are `USD|EUR|AUD|CNY|GBP|JPY`',
    `price_uom` STRING COMMENT 'Unit of measure for the price (e.g., USD per Dry Metric Tonne, USD per pound). Must align with the quantity unit of measure.. Valid values are `per_DMT|per_WMT|per_MT|per_tonne|per_pound|per_ounce`',
    `provisional_price` DECIMAL(18,2) COMMENT 'Initial price per unit agreed at the time of order confirmation, subject to final adjustment based on assay results and market conditions. Used in provisional pricing arrangements.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the order quantity. Common units include Dry Metric Tonnes (DMT), Wet Metric Tonnes (WMT), Metric Tonnes (MT), pounds, and troy ounces depending on commodity type.. Valid values are `DMT|WMT|MT|tonnes|pounds|ounces`',
    `settlement_terms` STRING COMMENT 'Payment terms and conditions agreed for this order (e.g., 30 days after Bill of Lading, Letter of Credit, advance payment). Defines when and how the buyer will pay.',
    `shipment_nomination_reference` STRING COMMENT 'Reference to the shipment nomination record that allocates this order to a specific vessel or transport movement. Links the order to the physical logistics execution.',
    `trade_date` DATE COMMENT 'Date on which the commodity order was executed or agreed. For spot orders, this is the date the trade was struck. For term orders, this is the date the order was raised against the agreement.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this order record. Used for accountability and audit purposes.',
    CONSTRAINT pk_commodity_order PRIMARY KEY(`commodity_order_id`)
) COMMENT 'Individual sales order raised against a term offtake agreement or executed as a spot trade, representing a confirmed commitment to deliver a specified commodity volume to a buyer. Captures order quantity, commodity grade/specification, delivery window, pricing snapshot (provisional or fixed), order status, shipment nomination reference, order type discriminator (term/spot), trade date, counterparty, settlement terms, pricing basis, and delivery terms. For spot orders: includes agreed spot price, market reference, and immediate/near-term delivery window. Core transactional record driving the order-to-cash lifecycle from commitment through to invoicing. SSOT for all confirmed sales commitments regardless of term or spot origin.';

CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`shipment_nomination` (
    `shipment_nomination_id` BIGINT COMMENT 'Primary key for shipment_nomination',
    `cargo_shipment_id` BIGINT COMMENT 'Foreign key linking to sales.cargo_shipment. Business justification: Shipment nomination is the planned/nominated shipment; cargo_shipment is the actual executed shipment. Adding cargo_shipment_id to shipment_nomination links the nomination to its execution, enabling t',
    `commodity_order_id` BIGINT COMMENT 'Reference to the parent commodity sales order or offtake agreement under which this shipment is nominated.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Shipment nominations represent committed sales volumes allocated to cost centres for production planning and revenue forecasting. Essential for mine-level sales planning and financial forecasting.',
    `counterparty_id` BIGINT COMMENT 'Reference to the customer or trading counterparty receiving this shipment.',
    `delivery_destination_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_destination. Business justification: Vessel nominations must be validated against approved discharge ports registered in delivery_destination. Role-prefix discharge_ distinguishes this from loading port. Supports nomination acceptance/',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Shipment nominations are made from a specific mine sites port. The nomination specifies loading port and logistics tied to the mine site. Site-level nomination tracking and port scheduling require th',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.offtake_agreement. Business justification: A shipment nomination is made under a term offtake agreement. While the path shipment_nomination->commodity_order->offtake_agreement exists, a direct FK to offtake_agreement is essential for nominatio',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Shipment nominations must be validated against the production schedule — nominated quantity and timing must be confirmed against scheduled ore availability before acceptance. A shipping coordinator ch',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Shipment nominations require profit centre attribution for revenue reporting by business segment. Mining finance tracks nominated shipment revenue by profit centre for monthly forecasting, accruals, a',
    `rom_stockpile_id` BIGINT COMMENT 'Foreign key linking to mine.rom_stockpile. Business justification: Shipment nominations specify which ROM stockpile to draw from for vessel loading. Logistics coordinates loading schedules with available inventory by grade and quality. Critical for stockpile manageme',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Nominations specify the exact product grade and form being loaded onto vessels. Critical for vessel loading instructions, quality certificate preparation, customs documentation, customer acceptance cr',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Nomination quality confirmation: vessel nominations in mining must reference the product specification to confirm the nominated cargo meets contractual grade requirements before loading. Operations te',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to sales.vessel. Business justification: Shipment nomination requires formal vessel reference. Currently has vessel_name and imo_number as strings, but vessel is a master reference table in the domain. Adding vessel_id FK allows proper refer',
    `acceptance_date` DATE COMMENT 'Date when the counterparty formally accepted this shipment nomination.',
    `cancellation_date` DATE COMMENT 'Date when this shipment nomination was cancelled.',
    `cancellation_reason` STRING COMMENT 'Explanation for why this shipment nomination was cancelled.',
    `confirmation_date` DATE COMMENT 'Date when the shipment nomination was confirmed and locked in for logistics execution.',
    `contract_price_usd_per_tonne` DECIMAL(18,2) COMMENT 'Agreed contract price per tonne for this shipment nomination, expressed in United States Dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipment nomination record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract price and revenue (typically USD for commodity trading).. Valid values are `^[A-Z]{3}$`',
    `estimated_discharge_date` DATE COMMENT 'Estimated date when discharge operations are expected to commence at the destination port.',
    `estimated_loading_date` DATE COMMENT 'Estimated date when loading operations are expected to commence at the loading port.',
    `estimated_revenue_usd` DECIMAL(18,2) COMMENT 'Estimated total revenue for this shipment nomination, calculated as nominated quantity multiplied by contract price.',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) rule governing the transfer of risk and responsibility between seller and buyer. FOB = Free on Board, CIF = Cost Insurance and Freight, CFR = Cost and Freight. [ENUM-REF-CANDIDATE: FOB|CIF|CFR|DDP|EXW|FCA|CPT|CIP|DAP|DPU — 10 candidates stripped; promote to reference product]',
    `laycan_end_date` DATE COMMENT 'End date of the laycan (lay days cancelling) window during which the vessel must arrive at the loading port. Defines the latest acceptable arrival date before cancellation rights apply.',
    `laycan_start_date` DATE COMMENT 'Start date of the laycan (lay days cancelling) window during which the vessel must arrive at the loading port. Defines the earliest acceptable arrival date.',
    `loading_port_code` STRING COMMENT 'Five-character UN/LOCODE for the port or terminal where the commodity will be loaded onto the vessel.. Valid values are `^[A-Z]{5}$`',
    `loading_port_name` STRING COMMENT 'Human-readable name of the port or terminal where the commodity will be loaded.',
    `nominated_quantity` DECIMAL(18,2) COMMENT 'Quantity of commodity nominated for this shipment, expressed in the unit of measure specified.',
    `nomination_date` DATE COMMENT 'Date when this shipment nomination was formally submitted to the counterparty or logistics provider.',
    `nomination_number` STRING COMMENT 'Externally-known unique business identifier for this shipment nomination, used in communications with counterparties and logistics providers.',
    `nomination_status` STRING COMMENT 'Current lifecycle status of the shipment nomination in the commercial and logistics workflow.. Valid values are `draft|submitted|accepted|rejected|confirmed|cancelled`',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information related to this shipment nomination.',
    `pricing_basis` STRING COMMENT 'Benchmark pricing index or formula used for this shipment (e.g., Platts IODEX 62% Fe, TSI FOB Australia, ICE Newcastle Coal).',
    `pricing_period` STRING COMMENT 'Time period over which the benchmark price will be averaged or fixed for this shipment (e.g., M+1, M+2, quotational period).',
    `quantity_uom` STRING COMMENT 'Unit of measure for the nominated quantity. MT = Metric Tonnes, DMT = Dry Metric Tonnes, WMT = Wet Metric Tonnes.. Valid values are `MT|DMT|WMT|tonnes|kg|lbs`',
    `rejection_date` DATE COMMENT 'Date when the counterparty rejected this shipment nomination.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the counterparty for rejecting this shipment nomination.',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'Allowable percentage variance (plus or minus) from the nominated quantity, as per contract terms.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for this shipment nomination.. Valid values are `vessel|rail|road|barge|pipeline|air`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this shipment nomination record was last modified.',
    CONSTRAINT pk_shipment_nomination PRIMARY KEY(`shipment_nomination_id`)
) COMMENT 'Formal nomination of a vessel or transport mode for a specific cargo delivery under a commodity order. Records vessel name, laycan window, port of loading, port of discharge, nominated quantity, nomination status, and counterparty acceptance. Drives the logistics execution of commodity sales.';

CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`benchmark_price` (
    `benchmark_price_id` BIGINT COMMENT 'Unique identifier for the benchmark price record. Primary key for the benchmark price data product.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Commodity price reference normalization: benchmark prices in mining are published for specific commodities (iron ore 62% Fe, copper cathode, thermal coal). The plain commodity and commodity_grade fiel',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to sales.price_index. Business justification: benchmark_price is daily price data for commodity indices; price_index is the index master/reference. benchmark_price should reference price_index to normalize index metadata. The target price_index t',
    `assessment_methodology` STRING COMMENT 'Description of the methodology used by the publishing agency to assess or calculate this benchmark price (e.g., survey-based, transaction-based, bid-offer spread, volume-weighted average). Important for understanding price reliability and contract applicability.',
    `contract_specification` STRING COMMENT 'Detailed specification of the underlying contract or assessment criteria, including quality parameters, delivery terms, and any adjustments or premiums/discounts applied by the publishing agency.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this benchmark price record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the benchmark price (e.g., USD, EUR, AUD, CNY).. Valid values are `^[A-Z]{3}$`',
    `data_source_url` STRING COMMENT 'The URL or reference to the publishing agencys official data source for this benchmark price. Used for audit trail and data lineage verification.',
    `delivery_basis` STRING COMMENT 'The Incoterms delivery basis for the benchmark price (e.g., CFR - Cost Insurance and Freight, FOB - Free on Board, CIF - Cost Insurance and Freight). Defines the point at which risk and cost transfer.. Valid values are `CFR|CIF|FOB|DAP|DDP|EXW`',
    `delivery_location` STRING COMMENT 'The geographic location or port associated with the delivery basis (e.g., China, Qingdao Port, Rotterdam, Newcastle). Used in conjunction with delivery_basis to define the pricing point.',
    `index_effective_date` DATE COMMENT 'The date from which this benchmark price index became active and available for use in offtake contracts. Defines the start of the indexs lifecycle.',
    `index_expiry_date` DATE COMMENT 'The date on which this benchmark price index was discontinued or became inactive. Null for currently active indices.',
    `index_status` STRING COMMENT 'Current lifecycle status of the benchmark price index. Active indices are currently published and used in contracts; Inactive or Discontinued indices are no longer published but historical data is retained.. Valid values are `Active|Inactive|Discontinued|Suspended`',
    `notes` STRING COMMENT 'Additional notes, commentary, or context provided by the publishing agency regarding this price value or index (e.g., market conditions, supply disruptions, data quality caveats).',
    `price_close` DECIMAL(18,2) COMMENT 'The closing or settlement price value for the price_date, applicable for exchange-traded indices (e.g., LME). Often used as the official settlement price in contracts.',
    `price_date` DATE COMMENT 'The date for which this benchmark price value is published. This is the business event date representing the pricing period or assessment date, not the publication timestamp.',
    `price_high` DECIMAL(18,2) COMMENT 'The highest price value published for the price_date, if the publishing agency provides a price range or intraday high. Used for volatility analysis and risk assessment.',
    `price_low` DECIMAL(18,2) COMMENT 'The lowest price value published for the price_date, if the publishing agency provides a price range or intraday low. Used for volatility analysis and risk assessment.',
    `price_open` DECIMAL(18,2) COMMENT 'The opening price value for the price_date, applicable for exchange-traded indices (e.g., LME). Used for intraday price movement analysis.',
    `price_type` STRING COMMENT 'The type of price represented by this index (e.g., Spot - immediate delivery, Forward - future delivery, Futures - exchange-traded contract, Assessment - agency-assessed price, Settlement - official settlement price).. Valid values are `Spot|Forward|Futures|Assessment|Settlement`',
    `price_value` DECIMAL(18,2) COMMENT 'The published benchmark price value for the given price_date, expressed in the unit_of_measure and currency_code. This is the core pricing data used in provisional pricing calculations and final settlement adjustments.',
    `publication_frequency` STRING COMMENT 'How frequently the publishing agency releases new price values for this index (e.g., Daily, Weekly, Monthly, Real-time).. Valid values are `Daily|Weekly|Monthly|Quarterly|Real-time`',
    `publication_timestamp` TIMESTAMP COMMENT 'The exact date and time when the publishing agency released this price value. Used to track data freshness and ensure timely price updates for provisional pricing calculations.',
    `quotational_period_convention` STRING COMMENT 'The time period convention used for price quotation and settlement in offtake contracts (e.g., Monthly Average of Daily Prices, Spot, Forward Month+1, Forward Month+2, Quarterly Average). Defines how prices are averaged or selected for provisional and final invoicing.. Valid values are `Daily|Weekly|Monthly Average|Spot|Forward M+1|Forward M+2|Forward M+3|Quarterly`',
    `revision_indicator` BOOLEAN COMMENT 'Flag indicating whether this price value has been revised or corrected by the publishing agency after initial publication. True if revised, False if original publication.',
    `revision_reason` STRING COMMENT 'Explanation provided by the publishing agency for why this price value was revised (e.g., data correction, methodology adjustment, late transaction inclusion).',
    `revision_timestamp` TIMESTAMP COMMENT 'The date and time when this price value was revised by the publishing agency, if applicable. Null if no revision has occurred.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the benchmark price (e.g., USD/DMT - US Dollars per Dry Metric Tonne, USD/WMT - US Dollars per Wet Metric Tonne, USD/lb - US Dollars per Pound, USD/oz - US Dollars per Troy Ounce).. Valid values are `USD/DMT|USD/WMT|USD/t|USD/lb|USD/kg|USD/oz`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this benchmark price record was last modified in the system. Used for audit trail and change tracking.',
    `volume_traded` DECIMAL(18,2) COMMENT 'The total volume of commodity traded at this benchmark price on the price_date, if reported by the publishing agency (e.g., for exchange-traded indices). Expressed in the commoditys standard unit (tonnes, pounds, ounces).',
    CONSTRAINT pk_benchmark_price PRIMARY KEY(`benchmark_price_id`)
) COMMENT 'Reference master and daily price repository for commodity benchmark indices used in offtake agreement pricing formulas. Captures both the index definition catalog (index code, index name, publishing agency — Platts, TSI, LME, Fastmarkets — commodity, unit of measure, quotational period convention, active status) and the associated daily/periodic price values (price date, price value, currency). Serves as the single source of truth for all benchmark pricing reference data and price history used in index-linked sales contracts, provisional pricing settlement, and quotational period calculations. Subsumes the price index definition catalog — index metadata and price values are co-located in this product.';

CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Primary key for invoice',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to customer.bank_account. Business justification: Invoices must reference the counterpartys bank account for payment routing and accounts receivable settlement. In mining commodity trade, the paying bank account is specified on the invoice for treas',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to sales.bill_of_lading. Business justification: In commodity trading, the bill of lading is the primary shipping document that triggers invoicing — the invoice is issued upon presentation of the BL. A direct FK from invoice to bill_of_lading formal',
    `cargo_shipment_id` BIGINT COMMENT 'Foreign key linking to sales.cargo_shipment. Business justification: invoice has cargo_reference and bill_of_lading_number (both STRING) which identify the shipment being invoiced. Adding cargo_shipment_id FK establishes proper relationship between invoice and shipment',
    `commodity_order_id` BIGINT COMMENT 'Foreign key linking to sales.commodity_order. Business justification: An invoice is raised against a specific commodity order in mining commodity trading. While the path invoice->cargo_shipment->commodity_order exists, a direct FK provides essential traceability for spo',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Sales invoices are allocated to cost centres for revenue recognition and mine-site P&L tracking. Complements existing GL and profit centre links for complete financial allocation structure.',
    `counterparty_id` BIGINT COMMENT 'Reference to the commodity buyer or customer to whom this invoice is issued. Links to the counterparty master record.',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Sales invoices post revenue to general ledger accounts. This FK is essential for revenue recognition, financial reporting, and audit trail. Enables proper revenue classification by commodity type, cus',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Sales invoices are issued by a specific legal entity. Essential for IFRS revenue recognition, GST/VAT compliance, intercompany reconciliation, and statutory financial reporting. Mining companies with ',
    `letter_of_credit_id` BIGINT COMMENT 'Foreign key linking to customer.letter_of_credit. Business justification: Mining commodity invoices are frequently presented under a Letter of Credit for payment. The direct invoice→LC link is required for LC utilization tracking, documentary credit compliance, and trade fi',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Invoices are issued for ore from a specific mine site. Site-level revenue reporting, statutory royalty calculations, and tax reporting all require the mine site reference on the invoice. A mining fina',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to customer.payment_term. Business justification: Invoice processing and payment reconciliation require structured payment term data including discount schedules, late payment penalties, and approval authorities. Credit control teams use payment_term',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to sales.price_index. Business justification: invoice has benchmark_index (STRING) which is a code reference to the price_index master used for pricing. Adding price_index_id FK allows proper normalization. The benchmark_index string column becom',
    `pricing_configuration_id` BIGINT COMMENT 'Foreign key linking to product.pricing_configuration. Business justification: Invoice price calculation audit: mining invoices apply bonus/penalty grade adjustments per a specific pricing_configuration (penalty_rate_per_unit, bonus_rate_per_unit). Auditors and dispute resolutio',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Sales invoices must be attributed to profit centres for segment reporting and profitability analysis. This FK enables revenue tracking by mine site, commodity type, and business unit, supporting manag',
    `quality_certificate_id` BIGINT COMMENT 'Foreign key linking to sales.quality_certificate. Business justification: invoice has assay_certificate_reference (STRING) which identifies the quality certificate supporting the invoice. Adding quality_certificate_id FK establishes proper relationship. The assay_certificat',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Invoices bill for specific saleable products with defined quality specifications. Essential for revenue recognition by product line, margin analysis, quality dispute resolution, pricing accuracy verif',
    `offtake_agreement_id` BIGINT COMMENT 'Reference to the underlying sales contract or offtake agreement governing this invoice. Links to the master sales contract record.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Sales invoices may be allocated to WBS elements when revenue is tied to specific capital projects or development phases, such as pre-production sales or project-specific offtake agreements.',
    `adjustment_quantity` DECIMAL(18,2) COMMENT 'Quantity adjustment applied during final settlement due to assay results, moisture content, or other quality factors that differ from provisional assumptions. May be positive or negative.',
    `adjustment_status` STRING COMMENT 'Status of the provisional-to-final price adjustment process. Indicates whether adjustments are pending, in progress, completed, or not applicable for this invoice.. Valid values are `pending|in_progress|completed|not_applicable`',
    `adjustment_value` DECIMAL(18,2) COMMENT 'Monetary value of the price adjustment resulting from the difference between provisional and final prices, or from quantity adjustments. Represents the delta between provisional and final invoice value.',
    `buyer_reference` STRING COMMENT 'External reference number or purchase order number provided by the buyer for invoice reconciliation and payment processing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system. Used for audit trail and data lineage tracking.',
    `delivery_date` DATE COMMENT 'Date on which the commodity cargo was delivered to the buyer or destination port. Relevant for FOB (Free on Board) and CIF (Cost Insurance and Freight) terms.',
    `final_price` DECIMAL(18,2) COMMENT 'Final benchmark-settled price per unit after the quotational period has concluded. This is the definitive price used for revenue recognition and represents the SSOT for final pricing.',
    `incoterm` STRING COMMENT 'INCOTERMS code defining the delivery terms and transfer of risk between seller and buyer. Common terms in mining include FOB (Free on Board) and CIF (Cost Insurance and Freight). [ENUM-REF-CANDIDATE: FOB|CIF|CFR|EXW|FCA|CPT|CIP|DAP|DPU|DDP — 10 candidates stripped; promote to reference product]',
    `invoice_number` STRING COMMENT 'Externally-known unique invoice number issued to the commodity buyer. Business identifier for the invoice used in all commercial correspondence and payment reconciliation.. Valid values are `^INV-[0-9]{8,12}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice. Tracks progression from draft through provisional pricing to final settlement and payment. Key states include draft, issued, provisional, final_settled, paid, overdue, disputed, and cancelled. [ENUM-REF-CANDIDATE: draft|issued|provisional|final_settled|paid|overdue|disputed|cancelled — 8 candidates stripped; promote to reference product]',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Total quantity of commodity invoiced, typically measured in dry metric tonnes (DMT) or wet metric tonnes (WMT) depending on the commodity and contract terms.',
    `issue_date` DATE COMMENT 'Date on which the invoice was formally issued to the buyer. Marks the start of the payment terms period and is used for accounts receivable tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was last modified. Tracks the most recent update to the invoice data for audit and change management purposes.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the invoice. May include dispute details, payment arrangements, or other commercial clarifications.',
    `payment_due_date` DATE COMMENT 'Date by which payment is due from the buyer according to the agreed payment terms. Used for accounts receivable aging and cash flow forecasting.',
    `price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice pricing. Commodity pricing is typically denominated in USD for international trade.. Valid values are `USD|AUD|EUR|CNY|JPY|GBP`',
    `provisional_price` DECIMAL(18,2) COMMENT 'Initial price per unit applied at the time of shipment or delivery, subject to final settlement based on benchmark pricing during the quotational period. Represents the preliminary pricing before final adjustment.',
    `quality_specification` STRING COMMENT 'Description of the quality specifications or grade of the commodity invoiced, including key assay parameters (e.g., Fe content, moisture, impurities) as per contract terms.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the invoiced quantity. Common units include DMT (Dry Metric Tonnes), WMT (Wet Metric Tonnes), or MT (Metric Tonnes).. Valid values are `DMT|WMT|MT|tonnes`',
    `quotational_period_end` DATE COMMENT 'End date of the quotational period during which benchmark prices are averaged. Marks the conclusion of the pricing window for final settlement calculation.',
    `quotational_period_start` DATE COMMENT 'Start date of the quotational period during which benchmark prices (Platts, TSI) are averaged to determine the final settlement price. Critical for provisional-to-final price adjustment calculation.',
    `settlement_date` DATE COMMENT 'Date on which the final price settlement was completed and the invoice transitioned from provisional to final pricing. Represents the definitive pricing event for revenue recognition.',
    `shipment_date` DATE COMMENT 'Date on which the commodity cargo was shipped or dispatched to the buyer. Used for revenue recognition timing and logistics tracking.',
    `total_invoice_value` DECIMAL(18,2) COMMENT 'Total monetary value of the invoice after all adjustments, representing the final amount due from the buyer. This is the SSOT for revenue recognition.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Commercial invoice issued to commodity buyers upon shipment or delivery of a cargo, serving as the SSOT for the full pricing lifecycle from provisional through final settlement including all price adjustments. Captures invoice number, buyer reference, commodity, invoiced quantity, provisional price, final benchmark-settled price, adjustment quantity, adjustment value, total invoice value, currency, payment terms, due date, invoice status, quotational period reference, settlement date, and adjustment status. Tracks the complete provisional-to-final price adjustment lifecycle — provisional adjustments are modelled as state transitions within the invoice record, not as separate entities. SSOT for revenue recognition and final settled price.';

CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`provisional_adjustment` (
    `provisional_adjustment_id` BIGINT COMMENT 'Unique identifier for the provisional price adjustment record. Primary key for the provisional adjustment entity.',
    `assay_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.assay_result. Business justification: Provisional price adjustments in mining are triggered when final assay results differ from provisional grades at loading. The existing assay_adjustment_applied flag on provisional_adjustment confirms ',
    `cargo_shipment_id` BIGINT COMMENT 'Reference to the commodity shipment for which this provisional adjustment applies. Links to the shipment that was initially invoiced at provisional pricing.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Provisional pricing adjustments impact revenue and are allocated to cost centres for accurate mine-level profitability tracking. Essential for final revenue recognition and variance analysis.',
    `counterparty_id` BIGINT COMMENT 'Reference to the customer or trading counterparty to whom the commodity was sold under provisional pricing terms.',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Provisional price adjustments generate specific GL postings (revenue adjustment accounts). Mining finance requires direct GL account attribution on adjustments for audit trail, financial statement acc',
    `invoice_id` BIGINT COMMENT 'Reference to the original provisional invoice that is being adjusted. Links to the billing document issued at provisional pricing.',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to sales.price_index. Business justification: provisional_adjustment has benchmark_source (STRING) which identifies the price index used for final settlement. Adding price_index_id FK allows proper normalization. The benchmark_source string colum',
    `pricing_configuration_id` BIGINT COMMENT 'Foreign key linking to product.pricing_configuration. Business justification: Adjustment calculation audit: mining provisional-to-final price adjustments apply grade-based bonus/penalty rates defined in pricing_configuration. The pricing_formula plain field is a denormalization',
    `production_reconciliation_id` BIGINT COMMENT 'Foreign key linking to mine.production_reconciliation. Business justification: Provisional price adjustments are triggered by final assay results reconciled against production data. The production_reconciliation record provides authoritative grade data driving the final price ad',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Provisional adjustments affect segment-level revenue and must be allocated to profit centres for accurate financial reporting and commodity-level performance tracking. Required for IFRS compliance.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Provisional price adjustments (common in iron ore/copper quotational period pricing) are posted against WBS elements for project cost and revenue tracking. Required for AISC reporting and project-leve',
    `adjustment_invoice_date` DATE COMMENT 'Date on which the adjustment invoice or credit/debit note was issued to the counterparty.',
    `adjustment_invoice_number` STRING COMMENT 'Invoice document number issued for the provisional adjustment. May be a credit note (for negative adjustments) or debit note (for positive adjustments).. Valid values are `^[A-Z0-9-]{8,20}$`',
    `adjustment_number` STRING COMMENT 'Business identifier for the provisional adjustment transaction. Externally visible reference number used in financial reconciliation and customer communication.. Valid values are `^ADJ-[0-9]{8,12}$`',
    `adjustment_quantity` DECIMAL(18,2) COMMENT 'Quantity of commodity (in tonnes or other unit of measure) to which the price adjustment applies. May differ from original shipment quantity due to final assay adjustments.',
    `adjustment_status` STRING COMMENT 'Current lifecycle status of the provisional adjustment. Tracks progression from calculation through final settlement and revenue recognition. [ENUM-REF-CANDIDATE: draft|pending|calculated|approved|invoiced|settled|cancelled — 7 candidates stripped; promote to reference product]',
    `adjustment_type` STRING COMMENT 'Classification of the adjustment event. Distinguishes between initial provisional-to-final settlement, interim adjustments during quotational period, and supplementary corrections.. Valid values are `provisional_to_final|interim|final|supplementary`',
    `adjustment_value` DECIMAL(18,2) COMMENT 'Total monetary value of the provisional adjustment, calculated as price difference multiplied by adjustment quantity. Represents the revenue impact to be recognized.',
    `approved_by` STRING COMMENT 'User ID of the finance or sales manager who approved the provisional adjustment for invoicing and revenue recognition. Required for financial control and SOX compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the provisional adjustment was approved for processing. Audit trail for financial control and compliance.',
    `assay_adjustment_applied` BOOLEAN COMMENT 'Indicates whether final assay results triggered a quantity or quality adjustment that impacts the provisional adjustment calculation. True if final assay differed from provisional assay.',
    `commodity_code` STRING COMMENT 'Code identifying the mineral commodity subject to provisional pricing adjustment (e.g., iron ore, copper concentrate, lithium carbonate).. Valid values are `^[A-Z0-9]{3,10}$`',
    `contract_reference` STRING COMMENT 'Reference to the master sales contract or offtake agreement under which the provisional pricing terms are defined.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this provisional adjustment record was first created in the system. Audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in this adjustment record (e.g., USD, AUD, EUR).. Valid values are `^[A-Z]{3}$`',
    `final_price` DECIMAL(18,2) COMMENT 'Final settled price per unit determined by the quotational period benchmark. Represents the actual market price against which revenue is finalized.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this provisional adjustment record. Audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this provisional adjustment record was last modified. Audit trail for change tracking and compliance.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or special circumstances related to the provisional adjustment (e.g., dispute resolution details, manual override justification).',
    `payment_due_date` DATE COMMENT 'Date by which payment of the adjustment amount is due from the counterparty (for positive adjustments) or to the counterparty (for negative adjustments).',
    `payment_received_date` DATE COMMENT 'Actual date on which payment for the adjustment was received from (or paid to) the counterparty. Null if payment is still outstanding.',
    `payment_status` STRING COMMENT 'Current status of payment collection or refund for the adjustment amount. Tracks whether the financial settlement has been completed.. Valid values are `not_due|pending|paid|overdue|disputed|waived`',
    `price_difference` DECIMAL(18,2) COMMENT 'Calculated difference between final price and provisional price per unit. Positive values indicate upward adjustment (additional revenue), negative values indicate downward adjustment (revenue reversal).',
    `provisional_price` DECIMAL(18,2) COMMENT 'Original provisional price per unit applied at the time of shipment and initial invoicing. Represents the estimated market price used for preliminary revenue recognition.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the adjustment quantity. Common values: MT (Metric Tonne), DMT (Dry Metric Tonne), WMT (Wet Metric Tonne), KG (Kilogram), LB (Pound), OZ (Troy Ounce).. Valid values are `MT|DMT|WMT|KG|LB|OZ`',
    `quotational_period_end` DATE COMMENT 'End date of the quotational period over which the final benchmark price is averaged or determined per the sales contract terms.',
    `quotational_period_start` DATE COMMENT 'Start date of the quotational period over which the final benchmark price is averaged or determined per the sales contract terms.',
    `settlement_date` DATE COMMENT 'Date on which the provisional adjustment is finalized and the adjustment value is recognized in revenue. Represents the accounting event date for revenue true-up.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this provisional adjustment record. Audit trail for accountability.',
    CONSTRAINT pk_provisional_adjustment PRIMARY KEY(`provisional_adjustment_id`)
) COMMENT 'Records the price adjustment between provisional and final invoice values for commodity shipments where pricing is settled against a quotational period benchmark. Captures original provisional price, final benchmark-settled price, adjustment quantity, adjustment value, settlement date, and adjustment status. Critical for revenue recognition accuracy.';

CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`revenue_forecast` (
    `revenue_forecast_id` BIGINT COMMENT 'Unique identifier for the revenue forecast record. Primary key.',
    `block_model_id` BIGINT COMMENT 'Foreign key linking to geology.block_model. Business justification: Revenue forecasts must reference the specific block model version used for tonnage and grade assumptions. Critical for forecast reconciliation, audit trail, and understanding forecast variance when mo',
    `commodity_id` BIGINT COMMENT 'Reference to the commodity being forecast (iron ore, copper, coal, lithium, nickel, etc.).',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Revenue forecasts are allocated to cost centres for mine-level AISC and C1 cost reporting, profitability analysis, and variance tracking. Essential for mine site financial planning and performance eva',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Revenue forecasts are prepared per legal entity for IFRS segment reporting, statutory accounts, and tax planning. Mining companies with multiple subsidiaries and JVs must attribute forecast revenue to',
    `lom_plan_id` BIGINT COMMENT 'Foreign key linking to mine.lom_plan. Business justification: Revenue forecasts must align with LOM production volumes, grades, and mine life. Finance uses this link for NPV calculations, board reporting, and investor guidance. The existing mine_site_id(unlinked',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site or operation from which the forecasted production and sales volume originates.',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.offtake_agreement. Business justification: revenue_forecast has sales_contract_reference (STRING) which should link to the offtake_agreement being forecasted. Adding offtake_agreement_id FK (note: using offtake_agreement_id as the column name,',
    `ore_reserve_id` BIGINT COMMENT 'Foreign key linking to exploration.ore_reserve. Business justification: Ore reserves (proven economically mineable resources) are the primary basis for revenue forecasting in mining. Sales teams must align forecasts with declared reserves for regulatory compliance and inv',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Revenue forecasts in mining are prepared at orebody level for Life-of-Mine planning, linking forecast volumes and prices to specific geological resources. Essential for mine planning and investor repo',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to sales.price_index. Business justification: revenue_forecast has benchmark_price_source (STRING) which identifies the price index used for revenue forecasting. Adding price_index_id FK allows proper normalization. The benchmark_price_source str',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Revenue forecasts are built period-by-period from production schedules — forecast volumes and grades are derived directly from scheduled ore tonnes. Mining finance teams require this link for LOM reve',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Revenue forecasts must align with profit centre segment reporting for IFRS compliance, board reporting, and commodity/geographic segment performance tracking. Required for management reporting and str',
    `project_valuation_id` BIGINT COMMENT 'Foreign key linking to finance.project_valuation. Business justification: Revenue forecasts are directly derived from project valuation studies (NPV/IRR/breakeven). Mining finance teams link LOM revenue forecasts to the underlying project valuation for board reporting, inve',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to exploration.resource_estimate. Business justification: Revenue forecasts in mining are built directly on resource estimates for LOM planning, investor reporting, and budget preparation. This is a fundamental business relationship - finance teams reference',
    `resource_statement_id` BIGINT COMMENT 'Foreign key linking to geology.resource_statement. Business justification: Revenue forecasts must align with published JORC/NI 43-101 resource statements for regulatory compliance and investor disclosure. Links forecast assumptions to the formal resource declaration underpin',
    `royalty_obligation_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_obligation. Business justification: Revenue forecasts must incorporate royalty obligations as deductions from gross revenue. Mining royalty rates (ad valorem, profit-based) directly affect net revenue forecasts used in LOM planning, boa',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Product-level revenue planning: mining revenue forecasts are built at the saleable product level (specific grade/form), not just commodity level. The plain product_grade field is a denormalization of ',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Revenue forecasts in mining must incorporate tenement-specific royalty rates and regulatory conditions. Board-level LOM revenue reporting requires direct tenement attribution. No existing tenement_id ',
    `tsf_capacity_survey_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf_capacity_survey. Business justification: TSF remaining airspace from capacity surveys is a primary constraint on LOM production volumes and therefore revenue forecasts. Mining finance teams explicitly reference TSF capacity surveys when buil',
    `volume_plan_id` BIGINT COMMENT 'Foreign key linking to sales.volume_plan. Business justification: Revenue forecasts in mining are derived from or aligned to sales volume plans — the volume_plan defines the planned tonnes by commodity and grade, while revenue_forecast applies pricing assumptions to',
    `approval_date` DATE COMMENT 'The date on which this forecast version was formally approved.',
    `assumed_benchmark_price` DECIMAL(18,2) COMMENT 'The assumed benchmark price per unit used in the revenue forecast (e.g., Platts Iron Ore Index, LME Copper, TSI Coal Index).',
    `assumptions_notes` STRING COMMENT 'Free-text field capturing key assumptions, market conditions, risk factors, or qualitative commentary supporting this forecast (e.g., Assumes stable Chinese steel demand, Includes impact of new mine ramp-up).',
    `board_reporting_flag` BOOLEAN COMMENT 'Indicates whether this forecast version is designated for board-level reporting and external guidance (True = board-level, False = internal planning only).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast record was first created in the system.',
    `estimated_revenue_amount` DECIMAL(18,2) COMMENT 'The total estimated revenue for the forecast period, calculated as forecast volume × assumed benchmark price × price adjustment factor.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter to which this forecast period belongs: Q1, Q2, Q3, Q4.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this forecast period belongs (e.g., 2024, 2025).',
    `forecast_confidence_level` STRING COMMENT 'The confidence level assigned to this forecast based on market conditions, contract certainty, and production reliability: high (>80% confidence), medium (50-80% confidence), low (<50% confidence).. Valid values are `high|medium|low`',
    `forecast_period_end_date` DATE COMMENT 'The end date of the forecast period (e.g., end of fiscal quarter or year).',
    `forecast_period_start_date` DATE COMMENT 'The start date of the forecast period (e.g., beginning of fiscal quarter or year).',
    `forecast_preparation_date` DATE COMMENT 'The date on which this forecast was prepared or last updated.',
    `forecast_status` STRING COMMENT 'Current approval status of the forecast: draft (in preparation), submitted (awaiting review), under_review (being evaluated), approved (approved for use), rejected (not approved), superseded (replaced by newer version).. Valid values are `draft|submitted|under_review|approved|rejected|superseded`',
    `forecast_type` STRING COMMENT 'Classification of the forecast: budget (initial annual plan), revised (mid-year update), latest_estimate (current best estimate), board_guidance (board-approved forecast), lom_aligned (aligned to Life of Mine production schedule).. Valid values are `budget|revised|latest_estimate|board_guidance|lom_aligned`',
    `forecast_version` STRING COMMENT 'Version identifier for the forecast (e.g., Q1-2024-V1, Annual-2024-V3) to track revisions and iterations.',
    `forecast_volume_tonnes` DECIMAL(18,2) COMMENT 'Forecasted sales volume in metric tonnes for the commodity in the specified period.',
    `forecast_volume_uom` STRING COMMENT 'Unit of measure for the forecast volume: tonnes (metric tonnes), dmt (dry metric tonnes), wmt (wet metric tonnes), pounds, ounces.. Valid values are `tonnes|dmt|wmt|pounds|ounces`',
    `incoterm` STRING COMMENT 'The International Commercial Terms (Incoterms) applicable to the forecast: FOB (Free on Board), CIF (Cost Insurance and Freight), CFR (Cost and Freight), EXW (Ex Works), FCA (Free Carrier), DAP (Delivered at Place), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: FOB|CIF|CFR|EXW|FCA|DAP|DDP — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast record was last modified or updated.',
    `lom_production_alignment_flag` BOOLEAN COMMENT 'Indicates whether this forecast is aligned with the approved Life of Mine (LOM) production schedule (True = aligned, False = not aligned or deviation exists).',
    `price_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to the benchmark price to reflect quality premiums, discounts, freight differentials, or contract-specific pricing terms (e.g., 0.95 for 5% discount, 1.10 for 10% premium).',
    `pricing_mechanism` STRING COMMENT 'The pricing mechanism used for this forecast: spot (spot market pricing), term_fixed (fixed price term contract), term_provisional (provisional pricing with final settlement), index_linked (linked to benchmark index), formula_based (custom pricing formula).. Valid values are `spot|term_fixed|term_provisional|index_linked|formula_based`',
    `revenue_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated revenue amount (e.g., USD for US Dollar, AUD for Australian Dollar).. Valid values are `USD|AUD|EUR|CNY|GBP|JPY`',
    `risk_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment applied to the forecast to account for identified risks (e.g., market volatility, production uncertainty, geopolitical risk). Negative values indicate downward risk adjustment.',
    `shipment_destination_region` STRING COMMENT 'The primary geographic region or market for the forecasted shipments (e.g., China, Europe, Japan, India).',
    `variance_to_prior_forecast_amount` DECIMAL(18,2) COMMENT 'The variance in revenue amount compared to the immediately prior forecast version for the same period (positive indicates increase, negative indicates decrease).',
    `variance_to_prior_forecast_percentage` DECIMAL(18,2) COMMENT 'The percentage variance in revenue compared to the immediately prior forecast version for the same period.',
    CONSTRAINT pk_revenue_forecast PRIMARY KEY(`revenue_forecast_id`)
) COMMENT 'Forward-looking revenue forecast for commodity sales aligned to Life of Mine (LOM) production schedules and annual sales volume plans. Captures forecast period, commodity, forecast volume, assumed benchmark price, estimated revenue, currency, forecast version, approval status, and variance to prior forecast. Supports CFO reporting, commercial planning, and board-level guidance against LOM production targets. One record per commodity per forecast period per version.';

CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`volume_plan` (
    `volume_plan_id` BIGINT COMMENT 'Primary key for volume_plan',
    `block_model_id` BIGINT COMMENT 'Foreign key linking to geology.block_model. Business justification: Volume plans derive planned_volume_tonnes and product_grade directly from block model grade-tonnage curves. Sales planners use the block model to validate that planned sales volumes are achievable giv',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Commodity-level volume planning: mining volume plans are organized by commodity for market analysis, royalty calculations, and export reporting. The plain commodity_type field is a denormalization of ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Sales volume plans are prepared by cost centre to align production capacity with sales commitments. Essential for mine-level P&L forecasting, production planning, and cost recovery analysis.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Volume plans are prepared at legal entity level for statutory reporting, transfer pricing, and intercompany sales planning. Mining groups with multiple operating entities require volume plans attribut',
    `lom_plan_id` BIGINT COMMENT 'Foreign key linking to mine.lom_plan. Business justification: Sales volume plans must align with LOM production capacity and reserve depletion schedules. Commercial teams plan annual sales volumes within mine production constraints to ensure contracted volumes a',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Volume plans are prepared per mine site — each site has distinct ore characteristics, port logistics, and customer allocations. Site-level sales planning and capacity allocation reporting require this',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.offtake_agreement. Business justification: A volume plan is typically constructed with reference to existing offtake agreements — the offtake_coverage_percentage attribute on volume_plan implies that some planned volumes are covered by agreeme',
    `ore_reserve_id` BIGINT COMMENT 'Foreign key linking to exploration.ore_reserve. Business justification: Sales volume planning must align with declared ore reserves and mine life plans. The volume_plan already has lom_production_forecast_alignment flag, and linking to the specific reserve estimate ensure',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Sales volume plans are developed per orebody to align with mine production schedules and geological resource availability. Essential for matching sales commitments to specific ore sources, particularl',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to sales.price_index. Business justification: volume_plan has benchmark_index (STRING) which is a code reference to the price_index master. Adding price_index_id FK allows proper normalization and resolves the silo issue. The benchmark_index stri',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Sales volume plans are constrained by the mines production schedule — planned sales volumes cannot exceed scheduled ore production. Sales planning teams use production_schedule as the primary input w',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Volume plans drive profit centre revenue targets and are required for segment reporting, management performance evaluation, and commodity-level strategic planning. Links sales planning to financial re',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to exploration.resource_estimate. Business justification: Long-term sales volume planning in mining uses resource estimates (not just declared ore reserves) to project future saleable volumes for periods beyond current reserve life. This underpins LOM sales ',
    `resource_statement_id` BIGINT COMMENT 'Foreign key linking to geology.resource_statement. Business justification: Volume plans must be constrained by published resource statements to ensure sales commitments do not exceed declared resources. Critical governance control for preventing over-commitment and ensuring ',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Sales volume planning by product: mining volume plans are constructed per saleable product to align production scheduling with market commitments. product_grade and product_specification_code are deno',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Quality-based volume planning: mining volume plans target specific product specifications to ensure planned volumes meet customer contractual quality requirements. Sales planners reference the specifi',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Sales volume plans must align with tenement production capacity, ore reserve estimates, and regulatory extraction limits. Quarterly sales planning requires tenement-level capacity constraints to ensur',
    `approval_date` DATE COMMENT 'Date when the volume plan was formally approved by commercial leadership.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or manager who approved the volume plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this volume plan record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for planned pricing (e.g., USD, AUD, EUR).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Type of customer or end-user segment targeted by this volume plan.. Valid values are `STEEL_MILL|TRADER|SMELTER|MANUFACTURER|UTILITY`',
    `delivery_basis` STRING COMMENT 'Incoterms delivery basis defining responsibility transfer point. FOB (Free on Board) and CIF (Cost Insurance and Freight) are most common in mining commodity sales.. Valid values are `FOB|CIF|CFR|EXW|DDP`',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary destination market.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this volume plan record was last updated.',
    `logistics_mode` STRING COMMENT 'Primary transportation mode planned for commodity delivery to market.. Valid values are `VESSEL|RAIL|TRUCK|PIPELINE|BARGE`',
    `lom_production_forecast_alignment` STRING COMMENT 'Indicates whether this volume plan is aligned with the Life of Mine production forecast. Critical for ensuring offtake agreements match production capacity.. Valid values are `ALIGNED|PARTIAL|NOT_ALIGNED`',
    `notes` STRING COMMENT 'Free-text field for additional context, assumptions, or constraints related to the volume plan.',
    `offtake_coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of planned volume already covered by executed offtake agreements. Used to track commercial risk and contract coverage.',
    `plan_code` STRING COMMENT 'Business identifier for the volume plan, used for external reference and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `plan_effective_date` DATE COMMENT 'Date from which this volume plan becomes effective and is used for commercial baseline.',
    `plan_expiry_date` DATE COMMENT 'Date when this volume plan ceases to be effective. Typically end of quarter or year.',
    `plan_name` STRING COMMENT 'Descriptive name of the sales volume plan for business user identification.',
    `plan_quarter` STRING COMMENT 'Fiscal quarter for which this volume plan applies. ANNUAL indicates a full-year plan.. Valid values are `Q1|Q2|Q3|Q4|ANNUAL`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the volume plan. ACTIVE indicates the plan is in effect for the period.. Valid values are `DRAFT|APPROVED|ACTIVE|REVISED|SUPERSEDED`',
    `plan_year` STRING COMMENT 'Calendar year for which this volume plan applies.',
    `planned_price_per_tonne` DECIMAL(18,2) COMMENT 'Target or assumed price per metric tonne used for revenue planning. Confidential commercial information.',
    `planned_volume_tonnes` DECIMAL(18,2) COMMENT 'Target sales volume in metric tonnes for the plan period. Core commercial baseline for offtake coverage.',
    `port_of_loading` STRING COMMENT 'Name of the port or terminal from which the commodity will be shipped for FOB/CIF deliveries.',
    `pricing_mechanism` STRING COMMENT 'Method by which the commodity price is determined. SPOT for immediate market price, TERM_FIXED for locked-in price, TERM_INDEX for benchmark-linked pricing (e.g., Platts, TSI).. Valid values are `SPOT|TERM_FIXED|TERM_INDEX|PROVISIONAL`',
    `revenue_forecast_amount` DECIMAL(18,2) COMMENT 'Projected revenue for the plan period calculated from planned volume and price. Used for financial planning and budgeting.',
    `risk_category` STRING COMMENT 'Commercial risk assessment for achieving the planned volume and pricing targets.. Valid values are `LOW|MEDIUM|HIGH|CRITICAL`',
    `shipment_nomination_window` STRING COMMENT 'Time period or month range during which shipments are planned to occur (e.g., Jan-Mar 2024, Q2 2024).',
    `target_market` STRING COMMENT 'Geographic market or region where the commodity is planned to be sold (e.g., China, Europe, Domestic).',
    `variance_tolerance_percentage` DECIMAL(18,2) COMMENT 'Acceptable percentage variance from planned volume before triggering plan revision or escalation.',
    `version_number` STRING COMMENT 'Version number of the volume plan. Incremented when plan is revised or updated.',
    CONSTRAINT pk_volume_plan PRIMARY KEY(`volume_plan_id`)
) COMMENT 'Annual and quarterly sales volume plan by commodity, product grade, and market destination. Captures planned volumes, target markets, delivery basis (FOB/CIF), planned pricing mechanism, and alignment to LOM production forecast. Serves as the commercial baseline for offtake agreement coverage and revenue planning.';

CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`cargo_shipment` (
    `cargo_shipment_id` BIGINT COMMENT 'Unique identifier for the cargo shipment record. Primary key. Role: TRANSACTION_HEADER.',
    `commodity_order_id` BIGINT COMMENT 'Foreign key linking to sales.commodity_order. Business justification: cargo_shipment has sales_contract_number (STRING) which represents the link to the originating commodity_order. Adding commodity_order_id FK establishes proper parent-child relationship between order ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Shipments are allocated to cost centres for revenue recognition timing and mine-level sales volume tracking. Essential for production-sales reconciliation and financial reporting.',
    `counterparty_id` BIGINT COMMENT 'Reference to the customer or counterparty who is the consignee or buyer of this cargo shipment.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to procurement.freight_order. Business justification: Freight cost allocation against sales revenue, demurrage reconciliation, and shipping cost reporting require linking the commercial cargo shipment to the freight order that arranged the transport. Min',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Cargo shipments are executed under a specific legal entity for customs export declarations, revenue recognition timing, and intercompany transfer pricing. Mining groups shipping between related entiti',
    `letter_of_credit_id` BIGINT COMMENT 'Foreign key linking to customer.letter_of_credit. Business justification: Documentary credit compliance verification requires linking shipments to structured LC records with issuing bank details, expiry dates, and document requirements. Trade finance settlement and shipping',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Cargo shipments originate from a specific mine site. Site-level shipment reporting, port allocation, demurrage tracking, and regulatory export documentation all require the originating mine site refer',
    `rom_stockpile_id` BIGINT COMMENT 'Foreign key linking to mine.rom_stockpile. Business justification: Cargo shipments are loaded from specific ROM stockpiles. Logistics tracks which stockpile supplied each vessel for inventory reconciliation, grade traceability, and stockpile depletion tracking. Essen',
    `royalty_agreement_id` BIGINT COMMENT 'Foreign key linking to tenement.royalty_agreement. Business justification: Each cargo shipment is subject to a specific royalty agreement governing the tenement from which the ore was extracted. Royalty calculation on shipment dispatch requires knowing which royalty agreemen',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Shipments transport specific saleable products with defined quality parameters. Required for bill of lading accuracy, quality certificate linkage, customs HS code determination, IMSBC classification c',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Shipment quality compliance: cargo shipments in mining must be loaded to a contractual specification. Operations teams reference the specification to validate moisture_content_percent and net_dry_weig',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to sales.vessel. Business justification: Cargo shipment must reference the vessel used for transport. Currently has vessel_name and vessel_imo_number as strings, but vessel is a master reference table. Adding vessel_id FK enables proper refe',
    `bill_of_lading_number` STRING COMMENT 'Unique bill of lading number issued by the carrier. Legal document of title and receipt of goods. Externally-known business identifier for this shipment.. Valid values are `^[A-Z0-9]{8,20}$`',
    `bl_issue_date` DATE COMMENT 'Date on which the bill of lading was issued by the carrier. Principal business event timestamp for legal title transfer.',
    `carrier_name` STRING COMMENT 'Name of the shipping line or carrier responsible for transporting the cargo.',
    `consignee_name` STRING COMMENT 'Legal name of the consignee (importer or buyer) as stated on the bill of lading.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cargo shipment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction (e.g., USD, AUD, EUR).. Valid values are `^[A-Z]{3}$`',
    `demurrage_amount_usd` DECIMAL(18,2) COMMENT 'Demurrage charges incurred when laytime used exceeds laytime allowed, expressed in United States Dollars.',
    `despatch_amount_usd` DECIMAL(18,2) COMMENT 'Despatch money earned when laytime used is less than laytime allowed, expressed in United States Dollars.',
    `discharge_commenced_timestamp` TIMESTAMP COMMENT 'Date and time when cargo discharge operations commenced at the port of discharge.',
    `discharge_completed_timestamp` TIMESTAMP COMMENT 'Date and time when cargo discharge operations were completed at the port of discharge.',
    `documentary_credit_compliant_flag` BOOLEAN COMMENT 'Indicates whether the shipment documentation complies with the terms and conditions of the letter of credit. True if compliant, False if discrepancies exist.',
    `insurance_cost_usd` DECIMAL(18,2) COMMENT 'Total insurance cost for this shipment in United States Dollars. Applicable when insurance is borne by the seller under CIF terms.',
    `invoice_value_usd` DECIMAL(18,2) COMMENT 'Total invoiced value of the cargo shipment in United States Dollars, used for revenue recognition and customs declaration.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cargo shipment record was last modified in the system.',
    `laytime_allowed_hours` DECIMAL(18,2) COMMENT 'Total laytime (loading and discharge time) allowed under the charter party or sales contract, expressed in hours.',
    `laytime_used_hours` DECIMAL(18,2) COMMENT 'Actual laytime used for loading and discharge operations, expressed in hours.',
    `loading_commenced_timestamp` TIMESTAMP COMMENT 'Date and time when cargo loading operations commenced at the port of loading.',
    `loading_completed_timestamp` TIMESTAMP COMMENT 'Date and time when cargo loading operations were completed at the port of loading.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Percentage of moisture content in the shipped cargo, used to calculate dry weight from wet weight.',
    `net_dry_weight_dmt` DECIMAL(18,2) COMMENT 'Net weight of cargo after adjusting for moisture content, expressed in dry metric tonnes. Used for invoicing and revenue recognition.',
    `notify_party_name` STRING COMMENT 'Name of the party to be notified upon arrival of the cargo at the discharge port, as stated on the bill of lading.',
    `port_of_discharge_code` STRING COMMENT 'Five-letter UN/LOCODE for the port where cargo discharge occurred or is planned.. Valid values are `^[A-Z]{5}$`',
    `port_of_loading_code` STRING COMMENT 'Five-letter UN/LOCODE for the port where cargo loading occurred.. Valid values are `^[A-Z]{5}$`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special instructions, or comments related to the cargo shipment.',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the cargo shipment in the logistics workflow. [ENUM-REF-CANDIDATE: planned|nominated|loading|loaded|in_transit|discharged|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `shipped_quantity_wmt` DECIMAL(18,2) COMMENT 'Total gross weight of cargo shipped in wet metric tonnes, including moisture content.',
    `shipper_name` STRING COMMENT 'Legal name of the shipper (exporter) as stated on the bill of lading.',
    `terminal_name` STRING COMMENT 'Name of the terminal or berth at the port of loading where the cargo was loaded.',
    CONSTRAINT pk_cargo_shipment PRIMARY KEY(`cargo_shipment_id`)
) COMMENT 'Operational record of an actual commodity cargo shipment from port of loading to port of discharge, serving as the SSOT for physical logistics execution, legal title transfer (bill of lading), and documentary credit presentation. Captures vessel name, BL number, BL issue date, shipper, consignee, notify party, loading/discharge dates, shipped quantity, moisture-adjusted dry weight, commodity grade, freight terms (FOB/CIF), port/terminal/berth allocation, shipment status, carrier details, gross weight, net dry weight, moisture content, and documentary credit compliance fields. The bill of lading is modelled as an integral component of this record — BL attributes (legal title document, carrier acknowledgment) are first-class fields within cargo_shipment, not a separate entity.';

CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`bill_of_lading` (
    `bill_of_lading_id` BIGINT COMMENT 'Unique identifier for the bill of lading record. Primary key for the bill of lading entity.',
    `cargo_shipment_id` BIGINT COMMENT 'Reference to the parent shipment record that this bill of lading documents.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Bills of lading trigger revenue recognition events allocated to cost centres for mine-level sales tracking. Essential for revenue recognition timing and production-sales reconciliation.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Bills of lading are issued by a specific legal entity as the exporter/shipper. Required for customs compliance, export documentation, revenue recognition under IFRS 15 (transfer of control), and inter',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Bills of lading reference the originating mine site as place of receipt and loading. Export regulatory compliance, trade finance documentation, and site-level shipment audit trails require traceabilit',
    `counterparty_id` BIGINT COMMENT 'Reference to the shipper party (typically the mining company or seller) consigning the cargo.',
    `offtake_agreement_id` BIGINT COMMENT 'Reference to the underlying sales contract or offtake agreement that governs this shipment.',
    `shipment_nomination_id` BIGINT COMMENT 'Foreign key linking to sales.shipment_nomination. Business justification: A bill of lading is issued for a specific cargo shipment that was formally nominated via a shipment nomination. The BL documents the cargo accepted for shipment under the nominated vessel and laycan. ',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.product_specification. Business justification: Bills of lading reference the contractual product specification being shipped. Required for customs clearance, quality dispute resolution, contractual compliance verification, and ensuring shipping do',
    `vessel_id` BIGINT COMMENT 'Reference to the vessel transporting the commodity cargo.',
    `bl_number` STRING COMMENT 'Externally-known unique bill of lading number issued by the carrier. Legal document identifier used for title transfer and documentary credit in commodity trade.. Valid values are `^[A-Z0-9]{8,20}$`',
    `bl_status` STRING COMMENT 'Current lifecycle status of the bill of lading document.. Valid values are `draft|issued|surrendered|amended|cancelled`',
    `bl_type` STRING COMMENT 'Classification of the bill of lading document type indicating its legal status and usage.. Valid values are `original|copy|seaway|express|charter_party`',
    `carrier_name` STRING COMMENT 'Legal name of the shipping carrier or freight company issuing the bill of lading.',
    `commodity_description` STRING COMMENT 'Detailed description of the commodity cargo being shipped including mineral type, grade, and specifications as stated on the bill of lading.',
    `consignee_address` STRING COMMENT 'Full address of the consignee party including street, city, state, and country.',
    `consignee_name` STRING COMMENT 'Legal name of the consignee party as stated on the bill of lading.',
    `container_numbers` STRING COMMENT 'Comma-separated list of container identification numbers if cargo is shipped in containers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bill of lading record was first created in the system.',
    `freight_terms` STRING COMMENT 'Indicates whether freight charges are prepaid by the shipper or collected from the consignee.. Valid values are `prepaid|collect`',
    `gross_weight_mt` DECIMAL(18,2) COMMENT 'Total weight of the commodity cargo including moisture and packaging, measured in metric tonnes.',
    `hs_code` STRING COMMENT 'International standardized system of names and numbers to classify traded products for customs and tariff purposes.. Valid values are `^[0-9]{6,10}$`',
    `incoterm` STRING COMMENT 'Standard trade terms defining the responsibilities of buyers and sellers for the delivery of goods. Common terms in mining include Free on Board (FOB) and Cost Insurance and Freight (CIF). [ENUM-REF-CANDIDATE: FOB|CIF|CFR|FAS|EXW|DDP|DAP — 7 candidates stripped; promote to reference product]',
    `is_negotiable` BOOLEAN COMMENT 'Indicates whether the bill of lading is negotiable (transferable title document) or non-negotiable (straight consignment).',
    `issue_date` DATE COMMENT 'Date when the bill of lading was issued by the carrier. Critical for documentary credit and title transfer timing.',
    `marks_and_numbers` STRING COMMENT 'Identifying marks, numbers, or labels on the packages or containers for cargo identification and tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bill of lading record was last modified in the system.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Percentage of moisture content in the commodity cargo as determined by laboratory assay. Used to calculate net dry weight for pricing.',
    `net_dry_weight_mt` DECIMAL(18,2) COMMENT 'Weight of the commodity cargo on a dry basis excluding all moisture content, measured in metric tonnes. Critical for pricing and settlement in commodity trade.',
    `net_weight_mt` DECIMAL(18,2) COMMENT 'Weight of the commodity cargo excluding packaging and moisture, measured in metric tonnes.',
    `notify_party_address` STRING COMMENT 'Full address of the notify party including contact details.',
    `notify_party_name` STRING COMMENT 'Name of the party to be notified upon arrival of the cargo at the destination port.',
    `number_of_originals` STRING COMMENT 'Total number of original bill of lading documents issued. Typically 3 originals are issued in international trade.',
    `number_of_packages` STRING COMMENT 'Total count of packages, containers, or units comprising the shipment.',
    `on_board_date` DATE COMMENT 'Date when the cargo was loaded on board the vessel. May differ from issue date for received-for-shipment bills of lading.',
    `package_type` STRING COMMENT 'Type of packaging or container used for the commodity cargo.. Valid values are `bulk|container|bag|pallet|drum`',
    `place_of_delivery` STRING COMMENT 'Final destination where the cargo will be delivered to the consignee, which may differ from the port of discharge for multimodal transport.',
    `place_of_receipt` STRING COMMENT 'Location where the carrier received the cargo from the shipper, which may differ from the port of loading for multimodal transport.',
    `port_of_discharge_code` STRING COMMENT 'United Nations Code for Trade and Transport Locations (UN/LOCODE) for the port where cargo is unloaded from the vessel.. Valid values are `^[A-Z]{5}$`',
    `port_of_discharge_name` STRING COMMENT 'Full name of the port where the commodity cargo is unloaded from the vessel.',
    `port_of_loading_code` STRING COMMENT 'United Nations Code for Trade and Transport Locations (UN/LOCODE) for the port where cargo is loaded onto the vessel.. Valid values are `^[A-Z]{5}$`',
    `port_of_loading_name` STRING COMMENT 'Full name of the port where the commodity cargo is loaded onto the vessel.',
    `shipper_address` STRING COMMENT 'Full address of the shipper party including street, city, state, and country.',
    `shipper_name` STRING COMMENT 'Legal name of the shipper party as stated on the bill of lading.',
    `special_instructions` STRING COMMENT 'Additional handling instructions, clauses, or remarks specific to this shipment as noted on the bill of lading.',
    `voyage_number` STRING COMMENT 'Voyage or trip number assigned by the carrier for this specific journey.',
    CONSTRAINT pk_bill_of_lading PRIMARY KEY(`bill_of_lading_id`)
) COMMENT 'Legal shipping document issued by the carrier confirming receipt of commodity cargo for shipment. Captures BL number, vessel, shipper, consignee, port of loading, port of discharge, commodity description, gross weight, net dry weight, moisture content, and date of issue. SSOT for title transfer and documentary credit in commodity trade.';

CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`quality_certificate` (
    `quality_certificate_id` BIGINT COMMENT 'Primary key for quality_certificate',
    `assay_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.assay_result. Business justification: Quality certificates issued for cargo shipments are directly derived from specific assay results. Mining CoA documents must reference the lab measurement underpinning reported grades (Fe, SiO2, moistu',
    `cargo_shipment_id` BIGINT COMMENT 'Foreign key linking to sales.cargo_shipment. Business justification: quality_certificate has cargo_reference and bill_of_lading_number (both STRING) which identify the shipment being certified. Adding cargo_shipment_id FK establishes proper relationship between certifi',
    `counterparty_id` BIGINT COMMENT 'Identifier of the customer or counterparty receiving this quality certificate.',
    `laboratory_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory_sample. Business justification: Sales quality certificates are based on laboratory assay results for the shipped cargo. This FK links the commercial quality certificate to the underlying LIMS sample record, enabling traceability fro',
    `production_reconciliation_id` BIGINT COMMENT 'Foreign key linking to mine.production_reconciliation. Business justification: Quality certificates must be traceable to the production reconciliation record confirming ore grade and quality. Metallurgists and quality managers reconcile shipment assay results against mine produc',
    `rom_stockpile_id` BIGINT COMMENT 'Foreign key linking to mine.rom_stockpile. Business justification: Quality certificates are issued for material drawn from a specific ROM stockpile. Stockpile grade characteristics and inventory records are the basis for the certificate. Quality traceability and stoc',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.product_specification. Business justification: Quality certificates verify cargo compliance against contractual product specifications. Critical for contractual compliance verification, penalty/bonus calculation, customer acceptance, dispute resol',
    `alumina_content_percent` DECIMAL(18,2) COMMENT 'Percentage of alumina content in the ore sample. Penalty element for iron ore quality.',
    `analysis_date` DATE COMMENT 'Date when the laboratory analysis was completed and results finalized.',
    `benchmark_index_reference` STRING COMMENT 'Reference to the pricing benchmark index used for settlement (e.g., Platts IODEX 62% Fe, TSI 62% Fe CFR China).',
    `certificate_number` STRING COMMENT 'Externally-known unique certificate number issued by the laboratory or inspection body for this cargo shipment.. Valid values are `^[A-Z0-9]{6,20}$`',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the quality certificate in the commercial workflow.. Valid values are `draft|issued|revised|disputed|accepted|rejected`',
    `certificate_type` STRING COMMENT 'Type of quality certificate issued for the shipment (e.g., certificate of analysis, inspection certificate, weight certificate).. Valid values are `certificate_of_analysis|inspection_certificate|weight_certificate|moisture_certificate|combined_certificate`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality certificate record was first created in the system.',
    `discharge_port` STRING COMMENT 'Destination port where the cargo will be or was discharged.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the quality certificate results are under dispute by the counterparty.',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute if the certificate is contested by the counterparty.',
    `effective_date` DATE COMMENT 'Date from which the certificate is valid and binding for commercial settlement purposes.',
    `expiry_date` DATE COMMENT 'Date after which the certificate is no longer valid for commercial purposes. Nullable for certificates without expiry.',
    `iron_content_percent` DECIMAL(18,2) COMMENT 'Percentage of iron content in the ore sample. Key quality parameter for iron ore shipments.',
    `issue_date` DATE COMMENT 'Date when the quality certificate was officially issued by the laboratory or inspection body.',
    `issuing_laboratory_name` STRING COMMENT 'Name of the accredited laboratory or inspection body that issued the quality certificate.',
    `laboratory_accreditation_number` STRING COMMENT 'Accreditation number of the issuing laboratory under ISO/IEC 17025 or equivalent standard.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality certificate record was last updated in the system.',
    `loading_port` STRING COMMENT 'Port where the cargo was loaded onto the vessel.',
    `loss_on_ignition_percent` DECIMAL(18,2) COMMENT 'Percentage of weight loss when the sample is heated to high temperature. Indicates volatile content and combined water.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Percentage of moisture content in the ore sample. Affects payable weight and pricing.',
    `penalty_deduction_amount` DECIMAL(18,2) COMMENT 'Total monetary penalty deduction applied to the invoice based on quality parameters exceeding contractual limits (e.g., high silica, high alumina).',
    `penalty_deduction_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty deduction amount.. Valid values are `^[A-Z]{3}$`',
    `phosphorus_content_percent` DECIMAL(18,2) COMMENT 'Percentage of phosphorus content in the ore sample. Penalty element affecting steel quality.',
    `price_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to the base price based on quality results. Values above 1.0 indicate premium, below 1.0 indicate discount.',
    `remarks` STRING COMMENT 'Additional remarks, notes, or qualifications provided by the laboratory or inspection body regarding the analysis or certificate.',
    `sales_contract_number` STRING COMMENT 'Reference to the underlying sales contract or offtake agreement governing this shipment.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `sample_collection_date` DATE COMMENT 'Date when the physical samples were collected from the cargo for laboratory analysis.',
    `sampling_method` STRING COMMENT 'Method used to collect samples for analysis (e.g., mechanical sampling, manual sampling, composite sampling).',
    `shipment_quantity_tonnes` DECIMAL(18,2) COMMENT 'Total quantity of commodity in the shipment covered by this certificate, measured in metric tonnes.',
    `silica_content_percent` DECIMAL(18,2) COMMENT 'Percentage of silica content in the ore sample. Penalty element for iron ore quality.',
    `size_fraction_minus_6_3mm_percent` DECIMAL(18,2) COMMENT 'Percentage of material passing through 6.3mm screen. Part of size distribution specification for fines content.',
    `size_fraction_plus_31_5mm_percent` DECIMAL(18,2) COMMENT 'Percentage of material retained on 31.5mm screen. Part of size distribution specification for lump ore.',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'Percentage of sulfur content in the ore sample. Penalty element affecting steel quality.',
    `vessel_name` STRING COMMENT 'Name of the vessel carrying the cargo shipment for which this certificate was issued.',
    CONSTRAINT pk_quality_certificate PRIMARY KEY(`quality_certificate_id`)
) COMMENT 'Certificate of analysis issued for a commodity cargo shipment confirming the chemical and physical quality specifications (grade, moisture, size distribution, penalty elements). Captures certificate number, cargo reference, assay results, moisture content, size fractions, penalty deductions, and issuing laboratory. Drives final invoice price adjustments.';

CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`offtake_schedule` (
    `offtake_schedule_id` BIGINT COMMENT 'Unique identifier for the offtake schedule record. Primary key.',
    `cargo_shipment_id` BIGINT COMMENT 'Foreign key linking to sales.cargo_shipment. Business justification: Offtake schedule represents the planned delivery schedule; cargo_shipment is the actual executed shipment. Adding cargo_shipment_id links the schedule line to its fulfillment shipment, enabling schedu',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Offtake schedules detail lifting plans by cost centre for production-sales alignment and revenue timing. Essential for mine-level operational and financial planning.',
    `counterparty_id` BIGINT COMMENT 'Reference to the buyer counterparty for this scheduled lifting.',
    `delivery_destination_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_destination. Business justification: Offtake schedules allocate volumes to specific ports by period. Linking to delivery_destination normalizes destination_port (plain text) and enables schedule-level port capacity planning and lifting',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Offtake schedules are site-specific — each lifting schedule is tied to a mine sites port, stockpile, and logistics infrastructure. Port allocation and vessel scheduling are managed at site level. No ',
    `offtake_agreement_id` BIGINT COMMENT 'Reference to the parent term offtake agreement from which this schedule is derived.',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to sales.price_index. Business justification: offtake_schedule currently stores benchmark_index as a free-text STRING, which is an unstructured reference to a price index. Normalising this to a FK to price_index.price_index_id ensures referential',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Offtake lifting schedules must be aligned with the mines production schedule — scheduled lifting dates and volumes are constrained by ore availability. Sales scheduling teams validate nominations aga',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Offtake schedules require profit centre attribution for management reporting of scheduled revenue by business segment. Mining companies report scheduled liftings by profit centre for monthly revenue f',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Offtake schedules specify which product grade is being lifted in each period. Required for production planning alignment, stockpile allocation, blending strategy, vessel nomination accuracy, and ensur',
    `shipment_nomination_id` BIGINT COMMENT 'Reference to the shipment nomination record associated with this scheduled lifting, if nominated.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Offtake schedules drive revenue recognition timing and are tracked against WBS elements in mining project accounting for LOM plan alignment and project-level revenue reporting. Required for project fi',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this offtake schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the scheduled price and revenue amounts.',
    `delivery_basis` STRING COMMENT 'Incoterms delivery basis defining the transfer of risk and cost responsibility for this scheduled shipment. FOB (Free on Board), CIF (Cost Insurance and Freight), CFR (Cost and Freight), DAP (Delivered at Place), DDP (Delivered Duty Paid), EXW (Ex Works).. Valid values are `FOB|CIF|CFR|DAP|DDP|EXW`',
    `delivery_window_end_date` DATE COMMENT 'End date of the delivery window during which the cargo lifting must occur.',
    `delivery_window_start_date` DATE COMMENT 'Start date of the delivery window during which the cargo lifting must occur.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code of the destination country for this scheduled delivery.',
    `fulfillment_status` STRING COMMENT 'Status indicating whether the scheduled lifting is being fulfilled according to plan, tracking shortfall or excess against contracted volumes. [ENUM-REF-CANDIDATE: not_started|on_track|at_risk|delayed|fulfilled|shortfall|excess — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this offtake schedule record was last updated.',
    `lifting_number` STRING COMMENT 'Sequential number of the cargo lifting within the schedule period.',
    `lom_alignment_flag` BOOLEAN COMMENT 'Indicates whether this scheduled lifting is aligned with the Life of Mine production forecast.',
    `nominated_vessel_name` STRING COMMENT 'Name of the vessel nominated by the buyer for this cargo lifting.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, exceptions, or special instructions for this scheduled lifting.',
    `port_allocation_code` STRING COMMENT 'Code representing the specific port berth or allocation slot assigned for this lifting.',
    `port_of_loading` STRING COMMENT 'Port facility from which the commodity is scheduled to be loaded for shipment.',
    `pricing_mechanism` STRING COMMENT 'Pricing method applied to this scheduled lifting as per the offtake agreement terms.. Valid values are `fixed|index_linked|provisional|spot`',
    `schedule_code` STRING COMMENT 'Business identifier for the offtake schedule, typically combining agreement code and period identifier.',
    `schedule_month` STRING COMMENT 'Calendar month (1-12) to which this offtake schedule applies, if applicable.',
    `schedule_period_type` STRING COMMENT 'Frequency of scheduled deliveries under this offtake schedule.. Valid values are `monthly|quarterly|semi-annual|annual`',
    `schedule_quarter` STRING COMMENT 'Calendar quarter (1-4) to which this offtake schedule applies, if applicable.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of this offtake schedule lifting.. Valid values are `planned|confirmed|in_progress|completed|cancelled|deferred`',
    `schedule_year` STRING COMMENT 'Calendar year to which this offtake schedule applies.',
    `scheduled_lifting_date` DATE COMMENT 'Target date for the cargo lifting within the delivery window.',
    `scheduled_price_per_tonne` DECIMAL(18,2) COMMENT 'Planned or estimated price per tonne for this scheduled lifting at the time of schedule creation.',
    `scheduled_revenue_amount` DECIMAL(18,2) COMMENT 'Planned revenue amount for this scheduled lifting, calculated as scheduled volume multiplied by scheduled price.',
    `scheduled_volume_tonnes` DECIMAL(18,2) COMMENT 'Planned volume of commodity to be delivered in this lifting, measured in metric tonnes.',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'Allowable variance percentage for the scheduled volume as per the offtake agreement terms.',
    `vessel_nomination_deadline` DATE COMMENT 'Deadline by which the buyer must nominate the vessel for this cargo lifting.',
    `volume_variance_tonnes` DECIMAL(18,2) COMMENT 'Difference between scheduled and actual volume (actual minus scheduled), measured in metric tonnes.',
    CONSTRAINT pk_offtake_schedule PRIMARY KEY(`offtake_schedule_id`)
) COMMENT 'Periodic delivery schedule derived from a term offtake agreement, specifying the planned cargo liftings by period (monthly/quarterly), volume per lifting, delivery window, and port allocation. Tracks scheduled vs actual liftings and identifies shortfall or excess against contracted volumes.';

CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`price_index` (
    `price_index_id` BIGINT COMMENT 'Primary key for price_index',
    `adjustment_factor_applicable` BOOLEAN COMMENT 'Indicates whether quality or specification adjustments are typically applied when using this index in pricing formulas (e.g., Fe content adjustments, moisture adjustments, impurity penalties).',
    `alternative_index_code` STRING COMMENT 'Reference to an alternative or successor index code that should be used if this index is deprecated or unavailable. Supports continuity planning for pricing formulas.',
    `commodity_grade` STRING COMMENT 'The specific grade or quality specification tracked by this index (e.g., 62% Fe, Premium Hard Coking Coal, Grade A Copper Cathode, Battery Grade Lithium Carbonate).',
    `commodity_type` STRING COMMENT 'The mineral commodity that this index tracks (e.g., Iron Ore, Copper, Coal, Lithium, Nickel). [ENUM-REF-CANDIDATE: Iron Ore|Copper|Coal|Lithium|Nickel|Gold|Silver|Zinc|Lead|Aluminium|Other — 11 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this price index record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the index is denominated (e.g., USD, EUR, AUD, CNY).. Valid values are `^[A-Z]{3}$`',
    `data_source_url` STRING COMMENT 'Web URL or reference link to the publishing agencys official page for this index, used for data validation and audit purposes.',
    `delivery_basis` STRING COMMENT 'The Incoterm delivery basis for the index pricing (e.g., CFR - Cost Insurance and Freight, FOB - Free on Board). Defines where price risk and title transfer occur. [ENUM-REF-CANDIDATE: CFR|FOB|CIF|EXW|FCA|DAP|DDP|Other — 8 candidates stripped; promote to reference product]',
    `delivery_location` STRING COMMENT 'The geographic location or port associated with the delivery basis (e.g., CFR China, FOB Australia, CIF Rotterdam). Used to specify the pricing point.',
    `discontinuation_date` DATE COMMENT 'The date on which this index was discontinued or deprecated by the publishing agency. Null if the index is still active.',
    `effective_date` DATE COMMENT 'The date from which this index definition became effective and available for use in pricing formulas and offtake agreements.',
    `index_category` STRING COMMENT 'The type or category of price index (e.g., Spot market index, Forward curve, Futures settlement, Benchmark reference).. Valid values are `Spot|Forward|Futures|Benchmark|Derivative|Other`',
    `index_code` STRING COMMENT 'Unique business identifier code for the price index (e.g., PLATTS_62FE, TSI_COKING, LME_COPPER_CASH). Used in pricing formulas and offtake agreements.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `index_family` STRING COMMENT 'Grouping or family name for related indices from the same publisher (e.g., Platts IODEX Family, TSI Coking Coal Suite, LME Base Metals). Used for hierarchical organization and reporting.',
    `index_methodology_description` STRING COMMENT 'Brief description of how the index is calculated or derived by the publishing agency (e.g., volume-weighted average of spot transactions, survey-based assessment, exchange settlement price).',
    `index_name` STRING COMMENT 'Full descriptive name of the price index (e.g., Platts IODEX 62% Fe CFR China, TSI Premium Hard Coking Coal FOB Australia).',
    `index_status` STRING COMMENT 'Current lifecycle status of the price index. Active indices are currently used in pricing formulas; Inactive or Deprecated indices are retained for historical reference only.. Valid values are `Active|Inactive|Deprecated|Suspended|Under Review`',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this price index record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this price index record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or business notes related to this price index (e.g., usage guidelines, known limitations, historical context).',
    `publication_frequency` STRING COMMENT 'How often the index is published or updated by the publishing agency (e.g., Daily, Weekly, Monthly, Real-time).. Valid values are `Daily|Weekly|Monthly|Quarterly|Real-time|Other`',
    `publishing_agency` STRING COMMENT 'The organization that publishes and maintains this price index (e.g., Platts, TSI - The Steel Index, LME - London Metal Exchange, Fastmarkets). [ENUM-REF-CANDIDATE: Platts|TSI|LME|Fastmarkets|Metal Bulletin|Argus|Bloomberg|CME|ICE|Other — 10 candidates stripped; promote to reference product]',
    `quotational_period_convention` STRING COMMENT 'The standard time window convention used for price averaging in contracts referencing this index (e.g., M+1 month average, M+2 month average, spot month, quarterly average). QP = Quotational Period defines the averaging window for provisional and final pricing.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this index is recognized or approved for use in regulatory reporting or compliance contexts (e.g., SEC S-K 1300 disclosure, IFRS fair value measurement).',
    `unit_of_measure` STRING COMMENT 'The unit in which the index price is quoted (e.g., USD per Dry Metric Tonne, USD per Wet Metric Tonne, USD per pound, USD per kilogram). DMT = Dry Metric Tonne, WMT = Wet Metric Tonne. [ENUM-REF-CANDIDATE: USD/DMT|USD/WMT|USD/tonne|USD/lb|USD/kg|USD/oz|Other — 7 candidates stripped; promote to reference product]',
    `usage_count` STRING COMMENT 'Number of active offtake agreements or pricing formulas currently referencing this index. Used for impact analysis when indices are deprecated or changed.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this price index record in the system.',
    CONSTRAINT pk_price_index PRIMARY KEY(`price_index_id`)
) COMMENT 'Reference master of commodity price indices used in offtake agreement pricing formulas, including index code, index name, publishing agency (Platts, TSI, LME, Fastmarkets), commodity, unit of measure, quotational period convention, and active status. Distinct from benchmark_price (which holds the actual daily price values) — this is the index definition catalog.';

CREATE OR REPLACE TABLE `mining_ecm`.`sales`.`vessel` (
    `vessel_id` BIGINT COMMENT 'Primary key for vessel',
    `sister_vessel_id` BIGINT COMMENT 'Self-referencing FK on vessel (sister_vessel_id)',
    `beam_width_m` DECIMAL(18,2) COMMENT 'Maximum width of the vessel in meters, critical for determining port and canal passage feasibility.',
    `build_year` STRING COMMENT 'Year the vessel was constructed, used to assess vessel age, maintenance requirements, and insurance premiums.',
    `call_sign` STRING COMMENT 'Unique radio call sign assigned to the vessel for maritime communication and identification purposes.',
    `cargo_hold_capacity_m3` DECIMAL(18,2) COMMENT 'Total volumetric capacity of all cargo holds in cubic meters, used to determine maximum commodity volume that can be loaded.',
    `charter_end_date` DATE COMMENT 'Date when the current charter agreement for the vessel expires, critical for long-term shipment nomination planning.',
    `charter_start_date` DATE COMMENT 'Date when the current charter agreement for the vessel becomes effective, used for shipment planning and cost allocation.',
    `charter_type` STRING COMMENT 'Type of charter agreement under which the vessel operates, affecting cost structure and operational control for commodity shipments.',
    `classification_society` STRING COMMENT 'Name of the independent organization that certifies the vessel meets safety and construction standards (e.g., Lloyds Register, DNV GL, ABS).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vessel record was first created in the system, used for data lineage and audit trail purposes.',
    `daily_charter_rate_usd` DECIMAL(18,2) COMMENT 'Daily cost in USD for chartering the vessel under time charter agreements, used for freight cost forecasting and budget planning.',
    `deadweight_tonnage` DECIMAL(18,2) COMMENT 'Maximum weight in metric tonnes that the vessel can safely carry including cargo, fuel, crew, provisions, and ballast. Critical for matching vessel capacity to shipment volume requirements.',
    `draft_depth_m` DECIMAL(18,2) COMMENT 'Vertical distance between the waterline and the bottom of the vessel hull in meters when fully loaded, used to assess port depth requirements and loading limits.',
    `flag_country_code` STRING COMMENT 'Three-letter ISO country code representing the nation under whose laws the vessel is registered, affecting regulatory compliance and taxation.',
    `fuel_consumption_ballast_mt_per_day` DECIMAL(18,2) COMMENT 'Daily fuel consumption in metric tonnes when the vessel is traveling without cargo, used for repositioning cost calculations.',
    `fuel_consumption_laden_mt_per_day` DECIMAL(18,2) COMMENT 'Daily fuel consumption in metric tonnes when the vessel is fully loaded, used for voyage cost estimation and carbon footprint calculation.',
    `gross_tonnage` DECIMAL(18,2) COMMENT 'Measure of the overall internal volume of the vessel in register tonnes, used for regulatory compliance and port fee calculations.',
    `ice_class_rating` STRING COMMENT 'Classification indicating the vessels capability to operate in ice-covered waters, critical for winter shipments from northern ports.',
    `imo_number` STRING COMMENT 'Unique seven-digit ship identification number assigned by the International Maritime Organization for vessel tracking and regulatory compliance.',
    `is_vetting_approved` BOOLEAN COMMENT 'Indicates whether the vessel has passed the companys vetting process for safety, environmental compliance, and operational standards.',
    `last_survey_date` DATE COMMENT 'Date of the most recent classification society survey or inspection, used to assess vessel compliance and maintenance status.',
    `length_overall_m` DECIMAL(18,2) COMMENT 'Maximum length of the vessel from bow to stern in meters, used to determine port berthing compatibility and canal transit eligibility.',
    `mmsi_number` STRING COMMENT 'Nine-digit unique identifier used by maritime digital selective calling, automatic identification systems, and other radio applications for vessel tracking.',
    `net_tonnage` DECIMAL(18,2) COMMENT 'Measure of the usable cargo volume of the vessel in register tonnes, used for calculating port charges and canal transit fees.',
    `next_survey_due_date` DATE COMMENT 'Scheduled date for the next mandatory classification society survey, critical for planning vessel availability and maintenance downtime.',
    `number_of_holds` STRING COMMENT 'Total count of separate cargo holds on the vessel, relevant for segregating different commodity grades or types during shipment.',
    `operator_name` STRING COMMENT 'Name of the company or entity responsible for the day-to-day operation and management of the vessel.',
    `owner_name` STRING COMMENT 'Legal name of the entity that owns the vessel, used for contract negotiations and liability determination.',
    `port_of_registry` STRING COMMENT 'Name of the port where the vessel is officially registered, determining the legal jurisdiction and regulatory framework.',
    `shipyard_name` STRING COMMENT 'Name of the shipyard where the vessel was constructed, relevant for quality assessment and maintenance history.',
    `speed_ballast_knots` DECIMAL(18,2) COMMENT 'Average cruising speed of the vessel in knots when traveling without cargo (in ballast condition), used for repositioning time calculations.',
    `speed_laden_knots` DECIMAL(18,2) COMMENT 'Average cruising speed of the vessel in knots when fully loaded with cargo, used for voyage duration estimation and shipment scheduling.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the vessel record was last modified, used for tracking data currency and change management.',
    `vessel_name` STRING COMMENT 'Official registered name of the vessel used for commodity shipment and transportation.',
    `vessel_status` STRING COMMENT 'Current operational status of the vessel indicating availability for commodity shipment nominations and offtake agreements.',
    `vessel_type` STRING COMMENT 'Classification of vessel based on cargo capacity and design, critical for matching vessel to commodity shipment requirements.',
    `vetting_expiry_date` DATE COMMENT 'Date when the current vetting approval expires and the vessel must be re-evaluated for continued use in commodity shipments.',
    CONSTRAINT pk_vessel PRIMARY KEY(`vessel_id`)
) COMMENT 'Master reference table for vessel. Referenced by vessel_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `mining_ecm`.`sales`.`price_index`(`price_index_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `mining_ecm`.`sales`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `mining_ecm`.`sales`.`price_index`(`price_index_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_commodity_order_id` FOREIGN KEY (`commodity_order_id`) REFERENCES `mining_ecm`.`sales`.`commodity_order`(`commodity_order_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `mining_ecm`.`sales`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `mining_ecm`.`sales`.`vessel`(`vessel_id`);
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ADD CONSTRAINT `fk_sales_benchmark_price_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `mining_ecm`.`sales`.`price_index`(`price_index_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `mining_ecm`.`sales`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_commodity_order_id` FOREIGN KEY (`commodity_order_id`) REFERENCES `mining_ecm`.`sales`.`commodity_order`(`commodity_order_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `mining_ecm`.`sales`.`price_index`(`price_index_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_quality_certificate_id` FOREIGN KEY (`quality_certificate_id`) REFERENCES `mining_ecm`.`sales`.`quality_certificate`(`quality_certificate_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `mining_ecm`.`sales`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `mining_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `mining_ecm`.`sales`.`price_index`(`price_index_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `mining_ecm`.`sales`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `mining_ecm`.`sales`.`price_index`(`price_index_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_volume_plan_id` FOREIGN KEY (`volume_plan_id`) REFERENCES `mining_ecm`.`sales`.`volume_plan`(`volume_plan_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `mining_ecm`.`sales`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `mining_ecm`.`sales`.`price_index`(`price_index_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_commodity_order_id` FOREIGN KEY (`commodity_order_id`) REFERENCES `mining_ecm`.`sales`.`commodity_order`(`commodity_order_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `mining_ecm`.`sales`.`vessel`(`vessel_id`);
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `mining_ecm`.`sales`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_shipment_nomination_id` FOREIGN KEY (`shipment_nomination_id`) REFERENCES `mining_ecm`.`sales`.`shipment_nomination`(`shipment_nomination_id`);
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `mining_ecm`.`sales`.`vessel`(`vessel_id`);
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ADD CONSTRAINT `fk_sales_quality_certificate_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `mining_ecm`.`sales`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `mining_ecm`.`sales`.`price_index`(`price_index_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_shipment_nomination_id` FOREIGN KEY (`shipment_nomination_id`) REFERENCES `mining_ecm`.`sales`.`shipment_nomination`(`shipment_nomination_id`);
ALTER TABLE `mining_ecm`.`sales`.`vessel` ADD CONSTRAINT `fk_sales_vessel_sister_vessel_id` FOREIGN KEY (`sister_vessel_id`) REFERENCES `mining_ecm`.`sales`.`vessel`(`vessel_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `mining_ecm`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Identifier');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lom Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `ore_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `pricing_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `pricing_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Configuration Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `resource_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Statement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'term|spot|framework|master');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `annual_volume_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume (Tonnes)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `arbitration_clause` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Clause Indicator');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `base_price_usd_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Base Price (USD per Tonne)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `base_price_usd_per_tonne` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `contracted_volume_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Contracted Volume (Tonnes)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_business_glossary_term' = 'Delivery Basis (Incoterms)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_value_regex' = 'FOB|CIF|CFR|DAP|EXW');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause Indicator');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `loading_port` SET TAGS ('dbx_business_glossary_term' = 'Loading Port');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `lom_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Alignment Flag');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `maximum_shipment_size_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Shipment Size (Tonnes)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `minimum_shipment_size_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Shipment Size (Tonnes)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `offtake_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `offtake_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `payment_term_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Term (Days)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `price_adjustment_formula` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Formula');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `price_adjustment_formula` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Pricing Mechanism');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_value_regex' = 'index_linked|fixed|benchmark|formula');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `quality_penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Quality Penalty Clause Indicator');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'automatic|mutual_consent|buyer_option|seller_option|none');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `shipment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Shipment Frequency');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ALTER COLUMN `tenure_years` SET TAGS ('dbx_business_glossary_term' = 'Tenure (Years)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `commodity_order_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Order Identifier (ID)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Identifier (ID)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `pricing_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Configuration Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms (Incoterms)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|CFR|DAP|DDP|EXW');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Date');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Date');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `final_price` SET TAGS ('dbx_business_glossary_term' = 'Final Price');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `final_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `lom_forecast_period` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Forecast Period');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'term|spot');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `order_value` SET TAGS ('dbx_business_glossary_term' = 'Order Value');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|AUD|CNY|GBP|JPY');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'per_DMT|per_WMT|per_MT|per_tonne|per_pound|per_ounce');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `provisional_price` SET TAGS ('dbx_business_glossary_term' = 'Provisional Price');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `provisional_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'DMT|WMT|MT|tonnes|pounds|ounces');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `shipment_nomination_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Nomination Reference');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `shipment_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Nomination Identifier');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `cargo_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Shipment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `commodity_order_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Order Identifier (ID)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Delivery Destination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Rom Stockpile Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `contract_price_usd_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Contract Price United States Dollars (USD) Per Tonne');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `contract_price_usd_per_tonne` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `contract_price_usd_per_tonne` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `estimated_discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Discharge Date');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `estimated_loading_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Loading Date');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `estimated_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue United States Dollars (USD)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `estimated_revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `estimated_revenue_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `laycan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan End Date');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `laycan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan Start Date');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `loading_port_code` SET TAGS ('dbx_business_glossary_term' = 'Loading Port Code');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `loading_port_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `loading_port_name` SET TAGS ('dbx_business_glossary_term' = 'Loading Port Name');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `nominated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Nominated Quantity');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `nomination_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Date');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `nomination_number` SET TAGS ('dbx_business_glossary_term' = 'Nomination Number');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `nomination_status` SET TAGS ('dbx_business_glossary_term' = 'Nomination Status');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `nomination_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|confirmed|cancelled');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `pricing_period` SET TAGS ('dbx_business_glossary_term' = 'Pricing Period');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `pricing_period` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'MT|DMT|WMT|tonnes|kg|lbs');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percentage');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'vessel|rail|road|barge|pipeline|air');
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` SET TAGS ('dbx_subdomain' = 'invoice_pricing');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `benchmark_price_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Price ID');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `contract_specification` SET TAGS ('dbx_business_glossary_term' = 'Contract Specification');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `data_source_url` SET TAGS ('dbx_business_glossary_term' = 'Data Source Uniform Resource Locator (URL)');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_business_glossary_term' = 'Delivery Basis');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_value_regex' = 'CFR|CIF|FOB|DAP|DDP|EXW');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `index_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Index Effective Date');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `index_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Index Expiry Date');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `index_status` SET TAGS ('dbx_business_glossary_term' = 'Index Status');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `index_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Discontinued|Suspended');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `price_close` SET TAGS ('dbx_business_glossary_term' = 'Price Close');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `price_date` SET TAGS ('dbx_business_glossary_term' = 'Price Date');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `price_high` SET TAGS ('dbx_business_glossary_term' = 'Price High');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `price_low` SET TAGS ('dbx_business_glossary_term' = 'Price Low');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `price_open` SET TAGS ('dbx_business_glossary_term' = 'Price Open');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'Spot|Forward|Futures|Assessment|Settlement');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `price_value` SET TAGS ('dbx_business_glossary_term' = 'Price Value');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `publication_frequency` SET TAGS ('dbx_business_glossary_term' = 'Publication Frequency');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `publication_frequency` SET TAGS ('dbx_value_regex' = 'Daily|Weekly|Monthly|Quarterly|Real-time');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `publication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Publication Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `quotational_period_convention` SET TAGS ('dbx_business_glossary_term' = 'Quotational Period (QP) Convention');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `quotational_period_convention` SET TAGS ('dbx_value_regex' = 'Daily|Weekly|Monthly Average|Spot|Forward M+1|Forward M+2|Forward M+3|Quarterly');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `revision_indicator` SET TAGS ('dbx_business_glossary_term' = 'Revision Indicator');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `revision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revision Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'USD/DMT|USD/WMT|USD/t|USD/lb|USD/kg|USD/oz');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ALTER COLUMN `volume_traded` SET TAGS ('dbx_business_glossary_term' = 'Volume Traded');
ALTER TABLE `mining_ecm`.`sales`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`sales`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_pricing');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `cargo_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Shipment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `commodity_order_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `letter_of_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Credit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `pricing_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Configuration Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `quality_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Identifier (ID)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `adjustment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Quantity');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|not_applicable');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `adjustment_value` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Value Amount');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `buyer_reference` SET TAGS ('dbx_business_glossary_term' = 'Buyer Reference Number');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `final_price` SET TAGS ('dbx_business_glossary_term' = 'Final Settled Price');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (INCOTERMS)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{8,12}$');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Issue Date');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency Code');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = 'USD|AUD|EUR|CNY|JPY|GBP');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `provisional_price` SET TAGS ('dbx_business_glossary_term' = 'Provisional Price');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `quality_specification` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'DMT|WMT|MT|tonnes');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `quotational_period_end` SET TAGS ('dbx_business_glossary_term' = 'Quotational Period End Date (QP)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `quotational_period_start` SET TAGS ('dbx_business_glossary_term' = 'Quotational Period Start Date (QP)');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Date');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Date');
ALTER TABLE `mining_ecm`.`sales`.`invoice` ALTER COLUMN `total_invoice_value` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Value');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` SET TAGS ('dbx_subdomain' = 'invoice_pricing');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `provisional_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Provisional Adjustment Identifier (ID)');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `assay_result_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Result Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `cargo_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `pricing_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Configuration Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `production_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Production Reconciliation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `adjustment_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Invoice Date');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `adjustment_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Invoice Number');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `adjustment_invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_value_regex' = '^ADJ-[0-9]{8,12}$');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `adjustment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Quantity');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'provisional_to_final|interim|final|supplementary');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `adjustment_value` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Value');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Approved By User');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Approved Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `assay_adjustment_applied` SET TAGS ('dbx_business_glossary_term' = 'Assay Adjustment Applied Flag');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `contract_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `final_price` SET TAGS ('dbx_business_glossary_term' = 'Final Price');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'not_due|pending|paid|overdue|disputed|waived');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `price_difference` SET TAGS ('dbx_business_glossary_term' = 'Price Difference');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `provisional_price` SET TAGS ('dbx_business_glossary_term' = 'Provisional Price');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'MT|DMT|WMT|KG|LB|OZ');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `quotational_period_end` SET TAGS ('dbx_business_glossary_term' = 'Quotational Period End Date');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `quotational_period_start` SET TAGS ('dbx_business_glossary_term' = 'Quotational Period Start Date');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `revenue_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Forecast ID');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `block_model_id` SET TAGS ('dbx_business_glossary_term' = 'Block Model Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity ID');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lom Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `ore_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `project_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Valuation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `resource_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Statement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `royalty_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `tsf_capacity_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Capacity Survey Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `volume_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `assumed_benchmark_price` SET TAGS ('dbx_business_glossary_term' = 'Assumed Benchmark Price');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `assumptions_notes` SET TAGS ('dbx_business_glossary_term' = 'Assumptions Notes');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `board_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Reporting Flag');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `estimated_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Amount');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `forecast_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Level');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `forecast_confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `forecast_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `forecast_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `forecast_preparation_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Preparation Date');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|superseded');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'budget|revised|latest_estimate|board_guidance|lom_aligned');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `forecast_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `forecast_volume_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Volume (Tonnes)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `forecast_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Forecast Volume Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `forecast_volume_uom` SET TAGS ('dbx_value_regex' = 'tonnes|dmt|wmt|pounds|ounces');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `lom_production_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Production Alignment Flag');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `price_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Factor');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Pricing Mechanism');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_value_regex' = 'spot|term_fixed|term_provisional|index_linked|formula_based');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Currency Code');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_value_regex' = 'USD|AUD|EUR|CNY|GBP|JPY');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `risk_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Amount');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `shipment_destination_region` SET TAGS ('dbx_business_glossary_term' = 'Shipment Destination Region');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `variance_to_prior_forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Forecast Amount');
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ALTER COLUMN `variance_to_prior_forecast_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Forecast Percentage');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `volume_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Plan Identifier');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `block_model_id` SET TAGS ('dbx_business_glossary_term' = 'Block Model Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lom Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `ore_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `resource_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Statement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'STEEL_MILL|TRADER|SMELTER|MANUFACTURER|UTILITY');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_business_glossary_term' = 'Delivery Basis');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_value_regex' = 'FOB|CIF|CFR|EXW|DDP');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `logistics_mode` SET TAGS ('dbx_business_glossary_term' = 'Logistics Mode');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `logistics_mode` SET TAGS ('dbx_value_regex' = 'VESSEL|RAIL|TRUCK|PIPELINE|BARGE');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `lom_production_forecast_alignment` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Production Forecast Alignment');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `lom_production_forecast_alignment` SET TAGS ('dbx_value_regex' = 'ALIGNED|PARTIAL|NOT_ALIGNED');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `offtake_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Offtake Coverage Percentage');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `plan_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `plan_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Expiry Date');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `plan_quarter` SET TAGS ('dbx_business_glossary_term' = 'Plan Quarter');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `plan_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4|ANNUAL');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'DRAFT|APPROVED|ACTIVE|REVISED|SUPERSEDED');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `planned_price_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Planned Price Per Tonne');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `planned_price_per_tonne` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `planned_volume_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume (Tonnes)');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Pricing Mechanism');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_value_regex' = 'SPOT|TERM_FIXED|TERM_INDEX|PROVISIONAL');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `revenue_forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Forecast Amount');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `revenue_forecast_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `shipment_nomination_window` SET TAGS ('dbx_business_glossary_term' = 'Shipment Nomination Window');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `variance_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Tolerance Percentage');
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `cargo_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Shipment Identifier');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `commodity_order_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `letter_of_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Credit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Rom Stockpile Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BL) Number');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `bl_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BL) Issue Date');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `demurrage_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Amount United States Dollars (USD)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `demurrage_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `despatch_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Despatch Amount United States Dollars (USD)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `despatch_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `discharge_commenced_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discharge Commenced Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `discharge_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discharge Completed Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `documentary_credit_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Documentary Credit Compliant Flag');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `insurance_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Insurance Cost United States Dollars (USD)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `insurance_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `invoice_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Invoice Value United States Dollars (USD)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `invoice_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `laytime_allowed_hours` SET TAGS ('dbx_business_glossary_term' = 'Laytime Allowed Hours');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `laytime_used_hours` SET TAGS ('dbx_business_glossary_term' = 'Laytime Used Hours');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `loading_commenced_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loading Commenced Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `loading_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loading Completed Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Percentage');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `net_dry_weight_dmt` SET TAGS ('dbx_business_glossary_term' = 'Net Dry Weight Dry Metric Tonnes (DMT)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_business_glossary_term' = 'Notify Party Name');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `port_of_discharge_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Discharge Code');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `port_of_discharge_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `port_of_loading_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading Code');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `port_of_loading_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Shipment Remarks');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `shipped_quantity_wmt` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity Wet Metric Tonnes (WMT)');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `shipper_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Name');
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ALTER COLUMN `terminal_name` SET TAGS ('dbx_business_glossary_term' = 'Terminal Name');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BL) Identifier');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `cargo_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Identifier');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `shipment_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Nomination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Identifier');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `bl_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BL) Number');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `bl_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `bl_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BL) Status');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `bl_status` SET TAGS ('dbx_value_regex' = 'draft|issued|surrendered|amended|cancelled');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `bl_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BL) Type');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `bl_type` SET TAGS ('dbx_value_regex' = 'original|copy|seaway|express|charter_party');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `consignee_address` SET TAGS ('dbx_business_glossary_term' = 'Consignee Address');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `consignee_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `consignee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `container_numbers` SET TAGS ('dbx_business_glossary_term' = 'Container Numbers');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `gross_weight_mt` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Metric Tonnes)');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `is_negotiable` SET TAGS ('dbx_business_glossary_term' = 'Is Negotiable Flag');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `marks_and_numbers` SET TAGS ('dbx_business_glossary_term' = 'Marks and Numbers');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Percentage');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `net_dry_weight_mt` SET TAGS ('dbx_business_glossary_term' = 'Net Dry Weight (Metric Tonnes)');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `net_weight_mt` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Metric Tonnes)');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `notify_party_address` SET TAGS ('dbx_business_glossary_term' = 'Notify Party Address');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `notify_party_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `notify_party_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_business_glossary_term' = 'Notify Party Name');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `number_of_originals` SET TAGS ('dbx_business_glossary_term' = 'Number of Original Bills');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `on_board_date` SET TAGS ('dbx_business_glossary_term' = 'On Board Date');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'bulk|container|bag|pallet|drum');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `place_of_delivery` SET TAGS ('dbx_business_glossary_term' = 'Place of Delivery');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `place_of_receipt` SET TAGS ('dbx_business_glossary_term' = 'Place of Receipt');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `port_of_discharge_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Discharge Code');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `port_of_discharge_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `port_of_discharge_name` SET TAGS ('dbx_business_glossary_term' = 'Port of Discharge Name');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `port_of_loading_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading Code');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `port_of_loading_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `port_of_loading_name` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading Name');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `shipper_address` SET TAGS ('dbx_business_glossary_term' = 'Shipper Address');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `shipper_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `shipper_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `shipper_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Name');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ALTER COLUMN `voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage Number');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `quality_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Identifier');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `assay_result_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Result Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `cargo_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Shipment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `production_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Production Reconciliation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Rom Stockpile Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `alumina_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Alumina (Al2O3) Content Percent');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `benchmark_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index Reference');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'draft|issued|revised|disputed|accepted|rejected');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'certificate_of_analysis|inspection_certificate|weight_certificate|moisture_certificate|combined_certificate');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `discharge_port` SET TAGS ('dbx_business_glossary_term' = 'Discharge Port');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Effective Date');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `iron_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Iron (Fe) Content Percent');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `issuing_laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Laboratory Name');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `laboratory_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation Number');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `loading_port` SET TAGS ('dbx_business_glossary_term' = 'Loading Port');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `loss_on_ignition_percent` SET TAGS ('dbx_business_glossary_term' = 'Loss on Ignition (LOI) Percent');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Percent');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `penalty_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Deduction Amount');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `penalty_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `penalty_deduction_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Deduction Currency');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `penalty_deduction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `phosphorus_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Phosphorus (P) Content Percent');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `price_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Factor');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `price_adjustment_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Certificate Remarks');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `sales_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Number');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `sales_contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `shipment_quantity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Shipment Quantity (Tonnes)');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `silica_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Silica (SiO2) Content Percent');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `size_fraction_minus_6_3mm_percent` SET TAGS ('dbx_business_glossary_term' = 'Size Fraction Minus 6.3mm Percent');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `size_fraction_plus_31_5mm_percent` SET TAGS ('dbx_business_glossary_term' = 'Size Fraction Plus 31.5mm Percent');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur (S) Content Percent');
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `offtake_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Schedule ID');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `cargo_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Shipment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement ID');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `shipment_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Nomination ID');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_business_glossary_term' = 'Delivery Basis');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_value_regex' = 'FOB|CIF|CFR|DAP|DDP|EXW');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `delivery_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Date');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `delivery_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Date');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `lifting_number` SET TAGS ('dbx_business_glossary_term' = 'Lifting Number');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `lom_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Alignment Flag');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `nominated_vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Nominated Vessel Name');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `port_allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Port Allocation Code');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Pricing Mechanism');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_value_regex' = 'fixed|index_linked|provisional|spot');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `schedule_month` SET TAGS ('dbx_business_glossary_term' = 'Schedule Month');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `schedule_period_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period Type');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `schedule_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annual|annual');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `schedule_quarter` SET TAGS ('dbx_business_glossary_term' = 'Schedule Quarter');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|in_progress|completed|cancelled|deferred');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `schedule_year` SET TAGS ('dbx_business_glossary_term' = 'Schedule Year');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `scheduled_lifting_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Lifting Date');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `scheduled_price_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Price Per Tonne');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `scheduled_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Revenue Amount');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `scheduled_volume_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Volume Tonnes');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percentage');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `vessel_nomination_deadline` SET TAGS ('dbx_business_glossary_term' = 'Vessel Nomination Deadline');
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ALTER COLUMN `volume_variance_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Volume Variance Tonnes');
ALTER TABLE `mining_ecm`.`sales`.`price_index` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `mining_ecm`.`sales`.`price_index` SET TAGS ('dbx_subdomain' = 'invoice_pricing');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Identifier');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `adjustment_factor_applicable` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Factor Applicable');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `alternative_index_code` SET TAGS ('dbx_business_glossary_term' = 'Alternative Index Code');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `commodity_grade` SET TAGS ('dbx_business_glossary_term' = 'Commodity Grade');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `data_source_url` SET TAGS ('dbx_business_glossary_term' = 'Data Source URL');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_business_glossary_term' = 'Delivery Basis');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `index_category` SET TAGS ('dbx_business_glossary_term' = 'Index Category');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `index_category` SET TAGS ('dbx_value_regex' = 'Spot|Forward|Futures|Benchmark|Derivative|Other');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `index_code` SET TAGS ('dbx_business_glossary_term' = 'Index Code');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `index_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `index_family` SET TAGS ('dbx_business_glossary_term' = 'Index Family');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `index_methodology_description` SET TAGS ('dbx_business_glossary_term' = 'Index Methodology Description');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `index_name` SET TAGS ('dbx_business_glossary_term' = 'Index Name');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `index_status` SET TAGS ('dbx_business_glossary_term' = 'Index Status');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `index_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Deprecated|Suspended|Under Review');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `publication_frequency` SET TAGS ('dbx_business_glossary_term' = 'Publication Frequency');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `publication_frequency` SET TAGS ('dbx_value_regex' = 'Daily|Weekly|Monthly|Quarterly|Real-time|Other');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `publishing_agency` SET TAGS ('dbx_business_glossary_term' = 'Publishing Agency');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `quotational_period_convention` SET TAGS ('dbx_business_glossary_term' = 'Quotational Period (QP) Convention');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `mining_ecm`.`sales`.`price_index` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `mining_ecm`.`sales`.`vessel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`sales`.`vessel` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `mining_ecm`.`sales`.`vessel` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Identifier');
ALTER TABLE `mining_ecm`.`sales`.`vessel` ALTER COLUMN `sister_vessel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`vessel` ALTER COLUMN `daily_charter_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`vessel` ALTER COLUMN `operator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`sales`.`vessel` ALTER COLUMN `owner_name` SET TAGS ('dbx_confidential' = 'true');
