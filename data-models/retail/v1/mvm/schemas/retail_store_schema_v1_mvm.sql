-- Schema for Domain: store | Business: Retail | Version: v1_mvm
-- Generated on: 2026-05-04 13:27:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `retail_ecm`.`store` COMMENT 'Manages physical retail locations including hypermarkets, department stores, discount outlets, dark stores, and micro-fulfillment centers (MFC). Owns store master records, planograms (POG), gondola and endcap configurations, footfall metrics, comp sales (SSS - Same-Store Sales), visual merchandising standards, POS terminal inventory, and store-level P&L. Supports store operations and omnichannel fulfillment as ship-from-store nodes.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `retail_ecm`.`store`.`location` (
    `location_id` BIGINT COMMENT 'Unique identifier for the physical retail location. Primary key for the store_location data product. This is the system-of-record identifier used across all domains (inventory, order, workforce, finance) to reference this specific store, dark store, or micro-fulfillment center (MFC).',
    `cost_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_zone. Business justification: Store locations are assigned to cost zones that determine landed cost calculations, freight factors, and duty rates applicable to that location. Retail supply chain and pricing teams use cost zone ass',
    `format_id` BIGINT COMMENT 'Foreign key linking to store.store_format. Business justification: Every store location is classified by a store format (hypermarket, discount outlet, department store, etc.). The store_location record currently denormalizes format_type as a STRING. Adding FK to stor',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Store locations are assigned to specific price lists beyond price zone (e.g., flagship vs. outlet locations may share a price zone but use different price lists). Retail pricing operations require loc',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Stores belong to price zones for regional pricing strategies. This is a fundamental retail concept - stores in the same geographic area or market segment share pricing rules. No visible redundant colu',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supplychain.dc_facility. Business justification: Every store has a primary DC assignment for standard replenishment routing. Fundamental retail supply chain topology required for: replenishment order routing, freight cost allocation, lead time calcu',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Every retail store location IS a profit center in management accounting. Retail finance rolls up store-level revenue and costs to profit centers for segment reporting and executive dashboards. The pro',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_program. Business justification: Store locations are enrolled in specific loyalty programs per banner. This FK drives store-level loyalty enrollment configuration, banner-loyalty reporting, and determines which program is active at c',
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
    `region_code` STRING COMMENT 'Code identifying the retail region to which this store location belongs. Used for hierarchical reporting, regional strategy, and executive-level performance analysis.',
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

CREATE OR REPLACE TABLE `retail_ecm`.`store`.`format` (
    `format_id` BIGINT COMMENT 'Unique identifier for the store format. Primary key.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_program. Business justification: Store formats participate in specific loyalty programs, governing POS integration setup and accrual rule applicability by format. The existing loyalty_program_participation_flag boolean is a denormali',
    `assortment_breadth_level` STRING COMMENT 'Typical range of product categories carried by this format. Narrow = few categories (e.g., convenience); broad = many categories (e.g., hypermarket).. Valid values are `narrow|moderate|broad|very_broad`',
    `assortment_depth_level` STRING COMMENT 'Typical variety within each product category for this format. Shallow = limited SKU (Stock Keeping Unit) variety per category; deep = extensive SKU variety per category.. Valid values are `shallow|moderate|deep|very_deep`',
    `bopis_capable_flag` BOOLEAN COMMENT 'Indicates whether stores of this format are capable of supporting BOPIS (Buy Online Pick Up In Store) fulfillment. True if BOPIS is supported; false otherwise.',
    `clienteling_service_flag` BOOLEAN COMMENT 'Indicates whether stores of this format offer clienteling (personalized in-store service) to customers. True if clienteling is offered; false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this store format record was first created in the system.',
    `dsd_receiving_flag` BOOLEAN COMMENT 'Indicates whether stores of this format receive DSD (Direct Store Delivery) shipments directly from vendors, bypassing the DC (Distribution Center). True if DSD receiving is supported; false otherwise.',
    `effective_end_date` DATE COMMENT 'Date when this store format definition was retired or deprecated. Null for currently active formats.',
    `effective_start_date` DATE COMMENT 'Date when this store format definition became effective and available for use in store planning and operations.',
    `endcap_count_typical` STRING COMMENT 'Typical number of endcaps (end-of-aisle displays) available for promotional merchandising in stores of this format.',
    `format_code` STRING COMMENT 'Short alphanumeric code representing the store format (e.g., HM for hypermarket, SS for superstore, DS for discount store, CONV for convenience, DARK for dark store, MFC for micro-fulfillment center).. Valid values are `^[A-Z0-9]{2,10}$`',
    `format_description` STRING COMMENT 'Detailed description of the store format including its purpose, target customer segment, and operational characteristics.',
    `format_name` STRING COMMENT 'Full descriptive name of the store format (e.g., Hypermarket, Superstore, Department Store, Discount Outlet, Convenience Store, Dark Store, Micro-Fulfillment Center, Ship-from-Store Node).',
    `format_status` STRING COMMENT 'Current lifecycle status of the store format. Active formats are in use across the banner portfolio; deprecated formats are being phased out; pilot formats are under testing.. Valid values are `active|inactive|deprecated|pilot`',
    `format_type` STRING COMMENT 'High-level classification of the format: physical_retail (customer-facing), fulfillment_only (dark store, MFC), or hybrid (ship-from-store capable retail location).. Valid values are `physical_retail|fulfillment_only|hybrid`',
    `gondola_configuration_type` STRING COMMENT 'Typical gondola (shelving unit) configuration used in stores of this format. Defines the standard shelving layout and fixture type.. Valid values are `standard|high_density|low_profile|modular|custom`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this store format record was last updated in the system.',
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

CREATE OR REPLACE TABLE `retail_ecm`.`store`.`pos_terminal` (
    `pos_terminal_id` BIGINT COMMENT 'Unique identifier for the POS terminal. Primary key. Inferred role: MASTER_RESOURCE.',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.store_department. Business justification: POS terminals are assigned to specific departments within a store (e.g., electronics department checkout, grocery department checkout). The pos_terminal record currently denormalizes department_code a',
    `location_id` BIGINT COMMENT 'Foreign key reference to the store location where this POS terminal is deployed.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_program. Business justification: POS terminals must be configured for the loyalty program they serve to enable real-time points accrual and redemption at checkout. loyalty_program.pos_integration_enabled confirms this operational lin',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: POS hardware is procured and maintained under vendor contracts. Retail IT and store operations teams track which vendor contract covers each terminal for warranty claims, SLA enforcement, scheduled ma',
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

CREATE OR REPLACE TABLE `retail_ecm`.`store`.`traffic_count` (
    `traffic_count_id` BIGINT COMMENT 'Primary key for traffic_count',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: traffic_count records footfall at store entrances and internal zones (counting_zone_code, counting_zone_name, zone_type). These zones correspond directly to store departments. Adding department_id lin',
    `location_id` BIGINT COMMENT 'Identifier of the retail location where the traffic count was measured. Links to the store master record.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Footfall measurement during promotional periods quantifies campaign-driven traffic—retailers tag traffic counts to campaigns for incremental traffic attribution. Store operations and marketing analyti',
    `accuracy_confidence_percent` DECIMAL(18,2) COMMENT 'Estimated accuracy confidence level of the measurement as a percentage (e.g., 95.5 indicates 95.5% confidence). Provided by advanced sensor systems with built-in quality scoring.',
    `average_dwell_time_minutes` DECIMAL(18,2) COMMENT 'Average time in minutes that customers spent in the counting zone during the measurement interval. Calculated from inbound/outbound timing data. Indicates customer engagement and shopping behavior.',
    `calibration_date` DATE COMMENT 'Date when the sensor device was last calibrated or validated for accuracy. Sensors require periodic calibration to maintain measurement precision; this attribute supports data quality auditing.',
    `conversion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of footfall that resulted in a transaction during the measurement interval. Calculated by dividing POS transaction count by inbound count. Key KPI for store performance and merchandising effectiveness.',
    `counting_zone_code` STRING COMMENT 'Code identifying the specific zone or area within the store where traffic was measured (e.g., MAIN_ENTRANCE, DEPT_ELECTRONICS, CHECKOUT_AREA, ENDCAP_A1). Enables zone-level footfall analysis.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `counting_zone_name` STRING COMMENT 'Human-readable name of the counting zone (e.g., Main Entrance, Electronics Department, Checkout Area 1). Provides business-friendly identification of the measurement location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this traffic count record was first created in the data platform. Used for data lineage and audit trail purposes.',
    `data_quality_flag` STRING COMMENT 'Indicator of the reliability and completeness of the traffic count measurement. Used to filter or adjust analytics based on data quality issues.. Valid values are `valid|suspect|invalid|calibration_required|sensor_offline|partial_data`',
    `data_source_system` STRING COMMENT 'Name of the source system or vendor platform that provided the traffic count data (e.g., RetailNext, ShopperTrak, Axis Camera Analytics). Used for data lineage and vendor performance tracking.',
    `day_of_week` STRING COMMENT 'Day of the week when the measurement was taken. Footfall patterns vary significantly by day of week; this attribute supports day-of-week trend analysis and staffing optimization. [ENUM-REF-CANDIDATE: monday|tuesday|wednesday|thursday|friday|saturday|sunday — 7 candidates stripped; promote to reference product]',
    `hour_of_day` STRING COMMENT 'Hour of the day (0-23) when the measurement was taken. Enables intraday footfall pattern analysis and peak-hour identification for workforce scheduling.',
    `inbound_count` STRING COMMENT 'Number of customers or individuals entering the counting zone during the measurement interval. Core footfall metric for traffic volume analysis.',
    `is_holiday` BOOLEAN COMMENT 'Flag indicating whether the measurement occurred on a recognized retail holiday or peak shopping day (e.g., Black Friday, Cyber Monday, Christmas Eve). Holidays significantly impact footfall patterns.',
    `is_promotional_event` BOOLEAN COMMENT 'Flag indicating whether a store-level promotional event or special sale was active during the measurement period. Used to isolate promotional lift in footfall analysis.',
    `is_store_open` BOOLEAN COMMENT 'Flag indicating whether the store was open for business during the measurement interval. Distinguishes operational footfall from after-hours activity (e.g., restocking, maintenance).',
    `measurement_interval_minutes` STRING COMMENT 'Duration of the measurement interval in minutes (e.g., 15, 60, 1440 for daily). Defines the time window over which traffic counts were aggregated.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The precise date and time when the traffic count measurement was captured by the sensor system. Represents the business event time of the footfall observation.',
    `net_occupancy_estimate` STRING COMMENT 'Estimated number of customers present in the zone at the end of the measurement interval, calculated as cumulative inbound minus outbound. Used for real-time capacity management and safety compliance.',
    `notes` STRING COMMENT 'Free-text field for operational notes or anomalies related to the measurement (e.g., sensor malfunction, store event, construction activity). Provides context for data quality issues or unusual patterns.',
    `outbound_count` STRING COMMENT 'Number of customers or individuals exiting the counting zone during the measurement interval. Used to calculate net occupancy and dwell time.',
    `peak_occupancy` STRING COMMENT 'Maximum number of customers simultaneously present in the zone during the measurement interval. Used for capacity planning, safety compliance, and staffing optimization.',
    `sensor_device_code` STRING COMMENT 'Unique identifier of the people-counting sensor or camera system that captured the measurement. Used for device performance tracking and data quality auditing.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `sensor_type` STRING COMMENT 'Technology type of the counting sensor (e.g., thermal imaging, video analytics with AI, infrared beam, RFID, WiFi tracking, Bluetooth beacon). Impacts measurement accuracy and privacy considerations.. Valid values are `thermal|video_analytics|infrared|rfid|wifi_tracking|bluetooth_beacon`',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Outdoor temperature in degrees Fahrenheit at the time of measurement. Used for weather-adjusted footfall modeling and seasonal trend analysis.',
    `transaction_count` STRING COMMENT 'Number of POS transactions completed during the measurement interval in the counting zone. Used to calculate conversion rate and sales per visitor metrics.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this traffic count record was last modified in the data platform. Supports change tracking and data quality auditing.',
    `weather_condition_code` STRING COMMENT 'Weather condition at the time of measurement. Footfall is highly correlated with weather; this attribute enables weather-adjusted traffic forecasting and comp sales analysis. [ENUM-REF-CANDIDATE: clear|rain|snow|fog|storm|extreme_heat|extreme_cold — 7 candidates stripped; promote to reference product]',
    `zone_type` STRING COMMENT 'Classification of the counting zone by functional area type. Used to segment footfall analysis by store area category.. Valid values are `entrance|department|checkout|aisle|endcap|gondola`',
    CONSTRAINT pk_traffic_count PRIMARY KEY(`traffic_count_id`)
) COMMENT 'Time-series record of customer traffic counts (footfall) measured at store entrances and internal zones, captured by people-counting sensors or RFID/camera systems. Records store location, counting zone (main entrance, department zone, checkout area), measurement interval (15-min, hourly, daily), inbound count, outbound count, net occupancy estimate, sensor device ID, data quality flag, and weather condition code at time of measurement. Footfall is a primary store operations KPI used for staffing optimization, conversion rate analysis, and trade area benchmarking.';

