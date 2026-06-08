-- Schema for Domain: sales | Business: Consumer Goods | Version: v1_mvm
-- Generated on: 2026-05-05 11:04:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `consumer_goods_ecm`.`sales` COMMENT 'Owns commercial sales execution, order management, and revenue transactions across all channels (retail, wholesale, DTC, e-commerce). Manages sales orders, pricing agreements, sales force automation (SFA), retail account call records, POG compliance, RSP/MSRP price management, ACV/TDP/SOM metrics, and field sales KPIs. Integrates with Salesforce Consumer Goods Cloud.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`trade_account` (
    `trade_account_id` BIGINT COMMENT 'Unique identifier for the B2B trade account. Primary key for the trade account master record.',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Consumer goods companies map trade accounts to consumer segments for JBP (Joint Business Planning) and shopper marketing investment allocation. A key account manager expects to know which consumer seg',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation report requires each customer linked to a cost center for internal expense tracking and profitability analysis.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Logistics planning assigns each trade account a primary distribution center for order fulfillment and inventory allocation.',
    `inventory_storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_storage_location. Business justification: VMI replenishment planning requires each trade account to have a designated warehouse (storage location); the default_storage_location_id FK enables the VMI allocation report.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis assigns each customer to a profit center to aggregate revenue and margin in financial reporting.',
    `account_close_date` DATE COMMENT 'The date when this trade account was permanently closed or terminated, if applicable.',
    `account_open_date` DATE COMMENT 'The date when this trade account was first established and approved for business transactions.',
    `account_status` STRING COMMENT 'The current lifecycle status of the trade account: active (operational), inactive (dormant), suspended (temporarily blocked), pending approval (new account under review), credit hold (payment issues), or closed (permanently terminated).. Valid values are `active|inactive|suspended|pending_approval|credit_hold|closed`',
    `account_tier` STRING COMMENT 'Strategic tier classification based on account size, coverage, and business importance: Tier 1 (national key accounts), Tier 2 (regional chains), Tier 3 (local/metro accounts), Tier 4 (independent operators).. Valid values are `tier_1_national|tier_2_regional|tier_3_local|tier_4_independent`',
    `account_type` STRING COMMENT 'The business model classification of the trade partner: retailer (sells to end consumers), distributor (logistics and fulfillment), wholesaler (bulk reseller), foodservice operator (restaurants/catering), or broker (sales intermediary).. Valid values are `retailer|distributor|wholesaler|foodservice_operator|broker`',
    `acv_total` DECIMAL(18,2) COMMENT 'The total All Commodity Volume representing the annual dollar sales volume across all product categories for this retail account, used for market coverage analysis.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The maximum outstanding accounts receivable balance allowed for this trade account before credit hold is applied.',
    `credit_rating` STRING COMMENT 'The credit risk rating assigned to this trade account by internal credit management or external credit bureau (e.g., AAA, AA, A, BBB, BB, B, CCC, D).',
    `currency_code` STRING COMMENT 'The 3-letter ISO 4217 currency code for all financial transactions with this trade account (e.g., USD, CAD, EUR, MXN).. Valid values are `^[A-Z]{3}$`',
    `dba_name` STRING COMMENT 'The trade name or DBA name under which the account operates in the market, if different from legal entity name.',
    `dsd_delivery_flag` BOOLEAN COMMENT 'Indicates whether this trade account receives direct store delivery (DSD) shipments bypassing the retailers distribution center.',
    `duns_number` STRING COMMENT 'The 9-digit DUNS number assigned by Dun & Bradstreet for unique identification of the business entity.. Valid values are `^[0-9]{9}$`',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether this trade account has EDI connectivity enabled for electronic exchange of purchase orders, invoices, and advance ship notices.',
    `gln` STRING COMMENT 'The 13-digit GS1 Global Location Number uniquely identifying the legal entity and physical location of the trade partner.. Valid values are `^[0-9]{13}$`',
    `headquarters_address_line1` STRING COMMENT 'The first line of the street address for the trade account headquarters or primary business location.',
    `headquarters_address_line2` STRING COMMENT 'The second line of the street address (suite, floor, building) for the trade account headquarters.',
    `headquarters_city` STRING COMMENT 'The city name of the trade account headquarters location.',
    `headquarters_country_code` STRING COMMENT 'The 3-letter ISO 3166-1 alpha-3 country code for the trade account headquarters location (e.g., USA, CAN, MEX, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'The postal code or ZIP code of the trade account headquarters location.',
    `headquarters_state_province` STRING COMMENT 'The state, province, or administrative region of the trade account headquarters location.',
    `last_order_date` DATE COMMENT 'The date of the most recent purchase order received from this trade account.',
    `legal_entity_name` STRING COMMENT 'The official registered legal name of the trade partner organization as it appears on legal documents and contracts.',
    `minimum_order_quantity` STRING COMMENT 'The minimum order quantity (in units or cases) required for orders placed by this trade account.',
    `otif_sla_target_percent` DECIMAL(18,2) COMMENT 'The contractual OTIF service level agreement target percentage for order fulfillment performance (e.g., 95.00 represents 95% of orders delivered on time and in full).',
    `payment_method` STRING COMMENT 'The primary payment instrument used by this account: ACH (automated clearing house), wire transfer, check, EDI payment (electronic funds transfer via EDI 820), or credit card.. Valid values are `ach|wire_transfer|check|edi_payment|credit_card`',
    `payment_terms_code` STRING COMMENT 'The standard payment terms code governing invoice payment due dates and early payment discounts (e.g., Net 30, Net 60, 2/10 Net 30).',
    `previous_status` STRING COMMENT 'The account status immediately prior to the most recent status change, maintained for audit trail and lifecycle analysis.',
    `primary_contact_email` STRING COMMENT 'The business email address of the primary contact for order management, invoicing, and account communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact or account manager at the trade partner organization.',
    `primary_contact_phone` STRING COMMENT 'The business phone number of the primary contact, including country code and extension if applicable.',
    `primary_language_code` STRING COMMENT 'The 2-letter ISO 639-1 language code for the preferred communication language with this trade account (e.g., en, es, fr, de).. Valid values are `^[a-z]{2}$`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this trade account master record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this trade account master record was most recently modified.',
    `status_change_reason` STRING COMMENT 'The business reason or justification for the most recent account status change (e.g., payment default, business closure, credit improvement, contract renewal).',
    `status_change_timestamp` TIMESTAMP COMMENT 'The date and time when the most recent account status change occurred.',
    `status_changed_by_user` STRING COMMENT 'The user ID or name of the person who executed the most recent account status change, for audit and accountability purposes.',
    `tax_exemption_flag` BOOLEAN COMMENT 'Indicates whether this trade account holds a valid tax exemption certificate for sales tax or VAT purposes.',
    `tax_number` STRING COMMENT 'The government-issued tax identification number for this legal entity (e.g., EIN in USA, VAT number in EU, GST number in other jurisdictions).',
    `tdp_count` STRING COMMENT 'The total number of distribution points (store locations or outlets) operated by this trade account where products can be sold.',
    `trade_channel` STRING COMMENT 'The primary retail or distribution channel through which this trade account operates: grocery (supermarkets), mass (mass merchandisers), club (warehouse clubs), drug (pharmacy chains), convenience stores, foodservice (restaurants/institutions), or e-commerce (online retailers). [ENUM-REF-CANDIDATE: grocery|mass|club|drug|convenience|foodservice|e-commerce — 7 candidates stripped; promote to reference product]',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this trade account participates in a VMI program where the supplier manages inventory replenishment based on POS or warehouse data.',
    CONSTRAINT pk_trade_account PRIMARY KEY(`trade_account_id`)
) COMMENT 'SSOT master record for all B2B trade customers including retailers, distributors, wholesalers, and foodservice operators. Captures authoritative account identity: legal entity name, trade channel classification (grocery, mass, club, drug, foodservice, e-commerce), account tier, credit rating, payment terms, currency, tax identifiers, DUNS number, GLN (GS1 Global Location Number), primary language, account status, lifecycle dates, and full status change audit history (previous status, new status, change reason, change timestamp, changed-by user). This is the golden record for all trade partner identity — every other customer domain entity references this product via FK.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` (
    `account_hierarchy_id` BIGINT COMMENT 'Unique identifier for the account hierarchy relationship record. Primary key.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the child account in the hierarchy. References the lower-level organizational entity (e.g., store, banner, chain).',
    `primary_trade_account_id` BIGINT COMMENT 'Identifier of the parent account in the hierarchy. References the higher-level organizational entity (e.g., banner, chain, parent corporation).',
    `acv_rollup_flag` BOOLEAN COMMENT 'Indicates whether All Commodity Volume (ACV) metrics should be rolled up from child to parent account. True means include in ACV aggregation; false means exclude. Critical for market coverage and distribution analysis.',
    `approval_status` STRING COMMENT 'Approval status of the hierarchical relationship change. Draft indicates the relationship is being defined; pending approval indicates the relationship is awaiting management review; approved indicates the relationship has been validated; rejected indicates the relationship was not approved.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the business user who approved the hierarchical relationship. Used for audit trail and governance purposes.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the hierarchical relationship was approved. Used for audit trail and compliance reporting.',
    `consolidation_flag` BOOLEAN COMMENT 'Indicates whether financial and operational metrics from the child account should be consolidated into the parent account for reporting purposes. True means consolidate; false means report separately. Critical for All Commodity Volume (ACV), Total Distribution Points (TDP), trade spend, and sales performance roll-ups.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the account hierarchy record was first created in the system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'Date when the hierarchical relationship ends or is no longer valid. Null indicates an open-ended relationship. Critical for historical analysis and point-in-time reporting.',
    `effective_start_date` DATE COMMENT 'Date when the hierarchical relationship becomes effective. Used for temporal tracking of organizational changes, mergers, acquisitions, and restructuring events.',
    `hierarchy_depth` STRING COMMENT 'Numeric depth of the child account within the hierarchy tree, with 1 representing the top level (parent corporation) and increasing numbers representing deeper levels (chain, banner, store). Used for recursive queries and hierarchy traversal.',
    `hierarchy_level` STRING COMMENT 'Level of the child account within the organizational hierarchy. Store represents individual retail locations; banner represents a retail brand or fascia; chain represents a retail chain or group; parent corporation represents the ultimate parent entity; division represents a business division; region represents a geographic region.. Valid values are `store|banner|chain|parent_corporation|division|region`',
    `hierarchy_path` STRING COMMENT 'Materialized path representing the full lineage from root to child account, typically formatted as slash-separated account identifiers (e.g., /1/23/456/7890). Enables efficient ancestor and descendant queries for Sales and Operations Planning (S&OP) and Trade Promotion Management (TPM) reporting.',
    `hierarchy_type` STRING COMMENT 'Type of organizational hierarchy relationship. Commercial hierarchies support sales and trade promotion roll-ups; logistics hierarchies support distribution and delivery planning; financial hierarchies support invoicing and payment consolidation; reporting hierarchies support management reporting structures; legal hierarchies represent corporate ownership; operational hierarchies support day-to-day execution.. Valid values are `commercial|logistics|financial|reporting|legal|operational`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the account hierarchy record was last updated. Used for change tracking and audit purposes.',
    `notes` STRING COMMENT 'Free-text notes or comments about the hierarchical relationship. May include business context, special handling instructions, or historical information about organizational changes.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership or control the parent account has over the child account. Used for proportional consolidation in financial and operational reporting. Range 0.00 to 100.00.',
    `primary_hierarchy_flag` BOOLEAN COMMENT 'Indicates whether this is the primary hierarchical relationship for the child account when multiple hierarchy types exist. True means this is the default hierarchy for reporting and analytics; false means this is a secondary or alternate hierarchy.',
    `relationship_code` STRING COMMENT 'Business code or identifier representing the nature of the parent-child relationship. May include codes for wholly-owned subsidiary, franchise, joint venture, affiliate, or other relationship types specific to the consumer goods trade channel.',
    `relationship_name` STRING COMMENT 'Human-readable name or description of the hierarchical relationship. Provides business context for the parent-child linkage (e.g., Regional Banner Group, Corporate Ownership, Distribution Network).',
    `relationship_status` STRING COMMENT 'Current status of the hierarchical relationship. Active indicates the relationship is currently in effect; inactive indicates the relationship has ended; pending indicates the relationship is awaiting activation; suspended indicates the relationship is temporarily paused; terminated indicates the relationship has been permanently ended.. Valid values are `active|inactive|pending|suspended|terminated`',
    `rollup_weight` DECIMAL(18,2) COMMENT 'Weighting factor applied when rolling up metrics from child to parent account. Used for proportional allocation of All Commodity Volume (ACV), Total Distribution Points (TDP), trade spend, and sales performance when a child account participates in multiple hierarchies or has split ownership.',
    `sales_rollup_flag` BOOLEAN COMMENT 'Indicates whether sales performance metrics should be rolled up from child to parent account. True means include in sales aggregation; false means exclude. Essential for Sales and Operations Planning (S&OP) and Integrated Business Planning (IBP).',
    `source_system` STRING COMMENT 'Name or code of the source system that provided the hierarchical relationship data. May reference Salesforce Consumer Goods Cloud, SAP S/4HANA SD (Sales and Distribution), Oracle Cloud ERP, or other master data management systems.',
    `source_system_code` STRING COMMENT 'Unique identifier of the hierarchical relationship record in the source system. Used for data lineage, reconciliation, and bidirectional synchronization.',
    `tdp_rollup_flag` BOOLEAN COMMENT 'Indicates whether Total Distribution Points (TDP) metrics should be rolled up from child to parent account. True means include in TDP aggregation; false means exclude. Essential for numeric distribution and weighted distribution reporting.',
    `trade_spend_rollup_flag` BOOLEAN COMMENT 'Indicates whether trade promotion spending should be rolled up from child to parent account. True means include in trade spend aggregation; false means exclude. Critical for Trade Promotion Management (TPM) and Trade Promotion Optimization (TPO) reporting.',
    CONSTRAINT pk_account_hierarchy PRIMARY KEY(`account_hierarchy_id`)
) COMMENT 'Defines the parent-child organizational hierarchy of trade accounts, enabling roll-up of ACV, TDP, trade spend, and sales performance from store level to banner, banner to chain, and chain to parent corporation. Captures parent account, child account, hierarchy level (store, banner, chain, parent corporation), effective date range, hierarchy type (commercial, logistics, financial), and consolidation flag. Critical for S&OP and TPM reporting.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`retail_store` (
    `retail_store_id` BIGINT COMMENT 'Unique identifier for the retail store location. Primary key.',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Shopper marketing programs in consumer goods are executed at store level, targeted to the primary consumer segment shopping that store format. Store-level consumer segment assignment drives planogram ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Store‑level budgeting and expense tracking use a cost center per retail store for internal cost accounting.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Store replenishment process requires an assigned distribution center to schedule deliveries and calculate OTIF performance.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Store profitability reporting aggregates sales and costs by profit center, requiring a link from store to profit_center.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Store‑level VMI or direct replenishment ties a retail store to the exact supplier site that ships inventory, needed for logistics and OTIF tracking.',
    `trade_account_id` BIGINT COMMENT 'Reference to the parent trade account, banner, or retail chain that owns or operates this store.',
    `acv_weight` DECIMAL(18,2) COMMENT 'All Commodity Volume (ACV) weighting factor representing this stores share of total market volume, used for distribution and market share calculations.',
    `address_line_1` STRING COMMENT 'Primary street address of the retail store location.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, building, or unit number.',
    `banner_name` STRING COMMENT 'The retail banner or brand under which this store operates (e.g., Walmart Supercenter, Target, Kroger).',
    `city` STRING COMMENT 'City or municipality where the retail store is located.',
    `close_date` DATE COMMENT 'Date when the store permanently closed or is scheduled to close. Null if store is active.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the store is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retail store record was first created in the system.',
    `dsd_route_code` STRING COMMENT 'Route code or identifier for Direct Store Delivery (DSD) logistics and delivery scheduling.',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying this physical store location for Electronic Data Interchange (EDI) and supply chain transactions.. Valid values are `^[0-9]{13}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this retail store record was last updated or modified.',
    `last_visit_date` DATE COMMENT 'Date of the most recent retail execution visit or sales call to this store location.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the store location for mapping and route optimization.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the store location for mapping and route optimization.',
    `next_scheduled_visit_date` DATE COMMENT 'Date of the next planned retail execution visit or sales call to this store location.',
    `open_date` DATE COMMENT 'Date when the store first opened for business operations.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the store (e.g., Mon-Fri 8am-10pm, Sat-Sun 9am-9pm) used for retail execution visit planning.',
    `osa_target_pct` DECIMAL(18,2) COMMENT 'Target On Shelf Availability (OSA) percentage for this store indicating expected in-stock performance for key Stock Keeping Units (SKUs).',
    `otif_sla_target_pct` DECIMAL(18,2) COMMENT 'Target On Time In Full (OTIF) service level percentage agreed with this store for delivery performance measurement.',
    `planogram_zone` STRING COMMENT 'Planogram zone or cluster assignment indicating which shelf layout and assortment plan applies to this store.',
    `pos_system_type` STRING COMMENT 'Type or vendor of the Point of Sale (POS) system used at this store for transaction processing and sales data capture.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the store location used for logistics and Direct Store Delivery (DSD) routing.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the store is located.',
    `store_format` STRING COMMENT 'The retail format classification of the store indicating size, assortment, and operational model. [ENUM-REF-CANDIDATE: hypermarket|supermarket|convenience|club|drug|dollar|specialty|e-commerce_fulfillment_center — 8 candidates stripped; promote to reference product]',
    `store_name` STRING COMMENT 'The official name or designation of the retail store location.',
    `store_number` STRING COMMENT 'The retailer-assigned unique store number or code used for operational identification and Direct Store Delivery (DSD) routing.',
    `store_phone` STRING COMMENT 'Primary contact phone number for the retail store location.',
    `store_size_sq_ft` STRING COMMENT 'Total retail selling space of the store measured in square feet, used for All Commodity Volume (ACV) and Total Distribution Points (TDP) calculations.',
    `store_status` STRING COMMENT 'Current operational status of the retail store location.. Valid values are `active|inactive|pending_opening|temporarily_closed|permanently_closed|under_renovation`',
    `store_tier` STRING COMMENT 'Strategic tier classification (e.g., Tier 1, Tier 2) indicating store importance based on volume, profitability, or strategic value for prioritized retail execution.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `tdp_weight` DECIMAL(18,2) COMMENT 'Total Distribution Points (TDP) weighting factor representing this stores contribution to numeric distribution metrics.',
    `trading_area` STRING COMMENT 'Geographic trading area or market designation (e.g., metro area, region) used for sales territory and distribution planning.',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this store participates in a Vendor Managed Inventory (VMI) program where the manufacturer manages replenishment.',
    CONSTRAINT pk_retail_store PRIMARY KEY(`retail_store_id`)
) COMMENT 'Individual physical retail store or outlet location associated with a trade account banner or chain. Captures store number, store name, banner, format (hypermarket, supermarket, convenience, club, drug, dollar, e-commerce fulfillment center), store size (sq ft), trading area, store open/close dates, store manager, operating hours, and planogram zone assignment. Used for retail execution, OSA tracking, and DSD route management.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`account_segment` (
    `account_segment_id` BIGINT COMMENT 'Unique identifier for the account segment record. Primary key.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: account_segment carries an assigned_sales_region STRING column that is a denormalized reference to the sales territory. Normalizing this to territory_id -> territory.territory_id replaces the free-tex',
    `trade_account_id` BIGINT COMMENT 'Reference to the trade account (retailer, distributor, wholesaler, or foodservice customer) to which this segmentation applies.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this account segment assignment is currently active and in use for commercial operations.',
    `acv_tier` STRING COMMENT 'Tier classification based on All Commodity Volume, representing the total retail sales volume of the account across all product categories.. Valid values are `high|medium|low|not_measured`',
    `applicable_region` STRING COMMENT 'Geographic region where this segmentation applies (e.g., North America, EMEA, APAC, LATAM).',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this segment assignment was formally approved.',
    `channel_tier` STRING COMMENT 'Hierarchical tier assignment within the channel, indicating relative importance or volume contribution (tier_1 = highest, tier_4 = lowest).. Valid values are `tier_1|tier_2|tier_3|tier_4|unassigned`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this account segment record was first created in the system.',
    `credit_limit_tier` STRING COMMENT 'Credit limit tier classification for accounts in this segment, determining maximum outstanding receivables allowed.. Valid values are `unlimited|high|medium|low|restricted`',
    `customer_tier` STRING COMMENT 'Customer value tier assignment based on revenue, volume, or strategic importance (platinum = highest value, standard = baseline).. Valid values are `platinum|gold|silver|bronze|standard`',
    `dsd_eligible_flag` BOOLEAN COMMENT 'Indicates whether the account is eligible for Direct Store Delivery, bypassing distribution centers for direct product delivery to retail locations.',
    `edi_trading_partner_flag` BOOLEAN COMMENT 'Indicates whether the account is configured as an EDI trading partner for automated order and invoice exchange.',
    `effective_end_date` DATE COMMENT 'Date when this account segment assignment expires or is superseded by a new assignment. Null indicates open-ended assignment.',
    `effective_start_date` DATE COMMENT 'Date when this account segment assignment becomes effective and applicable for business operations.',
    `field_sales_call_frequency` STRING COMMENT 'Recommended frequency of field sales representative visits based on account segment and strategic priority.. Valid values are `weekly|biweekly|monthly|quarterly|annual|as_needed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this account segment record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when this account segment assignment was last reviewed and validated by commercial leadership.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this account segment assignment.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this account segment assignment, capturing additional context or special considerations.',
    `otif_sla_target_pct` DECIMAL(18,2) COMMENT 'Target percentage for On Time In Full delivery performance as defined in the service level agreement for this account segment.',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code applicable to this account segment (e.g., NET30, NET60, COD).. Valid values are `^[A-Z0-9_]{2,10}$`',
    `pricing_strategy` STRING COMMENT 'Pricing strategy applicable to this account segment (EDLP = Everyday Low Price, Hi-Lo = High-Low promotional pricing).. Valid values are `edlp|hi_lo|hybrid|custom|standard`',
    `primary_channel_code` STRING COMMENT 'Code representing the primary channel classification (e.g., RETAIL, FOODSERVICE, WHOLESALE, DTC).. Valid values are `^[A-Z0-9_]{2,15}$`',
    `primary_channel_name` STRING COMMENT 'Full name of the primary channel (e.g., Retail, Foodservice, Wholesale, Direct to Consumer).',
    `segment_assignment_reason` STRING COMMENT 'Business rationale or trigger for this segment assignment (e.g., annual review, volume threshold met, strategic partnership established).',
    `segment_code` STRING COMMENT 'Short alphanumeric code representing the commercial segment assignment (e.g., STRATEGIC, KEY_ACCT, REGIONAL, EMERGING, TAIL).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `segment_name` STRING COMMENT 'Full descriptive name of the commercial segment (e.g., Strategic Account, Key Account, Regional Account, Emerging Account, Tail Account).',
    `segmentation_model_version` STRING COMMENT 'Version identifier of the segmentation model or algorithm used to assign this segment (e.g., 2024.Q1, V3.2).. Valid values are `^[A-Z0-9._-]{1,20}$`',
    `strategic_priority_flag` BOOLEAN COMMENT 'Indicates whether this account is designated as a strategic priority for executive engagement and resource allocation.',
    `tdp_tier` STRING COMMENT 'Tier classification based on Total Distribution Points, representing the weighted distribution reach of the account.. Valid values are `high|medium|low|not_measured`',
    `trade_promotion_eligibility` STRING COMMENT 'Eligibility status for trade promotion programs and funding allocation based on segment classification.. Valid values are `full|limited|excluded|pending_review`',
    `vmi_eligible_flag` BOOLEAN COMMENT 'Indicates whether the account is eligible for Vendor Managed Inventory programs where the supplier manages inventory replenishment.',
    CONSTRAINT pk_account_segment PRIMARY KEY(`account_segment_id`)
) COMMENT 'Commercial segmentation, channel classification taxonomy, and go-to-market tier assignment for trade accounts. Owns the complete channel reference hierarchy (primary: retail, foodservice, wholesale, DTC; secondary: grocery, mass, club, drug, convenience, e-commerce, QSR, institutional) as well as the commercial segment assignment (strategic, key account, regional, emerging, tail). Captures channel code, channel name, channel tier, segmentation model version, customer tier, strategic priority flag, assigned sales region, applicable region, active status, and effective date range. Drives trade promotion allocation, field sales call frequency, and standardized channel reporting across all downstream domains.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`order` (
    `order_id` BIGINT COMMENT 'Unique system identifier for the sales order record. Primary key for the order entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost Center Allocation report requires each sales order to be charged to a cost center for internal expense tracking.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center assigned to fulfill this order. Determines inventory allocation and shipping origin.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Order‑level Promotion Event Attribution report requires linking each order to the specific promotion event that generated the sale.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.pricing_agreement. Business justification: Orders are governed by a pricing agreement; linking captures contract context.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sales orders are attributed to profit centers for revenue forecasting and P&L planning. Consumer goods companies allocate order pipeline to profit centers (brand/channel/region) for management reporti',
    `retail_store_id` BIGINT COMMENT 'Reference to the customer location where goods should be delivered. May differ from bill-to location for multi-site customers.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative or account manager who created or owns this order. Used for commission calculation and SFA reporting.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Order Fulfillment Allocation report requires linking each order to the supply network node that will source inventory for accurate ATP/CTP calculations.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Directly assigning a territory to an order simplifies reporting and analytics.',
    `trade_account_id` BIGINT COMMENT 'Reference to the customer or retail account that placed this order. Links to the customer master record.',
    `actual_delivery_date` DATE COMMENT 'The actual date when the order was delivered to the customer. Used to calculate OTIF performance and delivery variance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the order was approved for fulfillment. Marks transition from draft/pending to confirmed status in the order lifecycle.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded reason for order cancellation if status is cancelled. Used for root cause analysis and process improvement.',
    `channel_type` STRING COMMENT 'The commercial channel through which the order was received. Critical for channel-specific analytics and revenue attribution.. Valid values are `retail|wholesale|dtc|ecommerce|distributor`',
    `cogs_amount` DECIMAL(18,2) COMMENT 'Total cost of goods sold for all items on this order. Used for gross margin calculation and profitability analysis.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by supply chain and logistics based on ATP/CTP availability. Committed date for OTIF tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this order record was first created in the database. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts on this order. Determines currency for pricing, tax, and totals.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the order including trade promotions, volume discounts, and negotiated price reductions.',
    `distribution_channel` STRING COMMENT 'The distribution channel through which products are sold. Defines the route-to-market and channel-specific pricing rules.. Valid values are `^[A-Z0-9]{2,10}$`',
    `division` STRING COMMENT 'The product division or business unit for this order. Used for divisional P&L reporting and product line segmentation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `freight_amount` DECIMAL(18,2) COMMENT 'Freight and shipping charges applied to the order. May be customer-paid or supplier-absorbed depending on terms.',
    `gross_margin_amount` DECIMAL(18,2) COMMENT 'Gross profit on the order calculated as total revenue less COGS. Key profitability metric for order-level margin analysis.',
    `incoterm` STRING COMMENT 'Three-letter Incoterm code defining the transfer of risk and cost responsibility between buyer and seller. Examples: FOB, CIF, DDP.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this order record was last updated. Used for change tracking and data synchronization across systems.',
    `order_date` DATE COMMENT 'The date when the sales order was placed or created by the customer. Primary business event timestamp for order lifecycle.',
    `order_number` STRING COMMENT 'Externally visible business identifier for the sales order. Used for customer communication and order tracking across systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_source` STRING COMMENT 'The system or channel through which the order was originally captured. Used for channel attribution and system integration tracking.. Valid values are `web_portal|edi|sales_rep|call_center|mobile_app|marketplace`',
    `order_status` STRING COMMENT 'Current lifecycle status of the sales order indicating its position in the order-to-cash workflow. [ENUM-REF-CANDIDATE: draft|open|confirmed|in_fulfillment|shipped|delivered|cancelled — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the order based on fulfillment method and business process. Determines routing, pricing, and delivery rules.. Valid values are `standard|rush|drop_ship|direct_store_delivery|promotional|sample`',
    `otif_status` STRING COMMENT 'Indicates whether the order was delivered on time and in full per customer commitment. Key supply chain KPI for customer service measurement.. Valid values are `on_time_in_full|late|partial|not_applicable`',
    `payment_terms` STRING COMMENT 'The payment terms code defining the credit period and discount conditions for this order. Examples: NET30, 2/10NET30.. Valid values are `^[A-Z0-9]{2,10}$`',
    `priority` STRING COMMENT 'Priority classification for order fulfillment. Determines sequencing in warehouse picking and expedited shipping eligibility.. Valid values are `standard|high|urgent|critical`',
    `purchase_order_number` STRING COMMENT 'The customers purchase order number provided at order placement. Required for EDI transactions and invoice matching.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `requested_delivery_date` DATE COMMENT 'The delivery date requested by the customer at the time of order placement. Used for OTIF performance measurement.',
    `sales_office` STRING COMMENT 'The sales office or branch that originated this order. Used for territory management and sales force performance tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `sales_organization` STRING COMMENT 'The sales organization responsible for this order. Defines the selling entity and organizational hierarchy for reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `sap_sd_document_number` STRING COMMENT 'The native SAP SD sales order document number. Used for system-to-system integration and ERP traceability.. Valid values are `^[0-9]{10}$`',
    `shipping_method` STRING COMMENT 'The transportation mode selected for order delivery. Impacts delivery time, cost, and carrier selection.. Valid values are `ground|air|ocean|rail|courier|dsd`',
    `special_instructions` STRING COMMENT 'Free-text field for customer-specific delivery instructions, packaging requirements, or handling notes for warehouse and logistics teams.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item amounts before taxes, discounts, and freight charges. Base revenue amount for the order.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the order including sales tax, VAT, GST, and other applicable taxes per jurisdiction.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount for the order including subtotal, taxes, freight, less discounts. The invoiced amount for revenue recognition.',
    CONSTRAINT pk_order PRIMARY KEY(`order_id`)
) COMMENT 'Core sales order record capturing all commercial sales transactions across retail, wholesale, DTC, and e-commerce channels. Contains order header details (order number, date, channel type, status, delivery dates, OTIF status, payment terms, currency, totals, SAP SD document number) and line-level detail (SKU/GTIN, quantities ordered/confirmed/shipped, unit pricing, discounts, trade promotion references, line status, COGS, gross margin, delivery schedule). Serves as the primary transactional backbone of the sales domain enabling both order-level and SKU-level revenue and margin analysis.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique system identifier for the invoice record. Primary key.',
    `batch_release_id` BIGINT COMMENT 'Foreign key linking to quality.batch_release. Business justification: In regulated consumer goods, an invoice for a shipped batch must reference the batch release record confirming QP approval for sale. Invoicing against released batches is a GMP compliance requiremen',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial consolidation needs each invoice posted to the responsible cost center for accurate profit analysis.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Invoice‑level trade spend reconciliation needs to reference the promotion event responsible for the invoiced sales.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Sales invoices post revenue to specific GL accounts (revenue recognition, trade discounts, freight). Consumer goods order-to-cash requires direct GL account assignment on invoices for financial statem',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Consumer goods regulatory compliance and recall management requires tracing invoiced products to specific lot/batch records. When a recall occurs, companies must identify all invoices containing affec',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.pricing_agreement. Business justification: Invoice billing often follows a pricing agreement; linking provides traceability.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Financial reconciliation links each invoice to the specific production order that produced the sold goods, supporting cost of goods sold analysis.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Consumer goods companies report revenue by profit center (brand, channel, region). Invoice-level profit center assignment drives P&L reporting and gross margin analysis by business unit — a core requi',
    `retail_store_id` BIGINT COMMENT 'Reference to the physical delivery location where goods were shipped. May differ from bill-to account for multi-site customers.',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order that this invoice fulfills. Links invoice to order for order-to-cash reconciliation.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account, distributor, or DTC consumer who is billed on this invoice. The sold-to party in the order-to-cash process.',
    `billing_period_end_date` DATE COMMENT 'End date of the period covered by this invoice. Used for period-based billing and revenue allocation.',
    `billing_period_start_date` DATE COMMENT 'Start date of the period covered by this invoice. Relevant for subscription, service, or recurring billing scenarios.',
    `billing_type` STRING COMMENT 'Classification of the invoice document type: standard invoice for goods/services, credit memo for returns/adjustments, debit memo for additional charges, proforma for advance notice, intercompany for internal transfers, or consignment for stock-based billing.. Valid values are `standard|credit_memo|debit_memo|proforma|intercompany|consignment`',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was cancelled or voided. Null for active invoices. Used for cancelled invoice reporting and audit.',
    `cost_of_goods_sold_amount` DECIMAL(18,2) COMMENT 'Total standard cost of all products billed on this invoice. Used for gross margin calculation and profitability analysis at invoice level.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this invoice record was first created in the billing system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP). All monetary amounts on this invoice are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
    `days_sales_outstanding` STRING COMMENT 'Number of days between invoice date and payment date (or current date if unpaid). Key metric for working capital management and customer payment behavior analysis.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator that the customer has raised a dispute or deduction claim against this invoice. Triggers collections hold and dispute resolution workflow.',
    `dispute_reason_code` STRING COMMENT 'Standardized code categorizing the reason for invoice dispute. Enables root cause analysis of deductions and customer dissatisfaction. [ENUM-REF-CANDIDATE: pricing|quantity|quality|delivery|promotion|damaged_goods|not_received — 7 candidates stripped; promote to reference product]',
    `distribution_channel_code` STRING COMMENT 'Code representing the distribution channel through which the sale was made (e.g., retail, wholesale, DTC, e-commerce). Enables channel-specific revenue analysis.. Valid values are `^[A-Z0-9]{2,4}$`',
    `division_code` STRING COMMENT 'Code identifying the product division or business unit to which invoice revenue is attributed. Supports divisional P&L reporting.. Valid values are `^[A-Z0-9]{2,4}$`',
    `due_date` DATE COMMENT 'The date by which payment is expected per the agreed payment terms. Used for DSO tracking and collections management.',
    `edi_document_number` STRING COMMENT 'Unique EDI transaction control number assigned when invoice is transmitted via EDI 810. Used for EDI audit trail and error resolution.',
    `edi_transmission_status` STRING COMMENT 'Status of EDI 810 invoice transmission to customers system. Tracks electronic invoice delivery for large retail and distributor accounts.. Valid values are `not_applicable|pending|transmitted|acknowledged|rejected|failed`',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Total freight, shipping, and logistics charges added to the invoice. May be separately itemized for customer transparency.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice value before any deductions, including all line items, charges, and fees but before trade discounts and taxes.',
    `gross_margin_amount` DECIMAL(18,2) COMMENT 'Gross profit on this invoice, calculated as net_amount minus cost_of_goods_sold_amount. Key profitability metric for customer and product analysis.',
    `incoterm_code` STRING COMMENT 'Three-letter Incoterm code defining the division of costs and risks between buyer and seller (e.g., FOB, CIF, DDP). Critical for international trade invoicing.. Valid values are `^[A-Z]{3}$`',
    `invoice_date` DATE COMMENT 'The date the invoice was officially issued to the customer. This is the accounting date used for revenue recognition and aging calculations.',
    `invoice_number` STRING COMMENT 'Externally-visible unique invoice document number used for customer communication, payment reconciliation, and accounts receivable tracking. Typically follows company-specific numbering scheme.. Valid values are `^[A-Z0-9]{8,20}$`',
    `invoice_status` STRING COMMENT 'Current state of the invoice in the accounts receivable lifecycle. Tracks progression from draft through payment completion or dispute resolution. [ENUM-REF-CANDIDATE: draft|issued|sent|partially_paid|paid|overdue|cancelled|disputed — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this invoice record. Tracks changes for audit and data quality monitoring.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final invoice total after all discounts, charges, and taxes. This is the amount due from the customer and recorded in accounts receivable.',
    `notes` STRING COMMENT 'Free-text field for special instructions, billing notes, dispute comments, or customer-specific messaging that appears on the invoice document.',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the invoice. Calculated as net_amount minus paid_amount. Used for aging analysis and collections prioritization.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Cumulative amount received against this invoice across all payment transactions. Used to calculate outstanding balance.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used (or expected) for settling this invoice. Influences payment processing and reconciliation workflows. [ENUM-REF-CANDIDATE: wire_transfer|ach|check|credit_card|edi_payment|cash|direct_debit — 7 candidates stripped; promote to reference product]',
    `payment_reference_number` STRING COMMENT 'External payment reference number provided by the customer or payment processor for reconciliation. Links invoice to bank statement or remittance advice.',
    `payment_status` STRING COMMENT 'Current payment settlement status indicating whether the invoice has been paid in full, partially, or remains outstanding.. Valid values are `unpaid|partially_paid|paid|overpaid|written_off`',
    `payment_terms_code` STRING COMMENT 'Standard code representing the payment terms agreement (e.g., Net 30, Net 60, 2/10 Net 30). Determines due date calculation and early payment discount eligibility.. Valid values are `^[A-Z0-9]{2,10}$`',
    `purchase_order_number` STRING COMMENT 'Customers purchase order number that authorized this invoice. Required for PO-based invoicing and three-way match reconciliation.',
    `revenue_recognition_category` STRING COMMENT 'Classification determining how revenue from this invoice is recognized per accounting standards (ASC 606 / IFRS 15). Drives financial reporting and revenue allocation logic.. Valid values are `point_in_time|over_time|deferred|subscription|service`',
    `sales_organization_code` STRING COMMENT 'Code identifying the sales organization unit responsible for this invoice. Used for revenue attribution and sales performance reporting.. Valid values are `^[A-Z0-9]{2,6}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Sum of all tax amounts (sales tax, VAT, GST, excise) applied to the invoice. Calculated based on tax jurisdiction and product tax classification.',
    `trade_discount_amount` DECIMAL(18,2) COMMENT 'Total trade promotion discounts, volume rebates, and negotiated price reductions applied at invoice level. Reduces gross amount to arrive at net taxable amount.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Commercial billing document issued to retail accounts, distributors, or DTC consumers upon order fulfillment. Contains invoice header (invoice number, date, billing type, payment terms, gross/net values, tax, currency, payment status, DSO tracking, EDI status) and line-level detail (SKU/GTIN, billed quantities, unit prices, trade discounts, net line values, tax codes, revenue recognition categories, COGS allocation). Links to the originating sales order and serves as the accounts receivable source record enabling SKU-level revenue and profitability reporting.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` (
    `pricing_agreement_id` BIGINT COMMENT 'Unique identifier for the pricing agreement record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Trade spend and promotional allowances in pricing agreements are charged to cost centers for budget control. Consumer goods companies track trade investment by cost center to manage selling expense an',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Pricing agreements with rebates, promotional allowances, and volume discounts require GL account assignment for trade spend accrual posting. Consumer goods trade promotion accounting mandates this lin',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.product_hierarchy. Business justification: Pricing agreements are defined per product hierarchy to set prices for all SKUs within that hierarchy; essential for price‑setting reports.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Pricing agreements are negotiated per brand for trade accounts; brand-level pricing is required for contract management.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to sales.price_list. Business justification: A pricing_agreement is a contractual arrangement that starts from a base price list and applies account-specific discounts, rebates, and allowances on top. The price_list is the master reference from ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: SKU-level trade pricing is a core consumer goods commercial process: key account managers negotiate net prices per SKU with retailers. pricing_agreement already links to hierarchy for category-scope a',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Cost-based pricing in consumer goods requires pricing agreements to reference standard costs for margin floor validation. Category managers use standard cost to ensure contracted net prices maintain m',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Gross margin and cost-to-serve reporting requires linking the customer-facing pricing agreement (sell price) to the supplier contract (cost basis). Consumer goods category managers and finance teams r',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account, distributor, or wholesale customer with whom this pricing agreement is established.',
    `agreement_name` STRING COMMENT 'Descriptive name or title of the pricing agreement for business reference and reporting.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the pricing agreement, used in contracts and SAP SD condition records.. Valid values are `^[A-Z0-9]{8,20}$`',
    `agreement_type` STRING COMMENT 'Classification of the pricing agreement structure: standard pricing, volume-based tiered discounts, promotional allowances, rebate structures, long-term contract, or spot pricing.. Valid values are `standard|volume_tiered|promotional|rebate|contract|spot`',
    `approval_status` STRING COMMENT 'Current approval workflow status indicating whether the pricing agreement has been reviewed and authorized by management.. Valid values are `not_submitted|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the manager or executive who approved the pricing agreement.',
    `approved_date` DATE COMMENT 'Date when the pricing agreement was formally approved by authorized personnel.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the pricing agreement automatically renews upon expiration unless terminated by either party.',
    `base_list_price` DECIMAL(18,2) COMMENT 'Standard manufacturer list price before any discounts, allowances, or negotiated reductions are applied.',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the legal contract document or master agreement associated with this pricing agreement.',
    `contracted_net_price` DECIMAL(18,2) COMMENT 'Agreed net price per unit after applying all negotiated discounts and allowances as defined in the pricing agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all pricing amounts in this agreement are denominated.. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount off the base list price granted to the customer under this pricing agreement.',
    `distribution_channel` STRING COMMENT 'Distribution channel through which products under this pricing agreement are sold (e.g., retail, wholesale, DTC, e-commerce).',
    `division` STRING COMMENT 'Product division or business unit to which this pricing agreement applies.',
    `effective_end_date` DATE COMMENT 'Date when the pricing agreement expires or terminates. Nullable for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the pricing agreement becomes active and enforceable for order pricing.',
    `geographic_scope` STRING COMMENT 'Geographic region or territory where this pricing agreement is valid and enforceable.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required per transaction to qualify for the contracted pricing under this agreement.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum monetary value required per order to qualify for the contracted pricing terms.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the pricing agreement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing agreement record was last modified or updated.',
    `msrp_price` DECIMAL(18,2) COMMENT 'Manufacturer suggested retail price for consumer-facing pricing, used for price positioning and margin calculation.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or clarifications related to the pricing agreement.',
    `payment_terms` STRING COMMENT 'Agreed payment terms defining the due date and discount conditions (e.g., Net 30, 2/10 Net 30).',
    `price_protection_flag` BOOLEAN COMMENT 'Indicates whether the customer is protected from price increases during the agreement period.',
    `pricing_agreement_status` STRING COMMENT 'Current lifecycle status of the pricing agreement indicating its operational state and enforceability.. Valid values are `draft|pending_approval|active|suspended|expired|terminated`',
    `pricing_tier` STRING COMMENT 'Tiered pricing level assigned to the customer based on volume commitments, strategic importance, or negotiated terms.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|custom`',
    `product_scope` STRING COMMENT 'Defines the breadth of product coverage: all products, specific product category, individual SKUs, or brand-level pricing.. Valid values are `all_products|product_category|specific_skus|brand`',
    `promotional_allowance` DECIMAL(18,2) COMMENT 'Additional allowance or discount provided to support trade promotions, in-store displays, or marketing activities.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Fixed monetary rebate amount granted per unit or per transaction under the pricing agreement terms.',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'Percentage rebate granted to the customer upon achieving volume thresholds or other performance criteria defined in the agreement.',
    `rsp_price` DECIMAL(18,2) COMMENT 'Manufacturer recommended selling price to be used by the retailer or distributor at point of sale.',
    `sales_organization` STRING COMMENT 'SAP sales organization code responsible for managing and executing this pricing agreement.',
    `volume_threshold_quantity` DECIMAL(18,2) COMMENT 'Minimum order or cumulative purchase quantity required to qualify for the contracted pricing tier or volume-based discount.',
    `volume_threshold_uom` STRING COMMENT 'Unit of measure for the volume threshold quantity (e.g., EA for each, CS for case, PAL for pallet).. Valid values are `^[A-Z]{2,3}$`',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the pricing agreement record.',
    CONSTRAINT pk_pricing_agreement PRIMARY KEY(`pricing_agreement_id`)
) COMMENT 'Contractual pricing arrangement established with a retail account, distributor, or wholesale customer defining agreed RSP/MSRP, net pricing, volume-based tiered discounts, promotional allowances, and rebate structures. Captures agreement number, effective start/end dates, pricing tier, base list price, contracted net price, volume thresholds, rebate percentage, payment terms, currency, and approval status. Source of truth for customer-specific pricing in SAP SD condition records.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Unique identifier for the sales opportunity record. Primary key.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative (field sales, key account manager, or territory manager) responsible for managing this opportunity.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that generated or influenced this opportunity, if applicable. Used for campaign ROI (Return on Investment) analysis.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Consumer goods sales pipeline reporting is always segmented by product category (e.g., Oral Care, Hair Care). opportunity.product_category_focus is a plain-text denormalization of product.category; re',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Sales opportunities in consumer goods are targeted at specific consumer segments (e.g., winning shelf space for a product targeting a premium segment). Consumer segment linkage drives opportunity prio',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Opportunities are tied to a specific brands product line for forecasting and pipeline reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sales pipeline opportunities are tracked against profit centers for revenue forecasting by business unit. Consumer goods finance teams use opportunity-to-profit-center mapping for rolling revenue fore',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Sales pipeline tracks regulatory submission status; linking opportunity to submission enables monitoring approval impact on forecast.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory (geographic or account-based) to which this opportunity is assigned. Used for territory performance tracking and quota allocation.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account or distributor associated with this opportunity (e.g., Walmart, Target, regional distributor).',
    `channel_type` STRING COMMENT 'Primary sales channel targeted by this opportunity: retail (brick-and-mortar stores), wholesale (distributor/wholesaler), DTC (Direct to Consumer), e-commerce (online retail), DSD (Direct Store Delivery), or foodservice (restaurants, institutions).. Valid values are `retail|wholesale|dtc|ecommerce|dsd|foodservice`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity was marked as closed-won or closed-lost. Null if opportunity is still open. Used for sales cycle duration analysis.',
    `competitive_displacement_context` STRING COMMENT 'Description of competitive dynamics: which competitors product(s) this opportunity aims to displace, or whether this is a net-new distribution gain without displacement. Used for competitive intelligence and win/loss analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity record was first created in the system. Used for opportunity age calculation and pipeline velocity analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated revenue (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `estimated_acv_gain` DECIMAL(18,2) COMMENT 'Projected gain in ACV (All Commodity Volume) if this opportunity closes successfully. ACV measures the total retail sales volume of stores carrying the product.',
    `estimated_annual_revenue` DECIMAL(18,2) COMMENT 'Projected incremental annual revenue from this opportunity if closed-won, in the base currency. Used for pipeline value calculation and sales forecasting.',
    `estimated_sku_count` STRING COMMENT 'Number of SKUs (Stock Keeping Units) expected to be authorized or listed if this opportunity closes successfully. Used for distribution point forecasting.',
    `estimated_tdp_gain` STRING COMMENT 'Projected gain in TDP (Total Distribution Points) if this opportunity closes successfully. TDP measures the number of stores carrying the product weighted by store importance.',
    `expected_close_date` DATE COMMENT 'Anticipated date when the opportunity will reach closed-won or closed-lost stage. Used for sales pipeline forecasting and quota planning.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter in which the opportunity is expected to close, formatted as Q1 2024, Q2 2024, etc. Used for quarterly sales forecasting and quota tracking.. Valid values are `^Q[1-4]sd{4}$`',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the opportunity is expected to close (e.g., 2024, 2025). Used for annual sales planning and year-over-year pipeline comparison.',
    `forecast_category` STRING COMMENT 'Sales forecast category for pipeline management: pipeline (early stage, low confidence), best_case (possible upside), commit (high confidence, included in quota forecast), or closed (deal finalized).. Valid values are `pipeline|best_case|commit|closed`',
    `is_deleted` BOOLEAN COMMENT 'Soft-delete flag indicating whether this opportunity record has been logically deleted. True if deleted, False if active. Used for audit trail and data retention compliance.',
    `jbp_alignment_flag` BOOLEAN COMMENT 'Indicates whether this opportunity is aligned with a formal JBP (Joint Business Planning) agreement with the retailer or distributor. True if aligned, False otherwise.',
    `last_activity_date` DATE COMMENT 'Date of the most recent sales activity (call, meeting, email, task) logged against this opportunity. Used for identifying stale opportunities requiring follow-up.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity record was last updated. Used for tracking recent activity and stale opportunity identification.',
    `lead_source` STRING COMMENT 'Origin of the opportunity: inbound inquiry from retailer, field sales prospecting, trade show contact, referral, marketing campaign, or expansion within existing account.. Valid values are `inbound_inquiry|field_sales_prospecting|trade_show|referral|marketing_campaign|existing_account_expansion`',
    `loss_reason` STRING COMMENT 'Primary reason for opportunity closure as closed-lost: price (not competitive), product fit (product did not meet needs), competitive loss (lost to competitor), timing (wrong time for buyer), budget constraints, no decision made, or other. Null if not closed-lost. [ENUM-REF-CANDIDATE: price|product_fit|competitive_loss|timing|budget_constraints|no_decision|other — 7 candidates stripped; promote to reference product]',
    `next_step_description` STRING COMMENT 'Description of the next action or milestone required to advance this opportunity (e.g., Schedule buyer meeting, Submit pricing proposal, Finalize contract terms).',
    `opportunity_name` STRING COMMENT 'Business-friendly name describing the opportunity (e.g., Q2 2024 SKU Authorization - Retailer X, New DTC Channel Launch - Product Line Y).',
    `opportunity_type` STRING COMMENT 'Classification of the opportunity by business objective: new retail account acquisition, SKU (Stock Keeping Unit) authorization/listing expansion, new channel entry (e.g., e-commerce, DSD), distribution gain with retailer/distributor, shelf space expansion, or promotional program. [ENUM-REF-CANDIDATE: new_account_acquisition|sku_authorization|sku_listing_expansion|channel_entry|distribution_gain|shelf_space_expansion|promotional_program — 7 candidates stripped; promote to reference product]',
    `probability_percentage` DECIMAL(18,2) COMMENT 'Estimated probability of closing this opportunity successfully, expressed as a percentage (0.00 to 100.00). Used for weighted pipeline forecasting.',
    `stage` STRING COMMENT 'Current stage in the sales opportunity lifecycle: prospecting (initial contact), qualification (fit assessment), needs analysis (requirements gathering), proposal (offer submitted), negotiation (terms discussion), closed-won (deal secured), or closed-lost (deal not secured). [ENUM-REF-CANDIDATE: prospecting|qualification|needs_analysis|proposal|negotiation|closed_won|closed_lost — 7 candidates stripped; promote to reference product]',
    `win_reason` STRING COMMENT 'Primary reason for opportunity closure as closed-won: price advantage, product quality, brand strength, relationship with buyer, innovation/differentiation, service level, or other. Null if not closed-won. [ENUM-REF-CANDIDATE: price|product_quality|brand_strength|relationship|innovation|service_level|other — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Sales opportunity record managed within Salesforce Consumer Goods Cloud representing potential new business: new retail account acquisition, SKU authorization/listing expansion, new channel entry, or distribution gain with a retailer or distributor. Captures opportunity name, stage (prospecting/qualification/proposal/negotiation/closed-won/closed-lost), estimated incremental annual revenue, probability percentage, expected close date, channel type, product category focus, assigned sales rep, buyer contact, and competitive displacement context. Drives SFA pipeline management, new distribution forecasting, and JBP (Joint Business Planning) alignment.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`account_call` (
    `account_call_id` BIGINT COMMENT 'Unique identifier for the field sales representative store visit record. Primary key for the account call entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Field calls are scheduled to support a particular marketing campaign; call performance is measured against campaign goals.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: In consumer goods field sales, store calls are organized by category (e.g., a reps Hair Care call focuses on shelf compliance, facings, and OOS for that category). Linking account_call to product.c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Field sales call costs (travel, samples distributed, merchandising materials) are charged to cost centers. Consumer goods companies track selling activity costs by cost center for route-to-market effi',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to marketing.creative_asset. Business justification: Field sales reps in consumer goods deploy specific POS materials, shelf talkers, and display assets during store calls. Linking account_call to creative_asset enables compliance tracking of in-store m',
    `oos_event_id` BIGINT COMMENT 'Foreign key linking to inventory.oos_event. Business justification: Sales reps observing OOS during store calls (account_call has oos_items_count, oos_items_list) must link their field observation to the formal inventory OOS event for root cause analysis, resolution t',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Linking account call to the order it generated removes need for separate flag and amount fields.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: An account_call is a field sales representative store visit record. While trade_account_id identifies the account, a specific store visit must reference the exact retail_store visited. In consumer goo',
    `rep_id` BIGINT COMMENT 'Reference to the field sales representative who conducted the store visit. Links to workforce employee data.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail store or account visited during this call. Links to the trade account master data.',
    `activities_completed` STRING COMMENT 'Summary of activities performed during the store visit, such as shelf audits, order placement, merchandising, training, or promotional setup. Free-text field capturing execution details.',
    `call_date` DATE COMMENT 'The calendar date on which the store visit occurred. Used for daily sales activity tracking and field sales Key Performance Indicator (KPI) reporting.',
    `call_duration_minutes` STRING COMMENT 'Total time spent at the store location in minutes. Key metric for field sales productivity analysis and route optimization.',
    `call_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the sales representative completed the store visit. Used to calculate call duration and productivity metrics.',
    `call_notes` STRING COMMENT 'Additional free-text notes and observations captured by the sales representative during the store visit. Provides qualitative context for the call record.',
    `call_number` STRING COMMENT 'Business identifier for the account call, typically generated by the Sales Force Automation (SFA) system. Used for external reference and tracking.',
    `call_objective` STRING COMMENT 'Primary business objective or goal for the store visit. Free-text description of what the sales representative intended to accomplish during the call.',
    `call_outcome` STRING COMMENT 'Overall outcome assessment of the store visit. Indicates whether call objectives were achieved and execution was successful.. Valid values are `successful|partially_successful|unsuccessful|rescheduled`',
    `call_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the sales representative began the store visit. Captured via mobile Sales Force Automation (SFA) application for time-in-store analytics.',
    `call_status` STRING COMMENT 'Current lifecycle status of the account call. Tracks progression from scheduled visit through completion or cancellation.. Valid values are `scheduled|in_progress|completed|cancelled|no_show`',
    `call_type` STRING COMMENT 'Classification of the account call purpose. Distinguishes between routine visits, promotional activities, merchandising support, compliance audits, New Product Development (NPD) launches, and issue resolution.. Valid values are `routine|promotional|merchandising|compliance_audit|new_product_introduction|problem_resolution`',
    `competitor_activity_observed` STRING COMMENT 'Free-text notes on competitor promotional activities, new product launches, pricing changes, or merchandising observed during the store visit. Competitive intelligence capture.',
    `competitor_pricing_flag` BOOLEAN COMMENT 'Indicates whether competitor pricing information was collected during the store visit. Used to trigger pricing analysis and response.',
    `corrective_actions_completed_flag` BOOLEAN COMMENT 'Indicates whether identified corrective actions were completed during the same store visit. Tracks immediate issue resolution effectiveness.',
    `corrective_actions_required` STRING COMMENT 'Description of corrective actions identified during the visit, such as restocking Out of Stock (OOS) items, fixing Planogram (POG) violations, or addressing pricing discrepancies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the account call record was first created in the Sales Force Automation (SFA) system. Audit trail for record creation.',
    `display_compliance_flag` BOOLEAN COMMENT 'Indicates whether promotional displays and secondary placements are set up according to trade promotion agreements and merchandising standards.',
    `display_type` STRING COMMENT 'Type of promotional display observed or set up during the store visit. Captures secondary placement strategy execution.. Valid values are `end_cap|floor_stand|pallet|shelf_talker|cooler|none`',
    `facings_actual` STRING COMMENT 'Actual number of product facings observed during the store visit. Used to calculate facing compliance and identify shelf space gaps.',
    `facings_required` STRING COMMENT 'Total number of product facings specified in the Planogram (POG) for this store. Represents the target shelf presence.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate captured when the call was logged via mobile Sales Force Automation (SFA) application. Used to verify store visit location and route compliance.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate captured when the call was logged via mobile Sales Force Automation (SFA) application. Used to verify store visit location and route compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the account call record was last updated. Audit trail for record changes and data quality monitoring.',
    `mobile_device_code` STRING COMMENT 'Identifier of the mobile device used to capture the account call record. Used for Sales Force Automation (SFA) system audit and device management.',
    `next_call_date` DATE COMMENT 'Scheduled date for the next store visit. Used for call frequency planning and route optimization.',
    `oos_items_count` STRING COMMENT 'Number of Stock Keeping Units (SKUs) found to be Out of Stock (OOS) during the store visit. Key metric for On Shelf Availability (OSA) tracking.',
    `oos_items_list` STRING COMMENT 'Comma-separated list of Stock Keeping Unit (SKU) codes or product names that were Out of Stock (OOS) during the visit. Used for replenishment prioritization.',
    `photo_evidence_count` STRING COMMENT 'Number of photos captured during the store visit via mobile Sales Force Automation (SFA) application. Used for visual compliance verification and audit trails.',
    `photo_storage_reference` STRING COMMENT 'Reference identifier or Uniform Resource Locator (URL) to the location where call photos are stored. Links to external document management or cloud storage system.',
    `pog_compliance_score` DECIMAL(18,2) COMMENT 'Overall compliance score for Planogram (POG) execution at the store, typically expressed as a percentage. Measures how well the actual shelf layout matches the planned POG.',
    `scheduled_date` DATE COMMENT 'Originally planned date for the store visit. Used to track adherence to call plans and route schedules.',
    `shelf_position_compliant_flag` BOOLEAN COMMENT 'Indicates whether products are placed in the correct shelf position as specified in the Planogram (POG). Critical for optimal product visibility and sales.',
    `signature_captured_flag` BOOLEAN COMMENT 'Indicates whether a digital signature was captured from the store contact to confirm the visit and any agreements made. Used for audit and compliance purposes.',
    `signature_reference` STRING COMMENT 'Reference identifier to the stored digital signature image. Links to external document storage system.',
    `store_contact_name` STRING COMMENT 'Name of the store manager or key contact person met during the visit. Used for relationship tracking and follow-up coordination.',
    `sync_status` STRING COMMENT 'Synchronization status of the call record between the mobile Sales Force Automation (SFA) application and the central system. Tracks data integration completeness.. Valid values are `synced|pending|failed`',
    CONSTRAINT pk_account_call PRIMARY KEY(`account_call_id`)
) COMMENT 'Field sales representative store visit record captured via Salesforce Consumer Goods Cloud SFA, including planogram compliance audit observations. Records call date/time, store/account visited, sales rep, call type, objectives, activities completed, orders placed, shelf compliance observations, OSA findings, competitor activity, POG compliance scores (facings required vs actual, shelf position, OOS items, display compliance), photo evidence references, corrective actions, and call outcome. Core operational record for retail execution, field sales KPI tracking, and shelf compliance reporting.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`return_order` (
    `return_order_id` BIGINT COMMENT 'Unique identifier for the return order record. Primary key.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Return processing requires identifying the original batch for quality assessment and potential recall actions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Return order processing costs (inspection, restocking, reverse logistics) are charged to cost centers. Consumer goods companies track returns handling expense by cost center for operational cost manag',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Return orders generate GL postings to sales returns and allowances accounts. Consumer goods companies post returns to specific GL accounts for accurate net revenue reporting and deduction management —',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Returned goods in consumer goods operations trigger a quality inspection lot to assess condition and disposition. The return_order drives the inspection; linking them enables returned goods quality i',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to sales.invoice. Business justification: A return order generates a credit memo against the original billing document (invoice). While return_order.originating_sales_order_id links back to the sales order, the financial reversal in consumer ',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Consumer goods return processing requires lot/batch traceability for quality inspection, disposition decisions, and recall linkage. A domain expert expects returned products to reference the specific ',
    `order_id` BIGINT COMMENT 'Reference to the original sales order that this return is associated with.',
    `product_complaint_id` BIGINT COMMENT 'Foreign key linking to quality.product_complaint. Business justification: Return processing links to product complaints for root‑cause analysis and corrective action tracking.',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_recall. Business justification: Required for recall processing: return orders must reference active product recall to manage returned items per compliance.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to inventory.recall_event. Business justification: Recall-driven returns in consumer goods must link to the inventory recall_event for quantity reconciliation, recovery rate tracking, and regulatory reporting. return_order already links to regulatory.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Reverse logistics routing: return orders must specify the receiving DC for physical goods return. warehouse_location_code is a plain-text denormalization. Role-prefix receiving_ distinguishes this f',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Return orders must reference the exact SKU being returned for warranty, credit, and compliance processing; used in return analytics.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail account, distributor, or DTC consumer initiating the return.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Returned goods in consumer goods are received at a specific warehouse for inspection and disposition. return_order has warehouse_location_code as a denormalized text field. A proper FK to inventory.wa',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Additional adjustments applied to the return value (e.g., damage deductions, handling fees, promotional credits).',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier used for reverse shipment of the returned goods.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this return order record was first created in the system.',
    `credit_memo_issued_date` DATE COMMENT 'Date when the credit memo was officially issued to the customer.',
    `credit_memo_number` STRING COMMENT 'Unique credit memo document number issued for this return in the financial system.. Valid values are `^CM-[A-Z0-9]{8,12}$`',
    `credit_memo_posted_date` DATE COMMENT 'Date when the credit memo was posted to the general ledger for financial settlement.',
    `credit_memo_status` STRING COMMENT 'Current status of the credit memo in the accounts receivable settlement process. [ENUM-REF-CANDIDATE: not_requested|requested|approved|issued|posted|rejected|cancelled — 7 candidates stripped; promote to reference product]',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this return order.. Valid values are `^[A-Z]{3}$`',
    `customer_responsible_flag` BOOLEAN COMMENT 'Indicates whether the customer is financially responsible for the return (True) or the business absorbs the cost (False).',
    `disposition_instruction` STRING COMMENT 'Instruction for handling the returned goods based on inspection results and business rules. [ENUM-REF-CANDIDATE: return_to_stock|destroy|rework|donate|quarantine|return_to_vendor|scrap — 7 candidates stripped; promote to reference product]',
    `distribution_channel` STRING COMMENT 'SAP distribution channel code through which the original sale and return are processed.. Valid values are `^[A-Z0-9]{2}$`',
    `division` STRING COMMENT 'SAP division code representing the product line or business unit.. Valid values are `^[A-Z0-9]{2}$`',
    `goods_received_date` DATE COMMENT 'Date when the returned goods were physically received at the return processing facility or warehouse.',
    `inspection_completed_date` DATE COMMENT 'Date when quality inspection of the returned goods was completed.',
    `inspector_name` STRING COMMENT 'Name of the quality inspector who performed the inspection of returned goods.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this return order record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this return order record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the return.',
    `original_unit_price` DECIMAL(18,2) COMMENT 'Original unit price at which the product was sold in the originating sales order.',
    `quality_inspection_result` STRING COMMENT 'Result of the quality inspection performed on the returned goods.. Valid values are `passed|failed|partial|not_inspected`',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer for processing and restocking the returned goods, if applicable.',
    `return_authorization_date` DATE COMMENT 'Date when the return was officially authorized by the business for processing.',
    `return_authorization_number` STRING COMMENT 'Externally-known unique authorization number issued for this return request. Format: RMA-XXXXXXXX.. Valid values are `^RMA-[A-Z0-9]{8,12}$`',
    `return_order_type` STRING COMMENT 'Classification of the return based on the originating channel: retail account, distributor, direct-to-consumer, or wholesale.. Valid values are `retail_account_return|distributor_return|dtc_consumer_return|wholesale_return`',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for the product return. [ENUM-REF-CANDIDATE: damaged_in_transit|expired|shelf_life_rejection|overstock|quality_defect|wrong_item_shipped|recall|customer_dissatisfaction|packaging_defect|promotional_return — 10 candidates stripped; promote to reference product]',
    `return_reason_description` STRING COMMENT 'Detailed free-text description providing additional context about the return reason.',
    `return_request_date` DATE COMMENT 'Date when the return request was initiated by the customer or account.',
    `return_shipping_cost` DECIMAL(18,2) COMMENT 'Cost incurred for shipping the returned goods back to the warehouse.',
    `return_status` STRING COMMENT 'Current lifecycle status of the return order in the reverse logistics and credit processing workflow. [ENUM-REF-CANDIDATE: requested|authorized|in_transit|received|inspected|approved|rejected|credit_issued|closed|cancelled — 10 candidates stripped; promote to reference product]',
    `return_value_gross` DECIMAL(18,2) COMMENT 'Gross monetary value of the returned goods before any deductions (returned quantity × original unit price).',
    `return_value_net` DECIMAL(18,2) COMMENT 'Net monetary value to be credited to the customer after restocking fees and adjustments (gross - restocking fee - adjustments).',
    `returned_quantity` DECIMAL(18,2) COMMENT 'Quantity of units being returned.',
    `returned_quantity_uom` STRING COMMENT 'Unit of measure for the returned quantity (EA=Each, CS=Case, PL=Pallet, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `sales_organization` STRING COMMENT 'SAP sales organization code responsible for processing this return.. Valid values are `^[A-Z0-9]{4}$`',
    `tracking_number` STRING COMMENT 'Shipment tracking number provided by the carrier for the return shipment.. Valid values are `^[A-Z0-9]{10,30}$`',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this return order record.',
    CONSTRAINT pk_return_order PRIMARY KEY(`return_order_id`)
) COMMENT 'Sales return authorization and credit memo request capturing product returns from retail accounts, distributors, or DTC consumers. Records return authorization number, return reason code (damaged in transit/expired/shelf-life rejection/overstock/quality defect/wrong item shipped/recall), return date, originating order reference, returned SKU/GTIN, returned quantity, return value, restocking fee if applicable, credit memo status (requested/approved/issued/posted), and disposition instruction (return to stock/destroy/rework/donate). Tracks reverse logistics triggers and financial credit processing for AR settlement.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`territory` (
    `territory_id` BIGINT COMMENT 'Primary key for territory',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Sales territories in consumer goods are aligned to consumer segment profiles to drive field execution priorities, call frequency, and shopper marketing investment allocation. Territory-level consumer ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sales territory field expenses (travel, samples, merchandising) are charged to cost centers. Consumer goods companies assign territories to cost centers for selling expense allocation, territory profi',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Sales planning and product eligibility: territory managers must know which regulatory jurisdiction governs their territory to determine which registered products can be sold, what labeling is required',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Territories map to profit centers for regional P&L reporting. Consumer goods companies attribute territory revenue and contribution to profit centers for geographic performance management and regional',
    `account_count` STRING COMMENT 'Total number of retail trade accounts assigned to this territory. Used for workload balancing and territory design.',
    `acv_coverage` DECIMAL(18,2) COMMENT 'Estimated All Commodity Volume (ACV) represented by the retail accounts in this territory, expressed in currency. ACV measures the total sales volume of all products sold through the retail outlets in the territory, used for market potential assessment.',
    `annual_quota_amount` DECIMAL(18,2) COMMENT 'Annual sales quota or revenue target assigned to this territory, expressed in the companys reporting currency. Used for sales performance management and incentive compensation.',
    `call_frequency_days` STRING COMMENT 'Standard call frequency in days for sales representative visits to accounts in this territory (e.g., 7 for weekly, 14 for bi-weekly, 30 for monthly). Used for SFA route planning.',
    `channel_assignment` STRING COMMENT 'Primary retail channel or trade class that this territory covers. Aligns with consumer goods distribution channels including grocery, drug, mass merchandiser, club, convenience, e-commerce, and Direct-to-Consumer (DTC). [ENUM-REF-CANDIDATE: grocery|drug|mass|club|convenience|e_commerce|foodservice|wholesale|dtc|multi_channel — 10 candidates stripped; promote to reference product]',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the primary country of the territory (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was first created in the system. Used for audit trail and data lineage.',
    `distribution_channel` STRING COMMENT 'Distribution channel code from the ERP system representing the route-to-market for this territory (e.g., Retail, Wholesale, E-Commerce). Aligns with SAP distribution channel master data.',
    `district` STRING COMMENT 'Mid-level geographic or organizational district within a region. Represents a grouping of territories managed by a district sales manager.',
    `division` STRING COMMENT 'Business division or product line that this territory supports (e.g., Personal Care, Home Care, Beauty). Used for division-level sales reporting and product scope definition.',
    `dsd_eligible_flag` BOOLEAN COMMENT 'Indicates whether the territory includes accounts eligible for Direct Store Delivery (DSD) distribution model, where products are delivered directly to retail stores bypassing distribution centers.',
    `edi_capability_flag` BOOLEAN COMMENT 'Indicates whether the majority of accounts in this territory support Electronic Data Interchange (EDI) for automated order processing, invoicing, and inventory management.',
    `effective_end_date` DATE COMMENT 'Date when the territory definition expires or is deactivated. Null for open-ended territories.',
    `effective_start_date` DATE COMMENT 'Date when the territory definition becomes active and operational for sales assignment and quota allocation.',
    `geographic_scope` STRING COMMENT 'Textual description of the geographic boundaries or coverage area of the territory (e.g., New York, New Jersey, Connecticut, California North, National - Walmart).',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the territory record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about the territory, including special handling instructions, account nuances, or historical context.',
    `pog_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether field sales representatives in this territory are required to monitor and enforce Planogram (POG) compliance for product placement and shelf merchandising.',
    `postal_code_list` STRING COMMENT 'Comma-separated or structured list of postal codes included in this territory. Used for precise geographic assignment and routing optimization.',
    `priority_tier` STRING COMMENT 'Strategic priority classification of the territory based on revenue potential, account importance, or growth opportunity. Tier 1 or Strategic territories receive higher resource allocation and management attention.. Valid values are `tier_1|tier_2|tier_3|strategic|standard`',
    `quota_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quota amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `region` STRING COMMENT 'Higher-level geographic or organizational region to which this territory belongs (e.g., Northeast, West Coast, EMEA). Used for regional sales rollup and management hierarchy.',
    `sales_organization` STRING COMMENT 'Sales organization code or identifier from the ERP system (e.g., SAP Sales Organization) that owns this territory. Used for financial and organizational reporting.',
    `state_province_list` STRING COMMENT 'Comma-separated list of states or provinces covered by this territory (e.g., NY,NJ,CT or CA,NV,AZ). Used for state-level sales reporting and compliance.',
    `store_count` STRING COMMENT 'Total number of retail store locations (points of distribution) within this territory. Key metric for coverage planning and Sales Force Automation (SFA) routing.',
    `tdp_coverage` STRING COMMENT 'Total Distribution Points (TDP) covered by this territory, representing the number of stores where the companys products are authorized for distribution. Critical metric for distribution reach and On-Shelf Availability (OSA).',
    `territory_code` STRING COMMENT 'Business identifier code for the territory used in sales force automation and reporting systems. Typically alphanumeric and unique across the organization.. Valid values are `^[A-Z0-9]{3,12}$`',
    `territory_name` STRING COMMENT 'Human-readable name of the sales territory, typically reflecting geographic region or account grouping (e.g., Northeast Metro, California Key Accounts).',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory. Active territories are operational and assigned to sales representatives; inactive territories are no longer in use; pending territories are being set up.. Valid values are `active|inactive|pending|suspended|archived`',
    `territory_type` STRING COMMENT 'Classification of the territory based on sales coverage model. Field territories cover geographic regions with multiple accounts; key account territories focus on strategic retail partners; national account territories manage enterprise-wide relationships.. Valid values are `field|key_account|national_account|regional|district|channel`',
    `trade_class` STRING COMMENT 'Detailed trade classification or sub-channel segmentation within the primary channel (e.g., Supermarket, Drug Chain, Dollar Store, Online Pure Play). Used for granular channel analytics.',
    `vmi_eligible_flag` BOOLEAN COMMENT 'Indicates whether accounts in this territory participate in Vendor Managed Inventory (VMI) programs where the manufacturer manages inventory replenishment at retail locations.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the territory record. Used for audit trail and accountability.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Geographic and account-based sales territory definition used to assign field sales representatives and key account managers to specific retail accounts, geographic regions, or channel segments. Captures territory code, name, region, district, channel assignment (grocery/drug/mass/club/convenience/e-commerce), territory type (field/key account/national account), channel characteristics (trade class, EDI capability, DSD eligibility), active status, effective dates, and assigned quota. Master reference for SFA routing, field sales KPI attribution, and channel-level segmentation.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`rep` (
    `rep_id` BIGINT COMMENT 'Primary key for rep',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sales rep compensation, benefits, and expenses are charged to cost centers. Consumer goods companies assign reps to cost centers for headcount cost tracking, SG&A allocation, and sales force productiv',
    `manager_rep_id` BIGINT COMMENT 'Reference to the sales representative record of this reps direct manager. Supports hierarchical reporting and approval workflows in the sales organization.',
    `territory_id` BIGINT COMMENT 'Reference to the assigned sales territory. Defines the geographic or account-based scope of responsibility for this sales representative.',
    `badge_number` STRING COMMENT 'Physical security badge or identification number issued to the sales representative. Used for facility access and field audit verification.',
    `certification_status` STRING COMMENT 'Status of required sales certifications or training completions (e.g., product knowledge, compliance training, safety certifications). Certified indicates all requirements met; pending indicates training in progress; expired indicates recertification needed; not_required for roles without certification mandates.. Valid values are `certified|pending|expired|not_required`',
    `channel_specialization` STRING COMMENT 'Primary sales channel focus for this representative. Retail covers traditional grocery and drug stores; wholesale covers distributors; DTC (Direct to Consumer) covers company-owned stores and online; e-commerce covers digital marketplaces; foodservice covers restaurants and institutions; convenience covers c-stores and gas stations; mass merchandise covers big-box retailers. [ENUM-REF-CANDIDATE: retail|wholesale|dtc|ecommerce|foodservice|convenience|mass_merchandise — 7 candidates stripped; promote to reference product]',
    `commission_plan_code` STRING COMMENT 'Identifier for the commission or incentive compensation plan assigned to this sales representative. Links to the compensation management system for payout calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales representative record was first created in the system. Used for audit trail and data lineage tracking.',
    `current_quota_amount` DECIMAL(18,2) COMMENT 'Current sales quota target amount for the active quota period. Measured in the sales organizations reporting currency. Used for performance tracking and commission calculation.',
    `email_address` STRING COMMENT 'Corporate email address of the sales representative. Used for system notifications, commission statements, and internal communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'First name of the sales representative. Used for personalization in SFA applications and customer-facing communications.',
    `full_name` STRING COMMENT 'Full display name of the sales representative (typically first name + last name). Used in reports, dashboards, and customer-facing materials.',
    `hire_date` DATE COMMENT 'Date the sales representative was hired into the sales organization. Used for tenure calculations, commission eligibility, and performance benchmarking.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code representing the primary language of the sales representative. Used for SFA application localization and communication preferences.. Valid values are `^[a-z]{2}$`',
    `last_certification_date` DATE COMMENT 'Date the sales representative last completed required certifications or training. Used to track recertification schedules and compliance status.',
    `last_name` STRING COMMENT 'Last name of the sales representative. Used for personalization in SFA applications and customer-facing communications.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review for this sales representative. Used to track review cycles and ensure timely evaluations.',
    `mobile_device_code` STRING COMMENT 'Identifier for the company-issued mobile device (smartphone or tablet) used by the sales representative for SFA application access. Used for device management and security compliance.',
    `mobile_phone` STRING COMMENT 'Mobile phone number of the sales representative. Used for SFA mobile app authentication, emergency contact, and field communication.',
    `modified_by` STRING COMMENT 'User identifier of the person or system that last modified this sales representative record. Used for audit trail and data governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales representative record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional information about the sales representative, such as special skills, territory transition notes, or temporary assignments.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating for the sales representative. Exceeds indicates above-quota performance; meets indicates on-target; below indicates under-performing; new_hire indicates insufficient tenure for rating.. Valid values are `exceeds|meets|below|new_hire`',
    `quota_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the quota amount. Typically matches the sales organizations reporting currency.. Valid values are `^[A-Z]{3}$`',
    `quota_period` STRING COMMENT 'Frequency at which sales quotas are assigned and measured for this representative. Monthly quotas are typical for field sales; quarterly for key accounts; annual for national accounts.. Valid values are `monthly|quarterly|annual`',
    `rep_number` STRING COMMENT 'Business identifier for the sales representative, typically assigned by the sales organization. Used in Salesforce Consumer Goods Cloud and SAP S/4HANA SD module for sales force automation and order capture.. Valid values are `^[A-Z0-9]{6,12}$`',
    `rep_status` STRING COMMENT 'Current lifecycle status of the sales representative. Active reps are assigned territories and quotas; inactive reps are temporarily not selling; on_leave indicates approved absence; suspended indicates disciplinary hold; terminated indicates employment ended.. Valid values are `active|inactive|on_leave|suspended|terminated`',
    `rep_type` STRING COMMENT 'Classification of the sales representative role. Field sales covers territory-based retail execution; key account manager handles strategic retail accounts; national account manager manages top-tier national chains; inside sales supports telesales and e-commerce; DSD (Direct Store Delivery) driver combines delivery and merchandising; regional manager oversees field teams.. Valid values are `field_sales|key_account_manager|national_account_manager|inside_sales|dsd_driver|regional_manager`',
    `sales_group` STRING COMMENT 'SAP S/4HANA SD sales group code. Represents the functional team or product line focus within the sales organization (e.g., health and beauty, household care, personal care).',
    `sales_office` STRING COMMENT 'SAP S/4HANA SD sales office code. Represents the physical office or regional hub to which this sales representative is assigned.',
    `sales_organization` STRING COMMENT 'SAP S/4HANA SD sales organization code. Represents the legal entity or business unit responsible for sales transactions executed by this representative.',
    `sfa_user_code` STRING COMMENT 'User identifier in the Sales Force Automation system (Salesforce Consumer Goods Cloud). Used to link mobile app activity, retail execution records, and call reports to this sales representative.',
    `termination_date` DATE COMMENT 'Date the sales representative left the organization or was terminated. Null for active employees. Used for historical sales attribution and territory transition analysis.',
    `vehicle_assigned` BOOLEAN COMMENT 'Indicates whether a company vehicle has been assigned to this sales representative. True for DSD drivers and field sales reps with company cars; false for inside sales and office-based roles.',
    `created_by` STRING COMMENT 'User identifier of the person or system that created this sales representative record. Used for audit trail and data governance.',
    CONSTRAINT pk_rep PRIMARY KEY(`rep_id`)
) COMMENT 'Sales representative master record for field sales, key account management, and inside sales personnel operating within the sales domain. Captures employee ID reference, rep name, rep type (field sales/key account manager/national account manager/inside sales/DSD driver), assigned territory, channel specialization, hire date, active status, SFA user ID, and current quota period. Distinct from the workforce domain employee record — this is the sales-domain operational view of the selling resource.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`quota` (
    `quota_id` BIGINT COMMENT 'Unique identifier for the sales quota assignment record.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: In consumer goods, incremental sales quotas are set in the context of specific marketing campaigns (e.g., new product launch campaigns). Linking quota to campaign enables campaign ROI measurement via ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quota attainment drives incentive compensation expense charged to cost centers. Consumer goods companies allocate sales incentive costs to cost centers for SG&A budget control and compensation expense',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Sales quotas are derived from and aligned to financial budgets in consumer goods IBP/S&OP planning cycles. Linking quota to finance_budget enables variance analysis between commercial targets and fina',
    `hierarchy_id` BIGINT COMMENT 'Identifier of the product category to which this quota applies.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand to which this quota applies.',
    `rep_id` BIGINT COMMENT 'Identifier of the sales representative to whom this quota is assigned.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: New product launch quotas and SKU-level sales targets are standard in consumer goods: reps receive specific volume quotas per SKU for new item sell-in. quota already links to hierarchy for category-le',
    `territory_id` BIGINT COMMENT 'Identifier of the sales territory to which this quota is assigned.',
    `accelerator_rate` DECIMAL(18,2) COMMENT 'Enhanced commission rate applied when stretch target is exceeded.',
    `allocation_method` STRING COMMENT 'Methodology used to allocate quota across territories or reps (e.g., historical performance, market potential, equal distribution).',
    `approval_status` STRING COMMENT 'Approval workflow status for the quota assignment.. Valid values are `not_submitted|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the manager or executive who approved the quota.',
    `approved_date` DATE COMMENT 'Date on which the quota was approved.',
    `channel_type` STRING COMMENT 'Sales channel to which this quota applies. DSD = Direct Store Delivery, DTC = Direct to Consumer.. Valid values are `retail|wholesale|dtc|ecommerce|dsd`',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission percentage rate applied when quota is achieved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quota record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary quota values.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Customer segment or account classification to which this quota applies (e.g., national accounts, regional chains, independent retailers).',
    `distribution_channel` STRING COMMENT 'Distribution channel code for this quota assignment.',
    `division` STRING COMMENT 'Business division or product line code for this quota assignment.',
    `fiscal_month` STRING COMMENT 'Fiscal month within the year (1-12) for which the quota is assigned.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter within the year (1-4) for which the quota is assigned.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the quota is assigned.',
    `geographic_scope` STRING COMMENT 'Geographic region or market to which this quota applies (e.g., Northeast Region, California, National).',
    `minimum_threshold` DECIMAL(18,2) COMMENT 'Minimum performance threshold required for quota credit or commission eligibility.',
    `modified_by` STRING COMMENT 'User or system identifier that last modified the quota record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the quota record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the quota assignment.',
    `period_end_date` DATE COMMENT 'End date of the quota period.',
    `period_start_date` DATE COMMENT 'Start date of the quota period.',
    `period_type` STRING COMMENT 'Time period granularity for the quota (monthly, quarterly, semi-annual, or annual).. Valid values are `monthly|quarterly|semi_annual|annual`',
    `product_scope` STRING COMMENT 'Scope of products covered by this quota (all products, specific category, specific brand, or specific SKU).. Valid values are `all_products|category|brand|sku`',
    `quota_name` STRING COMMENT 'Descriptive name for the quota assignment.',
    `quota_number` STRING COMMENT 'Business identifier or reference number for the quota assignment.',
    `quota_source` STRING COMMENT 'Method by which the quota was determined. Top-down = allocated from corporate targets, Bottom-up = aggregated from field input, Negotiated = agreed between management and rep, Algorithmic = calculated by predictive model.. Valid values are `top_down|bottom_up|negotiated|algorithmic`',
    `quota_status` STRING COMMENT 'Current lifecycle status of the quota assignment. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `quota_type` STRING COMMENT 'Type of quota being assigned. Revenue = monetary sales target, Volume = unit/case target, New Distribution = new store/outlet target, TDP (Total Distribution Points) = weighted distribution target, ACV (All Commodity Volume) = market coverage target, Unit Sales = individual unit target, Gross Margin = profitability target. [ENUM-REF-CANDIDATE: revenue|volume|new_distribution|tdp|acv|unit_sales|gross_margin — 7 candidates stripped; promote to reference product]',
    `quota_value` DECIMAL(18,2) COMMENT 'Target value for the quota. Interpretation depends on quota_type: monetary amount for revenue quotas, unit count for volume quotas, store count for distribution quotas.',
    `sales_organization` STRING COMMENT 'Sales organization code responsible for this quota assignment.',
    `stretch_target` DECIMAL(18,2) COMMENT 'Aspirational or stretch goal beyond the base quota value, used for incentive compensation.',
    `uom` STRING COMMENT 'Unit of measure for the quota value (e.g., USD, cases, units, stores, points).',
    `created_by` STRING COMMENT 'User or system identifier that created the quota record.',
    CONSTRAINT pk_quota PRIMARY KEY(`quota_id`)
) COMMENT 'Sales quota assignment record defining revenue, volume, and distribution targets for sales representatives, territories, or account teams for a given planning period. Captures quota period (month/quarter/year), quota type (revenue/volume/new distribution/TDP), assigned rep or territory, product category or brand, quota value, stretch target, currency, approval status, and quota source (top-down/bottom-up/negotiated). Enables field sales KPI attainment tracking and S&OP alignment.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`distribution_point` (
    `distribution_point_id` BIGINT COMMENT 'Unique identifier for the distribution point record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: TDP (Total Distribution Points) gains in consumer goods are frequently activated as part of new product launch or promotional campaigns. Linking distribution_point to campaign enables measurement of d',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Distribution points in consumer goods target specific consumer segments (e.g., premium SKUs distributed only in stores serving premium segments). Consumer segment linkage drives distribution strategy,',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: TDP (Total Distribution Points) reporting: distribution_point tracks SKU availability by account/channel and must reference the DC physically handling that product. distribution_source is a plain-text',
    `label_version_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_version. Business justification: Shelf compliance process: each distribution_point must carry the jurisdiction-approved label version for that market. Consumer goods field teams and trade compliance teams verify that the label versio',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Distribution points are managed per brand to ensure correct shelf placement and brand‑level inventory control.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: Market activation process: before a distribution_point is activated in a new market, sales operations must verify the SKU holds a valid regulatory_registration in that jurisdiction. Consumer goods com',
    `retail_store_id` BIGINT COMMENT 'Reference to the specific retail store location where the SKU is available for sale.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Distribution points record which SKU is allocated to each retail location; required for inventory allocation and shelf‑stocking dashboards.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: VMI programs tie a store distribution point to the supplier site that replenishes it, enabling inventory‑level monitoring.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Distribution Point Inventory Planning uses the supplying network node to compute safety stock, replenishment, and service level targets.',
    `trade_account_id` BIGINT COMMENT 'Reference to the retail trade account or customer where the SKU is distributed.',
    `activation_date` DATE COMMENT 'Date when the SKU became actively distributed and available for sale at this point.',
    `actual_retail_price` DECIMAL(18,2) COMMENT 'Current actual retail selling price observed at this distribution point, may differ from RSP/MSRP.',
    `acv_percentage` DECIMAL(18,2) COMMENT 'The ACV percentage contribution of this retail location to the total category volume, used for weighted distribution metrics.',
    `acv_weighted_flag` BOOLEAN COMMENT 'Indicates whether this distribution point is included in ACV-weighted distribution calculations (True/False). ACV-weighted stores represent a significant portion of category sales volume.',
    `authorization_date` DATE COMMENT 'Date when the SKU was authorized for distribution at this retail location or account.',
    `channel_type` STRING COMMENT 'Retail channel classification for this distribution point (grocery, mass merchandiser, drug, convenience, club, e-commerce, specialty). [ENUM-REF-CANDIDATE: grocery|mass_merchandiser|drug|convenience|club|ecommerce|specialty — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution point record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for pricing at this distribution point.. Valid values are `^[A-Z]{3}$`',
    `delist_date` DATE COMMENT 'Date when the SKU was delisted or removed from distribution at this location. Null if still active.',
    `distribution_channel` STRING COMMENT 'SAP SD distribution channel code representing the route-to-market for this distribution point.',
    `distribution_status` STRING COMMENT 'Current lifecycle status of the SKU at this distribution point. Active indicates the product is currently distributed and available for sale; authorized indicates approval but not yet active; delisted indicates removal from distribution; inactive indicates temporary suspension.. Valid values are `active|inactive|authorized|delisted|pending|suspended`',
    `distribution_verification_date` DATE COMMENT 'Date when the distribution status was last verified or confirmed through the distribution source.',
    `division` STRING COMMENT 'SAP division code representing the product line or business unit for this distribution.',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this distribution point is serviced via Direct Store Delivery (True) or warehouse distribution (False).',
    `edi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this distribution point supports EDI transactions for order and inventory management (True/False).',
    `facing_count` STRING COMMENT 'Number of product facings (front-facing units) allocated to this SKU on the retail shelf at this location.',
    `geographic_market` STRING COMMENT 'Geographic market or region code for this distribution point, used for regional distribution analysis.',
    `last_pos_sale_date` DATE COMMENT 'Most recent date when a POS transaction was recorded for this SKU at this location, used to verify active distribution.',
    `launch_wave` STRING COMMENT 'Launch wave or phase identifier for new product rollouts, indicating the sequence of distribution expansion.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this distribution point record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution point record was last modified or updated.',
    `msrp_price` DECIMAL(18,2) COMMENT 'Manufacturer suggested retail price for this SKU at this distribution point.',
    `new_product_flag` BOOLEAN COMMENT 'Indicates whether this distribution point represents a new product introduction (True/False). Used for NPD distribution tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding special conditions, exceptions, or context for this distribution point.',
    `osa_status` STRING COMMENT 'Current on-shelf availability status of the SKU at this location, indicating whether the product is physically available for purchase.. Valid values are `in_stock|out_of_stock|low_stock|unknown`',
    `planogram_slot_reference` STRING COMMENT 'Reference to the planogram slot or shelf position where this SKU is merchandised at the store.',
    `pog_compliance_flag` BOOLEAN COMMENT 'Indicates whether the SKU placement at this location is compliant with the authorized planogram (True/False).',
    `rsp_price` DECIMAL(18,2) COMMENT 'Manufacturer recommended selling price for this SKU at this distribution point.',
    `sales_organization` STRING COMMENT 'SAP sales organization code responsible for this distribution point.',
    `shelf_position` STRING COMMENT 'Vertical and horizontal shelf position classification for the SKU at this location (eye level, top shelf, middle shelf, bottom shelf, end cap, promotional display).. Valid values are `eye_level|top_shelf|middle_shelf|bottom_shelf|end_cap|promotional_display`',
    `tdp_count_flag` BOOLEAN COMMENT 'Indicates whether this distribution point is counted in TDP metrics (True/False). Used to calculate numeric distribution reach.',
    `vmi_flag` BOOLEAN COMMENT 'Indicates whether this distribution point operates under a Vendor Managed Inventory agreement (True/False).',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this distribution point record.',
    CONSTRAINT pk_distribution_point PRIMARY KEY(`distribution_point_id`)
) COMMENT 'Total Distribution Points (TDP) record tracking which SKUs are actively distributed and available for sale at specific retail accounts or store locations. Captures store/account reference, SKU/GTIN, distribution status (active/inactive/authorized/delisted), authorization date, delist date, channel, planogram slot reference, ACV-weighted distribution flag, and distribution source (sell-in confirmed/POS verified). Core entity for ACV/TDP metric computation and new product distribution tracking.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`price_list` (
    `price_list_id` BIGINT COMMENT 'Unique identifier for the price list record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Promotional price lists in consumer goods are created specifically for marketing campaigns (e.g., campaign-period pricing for a product launch). Linking price_list to campaign enables campaign cost tr',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Price lists are often brand‑specific, enabling brand‑level pricing strategy and compliance.',
    `superseded_by_price_list_id` BIGINT COMMENT 'Reference to the newer price list that replaces this one when status is superseded. Enables price list succession tracking and historical pricing analysis.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the price list. Tracks progression through pricing governance approval process before activation.. Valid values are `not_submitted|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the pricing manager or executive who approved this price list for activation. Required for audit trail and pricing governance compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the price list was approved for activation. Critical for audit trail and compliance with pricing governance policies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this price list record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all prices in this list are denominated. Critical for multi-currency pricing operations and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `distribution_channel` STRING COMMENT 'Distribution channel to which this price list applies. Enables channel-specific pricing strategies for retail stores, wholesale distributors, direct-to-consumer (DTC), e-commerce platforms, foodservice operators, and institutional buyers.. Valid values are `retail|wholesale|dtc|ecommerce|foodservice|institutional`',
    `division` STRING COMMENT 'SAP SD division code representing the product line or business unit to which this price list applies. Enables division-specific pricing strategies across product portfolios.',
    `effective_end_date` DATE COMMENT 'Date when the price list expires and is no longer valid for new pricing calculations. Nullable for open-ended price lists. Aligns with SAP SD condition record validity period.',
    `effective_start_date` DATE COMMENT 'Date when the price list becomes valid and active for pricing calculations in sales orders and quotations. Aligns with SAP SD condition record validity period.',
    `external_reference_code` STRING COMMENT 'External system identifier or reference number for this price list in the source system. Enables cross-system reconciliation and data lineage tracking.',
    `freight_inclusion_flag` BOOLEAN COMMENT 'Indicates whether freight costs are included in the prices in this list. True when prices are freight-inclusive (delivered pricing), false when prices are ex-works or FOB.',
    `geographic_scope` STRING COMMENT 'Geographic region, country, or territory to which this price list applies. Supports region-specific pricing strategies and regulatory compliance with local pricing regulations.',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) code defining delivery and risk transfer terms associated with prices in this list (e.g., FOB, CIF, DDP). Clarifies freight and insurance responsibilities.. Valid values are `^[A-Z]{3}$`',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required for prices in this list to apply. Used to enforce volume thresholds and support tiered pricing strategies.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this price list record. Required for audit trail and accountability in pricing governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this price list record was last modified. Supports change tracking and audit trail for pricing governance compliance.',
    `moq_uom` STRING COMMENT 'Unit of measure for the minimum order quantity threshold. May differ from price UoM to support different ordering and pricing units.. Valid values are `^[A-Z]{2,3}$`',
    `msrp_flag` BOOLEAN COMMENT 'Indicates whether this price list contains manufacturer suggested retail prices (MSRP). True when prices represent official MSRP for consumer-facing pricing and promotional compliance.',
    `notes` STRING COMMENT 'Free-form notes and comments about the price list including special conditions, exceptions, or business context for pricing decisions.',
    `payment_terms` STRING COMMENT 'Standard payment terms associated with this price list (e.g., Net 30, 2/10 Net 30). Defines credit period and early payment discount eligibility for customers purchasing under this list.',
    `price_basis` STRING COMMENT 'Pricing methodology or basis used to establish prices in this list. List price indicates standard published pricing, cost plus indicates markup over cost, market based indicates alignment with market rates, competitive indicates positioning relative to competitors, value based indicates pricing tied to customer value perception.. Valid values are `list_price|cost_plus|market_based|competitive|value_based`',
    `price_list_code` STRING COMMENT 'Unique business identifier code for the price list used in SAP SD pricing procedures and condition records. Externally-known identifier used in pricing agreements and sales documents.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `price_list_description` STRING COMMENT 'Detailed description of the price list purpose, scope, and applicability including target customer segments and product categories covered.',
    `price_list_name` STRING COMMENT 'Descriptive business name of the price list for identification and reporting purposes.',
    `price_list_status` STRING COMMENT 'Current lifecycle status of the price list. Draft indicates under development, pending approval indicates awaiting authorization, active indicates currently in use, inactive indicates temporarily disabled, expired indicates past validity period, superseded indicates replaced by newer version.. Valid values are `draft|pending_approval|active|inactive|expired|superseded`',
    `price_list_type` STRING COMMENT 'Classification of the price list by its business purpose and application context. Standard lists provide baseline pricing, promotional lists support time-limited campaigns, contract lists support negotiated agreements, channel-specific lists apply to distribution channels, seasonal lists support seasonal pricing strategies, and clearance lists support inventory liquidation.. Valid values are `standard|promotional|contract|channel_specific|seasonal|clearance`',
    `price_protection_days` STRING COMMENT 'Number of days of price protection coverage offered under this price list. Defines the lookback period for retroactive price adjustments when price protection is enabled.',
    `price_protection_flag` BOOLEAN COMMENT 'Indicates whether price protection provisions apply to this price list. When true, customers who purchased at higher prices may be eligible for retroactive credits if prices decrease during the protection period.',
    `price_rounding_rule` STRING COMMENT 'Rounding rule applied to calculated prices from this list. Supports psychological pricing strategies and currency denomination constraints.. Valid values are `none|nearest_cent|nearest_nickel|nearest_dime|nearest_dollar|up_to_99`',
    `price_uom` STRING COMMENT 'Standard unit of measure in which prices are expressed in this list (e.g., EA for each, CS for case, PAL for pallet). Aligns with SAP MM material master UoM configuration.. Valid values are `^[A-Z]{2,3}$`',
    `pricing_condition_type` STRING COMMENT 'SAP SD condition type code that defines how prices from this list are applied in pricing procedures (e.g., PR00 for base price, K004 for material price). Links price list to SAP pricing schema configuration.. Valid values are `^[A-Z0-9]{4}$`',
    `rsp_flag` BOOLEAN COMMENT 'Indicates whether this price list contains recommended selling prices (RSP) for retail partners. True when prices represent manufacturer-suggested retail pricing guidance.',
    `sales_organization` STRING COMMENT 'SAP SD sales organization code to which this price list applies. Defines the organizational scope for pricing applicability in the sales and distribution structure.. Valid values are `^[A-Z0-9]{4}$`',
    `source_system` STRING COMMENT 'Source system from which this price list record originated (e.g., SAP S/4HANA SD, Oracle Pricing Cloud, Salesforce CPQ). Supports data lineage and integration troubleshooting.',
    `tax_classification` STRING COMMENT 'Tax category or classification code applicable to prices in this list. Determines tax treatment for products priced under this list in compliance with jurisdictional tax regulations.',
    `trade_class` STRING COMMENT 'Customer trade class or customer pricing group to which this price list applies. Used to segment pricing by customer type such as mass merchandisers, drug stores, grocery chains, convenience stores, or specialty retailers.',
    `version_number` STRING COMMENT 'Sequential version number of the price list. Increments with each revision to support version control and change tracking for pricing history and audit purposes.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this price list record. Required for audit trail and accountability in pricing governance.',
    CONSTRAINT pk_price_list PRIMARY KEY(`price_list_id`)
) COMMENT 'Standard price list master defining list prices, RSP/MSRP, and channel-specific base prices for SKUs across different trade classes and geographies. Contains both header-level metadata (price list code, name, currency, effective dates, channel applicability, type, approval status) and SKU-level price entries (unit price, MOQ, price UoM, effective dates, override flags) for each product in the list. Serves as the pricing baseline from which customer-specific pricing agreements and trade discounts are derived in SAP SD condition records.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`sales`.`price_list_item` (
    `price_list_item_id` BIGINT COMMENT 'Unique identifier for the price list item record. Primary key for this entity.',
    `price_list_id` BIGINT COMMENT 'Reference to the parent price list that contains this item. Links this SKU-level price entry to its governing price list header.',
    `sku_id` BIGINT COMMENT 'Reference to the product (SKU) for which this price is defined. Identifies the specific finished good or SKU being priced.',
    `approval_status` STRING COMMENT 'The approval workflow status for this price list item. Tracks whether the price has been reviewed and approved by pricing management.. Valid values are `draft|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'The user ID or name of the person who approved this price list item. Supports audit trail and accountability for pricing decisions.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this price list item was approved. Part of the pricing governance audit trail.',
    `channel_type` STRING COMMENT 'The sales channel or distribution channel for which this price applies (e.g., retail, wholesale, DTC, e-commerce). Enables channel-specific pricing strategies.. Valid values are `retail|wholesale|dtc|ecommerce|foodservice|export`',
    `condition_type` STRING COMMENT 'The SAP SD condition type code that defines the pricing logic for this item (e.g., PR00 for base price, K004 for customer discount). Maps to SAP pricing procedure.',
    `cost_price` DECIMAL(18,2) COMMENT 'The standard cost or COGS for this SKU in the specified currency. Used for margin analysis and profitability calculations. Business-confidential data.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this price list item record was first created in the system. Part of the audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all price amounts in this record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'The customer segment or pricing group for which this price applies (e.g., national accounts, regional chains, independent retailers). Supports segment-based pricing.',
    `distribution_channel` STRING COMMENT 'The SAP distribution channel code for this price list item. Defines the route-to-market for which this price applies.',
    `division` STRING COMMENT 'The SAP division code for this price list item. Represents the product line or business unit responsible for this pricing.',
    `effective_end_date` DATE COMMENT 'The date on which this price list item expires and is no longer valid for new sales transactions. Null indicates open-ended validity.',
    `effective_start_date` DATE COMMENT 'The date from which this price list item becomes active and can be used in sales transactions. Part of the items validity period.',
    `geographic_scope` STRING COMMENT 'The geographic region, country, or market for which this price is valid. Supports regional pricing strategies and multi-country operations.',
    `gtin` STRING COMMENT 'The globally unique GTIN (UPC, EAN, or GTIN-14) for the product. Supports EDI transactions and retail POS integration.. Valid values are `^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$`',
    `item_sequence` STRING COMMENT 'Sequential line number of this item within the parent price list. Used for ordering and display purposes.',
    `list_price` DECIMAL(18,2) COMMENT 'The base list price for this SKU in the specified currency and unit of measure. Represents the standard selling price before any discounts or promotions.',
    `margin_percentage` DECIMAL(18,2) COMMENT 'The target gross margin percentage for this price list item, calculated as (list_price - cost_price) / list_price * 100. Business-confidential data.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered for this SKU at this price. Used to enforce order minimums and support volume-based pricing tiers.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this price list item record. Supports audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this price list item record was last modified. Part of the audit trail for tracking changes.',
    `moq_uom` STRING COMMENT 'The unit of measure for the minimum order quantity (e.g., EA, CS, PAL).',
    `msrp_price` DECIMAL(18,2) COMMENT 'The manufacturers suggested retail price for this SKU. Used for retail channel pricing guidance and price protection calculations.',
    `notes` STRING COMMENT 'Free-text notes or comments about this price list item. Used to document special pricing conditions, exceptions, or business rationale.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this price list item represents a manual override of standard pricing logic. True if this is an exception price.',
    `price_list_item_status` STRING COMMENT 'Current lifecycle status of this price list item. Controls whether the item can be used in pricing calculations.. Valid values are `active|inactive|pending|expired|superseded`',
    `price_uom` STRING COMMENT 'The unit of measure for which the price is quoted (e.g., EA for each, CS for case, PAL for pallet). Aligns with product packaging hierarchy.',
    `pricing_unit_quantity` DECIMAL(18,2) COMMENT 'The quantity of base units represented by one pricing unit. For example, if price is per case and a case contains 12 units, this value is 12.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this price is part of a promotional campaign. True if this is a temporary promotional price rather than standard list price.',
    `rsp_price` DECIMAL(18,2) COMMENT 'The recommended selling price for this SKU in the target market. May differ from MSRP based on regional pricing strategies.',
    `sales_organization` STRING COMMENT 'The SAP sales organization code responsible for this price list item. Aligns with organizational hierarchy and reporting structure.',
    `sap_condition_record_number` STRING COMMENT 'The unique SAP SD condition record number for this price list item. Enables traceability back to the source ERP system.',
    `scale_basis` STRING COMMENT 'The basis for volume-based pricing scales (e.g., quantity, order value, weight, volume). Defines how tiered pricing thresholds are measured.. Valid values are `quantity|value|weight|volume`',
    `scale_quantity_from` DECIMAL(18,2) COMMENT 'The lower bound of the quantity range for which this price applies in a tiered pricing structure. Used for volume discount calculations.',
    `scale_quantity_to` DECIMAL(18,2) COMMENT 'The upper bound of the quantity range for which this price applies in a tiered pricing structure. Null indicates no upper limit for the highest tier.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this price list item record. Supports audit trail and accountability.',
    CONSTRAINT pk_price_list_item PRIMARY KEY(`price_list_item_id`)
) COMMENT 'Individual SKU-level price entry within a price list, capturing the specific list price or MSRP/RSP for a given product in a given channel and currency. Records SKU/GTIN reference, price list reference, unit price, minimum order quantity (MOQ), price unit of measure, effective dates, and override flag. Enables granular SKU-level pricing management and supports SAP SD condition record maintenance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ADD CONSTRAINT `fk_sales_account_hierarchy_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ADD CONSTRAINT `fk_sales_account_hierarchy_primary_trade_account_id` FOREIGN KEY (`primary_trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ADD CONSTRAINT `fk_sales_retail_store_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ADD CONSTRAINT `fk_sales_account_segment_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `consumer_goods_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ADD CONSTRAINT `fk_sales_account_segment_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `consumer_goods_ecm`.`sales`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `consumer_goods_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `consumer_goods_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `consumer_goods_ecm`.`sales`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `consumer_goods_ecm`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ADD CONSTRAINT `fk_sales_pricing_agreement_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `consumer_goods_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `consumer_goods_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `consumer_goods_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ADD CONSTRAINT `fk_sales_account_call_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `consumer_goods_ecm`.`sales`.`invoice`(`invoice_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `consumer_goods_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_manager_rep_id` FOREIGN KEY (`manager_rep_id`) REFERENCES `consumer_goods_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `consumer_goods_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `consumer_goods_ecm`.`sales`.`rep`(`rep_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ADD CONSTRAINT `fk_sales_quota_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `consumer_goods_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_retail_store_id` FOREIGN KEY (`retail_store_id`) REFERENCES `consumer_goods_ecm`.`sales`.`retail_store`(`retail_store_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ADD CONSTRAINT `fk_sales_distribution_point_trade_account_id` FOREIGN KEY (`trade_account_id`) REFERENCES `consumer_goods_ecm`.`sales`.`trade_account`(`trade_account_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_superseded_by_price_list_id` FOREIGN KEY (`superseded_by_price_list_id`) REFERENCES `consumer_goods_ecm`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ADD CONSTRAINT `fk_sales_price_list_item_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `consumer_goods_ecm`.`sales`.`price_list`(`price_list_id`);

