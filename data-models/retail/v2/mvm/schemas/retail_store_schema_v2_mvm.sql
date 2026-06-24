-- Schema for Domain: store | Business: Retail | Version: v2_mvm
-- Generated on: 2026-06-24 00:49:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_retail_v1`.`store` COMMENT 'Manages physical retail locations including hypermarkets, department stores, discount outlets, dark stores, and micro-fulfillment centers (MFC). Owns store master records, planograms (POG), gondola and endcap configurations, footfall metrics, comp sales (SSS - Same-Store Sales), visual merchandising standards, POS terminal inventory, and store-level P&L. Supports store operations and omnichannel fulfillment as ship-from-store nodes.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_retail_v1`.`store`.`location` (
    `location_id` BIGINT COMMENT 'Unique identifier for the physical retail location. Primary key for the store_location data product. This is the system-of-record identifier used across all domains (inventory, order, workforce, finance) to reference this specific store, dark store, or micro-fulfillment center (MFC).',
    `format_id` BIGINT COMMENT 'Foreign key linking to store.store_format. Business justification: Every store location is classified by a store format (hypermarket, discount outlet, department store, etc.). The store_location record currently denormalizes format_type as a STRING. Adding FK to stor',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Stores belong to price zones for regional pricing strategies. This is a fundamental retail concept - stores in the same geographic area or market segment share pricing rules. No visible redundant colu',
    `region_id` BIGINT COMMENT 'Foreign key linking to store.region. Business justification: location currently stores region_code as a denormalized STRING. Adding region_id FK to store.region.region_id normalizes this relationship — a store location belongs to exactly one geographic region. ',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to store.sales_territory. Business justification: A store location belongs to exactly one sales territory for sales planning, rep assignment, and revenue targeting. The location table has district_code as a string but no FK to the sales_territory mas',
    `accessibility_certified` BOOLEAN COMMENT 'Indicates whether the store location is certified as fully accessible for customers with disabilities, meeting ADA (Americans with Disabilities Act) or equivalent local accessibility standards. True = certified accessible; False = not certified or non-compliant.',
    `address_line1` STRING COMMENT 'Primary street address line for the store location (street number and name). Used for customer navigation, delivery routing, and regulatory filings. Organizational contact data classified as confidential.',
    `address_line2` STRING COMMENT 'Secondary address line for the store location (suite, unit, building). Null if not applicable. Organizational contact data classified as confidential.',
    `assortment_breadth_norm` STRING COMMENT 'Standard assortment breadth (range of categories) for this store format. Narrow = limited category count (convenience); Moderate = balanced category mix; Broad = wide category range; Very Broad = full-line assortment (hypermarket). Used for merchandising strategy.. Valid values are `narrow|moderate|broad|very_broad`',
    `assortment_depth_norm` STRING COMMENT 'Standard assortment depth (variety within a category) for this store format. Shallow = limited SKU count per category; Moderate = balanced SKU selection; Deep = extensive SKU variety; Very Deep = maximum SKU variety. Used for category management and space planning.. Valid values are `shallow|moderate|deep|very_deep`',
    `banner_brand` STRING COMMENT 'The retail banner or brand under which this location operates (e.g., Retail Hypermarket, Retail Discount, Retail Express). Used for brand segmentation, assortment planning, and marketing strategy.',
    `bopis_capable` BOOLEAN COMMENT 'Indicates whether this store location supports BOPIS (Buy Online Pick Up In Store) fulfillment. True = BOPIS enabled with dedicated pickup area; False = BOPIS not available. Used for omnichannel order routing and customer service.',
    `city` STRING COMMENT 'City or municipality where the store location is situated. Used for geographic segmentation, market analysis, and regulatory compliance.',
    `climate_zone` STRING COMMENT 'Climate zone classification for the store location. Used for seasonal assortment planning, HVAC energy management, and merchandise mix optimization (e.g., winter apparel depth in continental zones).. Valid values are `tropical|subtropical|temperate|continental|polar`',
    `closure_date` DATE COMMENT 'The date this store location permanently ceased operations. Null for active stores. Used for historical analysis, lease termination tracking, and asset disposition planning.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the store location is situated (e.g., USA, CAN, MEX). Used for regulatory compliance, currency determination, and international reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this store location record was first created in the system. Used for data lineage, audit trails, and record lifecycle tracking.',
    `district_code` STRING COMMENT 'Code identifying the retail district or region to which this store location belongs. Used for hierarchical reporting, district manager accountability, and regional performance analysis.',
    `dsd_receiving` BOOLEAN COMMENT 'Indicates whether this store location accepts Direct Store Delivery (DSD) from vendors, bypassing the distribution center (DC). True = DSD receiving enabled; False = all inventory flows through DC. Common for beverages, snacks, and bread.',
    `email_address` STRING COMMENT 'Primary email address for the store location. Used for operational communications, customer service escalations, and vendor coordination. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `format_size_band` STRING COMMENT 'Size classification band for the store format, used for assortment planning and operational benchmarking. Small = <20K sq ft; Medium = 20K-50K sq ft; Large = 50K-100K sq ft; Extra Large = >100K sq ft. Bands are format-specific.. Valid values are `small|medium|large|extra_large`',
    `last_remodel_date` DATE COMMENT 'The date of the most recent major remodel or renovation of this store location. Used for capital expenditure tracking, store refresh planning, and performance analysis post-remodel.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the store location in decimal degrees. Used for geospatial analysis, delivery routing, trade area mapping, and proximity-based customer targeting.',
    `legal_entity_name` STRING COMMENT 'The legal entity name under which this store location operates. Used for regulatory filings, tax reporting, and legal compliance. May differ from the trading name.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the store location in its lifecycle. Planned = approved but not yet built; Under Construction = site work in progress; Open = actively trading; Temporarily Closed = closed for short-term reasons (weather, emergency); Permanently Closed = ceased operations; Remodeling = closed for renovation.. Valid values are `planned|under_construction|open|temporarily_closed|permanently_closed|remodeling`',
    `locale` STRING COMMENT 'Locale identifier for the store location in format language_COUNTRY (e.g., en_US, es_MX, fr_CA). Used for localized pricing, signage, customer communications, and regulatory compliance.. Valid values are `^[a-z]{2}_[A-Z]{2}$`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the store location in decimal degrees. Used for geospatial analysis, delivery routing, trade area mapping, and proximity-based customer targeting.',
    `manager_name` STRING COMMENT 'Full name of the current store manager responsible for this location. Used for operational accountability, escalation routing, and organizational reporting. Business reference, not direct PII.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this store location record was last modified. Used for data lineage, change tracking, and audit trails. Updated on every record change.',
    `number_of_floors` STRING COMMENT 'Total number of customer-accessible floors in the store location. Used for store layout planning, accessibility compliance, and customer flow analysis.',
    `opening_date` DATE COMMENT 'The date this store location first opened for business. Used for comp sales (SSS - Same-Store Sales) calculations, anniversary planning, and store maturity analysis. Null for planned stores not yet opened.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the store location, typically in format Mon-Fri 8:00-22:00, Sat-Sun 9:00-21:00. Used for workforce scheduling, customer communications, and omnichannel order fulfillment time windows.',
    `parking_capacity` STRING COMMENT 'Total number of customer parking spaces available at the store location. Used for site selection, customer convenience analysis, and BOPIS/ROPIS pickup planning. Null for urban locations without dedicated parking.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the store location. Used for customer inquiries, BOPIS/ROPIS coordination, and operational communications. Organizational contact data classified as confidential.',
    `postal_code` STRING COMMENT 'Postal code or ZIP code for the store location. Used for delivery routing, trade area analysis, and demographic segmentation. Organizational contact data classified as confidential.',
    `primary_dc_facility_code` BIGINT COMMENT 'Foreign key linking to supplychain.dc_facility. Business justification: Every store has a primary DC assignment for standard replenishment routing. Fundamental retail supply chain topology required for: replenishment order routing, freight cost allocation, lead time calcu',
    `ropis_capable` BOOLEAN COMMENT 'Indicates whether this store location supports ROPIS (Reserve Online Pick Up In Store) fulfillment, where customers reserve items online and complete purchase in-store. True = ROPIS enabled; False = ROPIS not available.',
    `selling_square_footage` DECIMAL(18,2) COMMENT 'Square footage of customer-accessible selling floor space, excluding back-of-house, storage, and office areas. Used for sales per square foot calculations, planogram (POG) planning, and merchandising density analysis.',
    `sfs_capable` BOOLEAN COMMENT 'Indicates whether this store location is enabled as a Ship-from-Store (SFS) fulfillment node, capable of picking, packing, and shipping e-commerce orders directly from store inventory. True = SFS enabled; False = SFS not available.',
    `staffing_model_type` STRING COMMENT 'The staffing model classification for this store format. Full Service = high staff-to-customer ratio with clienteling; Limited Service = moderate staffing; Self Service = minimal staff, customer self-checkout; Automated = dark store or MFC with no customer-facing staff.. Valid values are `full_service|limited_service|self_service|automated`',
    `state_province` STRING COMMENT 'State or province code (2-letter ISO or postal abbreviation) where the store location is situated. Used for tax jurisdiction determination, regulatory compliance, and regional reporting.. Valid values are `^[A-Z]{2}$`',
    `store_name` STRING COMMENT 'The trading name or display name of the store location as it appears to customers (e.g., Retail Superstore Downtown, Retail Express Market Hill). Used for customer communications, receipts, and marketing materials.',
    `store_number` STRING COMMENT 'Externally-known business identifier for the store location. This is the human-readable store number used in operational communications, signage, and customer-facing materials. Unique within the retail banner/brand.. Valid values are `^[A-Z0-9]{4,12}$`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the store location (e.g., America/New_York, America/Chicago). Used for POS transaction timestamping, workforce scheduling, and omnichannel order fulfillment coordination.. Valid values are `^[A-Z]{3,5}$`',
    `total_square_footage` DECIMAL(18,2) COMMENT 'Total building square footage of the store location, including selling floor, back-of-house, storage, and office space. Used for productivity metrics (sales per square foot), lease accounting, and facility management.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master record for every physical retail location operated by the business, including hypermarkets, department stores, discount outlets, dark stores, and micro-fulfillment centers (MFCs). Captures store number, banner/brand, format type (hypermarket, department, discount, dark store, MFC), format size band, assortment depth/breadth norms, staffing model type, fulfillment capability flags (BOPIS-capable, ROPIS-capable, SFS-capable, DSD-receiving), trading name, legal entity, opening date, closure date, remodel history, square footage (total and selling), number of floors, parking capacity, operating hours, time zone, locale, climate zone, accessibility certifications, and store lifecycle status. This is the SSOT for all store identity, classification, and format configuration data consumed by inventory, order, workforce, and finance domains.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`store`.`format` (
    `format_id` BIGINT COMMENT 'Unique identifier for the store format. Primary key.',
    `parent_format_id` BIGINT COMMENT 'Add column parent_format_id (BIGINT) to store.format with FK to store.format.format_id because store formats may have hierarchical relationships. P17: connect_table: store.format** - add column parent_format_id (BIGINT) with FK to store.for',
    `assortment_breadth_level` STRING COMMENT 'Typical range of product categories carried by this format. Narrow = few categories (e.g., convenience); broad = many categories (e.g., hypermarket).. Valid values are `narrow|moderate|broad|very_broad`',
    `assortment_depth_level` STRING COMMENT 'Typical variety within each product category for this format. Shallow = limited SKU (Stock Keeping Unit) variety per category; deep = extensive SKU variety per category.. Valid values are `shallow|moderate|deep|very_deep`',
    `bopis_capable_flag` BOOLEAN COMMENT 'Indicates whether stores of this format are capable of supporting BOPIS (Buy Online Pick Up In Store) fulfillment. True if BOPIS is supported; false otherwise.',
    `clienteling_service_flag` BOOLEAN COMMENT 'Indicates whether stores of this format offer clienteling (personalized in-store service) to customers. True if clienteling is offered; false otherwise.',
    `format_code` STRING COMMENT 'Short alphanumeric code representing the store format (e.g., HM for hypermarket, SS for superstore, DS for discount store, CONV for convenience, DARK for dark store, MFC for micro-fulfillment center).. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this store format record was first created in the system.',
    `format_description` STRING COMMENT 'Detailed description of the store format including its purpose, target customer segment, and operational characteristics.',
    `dsd_receiving_flag` BOOLEAN COMMENT 'Indicates whether stores of this format receive DSD (Direct Store Delivery) shipments directly from vendors, bypassing the DC (Distribution Center). True if DSD receiving is supported; false otherwise.',
    `effective_end_date` DATE COMMENT 'Date when this store format definition was retired or deprecated. Null for currently active formats.',
    `effective_start_date` DATE COMMENT 'Date when this store format definition became effective and available for use in store planning and operations.',
    `endcap_count_typical` STRING COMMENT 'Typical number of endcaps (end-of-aisle displays) available for promotional merchandising in stores of this format.',
    `format_status` STRING COMMENT 'Current lifecycle status of the store format. Active formats are in use across the banner portfolio; deprecated formats are being phased out; pilot formats are under testing.. Valid values are `active|inactive|deprecated|pilot`',
    `format_type` STRING COMMENT 'High-level classification of the format: physical_retail (customer-facing), fulfillment_only (dark store, MFC), or hybrid (ship-from-store capable retail location).. Valid values are `physical_retail|fulfillment_only|hybrid`',
    `gondola_configuration_type` STRING COMMENT 'Typical gondola (shelving unit) configuration used in stores of this format. Defines the standard shelving layout and fixture type.. Valid values are `standard|high_density|low_profile|modular|custom`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this store format record was last updated in the system.',
    `loyalty_program_participation_flag` BOOLEAN COMMENT 'Indicates whether stores of this format participate in the enterprise loyalty program. True if loyalty program is active; false otherwise.',
    `format_name` STRING COMMENT 'Full descriptive name of the store format (e.g., Hypermarket, Superstore, Department Store, Discount Outlet, Convenience Store, Dark Store, Micro-Fulfillment Center, Ship-from-Store Node).',
    `operating_hours_type` STRING COMMENT 'Typical operating hours pattern for stores of this format. 24_7 = open 24 hours; extended = long hours (e.g., 6am-midnight); standard = typical retail hours; limited = short hours; variable = hours vary by location.. Valid values are `24_7|extended|standard|limited|variable`',
    `parking_capacity_typical` STRING COMMENT 'Typical number of parking spaces available at stores of this format. Null for formats without customer parking (e.g., dark stores, MFCs).',
    `planogram_template_code` STRING COMMENT 'Code identifying the standard planogram (POG - Shelf Layout Diagram) template used for visual merchandising in stores of this format. Links to master planogram library.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `pos_terminal_count_max` STRING COMMENT 'Maximum number of POS (Point of Sale) terminals typically deployed in stores of this format. Defines the upper bound of checkout capacity.',
    `pos_terminal_count_min` STRING COMMENT 'Minimum number of POS (Point of Sale) terminals typically deployed in stores of this format. Defines the lower bound of checkout capacity.',
    `pricing_strategy_type` STRING COMMENT 'Typical pricing strategy employed by stores of this format. EDLP (Everyday Low Price) = consistent low prices; Hi-Lo (High-Low Pricing Strategy) = regular prices with frequent promotions; premium = higher prices with quality focus; discount = below-market pricing; dynamic = algorithmic pricing.. Valid values are `edlp|hi_lo|premium|discount|dynamic`',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether stores of this format use RFID (Radio Frequency Identification) technology for inventory tracking and shrinkage prevention. True if RFID is deployed; false otherwise.',
    `ropis_capable_flag` BOOLEAN COMMENT 'Indicates whether stores of this format are capable of supporting ROPIS (Reserve Online Pick Up In Store) fulfillment. True if ROPIS is supported; false otherwise.',
    `sfs_capable_flag` BOOLEAN COMMENT 'Indicates whether stores of this format are capable of serving as SFS (Ship-from-Store) fulfillment nodes for e-commerce orders. True if SFS is supported; false otherwise.',
    `size_band_max_sqft` DECIMAL(18,2) COMMENT 'Maximum store size in square feet for this format. Defines the upper bound of the typical size range.',
    `size_band_min_sqft` DECIMAL(18,2) COMMENT 'Minimum store size in square feet for this format. Defines the lower bound of the typical size range.',
    `staffing_model_type` STRING COMMENT 'Typical staffing and service model for this format. Full service = high staff-to-customer ratio with personalized assistance; self-service = minimal staff, customer-driven; automated = robotic/automated fulfillment.. Valid values are `full_service|limited_service|self_service|automated|hybrid`',
    `target_demographic` STRING COMMENT 'Primary customer demographic segment targeted by this store format (e.g., value-conscious families, urban professionals, convenience shoppers, bulk buyers).',
    `typical_sku_count_max` STRING COMMENT 'Maximum number of SKUs (Stock Keeping Units) typically carried by stores of this format. Defines the upper bound of product assortment size.',
    `typical_sku_count_min` STRING COMMENT 'Minimum number of SKUs (Stock Keeping Units) typically carried by stores of this format. Defines the lower bound of product assortment size.',
    `wms_integration_required_flag` BOOLEAN COMMENT 'Indicates whether stores of this format require integration with WMS (Warehouse Management System) for inventory management. True for fulfillment-heavy formats (dark stores, MFCs, SFS nodes); false for traditional retail-only formats.',
    CONSTRAINT pk_format PRIMARY KEY(`format_id`)
) COMMENT 'Reference classification of retail store formats used across the banner portfolio. Defines format codes and descriptions (hypermarket, superstore, department store, discount outlet, convenience, dark store, MFC, ship-from-store node), typical size bands (sq ft ranges), assortment depth/breadth norms, staffing model type, and fulfillment capability flags (BOPIS-capable, ROPIS-capable, SFS-capable, DSD-receiving). Used to drive operational standards, planogram templates, and omnichannel routing rules.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`store`.`pos_terminal` (
    `pos_terminal_id` BIGINT COMMENT 'Unique identifier for the POS terminal. Primary key. Inferred role: MASTER_RESOURCE.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.store_department. Business justification: POS terminals are assigned to specific departments within a store (e.g., electronics department checkout, grocery department checkout). The pos_terminal record currently denormalizes department_code a',
    `location_id` BIGINT COMMENT 'Foreign key reference to the store location where this POS terminal is deployed.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: POS terminals are capital equipment procured from hardware vendors. Tracking the vendor supports warranty claims, maintenance contract management, service call routing, and replacement parts procureme',
    `barcode_scanner_type` STRING COMMENT 'Type of barcode scanner peripheral attached to the POS terminal. Determines scanning workflow and throughput capabilities.. Valid values are `handheld|fixed_mount|presentation|none`',
    `cash_drawer_enabled` BOOLEAN COMMENT 'Indicates whether the terminal is connected to a cash drawer for handling cash transactions. False for self-checkout kiosks and mobile POS devices that do not accept cash.',
    `contactless_enabled` BOOLEAN COMMENT 'Indicates whether the terminal supports Near Field Communication (NFC) contactless payments (tap-to-pay, mobile wallets like Apple Pay, Google Pay).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this POS terminal record was first created in the master data system. Used for audit trail and data lineage tracking.',
    `customer_display_type` STRING COMMENT 'Type of customer-facing display device attached to the terminal. Shows transaction details, pricing, and promotional messages to the customer during checkout.. Valid values are `pole_display|integrated_screen|tablet|none`',
    `ebt_snap_enabled` BOOLEAN COMMENT 'Indicates whether the terminal is certified to accept Electronic Benefits Transfer (EBT) and Supplemental Nutrition Assistance Program (SNAP) payments. Required for grocery retailers serving SNAP recipients.',
    `emv_chip_enabled` BOOLEAN COMMENT 'Indicates whether the terminal supports EMV chip card transactions (contact chip reading). Required for PCI DSS compliance and fraud reduction.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether the terminal encrypts payment card data at the point of interaction (P2PE - Point-to-Point Encryption). Required for PCI DSS compliance and fraud prevention.',
    `hardware_model` STRING COMMENT 'Manufacturer model number or identifier for the POS terminal hardware (e.g., NCR RealPOS 82XRT, Toshiba TCx Sky, Zebra TC52). Critical for maintenance planning and compatibility management.',
    `hardware_serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the physical POS terminal device. Used for warranty tracking, asset management, and theft prevention.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `installation_date` DATE COMMENT 'Date when the POS terminal was first installed and commissioned at the store location. Used for asset lifecycle tracking and depreciation calculations.',
    `ip_address` STRING COMMENT 'Internet Protocol (IP) address assigned to the POS terminal on the store network. Used for network troubleshooting, security monitoring, and remote management.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$`',
    `lane_number` STRING COMMENT 'Physical lane or checkout position number within the store layout. Used for customer wayfinding and operational reporting. Null for mobile POS devices.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive maintenance or repair service performed on the terminal. Used for maintenance schedule compliance tracking.',
    `last_transaction_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent transaction processed by this terminal. Used for terminal utilization analysis and anomaly detection (e.g., identifying inactive terminals).',
    `mac_address` STRING COMMENT 'Media Access Control (MAC) address of the POS terminal network interface. Unique hardware identifier used for network access control and device authentication.. Valid values are `^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$`',
    `mobile_wallet_enabled` BOOLEAN COMMENT 'Indicates whether the terminal supports mobile wallet payment methods (Apple Pay, Google Pay, Samsung Pay, etc.). Typically requires NFC hardware.',
    `network_zone` STRING COMMENT 'Network security zone or segment where the POS terminal is deployed. Cardholder Data Environment (CDE) terminals are subject to stricter PCI DSS controls.. Valid values are `cardholder_data_environment|corporate_network|guest_network|isolated`',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date when the next preventive maintenance service is scheduled for the terminal. Used for proactive maintenance planning and resource allocation.',
    `operating_system` STRING COMMENT 'Operating system running on the POS terminal (e.g., Windows 10 IoT, Android 11, Linux Ubuntu 20.04). Impacts security posture and application compatibility.',
    `payment_processor` STRING COMMENT 'Name of the payment processing service or gateway integrated with this terminal (e.g., First Data, Worldpay, Square). Determines payment acceptance capabilities and settlement routing.',
    `pci_dss_certification_date` DATE COMMENT 'Date when the terminal last passed Payment Card Industry Data Security Standard (PCI DSS) compliance certification. Must be renewed annually to maintain payment acceptance capabilities.',
    `pci_dss_certification_expiry_date` DATE COMMENT 'Date when the current PCI DSS certification expires. Terminals must be recertified before this date to continue processing payment card transactions.',
    `pin_debit_enabled` BOOLEAN COMMENT 'Indicates whether the terminal supports PIN-based debit card transactions. Requires secure PIN pad hardware.',
    `qr_code_payment_enabled` BOOLEAN COMMENT 'Indicates whether the terminal supports QR code-based payment methods (e.g., Alipay, WeChat Pay, retailer-specific QR payment apps).',
    `receipt_printer_model` STRING COMMENT 'Model identifier for the receipt printer peripheral attached to the POS terminal. Used for consumables ordering and maintenance scheduling.',
    `remote_management_enabled` BOOLEAN COMMENT 'Indicates whether the terminal can be remotely monitored, configured, and updated from a central management system. Enables efficient fleet management and rapid issue resolution.',
    `scale_integrated` BOOLEAN COMMENT 'Indicates whether the terminal has an integrated scale for weighing produce, bulk items, or other variable-weight merchandise. Common in grocery checkout lanes.',
    `signature_capture_enabled` BOOLEAN COMMENT 'Indicates whether the terminal supports electronic signature capture for credit card transactions and delivery confirmations.',
    `software_version` STRING COMMENT 'Version number of the POS application software currently installed on the terminal. Critical for security patch management and feature compatibility.. Valid values are `^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$`',
    `terminal_name` STRING COMMENT 'Human-readable name or label for the POS terminal, often indicating its location or purpose within the store (e.g., Lane 5, Customer Service Desk, Pharmacy Register).',
    `terminal_number` STRING COMMENT 'Business identifier for the POS terminal, typically displayed on the terminal and used in operational communications. Unique within a store location.. Valid values are `^[A-Z0-9]{4,20}$`',
    `terminal_status` STRING COMMENT 'Current operational status of the POS terminal. Determines whether the terminal is available for transaction processing. Active terminals are in production use; offline terminals are temporarily unavailable; maintenance terminals are undergoing service; decommissioned terminals are permanently retired.. Valid values are `active|offline|maintenance|decommissioned|pending_activation|suspended`',
    `terminal_type` STRING COMMENT 'Classification of the POS terminal based on its operational function and staffing model. Determines transaction workflows and customer interaction patterns.. Valid values are `staffed_checkout_lane|self_checkout_kiosk|mobile_pos|customer_service_desk|pharmacy_register|express_lane`',
    `tokenization_enabled` BOOLEAN COMMENT 'Indicates whether the terminal supports payment tokenization, replacing sensitive card data with non-sensitive tokens for storage and transmission. Reduces PCI DSS scope.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this POS terminal record was last modified in the master data system. Used for change tracking and data synchronization.',
    CONSTRAINT pk_pos_terminal PRIMARY KEY(`pos_terminal_id`)
) COMMENT 'Master record for every Point-of-Sale (POS) terminal deployed within a store location. Captures terminal ID, lane number, terminal type (staffed checkout lane, self-checkout kiosk, mobile POS, customer service desk, pharmacy register), hardware model, software version, payment acceptance capabilities (EMV chip, NFC/contactless, PIN debit, EBT/SNAP, mobile wallet), peripheral devices (scanner, scale, receipt printer), installation date, last maintenance date, next scheduled maintenance, terminal status (active, offline, maintenance, decommissioned), PCI DSS compliance certification date, and assigned department or zone within the store. Critical for POS transaction reconciliation, shrinkage investigation, lane productivity analysis, and omnichannel payment compliance.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`store`.`fixture` (
    `fixture_id` BIGINT COMMENT 'Unique identifier for the store fixture. Primary key.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.store_department. Business justification: Fixtures are physically located within store departments. The fixture record currently denormalizes department_code as a STRING. Adding FK to store_department allows joining to get department_name, de',
    `location_id` BIGINT COMMENT 'Identifier of the retail store location where this fixture is currently assigned. Links to the store master record.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom the fixture was purchased. Links to the supplier master record for procurement history and vendor performance tracking.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether the fixture meets ADA accessibility requirements for height, reach range, and clearance. True indicates compliant, false indicates non-compliant or exempted.',
    `adjustable_shelves_flag` BOOLEAN COMMENT 'Indicates whether the fixture has adjustable shelf heights. True enables flexible merchandising for varying product sizes, false indicates fixed shelf positions.',
    `aisle_number` STRING COMMENT 'Aisle identifier where the fixture is positioned within the store. Used for store navigation, planogram assignment, and customer wayfinding.',
    `bay_position` STRING COMMENT 'Specific bay or section position within the aisle (e.g., Bay 1, Bay 2). Provides granular location tracking for planogram compliance and inventory audits.',
    `fixture_category` STRING COMMENT 'Categorization of the fixture based on its intended duration and purpose. Permanent fixtures are long-term store infrastructure, seasonal fixtures support recurring seasonal merchandising, promotional fixtures are used for short-term campaigns, and temporary fixtures are ad-hoc displays.. Valid values are `permanent|seasonal|promotional|temporary`',
    `fixture_code` STRING COMMENT 'Business identifier code for the fixture, used for asset tracking and inventory management. Typically alphanumeric code assigned by merchandising or facilities team.. Valid values are `^[A-Z0-9]{8,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixture record was first created in the system. Used for data lineage and audit trail.',
    `depth_inches` DECIMAL(18,2) COMMENT 'Depth of the fixture measured in inches. Important for aisle width planning, product capacity calculation, and customer navigation.',
    `digital_display_flag` BOOLEAN COMMENT 'Indicates whether the fixture includes digital signage or electronic shelf labels (ESL) for dynamic pricing and promotions. True indicates digital capability, false indicates traditional static signage.',
    `finish_color` STRING COMMENT 'Color or finish of the fixture exterior (e.g., white, black, chrome, wood grain). Used for visual merchandising consistency and brand alignment across store fleet.',
    `fixture_status` STRING COMMENT 'Current lifecycle status of the fixture. Active indicates in-use and operational, inactive indicates temporarily not in use, maintenance indicates undergoing repair or refurbishment, retired indicates permanently removed from service, damaged indicates requiring repair, and pending installation indicates purchased but not yet deployed.. Valid values are `active|inactive|maintenance|retired|damaged|pending_installation`',
    `fixture_type` STRING COMMENT 'Classification of the fixture by its primary merchandising function. Gondola refers to standard shelving units, endcap to end-of-aisle displays, cooler/freezer to refrigerated cases, pegboard to hanging merchandise panels, display table to promotional tables, checkout lane to POS area fixtures, shelf unit to standalone shelving, and rack to hanging garment fixtures. [ENUM-REF-CANDIDATE: gondola|endcap|cooler|freezer|pegboard|display_table|checkout_lane|shelf_unit|rack — 9 candidates stripped; promote to reference product]',
    `height_inches` DECIMAL(18,2) COMMENT 'Height of the fixture measured in inches. Critical for vertical space utilization, sight line planning, and compliance with accessibility standards.',
    `installation_date` DATE COMMENT 'Date the fixture was installed in its current store location. Used for age tracking, depreciation calculation, and maintenance scheduling.',
    `last_refurbishment_date` DATE COMMENT 'Date of the most recent refurbishment, repair, or significant maintenance performed on the fixture. Null if never refurbished since installation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixture record was most recently modified. Used for change tracking and data quality monitoring.',
    `lighting_integrated_flag` BOOLEAN COMMENT 'Indicates whether the fixture has built-in lighting to highlight merchandise. True indicates integrated lighting system, false indicates no built-in lighting.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactured the fixture. Used for warranty tracking, parts sourcing, and vendor performance analysis.',
    `material_composition` STRING COMMENT 'Primary materials used in fixture construction (e.g., steel, wood, laminate, glass, acrylic). Impacts durability, maintenance requirements, and aesthetic alignment with store design.',
    `mobility_type` STRING COMMENT 'Indicates whether the fixture is permanently installed (fixed), easily movable (mobile with casters), or requires tools to relocate (semi-mobile). Impacts flexibility for store resets and seasonal merchandising changes.. Valid values are `fixed|mobile|semi_mobile`',
    `model_number` STRING COMMENT 'Manufacturers model or part number for the fixture. Critical for ordering replacement parts, warranty claims, and standardization across stores.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next preventive maintenance or inspection. Used for maintenance scheduling and compliance with safety standards.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special handling instructions, maintenance history notes, or other relevant information about the fixture.',
    `power_required_flag` BOOLEAN COMMENT 'Indicates whether the fixture requires electrical power for operation (e.g., refrigeration, lighting, digital displays). True requires power connection, false indicates passive fixture.',
    `purchase_order_number` STRING COMMENT 'Purchase order number under which the fixture was procured. Used for procurement audit trail and invoice reconciliation.',
    `refrigeration_type` STRING COMMENT 'Temperature control classification for the fixture. Ambient indicates no refrigeration, chilled indicates 32-40°F range for dairy and produce, frozen indicates below 0°F for frozen foods, multi-temp indicates multiple temperature zones, and none indicates non-refrigerated fixtures.. Valid values are `ambient|chilled|frozen|multi_temp|none`',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether the fixture is equipped with RFID readers for automated inventory tracking and shrinkage prevention. True indicates RFID capability, false indicates no RFID integration.',
    `security_features` STRING COMMENT 'Description of anti-theft or security features integrated into the fixture (e.g., locking doors, security hooks, EAS tag compatibility, camera integration). Used for shrinkage prevention and loss prevention planning.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the individual fixture unit. Used for warranty claims, theft recovery, and precise asset tracking.',
    `shelf_count` STRING COMMENT 'Number of shelves or display levels on the fixture. Used for capacity planning and planogram assignment. Null for fixtures without shelves (e.g., pegboards, hanging racks).',
    `weight_capacity_lbs` DECIMAL(18,2) COMMENT 'Maximum weight load the fixture can safely support, measured in pounds. Critical for safety compliance and preventing structural failure when merchandising heavy products.',
    `width_inches` DECIMAL(18,2) COMMENT 'Width of the fixture measured in inches. Used for space planning, planogram design, and store layout optimization.',
    CONSTRAINT pk_fixture PRIMARY KEY(`fixture_id`)
) COMMENT 'Master record for physical store fixtures including gondolas (shelving units), endcaps (end-of-aisle displays), cooler/freezer cases, pegboard panels, display tables, and checkout lane fixtures. Captures fixture ID, fixture type, manufacturer, model number, dimensions (width, height, depth), number of shelves, adjustable shelf flag, refrigeration type (ambient, chilled, frozen), installation date, last refurbishment date, assigned store location, assigned department/zone, and current planogram assignment. Supports visual merchandising planning, maintenance scheduling, and capital asset tracking.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`store`.`department` (
    `department_id` BIGINT COMMENT 'Unique identifier for the store department. Primary key for the store department entity.',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Store departments map to merchandise categories (item hierarchy). Department managers are responsible for specific categories. Essential for departmental P&L reporting by category and category manager',
    `location_id` BIGINT COMMENT 'Reference to the parent store location where this department is physically located.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Retail departments (e.g., grocery, electronics, apparel) are assigned department-level price lists that govern valid selling prices for items in that department. This supports department-level price l',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Category management in retail assigns a primary vendor (category captain) to each department. This drives assortment decisions, planogram ownership, and vendor collaboration. A retail category manager',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the department record was first created in the system. Used for audit trail and data lineage.',
    `department_status` STRING COMMENT 'Current operational status of the department. Active departments are open for business; inactive departments are closed or not yet operational.. Valid values are `active|inactive|under_construction|seasonal_closed|remodeling|pending_closure`',
    `department_type` STRING COMMENT 'Classification of the department by merchandise category. Determines merchandising strategy, planogram standards, and operational procedures. [ENUM-REF-CANDIDATE: grocery|apparel|electronics|household|pharmacy|bakery|deli|produce|frozen|health_beauty|seasonal|home_garden|automotive|sporting_goods|toys|jewelry|furniture — 17 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when the department ceased operations or when the current configuration ended. Null for currently active departments.',
    `effective_start_date` DATE COMMENT 'Date when the department became operational or when the current configuration became effective. Used for historical tracking and comp sales analysis.',
    `endcap_count` STRING COMMENT 'Number of endcap display positions (end-of-aisle promotional displays) available in the department. Prime real estate for high-margin or promotional items.',
    `fixture_count` STRING COMMENT 'Total number of fixtures (gondolas, endcaps, shelving units, display cases) assigned to the department. Used for planogram capacity planning.',
    `floor_number` STRING COMMENT 'Floor level where the department is located within the store. Ground floor is typically 1, basement levels may be 0 or negative.',
    `gondola_count` STRING COMMENT 'Number of gondola shelving units (freestanding double-sided shelving) in the department. Key metric for planogram assignment and merchandising capacity.',
    `gross_margin_target_percent` DECIMAL(18,2) COMMENT 'Target gross margin percentage for the department. Used to measure profitability and pricing effectiveness.',
    `labor_budget_monthly` DECIMAL(18,2) COMMENT 'Monthly labor budget allocation for the department in local currency. Used for workforce scheduling and labor-to-sales ratio management.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified the department record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the department record was last updated. Used for audit trail and change tracking.',
    `license_expiry_date` DATE COMMENT 'Expiration date of the regulatory license or permit for licensed departments. Null for non-licensed departments.',
    `license_number` STRING COMMENT 'Regulatory license or permit number for licensed departments (e.g., pharmacy license, alcohol retail license). Null for non-licensed departments.',
    `licensed_department_flag` BOOLEAN COMMENT 'Indicates whether the department requires special licensing or regulatory compliance (e.g., pharmacy, alcohol, tobacco, firearms). True if licensing is required.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to the department. Used for operational context and exception handling.',
    `omnichannel_fulfillment_enabled_flag` BOOLEAN COMMENT 'Indicates whether the department supports omnichannel fulfillment operations (BOPIS, ROPIS, ship-from-store). True if omnichannel fulfillment is enabled.',
    `planogram_count` STRING COMMENT 'Number of active planograms (shelf layout diagrams) assigned to the department. Each planogram defines product placement and facings for a fixture or section.',
    `pos_terminal_count` STRING COMMENT 'Number of POS terminals or checkout lanes assigned to or located within the department. Relevant for departments with dedicated checkout (e.g., pharmacy, jewelry).',
    `sales_target_monthly` DECIMAL(18,2) COMMENT 'Monthly sales target or quota for the department in local currency. Used for performance management and comp sales (SSS) analysis.',
    `selling_area_sq_ft` DECIMAL(18,2) COMMENT 'Total selling floor space allocated to the department measured in square feet. Used to calculate sales per square foot and space productivity metrics.',
    `shrinkage_rate_percent` DECIMAL(18,2) COMMENT 'Historical shrinkage rate (inventory loss due to theft, damage, spoilage) for the department expressed as a percentage of sales. Used for loss prevention planning.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the department requires temperature-controlled environment (e.g., frozen, refrigerated, deli, bakery). True if climate control is required.',
    `temperature_range_max_f` DECIMAL(18,2) COMMENT 'Maximum temperature threshold in Fahrenheit for temperature-controlled departments. Null for non-temperature-controlled departments.',
    `temperature_range_min_f` DECIMAL(18,2) COMMENT 'Minimum temperature threshold in Fahrenheit for temperature-controlled departments. Null for non-temperature-controlled departments.',
    `visual_merchandising_standard` STRING COMMENT 'Code or reference to the visual merchandising standard or guideline applied to the department. Defines display aesthetics, signage, and presentation rules.',
    `zone_code` STRING COMMENT 'Alphanumeric code identifying the physical zone or area within the store floor plan. Used for wayfinding, inventory location, and planogram assignment.. Valid values are `^[A-Z0-9]{1,5}$`',
    CONSTRAINT pk_department PRIMARY KEY(`department_id`)
) COMMENT 'Master record for departments or selling zones within a store location — the primary sub-location operational unit in retail. Captures department ID, department name, department code, parent store location, floor number, zone coordinates, department type (grocery, apparel, electronics, household, pharmacy, bakery, deli, produce, frozen, health & beauty, seasonal, etc.), selling area (sq ft), number of fixtures, department manager assignment reference, labor budget allocation, and active status. Departments are the fundamental unit for planogram assignment, inventory allocation, staffing schedules, shrinkage attribution, and P&L sub-reporting within a store. Most operational KPIs (sales per sq ft, shrink rate, labor-to-sales ratio) are measured at department level.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`store`.`cluster` (
    `cluster_id` BIGINT COMMENT 'Unique identifier for the store cluster. Primary key.',
    `parent_cluster_id` BIGINT COMMENT 'Reference to a parent cluster if this cluster is part of a hierarchical clustering structure (e.g., sub-clusters within a regional cluster). Null for top-level clusters.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Retail clusters are assigned price zones to apply uniform pricing strategy across member stores. Cluster-based price zone assignment drives zone-level pricing execution, promotional intensity calibrat',
    `fulfillment_node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_node. Business justification: Store clusters are assigned a primary fulfillment node (e.g., regional dark store or DC-as-node) for cluster-level fulfillment capacity planning, SLA target-setting, and promotional surge routing. Ret',
    `promo_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_calendar. Business justification: Store clusters follow specific promotional calendars based on their shared characteristics (urbanization, format mix, customer segment). Cluster-to-calendar assignment drives promotional cadence plann',
    `region_id` BIGINT COMMENT 'Foreign key linking to store.region. Business justification: A store cluster is a logical grouping of locations that typically aligns to a geographic region for assortment, pricing, and promotional strategy. The cluster table has geographic_scope (string) and c',
    `allows_overlap` BOOLEAN COMMENT 'Indicates whether a store can belong to multiple clusters of this type simultaneously. True for concurrent clustering schemes (e.g., a store can be in both an assortment cluster and a pricing zone cluster); false for mutually exclusive schemes.',
    `assortment_depth_strategy` STRING COMMENT 'Planned depth of product assortment for this cluster. Deep assortment offers extensive variety within categories; moderate offers balanced selection; shallow offers limited SKU count; curated offers highly selective premium assortment. Drives OTB planning and space allocation.. Valid values are `deep|moderate|shallow|curated`',
    `average_annual_sales_usd` DECIMAL(18,2) COMMENT 'Average annual sales volume in USD for stores in this cluster. Used for performance tier clustering and benchmarking. Business-confidential financial metric.',
    `average_store_size_sqft` DECIMAL(18,2) COMMENT 'Average selling floor area in square feet of stores in this cluster. Used for format-based clustering and space productivity benchmarking.',
    `climate_zone` STRING COMMENT 'Predominant climate classification for stores in this cluster. Used for climate-based clustering to drive seasonal assortment and inventory planning (e.g., winter apparel depth, cooling appliances).. Valid values are `tropical|arid|temperate|continental|polar`',
    `cluster_status` STRING COMMENT 'Current lifecycle status of the cluster. Active clusters are in operational use; inactive clusters are temporarily disabled; pending clusters are awaiting approval; archived clusters are historical; under_review clusters are being evaluated for changes.. Valid values are `active|inactive|pending|archived|under_review`',
    `cluster_type` STRING COMMENT 'Classification of the clustering scheme. Assortment clusters drive localized product mix; pricing zone clusters enable zone-based pricing strategies; demographic clusters group by customer profile; performance tier clusters segment by sales volume or profitability; climate clusters address seasonal/weather-driven needs; geographic clusters group by region; format clusters group by store format (hypermarket, discount, dark store); omnichannel clusters optimize fulfillment network. [ENUM-REF-CANDIDATE: assortment|pricing_zone|demographic|performance_tier|climate|geographic|format|omnichannel — 8 candidates stripped; promote to reference product]',
    `clustering_criteria` STRING COMMENT 'Business rules or data attributes used to assign stores to this cluster (e.g., sales volume > $10M, urban location, customer income > $75K, climate zone = temperate). Supports transparency and auditability of cluster logic.',
    `clustering_methodology` STRING COMMENT 'Method used to define the cluster. Algorithmic indicates data-driven segmentation (e.g., k-means, hierarchical clustering); manual indicates business-defined groupings; hybrid combines both; machine_learning indicates advanced ML models; rule_based indicates business rules engine.. Valid values are `algorithmic|manual|hybrid|machine_learning|rule_based`',
    `cluster_code` STRING COMMENT 'Business-friendly alphanumeric code for the store cluster, used in reporting and operational systems. Typically follows a pattern like REGION-TYPE-SEQ (e.g., NE-ASSORT-01, SW-PRICE-03).. Valid values are `^[A-Z0-9]{3,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cluster record was first created in the system. Supports audit trail and data lineage.',
    `cluster_description` STRING COMMENT 'Detailed business description of the cluster purpose, characteristics, and intended use. Explains the rationale for grouping these stores together.',
    `effective_end_date` DATE COMMENT 'Date when this cluster definition ceases to be effective. Null indicates the cluster is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this cluster definition becomes effective for operational use. Supports temporal validity and historical analysis of cluster changes.',
    `external_cluster_code` STRING COMMENT 'Cluster identifier from the source system of record. Used for cross-system reconciliation and data lineage tracking.',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the cluster. National clusters span the entire country; regional clusters cover multi-state regions; state clusters are state-specific; metro clusters cover metropolitan areas; local clusters are city or neighborhood-level.. Valid values are `national|regional|state|metro|local`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cluster record was last updated. Supports change tracking and audit trail.',
    `last_review_date` DATE COMMENT 'Date when this cluster definition was last reviewed and validated by the cluster owner. Used to track cluster maintenance and ensure clustering logic remains current.',
    `cluster_level` STRING COMMENT 'Depth level in the cluster hierarchy. Level 1 is top-level (e.g., national or regional); higher numbers indicate more granular sub-clusters. Supports hierarchical rollup and drill-down analysis.',
    `member_store_count` STRING COMMENT 'Total number of store locations currently assigned to this cluster. Updated as stores join or leave the cluster.',
    `cluster_name` STRING COMMENT 'Human-readable name of the store cluster, used for display and business communication (e.g., Northeast Urban High-Income, Southwest Discount Tier 1).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next cluster review. Ensures periodic validation of cluster definitions and membership. Typically quarterly or semi-annually.',
    `owner_name` STRING COMMENT 'Name of the individual or role responsible for this cluster definition (e.g., Regional Merchandising Manager, Pricing Director).',
    `owner_team` STRING COMMENT 'Business function responsible for defining and maintaining this cluster. Merchandising owns assortment clusters; pricing owns pricing zone clusters; operations owns performance tier clusters; supply chain owns fulfillment clusters; marketing owns demographic clusters; analytics owns data-driven experimental clusters.. Valid values are `merchandising|pricing|operations|supply_chain|marketing|analytics`',
    `pricing_strategy` STRING COMMENT 'Pricing approach for this cluster. EDLP (Everyday Low Price) maintains consistent low prices; hi-lo uses frequent promotions; premium targets high-margin customers; competitive matches market prices; value emphasizes affordability. Drives zone pricing rules.. Valid values are `EDLP|hi_lo|premium|competitive|value`',
    `primary_business_purpose` STRING COMMENT 'Primary operational use case for this cluster (e.g., localized assortment planning, zone pricing strategy, promotional targeting, operational benchmarking, fulfillment network optimization).',
    `promotional_intensity` STRING COMMENT 'Frequency and depth of promotional activity targeted at this cluster. High intensity clusters receive frequent deep discounts; low intensity clusters have minimal promotions; none indicates EDLP strategy with no promotions.. Valid values are `high|medium|low|none`',
    `replenishment_frequency` STRING COMMENT 'Standard inventory replenishment cadence for stores in this cluster. Drives supply chain planning and DC allocation. High-volume urban stores typically receive daily replenishment; lower-volume rural stores may be weekly or bi-weekly.. Valid values are `daily|twice_weekly|weekly|bi_weekly|monthly`',
    `store_format_mix` STRING COMMENT 'Comma-separated list of store formats included in this cluster (e.g., hypermarket, discount, dark_store, MFC). Used for format-based clustering and omnichannel fulfillment optimization.',
    `supports_omnichannel` BOOLEAN COMMENT 'Indicates whether stores in this cluster are enabled for omnichannel fulfillment capabilities (BOPIS, ROPIS, ship-from-store, curbside pickup). True if cluster is designed for omnichannel operations.',
    `urbanization_level` STRING COMMENT 'Population density classification for stores in this cluster. Urban stores serve high-density city centers; suburban stores serve residential areas; rural stores serve low-density regions; exurban stores serve outer suburban fringe areas.. Valid values are `urban|suburban|rural|exurban`',
    CONSTRAINT pk_cluster PRIMARY KEY(`cluster_id`)
) COMMENT 'Master record defining store clusters — logical groupings of store locations used for localized assortment planning, zone pricing, promotional targeting, and operational benchmarking. Captures cluster ID, name, type (assortment, pricing zone, demographic, performance tier, climate), clustering methodology (algorithmic, manual override, hybrid), effective date range, member store count, and cluster owner (merchandising, pricing, or operations team). Also owns store-to-cluster membership associations including effective dates and override reasons, supporting many-to-many store-cluster relationships across concurrent clustering schemes.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` (
    `sfs_fulfillment_node_id` BIGINT COMMENT 'Unique identifier for the ship-from-store fulfillment node. Primary key for this entity.',
    `fulfillment_node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_node. Business justification: fulfillment.sfs_fulfillment_node defines a stores ship-from-store capability configuration; fulfillment.fulfillment_node is the operational execution record. Linking them enables SFS order routing, capacit',
    `location_id` BIGINT COMMENT 'Reference to the physical store location that serves as this fulfillment node. Links to the store master record.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Ship-from-store fulfillment nodes serve specific geographic markets and must operate under a price zone for omnichannel/ecommerce pricing. price_zone.fulfillment_node_count confirms this relationship ',
    `activation_date` DATE COMMENT 'Date when this fulfillment node was first activated and began accepting orders for fulfillment.',
    `average_pack_time_minutes` DECIMAL(18,2) COMMENT 'Average time in minutes required to pack a standard order at this fulfillment node. Used for capacity planning and throughput estimation.',
    `average_pick_time_minutes` DECIMAL(18,2) COMMENT 'Average time in minutes required to pick a standard order at this fulfillment node. Used for capacity planning and Service Level Agreement (SLA) estimation.',
    `carrier_account_number` STRING COMMENT 'Account number or identifier used for billing and tracking with the primary carrier. Business-confidential information used for shipment processing.',
    `contact_email` STRING COMMENT 'Email address of the primary operational contact for this fulfillment node. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary operational contact or fulfillment manager for this node. Business-confidential organizational contact information.',
    `contact_phone` STRING COMMENT 'Phone number of the primary operational contact for this fulfillment node. Organizational contact data classified as confidential.',
    `cost_per_order` DECIMAL(18,2) COMMENT 'Average operational cost in local currency to fulfill one order from this node, including labor, packaging, and overhead. Used for profitability analysis and routing optimization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment node record was first created in the system. Audit trail for data lineage and compliance.',
    `daily_capacity_orders` STRING COMMENT 'Maximum number of orders this fulfillment node can process per day, based on staffing, space, and operational constraints. Used by OMS for capacity-based order routing.',
    `daily_capacity_units` STRING COMMENT 'Maximum number of individual units (SKUs) this fulfillment node can pick, pack, and ship per day. Complements order capacity for more granular planning.',
    `deactivation_date` DATE COMMENT 'Date when this fulfillment node was deactivated or decommissioned. Null for currently active nodes.',
    `inventory_sync_frequency_minutes` STRING COMMENT 'Frequency in minutes at which inventory positions at this fulfillment node are synchronized with the central inventory system. Lower values enable more accurate real-time inventory visibility.',
    `next_day_cutoff_time` TIMESTAMP COMMENT 'Local time cutoff (HH:MM format) by which orders must be placed to qualify for next-day delivery from this node. Null if next-day delivery is not supported.',
    `node_code` STRING COMMENT 'Externally-known unique business identifier for this fulfillment node, used in Order Management System (OMS) and Warehouse Management System (WMS) integrations.. Valid values are `^[A-Z0-9]{6,12}$`',
    `node_name` STRING COMMENT 'Human-readable name of the fulfillment node, typically matching the store name or including a fulfillment designation (e.g., Downtown Store - SFS Node).',
    `node_type` STRING COMMENT 'Classification of the fulfillment node: ship_from_store (SFS - regular store with fulfillment capability), dark_store (fulfillment-only location closed to customers), micro_fulfillment_center (MFC - automated compact fulfillment facility), or hybrid (combination model).. Valid values are `ship_from_store|dark_store|micro_fulfillment_center|hybrid`',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or configuration details specific to this fulfillment node. Used for documentation and knowledge transfer.',
    `oms_integration_enabled` BOOLEAN COMMENT 'Indicates whether this fulfillment node is integrated with the Order Management System (OMS) for automated order routing and status updates. True if OMS integration is active; false otherwise.',
    `operating_hours` STRING COMMENT 'Standard operating hours for fulfillment operations at this node, typically in format Mon-Fri: 08:00-20:00, Sat-Sun: 09:00-18:00. Used for capacity planning and order routing.',
    `operational_status` STRING COMMENT 'Current operational state of the fulfillment node. Active nodes accept orders; inactive nodes are temporarily offline; suspended nodes are under review; testing nodes are in pilot phase; decommissioned nodes are permanently closed.. Valid values are `active|inactive|suspended|testing|decommissioned`',
    `picking_zone_count` STRING COMMENT 'Number of active picking zones configured within this fulfillment node. Zones organize inventory by category or location to optimize picking efficiency.',
    `picking_zone_identifiers` STRING COMMENT 'Comma-separated list of picking zone codes or identifiers active in this fulfillment node (e.g., ZONE-A,ZONE-B,ZONE-C). Used for WMS integration and picker assignment.',
    `primary_carrier_code` STRING COMMENT 'Code identifying the primary Third-Party Logistics (3PL) carrier or delivery service provider assigned to this fulfillment node (e.g., UPS, FEDEX, USPS, DHL).',
    `priority_rank` STRING COMMENT 'Numeric priority rank for this fulfillment node in the order routing algorithm. Lower numbers indicate higher priority. Used when multiple nodes can fulfill an order.',
    `same_day_cutoff_time` TIMESTAMP COMMENT 'Local time cutoff (HH:MM format) by which orders must be placed to qualify for same-day delivery from this node. Null if same-day delivery is not supported.',
    `service_postal_codes` STRING COMMENT 'Comma-separated list of postal codes or postal code prefixes this fulfillment node serves. Used for zone-based order routing when radius-based routing is insufficient.',
    `service_radius_km` DECIMAL(18,2) COMMENT 'Geographic service radius in kilometers from this fulfillment node. Orders within this radius are eligible for fulfillment from this node. Used by OMS for proximity-based routing.',
    `supports_bopis` BOOLEAN COMMENT 'Indicates whether this fulfillment node supports Buy Online Pick Up In Store (BOPIS) service. True if BOPIS is available; false otherwise.',
    `supports_curbside_pickup` BOOLEAN COMMENT 'Indicates whether this fulfillment node offers curbside pickup service where customers can collect orders without entering the store. True if curbside pickup is available; false otherwise.',
    `supports_next_day_delivery` BOOLEAN COMMENT 'Indicates whether this fulfillment node offers next-day delivery service. True if next-day delivery is available; false otherwise.',
    `supports_same_day_delivery` BOOLEAN COMMENT 'Indicates whether this fulfillment node offers same-day delivery service. True if same-day delivery is available; false otherwise.',
    `timezone` STRING COMMENT 'IANA timezone identifier for this fulfillment node (e.g., America/New_York, Europe/London). Used to interpret cutoff times and operating hours in local time.',
    `updated_by` STRING COMMENT 'User identifier or system account that last modified this fulfillment node record. Audit trail for accountability and compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment node record was last modified. Audit trail for change tracking and data governance.',
    `wms_integration_enabled` BOOLEAN COMMENT 'Indicates whether this fulfillment node is integrated with the Warehouse Management System (WMS) for automated pick/pack/ship workflows. True if WMS integration is active; false if manual processes are used.',
    CONSTRAINT pk_sfs_fulfillment_node PRIMARY KEY(`sfs_fulfillment_node_id`)
) COMMENT 'Master record designating a store location as a Ship-from-Store (SFS), dark store, or MFC fulfillment node within the omnichannel network. Captures node ID, store location reference, node type, daily fulfillment capacity (orders/day), active picking zones within the store, assigned carrier accounts, same-day/next-day cutoff times, geographic service radius, supported delivery SLAs, and node activation status. This is the SSOT for store-as-fulfillment-node configuration consumed by OMS and fulfillment domains. The fulfillment domain owns execution (pick/pack/ship); this product owns the node capability and capacity definition.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`store`.`cluster_membership` (
    `cluster_membership_id` BIGINT COMMENT 'Unique identifier for this store cluster membership record. Primary key for the association.',
    `cluster_id` BIGINT COMMENT 'Foreign key linking to the store cluster. Identifies which logical cluster this membership record associates with the store location.',
    `location_id` BIGINT COMMENT 'Foreign key linking to the store location. Identifies which physical retail location is a member of the cluster.',
    `assigned_by` STRING COMMENT 'Name or identifier of the user, system, or process that created this cluster membership assignment. Used for audit trail and accountability.',
    `assignment_effective_date` DATE COMMENT 'Date when this cluster assignment becomes operationally effective for planning and execution purposes. May differ from membership_start_date to support advance planning and staged rollouts.',
    `assignment_method` STRING COMMENT 'How the store was assigned to this cluster (manual, algorithmic, rule_based).',
    `assignment_notes` STRING COMMENT 'Free-text notes providing additional context about this cluster membership assignment. Used to document special circumstances, exceptions, or business rationale.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this cluster membership. Active = currently in operational use; Pending = scheduled for future activation; Suspended = temporarily inactive; Expired = past membership; Overridden = superseded by manual reassignment.',
    `cluster_assignment_reason` STRING COMMENT 'Business justification or methodology for assigning this store to this cluster. Examples: algorithmic segmentation based on sales patterns, manual override by merchandising team, geographic proximity, demographic alignment, performance tier classification.',
    `confidence_score` STRING COMMENT 'Confidence score of algorithmic cluster assignment.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_end_date` DATE COMMENT 'End date of cluster membership.',
    `effective_start_date` DATE COMMENT 'Start date of cluster membership.',
    `is_primary_cluster` BOOLEAN COMMENT 'Indicates whether this cluster is the primary cluster assignment for this store location within this cluster type. Used when a store belongs to multiple clusters of the same type and one must be designated as primary for operational purposes.',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified this cluster membership record. Used for audit trail and accountability.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this cluster membership record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Record last modification timestamp.',
    `membership_end_date` DATE COMMENT 'Date when this store location ceased to be a member of this cluster. Null indicates current active membership. Used for historical analysis of cluster composition changes.',
    `membership_start_date` DATE COMMENT 'Date when this store location became a member of this cluster. Supports temporal tracking of cluster membership changes over time.',
    `membership_status` STRING COMMENT 'Status of membership (active, inactive, pending).',
    `override_flag` BOOLEAN COMMENT 'Whether this assignment was manually overridden.',
    `override_reason` STRING COMMENT 'Reason for manual override of cluster assignment.',
    `primary_flag` BOOLEAN COMMENT 'Whether this is the primary cluster for the location.',
    `weight` STRING COMMENT 'Weight or degree of membership for fuzzy clustering.',
    CONSTRAINT pk_cluster_membership PRIMARY KEY(`cluster_membership_id`)
) COMMENT 'This association product represents the membership relationship between store clusters and store locations. It captures the assignment of individual stores to logical clusters used for localized assortment planning, zone pricing, promotional targeting, and operational benchmarking. Each record links one store cluster to one store location with effective dates, primary cluster designation, assignment reason, and status that exist only in the context of this relationship. Supports concurrent membership in multiple overlapping clustering schemes (assortment clusters, pricing zones, demographic clusters, performance tiers, climate zones).. Existence Justification: Store cluster membership is a genuine operational M:N relationship in retail. Retailers actively manage multiple concurrent clustering schemes (assortment clusters, pricing zones, demographic segments, performance tiers, climate zones) where a single store participates in multiple clusters simultaneously, and each cluster contains multiple stores. The relationship has its own lifecycle (effective dates), business rules (primary cluster designation), and operational significance (drives localized merchandising, pricing, and planning decisions).';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`store`.`sales_territory` (
    `sales_territory_id` BIGINT COMMENT 'Primary key for sales_territory',
    `parent_sales_territory_id` BIGINT COMMENT 'Self-referencing FK on sales_territory (parent_sales_territory_id)',
    `parent_territory_id` BIGINT COMMENT 'Reference to the parent sales territory in a hierarchical territory structure. Null for top-level territories.',
    `region_id` BIGINT COMMENT 'Reference to the geographic region this territory belongs to, for regional sales reporting and management.',
    `annual_revenue_target` DECIMAL(18,2) COMMENT 'Target annual revenue goal for this sales territory, used for performance measurement and incentive compensation.',
    `boundary_definition` STRING COMMENT 'Textual or structured definition of territory boundaries (e.g., list of counties, postal codes, geographic coordinates, or natural boundaries).',
    `competition_level` STRING COMMENT 'Assessment of competitive intensity within this sales territory: low (few competitors), moderate (balanced), high (many competitors), very_high (saturated market), monopoly (single dominant player).',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the primary country for this sales territory (e.g., USA, CAN, GBR, DEU).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales territory record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for financial targets and reporting in this territory (e.g., USD, CAD, EUR, GBP).',
    `customer_count` STRING COMMENT 'Number of active customers assigned to this sales territory. Used for territory balancing and performance benchmarking.',
    `effective_end_date` DATE COMMENT 'Date when this sales territory ceases or ceased to be active. Null for open-ended territories.',
    `effective_start_date` DATE COMMENT 'Date when this sales territory becomes or became active and operational for sales assignments and reporting.',
    `household_count` BIGINT COMMENT 'Total number of households within this sales territory. Used for consumer market analysis and targeting.',
    `language_code` STRING COMMENT 'Primary language code for customer communication and marketing in this territory (e.g., en, es, fr, de).',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this sales territory record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales territory record was last updated or modified.',
    `market_potential_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) representing the market opportunity and growth potential of this territory, based on demographics, competition, and economic indicators.',
    `median_household_income` DECIMAL(18,2) COMMENT 'Median annual household income within this territory, used for demographic profiling and product assortment planning.',
    `notes` STRING COMMENT 'Free-form notes and comments about this sales territory, including special instructions, historical context, or operational considerations.',
    `population_size` BIGINT COMMENT 'Total population count within the geographic boundaries of this sales territory. Used for market sizing and penetration analysis.',
    `postal_code_range_end` STRING COMMENT 'Ending postal code for territories defined by postal code ranges. Used for geographic territory assignment.',
    `postal_code_range_start` STRING COMMENT 'Starting postal code for territories defined by postal code ranges. Used for geographic territory assignment.',
    `priority_tier` STRING COMMENT 'Strategic priority classification for resource allocation and management focus. Tier 1/strategic territories receive highest investment; tier 3/maintenance receive baseline support.',
    `sales_channel` STRING COMMENT 'Primary sales channel served by this territory: retail (physical stores), wholesale (bulk/distributor), ecommerce (online), B2B (business customers), B2C (consumers), omnichannel (integrated).',
    `sales_rep_count` STRING COMMENT 'Number of sales representatives currently assigned to this territory. Used for capacity planning and workload balancing.',
    `sales_territory_status` STRING COMMENT 'Current lifecycle status of the sales territory. Active territories are operational; inactive are closed; pending are awaiting activation; suspended are temporarily halted; archived are historical; planned are future territories.',
    `state_province_code` STRING COMMENT 'State or province code for territories defined at sub-national level (e.g., CA, TX, ON, QC).',
    `store_count` STRING COMMENT 'Number of retail stores located within this sales territory. Used for territory sizing and resource allocation.',
    `territory_code` STRING COMMENT 'Unique business identifier code for the sales territory, used for external reference and reporting.',
    `territory_description` STRING COMMENT 'Detailed textual description of the sales territory, including geographic boundaries, key characteristics, strategic focus, and special considerations.',
    `territory_level` STRING COMMENT 'Numeric level in the territory hierarchy (e.g., 1=National, 2=Regional, 3=District, 4=Local). Used for rollup reporting and organizational structure.',
    `territory_name` STRING COMMENT 'Human-readable name of the sales territory (e.g., Northeast Region, California Metro, EMEA South).',
    `territory_type` STRING COMMENT 'Classification of the territory segmentation strategy: geographic (region-based), account-based (customer segments), product-based (product lines), channel-based (retail/wholesale/online), hybrid (combination), or strategic (key accounts).',
    `time_zone` STRING COMMENT 'Primary time zone for this sales territory (e.g., America/New_York, America/Los_Angeles, Europe/London). Used for scheduling and reporting.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this sales territory record.',
    CONSTRAINT pk_sales_territory PRIMARY KEY(`sales_territory_id`)
) COMMENT 'Master reference table for sales_territory. Referenced by sales_territory_id.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`store`.`region` (
    `region_id` BIGINT COMMENT 'Primary key for region',
    `parent_region_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent region in the regional hierarchy (e.g., a district rolls up to a region, which rolls up to a division). Null for top-level regions.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Regions map to price zones for regional pricing strategy governance and zone assignment reporting. The existing price_zone_code on region is a denormalized representation of the price_zone entity. A',
    `climate_zone` STRING COMMENT 'Köppen climate classification zone for this region. Used by merchandising and buying teams to align seasonal assortment planning, planogram (POG) configurations, and inventory allocation to regional climate patterns.',
    `region_code` STRING COMMENT 'Short, externally-known alphanumeric code uniquely identifying the region (e.g., EMEA-WEST, US-SE, APAC-AU). Used in reporting, system integrations, and store master data.',
    `comp_sales_base_year` STRING COMMENT 'The fiscal year used as the baseline for Same-Store Sales (SSS / Comp Sales) calculations in this region. Stores must have been open for at least 12 months relative to this base year to qualify as comparable.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the primary country this region is associated with (e.g., USA, GBR, AUS). For multi-country regions, reflects the primary operating country.',
    `country_name` STRING COMMENT 'Full English name of the country associated with this region (e.g., United States of America, United Kingdom). Denormalized for reporting convenience.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this region record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the primary trading currency used in this region (e.g., USD, GBP, EUR, AUD). Used for regional financial reporting and comp-sales calculations.',
    `region_description` STRING COMMENT 'Free-text narrative description of the region, including geographic boundaries, key markets, strategic importance, and any operational notes relevant to store management and planning teams.',
    `division_name` STRING COMMENT 'Name of the top-level business division this region belongs to (e.g., North America Retail, EMEA Wholesale). Supports divisional P&L and comp-sales (Same-Store Sales) reporting.',
    `effective_end_date` DATE COMMENT 'Date on which this region definition ceased to be operationally effective. Null for currently active regions. Supports slowly changing dimension (SCD) patterns for historical store reporting.',
    `effective_start_date` DATE COMMENT 'Date from which this region definition became operationally effective. Used for temporal queries and historical comp-sales (Same-Store Sales) analysis.',
    `fiscal_calendar_code` STRING COMMENT 'Code referencing the fiscal calendar applied to this region for financial reporting (e.g., 4-4-5, 4-5-4, Gregorian). Ensures correct period alignment for regional P&L and comp-sales reporting.',
    `gdp_index` DECIMAL(18,2) COMMENT 'Indexed GDP value for the region relative to a global or national baseline (baseline = 1.0000). Used by finance and strategy teams for market potential scoring, store investment prioritization, and regional P&L benchmarking.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this region within the regional hierarchy. Level 1 is the top (e.g., global or continental division); higher numbers represent finer granularity (e.g., district or zone). Used for roll-up aggregations in comp-sales and P&L reporting.',
    `hierarchy_path` STRING COMMENT 'Materialized path string representing the full ancestry of the region from root to current node (e.g., /GLOBAL/AMERICAS/US/SOUTHEAST). Enables efficient subtree queries without recursive CTEs.',
    `is_franchise_territory` BOOLEAN COMMENT 'Indicates whether this region operates under a franchise model (True) or is directly operated by the retailer (False). Drives franchise fee calculations, royalty reporting, and operational governance rules.',
    `is_pilot_region` BOOLEAN COMMENT 'Indicates whether this region is currently designated as a pilot or test market (True). Pilot regions receive new store formats, planogram configurations, or promotional strategies before broader rollout.',
    `locale_code` STRING COMMENT 'IETF BCP 47 locale code representing the primary language and regional formatting conventions for this region (e.g., en_US, fr_FR, de_DE). Drives localization of POS displays, receipts, and digital communications.',
    `region_name` STRING COMMENT 'Full human-readable name of the region as used in business reporting and store operations (e.g., Southeast United States, Western Europe).',
    `notes` STRING COMMENT 'Operational notes or annotations added by regional planning or store development teams. May include boundary change history, pending restructuring notes, or special operational considerations.',
    `omnichannel_enabled` BOOLEAN COMMENT 'Indicates whether stores in this region are enabled for omnichannel fulfillment capabilities such as ship-from-store, click-and-collect (BOPIS), and dark store / micro-fulfillment center (MFC) operations.',
    `population_size_band` STRING COMMENT 'Categorical band representing the total population served by this region. Used for market sizing, store network planning, and trade area analysis. Micro: <500K; Small: 500K–2M; Medium: 2M–10M; Large: 10M–50M; Mega: >50M.',
    `region_status` STRING COMMENT 'Current lifecycle status of the region record. Active regions are operational and contain live stores. Planned regions are being set up. Inactive regions have been decommissioned. Archived regions are retained for historical reporting only.',
    `region_type` STRING COMMENT 'Classification of the regions primary purpose. Geographic regions reflect physical territory groupings; operational regions reflect store management hierarchies; sales regions align to revenue reporting; franchise regions define franchisee territories; tax and compliance regions reflect regulatory jurisdictions.',
    `regional_director_email` STRING COMMENT 'Business email address of the Regional Director accountable for this region. Used for operational escalations, store performance alerts, and regional P&L distribution.',
    `regional_director_name` STRING COMMENT 'Name of the Regional Director or VP of Retail Operations accountable for this region. Stored as a reference label for operational communications and org chart reporting; not a PII-sensitive personal record.',
    `regional_director_phone` STRING COMMENT 'Business phone number of the Regional Director accountable for this region. Used for operational escalations and emergency store communications.',
    `regulatory_zone` STRING COMMENT 'Identifier for the regulatory compliance zone applicable to this region (e.g., GDPR-EU, CCPA-US-CA, PDPA-TH). Drives data privacy controls, product labelling requirements, and consumer protection rule enforcement.',
    `sales_channel_scope` STRING COMMENT 'Primary sales channel model operating within this region. Determines which store formats, fulfillment models (ship-from-store, dark store, MFC), and digital commerce capabilities are active in the region.',
    `ship_from_store_enabled` BOOLEAN COMMENT 'Indicates whether stores in this region are authorized to fulfill online orders by shipping directly from store inventory. Distinct from general omnichannel enablement; drives fulfillment routing logic.',
    `store_count` STRING COMMENT 'Number of physical retail locations (stores) currently assigned to this region. Maintained as a denormalized count for operational dashboards and regional planning. Not a computed aggregate — updated by store master data management processes.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the primary tax jurisdiction governing retail transactions in this region. Used for tax calculation, compliance reporting, and VAT/GST/sales-tax configuration on POS systems.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the primary timezone of this region (e.g., America/New_York, Europe/London). Used for scheduling store operations, promotional windows, and footfall reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this region record was most recently modified. Used for change detection, incremental ETL processing, and audit trail.',
    CONSTRAINT pk_region PRIMARY KEY(`region_id`)
) COMMENT 'Master reference table for region. Referenced by region_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_retail_v1`.`store`.`location` ADD CONSTRAINT `fk_store_location_format_id` FOREIGN KEY (`format_id`) REFERENCES `vibe_retail_v1`.`store`.`format`(`format_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`location` ADD CONSTRAINT `fk_store_location_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_retail_v1`.`store`.`region`(`region_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`location` ADD CONSTRAINT `fk_store_location_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `vibe_retail_v1`.`store`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`format` ADD CONSTRAINT `fk_store_format_parent_format_id` FOREIGN KEY (`parent_format_id`) REFERENCES `vibe_retail_v1`.`store`.`format`(`format_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ADD CONSTRAINT `fk_store_pos_terminal_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ADD CONSTRAINT `fk_store_pos_terminal_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ADD CONSTRAINT `fk_store_fixture_department_id` FOREIGN KEY (`department_id`) REFERENCES `vibe_retail_v1`.`store`.`department`(`department_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ADD CONSTRAINT `fk_store_fixture_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`department` ADD CONSTRAINT `fk_store_department_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ADD CONSTRAINT `fk_store_cluster_parent_cluster_id` FOREIGN KEY (`parent_cluster_id`) REFERENCES `vibe_retail_v1`.`store`.`cluster`(`cluster_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ADD CONSTRAINT `fk_store_cluster_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_retail_v1`.`store`.`region`(`region_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ADD CONSTRAINT `fk_store_sfs_fulfillment_node_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ADD CONSTRAINT `fk_store_cluster_membership_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `vibe_retail_v1`.`store`.`cluster`(`cluster_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ADD CONSTRAINT `fk_store_cluster_membership_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_retail_v1`.`store`.`location`(`location_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ADD CONSTRAINT `fk_store_sales_territory_parent_sales_territory_id` FOREIGN KEY (`parent_sales_territory_id`) REFERENCES `vibe_retail_v1`.`store`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ADD CONSTRAINT `fk_store_sales_territory_parent_territory_id` FOREIGN KEY (`parent_territory_id`) REFERENCES `vibe_retail_v1`.`store`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ADD CONSTRAINT `fk_store_sales_territory_region_id` FOREIGN KEY (`region_id`) REFERENCES `vibe_retail_v1`.`store`.`region`(`region_id`);
ALTER TABLE `vibe_retail_v1`.`store`.`region` ADD CONSTRAINT `fk_store_region_parent_region_id` FOREIGN KEY (`parent_region_id`) REFERENCES `vibe_retail_v1`.`store`.`region`(`region_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_retail_v1`.`store` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_retail_v1`.`store` SET TAGS ('dbx_domain' = 'store');
ALTER TABLE `vibe_retail_v1`.`store`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`store`.`location` SET TAGS ('dbx_subdomain' = 'store_network');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location ID');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Store Format Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `accessibility_certified` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Certified');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Store Address Line 1');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Store Address Line 2');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `assortment_breadth_norm` SET TAGS ('dbx_business_glossary_term' = 'Assortment Breadth Norm');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `assortment_breadth_norm` SET TAGS ('dbx_value_regex' = 'narrow|moderate|broad|very_broad');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `assortment_depth_norm` SET TAGS ('dbx_business_glossary_term' = 'Assortment Depth Norm');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `assortment_depth_norm` SET TAGS ('dbx_value_regex' = 'shallow|moderate|deep|very_deep');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `banner_brand` SET TAGS ('dbx_business_glossary_term' = 'Retail Banner Brand');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `bopis_capable` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Capable');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Store City');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `climate_zone` SET TAGS ('dbx_business_glossary_term' = 'Climate Zone');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `climate_zone` SET TAGS ('dbx_value_regex' = 'tropical|subtropical|temperate|continental|polar');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Store Closure Date');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Store Country Code');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `district_code` SET TAGS ('dbx_business_glossary_term' = 'Retail District Code');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `dsd_receiving` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Receiving');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Store Email Address');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `format_size_band` SET TAGS ('dbx_business_glossary_term' = 'Store Format Size Band');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `format_size_band` SET TAGS ('dbx_value_regex' = 'small|medium|large|extra_large');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `last_remodel_date` SET TAGS ('dbx_business_glossary_term' = 'Last Remodel Date');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Store Latitude');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Store Lifecycle Status');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'planned|under_construction|open|temporarily_closed|permanently_closed|remodeling');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Store Locale');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Store Longitude');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Store Manager Name');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `number_of_floors` SET TAGS ('dbx_business_glossary_term' = 'Number of Floors');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Store Opening Date');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Store Operating Hours');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `parking_capacity` SET TAGS ('dbx_business_glossary_term' = 'Parking Capacity');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Store Phone Number');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Store Postal Code');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `primary_dc_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Dc Facility Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `ropis_capable` SET TAGS ('dbx_business_glossary_term' = 'Reserve Online Pick Up In Store (ROPIS) Capable');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `selling_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Selling Square Footage');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `sfs_capable` SET TAGS ('dbx_business_glossary_term' = 'Ship From Store (SFS) Capable');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `staffing_model_type` SET TAGS ('dbx_business_glossary_term' = 'Staffing Model Type');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `staffing_model_type` SET TAGS ('dbx_value_regex' = 'full_service|limited_service|self_service|automated');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Store State or Province');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `store_name` SET TAGS ('dbx_business_glossary_term' = 'Store Trading Name');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `store_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `store_number` SET TAGS ('dbx_business_glossary_term' = 'Store Number');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `store_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Store Time Zone');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `time_zone` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,5}$');
ALTER TABLE `vibe_retail_v1`.`store`.`location` ALTER COLUMN `total_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Total Square Footage');
ALTER TABLE `vibe_retail_v1`.`store`.`format` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_retail_v1`.`store`.`format` SET TAGS ('dbx_subdomain' = 'store_network');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Store Format ID');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `assortment_breadth_level` SET TAGS ('dbx_business_glossary_term' = 'Assortment Breadth Level');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `assortment_breadth_level` SET TAGS ('dbx_value_regex' = 'narrow|moderate|broad|very_broad');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `assortment_depth_level` SET TAGS ('dbx_business_glossary_term' = 'Assortment Depth Level');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `assortment_depth_level` SET TAGS ('dbx_value_regex' = 'shallow|moderate|deep|very_deep');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `bopis_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'BOPIS (Buy Online Pick Up In Store) Capable Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `clienteling_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Clienteling (Personalized In-Store Service) Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `format_code` SET TAGS ('dbx_business_glossary_term' = 'Store Format Code');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `format_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `format_description` SET TAGS ('dbx_business_glossary_term' = 'Store Format Description');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `dsd_receiving_flag` SET TAGS ('dbx_business_glossary_term' = 'DSD (Direct Store Delivery) Receiving Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `endcap_count_typical` SET TAGS ('dbx_business_glossary_term' = 'Endcap (End-of-Aisle Display) Count Typical');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `format_status` SET TAGS ('dbx_business_glossary_term' = 'Store Format Status');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `format_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pilot');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Store Format Type');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'physical_retail|fulfillment_only|hybrid');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `gondola_configuration_type` SET TAGS ('dbx_business_glossary_term' = 'Gondola (Shelving Unit) Configuration Type');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `gondola_configuration_type` SET TAGS ('dbx_value_regex' = 'standard|high_density|low_profile|modular|custom');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `loyalty_program_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Participation Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `format_name` SET TAGS ('dbx_business_glossary_term' = 'Store Format Name');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `format_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `operating_hours_type` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Type');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `operating_hours_type` SET TAGS ('dbx_value_regex' = '24_7|extended|standard|limited|variable');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `parking_capacity_typical` SET TAGS ('dbx_business_glossary_term' = 'Parking Capacity Typical');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `planogram_template_code` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Template Code');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `planogram_template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `pos_terminal_count_max` SET TAGS ('dbx_business_glossary_term' = 'POS (Point of Sale) Terminal Count Maximum');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `pos_terminal_count_min` SET TAGS ('dbx_business_glossary_term' = 'POS (Point of Sale) Terminal Count Minimum');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `pricing_strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Type');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `pricing_strategy_type` SET TAGS ('dbx_value_regex' = 'edlp|hi_lo|premium|discount|dynamic');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Enabled Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `ropis_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'ROPIS (Reserve Online Pick Up In Store) Capable Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `sfs_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'SFS (Ship-from-Store) Capable Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `size_band_max_sqft` SET TAGS ('dbx_business_glossary_term' = 'Size Band Maximum Square Feet');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `size_band_min_sqft` SET TAGS ('dbx_business_glossary_term' = 'Size Band Minimum Square Feet');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `staffing_model_type` SET TAGS ('dbx_business_glossary_term' = 'Staffing Model Type');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `staffing_model_type` SET TAGS ('dbx_value_regex' = 'full_service|limited_service|self_service|automated|hybrid');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `typical_sku_count_max` SET TAGS ('dbx_business_glossary_term' = 'Typical SKU (Stock Keeping Unit) Count Maximum');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `typical_sku_count_min` SET TAGS ('dbx_business_glossary_term' = 'Typical SKU (Stock Keeping Unit) Count Minimum');
ALTER TABLE `vibe_retail_v1`.`store`.`format` ALTER COLUMN `wms_integration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'WMS (Warehouse Management System) Integration Required Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` SET TAGS ('dbx_subdomain' = 'retail_operations');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point-of-Sale (POS) Terminal ID');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Store Department Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `barcode_scanner_type` SET TAGS ('dbx_business_glossary_term' = 'Barcode Scanner Type');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `barcode_scanner_type` SET TAGS ('dbx_value_regex' = 'handheld|fixed_mount|presentation|none');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `cash_drawer_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cash Drawer Enabled');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless (NFC) Enabled');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `customer_display_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Display Type');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `customer_display_type` SET TAGS ('dbx_value_regex' = 'pole_display|integrated_screen|tablet|none');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `ebt_snap_enabled` SET TAGS ('dbx_business_glossary_term' = 'EBT/SNAP Enabled');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `emv_chip_enabled` SET TAGS ('dbx_business_glossary_term' = 'EMV Chip Enabled');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `hardware_model` SET TAGS ('dbx_business_glossary_term' = 'Hardware Model');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `hardware_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Hardware Serial Number');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `hardware_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `hardware_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `ip_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `lane_number` SET TAGS ('dbx_business_glossary_term' = 'Lane Number');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `last_transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC Address');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `mac_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `mobile_wallet_enabled` SET TAGS ('dbx_business_glossary_term' = 'Mobile Wallet Enabled');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `mobile_wallet_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `mobile_wallet_enabled` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `network_zone` SET TAGS ('dbx_business_glossary_term' = 'Network Zone');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `network_zone` SET TAGS ('dbx_value_regex' = 'cardholder_data_environment|corporate_network|guest_network|isolated');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `pci_dss_certification_date` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Certification Date');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `pci_dss_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Certification Expiry Date');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `pin_debit_enabled` SET TAGS ('dbx_business_glossary_term' = 'PIN Debit Enabled');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `qr_code_payment_enabled` SET TAGS ('dbx_business_glossary_term' = 'QR Code Payment Enabled');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `receipt_printer_model` SET TAGS ('dbx_business_glossary_term' = 'Receipt Printer Model');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `remote_management_enabled` SET TAGS ('dbx_business_glossary_term' = 'Remote Management Enabled');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `scale_integrated` SET TAGS ('dbx_business_glossary_term' = 'Scale Integrated');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `signature_capture_enabled` SET TAGS ('dbx_business_glossary_term' = 'Signature Capture Enabled');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `software_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `terminal_name` SET TAGS ('dbx_business_glossary_term' = 'Terminal Name');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `terminal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `terminal_number` SET TAGS ('dbx_business_glossary_term' = 'Terminal Number');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `terminal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `terminal_status` SET TAGS ('dbx_business_glossary_term' = 'Terminal Status');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `terminal_status` SET TAGS ('dbx_value_regex' = 'active|offline|maintenance|decommissioned|pending_activation|suspended');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `terminal_type` SET TAGS ('dbx_business_glossary_term' = 'Terminal Type');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `terminal_type` SET TAGS ('dbx_value_regex' = 'staffed_checkout_lane|self_checkout_kiosk|mobile_pos|customer_service_desk|pharmacy_register|express_lane');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `tokenization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Enabled');
ALTER TABLE `vibe_retail_v1`.`store`.`pos_terminal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` SET TAGS ('dbx_subdomain' = 'retail_operations');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Fixture ID');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Store Department Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'ADA (Americans with Disabilities Act) Compliant Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `adjustable_shelves_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustable Shelves Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `aisle_number` SET TAGS ('dbx_business_glossary_term' = 'Aisle Number');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `bay_position` SET TAGS ('dbx_business_glossary_term' = 'Bay Position');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `fixture_category` SET TAGS ('dbx_business_glossary_term' = 'Fixture Category');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `fixture_category` SET TAGS ('dbx_value_regex' = 'permanent|seasonal|promotional|temporary');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `fixture_code` SET TAGS ('dbx_business_glossary_term' = 'Fixture Code');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `fixture_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Depth (Inches)');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `digital_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Display Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `finish_color` SET TAGS ('dbx_business_glossary_term' = 'Finish Color');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `fixture_status` SET TAGS ('dbx_business_glossary_term' = 'Fixture Status');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `fixture_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|retired|damaged|pending_installation');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `fixture_type` SET TAGS ('dbx_business_glossary_term' = 'Fixture Type');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `height_inches` SET TAGS ('dbx_business_glossary_term' = 'Height (Inches)');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `last_refurbishment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Refurbishment Date');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `lighting_integrated_flag` SET TAGS ('dbx_business_glossary_term' = 'Integrated Lighting Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `mobility_type` SET TAGS ('dbx_business_glossary_term' = 'Mobility Type');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `mobility_type` SET TAGS ('dbx_value_regex' = 'fixed|mobile|semi_mobile');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `power_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Power Required Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `refrigeration_type` SET TAGS ('dbx_business_glossary_term' = 'Refrigeration Type');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `refrigeration_type` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|multi_temp|none');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Enabled Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `security_features` SET TAGS ('dbx_business_glossary_term' = 'Security Features');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `shelf_count` SET TAGS ('dbx_business_glossary_term' = 'Shelf Count');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity (Pounds)');
ALTER TABLE `vibe_retail_v1`.`store`.`fixture` ALTER COLUMN `width_inches` SET TAGS ('dbx_business_glossary_term' = 'Width (Inches)');
ALTER TABLE `vibe_retail_v1`.`store`.`department` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`store`.`department` SET TAGS ('dbx_subdomain' = 'retail_operations');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Store Department ID');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `department_status` SET TAGS ('dbx_business_glossary_term' = 'Department Status');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `department_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|seasonal_closed|remodeling|pending_closure');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `department_type` SET TAGS ('dbx_business_glossary_term' = 'Department Type');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `endcap_count` SET TAGS ('dbx_business_glossary_term' = 'Endcap Count');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `fixture_count` SET TAGS ('dbx_business_glossary_term' = 'Fixture Count');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `gondola_count` SET TAGS ('dbx_business_glossary_term' = 'Gondola Count');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `gross_margin_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Target Percent');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `gross_margin_target_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `labor_budget_monthly` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Monthly');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `labor_budget_monthly` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `licensed_department_flag` SET TAGS ('dbx_business_glossary_term' = 'Licensed Department Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Department Notes');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `omnichannel_fulfillment_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Omnichannel Fulfillment Enabled Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `planogram_count` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Count');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `pos_terminal_count` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal Count');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `sales_target_monthly` SET TAGS ('dbx_business_glossary_term' = 'Sales Target Monthly');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `sales_target_monthly` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `selling_area_sq_ft` SET TAGS ('dbx_business_glossary_term' = 'Selling Area Square Feet');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `shrinkage_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Rate Percent');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `shrinkage_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `temperature_range_max_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum Fahrenheit');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `temperature_range_min_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum Fahrenheit');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `visual_merchandising_standard` SET TAGS ('dbx_business_glossary_term' = 'Visual Merchandising Standard');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `vibe_retail_v1`.`store`.`department` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` SET TAGS ('dbx_subdomain' = 'store_network');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster ID');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `parent_cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Store Cluster ID');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fulfillment Node Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `promo_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Calendar Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `allows_overlap` SET TAGS ('dbx_business_glossary_term' = 'Allows Store Overlap Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `assortment_depth_strategy` SET TAGS ('dbx_business_glossary_term' = 'Assortment Depth Strategy');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `assortment_depth_strategy` SET TAGS ('dbx_value_regex' = 'deep|moderate|shallow|curated');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `average_annual_sales_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Annual Sales (USD)');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `average_annual_sales_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `average_store_size_sqft` SET TAGS ('dbx_business_glossary_term' = 'Average Store Size (Square Feet)');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `climate_zone` SET TAGS ('dbx_business_glossary_term' = 'Climate Zone');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `climate_zone` SET TAGS ('dbx_value_regex' = 'tropical|arid|temperate|continental|polar');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `cluster_status` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Status');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `cluster_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived|under_review');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `cluster_type` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Type');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `clustering_criteria` SET TAGS ('dbx_business_glossary_term' = 'Clustering Criteria');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `clustering_methodology` SET TAGS ('dbx_business_glossary_term' = 'Clustering Methodology');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `clustering_methodology` SET TAGS ('dbx_value_regex' = 'algorithmic|manual|hybrid|machine_learning|rule_based');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `cluster_code` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Code');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `cluster_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `cluster_description` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Description');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cluster Effective End Date');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cluster Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `external_cluster_code` SET TAGS ('dbx_business_glossary_term' = 'External Cluster ID');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|state|metro|local');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `cluster_level` SET TAGS ('dbx_business_glossary_term' = 'Cluster Hierarchy Level');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `member_store_count` SET TAGS ('dbx_business_glossary_term' = 'Member Store Count');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `cluster_name` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Name');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `cluster_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Cluster Owner Name');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `owner_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `owner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `owner_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Cluster Owner Team');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `owner_team` SET TAGS ('dbx_value_regex' = 'merchandising|pricing|operations|supply_chain|marketing|analytics');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'EDLP|hi_lo|premium|competitive|value');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `primary_business_purpose` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Purpose');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `promotional_intensity` SET TAGS ('dbx_business_glossary_term' = 'Promotional Intensity');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `promotional_intensity` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Frequency');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_value_regex' = 'daily|twice_weekly|weekly|bi_weekly|monthly');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `store_format_mix` SET TAGS ('dbx_business_glossary_term' = 'Store Format Mix');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `supports_omnichannel` SET TAGS ('dbx_business_glossary_term' = 'Supports Omnichannel Flag');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `urbanization_level` SET TAGS ('dbx_business_glossary_term' = 'Urbanization Level');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster` ALTER COLUMN `urbanization_level` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|exurban');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` SET TAGS ('dbx_subdomain' = 'retail_operations');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `sfs_fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-from-Store (SFS) Fulfillment Node ID');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `average_pack_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Pack Time Minutes');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `average_pick_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Pick Time Minutes');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `carrier_account_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Account Number');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `carrier_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `cost_per_order` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Order');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `cost_per_order` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `daily_capacity_orders` SET TAGS ('dbx_business_glossary_term' = 'Daily Capacity Orders');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `daily_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Daily Capacity Units');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `inventory_sync_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inventory Synchronization Frequency Minutes');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `next_day_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Next-Day Delivery Cutoff Time');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Code');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Name');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `node_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Type');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `node_type` SET TAGS ('dbx_value_regex' = 'ship_from_store|dark_store|micro_fulfillment_center|hybrid');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `oms_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Order Management System (OMS) Integration Enabled');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing|decommissioned');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `picking_zone_count` SET TAGS ('dbx_business_glossary_term' = 'Picking Zone Count');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `picking_zone_identifiers` SET TAGS ('dbx_business_glossary_term' = 'Picking Zone Identifiers');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `primary_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Carrier Code');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `same_day_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Same-Day Delivery Cutoff Time');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `service_postal_codes` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Codes');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `service_radius_km` SET TAGS ('dbx_business_glossary_term' = 'Service Radius Kilometers');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `supports_bopis` SET TAGS ('dbx_business_glossary_term' = 'Supports Buy Online Pick Up In Store (BOPIS)');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `supports_curbside_pickup` SET TAGS ('dbx_business_glossary_term' = 'Supports Curbside Pickup');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `supports_next_day_delivery` SET TAGS ('dbx_business_glossary_term' = 'Supports Next-Day Delivery');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `supports_same_day_delivery` SET TAGS ('dbx_business_glossary_term' = 'Supports Same-Day Delivery');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`sfs_fulfillment_node` ALTER COLUMN `wms_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Integration Enabled');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` SET TAGS ('dbx_subdomain' = 'store_network');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `cluster_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Membership ID');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Membership - Store Cluster Id');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Cluster Membership - Location Id');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Assigned By');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `assignment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Date');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `cluster_assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Cluster Assignment Reason');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `is_primary_cluster` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Cluster');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `membership_end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership End Date');
ALTER TABLE `vibe_retail_v1`.`store`.`cluster_membership` ALTER COLUMN `membership_start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Start Date');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` SET TAGS ('dbx_subdomain' = 'store_network');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Identifier');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `parent_sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sales Territory Id');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `parent_sales_territory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `parent_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Territory Id');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `boundary_definition` SET TAGS ('dbx_business_glossary_term' = 'Boundary Definition');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `competition_level` SET TAGS ('dbx_business_glossary_term' = 'Competition Level');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `customer_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Count');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `household_count` SET TAGS ('dbx_business_glossary_term' = 'Household Count');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `market_potential_score` SET TAGS ('dbx_business_glossary_term' = 'Market Potential Score');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `median_household_income` SET TAGS ('dbx_business_glossary_term' = 'Median Household Income');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `population_size` SET TAGS ('dbx_business_glossary_term' = 'Population Size');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `postal_code_range_end` SET TAGS ('dbx_business_glossary_term' = 'Postal Code Range End');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `postal_code_range_end` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `postal_code_range_end` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `postal_code_range_start` SET TAGS ('dbx_business_glossary_term' = 'Postal Code Range Start');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `postal_code_range_start` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `postal_code_range_start` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `sales_rep_count` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Count');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `sales_territory_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State Province Code');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `store_count` SET TAGS ('dbx_business_glossary_term' = 'Store Count');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `territory_level` SET TAGS ('dbx_business_glossary_term' = 'Territory Level');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_retail_v1`.`store`.`sales_territory` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_retail_v1`.`store`.`region` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`store`.`region` SET TAGS ('dbx_subdomain' = 'store_network');
ALTER TABLE `vibe_retail_v1`.`store`.`region` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Identifier');
ALTER TABLE `vibe_retail_v1`.`store`.`region` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`store`.`region` ALTER COLUMN `regional_director_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`region` ALTER COLUMN `regional_director_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`region` ALTER COLUMN `regional_director_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`store`.`region` ALTER COLUMN `regional_director_phone` SET TAGS ('dbx_pii_phone' = 'true');