CREATE OR REPLACE TABLE `retail_ecm`.`store`.`pl` (
    `pl_id` BIGINT COMMENT 'Unique identifier for the store-level profit and loss record. Primary key for the store P&L data product.',
    `financial_period_id` BIGINT COMMENT 'Identifier of the fiscal period (week, month, quarter, or year) to which this P&L record applies.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Store P&L figures must be reconciled against a specific accounting ledger (leading vs. local GAAP) for period-end close. Retail finance teams post store P&L to ledgers for consolidation reporting. No ',
    `location_id` BIGINT COMMENT 'Identifier of the retail location (hypermarket, department store, discount outlet, dark store, or micro-fulfillment center) for which this P&L record is reported.',
    `merch_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.merch_plan. Business justification: Plan-vs-actual variance reporting is a fundamental retail financial management process. Linking store P&L actuals (gross_sales_amount, gross_margin_percent) to the governing merchandise plan (planned_',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Each store P&L is reported against a profit center for regional/divisional financial rollup. Retail finance uses profit centers to aggregate store-level P&L into segment reporting. This is a fundament',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Store P&L attributes promotional costs and revenue to campaigns—finance teams allocate promotional discounts, vendor funding, and incremental labor to specific campaigns. Store-level P&L by campaign e',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Offer-level P&L attribution is a named retail finance reporting requirement — finance teams measure gross margin impact by specific promotional offer (not just campaign). Enables promotional ROI analy',
    `atv_amount` DECIMAL(18,2) COMMENT 'Average dollar value per transaction, calculated as net sales divided by transaction count. Key metric for store performance and basket analysis.',
    `cogs_amount` DECIMAL(18,2) COMMENT 'Total cost of merchandise sold at the store during the period, including product cost, inbound freight, and direct product costs. Used to calculate gross margin.',
    `comp_sales_flag` BOOLEAN COMMENT 'Indicates whether this store qualifies for comparable store sales (SSS - Same-Store Sales) analysis for the period. Typically true if the store has been open for at least 12 months.',
    `comp_sales_growth_percent` DECIMAL(18,2) COMMENT 'Year-over-year percentage change in net sales for this store during the period, used for same-store sales (SSS) performance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this store P&L record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all monetary amounts in this P&L record are denominated.. Valid values are `^[A-Z]{3}$`',
    `depreciation_amount` DECIMAL(18,2) COMMENT 'Depreciation expense for store fixtures, equipment, POS terminals, gondolas, and other fixed assets allocated to the store for the period.',
    `discounts_amount` DECIMAL(18,2) COMMENT 'Total value of markdowns, promotional discounts, and price reductions applied to merchandise sales during the period.',
    `ebitda_amount` DECIMAL(18,2) COMMENT 'Store contribution to enterprise EBITDA, calculated as gross margin minus operating expenses (excluding depreciation). Key metric for store-level profitability and GMROI analysis.',
    `ebitda_percent` DECIMAL(18,2) COMMENT 'EBITDA as a percentage of net sales. Used for store performance benchmarking and profitability comparison across locations.',
    `finalized_timestamp` TIMESTAMP COMMENT 'Date and time when this store P&L record was marked as final and locked for audit purposes. Null if still preliminary.',
    `gross_margin_amount` DECIMAL(18,2) COMMENT 'Net sales minus COGS. Represents the profit available to cover operating expenses and contribute to EBITDA.',
    `gross_margin_percent` DECIMAL(18,2) COMMENT 'Gross margin as a percentage of net sales. Key profitability metric used for store performance benchmarking and GMROI analysis.',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'Total merchandise sales at the store before deducting returns, allowances, and discounts. Used to calculate return rates and discount penetration.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total store labor expenses including wages, salaries, benefits, payroll taxes, and overtime for store associates and management during the period.',
    `marketing_expense_amount` DECIMAL(18,2) COMMENT 'Store-level marketing and advertising expenses including local promotions, signage, endcap displays, and community engagement costs for the period.',
    `net_sales_amount` DECIMAL(18,2) COMMENT 'Total revenue from merchandise sales at the store during the period, net of returns, allowances, and discounts. Represents the top line of the store P&L.',
    `notes` STRING COMMENT 'Free-text notes or comments explaining unusual variances, one-time adjustments, restatement reasons, or other contextual information for this P&L record.',
    `occupancy_cost_amount` DECIMAL(18,2) COMMENT 'Total store occupancy expenses including rent, common area maintenance (CAM) charges, property taxes, utilities, and facility maintenance costs for the period.',
    `period_end_date` DATE COMMENT 'The last calendar date of the fiscal period covered by this P&L record.',
    `period_start_date` DATE COMMENT 'The first calendar date of the fiscal period covered by this P&L record.',
    `pl_status` STRING COMMENT 'Current status of the P&L record indicating whether the figures are preliminary estimates, final audited values, or restated corrections.. Valid values are `preliminary|final|restated`',
    `reporting_entity` STRING COMMENT 'Legal entity or business unit responsible for this store P&L record, used for consolidated financial reporting and intercompany reconciliation.',
    `returns_amount` DECIMAL(18,2) COMMENT 'Total value of merchandise returned by customers during the period. Subtracted from gross sales to arrive at net sales.',
    `shrinkage_amount` DECIMAL(18,2) COMMENT 'Total inventory loss due to theft, damage, spoilage, or administrative errors during the period. Recorded as an operating expense.',
    `supply_expense_amount` DECIMAL(18,2) COMMENT 'Total cost of store supplies including bags, packaging materials, cleaning supplies, POS consumables, and other operational supplies consumed during the period.',
    `total_operating_expense_amount` DECIMAL(18,2) COMMENT 'Sum of all operating expenses including shrinkage, occupancy, labor, supplies, marketing, depreciation, and other operating costs for the period.',
    `transaction_count` BIGINT COMMENT 'Total number of POS transactions completed at the store during the period. Used to calculate average transaction value (ATV) and units per transaction (UPT).',
    `units_sold` BIGINT COMMENT 'Total number of merchandise units (SKUs) sold at the store during the period. Used to calculate units per transaction (UPT) and sell-through rates.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this store P&L record was last modified, including status changes or restatements.',
    `upt` DECIMAL(18,2) COMMENT 'Average number of units sold per transaction, calculated as units sold divided by transaction count. Indicates basket size and cross-selling effectiveness.',
    CONSTRAINT pk_pl PRIMARY KEY(`pl_id`)
) COMMENT 'Store-level Profit & Loss (P&L) record capturing periodic financial performance for each retail location. Records store location, fiscal period (week/month/quarter/year), net sales, COGS (Cost of Goods Sold), gross margin, gross margin %, shrinkage expense, occupancy cost (rent, CAM, utilities), labor cost, supply expense, total operating expense, EBITDA contribution, and P&L status (preliminary, final, restated). Owned by the store domain as the operational P&L; the finance domain owns the consolidated GL. Enables GMROI analysis and store-level profitability benchmarking.';

CREATE OR REPLACE TABLE `retail_ecm`.`store`.`shrinkage_event` (
    `shrinkage_event_id` BIGINT COMMENT 'Unique identifier for the shrinkage event record. Primary key.',
    `adjustment_id` BIGINT COMMENT 'Identifier of the inventory adjustment transaction in the WMS or ERP system that recorded the shrinkage loss. Links to the inventory adjustment ledger.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Shrinkage write-offs must be charged to a cost center for budget variance analysis and period-end expense allocation. Retail finance tracks shrinkage by cost center to monitor loss prevention effectiv',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: Shrinkage events require cost price linkage for accurate financial valuation in loss prevention reporting and insurance claims. Retail finance teams calculate cost_value_lost from the authoritative co',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.store_department. Business justification: Shrinkage events (theft, damage, spoilage) occur in specific departments within a store. The shrinkage_event record currently denormalizes department_code as a STRING. Adding FK to store_department al',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Shrinkage events must be period-matched for inventory valuation and period-end close. Retail finance requires shrinkage to post in the correct fiscal period for accurate COGS and gross margin reportin',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Shrinkage losses post to specific GL accounts (inventory shrink expense, theft loss) for financial statement impact and COGS accuracy—required for inventory valuation and P&L reporting.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Shrinkage events trigger inventory write-down journal entries for GAAP compliance. Linking shrinkage_event to its resulting journal_entry provides the audit trail required for external auditors and SO',
    `location_id` BIGINT COMMENT 'Identifier of the retail location where the shrinkage event occurred. Links to the store master record.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Promotional periods see elevated shrinkage due to high traffic, promotional displays, and temporary merchandising—loss prevention teams track shrinkage by campaign. AP and operations teams analyze cam',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Offer-level shrinkage attribution is a named loss prevention reporting requirement — high-value promotional items (BOGO, deep-discount offers) are disproportionately targeted for theft. Links shrinkag',
    `rma_id` BIGINT COMMENT 'Foreign key linking to returns.rma. Business justification: Shrinkage events frequently originate from fraudulent returns (empty box returns, receipt fraud, wardrobing, return of stolen merchandise). LP teams link shrinkage events to specific RMAs for loss att',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Loss-prevention reporting and inventory reconciliation require linking shrinkage events to specific SKUs. The existing plain-text `sku` and `upc` columns are denormalized; a proper FK enables shrinkag',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or supplier involved in the shrinkage event (for vendor fraud or DSD - Direct Store Delivery discrepancies).',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_item. Business justification: Retail loss prevention teams link shrinkage events to specific vendor items to initiate vendor quality chargebacks and assess supplier defect rates. This is a named business process (vendor chargeback',
    `case_reference_number` STRING COMMENT 'Reference number for the associated Loss Prevention investigation case, if one was opened. May link to external case management systems.',
    `cost_value_lost` DECIMAL(18,2) COMMENT 'The total cost value (COGS - Cost of Goods Sold) of inventory lost in this shrinkage event. Used for financial accounting and inventory valuation adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shrinkage event record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `detection_method` STRING COMMENT 'The method or process by which the shrinkage event was identified: POS (Point of Sale) exception report, cycle count, physical inventory, RFID (Radio Frequency Identification) scan, LP (Loss Prevention) investigation, or vendor audit.. Valid values are `pos_exception|cycle_count|physical_inventory|rfid_scan|lp_investigation|vendor_audit`',
    `event_date` DATE COMMENT 'The date on which the shrinkage event was identified or occurred. Format: yyyy-MM-dd.',
    `event_number` STRING COMMENT 'Business-facing unique reference number for the shrinkage event, used for tracking and case management (e.g., SHR-0000012345).. Valid values are `^SHR-[0-9]{10}$`',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the shrinkage event was detected or recorded. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `fiscal_period` STRING COMMENT 'The fiscal period (quarter or month) in which the shrinkage event occurred, used for financial reporting and P&L impact analysis (e.g., 2024-Q2 or 2024-06).. Valid values are `^[0-9]{4}-Q[1-4]$|^[0-9]{4}-[0-9]{2}$`',
    `incident_report_filed` BOOLEAN COMMENT 'Indicates whether a formal incident report was filed with Loss Prevention or law enforcement for this shrinkage event.',
    `inventory_adjustment_posted` BOOLEAN COMMENT 'Indicates whether the inventory adjustment for this shrinkage event has been posted to the inventory ledger and financial systems (WMS - Warehouse Management System and ERP).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this shrinkage event record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, investigation findings, or details about the shrinkage event. May include Loss Prevention officer observations or follow-up actions.',
    `police_report_number` STRING COMMENT 'Law enforcement report number if the shrinkage event involved external theft and was reported to police.',
    `product_description` STRING COMMENT 'Human-readable description of the product(s) involved in the shrinkage event.',
    `quantity_lost` DECIMAL(18,2) COMMENT 'The quantity of units lost in the shrinkage event. May include fractional units for weight-based or bulk items.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'The monetary value recovered from the shrinkage event through restitution, insurance claims, vendor credits, or merchandise recovery. Null or zero if no recovery occurred.',
    `recovery_method` STRING COMMENT 'The method by which value was recovered: merchandise physically recovered, restitution from perpetrator, insurance claim payout, vendor credit (RTV - Return to Vendor), chargeback to vendor, or none.. Valid values are `merchandise_recovered|restitution|insurance_claim|vendor_credit|chargeback|none`',
    `resolution_date` DATE COMMENT 'The date on which the shrinkage event case was resolved or closed. Null if still open or under investigation.',
    `resolution_status` STRING COMMENT 'Current status of the shrinkage event case: open (newly identified), under investigation, resolved (cause identified and addressed), closed unresolved, or recovered (merchandise or value recovered).. Valid values are `open|under_investigation|resolved|closed_unresolved|recovered`',
    `responsible_party_type` STRING COMMENT 'Classification of the party responsible for the shrinkage: external (customer/shoplifter), employee (internal theft), vendor (fraud/error), unknown, or not applicable (e.g., damage, administrative error).. Valid values are `external|employee|vendor|unknown|not_applicable`',
    `shrinkage_type` STRING COMMENT 'Classification of the root cause of the shrinkage event: external theft (shoplifting), internal theft (employee), administrative error (paperwork/system), vendor fraud, damage (spoilage/breakage), or unknown.. Valid values are `external_theft|internal_theft|administrative_error|vendor_fraud|damage|unknown`',
    `source_system` STRING COMMENT 'The operational system from which this shrinkage event record originated (e.g., Manhattan WMS, SAP S/4HANA, Oracle Retail, Loss Prevention Case Management System).',
    `total_retail_value_lost` DECIMAL(18,2) COMMENT 'The total estimated retail value of inventory lost in this shrinkage event (quantity_lost × unit_retail_value). Directly impacts store P&L (Profit and Loss).',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity lost (e.g., each, case, pound, kilogram, liter, gallon).. Valid values are `each|case|pound|kilogram|liter|gallon`',
    `unit_retail_value` DECIMAL(18,2) COMMENT 'The retail price per unit of the product at the time of the shrinkage event. Used to calculate total estimated loss.',
    `zone_location` STRING COMMENT 'Specific zone, aisle, or area within the store where the shrinkage event was detected (e.g., Aisle 12, Backroom, Checkout Lane 5).',
    CONSTRAINT pk_shrinkage_event PRIMARY KEY(`shrinkage_event_id`)
) COMMENT 'Operational record of an identified inventory shrinkage event at a store location. Captures event date, store location, department/zone, shrinkage type (shoplifting/external theft, internal theft, administrative error, vendor fraud, damage), SKU(s) involved, quantity lost, estimated retail value lost, detection method (POS exception, cycle count, RFID, LP investigation), case reference number, resolution status, and recovery amount. Shrinkage is a critical retail KPI directly impacting store P&L and inventory accuracy. Supports LP (Loss Prevention) operations and CPSC/FTC compliance reporting.';

CREATE OR REPLACE TABLE `retail_ecm`.`store`.`department` (
    `department_id` BIGINT COMMENT 'Unique identifier for the store department. Primary key for the store department entity.',
    `buyer_id` BIGINT COMMENT 'Foreign key linking to merchandising.buyer. Business justification: In retail operations, each store department is owned by a specific buyer responsible for assortment, purchasing authority, and performance accountability for that department. This buyer-department own',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Department managers execute category-level merchandising strategies. Real business process: departments track category performance targets, space allocation, assortment compliance, and GMROI against c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each store department (apparel, electronics, grocery) maps to a cost center for labor budgeting, expense allocation, and departmental P&L reporting. Retail finance tracks department-level costs via co',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Store departments map to merchandise categories (item hierarchy). Department managers are responsible for specific categories. Essential for departmental P&L reporting by category and category manager',
    `license_id` BIGINT COMMENT 'Foreign key linking to store.license. Business justification: department currently stores denormalized license data: license_number (STRING), license_expiry_date (DATE), and licensed_department_flag (BOOLEAN). These attributes exist because licensed departments ',
    `location_id` BIGINT COMMENT 'Reference to the parent store location where this department is physically located.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Retail departments (electronics, grocery, apparel) operate under department-specific price lists governing their pricing authority and markdown limits. Department-level price list assignment is a stan',
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
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to the department. Used for operational context and exception handling.',
    `omnichannel_fulfillment_enabled_flag` BOOLEAN COMMENT 'Indicates whether the department supports omnichannel fulfillment operations (BOPIS, ROPIS, ship-from-store). True if omnichannel fulfillment is enabled.',
    `planogram_count` STRING COMMENT 'Number of active planograms (shelf layout diagrams) assigned to the department. Each planogram defines product placement and facings for a fixture or section.',
    `pos_terminal_count` STRING COMMENT 'Number of POS terminals or checkout lanes assigned to or located within the department. Relevant for departments with dedicated checkout (e.g., pharmacy, jewelry).',
    `sales_target_monthly` DECIMAL(18,2) COMMENT 'Monthly sales target or quota for the department in local currency. Used for performance management and comp sales (SSS) analysis.',
    `selling_area_sq_ft` DECIMAL(18,2) COMMENT 'Total selling floor space allocated to the department measured in square feet. Used to calculate sales per square foot and space productivity metrics.',
    `shrinkage_rate_percent` DECIMAL(18,2) COMMENT 'Historical shrinkage rate (inventory loss due to theft, damage, spoilage) for the department expressed as a percentage of sales. Used for loss prevention planning.',
    `source_system` STRING COMMENT 'Name of the operational system of record from which this department record originated (e.g., ORMS, SAP S/4HANA, MDM).',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the department requires temperature-controlled environment (e.g., frozen, refrigerated, deli, bakery). True if climate control is required.',
    `temperature_range_max_f` DECIMAL(18,2) COMMENT 'Maximum temperature threshold in Fahrenheit for temperature-controlled departments. Null for non-temperature-controlled departments.',
    `temperature_range_min_f` DECIMAL(18,2) COMMENT 'Minimum temperature threshold in Fahrenheit for temperature-controlled departments. Null for non-temperature-controlled departments.',
    `visual_merchandising_standard` STRING COMMENT 'Code or reference to the visual merchandising standard or guideline applied to the department. Defines display aesthetics, signage, and presentation rules.',
    `zone_code` STRING COMMENT 'Alphanumeric code identifying the physical zone or area within the store floor plan. Used for wayfinding, inventory location, and planogram assignment.. Valid values are `^[A-Z0-9]{1,5}$`',
    CONSTRAINT pk_department PRIMARY KEY(`department_id`)
) COMMENT 'Master record for departments or selling zones within a store location — the primary sub-location operational unit in retail. Captures department ID, department name, department code, parent store location, floor number, zone coordinates, department type (grocery, apparel, electronics, household, pharmacy, bakery, deli, produce, frozen, health & beauty, seasonal, etc.), selling area (sq ft), number of fixtures, department manager assignment reference, labor budget allocation, and active status. Departments are the fundamental unit for planogram assignment, inventory allocation, staffing schedules, shrinkage attribution, and P&L sub-reporting within a store. Most operational KPIs (sales per sq ft, shrink rate, labor-to-sales ratio) are measured at department level.';

CREATE OR REPLACE TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` (
    `sfs_fulfillment_node_id` BIGINT COMMENT 'Unique identifier for the ship-from-store fulfillment node. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Ship-from-store nodes incur distinct operational costs (labor, packaging, carrier fees) tracked separately from store retail operations. Retail omnichannel finance allocates SFS fulfillment costs to d',
    `fulfillment_node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_node. Business justification: store.sfs_fulfillment_node defines a stores ship-from-store capability; fulfillment.fulfillment_node is the operational execution node. Linking them enables OMS/WMS capacity synchronization, unified ',
    `location_id` BIGINT COMMENT 'Reference to the physical store location that serves as this fulfillment node. Links to the store master record.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Ship-from-store fulfillment nodes serve specific geographic service areas and must apply the correct price zone for e-commerce order pricing. Retail OMS systems require price zone assignment on fulfil',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: An SFS fulfillment node (dark store, MFC, or ship-from-store area) operates out of specific departments or picking zones within a store. The sfs_fulfillment_node already has picking_zone_count and pic',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Campaign-driven fulfillment node activation and capacity planning is a named retail ops process — nodes are scaled up for Black Friday or seasonal campaigns. Distinct from the existing promo_offer_id ',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.storefront. Business justification: SFS node-to-storefront channel assignment: an SFS fulfillment node is configured to serve a specific online storefront (e.g., main website vs. marketplace). This drives order routing rules, capacity a',
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

CREATE OR REPLACE TABLE `retail_ecm`.`store`.`license` (
    `license_id` BIGINT COMMENT 'Unique identifier for the store license record. Primary key. Role: MASTER_AGREEMENT.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: License fees and compliance costs charge to cost centers for expense allocation and budget tracking—standard overhead accounting for regulatory compliance expenses in retail operations.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: License costs must be amortized and accrued across financial periods for GAAP compliance. Retail finance teams match license expenses to the correct fiscal period during period-end close. Linking to f',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: License fees (liquor, health, business permits) must be posted to specific GL accounts (prepaid expenses, license fees) for accrual accounting and regulatory compliance. Retail finance requires proper',
    `location_id` BIGINT COMMENT 'Reference to the store location that holds this license. Links to store_location master record.',
    `renewed_from_license_id` BIGINT COMMENT 'Self-referencing FK on license (renewed_from_license_id)',
    `audit_trail_reference` STRING COMMENT 'Reference to audit log entries or compliance audit records associated with this license. Supports regulatory audit readiness.',
    `compliance_notes` STRING COMMENT 'Free-text notes regarding compliance requirements, special conditions, or restrictions associated with this license.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this license record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual fee amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `effective_start_date` DATE COMMENT 'Date from which the license becomes legally binding and the store is authorized to operate under this license.',
    `inspection_frequency_months` STRING COMMENT 'Number of months between required regulatory inspections. Used to calculate next inspection due dates.',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether periodic regulatory inspections are required to maintain this license. True if inspections are mandatory, False otherwise.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection conducted for this license. Tracks compliance verification cadence.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this record. Audit trail for accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this license record was most recently updated. Audit trail for record changes.',
    `last_violation_date` DATE COMMENT 'Date of the most recent violation or citation issued for this license. Used for risk assessment and compliance monitoring.',
    `next_inspection_due_date` DATE COMMENT 'Date by which the next regulatory inspection must be completed to maintain license compliance.',
    `reinstatement_conditions` STRING COMMENT 'Conditions or requirements that must be met for the license to be reinstated after suspension or revocation.',
    `reinstatement_eligible_flag` BOOLEAN COMMENT 'Indicates whether the license is eligible for reinstatement after suspension or revocation. True if reinstatement is possible, False otherwise.',
    `renewal_lead_time_days` STRING COMMENT 'Number of days before expiration that the renewal process must be initiated to ensure continuity. Supports automated renewal alerting.',
    `revocation_date` DATE COMMENT 'Date the license was permanently revoked by the regulatory authority. Populated only when license_status is revoked.',
    `revocation_reason` STRING COMMENT 'Reason provided by the regulatory authority for revoking the license. Populated only when license_status is revoked.',
    `source_system` STRING COMMENT 'Name of the operational system from which this license record originated (e.g., SAP S/4HANA, Oracle Retail, Compliance Management System).',
    `source_system_code` STRING COMMENT 'Unique identifier for this license record in the source operational system. Enables traceability and reconciliation.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or URL to the scanned license document, certificate, or permit stored in the document management system.',
    `suspension_end_date` DATE COMMENT 'Date the license suspension is scheduled to end or was lifted. Nullable if suspension is indefinite.',
    `suspension_reason` STRING COMMENT 'Reason provided by the regulatory authority for suspending the license. Populated only when license_status is suspended.',
    `suspension_start_date` DATE COMMENT 'Date the license suspension became effective. Populated only when license_status is suspended.',
    `violation_count` STRING COMMENT 'Total number of violations or citations issued against this license since its issue date. Tracks compliance history.',
    CONSTRAINT pk_license PRIMARY KEY(`license_id`)
) COMMENT 'Master record for licenses, permits, and regulatory certifications held at each store location. Captures license ID, store location reference, license type (liquor license, pharmacy permit, tobacco license, food handling certification, business operating permit, fire occupancy permit, health department permit, controlled substance DEA registration, lottery retailer license, money services license), issuing authority, license number, issue date, expiration date, renewal lead time, renewal status (current, pending renewal, expired, suspended, revoked), annual fee, responsible associate reference, and supporting document references. Tracks multi-jurisdictional requirements (state, county, municipal) for stores operating across regulatory boundaries. Critical for compliance — operating with an expired license triggers fines, forced closure, and reputational damage. Supports automated renewal alerting and regulatory audit readiness.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `retail_ecm`.`store`.`location` ADD CONSTRAINT `fk_store_location_format_id` FOREIGN KEY (`format_id`) REFERENCES `retail_ecm`.`store`.`format`(`format_id`);
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ADD CONSTRAINT `fk_store_pos_terminal_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ADD CONSTRAINT `fk_store_pos_terminal_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ADD CONSTRAINT `fk_store_traffic_count_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ADD CONSTRAINT `fk_store_traffic_count_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`store`.`pl` ADD CONSTRAINT `fk_store_pl_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ADD CONSTRAINT `fk_store_shrinkage_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_license_id` FOREIGN KEY (`license_id`) REFERENCES `retail_ecm`.`store`.`license`(`license_id`);
ALTER TABLE `retail_ecm`.`store`.`department` ADD CONSTRAINT `fk_store_department_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ADD CONSTRAINT `fk_store_sfs_fulfillment_node_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ADD CONSTRAINT `fk_store_sfs_fulfillment_node_department_id` FOREIGN KEY (`department_id`) REFERENCES `retail_ecm`.`store`.`department`(`department_id`);
ALTER TABLE `retail_ecm`.`store`.`license` ADD CONSTRAINT `fk_store_license_location_id` FOREIGN KEY (`location_id`) REFERENCES `retail_ecm`.`store`.`location`(`location_id`);
ALTER TABLE `retail_ecm`.`store`.`license` ADD CONSTRAINT `fk_store_license_renewed_from_license_id` FOREIGN KEY (`renewed_from_license_id`) REFERENCES `retail_ecm`.`store`.`license`(`license_id`);

-- ========= TAGS =========
ALTER SCHEMA `retail_ecm`.`store` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `retail_ecm`.`store` SET TAGS ('dbx_domain' = 'store');
ALTER TABLE `retail_ecm`.`store`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`store`.`location` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location ID');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `cost_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Store Format Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Dc Facility Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `accessibility_certified` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Certified');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Store Address Line 1');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Store Address Line 2');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `assortment_breadth_norm` SET TAGS ('dbx_business_glossary_term' = 'Assortment Breadth Norm');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `assortment_breadth_norm` SET TAGS ('dbx_value_regex' = 'narrow|moderate|broad|very_broad');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `assortment_depth_norm` SET TAGS ('dbx_business_glossary_term' = 'Assortment Depth Norm');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `assortment_depth_norm` SET TAGS ('dbx_value_regex' = 'shallow|moderate|deep|very_deep');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `banner_brand` SET TAGS ('dbx_business_glossary_term' = 'Retail Banner Brand');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `bopis_capable` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Capable');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Store City');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `climate_zone` SET TAGS ('dbx_business_glossary_term' = 'Climate Zone');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `climate_zone` SET TAGS ('dbx_value_regex' = 'tropical|subtropical|temperate|continental|polar');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Store Closure Date');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Store Country Code');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `district_code` SET TAGS ('dbx_business_glossary_term' = 'Retail District Code');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `dsd_receiving` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Receiving');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Store Email Address');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `format_size_band` SET TAGS ('dbx_business_glossary_term' = 'Store Format Size Band');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `format_size_band` SET TAGS ('dbx_value_regex' = 'small|medium|large|extra_large');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `last_remodel_date` SET TAGS ('dbx_business_glossary_term' = 'Last Remodel Date');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Store Latitude');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Store Lifecycle Status');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'planned|under_construction|open|temporarily_closed|permanently_closed|remodeling');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Store Locale');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `locale` SET TAGS ('dbx_value_regex' = '^[a-z]{2}_[A-Z]{2}$');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Store Longitude');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Store Manager Name');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `number_of_floors` SET TAGS ('dbx_business_glossary_term' = 'Number of Floors');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Store Opening Date');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Store Operating Hours');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `parking_capacity` SET TAGS ('dbx_business_glossary_term' = 'Parking Capacity');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Store Phone Number');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Store Postal Code');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Retail Region Code');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `ropis_capable` SET TAGS ('dbx_business_glossary_term' = 'Reserve Online Pick Up In Store (ROPIS) Capable');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `selling_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Selling Square Footage');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `sfs_capable` SET TAGS ('dbx_business_glossary_term' = 'Ship From Store (SFS) Capable');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `staffing_model_type` SET TAGS ('dbx_business_glossary_term' = 'Staffing Model Type');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `staffing_model_type` SET TAGS ('dbx_value_regex' = 'full_service|limited_service|self_service|automated');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Store State or Province');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `store_name` SET TAGS ('dbx_business_glossary_term' = 'Store Trading Name');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `store_number` SET TAGS ('dbx_business_glossary_term' = 'Store Number');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `store_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Store Time Zone');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `time_zone` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,5}$');
ALTER TABLE `retail_ecm`.`store`.`location` ALTER COLUMN `total_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Total Square Footage');
ALTER TABLE `retail_ecm`.`store`.`format` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `retail_ecm`.`store`.`format` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `format_id` SET TAGS ('dbx_business_glossary_term' = 'Store Format ID');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `assortment_breadth_level` SET TAGS ('dbx_business_glossary_term' = 'Assortment Breadth Level');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `assortment_breadth_level` SET TAGS ('dbx_value_regex' = 'narrow|moderate|broad|very_broad');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `assortment_depth_level` SET TAGS ('dbx_business_glossary_term' = 'Assortment Depth Level');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `assortment_depth_level` SET TAGS ('dbx_value_regex' = 'shallow|moderate|deep|very_deep');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `bopis_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'BOPIS (Buy Online Pick Up In Store) Capable Flag');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `clienteling_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Clienteling (Personalized In-Store Service) Flag');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `dsd_receiving_flag` SET TAGS ('dbx_business_glossary_term' = 'DSD (Direct Store Delivery) Receiving Flag');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `endcap_count_typical` SET TAGS ('dbx_business_glossary_term' = 'Endcap (End-of-Aisle Display) Count Typical');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `format_code` SET TAGS ('dbx_business_glossary_term' = 'Store Format Code');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `format_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `format_description` SET TAGS ('dbx_business_glossary_term' = 'Store Format Description');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `format_name` SET TAGS ('dbx_business_glossary_term' = 'Store Format Name');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `format_status` SET TAGS ('dbx_business_glossary_term' = 'Store Format Status');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `format_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pilot');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Store Format Type');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'physical_retail|fulfillment_only|hybrid');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `gondola_configuration_type` SET TAGS ('dbx_business_glossary_term' = 'Gondola (Shelving Unit) Configuration Type');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `gondola_configuration_type` SET TAGS ('dbx_value_regex' = 'standard|high_density|low_profile|modular|custom');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `operating_hours_type` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Type');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `operating_hours_type` SET TAGS ('dbx_value_regex' = '24_7|extended|standard|limited|variable');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `parking_capacity_typical` SET TAGS ('dbx_business_glossary_term' = 'Parking Capacity Typical');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `planogram_template_code` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Template Code');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `planogram_template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `pos_terminal_count_max` SET TAGS ('dbx_business_glossary_term' = 'POS (Point of Sale) Terminal Count Maximum');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `pos_terminal_count_min` SET TAGS ('dbx_business_glossary_term' = 'POS (Point of Sale) Terminal Count Minimum');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `pricing_strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Type');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `pricing_strategy_type` SET TAGS ('dbx_value_regex' = 'edlp|hi_lo|premium|discount|dynamic');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Enabled Flag');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `ropis_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'ROPIS (Reserve Online Pick Up In Store) Capable Flag');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `sfs_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'SFS (Ship-from-Store) Capable Flag');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `size_band_max_sqft` SET TAGS ('dbx_business_glossary_term' = 'Size Band Maximum Square Feet');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `size_band_min_sqft` SET TAGS ('dbx_business_glossary_term' = 'Size Band Minimum Square Feet');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `staffing_model_type` SET TAGS ('dbx_business_glossary_term' = 'Staffing Model Type');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `staffing_model_type` SET TAGS ('dbx_value_regex' = 'full_service|limited_service|self_service|automated|hybrid');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `typical_sku_count_max` SET TAGS ('dbx_business_glossary_term' = 'Typical SKU (Stock Keeping Unit) Count Maximum');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `typical_sku_count_min` SET TAGS ('dbx_business_glossary_term' = 'Typical SKU (Stock Keeping Unit) Count Minimum');
ALTER TABLE `retail_ecm`.`store`.`format` ALTER COLUMN `wms_integration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'WMS (Warehouse Management System) Integration Required Flag');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point-of-Sale (POS) Terminal ID');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Store Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `barcode_scanner_type` SET TAGS ('dbx_business_glossary_term' = 'Barcode Scanner Type');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `barcode_scanner_type` SET TAGS ('dbx_value_regex' = 'handheld|fixed_mount|presentation|none');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `cash_drawer_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cash Drawer Enabled');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless (NFC) Enabled');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `customer_display_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Display Type');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `customer_display_type` SET TAGS ('dbx_value_regex' = 'pole_display|integrated_screen|tablet|none');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `ebt_snap_enabled` SET TAGS ('dbx_business_glossary_term' = 'EBT/SNAP Enabled');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `emv_chip_enabled` SET TAGS ('dbx_business_glossary_term' = 'EMV Chip Enabled');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `hardware_model` SET TAGS ('dbx_business_glossary_term' = 'Hardware Model');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `hardware_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Hardware Serial Number');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `hardware_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `hardware_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `lane_number` SET TAGS ('dbx_business_glossary_term' = 'Lane Number');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `last_transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Timestamp');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC Address');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `mobile_wallet_enabled` SET TAGS ('dbx_business_glossary_term' = 'Mobile Wallet Enabled');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `mobile_wallet_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `mobile_wallet_enabled` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `network_zone` SET TAGS ('dbx_business_glossary_term' = 'Network Zone');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `network_zone` SET TAGS ('dbx_value_regex' = 'cardholder_data_environment|corporate_network|guest_network|isolated');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `pci_dss_certification_date` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Certification Date');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `pci_dss_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Certification Expiry Date');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `pin_debit_enabled` SET TAGS ('dbx_business_glossary_term' = 'PIN Debit Enabled');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `qr_code_payment_enabled` SET TAGS ('dbx_business_glossary_term' = 'QR Code Payment Enabled');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `receipt_printer_model` SET TAGS ('dbx_business_glossary_term' = 'Receipt Printer Model');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `remote_management_enabled` SET TAGS ('dbx_business_glossary_term' = 'Remote Management Enabled');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `scale_integrated` SET TAGS ('dbx_business_glossary_term' = 'Scale Integrated');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `signature_capture_enabled` SET TAGS ('dbx_business_glossary_term' = 'Signature Capture Enabled');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `software_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `terminal_name` SET TAGS ('dbx_business_glossary_term' = 'Terminal Name');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `terminal_number` SET TAGS ('dbx_business_glossary_term' = 'Terminal Number');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `terminal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `terminal_status` SET TAGS ('dbx_business_glossary_term' = 'Terminal Status');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `terminal_status` SET TAGS ('dbx_value_regex' = 'active|offline|maintenance|decommissioned|pending_activation|suspended');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `terminal_type` SET TAGS ('dbx_business_glossary_term' = 'Terminal Type');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `terminal_type` SET TAGS ('dbx_value_regex' = 'staffed_checkout_lane|self_checkout_kiosk|mobile_pos|customer_service_desk|pharmacy_register|express_lane');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `tokenization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Enabled');
ALTER TABLE `retail_ecm`.`store`.`pos_terminal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `traffic_count_id` SET TAGS ('dbx_business_glossary_term' = 'Traffic Count Identifier');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `accuracy_confidence_percent` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Confidence (Percent)');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `average_dwell_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Dwell Time (Minutes)');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `conversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate (Percent)');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `counting_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Counting Zone Code');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `counting_zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `counting_zone_name` SET TAGS ('dbx_business_glossary_term' = 'Counting Zone Name');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid|calibration_required|sensor_offline|partial_data');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `hour_of_day` SET TAGS ('dbx_business_glossary_term' = 'Hour of Day');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `inbound_count` SET TAGS ('dbx_business_glossary_term' = 'Inbound Count');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `is_holiday` SET TAGS ('dbx_business_glossary_term' = 'Is Holiday');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `is_promotional_event` SET TAGS ('dbx_business_glossary_term' = 'Is Promotional Event');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `is_store_open` SET TAGS ('dbx_business_glossary_term' = 'Is Store Open');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `measurement_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Interval (Minutes)');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `net_occupancy_estimate` SET TAGS ('dbx_business_glossary_term' = 'Net Occupancy Estimate');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `outbound_count` SET TAGS ('dbx_business_glossary_term' = 'Outbound Count');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `peak_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Peak Occupancy');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `sensor_device_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor Device ID');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `sensor_device_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `sensor_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `sensor_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `sensor_type` SET TAGS ('dbx_business_glossary_term' = 'Sensor Type');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `sensor_type` SET TAGS ('dbx_value_regex' = 'thermal|video_analytics|infrared|rfid|wifi_tracking|bluetooth_beacon');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Fahrenheit)');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `weather_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition Code');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type');
ALTER TABLE `retail_ecm`.`store`.`traffic_count` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'entrance|department|checkout|aisle|endcap|gondola');
ALTER TABLE `retail_ecm`.`store`.`pl` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`store`.`pl` SET TAGS ('dbx_subdomain' = 'financial_performance');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `pl_id` SET TAGS ('dbx_business_glossary_term' = 'Store Profit & Loss (P&L) ID');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period ID');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `merch_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Merch Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `atv_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Transaction Value (ATV) Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `comp_sales_flag` SET TAGS ('dbx_business_glossary_term' = 'Comparable Store Sales (Comp Sales) Flag');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `comp_sales_growth_percent` SET TAGS ('dbx_business_glossary_term' = 'Comparable Store Sales (Comp Sales) Growth Percent');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `discounts_amount` SET TAGS ('dbx_business_glossary_term' = 'Discounts Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `ebitda_amount` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest, Taxes, Depreciation, and Amortization (EBITDA) Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `ebitda_percent` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest, Taxes, Depreciation, and Amortization (EBITDA) Percent');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finalized Timestamp');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `gross_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percent');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Sales Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `marketing_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Marketing Expense Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `net_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Sales Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Profit & Loss (P&L) Notes');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `occupancy_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Cost Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `pl_status` SET TAGS ('dbx_business_glossary_term' = 'Profit & Loss (P&L) Status');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `pl_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|restated');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `reporting_entity` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `returns_amount` SET TAGS ('dbx_business_glossary_term' = 'Returns Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `shrinkage_amount` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `supply_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Supply Expense Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `total_operating_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Operating Expense Amount');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`store`.`pl` ALTER COLUMN `upt` SET TAGS ('dbx_business_glossary_term' = 'Units Per Transaction (UPT)');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` SET TAGS ('dbx_subdomain' = 'financial_performance');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `shrinkage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Event ID');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment Transaction ID');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Store Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `case_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Loss Prevention (LP) Case Reference Number');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `cost_value_lost` SET TAGS ('dbx_business_glossary_term' = 'Cost Value Lost');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'pos_exception|cycle_count|physical_inventory|rfid_scan|lp_investigation|vendor_audit');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Event Date');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Event Number');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^SHR-[0-9]{10}$');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Event Timestamp');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-Q[1-4]$|^[0-9]{4}-[0-9]{2}$');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `incident_report_filed` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Filed Flag');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `inventory_adjustment_posted` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment Posted Flag');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Event Notes');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `police_report_number` SET TAGS ('dbx_business_glossary_term' = 'Police Report Number');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `quantity_lost` SET TAGS ('dbx_business_glossary_term' = 'Quantity Lost');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `recovery_method` SET TAGS ('dbx_value_regex' = 'merchandise_recovered|restitution|insurance_claim|vendor_credit|chargeback|none');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|resolved|closed_unresolved|recovered');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'external|employee|vendor|unknown|not_applicable');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `shrinkage_type` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Type');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `shrinkage_type` SET TAGS ('dbx_value_regex' = 'external_theft|internal_theft|administrative_error|vendor_fraud|damage|unknown');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `total_retail_value_lost` SET TAGS ('dbx_business_glossary_term' = 'Total Retail Value Lost');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pound|kilogram|liter|gallon');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `unit_retail_value` SET TAGS ('dbx_business_glossary_term' = 'Unit Retail Value');
ALTER TABLE `retail_ecm`.`store`.`shrinkage_event` ALTER COLUMN `zone_location` SET TAGS ('dbx_business_glossary_term' = 'Zone Location');
ALTER TABLE `retail_ecm`.`store`.`department` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`store`.`department` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Store Department ID');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `buyer_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `department_status` SET TAGS ('dbx_business_glossary_term' = 'Department Status');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `department_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|seasonal_closed|remodeling|pending_closure');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `department_type` SET TAGS ('dbx_business_glossary_term' = 'Department Type');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `endcap_count` SET TAGS ('dbx_business_glossary_term' = 'Endcap Count');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `fixture_count` SET TAGS ('dbx_business_glossary_term' = 'Fixture Count');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `gondola_count` SET TAGS ('dbx_business_glossary_term' = 'Gondola Count');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `gross_margin_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Target Percent');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `gross_margin_target_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `labor_budget_monthly` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Monthly');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `labor_budget_monthly` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Department Notes');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `omnichannel_fulfillment_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Omnichannel Fulfillment Enabled Flag');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `planogram_count` SET TAGS ('dbx_business_glossary_term' = 'Planogram (POG) Count');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `pos_terminal_count` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal Count');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `sales_target_monthly` SET TAGS ('dbx_business_glossary_term' = 'Sales Target Monthly');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `sales_target_monthly` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `selling_area_sq_ft` SET TAGS ('dbx_business_glossary_term' = 'Selling Area Square Feet');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `shrinkage_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Rate Percent');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `shrinkage_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `temperature_range_max_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum Fahrenheit');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `temperature_range_min_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum Fahrenheit');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `visual_merchandising_standard` SET TAGS ('dbx_business_glossary_term' = 'Visual Merchandising Standard');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `retail_ecm`.`store`.`department` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` SET TAGS ('dbx_subdomain' = 'store_operations');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `sfs_fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-from-Store (SFS) Fulfillment Node ID');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `average_pack_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Pack Time Minutes');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `average_pick_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Pick Time Minutes');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `carrier_account_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Account Number');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `carrier_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `cost_per_order` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Order');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `cost_per_order` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `daily_capacity_orders` SET TAGS ('dbx_business_glossary_term' = 'Daily Capacity Orders');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `daily_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Daily Capacity Units');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `inventory_sync_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inventory Synchronization Frequency Minutes');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `next_day_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Next-Day Delivery Cutoff Time');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Code');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Name');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Type');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `node_type` SET TAGS ('dbx_value_regex' = 'ship_from_store|dark_store|micro_fulfillment_center|hybrid');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `oms_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Order Management System (OMS) Integration Enabled');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing|decommissioned');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `picking_zone_count` SET TAGS ('dbx_business_glossary_term' = 'Picking Zone Count');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `picking_zone_identifiers` SET TAGS ('dbx_business_glossary_term' = 'Picking Zone Identifiers');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `primary_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Carrier Code');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `same_day_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Same-Day Delivery Cutoff Time');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `service_postal_codes` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Codes');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `service_radius_km` SET TAGS ('dbx_business_glossary_term' = 'Service Radius Kilometers');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `supports_bopis` SET TAGS ('dbx_business_glossary_term' = 'Supports Buy Online Pick Up In Store (BOPIS)');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `supports_curbside_pickup` SET TAGS ('dbx_business_glossary_term' = 'Supports Curbside Pickup');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `supports_next_day_delivery` SET TAGS ('dbx_business_glossary_term' = 'Supports Next-Day Delivery');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `supports_same_day_delivery` SET TAGS ('dbx_business_glossary_term' = 'Supports Same-Day Delivery');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`store`.`sfs_fulfillment_node` ALTER COLUMN `wms_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Integration Enabled');
ALTER TABLE `retail_ecm`.`store`.`license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`store`.`license` SET TAGS ('dbx_subdomain' = 'financial_performance');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'Store License ID');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `renewed_from_license_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `inspection_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Months');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `last_violation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Violation Date');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `reinstatement_conditions` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Conditions');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `reinstatement_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Eligible Flag');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `renewal_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Lead Time Days');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `retail_ecm`.`store`.`license` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
