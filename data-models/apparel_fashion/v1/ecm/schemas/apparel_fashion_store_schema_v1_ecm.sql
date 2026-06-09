-- Schema for Domain: store | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:38

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`store` COMMENT 'Manages retail store operations including POS transactions, store inventory, sales associates, visual merchandising, store performance KPIs, daily sales reconciliation, shrinkage, and omnichannel fulfillment (BOPIS, ship-from-store). Tracks store-level STR, ASP, AUR, and traffic analytics via SAP Customer Activity Repository.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`retail_store` (
    `retail_store_id` BIGINT COMMENT 'Unique surrogate identifier for each physical retail store location operated by Apparel Fashion. Primary key for the retail_store master record, referenced by POS, inventory, workforce, and omnichannel systems as the SSOT store dimension key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Retail stores are cost centers in apparel operations. Essential for store-level P&L reporting, budget variance analysis, and operational expense allocation. Every store manager reviews cost center per',
    `district_id` BIGINT COMMENT 'Foreign key linking to store.district. Business justification: Retail stores belong to districts for regional management hierarchy. retail_store currently has district_name (STRING) which is redundant once district_id FK is added. The district table contains dist',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: District managers oversee 8-15 store clusters, responsible for performance management, operational compliance, and escalation resolution. Essential for retail organizational hierarchy reporting, labor',
    `energy_consumption_id` BIGINT COMMENT 'Foreign key linking to sustainability.energy_consumption. Business justification: Stores consume energy for HVAC, lighting, and operations. Facilities teams track consumption by location for Scope 2 emissions reporting, utility cost management, renewable energy transition planning,',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to logistics.distribution_center. Business justification: Each store is assigned a primary DC for replenishment routing, inventory allocation planning, and freight cost modeling. Fundamental supply chain network design relationship used in allocation and tra',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Stores are profit centers for segment reporting and profitability analysis. Required for management reporting, regional performance comparison, and strategic decision-making on store portfolio. Standa',
    `renewable_energy_certificate_id` BIGINT COMMENT 'Foreign key linking to sustainability.renewable_energy_certificate. Business justification: Stores are allocated renewable energy certificates to offset Scope 2 emissions from electricity consumption. Sustainability teams track REC allocation by facility for carbon accounting, RE100 complian',
    `store_cluster_id` BIGINT COMMENT 'Foreign key linking to store.store_cluster. Business justification: Retail stores are grouped into clusters for merchandising, pricing, and operational strategy. The visual_merchandising_plan product references store_cluster_code, indicating stores belong to clusters.',
    `waste_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.waste_record. Business justification: Stores generate operational waste (packaging, hangers, damaged goods, cardboard). Waste management teams track by location for zero-waste-to-landfill programs, diversion rate reporting, circular econo',
    `water_usage_id` BIGINT COMMENT 'Foreign key linking to sustainability.water_usage. Business justification: Stores use water for restrooms, cleaning, and HVAC systems. Facilities teams track water consumption by location for sustainability reporting, utility management, water stewardship programs, and opera',
    `address_line1` STRING COMMENT 'Primary street address line of the retail store location. Used for logistics, lease documentation, customer store-finder, and regulatory filings. Organizational contact data classified as confidential.',
    `address_line2` STRING COMMENT 'Secondary address line for the retail store (suite, floor, unit, mall name, or building identifier). Supplements address_line1 for precise location identification in complex retail environments such as shopping malls or department stores.',
    `annual_base_rent` DECIMAL(18,2) COMMENT 'Annual base rent amount payable under the store lease agreement in the stores local currency. Used for occupancy cost analysis, GMROI (Gross Margin Return on Investment) calculation, and store profitability modelling. Excludes turnover/percentage rent and service charges.',
    `city` STRING COMMENT 'City or municipality in which the retail store is located. Used for geographic reporting, tax jurisdiction determination, and regional performance analytics.',
    `climate_zone` STRING COMMENT 'Köppen-based climate zone classification for the stores geographic location. Drives seasonal assortment planning, markdown timing, and inventory allocation decisions for weather-sensitive apparel categories (outerwear, swimwear, knitwear).. Valid values are `tropical|arid|temperate|continental|polar`',
    `closure_date` DATE COMMENT 'Date on which the store permanently ceased trading operations. Nullable for active stores. Used for store network rationalization reporting, lease surrender tracking, and historical performance analysis. Populated only when operational_status is permanently_closed.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the country in which the retail store operates (e.g., USA, GBR, FRA, DEU). Drives currency, tax, regulatory compliance, and international reporting hierarchies.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the retail store master record was first created in the system of record (SAP S/4HANA Real Estate / SAP Customer Activity Repository). Used for data lineage, audit trail, and record lifecycle management in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the primary trading currency of the store (e.g., USD, GBP, EUR). Used for POS transaction recording, financial consolidation, and MSRP/AUR reporting in local currency.. Valid values are `^[A-Z]{3}$`',
    `email_address` STRING COMMENT 'Primary operational email address for the retail store location. Used for internal communications, vendor coordination, and omnichannel order notifications. Classified as confidential organizational contact data.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fitting_room_count` STRING COMMENT 'Total number of fitting rooms (changing rooms/dressing rooms) available in the store. Used for store capacity planning, customer experience benchmarking, and visual merchandising layout design. Relevant for apparel conversion rate analytics.',
    `gross_selling_sqft` DECIMAL(18,2) COMMENT 'Total gross interior square footage of the retail store including all selling, back-of-house, stockroom, and ancillary areas. Used for lease cost-per-square-foot analysis, capital expenditure planning, and store portfolio benchmarking.',
    `headcount_capacity` STRING COMMENT 'Maximum approved headcount (number of employees) for the store as defined in the workforce plan. Used for labour scheduling, Workday HCM position management, and compliance with local employment regulations. Drives OTB labour cost budgeting.',
    `is_bopis_enabled` BOOLEAN COMMENT 'Indicates whether the store is configured and operationally enabled to fulfil Buy Online Pick Up In Store (BOPIS) orders. Drives omnichannel order routing logic in Salesforce Commerce Cloud and SAP Customer Activity Repository. True = BOPIS active; False = BOPIS not available at this location.',
    `is_rfid_enabled` BOOLEAN COMMENT 'Indicates whether the store is equipped with Radio Frequency Identification (RFID) infrastructure for inventory tracking, cycle counting, and loss prevention. RFID-enabled stores support real-time inventory accuracy and ATS (Available to Sell) visibility. True = RFID infrastructure active.',
    `is_ship_from_store_enabled` BOOLEAN COMMENT 'Indicates whether the store is configured to fulfil e-commerce orders by shipping directly to customers from store inventory. Enables distributed fulfilment network capabilities. Drives order routing in Salesforce Commerce Cloud and Manhattan Associates WMS. True = ship-from-store active.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the retail store location in decimal degrees (WGS84). Used for store-finder applications, trade area mapping, proximity-based marketing, and omnichannel routing (BOPIS, ship-from-store).',
    `lease_expiry_date` DATE COMMENT 'Expiration date of the current lease agreement for the store premises. Used for lease renewal pipeline management, store closure planning, and IFRS 16 lease liability amortization schedule. Nullable for month-to-month or perpetual arrangements.',
    `lease_start_date` DATE COMMENT 'Commencement date of the current lease agreement for the store premises as recorded in SAP S/4HANA Real Estate module. Used for lease term tracking, IFRS 16 right-of-use asset calculation, and lease renewal planning.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the retail store location in decimal degrees (WGS84). Used alongside latitude for geospatial analytics, trade area delineation, and omnichannel fulfillment routing.',
    `net_selling_sqft` DECIMAL(18,2) COMMENT 'Net productive selling floor area in square feet, excluding stockroom, fitting rooms, cash wrap, and back-of-house. Primary denominator for sales-per-square-foot (SPF) KPI, visual merchandising density planning, and fixture capacity modelling.',
    `opening_date` DATE COMMENT 'Date on which the store first opened for trading to customers. Used for store age calculations, comparable store (comp-store) sales analysis, and new store ramp-up performance benchmarking.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the store location within Apparel Fashions retail network. Pre-open indicates the store is in fit-out or pre-launch phase; trading indicates active selling operations; temporarily_closed covers seasonal or refurbishment closures; permanently_closed indicates the store has ceased operations. Drives inclusion/exclusion in POS reporting, inventory allocation, and workforce scheduling.. Valid values are `pre-open|trading|temporarily_closed|permanently_closed`',
    `phone_number` STRING COMMENT 'Primary customer-facing telephone number for the retail store location. Used for customer service, click-and-collect (BOPIS) coordination, and store directory listings. Classified as confidential organizational contact data.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `pos_system_type` STRING COMMENT 'Classification of the POS terminal configuration deployed in the store. Fixed terminals are traditional counter-based registers; mobile POS (mPOS) enables floor-based selling; self-checkout enables customer-operated transactions; mixed indicates a combination. Drives IT infrastructure planning and customer experience design.. Valid values are `fixed|mobile|self-checkout|mixed`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the retail store location. Used for trade area analysis, catchment modelling, demographic profiling, and logistics routing.',
    `region_name` STRING COMMENT 'Name of the geographic region within Apparel Fashions retail organizational hierarchy (e.g., North America, EMEA, APAC). Top tier of the region/district/territory hierarchy used for regional performance reporting and resource allocation.',
    `register_count` STRING COMMENT 'Total number of active Point of Sale (POS) terminals (registers) installed in the store. Used for transaction throughput capacity planning, queue management, and SAP Customer Activity Repository (CAR) terminal configuration management.',
    `remodel_date` DATE COMMENT 'Date of the most recent store remodel or significant capital refurbishment. Used to assess store condition age, plan future capital expenditure cycles, and correlate store investment with post-remodel sales uplift.',
    `rent_structure_type` STRING COMMENT 'Classification of the rent payment structure under the store lease. Fixed rent is a flat periodic payment; turnover rent is a percentage of net sales; fixed_plus_turnover combines a base rent with a sales-linked top-up; concession_percentage applies to shop-in-shop and concession formats. Drives financial planning and OTB (Open-to-Buy) modelling.. Valid values are `fixed|turnover|fixed_plus_turnover|concession_percentage`',
    `standard_trading_hours` STRING COMMENT 'Standard weekly operating hours for the store expressed as a structured string (e.g., Mon-Sat 09:00-21:00; Sun 11:00-18:00). Used for customer-facing store finder, workforce scheduling in Workday HCM, and daily sales reconciliation cut-off timing in SAP Customer Activity Repository.',
    `state_province` STRING COMMENT 'State, province, or administrative region in which the retail store is located. Used for tax jurisdiction mapping, regional hierarchy assignment, and regulatory compliance reporting.',
    `stockroom_sqft` DECIMAL(18,2) COMMENT 'Total square footage of the stores back-of-house stockroom area. Used for inventory capacity planning, WMS (Warehouse Management System) configuration, and the calculation of net-to-gross selling area ratio. Informs replenishment frequency and NOS (Never Out of Stock) capability.',
    `store_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the store, used across SAP S/4HANA, SAP Customer Activity Repository (CAR), Oracle Retail, and EDI integrations. Conforms to NRF ARTS store numbering convention. Unique across all store formats and geographies.. Valid values are `^[A-Z0-9]{3,10}$`',
    `store_format` STRING COMMENT 'Operational format classification of the store that determines merchandising strategy, assortment depth, pricing authority, and capital investment profile. Flagship stores carry full-price full-assortment; outlet stores carry clearance/off-price; pop-up stores are temporary; shop-in-shop and concession operate within a host retailers space.. Valid values are `flagship|outlet|pop-up|shop-in-shop|concession`',
    `store_name` STRING COMMENT 'Official trading name of the retail store location as displayed on signage, customer receipts, and marketing materials. Used for customer-facing communications and brand management reporting.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax authority jurisdiction code assigned to the store location for sales tax, VAT, or GST calculation and remittance. Sourced from SAP S/4HANA FI/CO tax configuration. Used for POS transaction tax determination and regulatory tax reporting.',
    `territory_name` STRING COMMENT 'Name of the territory or cluster within the district hierarchy. Lowest tier of the organizational hierarchy above individual store level, used for territory manager assignments and localized assortment planning.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the stores local operating time zone (e.g., America/New_York, Europe/London). Critical for accurate POS transaction timestamping, daily sales reconciliation, and omnichannel order cut-off time management in SAP Customer Activity Repository.',
    `trading_area_classification` STRING COMMENT 'Classification of the retail trading environment in which the store operates. Determines foot traffic patterns, trading hours, lease structure, and competitive benchmarking peer group. Used in store performance analytics and site selection models. [ENUM-REF-CANDIDATE: high_street|shopping_mall|outlet_center|airport|resort|standalone|department_store — promote to reference product]',
    CONSTRAINT pk_retail_store PRIMARY KEY(`retail_store_id`)
) COMMENT 'Master record for each physical retail store location operated by Apparel Fashion. Captures store identity, format (flagship, outlet, pop-up, shop-in-shop, concession), trading area classification, gross and net selling square footage, register inventory (terminal count, types, configurations), lease terms and rent structure, regional/district/territory hierarchy, climate zone, and operational status (pre-open, trading, temporarily closed, permanently closed). SSOT for store-level dimensional attributes referenced by POS, inventory, workforce, and omnichannel systems. Conforms to NRF ARTS RetailStore entity. Sourced from SAP S/4HANA Real Estate and SAP Customer Activity Repository.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` (
    `pos_transaction_id` BIGINT COMMENT 'Primary key for pos_transaction',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: B2B wholesale transactions processed at retail locations generate AR invoices for trade customers. Common in apparel brands with hybrid retail/wholesale models where stores serve business accounts req',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: POS transactions track campaign attribution via promo codes and campaign-specific offers. Essential for measuring in-store campaign ROAS, conversion rates, and incremental sales lift—core retail marke',
    `associate_id` BIGINT COMMENT 'Reference to the sales associate or cashier who processed the transaction. Used for associate-level performance tracking, commission calculation, and loss prevention audits.',
    `digital_storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_storefront. Business justification: Omnichannel POS transactions (returns of online purchases, loyalty redemption across channels) require attribution to the originating digital storefront for unified commerce reporting and cross-channe',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program under which points were earned or redeemed in this transaction. Supports multi-program loyalty analytics and Customer Lifetime Value (CLTV) measurement.',
    `profile_id` BIGINT COMMENT 'Reference to the identified customer (loyalty member or registered account) associated with this transaction. Nullable for anonymous/walk-in transactions. Enables Customer Lifetime Value (CLTV) and loyalty analytics.',
    `promotion_id` BIGINT COMMENT 'Reference to the primary promotional offer applied to this transaction. Supports promotion effectiveness analysis, markdown (MD) attribution, and Gross Margin Return on Investment (GMROI) reporting.',
    `register_id` BIGINT COMMENT 'Reference to the specific POS register (terminal) at which the transaction was processed within the store. Supports register-level reconciliation and shrinkage analysis.',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store where this POS transaction was processed. Links to the store master in the Store Operations domain.',
    `return_original_transaction_pos_transaction_id` BIGINT COMMENT 'For RETURN or EXCHANGE transaction types, references the original sale transaction being returned against. Enables return merchandise authorization (RMA) traceability and shrinkage analysis. Null for non-return transactions.',
    `rma_id` BIGINT COMMENT 'Foreign key linking to order.rma. Business justification: In-store returns with defects or warranty claims generate RMA records for vendor credit processing (RTV authorization). Business process: store return disposition triggers formal RMA when item require',
    `sales_order_id` BIGINT COMMENT 'Reference to the associated omnichannel sales order in SAP S/4HANA SD or Salesforce Commerce Cloud for BOPIS, ship-from-store, or endless aisle transactions. Null for standard in-store transactions. Enables cross-channel order traceability.',
    `business_date` DATE COMMENT 'The fiscal/retail business date to which this transaction is attributed for daily sales reconciliation and End-of-Month (EOM) reporting. May differ from the wall-clock date for transactions processed after midnight during extended trading hours.',
    `channel_type` STRING COMMENT 'Identifies the omnichannel fulfillment mode under which the transaction was processed. IN_STORE: standard in-store purchase; BOPIS: Buy Online Pick Up In Store; SHIP_FROM_STORE: store fulfills an online order; ENDLESS_AISLE: in-store kiosk ordering; CURBSIDE: curbside pickup. Supports Direct-to-Consumer (DTC) analytics.. Valid values are `IN_STORE|BOPIS|SHIP_FROM_STORE|ENDLESS_AISLE|CURBSIDE`',
    `coupon_code` STRING COMMENT 'Alphanumeric coupon or voucher code scanned or entered at the POS to apply a discount. Supports coupon redemption tracking, campaign attribution, and fraud detection in loss prevention.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was first ingested into the Silver layer of the Databricks Lakehouse from SAP Customer Activity Repository. Audit trail field for data lineage and ETL reconciliation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the transaction was denominated (e.g., USD, EUR, GBP). Required for multi-currency retail operations and international store reporting.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all discounts and markdowns (MD) applied to the transaction, including promotional discounts, employee discounts, coupon redemptions, and loyalty-funded discounts. Used in Maintained Markup (MMU) and Sell-Through Rate (STR) analysis.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total pre-discount, pre-tax merchandise value of all items in the transaction at their selling price. Represents the sum of line-item extended prices before any adjustments. Used in Average Unit Retail (AUR) and Average Selling Price (ASP) calculations.',
    `item_count` STRING COMMENT 'Total number of individual unit items (units) included in the transaction across all line items. Used for basket size analytics, Average Order Value (AOV) benchmarking, and store traffic conversion metrics.',
    `line_count` STRING COMMENT 'Total number of distinct line items (SKU entries) in the transaction. Differs from item_count when multiple units of the same SKU are purchased. Used for transaction complexity analysis.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty reward points earned by the customer on this transaction based on the applicable loyalty program earn rate. Used for loyalty liability accrual and Customer Relationship Management (CRM) analytics.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty reward points redeemed by the customer as a form of payment or discount on this transaction. Used for loyalty liability reduction and redemption rate analytics.',
    `manager_override_flag` BOOLEAN COMMENT 'Indicates whether a manager authorization override was required to complete this transaction (e.g., for price overrides, high-value returns, or discount exceptions). Critical for loss prevention and exception-based reporting.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount tendered by the customer: gross_amount minus discount_amount plus tax_amount. Represents the total cash obligation of the transaction. Primary revenue figure for daily sales reconciliation and KPI reporting.',
    `price_override_flag` BOOLEAN COMMENT 'Indicates whether a manual price override was applied to one or more items in this transaction, bypassing the system-calculated selling price. Used in loss prevention audits and markdown (MD) exception reporting.',
    `receipt_delivery_method` STRING COMMENT 'Method by which the transaction receipt was delivered to the customer: PRINT (paper receipt), EMAIL (digital email receipt), SMS (text message receipt), NONE (no receipt requested). Supports sustainability reporting and digital engagement analytics.. Valid values are `PRINT|EMAIL|SMS|NONE`',
    `receipt_number` STRING COMMENT 'Customer-facing receipt identifier printed on the physical or digital receipt. May differ from transaction_number in some POS configurations. Used for customer service, return authorization, and receipt lookup.',
    `return_reason_code` STRING COMMENT 'Coded reason for a merchandise return (e.g., DEFECTIVE, WRONG_SIZE, CHANGED_MIND, GIFT_RETURN). Populated only for RETURN and EXCHANGE transaction types. Used in product quality analysis, CPSC compliance, and Return to Vendor (RTV) decisions. [ENUM-REF-CANDIDATE: DEFECTIVE|WRONG_SIZE|CHANGED_MIND|GIFT_RETURN|WRONG_ITEM|NOT_AS_DESCRIBED — promote to reference product]',
    `rfid_verified_flag` BOOLEAN COMMENT 'Indicates whether the items in this transaction were verified via Radio Frequency Identification (RFID) scanning at the point of sale. Supports inventory accuracy, shrinkage reduction, and omnichannel Available to Sell (ATS) reconciliation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax collected across all applicable tax jurisdictions for this transaction. Aggregated from jurisdiction-level tax lines. Supports tax remittance reporting and compliance with FTC and state tax authorities.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the primary tax jurisdiction (state, county, municipality) applicable to this transaction for sales tax calculation and remittance. Supports multi-jurisdiction tax compliance reporting.',
    `tender_cash_amount` DECIMAL(18,2) COMMENT 'Amount of the transaction settled by cash tender. Used in daily cash drawer reconciliation and loss prevention audits. Part of the tender split breakdown.',
    `tender_credit_amount` DECIMAL(18,2) COMMENT 'Amount of the transaction settled by credit card tender. Supports PCI DSS compliance reporting and payment reconciliation. Part of the tender split breakdown.',
    `tender_debit_amount` DECIMAL(18,2) COMMENT 'Amount of the transaction settled by debit card tender. Supports payment reconciliation and PCI DSS compliance. Part of the tender split breakdown.',
    `tender_gift_card_amount` DECIMAL(18,2) COMMENT 'Amount of the transaction settled by gift card redemption. Used for gift card liability tracking, breakage analysis, and revenue recognition per IFRS/GAAP deferred revenue rules.',
    `tender_mobile_wallet_amount` DECIMAL(18,2) COMMENT 'Amount of the transaction settled via mobile wallet payment (e.g., Apple Pay, Google Pay, Samsung Pay). Tracks digital payment adoption trends and supports omnichannel payment analytics.',
    `tender_store_credit_amount` DECIMAL(18,2) COMMENT 'Amount of the transaction settled using store credit (issued from prior returns or promotions). Supports Return to Vendor (RTV) and return merchandise authorization liability tracking.',
    `training_mode_flag` BOOLEAN COMMENT 'Indicates whether this transaction was processed in POS training/demo mode and should be excluded from financial reporting and sales analytics. Critical for data quality and accurate daily sales reconciliation.',
    `transaction_number` STRING COMMENT 'Externally-known business identifier for the transaction as printed on the customer receipt and recorded in SAP Customer Activity Repository. Unique within a store and business date combination. Conforms to NRF ARTS POSLog SequenceNumber.',
    `transaction_status` STRING COMMENT 'Current lifecycle state of the transaction in the POS workflow. COMPLETED: fully tendered and closed; VOIDED: reversed before completion; SUSPENDED: parked mid-transaction for later recall; CANCELLED: abandoned; PENDING: awaiting tender confirmation (e.g., BOPIS pickup).. Valid values are `COMPLETED|VOIDED|SUSPENDED|CANCELLED|PENDING`',
    `transaction_timestamp` TIMESTAMP COMMENT 'The precise date and time when the transaction was initiated at the register, as recorded by the POS system. Principal business event timestamp. Stored in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for intraday traffic analytics and hourly sales reporting.',
    `transaction_type` STRING COMMENT 'Classification of the transaction event per NRF ARTS POSLog standard. SALE: standard purchase; RETURN: merchandise returned for refund; EXCHANGE: simultaneous return and sale; VOID: cancelled transaction before completion; NO_SALE: register opened without a sale; LAYAWAY: deferred payment purchase.. Valid values are `SALE|RETURN|EXCHANGE|VOID|NO_SALE|LAYAWAY`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was last modified in the Silver layer (e.g., due to post-void processing, tax adjustment, or data correction). Supports audit trail and change data capture (CDC) tracking.',
    `void_reason_code` STRING COMMENT 'Coded reason for voiding a transaction (e.g., OPERATOR_ERROR, CUSTOMER_CHANGED_MIND, SYSTEM_ERROR, MANAGER_OVERRIDE). Populated only for VOID transaction types. Used in loss prevention and exception reporting. [ENUM-REF-CANDIDATE: OPERATOR_ERROR|CUSTOMER_CHANGED_MIND|SYSTEM_ERROR|MANAGER_OVERRIDE|PRICE_OVERRIDE|DUPLICATE_TRANSACTION — promote to reference product]',
    `workstation_number` STRING COMMENT 'Human-readable identifier of the POS workstation/terminal as configured in SAP Customer Activity Repository (e.g., REG-01, KIOSK-03). Used for register-level reconciliation and store layout analytics.',
    CONSTRAINT pk_pos_transaction PRIMARY KEY(`pos_transaction_id`)
) COMMENT 'Captures every point-of-sale transaction processed at a retail store register, including sale, return, exchange, void, and no-sale events. Records transaction date/time, register ID, cashier/associate, tender split (cash, credit, debit, mobile wallet, gift card, store credit), total amount, tax by jurisdiction, discount applied, loyalty points earned/redeemed, and channel flag (in-store, BOPIS pickup, endless aisle). Conforms to NRF ARTS POSLog standard for transaction classification. Primary transactional heartbeat of the store domain. Sourced from SAP Customer Activity Repository.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` (
    `pos_transaction_line_id` BIGINT COMMENT 'Primary key for pos_transaction_line',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Line-level campaign attribution enables SKU-level campaign performance analysis. Merchandising teams use this to understand which products respond to campaigns, informing future assortment and promoti',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.quality_defect. Business justification: Retail stores capture quality defect codes on damaged/defective items at POS for warranty claims, vendor chargebacks, and quality feedback loops. Essential for root cause analysis and supplier perform',
    `ftc_label_id` BIGINT COMMENT 'Foreign key linking to compliance.ftc_label. Business justification: POS systems validate FTC fiber content and care labeling compliance at sale to ensure consumer protection, prevent mislabeling penalties, and support regulatory audits requiring proof of compliant lab',
    `pos_transaction_id` BIGINT COMMENT 'Reference to the parent POS transaction header. Establishes the header-detail relationship between the transaction and its individual line items. Aligns with TRANSACTION_LINE role HEADER_REFERENCE category.',
    `profile_id` BIGINT COMMENT 'Reference to the loyalty program member associated with this transaction line, if the customer identified themselves. Enables customer-level purchase history, CLTV analysis, and personalized marketing attribution.',
    `promotion_id` BIGINT COMMENT 'Reference to the promotion or markdown event applied to this line item, if any. Links to the promotion master for promotional effectiveness analysis and markdown event attribution.',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store where this POS transaction line was recorded. Enables store-level STR, ASP, AUR, and traffic analytics at the store-SKU-day grain.',
    `associate_id` BIGINT COMMENT 'Reference to the sales associate who processed or assisted with this transaction line. Used for associate-level sales performance tracking, commission calculation, and clienteling analytics.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU (Stock Keeping Unit) sold on this line. Represents the most granular sellable unit combining style, colorway, and size. Aligns with TRANSACTION_LINE role RESOURCE_REFERENCE category.',
    `class_code` STRING COMMENT 'Merchandise class code within the department hierarchy for the SKU sold (e.g., TOPS, BOTTOMS, OUTERWEAR, SNEAKERS). Supports class-level STR, markdown analysis, and assortment planning within Oracle Retail.',
    `cogs` DECIMAL(18,2) COMMENT 'Cost of Goods Sold (COGS) for this line item representing the total cost of the units sold. Used to calculate gross margin, GMROI, and MMU at the SKU-store-day grain. Sourced from SAP S/4HANA material valuation.',
    `colorway_code` STRING COMMENT 'Code identifying the specific colorway (color variant) of the style sold on this line. Used for colorway-level sell-through analysis and markdown decision-making within collection planning.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this line item (e.g., USD, EUR, GBP). Required for multi-currency retail operations and financial consolidation reporting.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Merchandise department classification code for the SKU sold (e.g., MENS, WOMENS, KIDS, FOOTWEAR, ACCESSORIES). Enables department-level sales reporting, OTB management, and assortment performance analytics.',
    `discount_reason_code` STRING COMMENT 'Code identifying the business reason for any discount or markdown applied to this line item (e.g., EMPLOYEE, LOYALTY, COUPON, CLEARANCE, PROMO, DAMAGE). Used for discount analytics, shrinkage investigation, and promotional effectiveness reporting. [ENUM-REF-CANDIDATE: EMPLOYEE|LOYALTY|COUPON|CLEARANCE|PROMO|DAMAGE|PRICE_MATCH|MANAGER_OVERRIDE — promote to reference product]',
    `fulfillment_type` STRING COMMENT 'Indicates the omnichannel fulfillment method for this line item. Distinguishes standard in-store purchases from BOPIS (Buy Online Pick Up In Store), ship-from-store, curbside pickup, and endless aisle orders. Critical for DTC omnichannel analytics.. Valid values are `IN_STORE|BOPIS|SHIP_FROM_STORE|CURBSIDE|ENDLESS_AISLE`',
    `imu_pct` DECIMAL(18,2) COMMENT 'Initial Markup (IMU) percentage for this SKU at the time of the transaction, representing the difference between the original retail price and COGS as a percentage of retail. Key metric for margin planning and merchandise financial performance.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was ingested into the Databricks Silver layer from the source system. Used for data freshness monitoring, SLA compliance tracking, and incremental load auditing.',
    `is_clearance_item` BOOLEAN COMMENT 'Indicates whether the SKU on this line was designated as a clearance item at the time of sale. Clearance items are end-of-lifecycle SKUs being liquidated. Distinct from is_markdown_item which covers all markdowns including promotional.',
    `is_markdown_item` BOOLEAN COMMENT 'Indicates whether the SKU on this line was sold at a marked-down price at the time of the transaction. True if the item was on permanent or promotional markdown. Used to segment full-price vs. markdown sales for AUR and margin analytics.',
    `is_rfid_scanned` BOOLEAN COMMENT 'Indicates whether this line item was identified via RFID (Radio Frequency Identification) tag scan rather than traditional barcode/UPC scan at the POS. Supports RFID adoption tracking, inventory accuracy measurement, and shrinkage reduction analytics.',
    `line_discount_amount` DECIMAL(18,2) COMMENT 'Additional point-of-sale discount amount applied to this specific line item beyond the ticketed markdown, such as employee discounts, loyalty rewards, or coupon redemptions. Distinct from markdown_amount which reflects price management markdowns.',
    `line_extended_amount` DECIMAL(18,2) COMMENT 'Total net sales amount for this line item (unit_retail_price × quantity_sold minus line_discount_amount). Represents the actual revenue recognized for this line. Used in daily sales reconciliation and financial reporting.',
    `line_number` STRING COMMENT 'Sequential line number identifying the position of this item within the parent POS transaction. Used for ordering and referencing individual items within a receipt. Aligns with TRANSACTION_LINE role LINE_SEQUENCE category.',
    `line_type` STRING COMMENT 'Classification of the transaction line indicating whether it represents a sale, return, exchange, void, or layaway. Drives revenue recognition logic, inventory adjustment direction, and return analytics.. Valid values are `SALE|RETURN|EXCHANGE|VOID|LAYAWAY`',
    `markdown_amount` DECIMAL(18,2) COMMENT 'Total markdown (MD) dollar amount applied to this line item, calculated as the difference between the original retail price and the unit retail price multiplied by quantity. Tracks permanent and promotional markdowns for MMU and margin analytics.',
    `mmu_pct` DECIMAL(18,2) COMMENT 'Maintained Markup (MMU) percentage for this line item, reflecting the actual margin achieved after all markdowns and discounts. Calculated as (unit_retail_price - unit_cost) / unit_retail_price. Core KPI for merchandise financial planning.',
    `msrp` DECIMAL(18,2) COMMENT 'The manufacturers suggested retail price (MSRP) for the SKU at the time of the transaction. Used as the baseline for markdown calculation, IMU computation, and price integrity reporting.',
    `original_retail_price` DECIMAL(18,2) COMMENT 'The original ticketed retail price of the SKU before any markdowns or promotional discounts were applied in this transaction. Used to calculate markdown amount and sell-through performance relative to initial pricing.',
    `quantity_sold` STRING COMMENT 'Number of units sold on this transaction line. Positive for sales, negative for returns/voids. Core metric for sell-through rate (STR), weeks of supply (WOS), and inventory depletion analytics. Aligns with TRANSACTION_LINE role LINE_QUANTITY category.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record in the Silver layer, reflecting corrections, late-arriving data, or restatements from the source system. Supports data quality monitoring and change data capture.',
    `register_code` STRING COMMENT 'Identifier of the POS register or terminal where this transaction line was processed. Used for register-level reconciliation, shrinkage investigation, and store operations auditing.',
    `return_reason_code` STRING COMMENT 'Code indicating the reason for a product return when line_type is RETURN or EXCHANGE (e.g., DEFECTIVE, WRONG_SIZE, CHANGED_MIND, DAMAGED). Null for non-return lines. Used for quality analysis, vendor chargebacks, and after-sales service reporting. [ENUM-REF-CANDIDATE: DEFECTIVE|WRONG_SIZE|CHANGED_MIND|DAMAGED|WRONG_ITEM|NOT_AS_DESCRIBED|OTHER — promote to reference product]',
    `season_code` STRING COMMENT 'Season identifier for the collection to which the sold SKU belongs (e.g., SS25, FW24, HO24). Used for season-level sell-through rate (STR) tracking, end-of-season markdown analysis, and collection performance reporting.',
    `size_code` STRING COMMENT 'Size designation of the SKU sold (e.g., XS, S, M, L, XL, 32x30, 8.5). Enables size-curve analytics, size-level STR reporting, and replenishment decisions at the store-SKU-size grain.',
    `source_system_line_reference` STRING COMMENT 'The native transaction line identifier from the source system (SAP Customer Activity Repository). Preserves the original system reference for data lineage, reconciliation, and audit trail purposes in the Silver layer.',
    `style_number` STRING COMMENT 'The style-level identifier for the product sold, representing the design without colorway or size differentiation. Enables style-level sell-through rate (STR) and performance analytics across colorways and sizes.',
    `subclass_code` STRING COMMENT 'Merchandise subclass code providing the most granular merchandise hierarchy classification below class (e.g., T-SHIRTS, DENIM, RUNNING_SHOES). Enables fine-grained assortment analytics and category management reporting.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Sales tax amount applied to this line item based on the applicable tax jurisdiction and product tax classification. Required for financial reconciliation, tax reporting, and COGS analysis.',
    `transaction_date` DATE COMMENT 'Calendar date on which the POS transaction occurred. Primary grain dimension for daily sales reconciliation, STR reporting, and store performance KPI dashboards.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Precise date and time when the POS transaction line was processed at the register. Used for intraday traffic analytics, peak hour analysis, and time-of-day sales pattern reporting.',
    `unit_retail_price` DECIMAL(18,2) COMMENT 'The actual retail price charged per unit on this line after all markdowns and promotions have been applied. Represents the AUR (Average Unit Retail) at the transaction level. Core input for ASP and AUR analytics. Aligns with TRANSACTION_LINE role LINE_VALUE_OR_RESULT category.',
    `upc` STRING COMMENT 'Universal Product Code (UPC) barcode value scanned at the POS terminal for this line item. 12-digit UPC-A or 14-digit GTIN standard. Used for item identification, inventory reconciliation, and RFID-based shrinkage tracking.. Valid values are `^[0-9]{12,14}$`',
    CONSTRAINT pk_pos_transaction_line PRIMARY KEY(`pos_transaction_line_id`)
) COMMENT 'Individual line-item detail within a POS transaction. Records SKU, UPC, style, colorway, size, quantity sold, unit retail price (AUR), markdown amount, IMU, MMU, COGS, and line-level discount reason. Enables STR, ASP, and AUR analytics at the SKU-store-day grain. Sourced from SAP Customer Activity Repository.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` (
    `daily_sales_summary_id` BIGINT COMMENT 'Unique surrogate identifier for each daily sales summary record. Primary key for the daily_sales_summary data product in the store domain.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Daily summaries aggregate campaign-driven sales for executive dashboards and weekly business reviews. Standard metric in retail: "sales by campaign by store by day" for performance tracking and budget',
    `fiscal_week_id` BIGINT COMMENT 'Foreign key linking to store.fiscal_week. Business justification: Daily sales summaries are aggregated and reported by fiscal week. Currently daily_sales_summary has fiscal_week (INT), fiscal_period (INT), and fiscal_year (INT) as denormalized attributes. Adding fis',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Daily sales summaries post to GL as journal entries for revenue recognition and cash reconciliation. Standard retail accounting practice; enables audit trail from store operations to financial stateme',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Store managers/supervisors reconcile daily sales to resolve variances between POS totals and physical cash/card settlements. Critical audit trail for financial controls, loss prevention investigations',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store for which this daily sales summary was generated. Links to the store master record.',
    `adjustment_reason` STRING COMMENT 'Reason code for any post-close adjustment applied to this daily sales summary. Only populated when is_adjusted = True. Used for audit trail and financial control reporting. [ENUM-REF-CANDIDATE: system_correction|manual_override|return_reclass|shrinkage_update|tax_correction|other — promote to reference product]. Valid values are `system_correction|manual_override|return_reclass|shrinkage_update|tax_correction|other`',
    `asp` DECIMAL(18,2) COMMENT 'Average selling price (ASP) per transaction on the business date, calculated as net sales amount divided by transaction count. Distinct from AUR which is per unit; ASP reflects basket-level pricing performance.',
    `aur` DECIMAL(18,2) COMMENT 'Average unit retail (AUR) price achieved on the business date, calculated as net sales amount divided by net units sold. Key KPI for pricing effectiveness and markdown impact analysis in apparel retail.',
    `bopis_order_count` STRING COMMENT 'Number of buy-online-pick-up-in-store (BOPIS) orders fulfilled at this store on the business date. Key omnichannel fulfillment metric used to assess store capacity utilization and DTC channel performance.',
    `business_date` DATE COMMENT 'The retail business date (trading day) for which this end-of-day sales summary applies. Represents the fiscal trading day, which may differ from the calendar date for overnight operations.',
    `card_tender_amount` DECIMAL(18,2) COMMENT 'Total sales amount tendered via credit or debit card on the business date. Reconciled against card processor settlement reports as part of daily sales reconciliation. Includes all card network types (Visa, Mastercard, Amex, etc.).',
    `cash_tender_amount` DECIMAL(18,2) COMMENT 'Total sales amount tendered in cash on the business date. Used for daily cash reconciliation, safe count verification, and bank deposit preparation as part of end-of-day store close procedures.',
    `closing_inventory_units` STRING COMMENT 'Total on-hand inventory unit count at the end of the business date after all sales, returns, receipts, and adjustments. Used for weeks-of-supply (WOS) calculation and next-day opening inventory.',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Percentage of customer visits that resulted in a completed purchase transaction on the business date (transaction count / customer traffic count), expressed as a decimal. Key store performance KPI for associate effectiveness and visual merchandising impact.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this daily sales summary record was first created in the data platform. Represents the audit trail creation event for data lineage and compliance purposes.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this daily sales summary record (e.g., USD, EUR, GBP). Supports multi-currency store operations in international markets.. Valid values are `^[A-Z]{3}$`',
    `customer_traffic_count` STRING COMMENT 'Total number of customer visits (door count) recorded at the store on the business date via traffic counting systems. Used to calculate conversion rate (transaction count / traffic count) as a store performance KPI.',
    `digital_tender_amount` DECIMAL(18,2) COMMENT 'Total sales amount tendered via digital payment methods (mobile wallets, gift cards, buy-now-pay-later, loyalty points redemption) on the business date. Tracked separately for digital payment adoption analytics.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total value of employee discounts, loyalty program discounts, and coupon redemptions applied to transactions on the business date. Distinct from markdowns which are price-level changes; discounts are transaction-level adjustments.',
    `gift_card_tender_amount` DECIMAL(18,2) COMMENT 'Total sales amount tendered via gift cards on the business date. Tracked separately from other digital tenders for gift card liability reconciliation and breakage accounting per IFRS/GAAP deferred revenue standards.',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'Total gross sales revenue for the business date before deducting returns, markdowns, or discounts. Represents the sum of all POS transaction line amounts at full selling price prior to any adjustments.',
    `is_adjusted` BOOLEAN COMMENT 'Boolean flag indicating whether this daily sales summary record has been subject to a post-close adjustment (True). Adjusted records require additional audit scrutiny and are tracked for financial control compliance.',
    `is_reconciled` BOOLEAN COMMENT 'Boolean flag indicating whether the daily sales summary has been formally reconciled (True) or is still pending reconciliation (False). Used to filter confirmed records for financial reporting and OTB updates.',
    `markdown_amount` DECIMAL(18,2) COMMENT 'Total markdown (MD) dollar value applied to transactions on the business date, including permanent markdowns, promotional discounts, and clearance price reductions. Used for maintained markup (MMU) and gross margin analysis.',
    `net_sales_amount` DECIMAL(18,2) COMMENT 'Total net sales revenue for the business date after deducting returns and markdowns from gross sales. The primary revenue figure used for store performance reporting, OTB tracking, and STR calculation.',
    `opening_inventory_units` STRING COMMENT 'Total on-hand inventory unit count at the start of the business date (beginning of day). Used as the denominator for daily sell-through rate (STR) calculation and OTB tracking.',
    `pos_close_timestamp` TIMESTAMP COMMENT 'The exact date and time when the POS end-of-day close process was completed for this store on the business date. Represents the principal business event timestamp for this summary record. Sourced from SAP Customer Activity Repository daily close process.',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'The date and time when the daily sales summary was formally reconciled and approved by the store manager or back-office team. Distinct from POS close timestamp; represents the human-verified sign-off event.',
    `return_transaction_count` STRING COMMENT 'Total number of return transactions processed at the store on the business date. Used to calculate return rate and assess customer satisfaction and product quality issues.',
    `returns_amount` DECIMAL(18,2) COMMENT 'Total monetary value of customer merchandise returns processed at the store on the business date. Subtracted from gross sales to derive net sales. Sourced from SAP CAR return transaction aggregation.',
    `ship_from_store_order_count` STRING COMMENT 'Number of e-commerce orders fulfilled via ship-from-store on the business date. Reflects the stores contribution to omnichannel fulfillment and impacts available-to-sell (ATS) inventory levels.',
    `shrinkage_amount` DECIMAL(18,2) COMMENT 'Estimated or recorded shrinkage (inventory loss due to theft, damage, or administrative error) value for the business date. Used for loss prevention reporting and COGS adjustment. Sourced from cycle count variances and known loss events.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this daily sales summary was sourced (e.g., SAP_CAR for SAP Customer Activity Repository). Supports data lineage tracking in the Databricks Silver Layer.. Valid values are `SAP_CAR|SFCC|POS_LEGACY|MANUAL`',
    `store_number` STRING COMMENT 'The externally-known alphanumeric store identifier as assigned in the retail merchandising and POS systems (e.g., STR-0042). Used for cross-system reconciliation and reporting.',
    `str` DECIMAL(18,2) COMMENT 'Sell-through rate (STR) for the business date, expressed as a decimal (e.g., 0.0325 = 3.25%). Calculated as units sold divided by beginning-of-day on-hand inventory units. Used for inventory productivity and OTB management.',
    `summary_status` STRING COMMENT 'Current lifecycle status of the daily sales summary record. open indicates the trading day is in progress; pending_reconciliation indicates end-of-day close initiated; reconciled indicates cash and card tenders have been balanced; closed indicates the record is finalized; adjusted indicates a post-close correction was applied; voided indicates the record was invalidated. [ENUM-REF-CANDIDATE: open|pending_reconciliation|reconciled|closed|adjusted|voided — promote to reference product]. Valid values are `open|pending_reconciliation|reconciled|closed|adjusted|voided`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax collected on transactions for the business date. Required for tax remittance reporting and financial reconciliation. Varies by jurisdiction and product category per applicable tax regulations.',
    `transaction_count` STRING COMMENT 'Total number of completed POS sales transactions (excluding voids and returns) processed at the store on the business date. Used as the denominator for average order value (AOV) and average unit retail (AUR) calculations.',
    `units_per_transaction` DECIMAL(18,2) COMMENT 'Average number of units sold per sales transaction on the business date (units sold divided by transaction count). A key store productivity KPI used to measure associate selling effectiveness and cross-sell performance.',
    `units_returned` STRING COMMENT 'Total number of individual units returned by customers on the business date. Used to calculate gross units sold and return rate metrics for store performance analysis.',
    `units_sold` STRING COMMENT 'Total number of individual units (SKUs) sold on the business date, net of returns. Used for sell-through rate (STR) calculation, average unit retail (AUR) computation, and inventory depletion tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this daily sales summary record was last modified in the data platform. Captures post-close adjustments, corrections, or reconciliation updates for audit trail purposes.',
    `void_transaction_count` STRING COMMENT 'Total number of voided POS transactions on the business date. Elevated void counts may indicate training issues, fraud risk, or system errors and are monitored as part of loss prevention.',
    CONSTRAINT pk_daily_sales_summary PRIMARY KEY(`daily_sales_summary_id`)
) COMMENT 'End-of-day store-level sales reconciliation record capturing total net sales, gross sales, returns, markdowns, units sold, transaction count, AUR, ASP, STR, and cash/card/digital tender breakdown. Used for daily sales reconciliation, OTB tracking, and store performance reporting. Sourced from SAP Customer Activity Repository daily close process.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`traffic_count` (
    `traffic_count_id` BIGINT COMMENT 'Primary key for traffic_count',
    `fiscal_week_id` BIGINT COMMENT 'Foreign key linking to store.fiscal_week. Business justification: Traffic counts are analyzed by fiscal week for store performance reporting. Currently traffic_count has fiscal_week_code (BIGINT) which is a denormalized reference. Adding fiscal_week_id FK allows joi',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store where the traffic count was recorded. Links to the store master entity for store attributes such as name, location, and format.',
    `zone_id` BIGINT COMMENT 'Reference to the specific zone or area within the store where the traffic sensor is installed (e.g., entrance, fitting room corridor, footwear section). Enables zone-level traffic analysis for visual merchandising optimization.',
    `avg_dwell_time_seconds` STRING COMMENT 'Average time in seconds that customers spent inside the store or zone during the counting period, as measured by stereoscopic video analytics or thermal sensors. Indicates customer engagement depth and supports visual merchandising effectiveness analysis.',
    `bopis_order_count` STRING COMMENT 'Number of Buy Online Pick Up In Store (BOPIS) orders collected at the store during the counting period. Enables separation of omnichannel-driven traffic from organic walk-in traffic for pure conversion rate analysis.',
    `bounce_rate` DECIMAL(18,2) COMMENT 'Proportion of visitors who entered the store or zone but exited within a very short dwell threshold (typically under 30 seconds) without engaging, expressed as a decimal (e.g., 0.1500 = 15%). Indicates storefront or window display effectiveness.',
    `capture_rate` DECIMAL(18,2) COMMENT 'Ratio of store entries to total passing pedestrian traffic (entry_count ÷ passing_traffic_count), expressed as a decimal. Key metric for lease negotiation support and storefront effectiveness benchmarking.',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Ratio of POS transactions to total entry count (transactions ÷ entry_count) for the counting period, expressed as a decimal (e.g., 0.2500 = 25%). Core store performance KPI for traffic-to-sales effectiveness analysis.',
    `count_date` DATE COMMENT 'Calendar date on which the traffic count was recorded (yyyy-MM-dd). Used for daily aggregation, trend analysis, and lease negotiation reporting.',
    `count_direction` STRING COMMENT 'Indicates whether the sensor captures bidirectional traffic (both entries and exits), inbound only, or outbound only. Affects how entry_count and exit_count values should be interpreted.. Valid values are `bidirectional|inbound_only|outbound_only`',
    `count_hour` STRING COMMENT 'Hour of the day (0–23) for which this traffic count record applies. Enables hourly granularity for peak-hour staffing optimization and intraday traffic pattern analysis.',
    `count_period_type` STRING COMMENT 'Granularity of the traffic count record indicating whether the record represents an hourly, daily, weekly, or monthly aggregation. Supports multi-granularity reporting in the silver layer.. Valid values are `hourly|daily|weekly|monthly`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this traffic count record was first created in the silver layer lakehouse (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports data lineage, audit trail, and incremental load processing.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) representing the assessed quality and reliability of the traffic count record, based on sensor uptime, calibration status, and anomaly detection. Used to weight records in analytics and flag low-confidence data.',
    `day_of_week` STRING COMMENT 'Day of the week corresponding to the count_date. Used for weekly traffic pattern analysis, staffing models, and comparative performance reporting. [ENUM-REF-CANDIDATE: Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday — 7 candidates stripped; promote to reference product]',
    `entry_count` STRING COMMENT 'Total number of customer entries (inbound foot-traffic) recorded by the sensor during the counting period. Core traffic KPI used for store performance analysis, lease negotiation, and staffing optimization.',
    `exit_count` STRING COMMENT 'Total number of customer exits (outbound foot-traffic) recorded by the sensor during the counting period. Used alongside entry_count to calculate net occupancy and validate sensor accuracy.',
    `gap_filled_flag` BOOLEAN COMMENT 'Indicates whether any portion of the traffic count for this period was estimated or interpolated due to sensor downtime or data loss (True = gap-filled). Supports data lineage transparency and analytics confidence scoring.',
    `is_holiday` BOOLEAN COMMENT 'Indicates whether the count_date falls on a public or retail holiday (True = holiday). Enables holiday-adjusted traffic benchmarking and year-over-year comparable analysis.',
    `is_promotional_period` BOOLEAN COMMENT 'Indicates whether the counting period coincides with an active promotional or markdown event (True = promotional period). Enables traffic lift analysis attributable to marketing and promotional activities.',
    `is_store_open` BOOLEAN COMMENT 'Indicates whether the store was open for trading during the counting period (True = open). Used to exclude closed-period records from traffic KPI calculations and to identify after-hours sensor anomalies.',
    `max_occupancy_count` STRING COMMENT 'Peak simultaneous occupancy count recorded within the counting period, derived from cumulative entry minus exit counts. Used for compliance with fire safety occupancy limits and store capacity management.',
    `passing_traffic_count` STRING COMMENT 'Number of pedestrians passing in front of the store entrance without entering, as measured by external-facing sensors. Used to calculate store capture rate (entry_count ÷ passing_traffic_count) for lease negotiation and location performance benchmarking.',
    `peak_hour_flag` BOOLEAN COMMENT 'Indicates whether the counting period falls within a designated peak trading hour for the store (True = peak hour). Used for staffing optimization and scheduling decisions.',
    `period_end_timestamp` TIMESTAMP COMMENT 'Exact timestamp marking the end of the traffic counting period (yyyy-MM-ddTHH:mm:ss.SSSXXX). Together with period_start_timestamp defines the precise observation window.',
    `period_start_timestamp` TIMESTAMP COMMENT 'Exact timestamp marking the beginning of the traffic counting period (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for precise temporal alignment of hourly and sub-hourly records.',
    `record_status` STRING COMMENT 'Lifecycle status of the traffic count record indicating data quality state. active = validated sensor data; estimated = gap-filled via interpolation; adjusted = manually corrected; excluded = removed from KPI calculations; pending_review = flagged for data quality review.. Valid values are `active|estimated|adjusted|excluded|pending_review`',
    `sensor_code` BIGINT COMMENT 'Reference to the specific traffic counting sensor device that recorded this observation. Enables sensor-level data quality monitoring and calibration tracking.',
    `sensor_type` STRING COMMENT 'Technology type of the traffic counting sensor that generated this record. [ENUM-REF-CANDIDATE: ir_beam_break|stereoscopic_video|thermal|time_of_flight|wifi_bluetooth — promote to reference product]. Valid values are `ir_beam_break|stereoscopic_video|thermal|time_of_flight|wifi_bluetooth`',
    `sensor_uptime_pct` DECIMAL(18,2) COMMENT 'Percentage of the counting period during which the sensor was operational and recording valid data (0.00–100.00). Used to assess data completeness and determine whether gap-filling or estimation is required.',
    `ship_from_store_count` STRING COMMENT 'Number of ship-from-store fulfillment orders processed at the store during the counting period. Supports omnichannel fulfillment traffic analysis and store-as-warehouse capacity planning.',
    `source_record_reference` STRING COMMENT 'Native identifier of this traffic count record in the originating source system (e.g., SAP CAR internal record key). Enables traceability from the silver layer back to the bronze/raw layer for audit and reconciliation.',
    `source_system_code` STRING COMMENT 'Code identifying the operational source system from which this traffic count record was ingested (e.g., SAP_CAR, SENSORMATIC, IRISYS). Supports data lineage and multi-source reconciliation in the silver layer.',
    `staff_count_scheduled` STRING COMMENT 'Number of sales associates scheduled to be on the store floor during the counting period. Used to calculate traffic-to-staff ratio for staffing optimization and labor productivity analysis.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient outdoor temperature in degrees Celsius at the store location during the counting period. Used as a quantitative weather covariate in traffic regression models and seasonal demand planning.',
    `transaction_count` STRING COMMENT 'Number of Point of Sale (POS) transactions completed at the store during the same counting period. Used as the numerator in conversion rate calculation (transactions ÷ traffic). Sourced from SAP Customer Activity Repository.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this traffic count record was last modified in the silver layer lakehouse (yyyy-MM-ddTHH:mm:ss.SSSXXX). Tracks adjustments, corrections, and reprocessing events for data lineage.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition at the store location during the counting period. Used as an external factor in traffic variance analysis and demand forecasting models. [ENUM-REF-CANDIDATE: clear|cloudy|rain|snow|storm|extreme_heat — promote to reference product]. Valid values are `clear|cloudy|rain|snow|storm|extreme_heat`',
    `week_number` STRING COMMENT 'ISO calendar week number (1–53) of the count_date. Supports weekly traffic trend analysis and year-over-year comparisons aligned to the retail fiscal calendar.',
    CONSTRAINT pk_traffic_count PRIMARY KEY(`traffic_count_id`)
) COMMENT 'Captures customer foot-traffic counts at the store and zone level, recorded by traffic counting sensors (IR beam-break, stereoscopic video analytics, thermal). Stores hourly and daily entry counts, conversion rate (transactions ÷ traffic), dwell-time metrics, and bounce rate. Enables store performance KPI analysis including traffic-to-conversion ratios, peak-hour staffing optimization, and lease negotiation support (traffic as rent justification). Conforms to retail traffic analytics industry standards.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`associate` (
    `associate_id` BIGINT COMMENT 'Primary key for associate',
    `employee_id` BIGINT COMMENT 'Cross-reference to the workforce domain employee master record (Workday HCM). Enables linkage between store-operational assignment context and HR/payroll data without duplicating the employee master.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_initiative. Business justification: Store associates participate in sustainability initiatives (waste sorting, energy conservation, circular program ambassadors, customer education). HR and sustainability teams track associate participa',
    `org_unit_id` BIGINT COMMENT 'Reference to the store department (e.g., Footwear, Apparel, Accessories, Fitting Room) to which the associate is assigned for floor coverage and commission attribution.',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store to which this associate is currently assigned. Used for store-level POS attribution, scheduling, and performance reporting.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the associates store assignment. Controls POS login eligibility, scheduling inclusion, and commission accrual. transferred indicates the associate has moved to another store.. Valid values are `active|on_leave|suspended|terminated|transferred`',
    `associate_number` STRING COMMENT 'Externally-known alphanumeric business identifier for the associate, used on POS terminals, scheduling systems, and commission reports. Sourced from SAP Customer Activity Repository operator configuration.. Valid values are `^ASC-[A-Z0-9]{6,12}$`',
    `bopis_fulfillment_enabled` BOOLEAN COMMENT 'Indicates whether the associate is authorized and trained to fulfill Buy Online Pick Up In Store (BOPIS) orders. Supports omnichannel fulfillment assignment in Salesforce Commerce Cloud and SAP Customer Activity Repository.',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether the associate is eligible to earn sales commission. Eligibility is determined by store role, employment type, and department assignment per the compensation policy.',
    `commission_plan_code` STRING COMMENT 'Code identifying the commission plan structure assigned to the associate (e.g., tiered, flat-rate, department-specific). References the commission plan configuration in SAP Customer Activity Repository.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Individual commission rate applied to the associates attributed net sales, expressed as a decimal (e.g., 0.0250 = 2.50%). Used for commission accrual calculations in SAP FI/CO. Confidential compensation data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the store associate record was first created in the Silver Layer data product. Audit trail field for data lineage and compliance purposes.',
    `employment_type` STRING COMMENT 'Classification of the associates employment arrangement. Determines scheduling eligibility, benefit entitlements, and labor cost categorization. Sourced from Workday HCM worker type.. Valid values are `full_time|part_time|seasonal|temporary|contractor`',
    `first_name` STRING COMMENT 'Legal given name of the store associate as recorded in Workday HCM. Used for scheduling displays, POS operator identification, and customer-facing name badges.',
    `hire_date` DATE COMMENT 'Date the associate was originally hired by the company. Used for tenure calculations, anniversary recognition, and benefit eligibility determination. Sourced from Workday HCM.',
    `keyholder_flag` BOOLEAN COMMENT 'Indicates whether the associate holds store key access and is authorized to open or close the store. Keyholders have elevated POS and alarm system permissions.',
    `language_code` STRING COMMENT 'Primary language spoken by the associate, expressed as an IETF BCP 47 language tag (e.g., en-US, es-MX, fr-FR). Used for customer service routing and multilingual store staffing analytics.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_name` STRING COMMENT 'Legal family name of the store associate as recorded in Workday HCM. Combined with first_name for full identity display on POS, commission statements, and performance reports.',
    `last_performance_review_date` DATE COMMENT 'Date of the associates most recent formal performance review. Used to track review cycle compliance and identify associates overdue for evaluation.',
    `loss_prevention_flag` BOOLEAN COMMENT 'Indicates whether the associate has an active loss prevention alert or investigation flag. Confidential — access restricted to store management and loss prevention teams. Used for shrinkage management.',
    `nps_score_avg` DECIMAL(18,2) COMMENT 'Average Net Promoter Score (NPS) received by the associate from customer satisfaction surveys attributed to their POS transactions. Ranges from -100 to 100. Used for associate-level service quality monitoring.',
    `performance_rating` STRING COMMENT 'Most recent formal performance rating assigned to the associate during the annual or mid-year review cycle. Confidential HR data used for promotion eligibility, commission tier adjustments, and workforce planning.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `pos_login_enabled` BOOLEAN COMMENT 'Indicates whether the associate is currently authorized to log in to POS terminals. Set to false during suspension, leave, or post-termination to prevent unauthorized transactions.',
    `pos_operator_code` STRING COMMENT 'Short alphanumeric code used to identify the associate on POS terminals for transaction attribution, cash drawer assignment, and sales performance tracking. Configured in SAP Customer Activity Repository.. Valid values are `^[A-Z0-9]{4,10}$`',
    `preferred_name` STRING COMMENT 'Preferred or commonly-used name of the associate for scheduling boards, name badges, and internal communications. May differ from legal first name.',
    `primary_department_code` STRING COMMENT 'Alphanumeric code identifying the associates primary assigned department within the store (e.g., FTWR for Footwear, APRL for Apparel). Used for floor coverage planning and department-level sales attribution.',
    `product_knowledge_tier` STRING COMMENT 'Certified level of product knowledge attained by the associate across the brands apparel, footwear, and accessories categories. Drives assignment to high-value customer interactions and specialist floor zones.. Valid values are `basic|intermediate|advanced|expert`',
    `rfid_badge_code` STRING COMMENT 'Unique RFID chip identifier embedded in the associates access badge. Used for store entry/exit access control, time and attendance tracking, and loss prevention audit trails.. Valid values are `^[A-F0-9]{8,24}$`',
    `sales_floor_zone` STRING COMMENT 'Designated zone or area of the sales floor to which the associate is assigned (e.g., Front-of-House, Back Wall, Fitting Room, Cash Wrap). Supports visual merchandising coverage and traffic analytics.',
    `scheduled_hours_per_week` DECIMAL(18,2) COMMENT 'Standard contracted or scheduled weekly hours for the associate. Used for labor cost planning, overtime threshold monitoring, and workforce scheduling in the store operations context.',
    `secondary_department_code` STRING COMMENT 'Code for a secondary department the associate is cross-trained to cover. Enables flexible floor scheduling and cross-department sales attribution during peak periods.',
    `ship_from_store_enabled` BOOLEAN COMMENT 'Indicates whether the associate is authorized to process ship-from-store fulfillment orders, including picking, packing, and carrier handoff. Supports omnichannel DTC fulfillment operations.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this associate record was sourced (e.g., SAP_CAR for SAP Customer Activity Repository, WORKDAY_HCM for Workday HCM). Supports data lineage and reconciliation.. Valid values are `SAP_CAR|WORKDAY_HCM|MANUAL`',
    `store_assignment_end_date` DATE COMMENT 'Date the associates assignment to the current store ended due to transfer, termination, or leave. Null if the assignment is currently active. Enables historical store assignment tracking.',
    `store_assignment_start_date` DATE COMMENT 'Date the associate was assigned to the current store. Distinct from hire_date — an associate may transfer between stores. Used for store-level tenure and performance benchmarking.',
    `store_role` STRING COMMENT 'Operational role of the associate within the retail store context. Drives POS operator permissions, commission tier eligibility, scheduling authority, and floor coverage responsibilities. Distinct from HR job title in Workday HCM.. Valid values are `sales_associate|keyholder|department_lead|assistant_manager|store_manager`',
    `termination_date` DATE COMMENT 'Date the associates employment was formally terminated. Null for active employees. Used for access revocation, final commission settlement, and workforce analytics.',
    `training_completion_date` DATE COMMENT 'Date the associate completed mandatory onboarding and product training for their current store role. Used to confirm readiness for floor assignment and POS activation.',
    `uniform_size_bottom` STRING COMMENT 'Apparel size for the associates uniform bottom garment. Used by store operations for uniform inventory management and replenishment ordering.. Valid values are `XS|S|M|L|XL|XXL`',
    `uniform_size_top` STRING COMMENT 'Apparel size for the associates uniform top garment. Used by store operations for uniform inventory management and replenishment ordering.. Valid values are `XS|S|M|L|XL|XXL`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the store associate record in the Silver Layer. Used for change data capture, incremental processing, and audit trail compliance.',
    `work_email` STRING COMMENT 'Corporate email address assigned to the associate for internal communications, scheduling notifications, and system access. Sourced from Workday HCM.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_phone` STRING COMMENT 'Work or store-assigned phone number for the associate, used for scheduling contact and store operations communication.',
    CONSTRAINT pk_associate PRIMARY KEY(`associate_id`)
) COMMENT 'Store-domain view of sales associates and floor staff assigned to a retail store. Captures associate role (sales associate, keyholder, department lead, store manager), assigned store, department, employment type, hire date, and active status. Distinct from the workforce domain employee master — this entity tracks store-operational assignment and role context for POS attribution, commission, and scheduling purposes.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`shift` (
    `shift_id` BIGINT COMMENT 'Primary key for shift',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Labor costs by shift must allocate to cost centers for accurate departmental expense tracking. Essential for labor budget management, productivity analysis, and store-level profitability. Shift-level ',
    `employee_id` BIGINT COMMENT 'Reference to the store supervisor or manager responsible for overseeing this shift. Used for escalation, override authorization, and shift performance accountability.',
    `payroll_run_id` BIGINT COMMENT 'Identifier for the payroll period to which this shifts hours are attributed (e.g., PP-2024-26 for the 26th pay period of 2024). Used to batch shift records for payroll export to Workday HCM.. Valid values are `^PP-[0-9]{4}-[0-9]{2}$`',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store where this shift is assigned. Links to the store master record in SAP Customer Activity Repository.',
    `associate_id` BIGINT COMMENT 'Reference to the store associate (employee) assigned to this shift. Sourced from Workday HCM employee master.',
    `shift_covering_associate_id` BIGINT COMMENT 'Reference to the associate who covered this shift in the event of a no-show, swap, or emergency absence. Null if no coverage was arranged. Supports shift swap tracking and labor scheduling analytics.',
    `shift_original_associate_id` BIGINT COMMENT 'Reference to the associate originally scheduled for this shift before a swap or reassignment occurred. Populated only when shift_swap_flag is True. Enables full audit trail of schedule changes.',
    `position_id` BIGINT COMMENT 'External position identifier from Workday HCM corresponding to the associates role at the time of the shift. Used for payroll integration and labor cost allocation.',
    `absence_reason_code` STRING COMMENT 'Standardized code indicating the reason for a no-show or partial absence (e.g., sick leave, personal leave, emergency, unauthorized). Populated when no_show_flag is True or shift is cancelled. [ENUM-REF-CANDIDATE: sick_leave|personal_leave|emergency|unauthorized|bereavement|jury_duty|weather — promote to reference product]',
    `actual_break_minutes` STRING COMMENT 'Total actual break time taken by the associate in minutes as recorded by the time and attendance system. Compared against scheduled break duration for compliance and payroll accuracy.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours the associate actually worked during the shift, computed from clock-in/clock-out minus break durations. Used for payroll processing, overtime calculation, and labor productivity KPIs.',
    `break_duration_minutes` STRING COMMENT 'Total scheduled break time in minutes for the shift (sum of all meal and rest breaks). Used to compute net hours worked and ensure compliance with labor rest-period regulations.',
    `clock_in_method` STRING COMMENT 'Method used by the associate to record their clock-in time (e.g., POS terminal, mobile app, biometric scanner, RFID badge, manager manual entry). Supports time and attendance audit and fraud detection.. Valid values are `pos_terminal|mobile_app|biometric|manager_entry|rfid`',
    `clock_in_time` TIMESTAMP COMMENT 'Actual date and time the associate clocked in for the shift as recorded by the time and attendance system. Null if the associate has not yet clocked in or was a no-show.',
    `clock_out_method` STRING COMMENT 'Method used by the associate to record their clock-out time. Mirrors clock_in_method for symmetry and audit completeness.. Valid values are `pos_terminal|mobile_app|biometric|manager_entry|rfid`',
    `clock_out_time` TIMESTAMP COMMENT 'Actual date and time the associate clocked out at the end of the shift. Null if the shift is still in progress or the associate did not clock out (requires manager resolution).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this shift record was first created in the system, either by the scheduling system or manually by a manager. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the labor cost amount (e.g., USD, EUR, GBP). Supports multi-currency store operations in international markets.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Store department or zone to which the associate is assigned during this shift (e.g., Menswear, Footwear, Accessories, Stockroom, Checkout). Used for labor allocation reporting and department-level productivity analysis.',
    `early_departure_flag` BOOLEAN COMMENT 'Indicates whether the associate clocked out before the scheduled end time. True = early departure occurred. Used for attendance tracking and SLA compliance in store staffing.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Estimated or actual labor cost for this shift in the stores operating currency, computed from actual hours worked multiplied by the applicable pay rate. Used for store-level labor cost reporting and GMROI analysis.',
    `manager_override_flag` BOOLEAN COMMENT 'Indicates whether a store manager manually overrode the clock-in, clock-out, or break time for this shift record. True = override applied; False = no override. Triggers additional audit review in payroll processing.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the associate failed to appear for a scheduled shift without prior notification. True = no-show recorded. Feeds into attendance management and disciplinary workflows in Workday HCM.',
    `omnichannel_fulfillment_flag` BOOLEAN COMMENT 'Indicates whether the associates role during this shift includes omnichannel fulfillment duties such as BOPIS (Buy Online Pick Up In Store) or ship-from-store. True = omnichannel duties assigned. Used for labor allocation and fulfillment capacity planning.',
    `override_reason` STRING COMMENT 'Free-text or coded reason provided by the manager when a shift time override is applied (e.g., system outage, forgotten clock-out, emergency). Required when manager_override_flag is True.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours worked beyond the standard shift threshold that qualify for overtime pay, as determined by applicable labor regulations and the associates employment contract. Feeds directly into Workday HCM payroll processing.',
    `pay_rate_code` STRING COMMENT 'Code identifying the pay rate tier applicable to this shift (e.g., standard, overtime, holiday, training). References the compensation rate table in Workday HCM. Classified confidential as it reveals compensation structure.',
    `payroll_export_flag` BOOLEAN COMMENT 'Indicates whether this shift record has been successfully exported to Workday HCM for payroll processing. True = exported; False = pending export. Used to prevent duplicate payroll submissions.',
    `payroll_export_timestamp` TIMESTAMP COMMENT 'Date and time when this shift record was exported to Workday HCM for payroll processing. Null if payroll_export_flag is False. Supports payroll reconciliation and audit.',
    `role_during_shift` STRING COMMENT 'The operational role the associate performs during this specific shift (e.g., Sales Associate, Cashier, Floor Supervisor, Stock Associate, Visual Merchandiser, BOPIS Fulfillment). May differ from the associates primary job title. [ENUM-REF-CANDIDATE: sales_associate|cashier|floor_supervisor|stock_associate|visual_merchandiser|bopis_fulfillment|keyholder|manager_on_duty — promote to reference product]',
    `schedule_adherence_minutes` STRING COMMENT 'Variance in minutes between the scheduled start time and actual clock-in time. Positive value = late arrival; negative value = early arrival. Used for store operations KPI reporting and associate performance management.',
    `schedule_source` STRING COMMENT 'Indicates the origin of the shift schedule record — whether generated automatically by Workday HCM scheduling, entered manually by a manager, or adjusted post-generation. Supports audit and schedule quality analysis.. Valid values are `workday|manual|auto_generated|manager_adjusted`',
    `scheduled_end_time` TIMESTAMP COMMENT 'The planned end date and time of the shift as defined in the labor scheduling system. Used to compute scheduled shift duration and planned labor cost.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Total number of hours the associate is scheduled to work for this shift, derived from scheduled start and end times minus planned break duration. Stored explicitly for scheduling and OTB labor budget comparisons.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The planned start date and time of the shift as defined in the labor scheduling system. Used to measure schedule adherence and compute planned labor hours.',
    `shift_date` DATE COMMENT 'The calendar date on which the shift is scheduled or occurred. Used as the primary business date for labor scheduling, daily sales reconciliation, and store performance reporting.',
    `shift_number` STRING COMMENT 'Human-readable business identifier for the shift record, used in scheduling systems, payroll exports, and store operations reporting. Format: SHF-YYYYMMDD-NNNNNN.. Valid values are `^SHF-[0-9]{8}-[0-9]{6}$`',
    `shift_status` STRING COMMENT 'Current lifecycle state of the shift record. scheduled = future shift confirmed; in_progress = associate currently clocked in; completed = shift ended and reconciled; cancelled = shift removed before start; no_show = associate did not clock in for a scheduled shift.. Valid values are `scheduled|in_progress|completed|cancelled|no_show`',
    `shift_type` STRING COMMENT 'Classification of the shift for labor scheduling and payroll purposes. Drives overtime eligibility, holiday pay rates, and training hour tracking. [ENUM-REF-CANDIDATE: regular|overtime|on_call|split|holiday|training — promote to reference product if additional types are needed]. Valid values are `regular|overtime|on_call|split|holiday|training`',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this shift record was ingested (SAP Customer Activity Repository, Workday HCM, or manual entry). Supports data lineage and reconciliation in the Silver layer.. Valid values are `SAP_CAR|WORKDAY|MANUAL`',
    `swap_flag` BOOLEAN COMMENT 'Indicates whether this shift was the result of a shift swap between two associates. True = shift was swapped. Used to track schedule changes and ensure proper payroll attribution.',
    `training_shift_flag` BOOLEAN COMMENT 'Indicates whether this shift is designated as a training shift where the associate is undergoing onboarding, product knowledge training, or compliance training rather than performing standard operational duties.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this shift record was last modified, including clock-in/out updates, manager overrides, or status changes. Used for change data capture (CDC) in the Silver layer pipeline.',
    CONSTRAINT pk_shift PRIMARY KEY(`shift_id`)
) COMMENT 'Records scheduled and actual work shifts for store associates, including shift date, start/end times, actual clock-in/out, break durations, role during shift, and store assignment. Supports labor scheduling, overtime tracking, and payroll integration with Workday HCM. Distinct from workforce payroll — this entity is the store-operational shift record.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`bopis_order` (
    `bopis_order_id` BIGINT COMMENT 'Unique identifier for the BOPIS order fulfillment record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: BOPIS orders result from digital marketing campaigns (email, social, paid search). Attribution critical for omnichannel campaign measurement: understanding which campaigns drive online-to-offline conv',
    `cart_id` BIGINT COMMENT 'Foreign key linking to ecommerce.cart. Business justification: BOPIS orders originate from online shopping carts; linking enables cart-to-pickup conversion analysis, abandoned cart recovery for in-store pickup, and omnichannel funnel optimization critical to buy-',
    `digital_order_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_order. Business justification: BOPIS fulfillment is the store-side execution of a digital order; this link is essential for end-to-end omnichannel order lifecycle tracking, SLA monitoring, and reconciling digital order status with ',
    `associate_id` BIGINT COMMENT 'Reference to the store associate who picked the items for this BOPIS order.',
    `profile_id` BIGINT COMMENT 'Reference to the customer who placed the BOPIS order.',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store assigned to fulfill this BOPIS order.',
    `sales_order_id` BIGINT COMMENT 'Reference to the originating sales order from the order domain that this BOPIS fulfillment is assigned to.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: BOPIS fulfillment may prioritize inventory from specific production lots for quality consistency, recall management, or to clear aging inventory from particular factory runs—supports lot-level invento',
    `assigned_timestamp` TIMESTAMP COMMENT 'The date and time when the BOPIS order was assigned to the fulfilling store.',
    `cancellation_notes` STRING COMMENT 'Free-text notes providing additional context about the BOPIS order cancellation.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason why the BOPIS order was cancelled.. Valid values are `customer_request|inventory_unavailable|expired|damaged_items|store_closure|system_error`',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The date and time when the BOPIS order was cancelled, either by customer request, store action, or system expiry.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this BOPIS order record was first created in the system. Audit trail field.',
    `curbside_flag` BOOLEAN COMMENT 'Indicates whether the customer requested curbside pickup service for this BOPIS order.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order total amount.. Valid values are `^[A-Z]{3}$`',
    `customer_notified_timestamp` TIMESTAMP COMMENT 'The date and time when the customer was notified that their BOPIS order is ready for pickup.',
    `expiry_timestamp` TIMESTAMP COMMENT 'The date and time when the BOPIS order will expire if not picked up. Typically set based on store policy (e.g., 3-7 days after ready notification).',
    `fulfillment_status` STRING COMMENT 'Current lifecycle status of the BOPIS order fulfillment workflow. Tracks progression from assignment through pickup or cancellation. [ENUM-REF-CANDIDATE: assigned|picking|picked|ready_for_pickup|picked_up|cancelled|expired — 7 candidates stripped; promote to reference product]',
    `item_count` STRING COMMENT 'Total number of distinct items (SKUs) included in this BOPIS order.',
    `notification_method` STRING COMMENT 'The communication channel used to notify the customer that their order is ready for pickup.. Valid values are `email|sms|push_notification|phone_call`',
    `order_number` STRING COMMENT 'Human-readable business identifier for the originating sales order. Used for customer communication and operational tracking.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'The date and time when the customer placed the original online order. Principal business event timestamp.',
    `order_total_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the BOPIS order including all items, taxes, and fees.',
    `pick_complete_timestamp` TIMESTAMP COMMENT 'The date and time when all items for this BOPIS order were successfully picked and staged.',
    `pick_start_timestamp` TIMESTAMP COMMENT 'The date and time when the store associate began picking items for this BOPIS order.',
    `pickup_location_type` STRING COMMENT 'The type of pickup location within or near the store where the customer will collect their order.. Valid values are `store_counter|curbside|locker|designated_area`',
    `pickup_timestamp` TIMESTAMP COMMENT 'The date and time when the customer picked up the BOPIS order from the store.',
    `pickup_verification_method` STRING COMMENT 'The method used to verify customer identity and authorize order handoff at pickup.. Valid values are `order_number|barcode_scan|qr_code|photo_id|email_confirmation`',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether this BOPIS order has been marked as priority for expedited fulfillment (e.g., VIP customer, urgent request).',
    `ready_for_pickup_timestamp` TIMESTAMP COMMENT 'The date and time when the BOPIS order was marked ready for customer pickup and customer notification was triggered.',
    `sla_actual_minutes` STRING COMMENT 'The actual number of minutes elapsed from order assignment to ready-for-pickup status. Used for SLA compliance tracking.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the BOPIS order fulfillment met the defined SLA target time. True if actual time is less than or equal to target time.',
    `sla_target_minutes` STRING COMMENT 'The target number of minutes from order assignment to ready-for-pickup status, as defined by store operations policy.',
    `special_instructions` STRING COMMENT 'Free-text special instructions or notes from the customer regarding pickup preferences or requirements.',
    `unit_count` STRING COMMENT 'Total number of units (quantity across all items) included in this BOPIS order.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this BOPIS order record was last modified. Audit trail field.',
    `vehicle_description` STRING COMMENT 'Description of the customers vehicle (make, model, color) for curbside pickup identification.',
    CONSTRAINT pk_bopis_order PRIMARY KEY(`bopis_order_id`)
) COMMENT 'Manages Buy Online Pick Up In Store (BOPIS) fulfillment orders assigned to a specific retail store. Captures order reference (from order domain), assigned store, pick status, pick associate, ready-for-pickup timestamp, customer notification status, pickup confirmation, and expiry/cancellation details. Enables omnichannel fulfillment SLA tracking.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` (
    `ship_from_store_id` BIGINT COMMENT 'Unique surrogate identifier for each ship-from-store fulfillment record in the Silver layer lakehouse. Primary key for this entity. Role: TRANSACTION_HEADER.',
    `associate_id` BIGINT COMMENT 'Reference to the store sales associate or fulfillment associate assigned to pick and pack this ship-from-store order. Links to the workforce/employee master in Workday HCM. [PARTY_REFERENCE category]',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Ship-from-store fulfillment driven by ecommerce campaigns. Tracking this link measures campaign impact on store-fulfilled digital orders, critical for distributed order management and omnichannel prof',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Ship-from-store fulfillment generates Scope 3 Category 9 (downstream transportation) emissions. Sustainability teams calculate emissions per shipment using carrier, distance, and weight data for carbo',
    `digital_order_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_order. Business justification: Ship-from-store fulfillment executes digital orders using store inventory; critical for distributed order management, store-as-warehouse operations, and reconciling digital order promises with actual ',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store acting as the fulfillment mini-distribution center for this ship-from-store request. Links to the store master record in SAP Customer Activity Repository.',
    `sales_order_id` BIGINT COMMENT 'Reference to the originating sales order (e-commerce or wholesale) that triggered this ship-from-store fulfillment request. Links to the order management system record in Salesforce Commerce Cloud or SAP S/4HANA SD.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Ship-from-store fulfillment creates outbound logistics shipments that must be tracked for carrier handoff, delivery status, OTIF compliance, and customer service inquiries. Core omnichannel fulfillmen',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU (Stock Keeping Unit) being fulfilled in this ship-from-store request. Represents the sellable unit at the color/size level as managed in the product master.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Ship-from-store operations track production origin for quality traceability, lot-level inventory management, and recall coordination—ensures customers receive consistent quality and enables targeted r',
    `business_date` DATE COMMENT 'The retail business date on which this ship-from-store fulfillment request was processed, aligned to the stores fiscal calendar. Used for daily sales reconciliation, store-level STR (Sell-Through Rate) reporting, and OTB (Open-to-Buy) budget tracking.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason a ship-from-store fulfillment request was cancelled. Used for root cause analysis, store capacity management, and inventory accuracy improvement initiatives.. Valid values are `OUT_OF_STOCK|CUSTOMER_REQUEST|FRAUD|DUPLICATE|STORE_CAPACITY|SYSTEM_ERROR`',
    `carrier_code` STRING COMMENT 'Standardized code identifying the parcel carrier used to ship the order from the store to the customer or destination. Used for carrier performance analytics and 3PL (Third-Party Logistics) cost allocation.. Valid values are `UPS|FEDEX|USPS|DHL|ONTRAC|LSO`',
    `carrier_service_level` STRING COMMENT 'The shipping service tier selected for this fulfillment (e.g., ground, 2-day, overnight). Drives carrier cost, delivery promise, and customer experience SLA compliance reporting.. Valid values are `GROUND|2DAY|OVERNIGHT|PRIORITY|ECONOMY|SAME_DAY`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ship-from-store record was first captured in the data platform. Used for data lineage, audit trail, and Silver layer ingestion tracking. [RECORD_AUDIT_CREATED category]',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this record (shipping_cost_amount, retail_value_amount). Supports multi-currency operations across international retail markets.. Valid values are `^[A-Z]{3}$`',
    `destination_address_line1` STRING COMMENT 'Primary street address line of the shipment destination (customer delivery address or alternate store). Classified as restricted PII per GDPR Article 4 and CCPA as it identifies the customers physical location.',
    `destination_city` STRING COMMENT 'City of the shipment destination address. Used for carrier zone determination, delivery time estimation, and geographic fulfillment analytics. Classified as restricted PII as part of the customer delivery address.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the shipment destination. Used for international shipping compliance, customs documentation, and cross-border fulfillment analytics.. Valid values are `^[A-Z]{3}$`',
    `destination_postal_code` STRING COMMENT 'Postal or ZIP code of the shipment destination. Used for carrier zone calculation, delivery time estimation, and geographic demand analytics. Classified as restricted PII as part of the customer delivery address.',
    `destination_state_code` STRING COMMENT 'Two-letter ISO 3166-2 state or province code of the shipment destination. Used for carrier zone mapping, tax jurisdiction determination, and regional fulfillment performance analytics.. Valid values are `^[A-Z]{2}$`',
    `exception_code` STRING COMMENT 'Standardized code capturing the type of exception encountered during the ship-from-store fulfillment process. Used for exception management workflows, store associate coaching, and process improvement analytics. [ENUM-REF-CANDIDATE: ITEM_NOT_FOUND|DAMAGED_ITEM|LABEL_FAILURE|CARRIER_PICKUP_MISSED|ADDRESS_INVALID|SYSTEM_TIMEOUT — promote to reference product]. Valid values are `ITEM_NOT_FOUND|DAMAGED_ITEM|LABEL_FAILURE|CARRIER_PICKUP_MISSED|ADDRESS_INVALID|SYSTEM_TIMEOUT`',
    `fulfillment_request_number` STRING COMMENT 'Externally-known business identifier for the ship-from-store fulfillment request, used for cross-system traceability across Salesforce Commerce Cloud, Manhattan Associates WMS, and SAP S/4HANA SD. Corresponds to the outbound delivery document number in WMS. [BUSINESS_IDENTIFIER category]. Valid values are `^SFS-[0-9]{10}$`',
    `fulfillment_status` STRING COMMENT 'Current lifecycle state of the ship-from-store fulfillment request, tracking progression from assignment through pick, pack, ship, and delivery. EXCEPTION indicates a fulfillment problem requiring intervention. [LIFECYCLE_STATUS category] [ENUM-REF-CANDIDATE: PENDING|ASSIGNED|PICKING|PACKED|SHIPPED|DELIVERED|CANCELLED|EXCEPTION — promote to reference product]',
    `fulfillment_type` STRING COMMENT 'Classification of the fulfillment channel that triggered this ship-from-store request. ECOM_DTC = Direct-to-Consumer e-commerce order; BOPIS = Buy Online Pick Up In Store; WHOLESALE = wholesale partner order; STORE_TRANSFER = inter-store inventory transfer; SHIP_TO_STORE = ship to alternate store for customer pickup. [CLASSIFICATION_OR_TYPE category]. Valid values are `ECOM_DTC|BOPIS|WHOLESALE|STORE_TRANSFER|SHIP_TO_STORE`',
    `in_full_flag` BOOLEAN COMMENT 'Indicates whether the shipped_quantity equals the ordered_quantity, confirming complete fulfillment. Enables decomposed OTIF analysis separating fullness from timeliness dimensions.',
    `notes` STRING COMMENT 'Free-text field for store associates or fulfillment managers to capture operational notes, exception details, or special handling instructions related to this ship-from-store request. Not used for structured analytics.',
    `on_time_flag` BOOLEAN COMMENT 'Indicates whether the order was shipped on or before the promised_ship_date, independent of quantity completeness. Enables decomposed OTIF analysis separating timeliness from fullness dimensions.',
    `ordered_quantity` STRING COMMENT 'The number of units of the SKU requested for fulfillment in this ship-from-store record. Represents the demand quantity as received from the originating sales order.',
    `otif_flag` BOOLEAN COMMENT 'Indicates whether this ship-from-store fulfillment met the OTIF (On Time In Full) standard — shipped on or before the promised_ship_date with the full shipped_quantity equal to ordered_quantity. Core KPI for omnichannel fulfillment performance and store capacity management.',
    `pack_timestamp` TIMESTAMP COMMENT 'Date and time when the packing of the ship-from-store order was completed and the parcel was sealed and labeled. Used to measure pack cycle time and overall fulfillment throughput.',
    `package_weight_kg` DECIMAL(18,2) COMMENT 'Actual weight of the packed parcel in kilograms as measured at the store packing station. Used for carrier rate calculation, dimensional weight billing reconciliation, and shipping cost allocation.',
    `partial_fulfillment_flag` BOOLEAN COMMENT 'Indicates that the shipped_quantity is less than the ordered_quantity, resulting in a partial shipment. Triggers downstream processes such as backorder creation, customer notification, or alternate store sourcing.',
    `pick_timestamp` TIMESTAMP COMMENT 'Date and time when the store associate completed the pick operation for this fulfillment request. Used to measure pick cycle time and store fulfillment throughput performance.',
    `picked_quantity` STRING COMMENT 'The actual number of units physically picked from store inventory during the pick operation. May differ from ordered_quantity due to inventory discrepancies, shrinkage, or partial fulfillment scenarios.',
    `promised_delivery_date` DATE COMMENT 'The customer-facing delivery date committed at the time of order placement. Distinct from promised_ship_date; used for customer experience SLA tracking and carrier service level selection.',
    `promised_ship_date` DATE COMMENT 'The committed date by which the store must ship the order to meet the customer-facing delivery promise. Used as the SLA (Service Level Agreement) target for OTIF measurement and store performance KPI reporting.',
    `request_timestamp` TIMESTAMP COMMENT 'The date and time when the ship-from-store fulfillment request was created and assigned to the store, representing the principal business event time. Used for OTIF (On Time In Full) SLA measurement and store capacity planning. [BUSINESS_EVENT_TIMESTAMP category]',
    `retail_value_amount` DECIMAL(18,2) COMMENT 'The total retail selling value (AUR × shipped_quantity) of the merchandise shipped in this fulfillment request, at the current selling price. Used for store-level revenue attribution, omnichannel sales reporting, and shrinkage risk assessment.',
    `rfid_verified_flag` BOOLEAN COMMENT 'Indicates whether the SKU was verified using RFID (Radio Frequency Identification) scanning during the pick or pack operation. Supports inventory accuracy, shrinkage reduction, and omnichannel fulfillment quality assurance programs.',
    `ship_timestamp` TIMESTAMP COMMENT 'Date and time when the parcel was tendered to the carrier and the shipment was confirmed. Used as the primary timestamp for OTIF (On Time In Full) compliance measurement against the SLA target.',
    `shipped_quantity` STRING COMMENT 'The actual number of units packed and handed to the carrier for shipment. Used in OTIF (On Time In Full) calculation and sell-through rate (STR) reporting at the store level.',
    `shipping_cost_amount` DECIMAL(18,2) COMMENT 'Actual carrier shipping cost incurred for this ship-from-store parcel in the transaction currency. Used for omnichannel fulfillment cost analysis, store P&L allocation, and COGS (Cost of Goods Sold) reporting.',
    `shipping_label_reference` STRING COMMENT 'Internal identifier for the shipping label generated by the WMS for this parcel. Used to reconcile label costs, void labels on cancellations, and audit label generation events in Manhattan Associates WMS.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that originated this ship-from-store fulfillment request. Supports data lineage, reconciliation, and Silver layer provenance tracking across the omnichannel technology stack.. Valid values are `SFCC|SAP_WM|MANHATTAN_WMS|SAP_CAR|MANUAL`',
    `store_inventory_deducted_flag` BOOLEAN COMMENT 'Indicates whether the shipped_quantity has been successfully deducted from the stores on-hand inventory in the WMS and ERP systems. Used to detect inventory reconciliation failures and ensure ATS (Available to Sell) accuracy.',
    `tracking_number` STRING COMMENT 'The carrier-assigned parcel tracking number generated at the time of shipment label creation. Used for customer shipment visibility, carrier claim management, and post-ship exception resolution.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this ship-from-store record was last modified in the data platform, capturing status transitions, carrier updates, or exception resolutions. [RECORD_AUDIT_UPDATED category]',
    CONSTRAINT pk_ship_from_store PRIMARY KEY(`ship_from_store_id`)
) COMMENT 'Tracks ship-from-store fulfillment requests where a retail store acts as a mini-DC to fulfill e-commerce or wholesale orders. Records order reference, assigned store, SKU, quantity, pick/pack/ship timestamps, carrier, tracking number, and OTIF status. Supports omnichannel fulfillment performance and store-level capacity management.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`return_transaction` (
    `return_transaction_id` BIGINT COMMENT 'Primary key for return_transaction',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Store managers approve high-value returns, no-receipt returns, and policy exceptions (manager_override_flag). Critical fraud prevention control, return abuse detection, and policy compliance tracking ',
    `circular_enrollment_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_enrollment. Business justification: Returns trigger circular program enrollment (take-back programs, recycling incentives, trade-in offers). Circular economy teams link returns to enrollment for material recovery tracking, customer enga',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.quality_defect. Business justification: Returns frequently cite quality defects (stitching failures, fabric flaws, sizing issues) as return reasons. Linking enables systematic quality issue tracking, supplier accountability, and product imp',
    `digital_order_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_order. Business justification: Store returns of online purchases require linking to the originating digital order for return authorization validation, refund processing, cross-channel return rate analytics, and reconciling digital ',
    `pos_transaction_id` BIGINT COMMENT 'Reference to the original POS transaction at which the merchandise being returned was purchased. Used to validate return eligibility, original tender, and purchase date. Maps to store.pos_transaction.store_pos_transaction_id.',
    `sku_id` BIGINT COMMENT 'Identifier of the specific Stock Keeping Unit (SKU) being returned. Enables return rate analysis by product, style, color, and size.',
    `associate_id` BIGINT COMMENT 'Identifier of the sales associate or cashier who processed the return transaction at the Point of Sale (POS). Used for associate performance tracking and loss prevention audit trails.',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: Returns flagged for safety issues (skin irritation, flammability, choking hazards) link to product safety tests for root cause analysis, CPSC reporting obligations, and recall determination—critical f',
    `profile_id` BIGINT COMMENT 'Identifier of the customer initiating the return. Used for loss prevention serial-returner flagging, Customer Relationship Management (CRM) history, and Customer Lifetime Value (CLTV) analytics.',
    `retail_store_id` BIGINT COMMENT 'Identifier of the retail store location where the return was processed. Links to the store master record.',
    `return_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.return_shipment. Business justification: Store returns requiring logistics handling (RTV to vendor, DC consolidation, warranty claims) generate return shipments that must be tracked for freight cost allocation, vendor chargebacks, and dispos',
    `rma_id` BIGINT COMMENT 'Foreign key linking to order.rma. Business justification: Store returns with disposition_code requiring vendor return (RTV) create RMA records for vendor credit and quality tracking. Business process: defective/damaged returns trigger RMA workflow for vendor',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Quality-driven returns require traceability to originating sourcing PO for vendor chargebacks, quality claims, RTV authorization, and supplier performance scorecards. Essential for cost recovery and v',
    `business_date` DATE COMMENT 'Fiscal or retail business date on which the return is recorded for daily sales reconciliation and End of Month (EOM) reporting. May differ from return_timestamp date for late-night transactions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the return transaction record was first created in the data platform. Used for audit trail, data lineage, and Silver layer ingestion tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this return transaction (e.g., USD, EUR, GBP). Supports multi-currency retail operations.. Valid values are `^[A-Z]{3}$`',
    `days_since_purchase` STRING COMMENT 'Number of calendar days elapsed between the original purchase date and the return transaction date. Used for return policy compliance validation and return window analytics. Stored as a business attribute to avoid repeated calculation in reporting.',
    `disposition_code` STRING COMMENT 'Routing decision for the physical merchandise after the return is processed. restock_floor returns item to selling floor inventory; rtv initiates Return to Vendor (RTV) workflow; damage_writeoff records as shrinkage/loss; outlet_transfer routes to outlet channel; quarantine holds for quality inspection or loss prevention review.. Valid values are `restock_floor|rtv|damage_writeoff|outlet_transfer|quarantine`',
    `item_condition_code` STRING COMMENT 'Condition assessment of the returned merchandise as evaluated by the processing associate at Point of Sale (POS). Drives disposition routing decisions: new_with_tags and new_without_tags are eligible for floor restock; worn and damaged route to outlet transfer or damage write-off; defective routes to Return to Vendor (RTV).. Valid values are `new_with_tags|new_without_tags|like_new|worn|damaged|defective`',
    `loss_prevention_flag` BOOLEAN COMMENT 'Indicates whether this return transaction has been flagged by the loss prevention system as suspicious, such as for serial returner behavior, wardrobing, or return fraud patterns. Triggers loss prevention review workflow.',
    `loyalty_points_reversed` STRING COMMENT 'Number of loyalty program points deducted from the customers account as a result of the return transaction. Reverses the points originally earned on the purchase.',
    `manager_override_flag` BOOLEAN COMMENT 'Indicates whether a store manager override was required to approve this return transaction, such as when the return falls outside standard policy (e.g., beyond return window, missing receipt, high-value item). Critical for loss prevention monitoring.',
    `original_order_channel` STRING COMMENT 'Sales channel through which the original purchase was made. Enables cross-channel return analysis (e.g., online purchase returned in-store) and Direct-to-Consumer (DTC) return rate reporting.. Valid values are `in_store|e_commerce|wholesale|bopis|ship_from_store`',
    `original_purchase_date` DATE COMMENT 'Date on which the merchandise was originally purchased. Used to calculate days since purchase for return policy eligibility validation and warranty period determination.',
    `original_tender_type` STRING COMMENT 'Payment method used in the original purchase transaction. Required to determine refund eligibility and routing when refund_method is original_tender. Sourced from the original POS transaction record.. Valid values are `cash|credit_card|debit_card|gift_card|store_credit|mobile_wallet`',
    `quantity_returned` STRING COMMENT 'Number of units of the Stock Keeping Unit (SKU) being returned in this transaction. Used for inventory restock calculations and return rate analysis.',
    `receipt_number` STRING COMMENT 'Receipt number printed on the return transaction receipt provided to the customer. Used for customer service inquiries and return transaction lookup.',
    `receipt_presented_flag` BOOLEAN COMMENT 'Indicates whether the customer presented the original purchase receipt at the time of return. Affects return policy eligibility, refund method options, and loss prevention risk scoring.',
    `refund_method` STRING COMMENT 'Method by which the refund is issued to the customer. original_tender returns funds to the original payment instrument; store_credit issues a store credit balance; exchange swaps for another item; gift_card issues a gift card; cash provides cash refund regardless of original tender.. Valid values are `original_tender|store_credit|exchange|gift_card|cash`',
    `register_code` BIGINT COMMENT 'Identifier of the Point of Sale (POS) register or workstation at which the return was processed. Used for daily cash reconciliation and loss prevention audit trails.',
    `return_channel` STRING COMMENT 'Channel through which the return was initiated or processed. Supports omnichannel return analytics including Buy Online Pick Up In Store (BOPIS) returns and ship-from-store returns.. Valid values are `in_store|bopis_return|ship_from_store|mail_in`',
    `return_discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount that was applied to the original purchase and is being reversed or credited back as part of the return. Ensures accurate net refund calculation.',
    `return_gross_amount` DECIMAL(18,2) COMMENT 'Total gross merchandise value of the returned items before any adjustments, calculated as unit_retail_price multiplied by quantity_returned. Used for return rate and Sell-Through Rate (STR) impact analysis.',
    `return_net_amount` DECIMAL(18,2) COMMENT 'Net amount refunded to the customer after applying discounts and taxes. Equals return_gross_amount minus return_discount_amount plus return_tax_amount. Used for financial reconciliation and daily sales reporting.',
    `return_number` STRING COMMENT 'Externally visible, human-readable return authorization number printed on the return receipt and used for customer-facing communication, warranty claims, and Return to Vendor (RTV) processing. Generated by SAP Customer Activity Repository (CAR).. Valid values are `^RTN-[0-9]{10}$`',
    `return_policy_code` STRING COMMENT 'Code identifying the specific return policy applied to this transaction (e.g., standard 30-day, extended holiday, loyalty member extended window, final sale). Determines return eligibility and refund method options.',
    `return_reason_code` STRING COMMENT 'Standardized reason code selected by the associate at Point of Sale (POS) explaining why the customer is returning the merchandise. Drives return rate analysis by reason, warranty claim routing, and Return to Vendor (RTV) eligibility. [ENUM-REF-CANDIDATE: fit|quality_defect|changed_mind|wrong_item|damaged_in_transit|warranty_claim|gift_return|size_exchange|color_exchange|duplicate_order — promote to reference product]. Valid values are `fit|quality_defect|changed_mind|wrong_item|damaged_in_transit|warranty_claim`',
    `return_reason_description` STRING COMMENT 'Free-text narrative provided by the associate or customer elaborating on the return reason beyond the standardized return_reason_code. Supports qualitative analysis and warranty claim documentation.',
    `return_status` STRING COMMENT 'Current lifecycle status of the return transaction workflow. pending indicates awaiting manager approval; approved indicates authorized but refund not yet issued; completed indicates fully processed with refund issued; rejected indicates denied by loss prevention or policy; voided indicates cancelled after initial entry.. Valid values are `pending|approved|completed|rejected|voided`',
    `return_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount being refunded to the customer as part of the return transaction. Calculated based on the applicable tax jurisdiction and original tax paid.',
    `return_timestamp` TIMESTAMP COMMENT 'Date and time when the return transaction was processed at the Point of Sale (POS) terminal. Principal business event timestamp for the return. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `rfid_verified_flag` BOOLEAN COMMENT 'Indicates whether the returned items Radio Frequency Identification (RFID) tag was scanned and verified during the return process. Supports inventory accuracy and loss prevention authentication.',
    `rtv_authorization_number` STRING COMMENT 'Vendor-issued Return to Vendor (RTV) authorization number assigned when disposition_code is rtv. Required for vendor credit processing and Electronic Data Interchange (EDI) transaction matching with the supplier.',
    `serial_returner_flag` BOOLEAN COMMENT 'Indicates whether the customer associated with this return has been identified as a serial returner based on return frequency thresholds. Distinct from loss_prevention_flag which covers broader fraud patterns. Used for targeted loss prevention intervention.',
    `store_credit_voucher_number` STRING COMMENT 'Voucher or store credit account number issued to the customer when refund_method is store_credit. Used for store credit redemption tracking and liability reporting.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code applicable to the return transaction for tax reversal calculation. Ensures correct tax credit is applied based on the stores geographic tax authority.',
    `unit_retail_price` DECIMAL(18,2) COMMENT 'Original selling price per unit at the time of the initial purchase transaction, used as the basis for refund calculation. Aligns with Average Unit Retail (AUR) reporting.',
    `upc_code` STRING COMMENT 'Universal Product Code (UPC) barcode of the returned item as scanned at Point of Sale (POS). Used for item verification, inventory reconciliation, and Radio Frequency Identification (RFID) cross-validation.. Valid values are `^[0-9]{12,13}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the return transaction record was last modified in the data platform, such as when disposition is updated or loss prevention flag is set. Used for change data capture and audit compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `warranty_claim_number` STRING COMMENT 'Warranty claim reference number assigned when the return is associated with a product defect or warranty issue. Links the return to the warranty claim tracking workflow in SAP S/4HANA.',
    CONSTRAINT pk_return_transaction PRIMARY KEY(`return_transaction_id`)
) COMMENT 'Records customer merchandise returns processed at a retail store, including original POS transaction reference, return reason code (fit, quality defect, changed mind, wrong item), SKU, quantity, condition assessment, refund method (original tender, store credit, exchange), processing associate, and disposition routing (restock to floor, return to vendor/RTV, damage write-off, outlet transfer). Supports return rate analysis by reason, RTV processing workflows, loss prevention flagging of serial returners, and warranty claim tracking.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` (
    `visual_merchandising_plan_id` BIGINT COMMENT 'Unique surrogate identifier for the visual merchandising plan record. Primary key for this entity in the Silver Layer lakehouse.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: VM plans execute campaign creative in-store: window displays for seasonal launches, mannequin styling for brand campaigns. Direct operational link between marketing creative direction and store visual',
    `collection_id` BIGINT COMMENT 'Reference to the product collection or capsule whose display guidelines are governed by this plan. Sourced from Centric PLM collection management.',
    `employee_id` BIGINT COMMENT 'Identifier of the regional visual merchandising manager who approved and published this plan. Used for escalation routing and accountability tracking.',
    `labeling_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.labeling_requirement. Business justification: VM plans must validate displayed products meet jurisdiction-specific labeling requirements (CA Prop 65 warnings, EU care symbols, bilingual Canadian labels) before floor sets to prevent non-compliant ',
    `retail_store_id` BIGINT COMMENT 'Identifier of the retail store or store cluster to which this visual merchandising plan applies. Links to the store master entity.',
    `season_id` BIGINT COMMENT 'Reference to the retail season (e.g., Spring/Summer, Fall/Winter) for which this visual merchandising plan is designed. Aligns with Oracle Retail Merchandising System season calendar.',
    `associate_id` BIGINT COMMENT 'Identifier of the visual merchandising associate or field representative responsible for executing and auditing this plan at the store level. References the workforce/associate master.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the individual who formally approved this visual merchandising plan for publication and distribution to stores.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the visual merchandising plan was formally approved and authorized for distribution to store teams.',
    `audit_date` DATE COMMENT 'Calendar date on which the most recent visual merchandising compliance audit was conducted for this plan.',
    `audit_score` DECIMAL(18,2) COMMENT 'Numeric compliance audit score (0.00–100.00) assigned during the most recent VM compliance audit. Reflects the degree to which the store has executed the plan per directive. Populated after merge with vm_compliance_check.',
    `audit_status` STRING COMMENT 'Current status of the compliance audit for this visual merchandising plan. Drives corrective action workflows and escalation triggers.. Valid values are `pending|in_progress|passed|failed|waived`',
    `collection_display_guidelines` STRING COMMENT 'Narrative description of the seasonal collection display guidelines, including brand story, lifestyle theme, hero product callouts, and cross-category adjacency rules. Sourced from Centric PLM collection management.',
    `color_blocking_direction` STRING COMMENT 'Prescribed color sequencing strategy for merchandise presentation on fixtures and walls. Drives visual consistency across stores within the same cluster.. Valid values are `light_to_dark|dark_to_light|tonal|mixed|brand_standard`',
    `compliance_deadline` DATE COMMENT 'The hard deadline by which store teams must complete the floor set and submit photographic or audit evidence of compliance. May precede the effective_start_date to allow pre-opening setup.',
    `corrective_action_deadline` DATE COMMENT 'The date by which the store team must resolve all non-compliant zones and resubmit evidence for re-audit. Drives escalation workflows in SAP Customer Activity Repository.',
    `corrective_action_notes` STRING COMMENT 'Free-text description of the corrective actions prescribed by the VM field team or regional manager to remediate non-compliant zones identified during the audit.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a corrective action is required following the compliance audit. Set to True when audit_status is failed or non_compliant_zone_count exceeds the acceptable threshold.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this visual merchandising plan record was first created in the source system (Oracle Retail Merchandising System or Centric PLM). Audit trail field.',
    `effective_end_date` DATE COMMENT 'The calendar date on which the visual merchandising plan expires and the floor set is expected to be transitioned to the next plan. Nullable for open-ended or permanent plans.',
    `effective_start_date` DATE COMMENT 'The calendar date on which the visual merchandising plan becomes active and store teams are required to have the floor set completed. Drives compliance deadline tracking.',
    `fixture_layout_code` STRING COMMENT 'Code identifying the prescribed fixture configuration for the store floor (e.g., gondola arrangement, wall system, freestanding unit layout). References the fixture library in Oracle Retail or Centric PLM.',
    `mannequin_count` STRING COMMENT 'Total number of mannequins specified in the visual merchandising plan, including window and interior mannequins. Drives mannequin styling instruction tracking.',
    `mannequin_styling_notes` STRING COMMENT 'Free-text instructions for mannequin outfit composition, accessory pairings, pose direction, and wig/hair styling as specified by the VM creative team. Sourced from Centric PLM tech pack directives.',
    `non_compliant_zone_count` STRING COMMENT 'Number of merchandising zones found to be non-compliant during the most recent audit. Used to prioritize corrective action and track improvement over audit cycles.',
    `non_compliant_zone_notes` STRING COMMENT 'Free-text description of the specific zones, fixtures, or product placements found to be non-compliant during the audit, including the nature of each deviation from the plan directive.',
    `omnichannel_flag` BOOLEAN COMMENT 'Indicates whether this visual merchandising plan includes omnichannel fulfillment zone directives such as BOPIS (Buy Online Pick Up In Store) or ship-from-store staging area setup.',
    `plan_name` STRING COMMENT 'Human-readable descriptive name for the visual merchandising plan (e.g., SS25 Athleisure Front Window Launch). Used in reporting dashboards and store communications.',
    `plan_number` STRING COMMENT 'Externally-known alphanumeric business identifier for the visual merchandising plan, used in communications with store teams, regional managers, and VM field representatives. Format: VM- followed by 4–20 alphanumeric characters.. Valid values are `^VM-[A-Z0-9]{4,20}$`',
    `plan_status` STRING COMMENT 'Current lifecycle state of the visual merchandising plan. Tracks progression from authoring through field execution. [ENUM-REF-CANDIDATE: draft|approved|published|active|expired|cancelled — promote to reference product if additional states are needed]. Valid values are `draft|approved|published|active|expired|cancelled`',
    `plan_type` STRING COMMENT 'Classification of the visual merchandising plan by its business purpose. Seasonal plans govern full-floor resets; promotional plans support campaign activations; window plans govern storefront displays. [ENUM-REF-CANDIDATE: seasonal|promotional|event|permanent|window|capsule — promote to reference product if additional types are needed]. Valid values are `seasonal|promotional|event|permanent|window|capsule`',
    `planogram_document_url` STRING COMMENT 'URL or file path to the planogram PDF or digital asset stored in the content management system. Provides store teams direct access to the fixture layout and product placement diagrams.',
    `planogram_version` STRING COMMENT 'Version identifier of the planogram document associated with this plan (e.g., v1.0, v2.3). Tracks revisions issued to stores after initial publication. Sourced from Oracle Retail Merchandising System planogram management.. Valid values are `^v[0-9]+.[0-9]+$`',
    `product_placement_zone_notes` STRING COMMENT 'Narrative instructions describing product placement by zone, wall, table, and window. Captures hero product positioning, color blocking direction, and adjacency rules for the floor set.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when the visual merchandising plan was published and made available to store teams via the distribution channel (e.g., Oracle Retail portal, intranet).',
    `signage_notes` STRING COMMENT 'Free-text notes detailing specific signage placement instructions, size requirements, and messaging guidelines for this visual merchandising plan.',
    `signage_specification_code` STRING COMMENT 'Code referencing the signage package specification (e.g., price tickets, lifestyle imagery, campaign headers, promotional banners) prescribed for this plan. Links to the signage asset library.',
    `size_run_display_standard` STRING COMMENT 'Standard governing how size runs are displayed on the sales floor (e.g., full size run on fixture, key sizes only on mannequin). Aligns with Oracle Retail size curve and assortment planning.. Valid values are `full_size_run|key_sizes_only|one_size_per_style|brand_standard`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this visual merchandising plan was sourced. ORM = Oracle Retail Merchandising System; CENTRIC_PLM = Centric PLM; MANUAL = manually entered.. Valid values are `ORM|CENTRIC_PLM|MANUAL`',
    `store_cluster_code` STRING COMMENT 'Code identifying the store cluster or tier grouping (e.g., flagship, A-tier, B-tier, outlet) to which this plan applies when a single plan governs multiple stores. Aligns with Oracle Retail store grading.',
    `sustainability_compliance_flag` BOOLEAN COMMENT 'Indicates whether the visual merchandising plan materials (fixtures, signage, packaging) comply with the companys sustainability standards, including GOTS, BCI, and OEKO-TEX requirements for display materials.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this visual merchandising plan record was last modified. Tracks revisions to planogram versions, compliance scores, or corrective action updates.',
    `window_display_count` STRING COMMENT 'Number of storefront window displays included in this visual merchandising plan. Used to track window execution compliance separately from interior floor sets.',
    `zone_count` STRING COMMENT 'Total number of distinct merchandising zones (e.g., front-of-store, mid-floor, back wall, window) covered by this visual merchandising plan.',
    CONSTRAINT pk_visual_merchandising_plan PRIMARY KEY(`visual_merchandising_plan_id`)
) COMMENT 'Captures visual merchandising directives, planogram assignments, and compliance audit results for a store or store cluster. Includes fixture layout, product placement by zone/wall/table/window, seasonal collection display guidelines, mannequin styling instructions, signage specifications, compliance deadline, audit scores, non-compliant zones, and corrective action tracking. After merge with vm_compliance_check, this entity is SSOT for both the plan and its execution verification. Sourced from Oracle Retail Merchandising System and Centric PLM collection management.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` (
    `vm_compliance_check_id` BIGINT COMMENT 'Unique surrogate identifier for each visual merchandising compliance audit record. Primary key for the vm_compliance_check data product.',
    `associate_id` BIGINT COMMENT 'Identifier of the individual who conducted the audit — either the store manager or a field visual merchandising team member. Links to the workforce/associate master.',
    `district_id` BIGINT COMMENT 'Identifier of the retail district to which the audited store belongs. Enables district-level compliance aggregation and benchmarking across the store fleet.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: District managers review and approve visual merchandising compliance audits, especially for critical violations requiring corrective action. Essential approval workflow for brand standards enforcement',
    `prior_audit_compliance_check_vm_compliance_check_id` BIGINT COMMENT 'Reference to the immediately preceding compliance check record for this store and VM plan, enabling trend analysis and comparison of compliance scores across audit cycles.',
    `re_audit_compliance_check_id` BIGINT COMMENT 'Reference to the subsequent re-audit compliance check record created after corrective actions are completed. Enables chaining of audit and re-audit records for full remediation lifecycle tracking.',
    `retail_store_id` BIGINT COMMENT 'Identifier of the retail store where the visual merchandising compliance audit was conducted. Links to the store master record.',
    `visual_merchandising_plan_id` BIGINT COMMENT 'Reference to the visual merchandising plan or directive that this compliance check is evaluated against. Ties the audit to a specific seasonal or campaign VM directive issued by the brand.',
    `acknowledgement_timestamp` TIMESTAMP COMMENT 'Date and time at which the store manager formally acknowledged the audit findings. Populated only when store_manager_acknowledgement_flag is True.',
    `audit_date` DATE COMMENT 'Calendar date on which the visual merchandising compliance audit was physically conducted in the store.',
    `audit_notes` STRING COMMENT 'General free-text observations and comments recorded by the auditor during the compliance check. Captures context not covered by structured fields, such as store-specific circumstances, staffing constraints, or positive observations.',
    `audit_number` STRING COMMENT 'Externally-visible, human-readable reference number assigned to this compliance audit (e.g., VM-2024-000123). Used for cross-referencing with field VM team communications and store operations reports.. Valid values are `^VM-[0-9]{4}-[0-9]{6}$`',
    `audit_status` STRING COMMENT 'Current lifecycle state of the compliance audit record. Tracks progression from initial capture through review and final disposition.. Valid values are `draft|submitted|under_review|passed|failed|closed`',
    `audit_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the compliance audit was initiated in the store, including timezone offset. Supports intraday scheduling and field team coordination.',
    `audit_type` STRING COMMENT 'Classification of the audit by its business trigger. Routine audits occur on a scheduled cadence; seasonal reset audits validate new collection floor sets; campaign launch audits confirm marketing activation compliance; spot checks are unannounced; re-audits follow a failed prior check.. Valid values are `routine|seasonal_reset|campaign_launch|spot_check|re_audit`',
    `auditor_role` STRING COMMENT 'Job role of the individual who conducted the audit. Distinguishes between internal store management audits and field visual merchandising team audits, which may carry different authority levels.. Valid values are `store_manager|assistant_manager|field_vm_specialist|district_manager|external_auditor`',
    `compliance_score` DECIMAL(18,2) COMMENT 'Overall percentage compliance score achieved by the store for this audit, expressed as a value between 0.00 and 100.00. Calculated by the auditor based on the number of compliant zones versus total zones assessed. Enables fleet-wide brand consistency benchmarking.',
    `compliance_threshold` DECIMAL(18,2) COMMENT 'Minimum compliance score percentage required for the store to be considered passing for this audit period. Captured at time of audit to preserve the standard in effect, as thresholds may change over time.',
    `compliant_zones_count` STRING COMMENT 'Number of assessed zones that were found to be fully compliant with the VM plan directives. Used alongside total_zones_assessed to validate the compliance_score.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the store must complete all corrective actions identified during the audit. Used to track remediation timeliness and SLA compliance.',
    `corrective_action_notes` STRING COMMENT 'Free-text field capturing the specific corrective actions required to bring non-compliant zones into alignment with the VM plan. Recorded by the auditor at time of inspection and communicated to store management for remediation.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action remediation process following a failed or partially compliant audit. Tracks whether the store has addressed the identified non-compliance issues within the required timeframe.. Valid values are `not_required|pending|in_progress|completed|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance audit record was first created in the system. Supports data lineage, audit trail, and Silver layer ingestion tracking.',
    `critical_violation_description` STRING COMMENT 'Free-text description of any critical brand standard violations identified. Populated only when critical_violation_flag is True. Documents the nature and location of the violation for escalation and remediation tracking.',
    `critical_violation_flag` BOOLEAN COMMENT 'Indicates whether any critical brand standard violations were identified during the audit (True = at least one critical violation present). Critical violations typically require immediate corrective action and may trigger escalation to district or regional management.',
    `fixture_layout_compliant_flag` BOOLEAN COMMENT 'Indicates whether the physical fixture layout and product adjacency on the sales floor matched the VM plan floor map directive during this audit.',
    `floor_set_date` DATE COMMENT 'Date on which the store completed the most recent floor set or VM reset prior to this audit. Contextualizes the audit relative to how recently the store implemented the VM directive.',
    `folding_hanging_compliant_flag` BOOLEAN COMMENT 'Indicates whether product folding, hanging, and presentation standards (e.g., size sequencing, color blocking, facing direction) were compliant with the VM directive during this audit.',
    `lighting_compliant_flag` BOOLEAN COMMENT 'Indicates whether store lighting (accent, ambient, and feature lighting) was set in accordance with the VM plan specifications during this audit.',
    `mannequin_styling_compliant_flag` BOOLEAN COMMENT 'Indicates whether mannequin styling and outfit coordination across the store floor was compliant with the VM plan directive. Mannequin presentation is a key brand consistency indicator in apparel retail.',
    `non_compliant_zone_count` STRING COMMENT 'Total number of zones found to be non-compliant during the audit. Provides a quick numeric summary for KPI dashboards and trend analysis without parsing the non_compliant_zones text field.',
    `non_compliant_zones` STRING COMMENT 'Comma-separated list or free-text description of the specific store zones or sections found to be non-compliant during the audit (e.g., Front Window Display, Denim Wall, Checkout Counter). Enables targeted corrective action assignment.',
    `pass_fail_flag` BOOLEAN COMMENT 'Indicates whether the store passed (True) or failed (False) the compliance audit based on whether the compliance_score met or exceeded the compliance_threshold. Drives escalation and corrective action workflows.',
    `photo_evidence_count` STRING COMMENT 'Number of photographic evidence images captured and attached to this compliance audit record. Photos document both compliant and non-compliant zones and are stored in the associated document management system.',
    `photo_evidence_reference` STRING COMMENT 'External reference identifier or URL path to the photo evidence package stored in the document management or digital asset management system for this audit record.',
    `re_audit_date` DATE COMMENT 'Scheduled or actual date for the follow-up re-audit to verify that corrective actions have been completed and the store is now compliant. Populated only when re_audit_required_flag is True.',
    `re_audit_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up re-audit is required for this store (True = re-audit scheduled or required). Typically set to True when the store fails the initial audit or when critical violations are identified.',
    `season_code` STRING COMMENT 'Merchandising season code associated with the VM plan being audited (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024). Aligns the audit to the relevant collection planning cycle.. Valid values are `^(SS|FW|HO|RS)[0-9]{2}$`',
    `signage_compliant_flag` BOOLEAN COMMENT 'Indicates whether in-store signage (promotional, price, directional, and brand signage) was compliant with the VM plan and current marketing campaign directives during this audit.',
    `store_manager_acknowledgement_flag` BOOLEAN COMMENT 'Indicates whether the store manager has formally acknowledged receipt of the audit findings and corrective action requirements (True = acknowledged). Required for audit closure in many brand compliance frameworks.',
    `total_zones_assessed` STRING COMMENT 'Total number of visual merchandising zones or sections evaluated during the audit (e.g., front window, entrance table, wall fixtures, fitting room corridor). Provides the denominator for compliance scoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance audit record was most recently modified. Tracks updates such as corrective action status changes, re-audit scheduling, and manager acknowledgements.',
    `vm_directive_version` STRING COMMENT 'Version identifier of the VM plan or directive document against which this audit was conducted (e.g., v2.1). Ensures auditability when VM directives are updated mid-season.',
    `window_display_compliant_flag` BOOLEAN COMMENT 'Indicates whether the stores front window display was found to be compliant with the VM plan directive during this audit. Window displays are a high-visibility brand touchpoint and are tracked separately.',
    CONSTRAINT pk_vm_compliance_check PRIMARY KEY(`vm_compliance_check_id`)
) COMMENT 'Records the results of visual merchandising compliance audits conducted at a store, capturing plan reference, audit date, auditor (store manager or field VM team), compliance score, non-compliant zones, corrective action notes, and re-audit date. Enables brand consistency enforcement across the retail fleet.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`markdown_event` (
    `markdown_event_id` BIGINT COMMENT 'Primary key for markdown_event',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Markdown events are coordinated with marketing campaigns (seasonal clearance, flash sales). Business tracks which campaigns justify markdowns and measures promotional markdown effectiveness vs. campai',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Markdown events on certified sustainable/organic products (GOTS, OEKO-TEX) require certification validation to ensure marketing claims during sales remain compliant with FTC Green Guides and prevent g',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Markdowns create inventory valuation adjustments requiring GL posting for accurate gross margin and inventory valuation. Critical for financial reporting compliance and margin analysis. Each markdown ',
    `merchandise_hierarchy_id` BIGINT COMMENT 'Identifier of the merchandise hierarchy node (department, class, subclass) to which the SKU belongs at the time of the markdown event. Enables hierarchical MD analysis and category-level GMROI reporting.',
    `non_conformance_id` BIGINT COMMENT 'Foreign key linking to quality.non_conformance. Business justification: Markdowns triggered by quality issues (fabric defects, construction flaws, color inconsistencies) require NCR linkage for cost recovery from suppliers and quality-driven margin impact analysis. Critic',
    `otb_budget_id` BIGINT COMMENT 'Reference to the Open-to-Buy (OTB) budget record impacted by this markdown event. Supports OTB reconciliation workflows in Anaplan by linking markdown-driven inventory reductions to planned buy budgets.',
    `price_change_event_id` BIGINT COMMENT 'Reference to the parent price change event in the merchandising domain from which this store-level markdown event originates. Supports traceability from store execution back to the central pricing decision.',
    `employee_id` BIGINT COMMENT 'User identifier of the merchandising manager or authorized personnel who approved the markdown event in Oracle Retail Price Management. Supports authorization audit and segregation of duties compliance.',
    `promotion_id` BIGINT COMMENT 'Identifier of the marketing promotion or campaign associated with this markdown event, if applicable. Links promotional markdowns to campaign performance tracking in Adobe Experience Platform and SAP Customer Activity Repository.',
    `retail_store_id` BIGINT COMMENT 'Identifier of the retail store at which this markdown event is executed. Links to the store master record for store-level MD tracking and performance analysis.',
    `season_id` BIGINT COMMENT 'Identifier of the merchandise season (e.g., Spring/Summer, Fall/Winter) associated with this markdown event. Supports seasonal MD analysis, OTB reconciliation, and collection lifecycle tracking.',
    `site_promotion_id` BIGINT COMMENT 'Foreign key linking to ecommerce.site_promotion. Business justification: Store markdowns often align with or reference coordinated digital promotions to maintain omnichannel price consistency, enable unified promotional effectiveness tracking, and support cross-channel mar',
    `sku_id` BIGINT COMMENT 'Identifier of the specific SKU (Stock Keeping Unit) subject to the markdown event. Enables SKU-level MD tracking, sell-through rate (STR) analysis, and GMROI reporting.',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Markdown decisions require landed cost context from sourcing PO for accurate margin analysis, IMU/MMU calculations, and vendor cost reconciliation. Critical for pricing strategy and profitability repo',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Markdown events often require vendor negotiation for markdown allowances or return-to-vendor (RTV) authorization. Real business process: buyers negotiate vendor-funded markdowns or cost recovery on sl',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Markdowns resulting from production quality issues, overruns, or late deliveries require work order linkage for factory chargeback calculations, vendor performance scorecards, and cost recovery negoti',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the markdown event was formally approved in Oracle Retail Price Management. Represents the principal business event timestamp for the markdown authorization lifecycle.',
    `authorization_reference` STRING COMMENT 'Reference number or code from the authorization workflow that approved this markdown event. Typically sourced from Oracle Retail Price Management approval chain. Required for audit compliance and financial controls.',
    `channel_applicability` STRING COMMENT 'Specifies the retail channel(s) to which this markdown event applies. Supports omnichannel pricing consistency, BOPIS (Buy Online Pick Up In Store), and ship-from-store fulfillment scenarios.. Valid values are `store_only|online_only|all_channels|bopis|ship_from_store`',
    `cost_price` DECIMAL(18,2) COMMENT 'Unit cost of goods sold (COGS) for the SKU at the time of the markdown event. Used to calculate gross margin impact of the markdown and support GMROI analysis. Sourced from SAP S/4HANA MM module.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this markdown event record was first created in the source system (Oracle Retail Price Management). Used for audit trail, data lineage, and Silver Layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this markdown event record (e.g., USD, EUR, GBP). Supports multi-currency retail operations and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The calendar date on which the markdown price becomes active and is applied at the store POS. Aligns with the Oracle Retail Price Management effective date field. Used for OTB reconciliation and fiscal period reporting.',
    `end_date` DATE COMMENT 'The calendar date on which the markdown event expires and the price reverts (for temporary/promotional markdowns). Null for permanent markdowns. Used for event duration analysis and POS price management.',
    `event_status` STRING COMMENT 'Current lifecycle state of the markdown event within the Oracle Retail Price Management workflow. Controls whether the markdown is visible and applied at the POS.. Valid values are `draft|approved|active|suspended|completed|cancelled`',
    `initial_markup_pct` DECIMAL(18,2) COMMENT 'Initial Markup (IMU) percentage at the time the SKU was first priced for the season, expressed as a decimal. Provides the baseline for measuring markdown erosion of margin and maintained markup (MMU) tracking.',
    `maintained_markup_pct` DECIMAL(18,2) COMMENT 'Maintained Markup (MMU) percentage after applying the markdown, reflecting the actual margin retained post-markdown. Calculated as (markdown_price minus cost_price) / markdown_price. Critical for GMROI analysis and financial planning in Anaplan.',
    `markdown_amount` DECIMAL(18,2) COMMENT 'Absolute monetary reduction applied to the original retail price (original_retail_price minus markdown_price). Expressed in the stores operating currency. Used for financial impact reporting and GMROI analysis.',
    `markdown_event_number` STRING COMMENT 'Externally-known business identifier for the markdown event as assigned by Oracle Retail Price Management. Used for cross-system reference, audit trails, and reconciliation with source system records.',
    `markdown_level` STRING COMMENT 'Granularity at which the markdown event is defined and applied within the merchandise hierarchy. SKU-level markdowns are the most granular; department-level markdowns apply broadly across a category.. Valid values are `sku|style|class|subclass|department`',
    `markdown_pct` DECIMAL(18,2) COMMENT 'Percentage reduction from the original retail price to the markdown price, expressed as a decimal (e.g., 0.3000 = 30%). Key metric for MD depth analysis, OTB reconciliation, and maintained markup (MMU) tracking.',
    `markdown_price` DECIMAL(18,2) COMMENT 'The new selling price for the SKU after the markdown event is applied. This is the price presented to customers at POS during the markdown event period. Core field for AUR and ASP reporting.',
    `markdown_reason_code` STRING COMMENT 'Business reason driving the markdown event. [ENUM-REF-CANDIDATE: clearance|seasonal|competitive|slow_seller|overstock|damage|end_of_line — promote to reference product]',
    `markdown_type` STRING COMMENT 'Classification of the markdown event by pricing permanence. Permanent markdowns reduce the ongoing retail price; temporary markdowns revert after the event period; promotional markdowns are tied to a campaign; clearance markdowns are end-of-lifecycle reductions.. Valid values are `permanent|temporary|promotional|clearance`',
    `msrp_price` DECIMAL(18,2) COMMENT 'The original Manufacturers Suggested Retail Price (MSRP) for the SKU prior to any markdown. Serves as the baseline for markdown percentage calculation and IMU/MMU analysis.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the merchandising team regarding the markdown event. May include competitive intelligence, vendor negotiation context, or store-specific execution instructions.',
    `on_hand_qty` STRING COMMENT 'Store-level on-hand inventory quantity for the SKU at the time the markdown event is created. Captured to support sell-through rate (STR) analysis, weeks of supply (WOS) calculation, and OTB reconciliation.',
    `original_retail_price` DECIMAL(18,2) COMMENT 'The stores current selling price for the SKU immediately before this markdown event is applied. May differ from MSRP due to prior price changes. Used as the direct basis for markdown amount and percentage calculations.',
    `pos_applied_flag` BOOLEAN COMMENT 'Indicates whether the markdown price has been successfully pushed to and activated at the store Point of Sale (POS) system (SAP Customer Activity Repository). True when the markdown is live at POS; False when pending or failed.',
    `price_label_required_flag` BOOLEAN COMMENT 'Indicates whether physical price label reprinting is required for store fixtures and merchandise as part of this markdown event. Drives visual merchandising and store operations task management.',
    `price_zone_code` STRING COMMENT 'Oracle Retail Price Management price zone code identifying the geographic or store-cluster pricing zone to which this markdown event applies. Supports zone-based pricing strategy and regional MD analysis.',
    `rfid_repriced_flag` BOOLEAN COMMENT 'Indicates whether RFID-tagged units for this SKU have been repriced and relabeled in the store as part of the markdown event execution. Supports RFID-enabled inventory accuracy and shrinkage control.',
    `sell_through_rate` DECIMAL(18,2) COMMENT 'Ratio of units sold during the markdown event to on-hand quantity at event start, expressed as a decimal (e.g., 0.6500 = 65% STR). Key KPI for markdown effectiveness and inventory liquidation performance. Sourced or calculated from SAP Customer Activity Repository data.',
    `source_record_reference` STRING COMMENT 'Native primary key or record identifier of this markdown event in the originating source system (Oracle Retail Price Management). Enables exact record traceability and idempotent Silver Layer upserts.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this markdown event record was sourced (e.g., ORM = Oracle Retail Merchandising, SAP_CAR = SAP Customer Activity Repository). Supports data lineage and Silver Layer provenance tracking.. Valid values are `ORM|SAP_CAR|ANAPLAN|MANUAL`',
    `units_sold_during_event` STRING COMMENT 'Total number of units of the SKU sold at the markdown price during the event period. Populated at event close or via daily reconciliation from SAP Customer Activity Repository. Supports STR and markdown effectiveness analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this markdown event record was last modified in the source system. Tracks amendments to markdown pricing, status changes, or date adjustments post-creation.',
    CONSTRAINT pk_markdown_event PRIMARY KEY(`markdown_event_id`)
) COMMENT 'Records markdown pricing events executed at the store level, including SKU, original MSRP, markdown price, markdown percentage, effective date, end date, markdown reason (clearance, seasonal, competitive), and authorization reference. Supports MD tracking, GMROI analysis, and OTB reconciliation. Sourced from Oracle Retail Price Management.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` (
    `shrinkage_incident_id` BIGINT COMMENT 'Unique system-generated identifier for each shrinkage incident record in the store loss prevention system. Primary key for this entity. Entity role: TRANSACTION_HEADER — represents a discrete loss event with its own lifecycle, investigation workflow, and financial impact.',
    `associate_id` BIGINT COMMENT 'Identifier of the store associate who discovered or reported the shrinkage incident. For internal theft cases, this may reference the subject of the investigation. Supports LP investigation workflows and associate accountability tracking.',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.quality_defect. Business justification: Shrinkage from damaged goods requires defect classification for vendor chargebacks, cost recovery, and quality reporting. Apparel retailers track whether shrinkage resulted from manufacturing defects ',
    `employee_id` BIGINT COMMENT 'Identifier of the Loss Prevention (LP) investigator or agent assigned to this incident case. Used to track investigator workload, case assignment, and resolution accountability.',
    `fiscal_week_id` BIGINT COMMENT 'Identifier of the fiscal week in which the shrinkage incident was discovered. Enables shrinkage rate KPI reporting aligned to the retail fiscal calendar (4-4-5 or 4-5-4 week structure) and weekly STR (Sell-Through Rate) performance context.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Shrinkage incidents involving counterfeit goods, non-compliant imports, or trademark violations escalate to compliance incidents requiring regulatory notification (CBP, brand protection), linking loss',
    `profile_id` BIGINT COMMENT 'Foreign key linking to customer.profile. Business justification: Loss prevention incidents involving identified customers (apprehensions, banned individuals, organized retail crime suspects) require customer profile linkage for case management, banned customer list',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Shrinkage losses require GL posting for inventory write-offs and loss recognition. Essential for accurate financial statements and shrinkage reserve management. Links operational loss prevention to fi',
    `org_unit_id` BIGINT COMMENT 'Identifier of the store department or selling floor zone where the shrinkage incident occurred or was discovered. Supports spatial shrinkage analysis for fixture security and visual merchandising decisions.',
    `pos_transaction_id` BIGINT COMMENT 'Reference to the Point of Sale (POS) transaction associated with this shrinkage incident, where applicable (e.g., a fraudulent return, a mis-scan event, or a void transaction linked to suspected internal theft). Null for incidents not tied to a specific POS transaction.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Shrinkage discovered during store receiving (shortage, damage) must be traced to inbound shipment for vendor claim filing, carrier liability determination, and supply chain quality metrics. Required f',
    `retail_store_id` BIGINT COMMENT 'Identifier of the retail store where the shrinkage incident was discovered or occurred. Links to the store master record for location, region, and format context.',
    `sku_id` BIGINT COMMENT 'Identifier of the primary Stock Keeping Unit (SKU) affected by the shrinkage incident, representing the specific style, color, and size combination. For multi-SKU incidents, references the highest-value or primary SKU; additional SKUs are captured in the shrinkage_incident_line product.',
    `store_cycle_count_id` BIGINT COMMENT 'Reference to the cycle count or physical inventory event that identified the shrinkage variance, where discovery_method is cycle_count_variance or physical_inventory. Null for incidents discovered by other methods.',
    `waste_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.waste_record. Business justification: Shrinkage (damaged, unsellable, or stolen goods) becomes waste when disposed. Loss prevention and sustainability teams track disposition for waste accounting, diversion programs, and circular economy ',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Shrinkage investigation traces to production work order when defects (missing security tags, incorrect labeling, quality issues) originate at factory level—enables root cause analysis and factory acco',
    `apprehension_made` BOOLEAN COMMENT 'Indicates whether a suspect was apprehended in connection with this shrinkage incident. Used to measure LP team effectiveness and track apprehension rates by store, shrinkage type, and time period.',
    `color_code` STRING COMMENT 'Standardized color code of the affected SKU as defined in the PLM system. Used alongside style_number and size_code to fully identify the affected product variant for shrinkage pattern analysis.',
    `cost_value_lost` DECIMAL(18,2) COMMENT 'Total cost value (Cost of Goods Sold / COGS) of the units lost in this incident at the time of discovery. Used for financial write-off entries in the general ledger and EBITDA impact reporting. Distinct from retail_value_lost which reflects selling price.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shrinkage incident record was first created in the system, including time-zone offset. Used for audit trail, data lineage, and SLA compliance tracking for incident reporting timeliness.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the monetary values recorded in this incident (retail_value_lost, cost_value_lost). Supports multi-currency reporting for international store portfolios.. Valid values are `^[A-Z]{3}$`',
    `discovery_date` DATE COMMENT 'Calendar date on which the shrinkage event was first identified or detected by store operations or loss prevention. Distinct from incident_date when the event occurred prior to detection.',
    `discovery_method` STRING COMMENT 'The operational process or technology that first identified the shrinkage event. Supports analysis of detection effectiveness by method and investment decisions for loss prevention technology. [ENUM-REF-CANDIDATE: cycle_count_variance|rfid_exception|video_analytics|eas_alarm|receiving_audit|pos_exception|physical_inventory — promote to reference product]',
    `discovery_timestamp` TIMESTAMP COMMENT 'Precise date and time when the shrinkage event was first identified, including time-zone offset. Used for intraday loss pattern analysis and correlation with POS transaction timelines.',
    `eas_alarm_triggered` BOOLEAN COMMENT 'Indicates whether an Electronic Article Surveillance (EAS) alarm was triggered in connection with this shrinkage incident. Used to evaluate EAS system effectiveness and correlate alarm events with confirmed shrinkage.',
    `gl_posting_flag` BOOLEAN COMMENT 'Indicates whether the financial write-off for this shrinkage incident has been posted to the General Ledger (GL) in SAP S/4HANA FI/CO. Supports financial close reconciliation and shrinkage expense reporting.',
    `incident_date` DATE COMMENT 'Calendar date on which the shrinkage event is estimated or confirmed to have occurred. May differ from the discovery date when shrinkage is identified retrospectively through cycle count variance or RFID exception reporting.',
    `incident_description` STRING COMMENT 'Free-text narrative describing the circumstances of the shrinkage incident, including how it occurred, who was involved, and any relevant contextual details. Used by LP investigators for case documentation and root cause analysis.',
    `incident_status` STRING COMMENT 'Current lifecycle state of the shrinkage incident record within the loss prevention workflow. Drives investigation routing and KPI reporting. [ENUM-REF-CANDIDATE: open|under_investigation|resolved|closed|escalated|voided — promote to reference product if additional statuses are needed]. Valid values are `open|under_investigation|resolved|closed|escalated|voided`',
    `inventory_adjustment_flag` BOOLEAN COMMENT 'Indicates whether a formal inventory adjustment has been posted in the inventory management system (SAP S/4HANA MM) to reflect the confirmed shrinkage loss. Ensures financial and operational inventory records are reconciled.',
    `lp_case_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned by the Loss Prevention (LP) department or case management system to track the investigation associated with this shrinkage incident. Used for cross-referencing with LP investigation workflows and law enforcement reports.. Valid values are `^LP-[A-Z0-9]{4,20}$`',
    `merchandise_category` STRING COMMENT 'The merchandise hierarchy category of the affected product (e.g., Outerwear, Footwear, Accessories, Activewear). Supports high-shrink category identification for fixture security decisions and assortment risk reporting.',
    `multi_sku_flag` BOOLEAN COMMENT 'Indicates whether this shrinkage incident involves more than one Stock Keeping Unit (SKU). When true, additional affected SKUs are captured in the shrinkage_incident_line detail product. Supports accurate total incident valuation.',
    `organized_retail_crime_flag` BOOLEAN COMMENT 'Indicates whether this incident has been classified as Organized Retail Crime (ORC) based on LP investigation findings. ORC incidents are escalated to regional LP teams and may be reported to law enforcement task forces. Supports ORC trend analysis and network-level investigation.',
    `police_report_number` STRING COMMENT 'Official law enforcement report number filed in connection with this shrinkage incident, where applicable (primarily external theft cases). Used for insurance claims, legal proceedings, and regulatory reporting.',
    `quantity_lost` STRING COMMENT 'Number of units confirmed lost or unaccounted for as a result of this shrinkage incident. Used as the primary quantitative measure for shrinkage rate KPI calculation and inventory adjustment.',
    `recovery_quantity` STRING COMMENT 'Number of units recovered following the shrinkage incident (e.g., merchandise recovered from a shoplifter, items found misplaced). Used to calculate net shrinkage after recovery and to assess LP recovery effectiveness.',
    `recovery_value` DECIMAL(18,2) COMMENT 'Retail value of merchandise recovered following the shrinkage incident. Used to calculate net financial impact after recovery and to report on LP recovery performance.',
    `resolution_date` DATE COMMENT 'Date on which the shrinkage incident was formally resolved and the case closed. Used to calculate case resolution cycle time and LP team performance metrics.',
    `resolution_type` STRING COMMENT 'The outcome or resolution method applied to close this shrinkage incident. Drives financial treatment (write-off vs. recovery vs. insurance claim) and vendor chargeback (Return to Vendor / RTV) processing.. Valid values are `written_off|recovered|insurance_claim|vendor_chargeback|employee_restitution|no_action`',
    `retail_value_lost` DECIMAL(18,2) COMMENT 'Total retail selling value of the units lost in this incident, calculated as quantity_lost multiplied by the current retail price at time of discovery. Expressed in the stores operating currency. Used as the primary monetary measure for shrinkage rate KPI (target <1.5% of net sales) and financial write-off processing.',
    `rfid_exception_flag` BOOLEAN COMMENT 'Indicates whether this shrinkage incident was triggered or corroborated by a Radio Frequency Identification (RFID) inventory exception, such as an item present in RFID scan but absent from physical count, or vice versa. Supports RFID ROI analysis for loss prevention.',
    `season_code` STRING COMMENT 'The merchandise season code associated with the affected SKU at the time of the incident (e.g., SS25, FW24). Supports seasonal shrinkage trend analysis and collection-level risk assessment for future season planning.',
    `shrinkage_type` STRING COMMENT 'Primary classification of the shrinkage event by root cause. External theft covers shoplifting and organized retail crime; internal theft covers employee theft; administrative error covers mis-scans, pricing errors, and paperwork discrepancies; vendor fraud covers short-shipment or substitution fraud; damage/spoilage covers unsaleable goods. Drives LP investigation routing and shrinkage rate decomposition reporting.. Valid values are `external_theft|internal_theft|administrative_error|vendor_fraud|damage_spoilage`',
    `size_code` STRING COMMENT 'Size designation of the affected SKU (e.g., XS, S, M, L, XL, 32x30). Combined with style_number and color_code to fully identify the product variant involved in the shrinkage event.',
    `store_zone` STRING COMMENT 'Specific area or zone within the store where the incident occurred (e.g., fitting room, entrance, stockroom, sales floor, cash wrap). Supports hotspot mapping for LP resource deployment and fixture security planning.',
    `style_number` STRING COMMENT 'The product style identifier from the Product Lifecycle Management (PLM) system representing the design-level grouping above SKU. Enables high-shrink style identification for fixture security and visual merchandising decisions.',
    `unit_retail_price` DECIMAL(18,2) COMMENT 'The retail selling price per unit of the affected SKU at the time the incident was discovered. Used to validate retail_value_lost calculation and to track whether high-price items are disproportionately targeted. Aligns with AUR (Average Unit Retail) KPI tracking.',
    `upc` STRING COMMENT 'Universal Product Code (UPC) barcode of the affected SKU. Used for cross-referencing with POS transaction records, receiving audits, and EAS alarm logs to validate shrinkage claims.. Valid values are `^[0-9]{12,14}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this shrinkage incident record, including time-zone offset. Used for change tracking, data freshness monitoring, and audit compliance in the Silver Layer lakehouse.',
    `video_evidence_flag` BOOLEAN COMMENT 'Indicates whether video surveillance footage has been captured and retained as evidence for this shrinkage incident. Supports LP investigation documentation and legal proceedings.',
    CONSTRAINT pk_shrinkage_incident PRIMARY KEY(`shrinkage_incident_id`)
) COMMENT 'Documents inventory shrinkage events identified at a store, including shrinkage type (external theft/shoplifting, internal/employee theft, administrative error, vendor fraud, damage/spoilage), discovery method (cycle count variance, RFID exception, video analytics, EAS alarm, receiving audit), affected SKUs with style/color/size detail, quantity and retail value lost, incident date, loss prevention case reference, and resolution status. Supports shrinkage rate KPI (target <1.5% of net sales), LP investigation workflows, and high-shrink SKU/category identification for fixture security decisions.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` (
    `store_cycle_count_id` BIGINT COMMENT 'Unique surrogate identifier for each physical inventory cycle count event at a retail store. Primary key for this record. Entity role: TRANSACTION_HEADER — represents a discrete inventory count business event with a defined lifecycle (open → in-progress → reconciled → approved).',
    `schedule_id` BIGINT COMMENT 'Reference to the cycle count schedule or plan that generated this count event. Links scheduled counts to their originating plan for compliance tracking against the stores annual cycle count calendar.',
    `fiscal_week_id` BIGINT COMMENT 'Foreign key linking to store.fiscal_week. Business justification: Cycle counts are scheduled and reported by fiscal week for inventory accuracy tracking. Currently store_cycle_count has fiscal_week_code (BIGINT) which is a denormalized reference. Adding fiscal_week_',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Inventory adjustments from cycle counts post to GL for perpetual inventory accuracy. Required for financial statement accuracy and inventory valuation compliance. Each variance adjustment creates acco',
    `associate_id` BIGINT COMMENT 'Reference to the sales associate or stock associate who performed the physical count. Supports accountability tracking and count accuracy analysis by associate. Sourced from Workday HCM employee records.',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail store location where the cycle count was performed. Links to the store master record in SAP Customer Activity Repository.',
    `sku_id` BIGINT COMMENT 'Reference to the specific Stock Keeping Unit (SKU) — the unique style/color/size combination — that was counted in this cycle count record. Each row represents one SKU counted within the count event. Links to the product SKU master.',
    `adjustment_document_number` STRING COMMENT 'The SAP S/4HANA material document number generated when the inventory adjustment was posted following cycle count approval. Provides the audit trail link between the cycle count record and the financial inventory posting.',
    `adjustment_posted_flag` BOOLEAN COMMENT 'Indicates whether the approved inventory variance has been posted as an inventory adjustment transaction in the system of record (SAP S/4HANA MM). True = adjustment posted; False = pending posting. Critical for financial close and inventory accuracy KPI reporting.',
    `arts_conformance_version` STRING COMMENT 'The version of the NRF Association for Retail Technology Standards (ARTS) InventoryCount schema to which this record conforms. Supports regulatory and standards audit documentation.',
    `bopis_reserved_qty` STRING COMMENT 'The quantity of this SKU reserved for Buy Online Pick Up In Store (BOPIS) orders at the time of the cycle count. Excluded from Available to Sell (ATS) calculation and must be reconciled separately during omnichannel fulfillment accuracy review.',
    `color_code` STRING COMMENT 'Standardized color code for the counted SKU as defined in the product master. Enables color-level variance analysis and supports visual merchandising accuracy reporting.',
    `count_date` DATE COMMENT 'The calendar date on which the physical inventory cycle count was conducted. Used for scheduling, trend analysis, and reconciliation against system on-hand as of that date. Principal business event date for this transaction.',
    `count_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the physical count was completed at the store. Used to calculate count duration and to close the inventory freeze window. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `count_method` STRING COMMENT 'The physical counting technique used during the cycle count. Manual counts are hand-tallied; rfid_scan uses Radio Frequency Identification (RFID) readers; barcode_scan uses handheld scanners; hybrid combines methods. Impacts count accuracy benchmarking and equipment utilization reporting.. Valid values are `manual|rfid_scan|barcode_scan|hybrid`',
    `count_number` STRING COMMENT 'Externally-known business identifier for the cycle count event, used in store operations, reconciliation reports, and audit trails. Format: CC-{YYYY}-{MM}-{SEQNUM}. Sourced from SAP Customer Activity Repository inventory count document number.. Valid values are `^CC-[0-9]{4}-[0-9]{2}-[0-9]{6}$`',
    `count_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the physical count was initiated at the store. Used to measure count duration and to freeze system on-hand snapshot for variance calculation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `count_status` STRING COMMENT 'Current workflow state of the cycle count event. Drives operational actions: open (scheduled, not started), in_progress (counting underway), reconciled (variances reviewed), approved (supervisor sign-off complete), cancelled (count voided). Sourced from SAP CAR inventory count status.. Valid values are `open|in_progress|reconciled|approved|cancelled`',
    `count_type` STRING COMMENT 'Classification of the count event by its trigger or scope. Scheduled counts are planned per the cycle count calendar; ad_hoc counts are triggered by discrepancy alerts; full_store counts cover all zones; spot_check counts target high-risk SKUs; post_shrinkage counts follow a shrinkage incident. [ENUM-REF-CANDIDATE: scheduled|ad_hoc|full_store|spot_check|post_shrinkage|post_receipt|post_transfer — promote to reference product]. Valid values are `scheduled|ad_hoc|full_store|spot_check|post_shrinkage`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cycle count record was first created in the system. Audit trail field for data governance and lineage tracking in the Databricks Lakehouse Silver layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary variance values in this record (e.g., USD, EUR, GBP). Supports multi-currency retail operations and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Merchandise department code scoped for this cycle count (e.g., Mens Apparel, Womens Footwear, Accessories). Aligns with Oracle Retail Merchandising System department hierarchy for inventory accuracy reporting by department.',
    `location_type` STRING COMMENT 'The specific type of physical location within the store where the SKU was found during the count. Enables location-level accuracy analysis and supports visual merchandising compliance checks.. Valid values are `sales_floor|stockroom|fitting_room|receiving|display|vault`',
    `physical_count_qty` STRING COMMENT 'The actual quantity of units physically counted and verified on the store floor or stockroom for this SKU during the cycle count. This is the raw count result entered by the counter associate.',
    `recount_qty` STRING COMMENT 'The quantity recorded during a mandatory recount triggered when the initial physical count variance exceeds the tolerance threshold. Null if no recount was performed. Used to validate or override the original physical count.',
    `recount_required_flag` BOOLEAN COMMENT 'Indicates whether a recount was triggered for this SKU because the initial variance exceeded the stores tolerance threshold. True = recount was required and performed; False = variance within acceptable tolerance.',
    `retail_unit_price` DECIMAL(18,2) COMMENT 'The current retail selling price (Average Unit Retail — AUR) of the SKU at the time of the cycle count. Used to calculate variance retail value and supports Manufacturers Suggested Retail Price (MSRP) compliance checks.',
    `rfid_verified_flag` BOOLEAN COMMENT 'Indicates whether the SKU count was verified using Radio Frequency Identification (RFID) scanning technology. True = RFID scan confirmed; False = counted by manual or barcode method only. Supports RFID accuracy benchmarking.',
    `season_code` STRING COMMENT 'The merchandise season code associated with the counted SKU (e.g., SS25, FW24). Enables seasonal inventory accuracy analysis and supports Open-to-Buy (OTB) and sell-through rate (STR) reporting by season.',
    `ship_from_store_reserved_qty` STRING COMMENT 'The quantity of this SKU reserved for ship-from-store fulfillment orders at the time of the cycle count. Supports omnichannel inventory accuracy and Available to Promise (ATP) reconciliation.',
    `size_code` STRING COMMENT 'Size designation for the counted SKU (e.g., XS, S, M, L, XL, 32x30, 8.5). Enables size-level inventory accuracy analysis and supports size curve (Size Curve) reporting for replenishment decisions.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this cycle count record was sourced (e.g., SAP Customer Activity Repository, Manhattan Associates WMS). Supports data lineage and Silver layer reconciliation in the Databricks Lakehouse.. Valid values are `SAP_CAR|SAP_S4|MANHATTAN_WMS|MANUAL`',
    `style_number` STRING COMMENT 'The product style identifier representing the base design, independent of color and size. Used for style-level inventory accuracy analysis and alignment with Product Lifecycle Management (PLM) records in Centric PLM and Infor PLM.',
    `system_on_hand_qty` STRING COMMENT 'The inventory quantity recorded in the system of record (SAP S/4HANA MM or SAP CAR) at the time the cycle count was initiated. Serves as the baseline for variance calculation. Represents the book inventory position before physical count.',
    `upc` STRING COMMENT 'Universal Product Code (UPC) barcode value for the counted SKU. Used for barcode scan reconciliation and cross-reference with point-of-sale (POS) and warehouse management system (WMS) records. Conforms to GS1 GTIN-12 or GTIN-14 format.. Valid values are `^[0-9]{12,14}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this cycle count record was last modified, including status changes, recount entries, variance reason updates, and adjustment postings. Audit trail field for data governance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `variance_cost_value` DECIMAL(18,2) COMMENT 'The monetary value of the inventory variance expressed at cost (Cost of Goods Sold — COGS basis). Used for financial inventory write-down reporting and EBITDA impact analysis. Expressed in the stores operating currency.',
    `variance_notes` STRING COMMENT 'Free-text narrative entered by the counter associate or supervisor to describe the circumstances of the inventory variance. Supports loss prevention investigation and audit documentation.',
    `variance_pct` DECIMAL(18,2) COMMENT 'The inventory variance expressed as a percentage of system on-hand quantity (variance_qty / system_on_hand_qty × 100). Used to measure inventory accuracy against the target KPI of greater than 98% accuracy per NRF best practices.',
    `variance_qty` STRING COMMENT 'The unit difference between physical count quantity and system on-hand quantity (physical_count_qty minus system_on_hand_qty). Negative values indicate shrinkage or unrecorded outbound movement; positive values indicate unrecorded inbound or phantom inventory.',
    `variance_reason_code` STRING COMMENT 'Coded reason assigned during reconciliation to explain the root cause of the inventory variance. Used for shrinkage classification, loss prevention reporting, and process improvement. [ENUM-REF-CANDIDATE: shrinkage|receiving_error|transfer_error|mis_sort|damage|admin_error|unknown|vendor_short_ship|return_processing_error — promote to reference product]',
    `variance_retail_value` DECIMAL(18,2) COMMENT 'The monetary value of the inventory variance expressed at retail price (variance_qty multiplied by the current retail price of the SKU). Used for shrinkage dollar reporting, loss prevention analysis, and financial reconciliation. Expressed in the stores operating currency.',
    `zone_code` STRING COMMENT 'Alphanumeric code identifying the physical zone or area within the store that was counted (e.g., sales floor, stockroom, fitting room, receiving dock). Enables zone-level inventory accuracy analysis and targeted shrinkage investigation.',
    CONSTRAINT pk_store_cycle_count PRIMARY KEY(`store_cycle_count_id`)
) COMMENT 'Records scheduled and ad-hoc physical inventory cycle counts performed at a store, capturing count date, count method (manual, RFID scan, barcode scan), zone/department scope, counted SKUs with style/color/size detail, system on-hand quantity, physical count quantity, variance units, variance value at retail, count status (open, in-progress, reconciled, approved), and counter associate. Supports inventory accuracy KPI (target >98%), shrinkage identification, and NRF ARTS InventoryCount conformance.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` (
    `campaign_participation_id` BIGINT COMMENT 'Unique identifier for each store-campaign participation record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key to campaign. Identifies which campaign the store is participating in.',
    `retail_store_id` BIGINT COMMENT 'Foreign key to retail_store. Identifies which store is participating in the campaign.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for store_budget_allocated_amount and store_actual_sales_amount. Typically matches the stores local currency_code.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this store-campaign participation record was created in the system.',
    `store_actual_sales_amount` DECIMAL(18,2) COMMENT 'Actual sales revenue generated by this store attributable to this campaign. Used for campaign ROI analysis at store level.',
    `store_budget_allocated_amount` DECIMAL(18,2) COMMENT 'Budget amount allocated specifically to this store for this campaign. Part of the campaigns total budget is distributed across participating stores.',
    `store_compliance_flag` BOOLEAN COMMENT 'Indicates whether this store is compliant with campaign execution requirements (signage, merchandising, staff training, promotional pricing). Used for campaign audit and quality control.',
    `store_end_date` DATE COMMENT 'Date when this specific stores participation in the campaign ended. May differ from the campaigns overall end_date due to early termination or extended participation.',
    `store_participation_status` STRING COMMENT 'Current status of this stores participation in the campaign. Values: planned, active, paused, completed, cancelled. Allows stores to opt in/out or pause participation independently.',
    `store_start_date` DATE COMMENT 'Date when this specific store began participating in the campaign. May differ from the campaigns overall start_date due to phased rollouts or regional timing.',
    `store_target_impressions` BIGINT COMMENT 'Target number of impressions or customer touchpoints this specific store is expected to generate for this campaign.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this store-campaign participation record was last updated.',
    CONSTRAINT pk_campaign_participation PRIMARY KEY(`campaign_participation_id`)
) COMMENT 'This association product represents the participation of individual retail stores in marketing campaigns. It captures store-level budget allocation, performance targets, actual results, and operational compliance for each store-campaign combination. Each record links one retail store to one campaign with attributes that exist only in the context of this specific stores participation in this specific campaign.. Existence Justification: In apparel fashion retail operations, marketing campaigns are executed across multiple store locations with store-specific budget allocations, performance targets, and compliance tracking. A single national or regional campaign (e.g., Spring 2024 Collection Launch) runs simultaneously across dozens or hundreds of stores, while each store participates in multiple concurrent campaigns (brand awareness, seasonal clearance, local events). Marketing operations actively manage this many-to-many relationship by allocating budgets per store-campaign pair, setting store-level targets, tracking store-level sales attribution, and monitoring execution compliance.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` (
    `storefront_fulfillment_id` BIGINT COMMENT 'Unique surrogate identifier for each store-to-storefront fulfillment configuration record. Primary key.',
    `digital_storefront_id` BIGINT COMMENT 'Foreign key linking to the digital storefront that sources inventory and fulfillment from this store',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to the physical retail store location that provides fulfillment services',
    `bopis_enabled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether Buy Online Pick-up In Store (BOPIS) fulfillment is enabled for this store-storefront combination. A store may offer BOPIS for some digital storefronts but not others based on operational capacity, brand alignment, or regional strategy. This is relationship-specific configuration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment configuration record was created in the system. Used for audit trail and data lineage tracking.',
    `effective_date` DATE COMMENT 'Date when this store-storefront fulfillment configuration became or will become active. Used for temporal tracking of fulfillment network changes, seasonal capacity adjustments, and new store launches. This is relationship-specific temporal data that tracks when this particular fulfillment link was established.',
    `end_date` DATE COMMENT 'Date when this store-storefront fulfillment configuration ended or will end. Null if the configuration is currently active. Used to track historical fulfillment network topology, store closures, or strategic channel realignments. This is relationship-specific temporal data that tracks when this particular fulfillment link was terminated.',
    `fulfillment_priority` STRING COMMENT 'Numeric priority ranking for this store when fulfilling orders from this digital storefront. Lower numbers indicate higher priority. Used by order routing algorithms to determine which store should fulfill an order when multiple stores are eligible. This attribute exists only in the context of the store-storefront relationship because the same store may have different priorities for different storefronts based on geography, brand affinity, or capacity.',
    `inventory_allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of the stores available inventory that is allocated for fulfillment of orders from this digital storefront. Allows stores to reserve inventory capacity across multiple digital channels. Sum of allocation percentages across all storefronts for a given store may exceed 100% in overbooking scenarios. This is relationship-specific data because allocation rules vary by storefront based on channel strategy and demand patterns.',
    `service_level_agreement_hours` STRING COMMENT 'Target number of hours within which this store commits to fulfill orders from this digital storefront (e.g., 2 hours for BOPIS, 24 hours for ship-from-store). Service level agreements may vary by store-storefront combination based on customer expectations, competitive positioning, and operational capacity. This is relationship-specific operational data.',
    `ship_from_store_enabled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether ship-from-store fulfillment is enabled for this store-storefront combination. Determines if the store can pack and ship orders placed on this digital storefront directly to customers. A store may ship for some storefronts but not others based on shipping infrastructure, labor capacity, or channel strategy. This is relationship-specific configuration.',
    `updated_by_user` STRING COMMENT 'Identifier of the user or system process that last updated this fulfillment configuration record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment configuration record was last updated. Used for audit trail and change tracking.',
    CONSTRAINT pk_storefront_fulfillment PRIMARY KEY(`storefront_fulfillment_id`)
) COMMENT 'This association product represents the fulfillment configuration between retail_store and digital_storefront. It captures the operational rules governing how physical stores fulfill orders originating from digital storefronts, including BOPIS (Buy Online Pick-up In Store), ship-from-store capabilities, inventory allocation percentages, and fulfillment priority rankings. Each record links one retail_store to one digital_storefront with attributes that exist only in the context of this omnichannel fulfillment relationship.. Existence Justification: In omnichannel apparel fashion operations, a single physical retail store can fulfill orders originating from multiple digital storefronts (e.g., a flagship store in NYC fulfills for both the US DTC site and the outlet microsite), and a single digital storefront sources inventory and fulfillment capacity from multiple physical stores across its service geography. The business actively manages this many-to-many relationship through fulfillment configuration records that specify BOPIS eligibility, ship-from-store capabilities, inventory allocation percentages, fulfillment priority rankings, and service level agreements for each store-storefront pair.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`store_cluster` (
    `store_cluster_id` BIGINT COMMENT 'Primary key for store_cluster',
    `parent_store_cluster_id` BIGINT COMMENT 'Self-referencing FK on store_cluster (parent_store_cluster_id)',
    `average_store_size_sqft` DECIMAL(18,2) COMMENT 'Average retail floor space in square feet across all stores in the cluster.',
    `climate_zone` STRING COMMENT 'Primary climate zone classification for the cluster used for seasonal merchandise planning and allocation.',
    `cluster_code` STRING COMMENT 'Business identifier code for the store cluster used in operational systems and reporting.',
    `cluster_description` STRING COMMENT 'Detailed business description of the cluster purpose, characteristics, and strategic rationale for grouping.',
    `cluster_manager_email` STRING COMMENT 'Business email address of the cluster manager for operational communication.',
    `cluster_manager_name` STRING COMMENT 'Name of the regional or cluster manager responsible for stores in this cluster.',
    `cluster_name` STRING COMMENT 'Descriptive name of the store cluster for business users and reporting purposes.',
    `cluster_status` STRING COMMENT 'Current lifecycle status of the store cluster indicating whether it is actively used for planning and operations.',
    `cluster_tier` STRING COMMENT 'Performance or strategic tier classification of the cluster (tier 1 being highest performing or most strategic).',
    `cluster_type` STRING COMMENT 'Classification of the cluster based on grouping methodology: geographic proximity, demographic profile, performance tier, store format similarity, strategic importance, or seasonal behavior.',
    `competitive_intensity` STRING COMMENT 'Level of competitive pressure from other apparel retailers in the clusters market area.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the primary country of the cluster.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cluster record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the cluster configuration was retired or superseded. Null for currently active clusters.',
    `effective_start_date` DATE COMMENT 'Date when the cluster configuration became effective and stores were assigned to it.',
    `geographic_region` STRING COMMENT 'Primary geographic region or market area that the cluster represents (e.g., Northeast, West Coast, EMEA).',
    `is_flagship_cluster` BOOLEAN COMMENT 'Indicates whether this cluster contains flagship or brand showcase stores requiring premium treatment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the cluster record was last updated or modified.',
    `merchandising_strategy` STRING COMMENT 'Primary merchandising and assortment strategy applied to stores in this cluster (e.g., athletic-focused, lifestyle-casual, luxury-premium).',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the cluster configuration, special considerations, or historical context.',
    `omnichannel_capability` STRING COMMENT 'Level of omnichannel fulfillment capabilities enabled for stores in this cluster (BOPIS: Buy Online Pick-up In Store).',
    `planning_system_code` STRING COMMENT 'Cluster identifier used in merchandise planning and allocation systems (e.g., SAP Customer Activity Repository).',
    `pricing_strategy` STRING COMMENT 'Pricing approach applied to the cluster reflecting market positioning and competitive dynamics.',
    `replenishment_frequency` STRING COMMENT 'Standard inventory replenishment frequency for stores in this cluster.',
    `seasonal_profile` STRING COMMENT 'Seasonal sales pattern classification for the cluster used in demand forecasting and inventory planning (e.g., winter-peak, summer-peak, balanced).',
    `store_count` STRING COMMENT 'Total number of stores currently assigned to this cluster.',
    `target_demographic` STRING COMMENT 'Primary customer demographic profile targeted by stores in this cluster (e.g., urban millennials, suburban families, luxury shoppers).',
    `traffic_pattern` STRING COMMENT 'Typical customer foot traffic pattern classification for stores in the cluster.',
    `visual_merchandising_standard` STRING COMMENT 'Visual merchandising and store presentation standard applied to the cluster.',
    CONSTRAINT pk_store_cluster PRIMARY KEY(`store_cluster_id`)
) COMMENT 'Master reference table for store_cluster. Referenced by store_cluster_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`register` (
    `register_id` BIGINT COMMENT 'Primary key for register',
    `retail_store_id` BIGINT COMMENT 'Identifier of the retail store where this register is located.',
    `replaced_register_id` BIGINT COMMENT 'Self-referencing FK on register (replaced_register_id)',
    `activation_date` DATE COMMENT 'Date when the register was activated and made available for processing transactions.',
    `barcode_scanner_enabled` BOOLEAN COMMENT 'Indicates whether this register is equipped with a barcode scanning device.',
    `card_reader_enabled` BOOLEAN COMMENT 'Indicates whether this register is equipped with and configured to accept card payments.',
    `cash_drawer_enabled` BOOLEAN COMMENT 'Indicates whether this register is equipped with and configured to use a physical cash drawer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this register record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for transactions processed at this register.',
    `deactivation_date` DATE COMMENT 'Date when the register was deactivated or taken out of service. Null if currently active.',
    `firmware_version` STRING COMMENT 'Version number of the firmware installed on the register hardware.',
    `floor_level` STRING COMMENT 'Floor number where the register is located within multi-level retail stores.',
    `installation_date` DATE COMMENT 'Date when the register was installed and commissioned for use in the store.',
    `ip_address` STRING COMMENT 'Network IP address assigned to the register for connectivity and system integration.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance or service performed on the register.',
    `location_zone` STRING COMMENT 'Physical zone or area within the store where the register is positioned (e.g., front entrance, back corner, fitting rooms).',
    `mac_address` STRING COMMENT 'Hardware MAC address of the register network interface for device identification.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the point-of-sale hardware.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum transaction value that can be processed at this register without manager override.',
    `model_number` STRING COMMENT 'Manufacturer model number or designation for the register hardware.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance or service check.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or operational comments about the register.',
    `offline_mode_enabled` BOOLEAN COMMENT 'Indicates whether this register can continue processing transactions when network connectivity is lost.',
    `payment_terminal_code` STRING COMMENT 'Unique identifier for the payment terminal device associated with this register for card processing.',
    `receipt_printer_enabled` BOOLEAN COMMENT 'Indicates whether this register has a functioning receipt printer attached.',
    `register_name` STRING COMMENT 'Human-readable name or label assigned to the register for easy identification by store staff.',
    `register_number` STRING COMMENT 'Business-facing unique register number used for operational identification and reporting.',
    `register_type` STRING COMMENT 'Classification of the register based on its operational purpose and configuration.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer for hardware identification and warranty tracking.',
    `software_version` STRING COMMENT 'Version number of the POS software application currently running on the register.',
    `register_status` STRING COMMENT 'Current operational status of the register indicating its availability for transactions.',
    `supports_employee_discount` BOOLEAN COMMENT 'Indicates whether this register can apply employee discount codes and pricing.',
    `supports_exchanges` BOOLEAN COMMENT 'Indicates whether this register is configured to process product exchanges.',
    `supports_gift_cards` BOOLEAN COMMENT 'Indicates whether this register can process gift card sales, redemptions, and balance inquiries.',
    `supports_layaway` BOOLEAN COMMENT 'Indicates whether this register can process layaway transactions and payments.',
    `supports_loyalty_program` BOOLEAN COMMENT 'Indicates whether this register is configured to process loyalty program enrollments and point redemptions.',
    `supports_returns` BOOLEAN COMMENT 'Indicates whether this register is configured to process customer returns and refunds.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this register record was last modified in the system.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty coverage for the register hardware expires.',
    CONSTRAINT pk_register PRIMARY KEY(`register_id`)
) COMMENT 'Master reference table for register. Referenced by register_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`fiscal_week` (
    `fiscal_week_id` BIGINT COMMENT 'Primary key for fiscal_week',
    `prior_year_fiscal_week_id` BIGINT COMMENT 'Self-referencing FK on fiscal_week (prior_year_fiscal_week_id)',
    `calendar_month` STRING COMMENT 'The Gregorian calendar month (1-12) in which the majority of this fiscal week falls.',
    `calendar_year` STRING COMMENT 'The Gregorian calendar year in which the majority of this fiscal week falls, represented as a four-digit year.',
    `comparable_week_prior_year` BIGINT COMMENT 'Reference to the fiscal week identifier from the prior year that is comparable for year-over-year (YoY) analysis, accounting for calendar shifts.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fiscal week record was first created in the system.',
    `days_in_week` STRING COMMENT 'The actual number of calendar days in this fiscal week, typically 7 but may vary at fiscal year boundaries or in leap week years.',
    `effective_from_timestamp` TIMESTAMP COMMENT 'The timestamp when this fiscal week record became effective and active for business use.',
    `effective_to_timestamp` TIMESTAMP COMMENT 'The timestamp when this fiscal week record ceased to be effective, null if currently active.',
    `fiscal_month` STRING COMMENT 'The fiscal month within the fiscal year (1 through 12 or 13 for retailers using 4-5-4 calendar) to which this week belongs.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the fiscal year (1, 2, 3, or 4) to which this week belongs.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this week belongs, represented as a four-digit year (e.g., 2024).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this fiscal week record is currently active (True) or has been superseded or deactivated (False).',
    `is_current_week` BOOLEAN COMMENT 'Boolean flag indicating whether this fiscal week is the current active week (True) or not (False).',
    `is_holiday_week` BOOLEAN COMMENT 'Boolean flag indicating whether this fiscal week contains major holidays that impact retail operations (True) or not (False).',
    `is_month_end_week` BOOLEAN COMMENT 'Boolean flag indicating whether this fiscal week is the last week of a fiscal month (True) or not (False), used for month-end reporting and reconciliation.',
    `is_promotional_week` BOOLEAN COMMENT 'Boolean flag indicating whether this fiscal week is designated for major promotional campaigns or sales events (True) or not (False).',
    `is_quarter_end_week` BOOLEAN COMMENT 'Boolean flag indicating whether this fiscal week is the last week of a fiscal quarter (True) or not (False), used for quarterly reporting and financial close.',
    `is_year_end_week` BOOLEAN COMMENT 'Boolean flag indicating whether this fiscal week is the last week of the fiscal year (True) or not (False), used for annual reporting and financial close.',
    `iso_week_number` STRING COMMENT 'The ISO 8601 week number (1-53) for cross-reference with international calendar standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this fiscal week record was last updated or modified.',
    `season_code` STRING COMMENT 'The retail season classification for this fiscal week, used for seasonal merchandise planning and analysis.',
    `trading_days_count` STRING COMMENT 'The number of trading days (days stores are open) within this fiscal week, accounting for holidays and closures.',
    `week_description` STRING COMMENT 'Extended description of the fiscal week, may include notable events, holidays, or business context (e.g., Black Friday Week, End of Season Sale Week).',
    `week_end_date` DATE COMMENT 'The calendar date on which this fiscal week ends, typically Saturday or Sunday depending on business convention.',
    `week_in_month` STRING COMMENT 'The sequential position of this week within its fiscal month (1-5), used in 4-5-4 retail calendar analysis.',
    `week_in_quarter` STRING COMMENT 'The sequential position of this week within its fiscal quarter (1-13), used for quarterly trend analysis.',
    `week_label` STRING COMMENT 'Human-readable label for the fiscal week, typically formatted as FY2024-W12 or Week 12, FY2024 for reporting and display purposes.',
    `week_number` STRING COMMENT 'The sequential week number within the fiscal year, typically ranging from 1 to 52 or 53.',
    `week_start_date` DATE COMMENT 'The calendar date on which this fiscal week begins, typically Sunday or Monday depending on business convention.',
    `week_type` STRING COMMENT 'Classification of the week structure: standard (7 days), short (less than 7 days, typically at year boundaries), long (more than 7 days in leap week years), or split (spans two calendar months).',
    CONSTRAINT pk_fiscal_week PRIMARY KEY(`fiscal_week_id`)
) COMMENT 'Master reference table for fiscal_week. Referenced by fiscal_week_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`zone` (
    `zone_id` BIGINT COMMENT 'Primary key for zone',
    `employee_id` BIGINT COMMENT 'Employee identifier of the sales associate or manager responsible for this zone.',
    `parent_zone_id` BIGINT COMMENT 'Identifier of the parent zone if this zone is a sub-zone within a larger area. Null for top-level zones.',
    `planogram_id` BIGINT COMMENT 'Reference to the planogram or layout plan currently assigned to this zone.',
    `retail_store_id` BIGINT COMMENT 'Identifier of the retail store to which this zone belongs.',
    `accessible` BOOLEAN COMMENT 'Indicates whether the zone meets accessibility standards for customers with disabilities.',
    `area_square_meters` DECIMAL(18,2) COMMENT 'Total floor area of the zone measured in square meters.',
    `average_transaction_value` DECIMAL(18,2) COMMENT 'Average transaction value for sales originating from this zone, used for zone performance analysis.',
    `capacity_units` STRING COMMENT 'Maximum number of product units that can be displayed or stored in this zone.',
    `climate_controlled` BOOLEAN COMMENT 'Indicates whether the zone has dedicated climate control for temperature-sensitive merchandise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this zone record was first created in the system.',
    `zone_description` STRING COMMENT 'Detailed description of the zone including its purpose, merchandise focus, and operational notes.',
    `effective_end_date` DATE COMMENT 'Date when this zone configuration was deactivated or replaced. Null for currently active zones.',
    `effective_start_date` DATE COMMENT 'Date when this zone configuration became active in the store.',
    `fixture_count` STRING COMMENT 'Number of display fixtures, racks, or shelving units allocated to this zone.',
    `floor_level` STRING COMMENT 'Floor number where the zone is located (e.g., 1 for ground floor, 2 for second floor, -1 for basement).',
    `last_merchandising_reset_date` DATE COMMENT 'Date when the zone last underwent a full merchandising reset or planogram change.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this zone record was last modified in the system.',
    `notes` STRING COMMENT 'Additional operational notes or special instructions related to the zone management.',
    `omnichannel_enabled` BOOLEAN COMMENT 'Indicates whether the zone supports omnichannel fulfillment operations such as Buy Online Pickup In Store (BOPIS) or ship-from-store.',
    `security_level` STRING COMMENT 'Security monitoring level assigned to the zone based on merchandise value and shrinkage risk.',
    `zone_status` STRING COMMENT 'Current operational status of the zone within the store.',
    `target_sales_per_square_meter` DECIMAL(18,2) COMMENT 'Target sales productivity metric for this zone measured as revenue per square meter.',
    `traffic_priority` STRING COMMENT 'Customer traffic priority classification for this zone based on store layout and flow analysis.',
    `visual_merchandising_theme` STRING COMMENT 'Current visual merchandising theme or campaign applied to the zone (e.g., Spring Collection, Holiday, Back to School).',
    `zone_category` STRING COMMENT 'Merchandise category or department assigned to this zone.',
    `zone_code` STRING COMMENT 'Business identifier code for the zone used in store operations and reporting.',
    `zone_name` STRING COMMENT 'Human-readable name of the zone (e.g., Mens Apparel, Footwear, Accessories, Checkout).',
    `zone_type` STRING COMMENT 'Classification of the zone by its primary function within the store.',
    CONSTRAINT pk_zone PRIMARY KEY(`zone_id`)
) COMMENT 'Master reference table for zone. Referenced by zone_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`district` (
    `district_id` BIGINT COMMENT 'Primary key for district',
    `employee_id` BIGINT COMMENT 'Reference to the employee who serves as the district manager responsible for all stores within this district.',
    `region_id` BIGINT COMMENT 'Reference to the parent region that this district belongs to in the organizational hierarchy.',
    `parent_district_id` BIGINT COMMENT 'Self-referencing FK on district (parent_district_id)',
    `annual_sales_target` DECIMAL(18,2) COMMENT 'Planned annual sales revenue target for the district, used for performance measurement and incentive calculations.',
    `annual_traffic_target` BIGINT COMMENT 'Planned annual customer traffic target across all stores in the district, used for conversion and productivity analysis.',
    `bopis_enabled` BOOLEAN COMMENT 'Indicates whether Buy Online Pickup In Store capability is enabled for stores in this district.',
    `comp_store_sales_target_percent` DECIMAL(18,2) COMMENT 'Year-over-year comparable store sales growth target percentage for the district.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this district record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code used for financial reporting and transactions within this district.',
    `district_code` STRING COMMENT 'Business identifier code for the district used in operational systems and reporting. Typically follows a regional prefix pattern.',
    `district_manager_name` STRING COMMENT 'Full name of the district manager for quick reference and reporting purposes.',
    `district_name` STRING COMMENT 'Official name of the district used for business communication and reporting.',
    `district_type` STRING COMMENT 'Classification of the district based on store composition and market characteristics.',
    `effective_end_date` DATE COMMENT 'Date when this district configuration ceased to be effective. Null for currently active districts.',
    `effective_start_date` DATE COMMENT 'Date when this district configuration became effective in the organizational structure.',
    `headquarters_address_line_1` STRING COMMENT 'Primary street address line for the district headquarters office.',
    `headquarters_address_line_2` STRING COMMENT 'Secondary address line for suite, floor, or building information for the district headquarters.',
    `headquarters_city` STRING COMMENT 'City where the district headquarters office is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO country code for the district headquarters location.',
    `headquarters_email_address` STRING COMMENT 'Primary email address for district headquarters communications.',
    `headquarters_phone_number` STRING COMMENT 'Primary contact phone number for the district headquarters office.',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the district headquarters office location.',
    `headquarters_state_province` STRING COMMENT 'State or province where the district headquarters office is located.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this district record was last updated in the system.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to the district.',
    `omnichannel_fulfillment_enabled` BOOLEAN COMMENT 'Indicates whether stores in this district are enabled for omnichannel fulfillment capabilities including Buy Online Pickup In Store (BOPIS) and ship-from-store.',
    `sap_car_integration_enabled` BOOLEAN COMMENT 'Indicates whether stores in this district are integrated with SAP Customer Activity Repository for traffic and customer analytics.',
    `ship_from_store_enabled` BOOLEAN COMMENT 'Indicates whether ship-from-store fulfillment capability is enabled for stores in this district.',
    `shrinkage_target_percent` DECIMAL(18,2) COMMENT 'Target shrinkage rate as a percentage of sales for the district, used for loss prevention performance measurement.',
    `district_status` STRING COMMENT 'Current operational status of the district in the organizational structure.',
    `store_count` STRING COMMENT 'Total number of active stores currently assigned to this district.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the district headquarters location, used for scheduling and reporting alignment.',
    `total_selling_square_footage` DECIMAL(18,2) COMMENT 'Aggregate selling square footage across all stores in the district, used for productivity and sales per square foot analysis.',
    `visual_merchandising_standard` STRING COMMENT 'Visual merchandising standard tier applied to stores within this district, determining display guidelines and fixture requirements.',
    CONSTRAINT pk_district PRIMARY KEY(`district_id`)
) COMMENT 'Master reference table for district. Referenced by district_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`store`.`planogram` (
    `planogram_id` BIGINT COMMENT 'Primary key for planogram',
    `superseded_planogram_id` BIGINT COMMENT 'Self-referencing FK on planogram (superseded_planogram_id)',
    `approval_status` STRING COMMENT 'Current approval workflow status of the planogram in the design and review process.',
    `approved_by_id` BIGINT COMMENT 'Reference to the merchandising manager or executive who approved this planogram for deployment.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this planogram was officially approved for store implementation.',
    `average_unit_retail_usd` DECIMAL(18,2) COMMENT 'Average unit retail price in USD of products included in this planogram, used for sales forecasting.',
    `category_id` BIGINT COMMENT 'Reference to the primary product category this planogram is designed for.',
    `climate_zone` STRING COMMENT 'Climate zone classification for which this planogram is optimized, affecting seasonal product mix.',
    `color_story` STRING COMMENT 'Dominant color palette or color blocking strategy used in this planogram to create visual impact.',
    `compliance_required` BOOLEAN COMMENT 'Indicates whether strict compliance to this planogram is mandatory or if stores have flexibility to adapt.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for country-specific planogram variations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this planogram record was first created in the system.',
    `digital_integration_enabled` BOOLEAN COMMENT 'Indicates whether this planogram includes digital display elements, QR codes, or interactive technology.',
    `effective_end_date` DATE COMMENT 'Date when this planogram is scheduled to be retired and replaced with a new layout. Null for open-ended planograms.',
    `effective_start_date` DATE COMMENT 'Date when this planogram becomes active and should be implemented in stores.',
    `fixture_count` STRING COMMENT 'Number of fixtures or display units required to implement this planogram.',
    `fixture_type` STRING COMMENT 'Primary type of retail fixture or display unit this planogram is designed for.',
    `floor_space_sqm` DECIMAL(18,2) COMMENT 'Total floor space in square meters required to implement this planogram.',
    `height_cm` DECIMAL(18,2) COMMENT 'Maximum vertical height in centimeters of the planogram display from floor to top shelf.',
    `implementation_duration_hours` DECIMAL(18,2) COMMENT 'Estimated time in hours required for store staff to implement this planogram from start to completion.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this planogram record was last updated or modified.',
    `merchandising_zone` STRING COMMENT 'Strategic zone within the store where this planogram is intended to be placed for optimal customer engagement.',
    `notes` STRING COMMENT 'Additional implementation instructions, special considerations, or merchandising tips for store teams.',
    `omnichannel_enabled` BOOLEAN COMMENT 'Indicates whether this planogram supports omnichannel features such as buy online pickup in store (BOPIS) or ship from store integration.',
    `parent_planogram_id` BIGINT COMMENT 'Reference to the previous version of this planogram if this is a revision. Null for original planograms.',
    `planogram_code` STRING COMMENT 'Externally-known unique business identifier for the planogram used across systems and communications.',
    `planogram_description` STRING COMMENT 'Detailed description of the planogram including merchandising strategy, target customer segment, and visual presentation goals.',
    `planogram_name` STRING COMMENT 'Human-readable name or title of the planogram describing its purpose or target category.',
    `planogram_type` STRING COMMENT 'Classification of the planogram based on merchandising strategy and product lifecycle stage.',
    `price_point_strategy` STRING COMMENT 'Pricing tier strategy for products featured in this planogram.',
    `projected_sales_per_sqm_usd` DECIMAL(18,2) COMMENT 'Forecasted sales revenue per square meter in USD expected from this planogram based on historical performance.',
    `region_code` STRING COMMENT 'Geographic region code where this planogram is intended to be deployed (e.g., NAM, EUR, APAC).',
    `season_code` STRING COMMENT 'Fashion season identifier for which this planogram is designed (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024).',
    `store_format` STRING COMMENT 'Type of retail store format this planogram is designed for, reflecting store size and merchandising approach.',
    `style_theme` STRING COMMENT 'Fashion style theme or aesthetic direction of the planogram (e.g., athleisure, minimalist, bold prints, heritage).',
    `subcategory_id` BIGINT COMMENT 'Reference to the specific product subcategory within the category that this planogram targets.',
    `sustainability_rating` STRING COMMENT 'Sustainability rating of the planogram based on percentage of eco-friendly and sustainable products featured.',
    `target_demographic` STRING COMMENT 'Primary customer demographic segment this planogram is designed to appeal to (e.g., women 25-40, men athletic, youth streetwear).',
    `total_sku_count` STRING COMMENT 'Total number of unique SKUs included in this planogram layout.',
    `total_unit_capacity` STRING COMMENT 'Maximum number of individual product units that can be displayed when the planogram is fully stocked.',
    `version_number` STRING COMMENT 'Version number of this planogram, incremented with each revision or update.',
    `visual_merchandiser_id` BIGINT COMMENT 'Reference to the visual merchandiser or designer who created this planogram.',
    `wall_space_linear_m` DECIMAL(18,2) COMMENT 'Total linear wall space in meters required for wall-mounted fixtures in this planogram.',
    CONSTRAINT pk_planogram PRIMARY KEY(`planogram_id`)
) COMMENT 'Master reference table for planogram. Referenced by planogram_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_district_id` FOREIGN KEY (`district_id`) REFERENCES `apparel_fashion_ecm`.`store`.`district`(`district_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ADD CONSTRAINT `fk_store_retail_store_store_cluster_id` FOREIGN KEY (`store_cluster_id`) REFERENCES `apparel_fashion_ecm`.`store`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_register_id` FOREIGN KEY (`register_id`) REFERENCES `apparel_fashion_ecm`.`store`.`register`(`register_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ADD CONSTRAINT `fk_store_pos_transaction_return_original_transaction_pos_transaction_id` FOREIGN KEY (`return_original_transaction_pos_transaction_id`) REFERENCES `apparel_fashion_ecm`.`store`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `apparel_fashion_ecm`.`store`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ADD CONSTRAINT `fk_store_pos_transaction_line_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ADD CONSTRAINT `fk_store_daily_sales_summary_fiscal_week_id` FOREIGN KEY (`fiscal_week_id`) REFERENCES `apparel_fashion_ecm`.`store`.`fiscal_week`(`fiscal_week_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ADD CONSTRAINT `fk_store_daily_sales_summary_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ADD CONSTRAINT `fk_store_traffic_count_fiscal_week_id` FOREIGN KEY (`fiscal_week_id`) REFERENCES `apparel_fashion_ecm`.`store`.`fiscal_week`(`fiscal_week_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ADD CONSTRAINT `fk_store_traffic_count_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ADD CONSTRAINT `fk_store_traffic_count_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `apparel_fashion_ecm`.`store`.`zone`(`zone_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ADD CONSTRAINT `fk_store_associate_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ADD CONSTRAINT `fk_store_shift_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ADD CONSTRAINT `fk_store_shift_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ADD CONSTRAINT `fk_store_shift_shift_covering_associate_id` FOREIGN KEY (`shift_covering_associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ADD CONSTRAINT `fk_store_shift_shift_original_associate_id` FOREIGN KEY (`shift_original_associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ADD CONSTRAINT `fk_store_bopis_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ADD CONSTRAINT `fk_store_ship_from_store_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `apparel_fashion_ecm`.`store`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ADD CONSTRAINT `fk_store_return_transaction_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ADD CONSTRAINT `fk_store_visual_merchandising_plan_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ADD CONSTRAINT `fk_store_vm_compliance_check_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ADD CONSTRAINT `fk_store_vm_compliance_check_district_id` FOREIGN KEY (`district_id`) REFERENCES `apparel_fashion_ecm`.`store`.`district`(`district_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ADD CONSTRAINT `fk_store_vm_compliance_check_prior_audit_compliance_check_vm_compliance_check_id` FOREIGN KEY (`prior_audit_compliance_check_vm_compliance_check_id`) REFERENCES `apparel_fashion_ecm`.`store`.`vm_compliance_check`(`vm_compliance_check_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ADD CONSTRAINT `fk_store_vm_compliance_check_re_audit_compliance_check_id` FOREIGN KEY (`re_audit_compliance_check_id`) REFERENCES `apparel_fashion_ecm`.`store`.`vm_compliance_check`(`vm_compliance_check_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ADD CONSTRAINT `fk_store_vm_compliance_check_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ADD CONSTRAINT `fk_store_vm_compliance_check_visual_merchandising_plan_id` FOREIGN KEY (`visual_merchandising_plan_id`) REFERENCES `apparel_fashion_ecm`.`store`.`visual_merchandising_plan`(`visual_merchandising_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ADD CONSTRAINT `fk_store_markdown_event_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_fiscal_week_id` FOREIGN KEY (`fiscal_week_id`) REFERENCES `apparel_fashion_ecm`.`store`.`fiscal_week`(`fiscal_week_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_pos_transaction_id` FOREIGN KEY (`pos_transaction_id`) REFERENCES `apparel_fashion_ecm`.`store`.`pos_transaction`(`pos_transaction_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ADD CONSTRAINT `fk_store_shrinkage_incident_store_cycle_count_id` FOREIGN KEY (`store_cycle_count_id`) REFERENCES `apparel_fashion_ecm`.`store`.`store_cycle_count`(`store_cycle_count_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ADD CONSTRAINT `fk_store_store_cycle_count_fiscal_week_id` FOREIGN KEY (`fiscal_week_id`) REFERENCES `apparel_fashion_ecm`.`store`.`fiscal_week`(`fiscal_week_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ADD CONSTRAINT `fk_store_store_cycle_count_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `apparel_fashion_ecm`.`store`.`associate`(`associate_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ADD CONSTRAINT `fk_store_store_cycle_count_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ADD CONSTRAINT `fk_store_campaign_participation_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ADD CONSTRAINT `fk_store_storefront_fulfillment_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cluster` ADD CONSTRAINT `fk_store_store_cluster_parent_store_cluster_id` FOREIGN KEY (`parent_store_cluster_id`) REFERENCES `apparel_fashion_ecm`.`store`.`store_cluster`(`store_cluster_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`register` ADD CONSTRAINT `fk_store_register_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`register` ADD CONSTRAINT `fk_store_register_replaced_register_id` FOREIGN KEY (`replaced_register_id`) REFERENCES `apparel_fashion_ecm`.`store`.`register`(`register_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`fiscal_week` ADD CONSTRAINT `fk_store_fiscal_week_prior_year_fiscal_week_id` FOREIGN KEY (`prior_year_fiscal_week_id`) REFERENCES `apparel_fashion_ecm`.`store`.`fiscal_week`(`fiscal_week_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`zone` ADD CONSTRAINT `fk_store_zone_parent_zone_id` FOREIGN KEY (`parent_zone_id`) REFERENCES `apparel_fashion_ecm`.`store`.`zone`(`zone_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`zone` ADD CONSTRAINT `fk_store_zone_planogram_id` FOREIGN KEY (`planogram_id`) REFERENCES `apparel_fashion_ecm`.`store`.`planogram`(`planogram_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`zone` ADD CONSTRAINT `fk_store_zone_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `apparel_fashion_ecm`.`store`.`retail_store`(`retail_store_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ADD CONSTRAINT `fk_store_district_parent_district_id` FOREIGN KEY (`parent_district_id`) REFERENCES `apparel_fashion_ecm`.`store`.`district`(`district_id`);
ALTER TABLE `apparel_fashion_ecm`.`store`.`planogram` ADD CONSTRAINT `fk_store_planogram_superseded_planogram_id` FOREIGN KEY (`superseded_planogram_id`) REFERENCES `apparel_fashion_ecm`.`store`.`planogram`(`planogram_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`store` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `apparel_fashion_ecm`.`store` SET TAGS ('dbx_domain' = 'store');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` SET TAGS ('dbx_subdomain' = 'location_operations');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'District Manager Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `energy_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Distribution Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `renewable_energy_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `waste_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `water_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Water Usage Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Store Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Store Address Line 2');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `annual_base_rent` SET TAGS ('dbx_business_glossary_term' = 'Annual Base Rent');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `annual_base_rent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Store City');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `climate_zone` SET TAGS ('dbx_business_glossary_term' = 'Store Climate Zone');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `climate_zone` SET TAGS ('dbx_value_regex' = 'tropical|arid|temperate|continental|polar');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Store Closure Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Store Country Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Store Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Store Email Address');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `fitting_room_count` SET TAGS ('dbx_business_glossary_term' = 'Fitting Room Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `gross_selling_sqft` SET TAGS ('dbx_business_glossary_term' = 'Gross Selling Square Footage');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `headcount_capacity` SET TAGS ('dbx_business_glossary_term' = 'Store Headcount Capacity');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `is_bopis_enabled` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `is_rfid_enabled` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `is_ship_from_store_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ship From Store Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Store Latitude');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Start Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `lease_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Store Longitude');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `net_selling_sqft` SET TAGS ('dbx_business_glossary_term' = 'Net Selling Square Footage');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Store Opening Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Store Operational Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'pre-open|trading|temporarily_closed|permanently_closed');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Store Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `pos_system_type` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) System Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `pos_system_type` SET TAGS ('dbx_value_regex' = 'fixed|mobile|self-checkout|mixed');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Store Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Store Region Name');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `register_count` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale Register Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `remodel_date` SET TAGS ('dbx_business_glossary_term' = 'Store Last Remodel Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `rent_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rent Structure Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `rent_structure_type` SET TAGS ('dbx_value_regex' = 'fixed|turnover|fixed_plus_turnover|concession_percentage');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `rent_structure_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `standard_trading_hours` SET TAGS ('dbx_business_glossary_term' = 'Standard Trading Hours');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Store State or Province');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `stockroom_sqft` SET TAGS ('dbx_business_glossary_term' = 'Stockroom Square Footage');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `store_code` SET TAGS ('dbx_business_glossary_term' = 'Store Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `store_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `store_format` SET TAGS ('dbx_business_glossary_term' = 'Store Format');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `store_format` SET TAGS ('dbx_value_regex' = 'flagship|outlet|pop-up|shop-in-shop|concession');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `store_name` SET TAGS ('dbx_business_glossary_term' = 'Store Name');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Store Territory Name');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Store Time Zone');
ALTER TABLE `apparel_fashion_ecm`.`store`.`retail_store` ALTER COLUMN `trading_area_classification` SET TAGS ('dbx_business_glossary_term' = 'Trading Area Classification');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier / Sales Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `return_original_transaction_pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Return Original POS Transaction ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Omnichannel Transaction Channel Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'IN_STORE|BOPIS|SHIP_FROM_STORE|ENDLESS_AISLE|CURBSIDE');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Item Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `line_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Line Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `manager_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manager Override Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `price_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Override Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `receipt_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Receipt Delivery Method');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `receipt_delivery_method` SET TAGS ('dbx_value_regex' = 'PRINT|EMAIL|SMS|NONE');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `rfid_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Verified Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `tender_cash_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Tender Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `tender_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Card Tender Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `tender_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Card Tender Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `tender_gift_card_amount` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Tender Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `tender_mobile_wallet_amount` SET TAGS ('dbx_business_glossary_term' = 'Mobile Wallet Tender Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `tender_mobile_wallet_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `tender_mobile_wallet_amount` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `tender_store_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Store Credit Tender Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `training_mode_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Mode Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'POS Transaction Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'POS Transaction Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'COMPLETED|VOIDED|SUSPENDED|CANCELLED|PENDING');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'POS Transaction Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'POS Transaction Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'SALE|RETURN|EXCHANGE|VOID|NO_SALE|LAYAWAY');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `void_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Void Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction` ALTER COLUMN `workstation_number` SET TAGS ('dbx_business_glossary_term' = 'POS Workstation Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `pos_transaction_line_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Line Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `ftc_label_id` SET TAGS ('dbx_business_glossary_term' = 'Ftc Label Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'POS Transaction ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Class Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `cogs` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `cogs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `colorway_code` SET TAGS ('dbx_business_glossary_term' = 'Colorway Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Department Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `discount_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Line Discount Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Omnichannel Fulfillment Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'IN_STORE|BOPIS|SHIP_FROM_STORE|CURBSIDE|ENDLESS_AISLE');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `imu_pct` SET TAGS ('dbx_business_glossary_term' = 'Initial Markup (IMU) Percentage');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `imu_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Ingestion Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `is_clearance_item` SET TAGS ('dbx_business_glossary_term' = 'Is Clearance Item Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `is_markdown_item` SET TAGS ('dbx_business_glossary_term' = 'Is Markdown Item Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `is_rfid_scanned` SET TAGS ('dbx_business_glossary_term' = 'Is Radio Frequency Identification (RFID) Scanned Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `line_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `line_extended_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Extended Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Line Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Line Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'SALE|RETURN|EXCHANGE|VOID|LAYAWAY');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `markdown_amount` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `mmu_pct` SET TAGS ('dbx_business_glossary_term' = 'Maintained Markup (MMU) Percentage');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `mmu_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturers Suggested Retail Price (MSRP)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `original_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Original Retail Price');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `quantity_sold` SET TAGS ('dbx_business_glossary_term' = 'Quantity Sold');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `register_code` SET TAGS ('dbx_business_glossary_term' = 'POS Register ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `size_code` SET TAGS ('dbx_business_glossary_term' = 'Size Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `source_system_line_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Line ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `style_number` SET TAGS ('dbx_business_glossary_term' = 'Style Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `subclass_code` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Subclass Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `unit_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Retail (AUR) Price');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`pos_transaction_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12,14}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `daily_sales_summary_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Sales Summary ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `fiscal_week_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Week Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_value_regex' = 'system_correction|manual_override|return_reclass|shrinkage_update|tax_correction|other');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `asp` SET TAGS ('dbx_business_glossary_term' = 'Average Selling Price (ASP)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `asp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `aur` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Retail (AUR)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `aur` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `bopis_order_count` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Order Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `card_tender_amount` SET TAGS ('dbx_business_glossary_term' = 'Card Tender Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `card_tender_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `cash_tender_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Tender Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `cash_tender_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `closing_inventory_units` SET TAGS ('dbx_business_glossary_term' = 'Closing Inventory Units');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `customer_traffic_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Traffic Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `digital_tender_amount` SET TAGS ('dbx_business_glossary_term' = 'Digital Tender Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `digital_tender_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `gift_card_tender_amount` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Tender Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `gift_card_tender_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Sales Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `is_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Is Adjusted Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `is_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Is Reconciled Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `markdown_amount` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `markdown_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `net_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Sales Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `net_sales_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `opening_inventory_units` SET TAGS ('dbx_business_glossary_term' = 'Opening Inventory Units');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `pos_close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Close Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `reconciliation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `return_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Return Transaction Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `returns_amount` SET TAGS ('dbx_business_glossary_term' = 'Returns Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `returns_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `ship_from_store_order_count` SET TAGS ('dbx_business_glossary_term' = 'Ship-From-Store Order Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `shrinkage_amount` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `shrinkage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_CAR|SFCC|POS_LEGACY|MANUAL');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `store_number` SET TAGS ('dbx_business_glossary_term' = 'Store Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `str` SET TAGS ('dbx_business_glossary_term' = 'Sell-Through Rate (STR)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `summary_status` SET TAGS ('dbx_business_glossary_term' = 'Daily Sales Summary Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `summary_status` SET TAGS ('dbx_value_regex' = 'open|pending_reconciliation|reconciled|closed|adjusted|voided');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `units_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Units Per Transaction (UPT)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `units_returned` SET TAGS ('dbx_business_glossary_term' = 'Units Returned');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`daily_sales_summary` ALTER COLUMN `void_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Void Transaction Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` SET TAGS ('dbx_subdomain' = 'location_operations');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `traffic_count_id` SET TAGS ('dbx_business_glossary_term' = 'Traffic Count Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `fiscal_week_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Week Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `avg_dwell_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Dwell Time (Seconds)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `bopis_order_count` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Order Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `bounce_rate` SET TAGS ('dbx_business_glossary_term' = 'Bounce Rate');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `capture_rate` SET TAGS ('dbx_business_glossary_term' = 'Capture Rate');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Count Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `count_direction` SET TAGS ('dbx_business_glossary_term' = 'Count Direction');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `count_direction` SET TAGS ('dbx_value_regex' = 'bidirectional|inbound_only|outbound_only');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `count_hour` SET TAGS ('dbx_business_glossary_term' = 'Count Hour');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `count_period_type` SET TAGS ('dbx_business_glossary_term' = 'Count Period Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `count_period_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `entry_count` SET TAGS ('dbx_business_glossary_term' = 'Entry Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `exit_count` SET TAGS ('dbx_business_glossary_term' = 'Exit Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `gap_filled_flag` SET TAGS ('dbx_business_glossary_term' = 'Gap Filled Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `is_holiday` SET TAGS ('dbx_business_glossary_term' = 'Is Holiday Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `is_promotional_period` SET TAGS ('dbx_business_glossary_term' = 'Is Promotional Period Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `is_store_open` SET TAGS ('dbx_business_glossary_term' = 'Is Store Open Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `max_occupancy_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Occupancy Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `passing_traffic_count` SET TAGS ('dbx_business_glossary_term' = 'Passing Traffic Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `peak_hour_flag` SET TAGS ('dbx_business_glossary_term' = 'Peak Hour Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `period_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period End Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `period_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Start Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|estimated|adjusted|excluded|pending_review');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `sensor_type` SET TAGS ('dbx_business_glossary_term' = 'Sensor Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `sensor_type` SET TAGS ('dbx_value_regex' = 'ir_beam_break|stereoscopic_video|thermal|time_of_flight|wifi_bluetooth');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `sensor_uptime_pct` SET TAGS ('dbx_business_glossary_term' = 'Sensor Uptime Percentage');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `ship_from_store_count` SET TAGS ('dbx_business_glossary_term' = 'Ship From Store Order Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `staff_count_scheduled` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Staff Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'clear|cloudy|rain|snow|storm|extreme_heat');
ALTER TABLE `apparel_fashion_ecm`.`store`.`traffic_count` ALTER COLUMN `week_number` SET TAGS ('dbx_business_glossary_term' = 'Week Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Associate Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Store Assignment Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|suspended|terminated|transferred');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `associate_number` SET TAGS ('dbx_business_glossary_term' = 'Associate Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `associate_number` SET TAGS ('dbx_value_regex' = '^ASC-[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `bopis_fulfillment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Fulfillment Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|temporary|contractor');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Associate First Name');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `keyholder_flag` SET TAGS ('dbx_business_glossary_term' = 'Keyholder Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Associate Last Name');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `loss_prevention_flag` SET TAGS ('dbx_business_glossary_term' = 'Loss Prevention Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `loss_prevention_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `nps_score_avg` SET TAGS ('dbx_business_glossary_term' = 'Average Net Promoter Score (NPS)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `performance_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `pos_login_enabled` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Login Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `pos_operator_code` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Operator Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `pos_operator_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Associate Preferred Name');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `primary_department_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Department Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `product_knowledge_tier` SET TAGS ('dbx_business_glossary_term' = 'Product Knowledge Tier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `product_knowledge_tier` SET TAGS ('dbx_value_regex' = 'basic|intermediate|advanced|expert');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `rfid_badge_code` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Badge ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `rfid_badge_code` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{8,24}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `rfid_badge_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `rfid_badge_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `sales_floor_zone` SET TAGS ('dbx_business_glossary_term' = 'Sales Floor Zone');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `scheduled_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours Per Week');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `secondary_department_code` SET TAGS ('dbx_business_glossary_term' = 'Secondary Department Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `ship_from_store_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ship From Store Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_CAR|WORKDAY_HCM|MANUAL');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `store_assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Store Assignment End Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `store_assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Store Assignment Start Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `store_role` SET TAGS ('dbx_business_glossary_term' = 'Store Role');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `store_role` SET TAGS ('dbx_value_regex' = 'sales_associate|keyholder|department_lead|assistant_manager|store_manager');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `uniform_size_bottom` SET TAGS ('dbx_business_glossary_term' = 'Uniform Bottom Size');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `uniform_size_bottom` SET TAGS ('dbx_value_regex' = 'XS|S|M|L|XL|XXL');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `uniform_size_top` SET TAGS ('dbx_business_glossary_term' = 'Uniform Top Size');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `uniform_size_top` SET TAGS ('dbx_value_regex' = 'XS|S|M|L|XL|XXL');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Associate Work Email Address');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `work_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Associate Work Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`associate` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` SET TAGS ('dbx_subdomain' = 'workforce_management');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_value_regex' = '^PP-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `shift_covering_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Covering Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `shift_original_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Original Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Workday Position ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `absence_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `actual_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Break Duration (Minutes)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration (Minutes)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `clock_in_method` SET TAGS ('dbx_business_glossary_term' = 'Clock-In Method');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `clock_in_method` SET TAGS ('dbx_value_regex' = 'pos_terminal|mobile_app|biometric|manager_entry|rfid');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `clock_in_time` SET TAGS ('dbx_business_glossary_term' = 'Clock-In Time');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `clock_out_method` SET TAGS ('dbx_business_glossary_term' = 'Clock-Out Method');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `clock_out_method` SET TAGS ('dbx_value_regex' = 'pos_terminal|mobile_app|biometric|manager_entry|rfid');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `clock_out_time` SET TAGS ('dbx_business_glossary_term' = 'Clock-Out Time');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `early_departure_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Departure Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `manager_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manager Override Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `omnichannel_fulfillment_flag` SET TAGS ('dbx_business_glossary_term' = 'Omnichannel Fulfillment Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `pay_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `pay_rate_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `payroll_export_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Export Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `payroll_export_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Export Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `role_during_shift` SET TAGS ('dbx_business_glossary_term' = 'Role During Shift');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `schedule_adherence_minutes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Adherence (Minutes)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `schedule_source` SET TAGS ('dbx_business_glossary_term' = 'Schedule Source');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `schedule_source` SET TAGS ('dbx_value_regex' = 'workday|manual|auto_generated|manager_adjusted');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `shift_number` SET TAGS ('dbx_business_glossary_term' = 'Shift Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `shift_number` SET TAGS ('dbx_value_regex' = '^SHF-[0-9]{8}-[0-9]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|no_show');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|on_call|split|holiday|training');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_CAR|WORKDAY|MANUAL');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `swap_flag` SET TAGS ('dbx_business_glossary_term' = 'Shift Swap Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `training_shift_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Shift Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shift` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` SET TAGS ('dbx_subdomain' = 'fulfillment_services');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `bopis_order_id` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Order ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `cart_id` SET TAGS ('dbx_business_glossary_term' = 'Cart Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `digital_order_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Store Assignment Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `cancellation_notes` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notes');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = 'customer_request|inventory_unavailable|expired|damaged_items|store_closure|system_error');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `curbside_flag` SET TAGS ('dbx_business_glossary_term' = 'Curbside Pickup Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `customer_notified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiry Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|sms|push_notification|phone_call');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `order_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Total Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `pick_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Complete Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `pick_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Start Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `pickup_location_type` SET TAGS ('dbx_business_glossary_term' = 'Pickup Location Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `pickup_location_type` SET TAGS ('dbx_value_regex' = 'store_counter|curbside|locker|designated_area');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pickup Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `pickup_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Pickup Verification Method');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `pickup_verification_method` SET TAGS ('dbx_value_regex' = 'order_number|barcode_scan|qr_code|photo_id|email_confirmation');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `ready_for_pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ready For Pickup Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `sla_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Minutes');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Minutes');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `unit_count` SET TAGS ('dbx_business_glossary_term' = 'Unit Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`bopis_order` ALTER COLUMN `vehicle_description` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Description');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` SET TAGS ('dbx_subdomain' = 'fulfillment_services');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `ship_from_store_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-From-Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `digital_order_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order (SO) ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = 'OUT_OF_STOCK|CUSTOMER_REQUEST|FRAUD|DUPLICATE|STORE_CAPACITY|SYSTEM_ERROR');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `carrier_code` SET TAGS ('dbx_value_regex' = 'UPS|FEDEX|USPS|DHL|ONTRAC|LSO');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'GROUND|2DAY|OVERNIGHT|PRIORITY|ECONOMY|SAME_DAY');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `destination_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `destination_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `destination_state_code` SET TAGS ('dbx_business_glossary_term' = 'Destination State Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `destination_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Exception Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = 'ITEM_NOT_FOUND|DAMAGED_ITEM|LABEL_FAILURE|CARRIER_PICKUP_MISSED|ADDRESS_INVALID|SYSTEM_TIMEOUT');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `fulfillment_request_number` SET TAGS ('dbx_business_glossary_term' = 'Ship-From-Store Fulfillment Request Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `fulfillment_request_number` SET TAGS ('dbx_value_regex' = '^SFS-[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Ship-From-Store Fulfillment Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'ECOM_DTC|BOPIS|WHOLESALE|STORE_TRANSFER|SHIP_TO_STORE');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Fulfillment Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Notes');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Fulfillment Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `otif_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `pack_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `package_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Package Weight (kg)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `partial_fulfillment_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Fulfillment Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `pick_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `promised_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Request Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `retail_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Retail Value Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `retail_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `rfid_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Verified Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `ship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ship Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `shipping_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `shipping_label_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SFCC|SAP_WM|MANHATTAN_WMS|SAP_CAR|MANUAL');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `store_inventory_deducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Store Inventory Deducted Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`ship_from_store` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Return Transaction Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `circular_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Enrollment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `digital_order_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Point of Sale (POS) Transaction ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `days_since_purchase` SET TAGS ('dbx_business_glossary_term' = 'Days Since Purchase');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Return Disposition Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'restock_floor|rtv|damage_writeoff|outlet_transfer|quarantine');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `item_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Returned Item Condition Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `item_condition_code` SET TAGS ('dbx_value_regex' = 'new_with_tags|new_without_tags|like_new|worn|damaged|defective');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `loss_prevention_flag` SET TAGS ('dbx_business_glossary_term' = 'Loss Prevention Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `loyalty_points_reversed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Reversed');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `manager_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Manager Override Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `original_order_channel` SET TAGS ('dbx_business_glossary_term' = 'Original Order Channel');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `original_order_channel` SET TAGS ('dbx_value_regex' = 'in_store|e_commerce|wholesale|bopis|ship_from_store');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `original_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Original Purchase Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `original_tender_type` SET TAGS ('dbx_business_glossary_term' = 'Original Tender Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `original_tender_type` SET TAGS ('dbx_value_regex' = 'cash|credit_card|debit_card|gift_card|store_credit|mobile_wallet');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `quantity_returned` SET TAGS ('dbx_business_glossary_term' = 'Quantity Returned');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Return Receipt Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `receipt_presented_flag` SET TAGS ('dbx_business_glossary_term' = 'Receipt Presented Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original_tender|store_credit|exchange|gift_card|cash');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `register_code` SET TAGS ('dbx_business_glossary_term' = 'Register ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_channel` SET TAGS ('dbx_business_glossary_term' = 'Return Channel');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_channel` SET TAGS ('dbx_value_regex' = 'in_store|bopis_return|ship_from_store|mail_in');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Return Discount Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Return Gross Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Return Net Refund Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_number` SET TAGS ('dbx_business_glossary_term' = 'Return Transaction Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_number` SET TAGS ('dbx_value_regex' = '^RTN-[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'fit|quality_defect|changed_mind|wrong_item|damaged_in_transit|warranty_claim');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Transaction Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_status` SET TAGS ('dbx_value_regex' = 'pending|approved|completed|rejected|voided');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Return Tax Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Transaction Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `rfid_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Verified Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `rtv_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Authorization Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `serial_returner_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Returner Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `store_credit_voucher_number` SET TAGS ('dbx_business_glossary_term' = 'Store Credit Voucher Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `unit_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Retail Price');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `upc_code` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `upc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{12,13}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`return_transaction` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` SET TAGS ('dbx_subdomain' = 'location_operations');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `visual_merchandising_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Visual Merchandising Plan ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Regional Visual Merchandising Manager ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `labeling_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Requirement Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Visual Merchandising Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Visual Merchandising Audit Score');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|passed|failed|waived');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `collection_display_guidelines` SET TAGS ('dbx_business_glossary_term' = 'Collection Display Guidelines');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `color_blocking_direction` SET TAGS ('dbx_business_glossary_term' = 'Color Blocking Direction');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `color_blocking_direction` SET TAGS ('dbx_value_regex' = 'light_to_dark|dark_to_light|tonal|mixed|brand_standard');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `corrective_action_notes` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Notes');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `fixture_layout_code` SET TAGS ('dbx_business_glossary_term' = 'Fixture Layout Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `mannequin_count` SET TAGS ('dbx_business_glossary_term' = 'Mannequin Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `mannequin_styling_notes` SET TAGS ('dbx_business_glossary_term' = 'Mannequin Styling Notes');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `non_compliant_zone_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliant Zone Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `non_compliant_zone_notes` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliant Zone Notes');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `omnichannel_flag` SET TAGS ('dbx_business_glossary_term' = 'Omnichannel Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Visual Merchandising Plan Name');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Visual Merchandising Plan Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^VM-[A-Z0-9]{4,20}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Visual Merchandising Plan Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|published|active|expired|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Visual Merchandising Plan Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'seasonal|promotional|event|permanent|window|capsule');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `planogram_document_url` SET TAGS ('dbx_business_glossary_term' = 'Planogram Document URL');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `planogram_version` SET TAGS ('dbx_business_glossary_term' = 'Planogram Version');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `planogram_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `product_placement_zone_notes` SET TAGS ('dbx_business_glossary_term' = 'Product Placement Zone Notes');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `signage_notes` SET TAGS ('dbx_business_glossary_term' = 'Signage Notes');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `signage_specification_code` SET TAGS ('dbx_business_glossary_term' = 'Signage Specification Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `size_run_display_standard` SET TAGS ('dbx_business_glossary_term' = 'Size Run Display Standard');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `size_run_display_standard` SET TAGS ('dbx_value_regex' = 'full_size_run|key_sizes_only|one_size_per_style|brand_standard');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'ORM|CENTRIC_PLM|MANUAL');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `store_cluster_code` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `sustainability_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Compliance Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `window_display_count` SET TAGS ('dbx_business_glossary_term' = 'Window Display Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`visual_merchandising_plan` ALTER COLUMN `zone_count` SET TAGS ('dbx_business_glossary_term' = 'Zone Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` SET TAGS ('dbx_subdomain' = 'location_operations');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `vm_compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Visual Merchandising (VM) Compliance Check ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'District Manager Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `prior_audit_compliance_check_vm_compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Audit Visual Merchandising (VM) Compliance Check ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `re_audit_compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Re-Audit Visual Merchandising (VM) Compliance Check ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `visual_merchandising_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Visual Merchandising (VM) Plan ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^VM-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|passed|failed|closed');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'routine|seasonal_reset|campaign_launch|spot_check|re_audit');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `auditor_role` SET TAGS ('dbx_business_glossary_term' = 'Auditor Role');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `auditor_role` SET TAGS ('dbx_value_regex' = 'store_manager|assistant_manager|field_vm_specialist|district_manager|external_auditor');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `compliance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Compliance Threshold');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `compliant_zones_count` SET TAGS ('dbx_business_glossary_term' = 'Compliant Zones Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `corrective_action_notes` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Notes');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|overdue');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `critical_violation_description` SET TAGS ('dbx_business_glossary_term' = 'Critical Violation Description');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `critical_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Violation Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `fixture_layout_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Fixture Layout Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `floor_set_date` SET TAGS ('dbx_business_glossary_term' = 'Floor Set Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `folding_hanging_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Folding and Hanging Standards Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `lighting_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Lighting Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `mannequin_styling_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Mannequin Styling Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `non_compliant_zone_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliant Zone Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `non_compliant_zones` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliant Zones');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `pass_fail_flag` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `photo_evidence_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence Count');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `photo_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence Reference');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `re_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `re_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Audit Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(SS|FW|HO|RS)[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `signage_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Signage Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `store_manager_acknowledgement_flag` SET TAGS ('dbx_business_glossary_term' = 'Store Manager Acknowledgement Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `total_zones_assessed` SET TAGS ('dbx_business_glossary_term' = 'Total Zones Assessed');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `vm_directive_version` SET TAGS ('dbx_business_glossary_term' = 'Visual Merchandising (VM) Directive Version');
ALTER TABLE `apparel_fashion_ecm`.`store`.`vm_compliance_check` ALTER COLUMN `window_display_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Window Display Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `markdown_event_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Event Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `merchandise_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Hierarchy ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Non Conformance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `otb_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Open-to-Buy (OTB) Budget ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `price_change_event_id` SET TAGS ('dbx_business_glossary_term' = 'Price Change Event ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `site_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Site Promotion Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Markdown Approval Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Markdown Authorization Reference');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_value_regex' = 'store_only|online_only|all_channels|bopis|ship_from_store');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `cost_price` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Price');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `cost_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Markdown Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Markdown End Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Markdown Event Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|suspended|completed|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `initial_markup_pct` SET TAGS ('dbx_business_glossary_term' = 'Initial Markup Percentage (IMU)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `maintained_markup_pct` SET TAGS ('dbx_business_glossary_term' = 'Maintained Markup Percentage (MMU)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `markdown_amount` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `markdown_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `markdown_event_number` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Event Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `markdown_level` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Level');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `markdown_level` SET TAGS ('dbx_value_regex' = 'sku|style|class|subclass|department');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `markdown_pct` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Percentage');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `markdown_price` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Price');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `markdown_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `markdown_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `markdown_type` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `markdown_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|promotional|clearance');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `msrp_price` SET TAGS ('dbx_business_glossary_term' = 'Manufacturers Suggested Retail Price (MSRP)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `msrp_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Markdown Event Notes');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `on_hand_qty` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity at Markdown');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `original_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Original Retail Price');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `original_retail_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `pos_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Applied Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `price_label_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Label Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `price_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `rfid_repriced_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Repriced Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `sell_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Sell-Through Rate (STR)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'ORM|SAP_CAR|ANAPLAN|MANUAL');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `units_sold_during_event` SET TAGS ('dbx_business_glossary_term' = 'Units Sold During Markdown Event');
ALTER TABLE `apparel_fashion_ecm`.`store`.`markdown_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` SET TAGS ('dbx_subdomain' = 'location_operations');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `shrinkage_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Incident ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Loss Prevention (LP) Investigator ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `fiscal_week_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Week ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Involved Profile Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Transaction ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `store_cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `waste_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `apprehension_made` SET TAGS ('dbx_business_glossary_term' = 'Apprehension Made Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `color_code` SET TAGS ('dbx_business_glossary_term' = 'Color Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `cost_value_lost` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Value Lost');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `cost_value_lost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Discovery Method');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `eas_alarm_triggered` SET TAGS ('dbx_business_glossary_term' = 'Electronic Article Surveillance (EAS) Alarm Triggered');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `gl_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|resolved|closed|escalated|voided');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `inventory_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `lp_case_number` SET TAGS ('dbx_business_glossary_term' = 'Loss Prevention (LP) Case Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `lp_case_number` SET TAGS ('dbx_value_regex' = '^LP-[A-Z0-9]{4,20}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `merchandise_category` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Category');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `multi_sku_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-SKU Incident Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `organized_retail_crime_flag` SET TAGS ('dbx_business_glossary_term' = 'Organized Retail Crime (ORC) Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `police_report_number` SET TAGS ('dbx_business_glossary_term' = 'Police Report Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `quantity_lost` SET TAGS ('dbx_business_glossary_term' = 'Quantity Lost');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `recovery_quantity` SET TAGS ('dbx_business_glossary_term' = 'Recovery Quantity');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `recovery_value` SET TAGS ('dbx_business_glossary_term' = 'Recovery Value');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `recovery_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'written_off|recovered|insurance_claim|vendor_chargeback|employee_restitution|no_action');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `retail_value_lost` SET TAGS ('dbx_business_glossary_term' = 'Retail Value Lost');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `retail_value_lost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `rfid_exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Exception Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `shrinkage_type` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `shrinkage_type` SET TAGS ('dbx_value_regex' = 'external_theft|internal_theft|administrative_error|vendor_fraud|damage_spoilage');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `size_code` SET TAGS ('dbx_business_glossary_term' = 'Size Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `store_zone` SET TAGS ('dbx_business_glossary_term' = 'Store Zone');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `style_number` SET TAGS ('dbx_business_glossary_term' = 'Style Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `unit_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Retail (AUR) Price');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `unit_retail_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12,14}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`shrinkage_incident` ALTER COLUMN `video_evidence_flag` SET TAGS ('dbx_business_glossary_term' = 'Video Evidence Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` SET TAGS ('dbx_subdomain' = 'location_operations');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `store_cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cycle Count ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Count Schedule ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `fiscal_week_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Week Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Counter Associate ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `adjustment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment Document Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `adjustment_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment Posted Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `arts_conformance_version` SET TAGS ('dbx_business_glossary_term' = 'NRF ARTS InventoryCount Conformance Version');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `bopis_reserved_qty` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Reserved Quantity');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `color_code` SET TAGS ('dbx_business_glossary_term' = 'Color Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Count Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `count_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count End Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'manual|rfid_scan|barcode_scan|hybrid');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `count_number` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `count_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{4}-[0-9]{2}-[0-9]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `count_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Start Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|reconciled|approved|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'scheduled|ad_hoc|full_store|spot_check|post_shrinkage');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location Type');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'sales_floor|stockroom|fitting_room|receiving|display|vault');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `physical_count_qty` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Quantity');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `recount_qty` SET TAGS ('dbx_business_glossary_term' = 'Recount Quantity');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `recount_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `retail_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Retail Unit Price');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `retail_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `rfid_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Verified Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `ship_from_store_reserved_qty` SET TAGS ('dbx_business_glossary_term' = 'Ship-From-Store Reserved Quantity');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `size_code` SET TAGS ('dbx_business_glossary_term' = 'Size Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_CAR|SAP_S4|MANHATTAN_WMS|MANUAL');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `style_number` SET TAGS ('dbx_business_glossary_term' = 'Style Number');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `system_on_hand_qty` SET TAGS ('dbx_business_glossary_term' = 'System On-Hand Quantity');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12,14}$');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `variance_cost_value` SET TAGS ('dbx_business_glossary_term' = 'Variance Cost Value');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `variance_cost_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `variance_qty` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `variance_retail_value` SET TAGS ('dbx_business_glossary_term' = 'Variance Retail Value');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `variance_retail_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cycle_count` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Store Zone Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` SET TAGS ('dbx_subdomain' = 'location_operations');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` SET TAGS ('dbx_association_edges' = 'store.retail_store,marketing.campaign');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ALTER COLUMN `campaign_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Participation ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ALTER COLUMN `store_actual_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Store Actual Sales Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ALTER COLUMN `store_budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Store Budget Allocated Amount');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ALTER COLUMN `store_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Store Compliance Flag');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ALTER COLUMN `store_end_date` SET TAGS ('dbx_business_glossary_term' = 'Store End Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ALTER COLUMN `store_participation_status` SET TAGS ('dbx_business_glossary_term' = 'Store Participation Status');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ALTER COLUMN `store_start_date` SET TAGS ('dbx_business_glossary_term' = 'Store Start Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ALTER COLUMN `store_target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Store Target Impressions');
ALTER TABLE `apparel_fashion_ecm`.`store`.`campaign_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` SET TAGS ('dbx_subdomain' = 'fulfillment_services');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` SET TAGS ('dbx_association_edges' = 'store.retail_store,ecommerce.digital_storefront');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ALTER COLUMN `storefront_fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Store Storefront Fulfillment Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Store Storefront Fulfillment - Digital Storefront Id');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store Storefront Fulfillment - Retail Store Id');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ALTER COLUMN `bopis_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick-up In Store Enabled');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Configuration Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Configuration End Date');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ALTER COLUMN `fulfillment_priority` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Priority Rank');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ALTER COLUMN `inventory_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Inventory Allocation Percentage');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ALTER COLUMN `service_level_agreement_hours` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Service Level Agreement Hours');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ALTER COLUMN `ship_from_store_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Ship From Store Enabled');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `apparel_fashion_ecm`.`store`.`storefront_fulfillment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cluster` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cluster` SET TAGS ('dbx_subdomain' = 'location_operations');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cluster` ALTER COLUMN `store_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cluster` ALTER COLUMN `parent_store_cluster_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cluster` ALTER COLUMN `cluster_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`store_cluster` ALTER COLUMN `cluster_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`register` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `apparel_fashion_ecm`.`store`.`register` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`register` ALTER COLUMN `replaced_register_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`register` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`register` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`register` ALTER COLUMN `payment_terminal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`register` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`fiscal_week` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`fiscal_week` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `apparel_fashion_ecm`.`store`.`fiscal_week` ALTER COLUMN `fiscal_week_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Week Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`fiscal_week` ALTER COLUMN `prior_year_fiscal_week_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`zone` SET TAGS ('dbx_subdomain' = 'location_operations');
ALTER TABLE `apparel_fashion_ecm`.`store`.`zone` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` SET TAGS ('dbx_subdomain' = 'location_operations');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `parent_district_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `annual_sales_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`district` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`store`.`planogram` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`store`.`planogram` SET TAGS ('dbx_subdomain' = 'location_operations');
ALTER TABLE `apparel_fashion_ecm`.`store`.`planogram` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Identifier');
ALTER TABLE `apparel_fashion_ecm`.`store`.`planogram` ALTER COLUMN `superseded_planogram_id` SET TAGS ('dbx_self_ref_fk' = 'true');