-- ========= TAGS =========
ALTER SCHEMA `consumer_goods_ecm`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `consumer_goods_ecm`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Distribution Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Default Storage Location Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `account_close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `account_open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|credit_hold|closed');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'tier_1_national|tier_2_regional|tier_3_local|tier_4_independent');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'retailer|distributor|wholesaler|foodservice_operator|broker');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `acv_total` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Total');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `acv_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `dsd_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `otif_sla_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Service Level Agreement (SLA) Target Percent');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|edi_payment|credit_card');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Account Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `status_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Change Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `status_changed_by_user` SET TAGS ('dbx_business_glossary_term' = 'Status Changed By User');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `tax_exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `tdp_count` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Count');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `trade_channel` SET TAGS ('dbx_business_glossary_term' = 'Trade Channel Classification');
ALTER TABLE `consumer_goods_ecm`.`sales`.`trade_account` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `account_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Child Account Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `primary_trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `acv_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Roll-Up Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `consolidation_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `hierarchy_depth` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Depth');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_value_regex' = 'store|banner|chain|parent_corporation|division|region');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'commercial|logistics|financial|reporting|legal|operational');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `primary_hierarchy_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Hierarchy Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_code` SET TAGS ('dbx_business_glossary_term' = 'Relationship Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_name` SET TAGS ('dbx_business_glossary_term' = 'Relationship Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `rollup_weight` SET TAGS ('dbx_business_glossary_term' = 'Roll-Up Weight');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `sales_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'Sales Roll-Up Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `tdp_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Roll-Up Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_hierarchy` ALTER COLUMN `trade_spend_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'Trade Spend Roll-Up Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Distribution Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `acv_weight` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Weight');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `banner_name` SET TAGS ('dbx_business_glossary_term' = 'Banner Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Store Close Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `dsd_route_code` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Route Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `last_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Visit Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `next_scheduled_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Visit Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Store Open Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `osa_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Shelf Availability (OSA) Target Percentage');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `otif_sla_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Service Level Agreement (SLA) Target Percentage');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `planogram_zone` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Zone');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `pos_system_type` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) System Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `store_format` SET TAGS ('dbx_business_glossary_term' = 'Store Format');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `store_name` SET TAGS ('dbx_business_glossary_term' = 'Store Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `store_number` SET TAGS ('dbx_business_glossary_term' = 'Store Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `store_phone` SET TAGS ('dbx_business_glossary_term' = 'Store Phone Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `store_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `store_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `store_size_sq_ft` SET TAGS ('dbx_business_glossary_term' = 'Store Size (Square Feet)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `store_status` SET TAGS ('dbx_business_glossary_term' = 'Store Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `store_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_opening|temporarily_closed|permanently_closed|under_renovation');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `store_tier` SET TAGS ('dbx_business_glossary_term' = 'Store Tier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `store_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `tdp_weight` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Weight');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `trading_area` SET TAGS ('dbx_business_glossary_term' = 'Trading Area');
ALTER TABLE `consumer_goods_ecm`.`sales`.`retail_store` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `account_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Account Segment ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `acv_tier` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Tier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `acv_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_measured');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `applicable_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `channel_tier` SET TAGS ('dbx_business_glossary_term' = 'Channel Tier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `channel_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|unassigned');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `credit_limit_tier` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Tier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `credit_limit_tier` SET TAGS ('dbx_value_regex' = 'unlimited|high|medium|low|restricted');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `customer_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Tier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `customer_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `dsd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `edi_trading_partner_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Trading Partner Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `field_sales_call_frequency` SET TAGS ('dbx_business_glossary_term' = 'Field Sales Call Frequency');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `field_sales_call_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|annual|as_needed');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `otif_sla_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Service Level Agreement (SLA) Target Percentage');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'edlp|hi_lo|hybrid|custom|standard');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `primary_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `primary_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `primary_channel_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `segment_assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Reason');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `segmentation_model_version` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Model Version');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `segmentation_model_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,20}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `strategic_priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `tdp_tier` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Tier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `tdp_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_measured');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `trade_promotion_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Eligibility');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `trade_promotion_eligibility` SET TAGS ('dbx_value_regex' = 'full|limited|excluded|pending_review');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_segment` ALTER COLUMN `vmi_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Eligible Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Warehouse Identifier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location Identifier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Approval Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Cancellation Reason');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|dtc|ecommerce|distributor');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `division` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `incoterm` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source System');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'web_portal|edi|sales_rep|call_center|mobile_app|marketplace');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|rush|drop_ship|direct_store_delivery|promotional|sample');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `otif_status` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `otif_status` SET TAGS ('dbx_value_regex' = 'on_time_in_full|late|partial|not_applicable');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority Level');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|critical');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `sales_office` SET TAGS ('dbx_business_glossary_term' = 'Sales Office Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `sales_office` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `sales_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `sap_sd_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales and Distribution (SD) Document Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `sap_sd_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'ground|air|ocean|rail|courier|dsd');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Subtotal Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Total Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location Identifier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `billing_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Document Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `billing_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|proforma|intercompany|consignment');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Cancellation Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `cost_of_goods_sold_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `cost_of_goods_sold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `days_sales_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Product Division Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `division_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `edi_document_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Document Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `edi_transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `edi_transmission_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|transmitted|acknowledged|rejected|failed');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight and Shipping Charge Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterm) Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Issue Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Lifecycle Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes and Comments');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Receivable Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid to Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Settlement Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partially_paid|paid|overpaid|written_off');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Category');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|deferred|subscription|service');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`invoice` ALTER COLUMN `trade_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Discount Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'standard|volume_tiered|promotional|rebate|contract|spot');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `base_list_price` SET TAGS ('dbx_business_glossary_term' = 'Base List Price');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `contracted_net_price` SET TAGS ('dbx_business_glossary_term' = 'Contracted Net Price');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `msrp_price` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Notes');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `price_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|terminated');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|custom');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `product_scope` SET TAGS ('dbx_value_regex' = 'all_products|product_category|specific_skus|brand');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `promotional_allowance` SET TAGS ('dbx_business_glossary_term' = 'Promotional Allowance');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `rsp_price` SET TAGS ('dbx_business_glossary_term' = 'Recommended Selling Price (RSP)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `volume_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold Quantity');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `volume_threshold_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `volume_threshold_uom` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`pricing_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Representative ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|dtc|ecommerce|dsd|foodservice');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `competitive_displacement_context` SET TAGS ('dbx_business_glossary_term' = 'Competitive Displacement Context');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_acv_gain` SET TAGS ('dbx_business_glossary_term' = 'Estimated ACV (All Commodity Volume) Gain');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Incremental Annual Revenue');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated SKU (Stock Keeping Unit) Count');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_tdp_gain` SET TAGS ('dbx_business_glossary_term' = 'Estimated TDP (Total Distribution Points) Gain');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = '^Q[1-4]sd{4}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'pipeline|best_case|commit|closed');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `jbp_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'JBP (Joint Business Planning) Alignment Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_value_regex' = 'inbound_inquiry|field_sales_prospecting|trade_show|referral|marketing_campaign|existing_account_expansion');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `next_step_description` SET TAGS ('dbx_business_glossary_term' = 'Next Step Description');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_type` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `probability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Stage');
ALTER TABLE `consumer_goods_ecm`.`sales`.`opportunity` ALTER COLUMN `win_reason` SET TAGS ('dbx_business_glossary_term' = 'Win Reason');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `account_call_id` SET TAGS ('dbx_business_glossary_term' = 'Account Call Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `oos_event_id` SET TAGS ('dbx_business_glossary_term' = 'Oos Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `activities_completed` SET TAGS ('dbx_business_glossary_term' = 'Activities Completed');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `call_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Call Duration in Minutes');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `call_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call End Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `call_notes` SET TAGS ('dbx_business_glossary_term' = 'Call Notes');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `call_number` SET TAGS ('dbx_business_glossary_term' = 'Call Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `call_objective` SET TAGS ('dbx_business_glossary_term' = 'Call Objective');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `call_outcome` SET TAGS ('dbx_business_glossary_term' = 'Call Outcome');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `call_outcome` SET TAGS ('dbx_value_regex' = 'successful|partially_successful|unsuccessful|rescheduled');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `call_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call Start Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `call_status` SET TAGS ('dbx_business_glossary_term' = 'Call Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `call_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|no_show');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `call_type` SET TAGS ('dbx_business_glossary_term' = 'Call Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `call_type` SET TAGS ('dbx_value_regex' = 'routine|promotional|merchandising|compliance_audit|new_product_introduction|problem_resolution');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `competitor_activity_observed` SET TAGS ('dbx_business_glossary_term' = 'Competitor Activity Observed');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `competitor_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitor Pricing Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `corrective_actions_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Completed Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `display_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Display Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `display_type` SET TAGS ('dbx_business_glossary_term' = 'Display Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `display_type` SET TAGS ('dbx_value_regex' = 'end_cap|floor_stand|pallet|shelf_talker|cooler|none');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `facings_actual` SET TAGS ('dbx_business_glossary_term' = 'Facings Actual');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `facings_required` SET TAGS ('dbx_business_glossary_term' = 'Facings Required');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_business_glossary_term' = 'Mobile Device Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `next_call_date` SET TAGS ('dbx_business_glossary_term' = 'Next Call Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `oos_items_count` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Items Count');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `oos_items_list` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Items List');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `photo_evidence_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence Count');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `photo_storage_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Storage Reference');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `pog_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Compliance Score');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Call Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `shelf_position_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Shelf Position Compliant Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Signature Reference');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `store_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Store Contact Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `store_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `store_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `sync_status` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`account_call` ALTER COLUMN `sync_status` SET TAGS ('dbx_value_regex' = 'synced|pending|failed');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `return_order_id` SET TAGS ('dbx_business_glossary_term' = 'Return Order ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Sales Order ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Product Complaint Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `credit_memo_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Issued Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_value_regex' = '^CM-[A-Z0-9]{8,12}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `credit_memo_posted_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Posted Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `credit_memo_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `customer_responsible_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Responsible Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `disposition_instruction` SET TAGS ('dbx_business_glossary_term' = 'Disposition Instruction');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `division` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `goods_received_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Received Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `inspection_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completed Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `original_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Original Unit Price');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_value_regex' = 'passed|failed|partial|not_inspected');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `return_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_value_regex' = '^RMA-[A-Z0-9]{8,12}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `return_order_type` SET TAGS ('dbx_business_glossary_term' = 'Return Order Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `return_order_type` SET TAGS ('dbx_value_regex' = 'retail_account_return|distributor_return|dtc_consumer_return|wholesale_return');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `return_request_date` SET TAGS ('dbx_business_glossary_term' = 'Return Request Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `return_shipping_cost` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Cost');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `return_value_gross` SET TAGS ('dbx_business_glossary_term' = 'Return Value Gross');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `return_value_net` SET TAGS ('dbx_business_glossary_term' = 'Return Value Net');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `returned_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `sales_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`return_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `account_count` SET TAGS ('dbx_business_glossary_term' = 'Account Count');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `acv_coverage` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Coverage');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Quota Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `call_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Call Frequency in Days');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `channel_assignment` SET TAGS ('dbx_business_glossary_term' = 'Channel Assignment');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `district` SET TAGS ('dbx_business_glossary_term' = 'Sales District');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `dsd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `edi_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capability Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `pog_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Compliance Required Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `postal_code_list` SET TAGS ('dbx_business_glossary_term' = 'Postal Code List');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `postal_code_list` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `postal_code_list` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|strategic|standard');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `state_province_list` SET TAGS ('dbx_business_glossary_term' = 'State or Province List');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `store_count` SET TAGS ('dbx_business_glossary_term' = 'Store Count');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `tdp_coverage` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Coverage');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'field|key_account|national_account|regional|district|channel');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `trade_class` SET TAGS ('dbx_business_glossary_term' = 'Trade Class');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `vmi_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Eligible Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`territory` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Identifier');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `manager_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Sales Representative ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `badge_number` SET TAGS ('dbx_business_glossary_term' = 'Badge Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|expired|not_required');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `channel_specialization` SET TAGS ('dbx_business_glossary_term' = 'Channel Specialization');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `commission_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `current_quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Quota Amount');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `last_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Certification Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_business_glossary_term' = 'Mobile Device ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|below|new_hire');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `quota_period` SET TAGS ('dbx_business_glossary_term' = 'Quota Period');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `quota_period` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `rep_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `rep_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `rep_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `rep_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|suspended|terminated');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `rep_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `rep_type` SET TAGS ('dbx_value_regex' = 'field_sales|key_account_manager|national_account_manager|inside_sales|dsd_driver|regional_manager');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `sales_group` SET TAGS ('dbx_business_glossary_term' = 'Sales Group');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `sales_office` SET TAGS ('dbx_business_glossary_term' = 'Sales Office');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `sfa_user_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Force Automation (SFA) User ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `sfa_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `sfa_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `vehicle_assigned` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assigned Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`rep` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `quota_id` SET TAGS ('dbx_business_glossary_term' = 'Quota ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `accelerator_rate` SET TAGS ('dbx_business_glossary_term' = 'Accelerator Rate');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|dtc|ecommerce|dsd');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `minimum_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Threshold');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Quota Period Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `product_scope` SET TAGS ('dbx_value_regex' = 'all_products|category|brand|sku');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `quota_name` SET TAGS ('dbx_business_glossary_term' = 'Quota Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `quota_number` SET TAGS ('dbx_business_glossary_term' = 'Quota Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `quota_source` SET TAGS ('dbx_business_glossary_term' = 'Quota Source');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `quota_source` SET TAGS ('dbx_value_regex' = 'top_down|bottom_up|negotiated|algorithmic');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `quota_status` SET TAGS ('dbx_business_glossary_term' = 'Quota Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `quota_type` SET TAGS ('dbx_business_glossary_term' = 'Quota Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `quota_value` SET TAGS ('dbx_business_glossary_term' = 'Quota Value');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `stretch_target` SET TAGS ('dbx_business_glossary_term' = 'Stretch Target');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Quota Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`quota` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `distribution_point_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Point ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `label_version_id` SET TAGS ('dbx_business_glossary_term' = 'Label Version Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `actual_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Actual Retail Price');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `acv_percentage` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Percentage');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `acv_weighted_flag` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Weighted Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `delist_date` SET TAGS ('dbx_business_glossary_term' = 'Delist Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'active|inactive|authorized|delisted|pending|suspended');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `distribution_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Verification Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `facing_count` SET TAGS ('dbx_business_glossary_term' = 'Shelf Facing Count');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `last_pos_sale_date` SET TAGS ('dbx_business_glossary_term' = 'Last Point of Sale (POS) Sale Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `launch_wave` SET TAGS ('dbx_business_glossary_term' = 'Product Launch Wave');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `msrp_price` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `new_product_flag` SET TAGS ('dbx_business_glossary_term' = 'New Product Distribution Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Point Notes');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `osa_status` SET TAGS ('dbx_business_glossary_term' = 'On Shelf Availability (OSA) Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `osa_status` SET TAGS ('dbx_value_regex' = 'in_stock|out_of_stock|low_stock|unknown');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `planogram_slot_reference` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Slot Reference');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `pog_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `rsp_price` SET TAGS ('dbx_business_glossary_term' = 'Recommended Selling Price (RSP)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `shelf_position` SET TAGS ('dbx_business_glossary_term' = 'Shelf Position');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `shelf_position` SET TAGS ('dbx_value_regex' = 'eye_level|top_shelf|middle_shelf|bottom_shelf|end_cap|promotional_display');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `tdp_count_flag` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Count Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `vmi_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`distribution_point` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `superseded_by_price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Price List ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'retail|wholesale|dtc|ecommerce|foodservice|institutional');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `freight_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Freight Inclusion Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `incoterm` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `moq_uom` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure (UoM)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `moq_uom` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `msrp_flag` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_basis` SET TAGS ('dbx_value_regex' = 'list_price|cost_plus|market_based|competitive|value_based');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_code` SET TAGS ('dbx_business_glossary_term' = 'Price List Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_description` SET TAGS ('dbx_business_glossary_term' = 'Price List Description');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_name` SET TAGS ('dbx_business_glossary_term' = 'Price List Name');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|inactive|expired|superseded');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_type` SET TAGS ('dbx_business_glossary_term' = 'Price List Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_type` SET TAGS ('dbx_value_regex' = 'standard|promotional|contract|channel_specific|seasonal|clearance');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_protection_days` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Days');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_rounding_rule` SET TAGS ('dbx_business_glossary_term' = 'Price Rounding Rule');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_rounding_rule` SET TAGS ('dbx_value_regex' = 'none|nearest_cent|nearest_nickel|nearest_dime|nearest_dollar|up_to_99');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UoM)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `pricing_condition_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `pricing_condition_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `rsp_flag` SET TAGS ('dbx_business_glossary_term' = 'Recommended Selling Price (RSP) Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `sales_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `trade_class` SET TAGS ('dbx_business_glossary_term' = 'Trade Class');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|wholesale|dtc|ecommerce|foodservice|export');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'SAP Condition Type');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `cost_price` SET TAGS ('dbx_business_glossary_term' = 'Cost Price');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `cost_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `item_sequence` SET TAGS ('dbx_business_glossary_term' = 'Item Sequence Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percentage');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `margin_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `moq_uom` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `msrp_price` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Notes');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Override Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `price_list_item_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Status');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `price_list_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `pricing_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pricing Unit Quantity');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Price Flag');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `rsp_price` SET TAGS ('dbx_business_glossary_term' = 'Recommended Selling Price (RSP)');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `sap_condition_record_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Condition Record Number');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `scale_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Scale Basis');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `scale_basis` SET TAGS ('dbx_value_regex' = 'quantity|value|weight|volume');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `scale_quantity_from` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity From');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `scale_quantity_to` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity To');
ALTER TABLE `consumer_goods_ecm`.`sales`.`price_list_item` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
