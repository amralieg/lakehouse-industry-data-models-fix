-- Schema for Domain: dealer | Business: Automotive | Version: v2_mvm
-- Generated on: 2026-06-23 06:00:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`dealer` COMMENT 'Dealer network management including dealer profiles, franchise agreements, territory assignments, and dealer performance scorecards. Manages dealer inventory allocation, vehicle allocation rules, dealer incentive programs, and DMS (Dealer Management System) integration. Tracks dealer sales performance, customer satisfaction scores, service capacity, and parts inventory at dealer locations. Supports both OEM-owned and independent franchise dealer models. Integrates with CDK Global DMS.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`dealer`.`dealership` (
    `dealership_id` BIGINT COMMENT 'Unique surrogate identifier for each dealer location in the OEM franchise network. Primary key for the dealership master record and the enterprise Single Source of Truth (SSOT) for dealer identity.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Dealerships operate under jurisdiction-specific franchise laws, dealer licensing requirements, and consumer protection regulations. Linking dealership to jurisdiction enables franchise law compliance ',
    `activation_date` DATE COMMENT 'Date on which the dealership was formally activated in the OEM dealer network and became eligible to receive vehicle allocations and participate in OEM programs.',
    `adas_certified` BOOLEAN COMMENT 'Indicates whether the dealership is certified to perform Advanced Driver Assistance Systems (ADAS) calibration and repair. Required for servicing vehicles equipped with cameras, radar, and LiDAR-based safety systems.',
    `address_line1` STRING COMMENT 'Primary street address of the dealership physical location. Used for logistics, customer navigation, regulatory filings, and Pre-Delivery Inspection (PDI) vehicle delivery coordination.',
    `address_line2` STRING COMMENT 'Secondary address line for the dealership (suite, unit, building number). Supplements address_line1 for precise location identification.',
    `cdk_dealer_code` STRING COMMENT 'Unique dealer identifier assigned within the CDK Global Dealer Management System (DMS). This is the integration key used for all data exchanges between the OEM lakehouse and the CDK DMS platform including inventory, F&I, and service scheduling feeds.. Valid values are `^[A-Z0-9]{4,20}$`',
    `channel_classification` STRING COMMENT 'Categorizes the dealers primary sales channel model. Retail covers traditional showroom sales; fleet covers B2B volume sales; agency model covers OEM-set pricing arrangements; export covers cross-border sales points.. Valid values are `retail|fleet|wholesale|online|agency|export`',
    `city` STRING COMMENT 'City in which the dealership is physically located. Used for geographic market analysis, territory assignment, and customer proximity reporting.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country in which the dealership is physically located (e.g., USA, CAN, MEX, GBR, DEU). Drives regulatory compliance, currency, and tax treatment.. Valid values are `^[A-Z]{3}$`',
    `deactivation_date` DATE COMMENT 'Date on which the dealership was deactivated or terminated from the OEM dealer network. Nullable for currently active dealers. Used for franchise termination tracking and regulatory reporting.',
    `dealer_code` STRING COMMENT 'Externally-known alphanumeric code assigned by the OEM to uniquely identify the dealer location across all enterprise systems including SAP SD, CDK Global DMS, and Salesforce Automotive Cloud. Used on all inter-system communications, vehicle allocations, and incentive programs.. Valid values are `^[A-Z0-9]{4,12}$`',
    `dealer_status` STRING COMMENT 'Current lifecycle status of the dealership within the OEM franchise network. Controls eligibility for vehicle allocation, incentive programs, and DMS integration. [ENUM-REF-CANDIDATE: active|inactive|suspended|pending_approval|terminated|under_review — promote to reference product]. Valid values are `active|inactive|suspended|pending_approval|terminated|under_review`',
    `dealer_tier` STRING COMMENT 'OEM-assigned performance tier classification for the dealership based on annual sales volume, customer satisfaction scores, and compliance metrics. Determines eligibility for premium vehicle allocations, co-op marketing funds, and incentive program tiers.. Valid values are `platinum|gold|silver|bronze|standard`',
    `dms_go_live_date` DATE COMMENT 'Date on which the CDK Global DMS integration for this dealership went live and began transmitting data to the OEM enterprise systems. Used for integration tenure tracking and data completeness assessments.',
    `dms_integration_status` STRING COMMENT 'Current status of the CDK Global DMS data integration feed for this dealership. Indicates whether real-time inventory, sales, and service data is flowing correctly into the OEM lakehouse.. Valid values are `active|inactive|pending_setup|error|suspended`',
    `ev_certified` BOOLEAN COMMENT 'Indicates whether the dealership has completed OEM Electric Vehicle (EV) certification requirements including technician training, charging infrastructure installation, and EV-specific tooling. Required for allocation of BEV and PHEV models.',
    `ev_charger_count` STRING COMMENT 'Number of EV charging stations installed at the dealership for customer and demo vehicle use. Relevant for EV certification compliance and customer experience reporting.',
    `franchise_agreement_number` STRING COMMENT 'Reference number of the active franchise agreement between the OEM and the dealer entity. Used to link the dealership master record to the franchise agreement contract for legal and compliance purposes.',
    `franchise_expiry_date` DATE COMMENT 'Date on which the current franchise agreement is scheduled to expire or must be renewed. Nullable for perpetual agreements. Triggers renewal workflow when within the notice period.',
    `franchise_start_date` DATE COMMENT 'Date on which the current franchise agreement between the OEM and the dealer became effective. Used for tenure calculations, renewal scheduling, and performance baseline setting.',
    `franchise_type` STRING COMMENT 'Classification of the dealers franchise arrangement with the OEM. Distinguishes OEM-owned (captive) outlets from independent franchise dealers, authorized repairers, fleet-only points, used vehicle specialists, and satellite locations. [ENUM-REF-CANDIDATE: oem_owned|independent_franchise|authorized_repairer|fleet_only|used_vehicle_only|satellite — promote to reference product]. Valid values are `oem_owned|independent_franchise|authorized_repairer|fleet_only|used_vehicle_only|satellite`',
    `home_delivery_enabled_flag` BOOLEAN COMMENT 'Whether this dealership supports home delivery to customers.',
    `last_mile_delivery_radius_km` DECIMAL(18,2) COMMENT 'Maximum delivery radius in km for home delivery from this dealership.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (WGS 84 decimal degrees) of the dealership location. Enables spatial analytics, territory mapping, and customer proximity calculations for dealer locator services.',
    `legal_name` STRING COMMENT 'Full registered legal name of the dealer entity as recorded with the relevant state or national business registry. Used for franchise agreements, regulatory filings, and financial settlements.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (WGS 84 decimal degrees) of the dealership location. Enables spatial analytics, territory mapping, and customer proximity calculations for dealer locator services.',
    `lot_capacity` STRING COMMENT 'Maximum number of vehicles that can be stored on the dealer lot (outdoor inventory storage). Used for vehicle allocation limits, inventory aging analysis, and logistics planning.',
    `market_region_code` STRING COMMENT 'OEM-defined market region code to which this dealership belongs (e.g., NORTHEAST, MIDWEST, SOUTHWEST, WEST, SOUTHEAST). Used for territory management, regional incentive programs, and sales performance reporting.. Valid values are `^[A-Z]{2,10}$`',
    `new_vehicle_sales_capacity` STRING COMMENT 'OEM-assessed annual new vehicle sales capacity (unit count) for this dealership based on facility size, staffing, and market area. Used as the denominator for allocation planning and sales target setting.',
    `oem_brand_codes` STRING COMMENT 'Pipe-delimited list of OEM brand codes (e.g., BRAND_A|BRAND_B) that this dealership is franchised to sell and service. A single dealer point may hold multi-brand authorizations (e.g., passenger car and commercial vehicle brands).',
    `ownership_group_name` STRING COMMENT 'Name of the dealer group or automotive retail group that owns this dealership location (e.g., AutoNation, Penske, Lithia). Enables group-level performance aggregation, consolidated incentive calculations, and multi-point dealer management.',
    `parts_warehouse_area_sqm` DECIMAL(18,2) COMMENT 'Total floor area in square metres of the dealerships parts storage facility. Used for parts inventory capacity planning, MRP replenishment calculations, and Just-in-Time (JIT) parts delivery scheduling.',
    `pdi_certified` BOOLEAN COMMENT 'Indicates whether the dealership is certified to perform Pre-Delivery Inspection (PDI) on new vehicles prior to customer handover. PDI certification is required for new vehicle delivery authorization.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the dealerships physical location. Used for geographic market segmentation, territory boundary analysis, and customer catchment area reporting.. Valid values are `^[A-Z0-9 -]{3,10}$`',
    `primary_email` STRING COMMENT 'Primary business email address for the dealership used for OEM communications, vehicle allocation notifications, incentive program updates, and Technical Service Bulletin (TSB) distribution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Main switchboard or primary contact telephone number for the dealership. Used for OEM-to-dealer communications, customer service escalations, and directory listings.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `principal_contact_email` STRING COMMENT 'Email address of the primary OEM relationship contact at the dealership. Used for franchise communications, incentive program notifications, and regulatory bulletin distribution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `principal_contact_name` STRING COMMENT 'Full name of the primary OEM relationship contact at the dealership (typically the Dealer Principal or General Manager). Used for OEM communications, franchise agreement correspondence, and escalation routing.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dealership master record was first created in the enterprise data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trail, and record age analysis.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dealership master record in the enterprise data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change detection, data freshness monitoring, and audit compliance.',
    `sales_district_code` STRING COMMENT 'OEM-defined sales district code representing the sub-regional territory assignment for this dealership. Used for district sales manager (DSM) alignment, vehicle allocation quotas, and performance benchmarking.. Valid values are `^[A-Z0-9]{2,10}$`',
    `sap_customer_number` STRING COMMENT 'SAP S/4HANA customer master number (SD module) assigned to this dealership for vehicle order processing, invoicing, and financial settlement. Links dealership to SAP SD sales orders and FI accounts receivable.. Valid values are `^[0-9]{6,10}$`',
    `service_bay_count` STRING COMMENT 'Total number of service bays available at the dealership for vehicle maintenance and repair operations. Used for after-sales capacity planning, warranty repair throughput analysis, and service scheduling optimization.',
    `showroom_display_capacity` STRING COMMENT 'Maximum number of vehicles that can be displayed simultaneously in the dealership showroom. Used for vehicle allocation planning, demo fleet sizing, and facility investment decisions.',
    `state_province_code` STRING COMMENT 'ISO 3166-2 state or province code for the dealerships physical location (e.g., CA, TX, NY, ON). Used for CAFE compliance reporting, CARB emissions zone classification, and state-level dealer franchise law compliance.. Valid values are `^[A-Z]{2,5}$`',
    `trading_name` STRING COMMENT 'The public-facing doing business as (DBA) name of the dealership as displayed to customers, on signage, and in marketing materials. May differ from the legal entity name.',
    `used_vehicle_sales_capacity` STRING COMMENT 'OEM-assessed annual used vehicle sales capacity (unit count) for this dealership. Used for certified pre-owned (CPO) program eligibility and used vehicle allocation planning.',
    `warranty_authorized` BOOLEAN COMMENT 'Indicates whether the dealership is authorized to perform OEM warranty repairs and submit warranty claims. Drives warranty claim processing eligibility in SAP and CDK DMS.',
    `website_url` STRING COMMENT 'Public-facing website URL for the dealership. Used for digital marketing integration, online inventory syndication, and customer-facing dealer locator services.. Valid values are `^https?://[^s]{3,255}$`',
    `yard_slot_capacity` STRING COMMENT 'Number of vehicle storage slots available at the dealership yard.',
    CONSTRAINT pk_dealership PRIMARY KEY(`dealership_id`)
) COMMENT 'Master record for each dealer location in the OEM franchise network. Captures dealer legal entity, DMS (Dealer Management System) integration identifiers (CDK Global), franchise type (OEM-owned vs independent), physical address, contact details, operational status, market region, and channel classification. This is the SSOT for dealer identity across the enterprise.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` (
    `franchise_agreement_id` BIGINT COMMENT 'Unique identifier for the franchise agreement record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: franchise_agreement.governing_law_jurisdiction is a denormalized reference to jurisdiction. Franchise agreements are governed by specific jurisdictions dealer franchise laws. Normalizing to jurisdict',
    `dealership_id` BIGINT COMMENT 'Reference to the dealer entity that is party to this franchise agreement.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Franchise agreements are governed by jurisdiction-specific dealer franchise protection laws and regulatory requirements. OEM legal/compliance teams must ensure franchise agreement terms comply with ap',
    `warranty_policy_id` BIGINT COMMENT 'Foreign key linking to aftersales.warranty_policy. Business justification: OEM franchise agreements govern which warranty policies a dealer is authorized to administer. warranty_administration_authorized_flag and recall_service_authorized_flag on franchise_agreement require ',
    `agreement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all financial terms in the franchise agreement (quotas, fees, investment requirements). Example: USD, EUR, JPY.. Valid values are `^[A-Z]{3}$`',
    `agreement_document_url` STRING COMMENT 'Secure URL or file path to the digitally stored franchise agreement contract document (PDF or scanned image).',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the franchise agreement, typically including dealer name and location.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the franchise agreement. Format: FA-NNNNNNNN.. Valid values are `^FA-[0-9]{8}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the franchise agreement: draft (being negotiated), pending approval (awaiting OEM sign-off), active (in force), suspended (temporarily inactive), terminated (ended before expiration), or expired (reached end date).. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `agreement_type` STRING COMMENT 'Classification of the franchise agreement based on its purpose: new franchise grant, renewal of existing agreement, amendment to terms, territory expansion, or termination agreement.. Valid values are `new_franchise|renewal|amendment|expansion|termination`',
    `allocation_priority_tier` STRING COMMENT 'Priority tier for vehicle inventory allocation. Higher tiers receive preferential allocation of high-demand models and limited-production vehicles. Tier 1 = highest priority.. Valid values are `tier_1|tier_2|tier_3|tier_4|standard`',
    `authorized_nameplates` STRING COMMENT 'Comma-separated list of vehicle nameplates (brands, model lines) that the dealer is authorized to sell under this franchise agreement. Examples: Sedan, SUV, Truck, EV (Electric Vehicle), HEV (Hybrid Electric Vehicle).',
    `authorized_vehicle_lines` STRING COMMENT 'Specific vehicle lines or series the dealer is authorized to sell, such as luxury, commercial, electric, or performance segments.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the franchise agreement automatically renews at expiration unless either party provides notice. True = auto-renews, False = requires explicit renewal.',
    `certified_pre_owned_authorized_flag` BOOLEAN COMMENT 'Indicates whether the dealer is authorized to sell OEM-certified pre-owned vehicles under the manufacturers CPO program. True = authorized, False = not authorized.',
    `commercial_fleet_authorized_flag` BOOLEAN COMMENT 'Indicates whether the dealer is authorized to sell vehicles to commercial fleet customers and participate in fleet sales programs. True = authorized, False = not authorized.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this franchise agreement record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_satisfaction_target_score` DECIMAL(18,2) COMMENT 'Minimum Net Promoter Score (NPS) or customer satisfaction score the dealer must achieve to maintain franchise agreement in good standing. Typically measured on a scale of 0-100.',
    `dealer_signatory_name` STRING COMMENT 'Full name of the dealer authorized representative (typically dealer principal or owner) who signed the franchise agreement.',
    `digital_retailing_required_flag` BOOLEAN COMMENT 'Indicates whether the dealer must offer digital retailing capabilities (online sales, virtual showroom, e-commerce) as required by the franchise agreement. True = required, False = optional.',
    `dms_integration_required_flag` BOOLEAN COMMENT 'Indicates whether the dealer must integrate their DMS (Dealer Management System) with OEM systems for real-time inventory, sales, and service data sharing. True = required, False = optional.',
    `effective_date` DATE COMMENT 'Date when the franchise agreement becomes legally binding and operational. Marks the start of the dealers franchise rights and obligations.',
    `ev_charging_infrastructure_required_flag` BOOLEAN COMMENT 'Indicates whether the dealer must install and maintain EV (Electric Vehicle) charging infrastructure at their facility as a condition of selling electric or hybrid vehicles. True = required, False = optional.',
    `exclusive_territory_flag` BOOLEAN COMMENT 'Indicates whether the dealer has exclusive rights to sell in the assigned territory. True = exclusive (no other dealers in territory), False = non-exclusive (shared territory).',
    `expiration_date` DATE COMMENT 'Date when the franchise agreement is scheduled to end. Nullable for open-ended or perpetual agreements subject to performance review.',
    `facility_investment_requirement_amount` DECIMAL(18,2) COMMENT 'Minimum capital expenditure (CapEx) the dealer must invest in facility improvements, showroom standards, service equipment, and infrastructure to meet OEM brand standards.',
    `franchise_tier` STRING COMMENT 'Tier or level of the franchise agreement indicating dealer status, privileges, and performance expectations. Higher tiers typically receive preferential allocation and incentives.. Valid values are `platinum|gold|silver|bronze|standard`',
    `home_delivery_obligation_flag` BOOLEAN COMMENT 'Whether the franchise agreement requires home delivery capability.',
    `incentive_program_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the dealer is eligible to participate in OEM dealer incentive programs, volume bonuses, and performance rewards. True = eligible, False = not eligible.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this franchise agreement record was last updated in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `minimum_sales_quota_annual` STRING COMMENT 'Minimum number of vehicle units the dealer must sell annually to maintain franchise agreement in good standing. Performance obligation defined in agreement.',
    `minimum_service_capacity` STRING COMMENT 'Minimum number of vehicles the dealer must be capable of servicing per month to meet franchise agreement service obligations.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate or not renew the franchise agreement. Typical values are 30, 60, 90, or 180 days.',
    `oem_signatory_name` STRING COMMENT 'Full name of the OEM authorized representative who signed the franchise agreement on behalf of the manufacturer.',
    `ownership_model` STRING COMMENT 'Classification of dealer ownership structure: OEM (Original Equipment Manufacturer) owned, independent franchise, joint venture, or corporate store.. Valid values are `oem_owned|independent_franchise|joint_venture|corporate_store`',
    `parts_inventory_requirement_amount` DECIMAL(18,2) COMMENT 'Minimum dollar value of OEM (Original Equipment Manufacturer) parts inventory the dealer must maintain at all times to meet franchise agreement obligations.',
    `performance_review_frequency` STRING COMMENT 'Frequency at which the OEM conducts formal performance reviews of the dealer against franchise agreement obligations and performance metrics.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `recall_service_authorized_flag` BOOLEAN COMMENT 'Indicates whether the dealer is authorized to perform recall repairs and service campaigns issued by the OEM or NHTSA (National Highway Traffic Safety Administration). True = authorized, False = not authorized.',
    `renewal_date` DATE COMMENT 'Date when the franchise agreement was last renewed or is scheduled for renewal review. Used for tracking renewal cycles.',
    `renewal_term_months` STRING COMMENT 'Duration in months for each renewal period of the franchise agreement. Typical values are 12, 24, 36, or 60 months.',
    `signed_date` DATE COMMENT 'Date when the franchise agreement was formally signed by both the dealer and OEM authorized representatives, making it legally binding.',
    `termination_date` DATE COMMENT 'Actual date when the franchise agreement was terminated, if applicable. Populated only for agreements that ended before their scheduled expiration.',
    `termination_reason` STRING COMMENT 'Detailed explanation of why the franchise agreement was terminated early, including performance issues, dealer request, market consolidation, or regulatory compliance.',
    `territory_description` STRING COMMENT 'Textual description of the geographic territory assigned to the dealer under this franchise agreement, including cities, counties, postal codes, or radius from dealer location.',
    `territory_radius_km` DECIMAL(18,2) COMMENT 'Radius in kilometers from the dealers primary location defining the franchise territory boundary, if territory is defined by radius rather than geographic boundaries.',
    `training_certification_required_flag` BOOLEAN COMMENT 'Indicates whether dealer staff must complete OEM-mandated training and certification programs as a condition of the franchise agreement. True = required, False = optional.',
    `warranty_administration_authorized_flag` BOOLEAN COMMENT 'Indicates whether the dealer is authorized to process and submit warranty claims on behalf of customers under OEM warranty programs. True = authorized, False = not authorized.',
    CONSTRAINT pk_franchise_agreement PRIMARY KEY(`franchise_agreement_id`)
) COMMENT 'Formal franchise contract between the OEM and an independent or OEM-owned dealer. Tracks agreement effective dates, expiration, renewal terms, franchise tier, authorized vehicle lines (nameplates), territory rights, performance obligations, and agreement status. Supports both new franchise grants and renewals.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`dealer`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique identifier for the dealer territory assignment. Primary key.',
    `franchise_agreement_id` BIGINT COMMENT 'Reference to the franchise agreement that governs this territory assignment. Links territory rights to contractual terms.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Territory planning aligns with the legal jurisdiction for emissions and safety regulations; linking enables jurisdiction‑specific reporting.',
    `dealership_id` BIGINT COMMENT 'Reference to the dealership that owns or is assigned this territory.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to product.product_segment. Business justification: OEM territory planning assigns each dealer territory to a product segment (e.g., EV, truck, luxury) for allocation quotas and market coverage analysis. market_segment_classification is a denormalized ',
    `allocation_quota_percentage` DECIMAL(18,2) COMMENT 'Percentage of regional or national vehicle allocation assigned to this territory. Sum of all territory percentages within a region should equal 100.',
    `approval_date` DATE COMMENT 'Date when the territory assignment or modification was formally approved by OEM (Original Equipment Manufacturer) management.',
    `approved_by` STRING COMMENT 'Name or identifier of the OEM (Original Equipment Manufacturer) executive or manager who approved this territory assignment or modification.',
    `city_list` STRING COMMENT 'Comma-separated list of cities or municipalities included in the territory coverage area.',
    `territory_code` STRING COMMENT 'Unique alphanumeric code identifying the territory within the dealer network. Used for vehicle allocation and market planning.. Valid values are `^[A-Z0-9]{3,12}$`',
    `competitive_intensity_rating` STRING COMMENT 'Assessment of competitive pressure within the territory based on number of competing brands, dealer density, and market saturation.. Valid values are `low|medium|high|very_high`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the territory location (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `county_region` STRING COMMENT 'County, district, or regional subdivision name within the state/province that defines part of the territory boundary.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory assignment record was first created in the system. Audit trail for data lineage.',
    `dms_integration_status` STRING COMMENT 'Status of territory data synchronization with the dealers DMS (Dealer Management System), specifically CDK Global DMS. Indicates whether territory boundaries are reflected in dealer systems.. Valid values are `integrated|pending|failed|not_applicable`',
    `dms_last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the last successful synchronization of territory data with the dealers DMS (Dealer Management System). Used to monitor data freshness and integration health.',
    `effective_end_date` DATE COMMENT 'Date when the territory assignment expires or is terminated. Null indicates an open-ended assignment.',
    `effective_start_date` DATE COMMENT 'Date when the territory assignment becomes active and the dealer assumes responsibility for the defined area.',
    `geographic_boundary_description` STRING COMMENT 'Textual description of territory boundaries using landmarks, highways, or natural features (e.g., North of I-40, East of Highway 101).',
    `home_delivery_coverage_flag` BOOLEAN COMMENT 'Whether home delivery is available in this territory.',
    `household_count_estimate` STRING COMMENT 'Estimated number of households within the territory. Used for market penetration analysis and vehicle allocation planning.',
    `incentive_program_eligibility_flag` BOOLEAN COMMENT 'Indicates whether dealers in this territory are eligible for special OEM (Original Equipment Manufacturer) incentive programs or bonuses. True = eligible; False = not eligible.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory assignment record was last updated. Tracks the most recent change to any field in the record.',
    `last_review_date` DATE COMMENT 'Date when the territory assignment was last reviewed or audited by OEM (Original Equipment Manufacturer) management. Used to track compliance with periodic review requirements.',
    `manager_email` STRING COMMENT 'Email address of the OEM (Original Equipment Manufacturer) territory manager. Used for dealer communications and escalations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `manager_name` STRING COMMENT 'Name of the OEM (Original Equipment Manufacturer) regional or territory manager responsible for overseeing this territory and dealer relationship.',
    `manager_phone` STRING COMMENT 'Contact phone number for the OEM (Original Equipment Manufacturer) territory manager.',
    `modification_reason` STRING COMMENT 'Business justification for the most recent change to the territory assignment (e.g., market expansion, dealer consolidation, performance adjustment).',
    `territory_name` STRING COMMENT 'Business-friendly name or description of the territory (e.g., Metro East Region, Downtown District).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next territory assignment review. Ensures regular evaluation of territory boundaries and dealer performance.',
    `overlap_allowed_flag` BOOLEAN COMMENT 'Indicates whether this territory can overlap with other dealer territories. True allows shared coverage; False enforces exclusive boundaries.',
    `overlap_rule_description` STRING COMMENT 'Business rules governing how overlapping territories are managed, including priority rules, customer assignment logic, and conflict resolution procedures.',
    `performance_benchmark_group` STRING COMMENT 'Peer group or cohort used for dealer performance benchmarking. Territories with similar characteristics are grouped for fair comparison.',
    `population_estimate` STRING COMMENT 'Estimated total population within the territory boundaries. Used for market sizing and dealer performance benchmarking.',
    `postal_code_list` STRING COMMENT 'Comma-separated or range-based list of postal/zip codes included in the territory (e.g., 90001-90099,91000). Used for precise geographic allocation.',
    `primary_area_of_responsibility` STRING COMMENT 'Geographic description of the core territory where the dealer has primary sales and service responsibility. May include city names, county boundaries, or regional descriptors.',
    `sales_potential_index` DECIMAL(18,2) COMMENT 'Numeric index representing the relative sales potential of the territory compared to a baseline (e.g., 100 = average, 150 = 50% above average). Used for vehicle allocation and quota setting.',
    `special_program_notes` STRING COMMENT 'Free-text notes describing any special programs, pilot initiatives, or unique conditions applicable to this territory (e.g., EV (Electric Vehicle) launch market, rural incentive zone).',
    `state_province_code` STRING COMMENT 'Two or three-letter code for the state, province, or administrative region (e.g., CA, TX, ON).. Valid values are `^[A-Z]{2,3}$`',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory assignment. Active territories are operational; pending awaits approval; suspended is temporarily halted; terminated is closed.. Valid values are `active|inactive|pending|suspended|under_review|terminated`',
    `territory_type` STRING COMMENT 'Classification of territory assignment model: exclusive (single dealer), shared (multiple dealers), open (no restrictions), primary (main responsibility), secondary (backup coverage), overlay (special program).. Valid values are `exclusive|shared|open|primary|secondary|overlay`',
    `vehicle_allocation_priority` STRING COMMENT 'Priority ranking for vehicle inventory allocation to this territory. Lower numbers indicate higher priority. Used during supply constraints.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Geographic sales territory assigned to a dealership. Defines primary area of responsibility (PAR), zip/postal code coverage, county or region boundaries, territory type (exclusive, shared, open), effective dates, and overlap rules. Used for vehicle allocation, market representation planning, and dealer performance benchmarking.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`dealer`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique identifier for the dealer certification record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Dealer certifications are jurisdiction-specific (e.g., California ZEV mandate, federal NHTSA requirements). Compliance reporting requires linking certifications to the issuing jurisdiction for regulat',
    `dealership_id` BIGINT COMMENT 'Reference to the dealership that holds this certification. Links to the dealer master record.',
    `regulatory_body_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_body. Business justification: dealer_certification.issuing_body and issuing_body_type are denormalized representations of regulatory_body. OEM compliance teams track which regulatory body issued each dealer certification for renew',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Dealer certifications (EV, ADAS, CPO) are mandated by specific regulatory requirements. OEM compliance teams map dealer certifications to regulatory requirements for audit reporting and renewal tracki',
    `segment_id` BIGINT COMMENT 'Foreign key linking to product.product_segment. Business justification: Dealer certifications (EV-certified, ADAS-certified) are scoped to specific product segments. OEM certification programs require linking each certification to the product segment it authorizes (e.g., ',
    `allocation_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this certification makes the dealer eligible for preferential vehicle allocation (e.g., EV-certified dealers receive priority allocation of electric vehicles).',
    `annual_maintenance_cost_amount` DECIMAL(18,2) COMMENT 'Estimated annual cost to maintain this certification, including renewal fees, ongoing training, and audit costs. Expressed in the OEMs reporting currency.',
    `audit_outcome` STRING COMMENT 'Result of the most recent audit (e.g., passed, passed with conditions, failed). Determines whether certification remains in good standing.. Valid values are `PASSED|PASSED_WITH_CONDITIONS|FAILED|NOT_APPLICABLE`',
    `audit_required_flag` BOOLEAN COMMENT 'Indicates whether the dealer must undergo periodic audits to maintain this certification.',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score or rating achieved in the most recent audit (e.g., 0-100 scale, or percentage). Reflects compliance quality and performance.',
    `certification_number` STRING COMMENT 'Unique alphanumeric identifier assigned by the issuing body for this certification. Externally-known business identifier.. Valid values are `^[A-Z0-9]{8,20}$`',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Determines whether the dealer is currently authorized under this certification program.. Valid values are `ACTIVE|EXPIRED|SUSPENDED|PENDING_RENEWAL|REVOKED|UNDER_REVIEW`',
    `certification_type` STRING COMMENT 'Category of certification awarded to the dealer. Defines the specialized capability or program enrollment (e.g., EV-certified dealer, ADAS service authorization, luxury brand certification).. Valid values are `EV_CERTIFIED|ADAS_SERVICE|LUXURY_BRAND|COMMERCIAL_VEHICLE|HYBRID_SPECIALIST|PERFORMANCE_TUNING`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred by the dealer to obtain this certification, including training, equipment, facility upgrades, and application fees. Expressed in the OEMs reporting currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date from which the certification becomes active and the dealer is authorized to operate under this certification. May differ from issue date if there is a grace period.',
    `equipment_requirements` STRING COMMENT 'Description of specialized tools, diagnostic equipment, or technology the dealer must possess for this certification (e.g., high-voltage battery diagnostic tools, ADAS radar calibration systems).',
    `expiry_date` DATE COMMENT 'Date when the certification expires and the dealer must renew to maintain authorization. Nullable for certifications with no expiration.',
    `facility_requirements` STRING COMMENT 'Description of physical facility requirements the dealer must meet for this certification (e.g., dedicated EV charging bays, ADAS calibration equipment, climate-controlled service area).',
    `geographic_scope` STRING COMMENT 'Geographic coverage level of this certification (e.g., global, regional, national, state/provincial, local). Defines where the certification is recognized.. Valid values are `GLOBAL|REGIONAL|NATIONAL|STATE_PROVINCIAL|LOCAL`',
    `home_delivery_certified_flag` BOOLEAN COMMENT 'Whether the dealer is certified for home delivery operations.',
    `incentive_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this certification qualifies the dealer for special incentive programs, rebates, or performance bonuses.',
    `issue_date` DATE COMMENT 'Date when the certification was originally issued to the dealer. Marks the start of the certification validity period.',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit conducted for this certification. Used to track audit compliance and schedule next audit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was most recently updated. Audit trail for data lineage and change tracking.',
    `last_renewal_date` DATE COMMENT 'Date of the most recent renewal or recertification event. Tracks ongoing compliance and re-qualification.',
    `certification_level` STRING COMMENT 'Tier or grade of certification achieved by the dealer within a tiered program (e.g., Bronze, Silver, Gold, Platinum). Higher levels may unlock additional benefits.. Valid values are `BRONZE|SILVER|GOLD|PLATINUM|ELITE|STANDARD`',
    `minimum_certified_technicians` STRING COMMENT 'Minimum number of technicians who must hold individual certification credentials for the dealer to maintain this certification.',
    `certification_name` STRING COMMENT 'Full descriptive name of the certification program or credential (e.g., Electric Vehicle Sales and Service Certification, Advanced Driver Assistance Systems Authorized Service Center).',
    `next_audit_due_date` DATE COMMENT 'Date by which the next audit must be completed to maintain certification compliance.',
    `next_renewal_due_date` DATE COMMENT 'Date by which the dealer must complete renewal requirements to maintain active certification status. Used for proactive renewal management.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or contextual information about this certification record.',
    `personnel_requirements` STRING COMMENT 'Description of staffing requirements for this certification (e.g., minimum number of certified technicians, specific role qualifications, training credentials).',
    `reinstatement_date` DATE COMMENT 'Date when a previously suspended certification was reinstated to active status. Nullable if never suspended or not yet reinstated.',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewal cycles for this certification (e.g., 12 for annual, 24 for biennial, 36 for triennial).',
    `revocation_date` DATE COMMENT 'Date when the certification was permanently revoked. Nullable if never revoked.',
    `revocation_reason` STRING COMMENT 'Explanation of why the certification was permanently revoked, if applicable (e.g., serious compliance violations, fraudulent activity, repeated failures). Nullable if never revoked.',
    `suspension_date` DATE COMMENT 'Date when the certification was suspended. Nullable if never suspended.',
    `suspension_reason` STRING COMMENT 'Explanation of why the certification was suspended, if applicable (e.g., failed audit, non-compliance with training requirements, facility deficiencies). Nullable if never suspended.',
    `training_completion_date` DATE COMMENT 'Date when the dealer completed the required training program for this certification. Nullable if training is not required or not yet completed.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether dealer personnel must complete specific training programs to obtain or maintain this certification.',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Tracks OEM-issued certifications and program enrollments for a dealership, such as EV-certified dealer, ADAS service authorization, luxury brand certification, and IATF 16949 compliance status. Includes certification type, issuing body, issue date, expiry date, renewal requirements, and current status. Drives eligibility for vehicle allocation and incentive programs.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` (
    `vehicle_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each vehicle allocation record linking a specific vehicle unit or allocation batch from OEM manufacturing output to a dealership inventory pipeline.',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to vehicle.configuration. Business justification: Dealer allocation planning and OEM order management require knowing the exact vehicle configuration (trim, powertrain, market, color) being allocated. This drives incentive eligibility, allocation pri',
    `fleet_contract_id` BIGINT COMMENT 'Foreign key linking to sales.fleet_contract. Business justification: Fleet contract fulfillment tracking: OEMs allocate specific vehicles to satisfy fleet contract committed volumes. Linking vehicle_allocation to fleet_contract enables fleet delivery schedule tracking,',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: OEM vehicle allocation is plant-sourced: allocation teams assign dealer units from specific plants. Allocation reports, supply planning, and dealer-facing ETAs are all plant-keyed. production_plant_c',
    `dealership_id` BIGINT COMMENT 'Reference to the dealership receiving this vehicle allocation. Links to the dealer master record in the dealer network.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_schedule. Business justification: OEM allocation process is directly driven by production schedules: available units per model/variant per period are read from production_schedule to determine dealer allocation quantities. Allocation ',
    `territory_id` BIGINT COMMENT 'Foreign key linking to dealer.dealer_territory. Business justification: Vehicle allocations are distributed according to dealer territory assignments — vehicle_allocation.territory_code is a denormalized string reference to dealer_territory.territory_code. Replacing it wi',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: OEM allocation planning is organized by vehicle program — allocation teams assign units to dealers by program (model year, nameplate, platform). Linking vehicle_allocation to vehicle_program enables p',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Once a VIN is assigned to a dealer allocation, traceability from allocation decision to the specific registered VIN is required for recall management, warranty activation, delivery confirmation, and O',
    `acceptance_deadline` DATE COMMENT 'Date by which the dealer must formally accept or reject this allocation. Failure to respond by this date may result in automatic acceptance or reallocation per OEM dealer agreement terms.',
    `acceptance_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the dealer formally accepted this vehicle allocation via the dealer portal or DMS integration. Provides precise audit trail for dealer commitment.',
    `accepted_quantity` STRING COMMENT 'Number of vehicle units formally accepted by the dealer from this allocation. May be less than allocated_quantity if the dealer partially accepts or rejects units.',
    `actual_delivery_date` DATE COMMENT 'Actual date the allocated vehicle(s) were physically delivered to and received by the dealership. Used for On-Time Delivery (OTD) performance measurement and dealer satisfaction tracking.',
    `allocation_batch_number` STRING COMMENT 'Identifier grouping multiple allocation records issued in the same OEM allocation run or production release cycle. Enables batch-level tracking, reporting, and dealer communication.',
    `allocation_date` DATE COMMENT 'The business event date on which the OEM formally allocated the vehicle unit(s) to the dealership. Represents the principal real-world event time for this transaction.',
    `allocation_number` STRING COMMENT 'Externally-known business identifier for this allocation transaction, used in dealer communications, DMS integration, and OEM-dealer correspondence. Format: ALLOC-{MY}-{sequence}.. Valid values are `^ALLOC-[0-9]{4}-[0-9]{6}$`',
    `allocation_rule_code` STRING COMMENT 'Code identifying the specific allocation rule or algorithm applied to determine this dealers vehicle entitlement (e.g., turn-and-earn, market share, historical sales, regional quota). Drives transparency and auditability of allocation decisions.',
    `allocation_status` STRING COMMENT 'Current lifecycle state of the vehicle allocation record. Tracks progression from OEM-initiated pending through dealer acceptance or rejection to final delivery confirmation.. Valid values are `pending|confirmed|accepted|rejected|cancelled|delivered`',
    `allocation_type` STRING COMMENT 'Classification of the allocation purpose: standard retail inventory, priority customer order fulfillment, constrained supply allocation, fleet customer, dealer demonstrator vehicle, or loaner vehicle program.. Valid values are `standard|priority|constrained|fleet|demo|loaner`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was first captured in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this allocation record (MSRP, dealer invoice price, incentive amounts). Supports multi-currency dealer networks in international markets.. Valid values are `^[A-Z]{3}$`',
    `dealer_invoice_price` DECIMAL(18,2) COMMENT 'The price at which the OEM invoices the dealer for the allocated vehicle, net of holdback and before dealer incentives. Represents the dealers cost basis for inventory financing and margin calculation.',
    `dms_reference_number` STRING COMMENT 'The corresponding allocation or stock order reference number in the dealers CDK Global Dealer Management System (DMS). Enables end-to-end reconciliation between OEM allocation records and dealer inventory systems.',
    `estimated_delivery_date` DATE COMMENT 'Estimated date the allocated vehicle(s) are expected to arrive at the dealership. Calculated based on production schedule, transport lead time, and PDI processing time. Communicated to dealers for inventory planning.',
    `hold_code` STRING COMMENT 'Code indicating any active hold placed on the allocated vehicle(s) preventing retail sale (e.g., safety recall hold, quality hold, regulatory compliance hold, stop-sale order). Null when no hold is active. [ENUM-REF-CANDIDATE: safety_recall|quality_hold|regulatory|stop_sale|tsb_hold|other — promote to reference product]',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary value of the dealer incentive or bonus applicable to this specific allocation record. Represents the financial benefit to the dealer for accepting and retailing this vehicle.',
    `incentive_program_code` STRING COMMENT 'Code identifying the OEM dealer incentive program applicable to this allocation (e.g., volume bonus, stair-step program, conquest incentive). Links to the dealer incentive program master for payout calculation.',
    `is_customer_order` BOOLEAN COMMENT 'Indicates whether this allocation is fulfilling a specific retail customer order (sold order) rather than being allocated to dealer stock inventory. Drives order fulfillment priority and customer communication workflows.',
    `last_mile_delivery_method` STRING COMMENT 'Preferred last-mile delivery method for this allocation (truck, rail, self-drive).',
    `msrp` DECIMAL(18,2) COMMENT 'Manufacturer Suggested Retail Price (MSRP) for the allocated vehicle unit in the base transaction currency. Used for dealer invoice calculation, incentive program application, and consumer pricing guidance.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or dealer-specific comments associated with this allocation record. Used by zone managers and dealer relations teams.',
    `pdi_completed` BOOLEAN COMMENT 'Indicates whether the Pre-Delivery Inspection (PDI) has been completed for the allocated vehicle(s) at the dealership. Required before vehicle can be retailed to a customer.',
    `pdi_required` BOOLEAN COMMENT 'Indicates whether a Pre-Delivery Inspection (PDI) is required for the allocated vehicle(s) before retail handover. Drives dealer service scheduling and PDI cost recovery processes.',
    `port_of_entry_code` STRING COMMENT 'Code identifying the port or processing compound through which imported or CKD/SKD vehicles pass before onward delivery to the dealer. Relevant for international allocation flows and customs compliance.. Valid values are `^[A-Z]{3,5}$`',
    `priority_tier` STRING COMMENT 'Dealer priority tier assigned for this allocation cycle, determining precedence when vehicle supply is constrained. Tier 1 dealers receive first allocation rights based on performance metrics, sales volume, or strategic importance.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `region_code` STRING COMMENT 'OEM regional zone code (e.g., NORTHEAST, SOUTHEAST, CENTRAL, WEST) grouping territories for macro-level allocation planning, regional incentive programs, and zone manager oversight.. Valid values are `^[A-Z]{2,5}$`',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the dealers reason for rejecting this allocation (e.g., excess inventory, wrong specification, cash flow constraints, market demand mismatch). Null when allocation is accepted. [ENUM-REF-CANDIDATE: excess_inventory|wrong_spec|cash_flow|demand_mismatch|facility_capacity|other — promote to reference product]',
    `scheduled_production_date` DATE COMMENT 'Planned date on which the allocated vehicle unit(s) are scheduled to enter the production line. Derived from the Start of Production (SOP) schedule and used for delivery window planning.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record that originated this allocation record. Supports data lineage, reconciliation, and multi-system integration auditing across SAP S/4HANA SD, CDK Global DMS, and Salesforce Automotive Cloud.. Valid values are `SAP_SD|CDK_DMS|SALESFORCE|MES|MANUAL`',
    `transport_mode` STRING COMMENT 'Primary mode of transportation used to deliver the allocated vehicle(s) from the production plant or port of entry to the dealership. Drives logistics cost allocation and delivery lead time estimation.. Valid values are `rail|truck|ship|compound`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this allocation record. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    CONSTRAINT pk_vehicle_allocation PRIMARY KEY(`vehicle_allocation_id`)
) COMMENT 'Records the OEMs allocation of specific vehicle units (by VIN or allocation batch) to a dealership for a given model year and production period. Captures allocation quantity, nameplate, trim, powertrain type (ICE/HEV/PHEV/EV), allocation rule applied, priority tier, acceptance status, and delivery window. Core operational record linking manufacturing output to dealer inventory pipeline.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` (
    `dealer_inventory_id` BIGINT COMMENT 'Unique surrogate identifier for each dealer inventory record in the Silver Layer lakehouse. Primary key for this data product.',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Inventory management report requires linking each dealer inventory record to the SKU definition for pricing, specs, warranty and compliance.',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to vehicle.configuration. Business justification: Dealer lot inventory management, recall compliance, incentive eligibility, and window sticker accuracy all require the exact vehicle configuration. body_style, drivetrain, and transmission_type are de',
    `dealership_id` BIGINT COMMENT 'Reference to the dealership that physically holds or is allocated this inventory unit. Sourced from CDK Global DMS dealer master.',
    `recall_campaign_id` BIGINT COMMENT 'Foreign key linking to compliance.recall_campaign. Business justification: Dealers must hold and identify inventory vehicles affected by active recall campaigns before sale. recall_campaign_number is a denormalized reference. Linking dealer_inventory to recall_campaign suppo',
    `service_campaign_id` BIGINT COMMENT 'Foreign key linking to aftersales.service_campaign. Business justification: Dealer inventory vehicles on recall/service campaign hold must be tracked against the specific campaign for lot management, parts pre-ordering, and OEM compliance reporting. recall_campaign_number is ',
    `vehicle_allocation_id` BIGINT COMMENT 'Foreign key linking to dealer.vehicle_allocation. Business justification: Dealer inventory records are created when OEM-allocated vehicles arrive at the dealership. vehicle_allocation is the upstream record that triggers the creation of a dealer_inventory entry. Linking dea',
    `vehicle_build_id` BIGINT COMMENT 'Foreign key linking to manufacturing.vehicle_build. Business justification: Needed for Vehicle Traceability report, connecting each inventory record to its exact build record for warranty and recall actions.',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Dealer inventory management report requires each inventory record to be linked to the VIN registry for warranty, recall, and compliance tracking.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'The dealers total landed cost for this vehicle unit, including invoice price, transportation/destination charges, PDI costs, and any dealer-installed accessories. Used for gross profit calculation and inventory valuation.',
    `asking_price` DECIMAL(18,2) COMMENT 'The dealers current advertised or asking retail price for this vehicle unit. May differ from MSRP due to market adjustments, dealer markups, or promotional discounts. Updated dynamically based on market conditions and days-on-lot.',
    `certified_pre_owned` BOOLEAN COMMENT 'Indicates whether this used vehicle unit has been certified under the OEMs Certified Pre-Owned (CPO) program, meeting specific age, mileage, inspection, and reconditioning standards. True = CPO certified; False = not CPO certified. CPO vehicles carry extended warranty coverage and premium pricing.',
    `days_on_lot` STRING COMMENT 'The number of calendar days this vehicle unit has been physically present on the dealers lot since the received date. A key inventory aging metric used to trigger price adjustments, incentive programs, and wholesale decisions. Aged inventory (typically >60 days) incurs floor plan interest costs.',
    `dms_record_reference` STRING COMMENT 'The source system record identifier from CDK Global DMS for this inventory unit. Used for data lineage, reconciliation, and incremental load processing between the DMS source and the Silver Layer lakehouse.',
    `dwell_time_days` STRING COMMENT 'Number of days the vehicle has been in dealer inventory.',
    `engine_description` STRING COMMENT 'Descriptive label for the engine or powertrain configuration (e.g., 2.5L 4-Cylinder, 3.5L V6 EcoBoost, 75 kWh Electric Motor). Supports customer consultation and technical service identification.',
    `estimated_arrival_date` DATE COMMENT 'The estimated date the vehicle unit is expected to arrive at the dealership from the OEM or transport carrier. Relevant for in-transit inventory. Used for customer pre-order management and lot planning.',
    `exterior_color_code` STRING COMMENT 'OEM-assigned paint/exterior color code for this vehicle unit (e.g., NH-883P for Sonic Gray Pearl). Used for inventory search, customer matching, and lot locator functions within CDK Global DMS.',
    `exterior_color_name` STRING COMMENT 'Human-readable marketing name of the exterior paint color (e.g., Sonic Gray Pearl, Midnight Black Metallic). Used for customer-facing display and sales consultation.',
    `floor_plan_date` DATE COMMENT 'The date on which floor plan financing commenced for this vehicle unit. Used to calculate accrued floor plan interest costs and curtailment schedules. Null for vehicles not financed via floor plan.',
    `floor_plan_lender` STRING COMMENT 'Name of the financial institution providing floor plan (wholesale) financing for this vehicle unit (e.g., Ford Motor Credit, Ally Financial, Chase Auto Finance). Floor plan financing is the short-term credit line dealers use to fund vehicle inventory.',
    `fuel_economy_city_mpg` DECIMAL(18,2) COMMENT 'EPA-rated city fuel economy for this vehicle configuration in miles per gallon (MPG), or MPGe for electric/hybrid vehicles. Required disclosure on the Monroney label and used for CAFE compliance reporting.',
    `fuel_economy_highway_mpg` DECIMAL(18,2) COMMENT 'EPA-rated highway fuel economy for this vehicle configuration in miles per gallon (MPG), or MPGe for electric/hybrid vehicles. Required disclosure on the Monroney label and used for CAFE compliance reporting.',
    `in_service_date` DATE COMMENT 'The date the vehicle was placed into service (sold and delivered to a retail customer, or placed into demo/loaner service). Marks the start of the OEM warranty period. Null if the vehicle has not yet been placed in service.',
    `interior_color_code` STRING COMMENT 'OEM-assigned interior color/trim code for this vehicle unit (e.g., BK for Black). Used for inventory matching and customer preference alignment.',
    `interior_color_name` STRING COMMENT 'Human-readable marketing name of the interior color and material (e.g., Black Leather, Sandstone Cloth). Used for customer-facing display and sales consultation.',
    `inventory_status` STRING COMMENT 'Current disposition status of the vehicle unit within the dealer inventory lifecycle. available = on-lot and saleable; sold = retail sale completed; demo = dealer demonstration unit; loaner = service loaner vehicle; in_transit = allocated but not yet physically received; reserved = held for a specific customer; wholesale = designated for wholesale/auction disposal. [ENUM-REF-CANDIDATE: available|sold|demo|loaner|in_transit|reserved|wholesale — promote to reference product]',
    `inventory_type` STRING COMMENT 'Classification of the vehicle unit by its condition and ownership history: new = new vehicle never titled; used = previously owned/titled vehicle; certified_pre_owned = OEM-certified used vehicle meeting specific age/mileage criteria; demo = dealer demonstration vehicle; loaner = service loaner vehicle. Governs applicable pricing, warranty, and financing programs.. Valid values are `new|used|certified_pre_owned|demo|loaner`',
    `invoice_price` DECIMAL(18,2) COMMENT 'The OEM invoice price charged to the dealer for this vehicle unit, representing the dealers acquisition cost from the manufacturer before holdback, dealer cash, or other incentives. Confidential commercial pricing data.',
    `last_price_update_date` DATE COMMENT 'The date on which the asking price for this vehicle unit was most recently updated in the CDK Global DMS. Used to track pricing strategy cadence and ensure market-aligned pricing for aged inventory.',
    `location_code` STRING COMMENT 'The physical lot or storage location code within the dealership where this vehicle is parked (e.g., LOT-A-12, SHOWROOM-3, OVERFLOW-B). Used for lot management, vehicle locator, and PDI workflow routing within CDK Global DMS.',
    `msrp` DECIMAL(18,2) COMMENT 'The Manufacturer Suggested Retail Price (MSRP) for this specific vehicle unit including all factory-installed options and packages, expressed in the local currency (USD). Established by the OEM and used as the baseline for dealer pricing and incentive calculations.',
    `odometer_reading` STRING COMMENT 'Current odometer reading of the vehicle in miles at the time of inventory check-in or last update. Critical for used, demo, and loaner vehicles to determine CPO eligibility, warranty coverage, and pricing. For new vehicles, reflects delivery mileage.',
    `pdi_completed` BOOLEAN COMMENT 'Indicates whether the Pre-Delivery Inspection (PDI) has been completed for this vehicle unit. PDI is a mandatory dealer quality check performed before vehicle delivery to a customer, verifying all systems, fluids, and accessories meet OEM standards. True = PDI completed; False = PDI pending.',
    `pdi_completed_date` DATE COMMENT 'The date on which the Pre-Delivery Inspection (PDI) was completed and signed off by the dealers service technician. Null if PDI has not yet been performed.',
    `recall_hold` BOOLEAN COMMENT 'Indicates whether this vehicle unit is subject to an active NHTSA safety recall that prevents retail sale or delivery until the recall remedy has been performed. True = vehicle is on recall hold and cannot be sold; False = no active recall hold. Critical for regulatory compliance and consumer safety.',
    `received_date` DATE COMMENT 'The date the vehicle unit was physically received and checked into the dealers inventory from the OEM transport carrier or trade-in. Marks the start of the days-on-lot aging clock and floor plan financing period.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this dealer inventory record was first created in the Silver Layer lakehouse, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this dealer inventory record was most recently updated in the Silver Layer lakehouse, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking, incremental processing, and audit trail requirements.',
    `source_type` STRING COMMENT 'Indicates how the dealer acquired this vehicle unit: factory_order = ordered directly from OEM; dealer_trade = acquired via dealer-to-dealer trade; auction = purchased at wholesale auction; trade_in = accepted as customer trade-in; fleet_return = returned from fleet/rental program; lease_return = returned at end of lease term.. Valid values are `factory_order|dealer_trade|auction|trade_in|fleet_return|lease_return`',
    `stock_number` STRING COMMENT 'Dealer-assigned internal stock number used within the CDK Global DMS to identify and locate this vehicle on the lot. Unique within a dealership but not globally unique.',
    `transport_status` STRING COMMENT 'Current transportation status for vehicles in the delivery pipeline from OEM plant to dealership: not_shipped = awaiting dispatch from plant; in_transit = en route via carrier; delivered = arrived at dealer; rail = currently on rail transport; truck = currently on truck transport.. Valid values are `not_shipped|in_transit|delivered|rail|truck`',
    `window_sticker_url` STRING COMMENT 'URL link to the digital Monroney window sticker (required by the Automobile Information Disclosure Act) for this vehicle unit, hosted by the OEM or a third-party service. Contains MSRP, standard equipment, options, fuel economy ratings, and safety information.',
    `yard_slot_code` STRING COMMENT 'Yard slot code where the vehicle is parked at the dealership.',
    CONSTRAINT pk_dealer_inventory PRIMARY KEY(`dealer_inventory_id`)
) COMMENT 'Real-time inventory of vehicles physically on-hand or in-transit at a dealership. Tracks VIN, nameplate, model year, trim, exterior/interior color, powertrain, days-on-lot, acquisition cost, current asking price, inventory status (available, sold, demo, loaner, in-transit), and PDI (Pre-Delivery Inspection) completion flag. Sourced from CDK Global DMS inventory module.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` (
    `retail_sale_id` BIGINT COMMENT 'Unique surrogate identifier for each retail vehicle sale transaction record in the dealer domain. Primary key for the retail_sale data product.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Campaign ROI and incentive program reporting: retail sales are driven by OEM incentive campaigns. Linking retail_sale to campaign enables campaign-to-sales conversion analytics, incentive spend vs. re',
    `dealer_inventory_id` BIGINT COMMENT 'Foreign key linking to dealer.dealer_inventory. Business justification: A retail sale is the transaction that converts a dealer inventory unit into a sold vehicle. retail_sale.stock_number is a denormalized string reference to dealer_inventory.stock_number — replacing it ',
    `msrp_price_book_id` BIGINT COMMENT 'Foreign key linking to product.msrp_price_book. Business justification: Consumer protection regulations and OEM audit requirements mandate recording which MSRP price book governed each retail sale. This enables price compliance audits, incentive reconciliation, and regula',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Retail sale conversion analysis links the final sale back to the originating sales opportunity for win‑loss tracking.',
    `party_id` BIGINT COMMENT 'Reference to the retail customer (buyer) who purchased the vehicle. Links to the customer master record.',
    `dealership_id` BIGINT COMMENT 'Reference to the dealership that executed the retail sale transaction. Links to the dealer master record in the dealer domain.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Program managers track retail sales performance against program-level volume and revenue targets (target_production_volume, target_cost_per_vehicle on vehicle_program). Linking retail_sale to vehicle_',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Retail sale reporting and warranty registration depend on linking the sold vehicle to its VIN registry entry.',
    `apr` DECIMAL(18,2) COMMENT 'The Annual Percentage Rate (APR) on the retail installment contract as disclosed to the customer under Regulation Z. Expressed as a decimal (e.g., 0.0699 for 6.99%). Null for cash and lease deals.',
    `back_end_gross` DECIMAL(18,2) COMMENT 'Gross profit earned from F&I products and dealer reserve on the financing (back-end), representing the total F&I department contribution to the deal. Key dealer profitability metric.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the retail sale record was first created in the data platform (Silver Layer ingestion). Conforms to ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this retail sale record (e.g., USD, CAD, EUR). Supports multi-market dealer network operations.. Valid values are `^[A-Z]{3}$`',
    `deal_number` STRING COMMENT 'Externally-known alphanumeric deal reference number assigned by the CDK Global DMS F&I module at the time the deal is opened. Used for cross-referencing with dealer records, lender submissions, and OEM reporting.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `deal_status` STRING COMMENT 'Current lifecycle state of the retail sale deal. draft indicates deal is being structured; pending indicates awaiting lender funding approval; funded indicates lender has funded the deal; unwound indicates a previously funded deal that was reversed; cancelled indicates deal was voided before funding.. Valid values are `draft|pending|funded|unwound|cancelled`',
    `delivery_date` DATE COMMENT 'The date the vehicle was physically delivered to the customer following Pre-Delivery Inspection (PDI). May differ from sale_date when delivery is deferred. Used for warranty start date determination and OEM retail reporting.',
    `delivery_method` STRING COMMENT 'Method of vehicle delivery to customer (dealer_pickup, home_delivery, compound_pickup).',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the vehicle sale, calculated as MSRP minus sale price. Includes dealer discounts, OEM incentive discounts, and employee pricing adjustments. Used for dealer margin analysis and OEM incentive reconciliation.',
    `dms_deal_reference` STRING COMMENT 'The native deal identifier assigned by the CDK Global DMS F&I module. Used for source system traceability, reconciliation, and integration with downstream OEM reporting and lender portals.',
    `doc_fee` DECIMAL(18,2) COMMENT 'Dealer-charged documentation and processing fee included in the deal. Subject to state-level regulatory caps in many jurisdictions. Disclosed on the buyers order.',
    `down_payment` DECIMAL(18,2) COMMENT 'Cash down payment made by the customer at the time of sale, excluding trade-in allowance. Reduces the amount financed. Used for deal structure analysis and lender submission.',
    `fi_product_revenue` DECIMAL(18,2) COMMENT 'Total gross revenue generated from Finance and Insurance (F&I) aftermarket products sold as part of the deal, including extended service contracts, GAP insurance, paint protection, tire and wheel protection, and credit life/disability insurance.',
    `finance_amount` DECIMAL(18,2) COMMENT 'The total amount financed by the customer under the retail installment contract, including vehicle price, F&I products, taxes, and fees, less down payment and trade-in allowance. Null for cash deals.',
    `financing_type` STRING COMMENT 'The method by which the customer is financing the vehicle purchase. cash = outright purchase; retail_finance = retail installment contract through a lender; lease = closed-end consumer lease; balloon = balloon payment retail contract.. Valid values are `cash|retail_finance|lease|balloon`',
    `fleet_sale` BOOLEAN COMMENT 'Indicates whether the vehicle was sold as part of a fleet or commercial account transaction rather than a retail consumer sale. Fleet sales are tracked separately for CAFE compliance, OEM fleet incentive programs, and sales mix reporting.',
    `front_end_gross` DECIMAL(18,2) COMMENT 'Gross profit earned on the vehicle sale itself (front-end), calculated as sale price minus dealer invoice cost and pack. Excludes F&I product revenue. Key dealer profitability metric reported in DMS and OEM dealer scorecards.',
    `lender_name` STRING COMMENT 'Name of the financial institution (captive finance company, bank, credit union) that approved and funded the retail installment contract or lease. Null for cash deals. Used for lender mix reporting and dealer reserve analysis.',
    `loan_term_months` STRING COMMENT 'The contractual term of the retail installment contract expressed in months (e.g., 36, 48, 60, 72, 84). Used for lender mix analysis, payment affordability reporting, and portfolio risk assessment.',
    `model_year` STRING COMMENT 'The Model Year (MY) of the vehicle sold, as defined by the OEM and NHTSA. Used for CAFE compliance reporting, incentive program eligibility, and sales mix analytics.',
    `monthly_payment` DECIMAL(18,2) COMMENT 'The customers contracted monthly payment amount under the retail installment contract or lease agreement. Used for affordability analysis and customer financial profiling.',
    `msrp_amount` DECIMAL(18,2) COMMENT 'The Manufacturer Suggested Retail Price (MSRP) of the vehicle as stickered, inclusive of all factory-installed options and destination charges. Expressed in the local currency (USD). Used as the baseline for discount calculation, incentive reporting, and dealer margin analysis.',
    `oem_incentive_amount` DECIMAL(18,2) COMMENT 'Total value of OEM-funded customer incentives applied to the deal, including cash-back rebates, conquest bonuses, loyalty bonuses, and special program pricing. Sourced from OEM incentive program data and reconciled against dealer statements.',
    `pdi_completed` BOOLEAN COMMENT 'Indicates whether the Pre-Delivery Inspection (PDI) was completed and signed off by the dealer technician prior to vehicle delivery to the customer. PDI completion is required for warranty activation and OEM delivery standards compliance.',
    `sale_date` DATE COMMENT 'The calendar date on which the retail vehicle sale was consummated — i.e., the date the buyer signed the retail installment contract or cash purchase agreement. This is the principal business event date used for sales reporting, OEM incentive eligibility, and regulatory compliance.',
    `sale_price` DECIMAL(18,2) COMMENT 'The agreed-upon selling price of the vehicle as negotiated between the dealer and the customer, before trade-in allowance, taxes, and fees. This is the gross capitalized cost for lease deals or the selling price for retail finance and cash deals.',
    `sales_tax_amount` DECIMAL(18,2) COMMENT 'State and local sales tax assessed on the vehicle sale transaction. Calculated based on the taxable selling price and the applicable jurisdiction tax rate. Used for tax remittance reporting and deal cost reconciliation.',
    `trade_in_allowance` DECIMAL(18,2) COMMENT 'The agreed trade-in value credited to the customer for a vehicle traded in as part of the deal. Reduces the amount financed or cash due. Null if no trade-in vehicle was involved in the transaction.',
    `trade_in_payoff_amount` DECIMAL(18,2) COMMENT 'The outstanding loan or lease payoff balance on the customers trade-in vehicle at the time of the deal. If payoff exceeds trade-in allowance, the difference (negative equity) is typically rolled into the new deal.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the retail sale record was last modified in the data platform, reflecting deal amendments, status changes, or corrections sourced from CDK Global DMS. Conforms to ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `vehicle_condition` STRING COMMENT 'Condition classification of the vehicle at point of sale. new indicates a new, untitled vehicle; used indicates a previously titled vehicle; certified_pre_owned indicates a manufacturer-certified pre-owned vehicle meeting OEM CPO program standards.. Valid values are `new|used|certified_pre_owned`',
    CONSTRAINT pk_retail_sale PRIMARY KEY(`retail_sale_id`)
) COMMENT 'Records the retail sale of a new or used vehicle by a dealership to an end customer. Captures VIN, sale date, sale price, MSRP, discount amount, trade-in details, financing type (cash, retail finance, lease), F&I products sold, salesperson, and deal status. Sourced from CDK Global DMS F&I module. SSOT for dealer-level vehicle sales transactions.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` (
    `dealer_service_appointment_id` BIGINT COMMENT 'Unique identifier for the dealer_service_appointment data product (auto-inserted pre-linking).',
    `aftersales_service_appointment_id` BIGINT COMMENT 'Foreign key linking to aftersales.service_appointment. Business justification: Business process: Dealer DMS schedules service appointments; aftersales processes them. Linking ensures appointment sync for parts, labor, and warranty tracking.',
    `dealership_id` BIGINT COMMENT 'Foreign key linking to dealer.dealership. Business justification: Dealer service appointments belong to a dealership; add dealership_id FK to link to dealership and remove redundant dealer_id column.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Service appointment scheduling needs to associate the customer (party) with the appointment for service history and follow‑up.',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Service appointment scheduling must reference the specific vehicle VIN to allocate resources and track service history.',
    `appointment_date` DATE COMMENT 'Date of the service appointment',
    `appointment_number` STRING COMMENT '',
    `appointment_status` STRING COMMENT 'Status (scheduled, confirmed, in-progress, completed, cancelled, no-show)',
    `appointment_time` TIMESTAMP COMMENT 'Scheduled time of appointment',
    `booking_channel` STRING COMMENT '',
    `check_in_timestamp` TIMESTAMP COMMENT '',
    `checked_in_at` TIMESTAMP COMMENT '',
    `checked_in_timestamp` TIMESTAMP COMMENT '',
    `completed_at` TIMESTAMP COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `customer_concern` STRING COMMENT 'Customer-reported concern or issue',
    `customer_concern_description` STRING COMMENT '',
    `customer_name` STRING COMMENT 'Name of the customer',
    `customer_phone` STRING COMMENT 'Customer phone number',
    `drop_off_timestamp` TIMESTAMP COMMENT 'Timestamp when vehicle was dropped off',
    `estimated_cost` DECIMAL(18,2) COMMENT '',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT '',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated service duration in hours',
    `estimated_duration_minutes` STRING COMMENT '',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT '',
    `home_service_flag` BOOLEAN COMMENT 'Whether this appointment is for mobile/home service delivery.',
    `loaner_requested_flag` BOOLEAN COMMENT '',
    `loaner_required_flag` BOOLEAN COMMENT 'Whether a loaner vehicle is needed',
    `mileage_at_service` STRING COMMENT 'Vehicle mileage at time of service',
    `mileage_in` STRING COMMENT '',
    `odometer_reading` STRING COMMENT '',
    `pickup_timestamp` TIMESTAMP COMMENT 'Timestamp when vehicle was picked up',
    `scheduled_at` TIMESTAMP COMMENT '',
    `scheduled_end_timestamp` TIMESTAMP COMMENT '',
    `scheduled_start_timestamp` TIMESTAMP COMMENT '',
    `scheduled_timestamp` TIMESTAMP COMMENT '',
    `service_type` STRING COMMENT 'Type of service (maintenance, repair, recall, warranty)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_dealer_service_appointment PRIMARY KEY(`dealer_service_appointment_id`)
) COMMENT 'Scheduled service appointments at a dealership for vehicle maintenance, warranty repair, recall service, or customer-pay work. Tracks appointment date/time, customer, VIN, service type, advisor assigned, estimated duration, appointment status (scheduled, checked-in, in-progress, completed, no-show), and transportation option (loaner, shuttle, wait). Sourced from CDK Global DMS service scheduling module. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` (
    `dealer_repair_order_id` BIGINT COMMENT 'Unique identifier for the dealer_repair_order data product (auto-inserted pre-linking).',
    `aftersales_repair_order_id` BIGINT COMMENT 'Foreign key linking to aftersales.repair_order. Business justification: Process: Dealer creates a repair order in DMS; it must reference the central aftersales repair order for warranty validation and labor costing.',
    `dealer_service_appointment_id` BIGINT COMMENT 'Foreign key linking to dealer.dealer_service_appointment. Business justification: A dealer repair order is the execution record that fulfills a scheduled service appointment. The appointment (dealer_service_appointment) is the parent scheduling event; the repair order (dealer_repai',
    `dealership_id` BIGINT COMMENT 'Foreign key linking to dealer.dealership. Business justification: A repair order is always performed at a specific dealership. dealer_repair_order currently has no in-domain FK to dealership (only cross-domain links to aftersales, customer, and vehicle domains exist',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Repair orders must be linked to the owning customer for warranty claim processing and regulatory reporting.',
    `recall_campaign_id` BIGINT COMMENT 'Foreign key linking to compliance.recall_campaign. Business justification: Dealers perform recall remedy work tracked via repair orders. recall_campaign_number is denormalized. NHTSA recall completion rate reporting requires linking repair orders to specific recall campaigns',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Repair orders must be tied to the VIN registry to manage warranty repairs and parts usage per vehicle.',
    `cause_description` STRING COMMENT 'Diagnosed cause',
    `close_date` DATE COMMENT 'Date repair order was closed',
    `closed_at` TIMESTAMP COMMENT '',
    `closed_timestamp` TIMESTAMP COMMENT '',
    `complaint_description` STRING COMMENT 'Customer complaint description',
    `correction_description` STRING COMMENT 'Correction performed',
    `created_timestamp` TIMESTAMP COMMENT '',
    `labor_amount` DECIMAL(18,2) COMMENT 'Total labor charges',
    `labor_hours` DECIMAL(18,2) COMMENT '',
    `mileage` STRING COMMENT 'Vehicle mileage at time of repair',
    `open_date` DATE COMMENT 'Date repair order was opened',
    `opened_at` TIMESTAMP COMMENT '',
    `opened_timestamp` TIMESTAMP COMMENT '',
    `parts_amount` DECIMAL(18,2) COMMENT 'Total parts charges',
    `payment_type` STRING COMMENT 'Payment type (customer pay, warranty, internal, insurance)',
    `pickup_delivery_flag` BOOLEAN COMMENT 'Whether vehicle pickup and delivery service is included.',
    `repair_description` STRING COMMENT '',
    `repair_order_number` STRING COMMENT '',
    `repair_order_status` STRING COMMENT '',
    `repair_status` STRING COMMENT '',
    `ro_number` STRING COMMENT 'Repair order number',
    `ro_status` STRING COMMENT 'Status (open, in-progress, parts-on-order, completed, invoiced)',
    `total_amount` DECIMAL(18,2) COMMENT 'Total repair order amount',
    `total_labor_amount` DECIMAL(18,2) COMMENT '',
    `total_parts_amount` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `warranty_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_dealer_repair_order PRIMARY KEY(`dealer_repair_order_id`)
) COMMENT 'Detailed repair order (RO) record for each vehicle service event at a dealership. Captures RO number, open/close dates, VIN, mileage-in, complaint/cause/correction (3C), labor operations, technician assignments, parts consumed, warranty vs customer-pay vs internal split, total labor hours, total parts cost, and RO status. Core operational record for dealer service operations sourced from CDK Global DMS. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` (
    `performance_scorecard_id` BIGINT COMMENT 'Unique identifier for the dealer performance scorecard record.',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to dealer.franchise_agreement. Business justification: A performance scorecard evaluates a dealers compliance against the terms defined in their franchise agreement — including minimum_sales_quota_annual, customer_satisfaction_target_score, minimum_servi',
    `dealership_id` BIGINT COMMENT 'Reference to the dealer being evaluated in this scorecard.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to product.product_segment. Business justification: OEMs issue segment-specific performance scorecards (e.g., EV sales scorecard, truck segment scorecard) to dealers. Linking scorecard to product_segment enables segment-level dealer performance reporti',
    `comments` STRING COMMENT 'Additional notes or commentary from the OEM regarding the dealers performance during this period.',
    `composite_score` DECIMAL(18,2) COMMENT 'The overall weighted composite performance score combining all KPI categories (sales, service, parts, customer satisfaction, facility standards) used for franchise compliance and incentive eligibility.',
    `composite_score_benchmark` DECIMAL(18,2) COMMENT 'The minimum composite score required for franchise compliance and incentive program eligibility.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this scorecard record was first created in the system.',
    `csi_benchmark` DECIMAL(18,2) COMMENT 'The target or industry benchmark CSI score the dealer is expected to meet or exceed.',
    `csi_score` DECIMAL(18,2) COMMENT 'The Customer Satisfaction Index score measuring overall customer satisfaction with sales and service experience, typically on a scale of 0-100 or 0-1000 depending on OEM methodology.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts in this scorecard.. Valid values are `^[A-Z]{3}$`',
    `days_supply` STRING COMMENT 'The average number of days of inventory on hand at the dealer based on current sales rate.',
    `delivery_satisfaction_score` DECIMAL(18,2) COMMENT 'Customer satisfaction score for delivery operations.',
    `dms_integration_source` STRING COMMENT 'The Dealer Management System from which raw performance data was extracted for this scorecard.. Valid values are `CDK_Global|Reynolds_Reynolds|Dealertrack|ADP|Other`',
    `facility_standards_score` DECIMAL(18,2) COMMENT 'The score measuring dealer compliance with OEM facility image and standards requirements (showroom, service bays, signage, etc.).',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) to which this scorecard period belongs, if applicable.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this scorecard period belongs.',
    `franchise_compliance_status` STRING COMMENT 'The dealers franchise agreement compliance status based on this scorecards performance results.. Valid values are `compliant|non_compliant|probation|warning`',
    `incentive_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the dealer met the minimum performance thresholds to qualify for OEM incentive programs during this scorecard period.',
    `inventory_turn_rate` DECIMAL(18,2) COMMENT 'The number of times the dealers new vehicle inventory was sold and replaced during the scorecard period, calculated as sales divided by average inventory.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this scorecard record was last updated.',
    `market_share_pct` DECIMAL(18,2) COMMENT 'The dealers share of total new vehicle sales in their assigned territory or market area during the scorecard period.',
    `new_vehicle_sales_actual` STRING COMMENT 'The actual number of new vehicles sold by the dealer during the scorecard period.',
    `new_vehicle_sales_attainment_pct` DECIMAL(18,2) COMMENT 'The percentage of the new vehicle sales objective achieved by the dealer (actual/objective * 100).',
    `new_vehicle_sales_objective` STRING COMMENT 'The target number of new vehicles the dealer was expected to sell during the scorecard period.',
    `nps_benchmark` DECIMAL(18,2) COMMENT 'The target or industry benchmark NPS score the dealer is expected to meet or exceed.',
    `nps_score` DECIMAL(18,2) COMMENT 'The Net Promoter Score measuring customer loyalty and likelihood to recommend the dealer, calculated as percentage of promoters minus percentage of detractors.',
    `parts_fill_rate_pct` DECIMAL(18,2) COMMENT 'The percentage of parts orders fulfilled from dealer inventory without backorder during the scorecard period.',
    `parts_revenue_actual` DECIMAL(18,2) COMMENT 'The actual parts department revenue generated during the scorecard period.',
    `parts_revenue_objective` DECIMAL(18,2) COMMENT 'The target parts department revenue for the scorecard period.',
    `performance_tier` STRING COMMENT 'The performance tier classification assigned to the dealer based on composite score and key metrics.. Valid values are `platinum|gold|silver|bronze|standard`',
    `period_type` STRING COMMENT 'The frequency of the scorecard evaluation period.. Valid values are `monthly|quarterly|annual`',
    `published_date` DATE COMMENT 'The date this scorecard was officially published and communicated to the dealer.',
    `reviewer_name` STRING COMMENT 'The name of the OEM regional manager or analyst who reviewed and approved this scorecard.',
    `scorecard_period_end_date` DATE COMMENT 'The last day of the evaluation period covered by this scorecard.',
    `scorecard_period_start_date` DATE COMMENT 'The first day of the evaluation period covered by this scorecard (monthly or quarterly).',
    `scorecard_status` STRING COMMENT 'The current status of this scorecard record in its lifecycle.. Valid values are `draft|published|final|revised`',
    `service_absorption_rate_pct` DECIMAL(18,2) COMMENT 'The percentage of fixed operations expenses covered by service and parts gross profit, a key profitability metric for dealer operations.',
    `service_revenue_actual` DECIMAL(18,2) COMMENT 'The actual service department revenue generated during the scorecard period.',
    `service_revenue_objective` DECIMAL(18,2) COMMENT 'The target service department revenue for the scorecard period.',
    `training_compliance_pct` DECIMAL(18,2) COMMENT 'The percentage of required OEM training programs completed by dealer staff during the scorecard period.',
    `used_vehicle_sales_actual` STRING COMMENT 'The actual number of used vehicles sold by the dealer during the scorecard period.',
    `used_vehicle_sales_attainment_pct` DECIMAL(18,2) COMMENT 'The percentage of the used vehicle sales objective achieved by the dealer.',
    `used_vehicle_sales_objective` STRING COMMENT 'The target number of used vehicles the dealer was expected to sell during the scorecard period.',
    `warranty_claim_approval_rate_pct` DECIMAL(18,2) COMMENT 'The percentage of warranty claims submitted by the dealer that were approved by the OEM during the scorecard period.',
    CONSTRAINT pk_performance_scorecard PRIMARY KEY(`performance_scorecard_id`)
) COMMENT 'Periodic (monthly/quarterly) dealer performance scorecard capturing KPIs across sales, service, parts, customer satisfaction, and facility standards. Tracks new vehicle sales vs objective, used vehicle sales, service absorption rate, CSI (Customer Satisfaction Index) score, NPS (Net Promoter Score), parts fill rate, and overall composite score. Used for franchise compliance and incentive eligibility determination.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ADD CONSTRAINT `fk_dealer_franchise_agreement_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ADD CONSTRAINT `fk_dealer_territory_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ADD CONSTRAINT `fk_dealer_territory_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ADD CONSTRAINT `fk_dealer_certification_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ADD CONSTRAINT `fk_dealer_vehicle_allocation_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`territory`(`territory_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ADD CONSTRAINT `fk_dealer_dealer_inventory_vehicle_allocation_id` FOREIGN KEY (`vehicle_allocation_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`vehicle_allocation`(`vehicle_allocation_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ADD CONSTRAINT `fk_dealer_retail_sale_dealer_inventory_id` FOREIGN KEY (`dealer_inventory_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealer_inventory`(`dealer_inventory_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ADD CONSTRAINT `fk_dealer_retail_sale_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ADD CONSTRAINT `fk_dealer_dealer_service_appointment_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ADD CONSTRAINT `fk_dealer_dealer_repair_order_dealer_service_appointment_id` FOREIGN KEY (`dealer_service_appointment_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealer_service_appointment`(`dealer_service_appointment_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ADD CONSTRAINT `fk_dealer_dealer_repair_order_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ADD CONSTRAINT `fk_dealer_performance_scorecard_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ADD CONSTRAINT `fk_dealer_performance_scorecard_dealership_id` FOREIGN KEY (`dealership_id`) REFERENCES `vibe_automotive_v1`.`dealer`.`dealership`(`dealership_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`dealer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_automotive_v1`.`dealer` SET TAGS ('dbx_domain' = 'dealer');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` SET TAGS ('dbx_subdomain' = 'dealer_profile');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealership ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Dealer Network Activation Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `adas_certified` SET TAGS ('dbx_business_glossary_term' = 'Advanced Driver Assistance Systems (ADAS) Certified Dealer Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Dealer Street Address Line 1');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Dealer Street Address Line 2');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `cdk_dealer_code` SET TAGS ('dbx_business_glossary_term' = 'CDK Global Dealer Management System (DMS) Dealer ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `cdk_dealer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `channel_classification` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Classification');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `channel_classification` SET TAGS ('dbx_value_regex' = 'retail|fleet|wholesale|online|agency|export');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Dealer City');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Dealer Network Deactivation Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `dealer_code` SET TAGS ('dbx_business_glossary_term' = 'Dealer Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `dealer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `dealer_status` SET TAGS ('dbx_business_glossary_term' = 'Dealer Operational Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `dealer_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated|under_review');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `dealer_tier` SET TAGS ('dbx_business_glossary_term' = 'Dealer Performance Tier');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `dealer_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `dms_go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Dealer Management System (DMS) Go-Live Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `dms_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Dealer Management System (DMS) Integration Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `dms_integration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_setup|error|suspended');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `ev_certified` SET TAGS ('dbx_business_glossary_term' = 'Electric Vehicle (EV) Certified Dealer Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `ev_charger_count` SET TAGS ('dbx_business_glossary_term' = 'Electric Vehicle (EV) Charger Count');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Number');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `franchise_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Expiry Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `franchise_start_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Start Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `franchise_type` SET TAGS ('dbx_business_glossary_term' = 'Franchise Type');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `franchise_type` SET TAGS ('dbx_value_regex' = 'oem_owned|independent_franchise|authorized_repairer|fleet_only|used_vehicle_only|satellite');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `home_delivery_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Home Delivery Enabled');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `last_mile_delivery_radius_km` SET TAGS ('dbx_business_glossary_term' = 'Last Mile Delivery Radius');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Dealer Geolocation Latitude');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Dealer Legal Entity Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Dealer Geolocation Longitude');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `lot_capacity` SET TAGS ('dbx_business_glossary_term' = 'Dealer Lot Vehicle Capacity');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `market_region_code` SET TAGS ('dbx_business_glossary_term' = 'Market Region Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `market_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `new_vehicle_sales_capacity` SET TAGS ('dbx_business_glossary_term' = 'New Vehicle Annual Sales Capacity');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `oem_brand_codes` SET TAGS ('dbx_business_glossary_term' = 'Authorized OEM Brand Codes');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `ownership_group_name` SET TAGS ('dbx_business_glossary_term' = 'Dealer Ownership Group Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `ownership_group_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `parts_warehouse_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Parts Warehouse Area (Square Metres)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `pdi_certified` SET TAGS ('dbx_business_glossary_term' = 'Pre-Delivery Inspection (PDI) Certified Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Dealer Postal Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9 -]{3,10}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Dealer Primary Email Address');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `primary_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Dealer Primary Phone Number');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `primary_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `primary_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `principal_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Dealer Principal Contact Email Address');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `principal_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `principal_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `principal_contact_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `principal_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Dealer Principal Contact Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `principal_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `principal_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `sales_district_code` SET TAGS ('dbx_business_glossary_term' = 'Sales District Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `sales_district_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `sap_customer_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Customer Number');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `sap_customer_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `service_bay_count` SET TAGS ('dbx_business_glossary_term' = 'Service Bay Count');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `showroom_display_capacity` SET TAGS ('dbx_business_glossary_term' = 'Showroom Display Vehicle Capacity');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Dealer Trading Name (DBA)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `used_vehicle_sales_capacity` SET TAGS ('dbx_business_glossary_term' = 'Used Vehicle Annual Sales Capacity');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `warranty_authorized` SET TAGS ('dbx_business_glossary_term' = 'OEM Warranty Repair Authorization Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Dealer Website URL');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[^s]{3,255}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealership` ALTER COLUMN `yard_slot_capacity` SET TAGS ('dbx_business_glossary_term' = 'Yard Slot Capacity');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` SET TAGS ('dbx_subdomain' = 'dealer_profile');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `warranty_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Warranty Policy Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `agreement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Currency Code (ISO 4217)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `agreement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `agreement_document_url` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Document URL');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `agreement_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Number');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^FA-[0-9]{8}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Type');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'new_franchise|renewal|amendment|expansion|termination');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `allocation_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Allocation Priority Tier');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `allocation_priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|standard');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `authorized_nameplates` SET TAGS ('dbx_business_glossary_term' = 'Authorized Vehicle Nameplates');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `authorized_vehicle_lines` SET TAGS ('dbx_business_glossary_term' = 'Authorized Vehicle Lines');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Auto-Renewal Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `certified_pre_owned_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Certified Pre-Owned (CPO) Authorized Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `commercial_fleet_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Fleet Sales Authorized Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `customer_satisfaction_target_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Target Score (NPS)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `dealer_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Dealer Signatory Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `digital_retailing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Retailing Required Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `dms_integration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Dealer Management System (DMS) Integration Required Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Effective Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `ev_charging_infrastructure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Electric Vehicle (EV) Charging Infrastructure Required Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `exclusive_territory_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Territory Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Expiration Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `facility_investment_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Facility Investment Requirement Amount (CapEx)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `facility_investment_requirement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `franchise_tier` SET TAGS ('dbx_business_glossary_term' = 'Franchise Tier');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `franchise_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `home_delivery_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Home Delivery Obligation Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `incentive_program_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Program Eligibility Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `minimum_sales_quota_annual` SET TAGS ('dbx_business_glossary_term' = 'Minimum Annual Sales Quota (Units)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `minimum_service_capacity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Service Capacity (Vehicles per Month)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Notice Period (Days)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `oem_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'OEM (Original Equipment Manufacturer) Signatory Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Ownership Model');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `ownership_model` SET TAGS ('dbx_value_regex' = 'oem_owned|independent_franchise|joint_venture|corporate_store');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `parts_inventory_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Parts Inventory Requirement Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `parts_inventory_requirement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Frequency');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `recall_service_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Service Authorized Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Renewal Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Renewal Term (Months)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Signed Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Termination Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Termination Reason');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Franchise Territory Description');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `territory_radius_km` SET TAGS ('dbx_business_glossary_term' = 'Franchise Territory Radius (Kilometers)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `training_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Certification Required Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`franchise_agreement` ALTER COLUMN `warranty_administration_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Administration Authorized Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` SET TAGS ('dbx_subdomain' = 'dealer_profile');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Territory Identifier (ID)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Identifier (ID)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier (ID)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Product Segment Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `allocation_quota_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Quota Percentage');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `city_list` SET TAGS ('dbx_business_glossary_term' = 'City List');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `competitive_intensity_rating` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intensity Rating');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `competitive_intensity_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `county_region` SET TAGS ('dbx_business_glossary_term' = 'County or Region');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `dms_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Dealer Management System (DMS) Integration Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `dms_integration_status` SET TAGS ('dbx_value_regex' = 'integrated|pending|failed|not_applicable');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `dms_last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dealer Management System (DMS) Last Synchronization Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `geographic_boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary Description');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `home_delivery_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Home Delivery Coverage Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `household_count_estimate` SET TAGS ('dbx_business_glossary_term' = 'Household Count Estimate');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `incentive_program_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Program Eligibility Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Territory Manager Email Address');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Manager Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Territory Manager Phone Number');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `manager_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `modification_reason` SET TAGS ('dbx_business_glossary_term' = 'Modification Reason');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `overlap_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Territory Overlap Allowed Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `overlap_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Overlap Rule Description');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `performance_benchmark_group` SET TAGS ('dbx_business_glossary_term' = 'Performance Benchmark Group');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `population_estimate` SET TAGS ('dbx_business_glossary_term' = 'Population Estimate');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `postal_code_list` SET TAGS ('dbx_business_glossary_term' = 'Postal Code List');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `postal_code_list` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `postal_code_list` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `primary_area_of_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Primary Area of Responsibility (PAR)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `sales_potential_index` SET TAGS ('dbx_business_glossary_term' = 'Sales Potential Index');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `special_program_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Program Notes');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|under_review|terminated');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'exclusive|shared|open|primary|secondary|overlay');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`territory` ALTER COLUMN `vehicle_allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Allocation Priority');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` SET TAGS ('dbx_subdomain' = 'dealer_profile');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Certification Identifier (ID)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier (ID)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `regulatory_body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Product Segment Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `allocation_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Allocation Eligibility Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `annual_maintenance_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Maintenance Cost Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `annual_maintenance_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_value_regex' = 'PASSED|PASSED_WITH_CONDITIONS|FAILED|NOT_APPLICABLE');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|EXPIRED|SUSPENDED|PENDING_RENEWAL|REVOKED|UNDER_REVIEW');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'EV_CERTIFIED|ADAS_SERVICE|LUXURY_BRAND|COMMERCIAL_VEHICLE|HYBRID_SPECIALIST|PERFORMANCE_TUNING');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `equipment_requirements` SET TAGS ('dbx_business_glossary_term' = 'Equipment Requirements');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `facility_requirements` SET TAGS ('dbx_business_glossary_term' = 'Facility Requirements');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'GLOBAL|REGIONAL|NATIONAL|STATE_PROVINCIAL|LOCAL');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `home_delivery_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Home Delivery Certified Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `incentive_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Eligibility Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_value_regex' = 'BRONZE|SILVER|GOLD|PLATINUM|ELITE|STANDARD');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `minimum_certified_technicians` SET TAGS ('dbx_business_glossary_term' = 'Minimum Certified Technicians');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `personnel_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personnel Requirements');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency in Months');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`certification` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` SET TAGS ('dbx_subdomain' = 'sales_operations');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `vehicle_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Allocation ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `fleet_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Contract Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Territory Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `acceptance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Deadline');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `allocation_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Batch Number');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Number');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^ALLOC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `allocation_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|accepted|rejected|cancelled|delivered');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'standard|priority|constrained|fleet|demo|loaner');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `dealer_invoice_price` SET TAGS ('dbx_business_glossary_term' = 'Dealer Invoice Price');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `dealer_invoice_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `dms_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Dealer Management System (DMS) Reference Number');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `hold_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Hold Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `incentive_program_code` SET TAGS ('dbx_business_glossary_term' = 'Incentive Program Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `is_customer_order` SET TAGS ('dbx_business_glossary_term' = 'Customer Order Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `last_mile_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Last Mile Delivery Method');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `msrp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `pdi_completed` SET TAGS ('dbx_business_glossary_term' = 'Pre-Delivery Inspection (PDI) Completed Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `pdi_required` SET TAGS ('dbx_business_glossary_term' = 'Pre-Delivery Inspection (PDI) Required Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `port_of_entry_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Entry Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `port_of_entry_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,5}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `scheduled_production_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Production Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_SD|CDK_DMS|SALESFORCE|MES|MANUAL');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'rail|truck|ship|compound');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`vehicle_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` SET TAGS ('dbx_subdomain' = 'sales_operations');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `dealer_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Inventory ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Campaign Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `service_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Service Campaign Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `vehicle_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Allocation Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `vehicle_build_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Build Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `asking_price` SET TAGS ('dbx_business_glossary_term' = 'Current Asking Price');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `asking_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `certified_pre_owned` SET TAGS ('dbx_business_glossary_term' = 'Certified Pre-Owned (CPO) Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `days_on_lot` SET TAGS ('dbx_business_glossary_term' = 'Days on Lot');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `dms_record_reference` SET TAGS ('dbx_business_glossary_term' = 'DMS Record ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `dwell_time_days` SET TAGS ('dbx_business_glossary_term' = 'Dwell Time Days');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `engine_description` SET TAGS ('dbx_business_glossary_term' = 'Engine Description');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `estimated_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `exterior_color_code` SET TAGS ('dbx_business_glossary_term' = 'Exterior Color Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `exterior_color_name` SET TAGS ('dbx_business_glossary_term' = 'Exterior Color Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `floor_plan_date` SET TAGS ('dbx_business_glossary_term' = 'Floor Plan Start Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `floor_plan_lender` SET TAGS ('dbx_business_glossary_term' = 'Floor Plan Lender');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `floor_plan_lender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `fuel_economy_city_mpg` SET TAGS ('dbx_business_glossary_term' = 'City Fuel Economy (MPG)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `fuel_economy_highway_mpg` SET TAGS ('dbx_business_glossary_term' = 'Highway Fuel Economy (MPG)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `interior_color_code` SET TAGS ('dbx_business_glossary_term' = 'Interior Color Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `interior_color_name` SET TAGS ('dbx_business_glossary_term' = 'Interior Color Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `inventory_type` SET TAGS ('dbx_value_regex' = 'new|used|certified_pre_owned|demo|loaner');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `invoice_price` SET TAGS ('dbx_business_glossary_term' = 'Invoice Price');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `invoice_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `last_price_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Price Update Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Lot Location Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `msrp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading (Miles)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `pdi_completed` SET TAGS ('dbx_business_glossary_term' = 'Pre-Delivery Inspection (PDI) Completed Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `pdi_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Delivery Inspection (PDI) Completion Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `recall_hold` SET TAGS ('dbx_business_glossary_term' = 'Recall Hold Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Source Type');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'factory_order|dealer_trade|auction|trade_in|fleet_return|lease_return');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `stock_number` SET TAGS ('dbx_business_glossary_term' = 'Dealer Stock Number');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `transport_status` SET TAGS ('dbx_business_glossary_term' = 'Transport Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `transport_status` SET TAGS ('dbx_value_regex' = 'not_shipped|in_transit|delivered|rail|truck');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `window_sticker_url` SET TAGS ('dbx_business_glossary_term' = 'Window Sticker URL (Monroney Label)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_inventory` ALTER COLUMN `yard_slot_code` SET TAGS ('dbx_business_glossary_term' = 'Yard Slot Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` SET TAGS ('dbx_subdomain' = 'sales_operations');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `retail_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Sale ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `dealer_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Inventory Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `msrp_price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Msrp Price Book Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `apr` SET TAGS ('dbx_business_glossary_term' = 'Annual Percentage Rate (APR)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `apr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `back_end_gross` SET TAGS ('dbx_business_glossary_term' = 'Back-End Gross Profit');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `back_end_gross` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `deal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `deal_status` SET TAGS ('dbx_value_regex' = 'draft|pending|funded|unwound|cancelled');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Delivery Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `dms_deal_reference` SET TAGS ('dbx_business_glossary_term' = 'Dealer Management System (DMS) Deal ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `doc_fee` SET TAGS ('dbx_business_glossary_term' = 'Documentation Fee');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `down_payment` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `down_payment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `down_payment` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `fi_product_revenue` SET TAGS ('dbx_business_glossary_term' = 'Finance and Insurance (F&I) Product Revenue');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `fi_product_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `finance_amount` SET TAGS ('dbx_business_glossary_term' = 'Finance Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `finance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `finance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `financing_type` SET TAGS ('dbx_business_glossary_term' = 'Financing Type');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `financing_type` SET TAGS ('dbx_value_regex' = 'cash|retail_finance|lease|balloon');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `fleet_sale` SET TAGS ('dbx_business_glossary_term' = 'Fleet Sale Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `front_end_gross` SET TAGS ('dbx_business_glossary_term' = 'Front-End Gross Profit');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `front_end_gross` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `lender_name` SET TAGS ('dbx_business_glossary_term' = 'Lender Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `loan_term_months` SET TAGS ('dbx_business_glossary_term' = 'Loan Term (Months)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `monthly_payment` SET TAGS ('dbx_business_glossary_term' = 'Monthly Payment Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `monthly_payment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `monthly_payment` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `msrp_amount` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `msrp_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `oem_incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'OEM Incentive Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `oem_incentive_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `pdi_completed` SET TAGS ('dbx_business_glossary_term' = 'Pre-Delivery Inspection (PDI) Completed Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `sale_date` SET TAGS ('dbx_business_glossary_term' = 'Sale Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `sale_price` SET TAGS ('dbx_business_glossary_term' = 'Sale Price');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `sale_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `sale_price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `sales_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Tax Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `trade_in_allowance` SET TAGS ('dbx_business_glossary_term' = 'Trade-In Allowance');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `trade_in_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `trade_in_payoff_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade-In Payoff Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `trade_in_payoff_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `vehicle_condition` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Condition');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`retail_sale` ALTER COLUMN `vehicle_condition` SET TAGS ('dbx_value_regex' = 'new|used|certified_pre_owned');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` SET TAGS ('dbx_subdomain' = 'service_performance');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `dealer_service_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for dealer_service_appointment');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `aftersales_service_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Aftersales Service Appointment Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealership Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `appointment_time` SET TAGS ('dbx_business_glossary_term' = 'Appointment Time');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `customer_concern` SET TAGS ('dbx_business_glossary_term' = 'Customer Concern');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `customer_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `customer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `customer_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Phone');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `customer_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `drop_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Drop Off Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_money' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `home_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Home Service Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `loaner_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Loaner Required');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `mileage_at_service` SET TAGS ('dbx_business_glossary_term' = 'Mileage at Service');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pickup Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_service_appointment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` SET TAGS ('dbx_subdomain' = 'service_performance');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `dealer_repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for dealer_repair_order');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `aftersales_repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Aftersales Repair Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `dealer_service_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Service Appointment Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealership Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Campaign Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Cause');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Close Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `correction_description` SET TAGS ('dbx_business_glossary_term' = 'Correction');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `labor_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `mileage` SET TAGS ('dbx_business_glossary_term' = 'Mileage');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Open Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `parts_amount` SET TAGS ('dbx_business_glossary_term' = 'Parts Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `pickup_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Pickup Delivery Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `ro_number` SET TAGS ('dbx_business_glossary_term' = 'RO Number');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `ro_status` SET TAGS ('dbx_business_glossary_term' = 'RO Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `total_labor_amount` SET TAGS ('dbx_money' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`dealer_repair_order` ALTER COLUMN `total_parts_amount` SET TAGS ('dbx_money' = 'true');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` SET TAGS ('dbx_subdomain' = 'service_performance');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `performance_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Scorecard ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer ID');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Product Segment Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `composite_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Score');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `composite_score_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Composite Score Benchmark');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `csi_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Index (CSI) Benchmark');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `csi_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Index (CSI) Score');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `delivery_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Delivery Satisfaction Score');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `dms_integration_source` SET TAGS ('dbx_business_glossary_term' = 'Dealer Management System (DMS) Integration Source');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `dms_integration_source` SET TAGS ('dbx_value_regex' = 'CDK_Global|Reynolds_Reynolds|Dealertrack|ADP|Other');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `facility_standards_score` SET TAGS ('dbx_business_glossary_term' = 'Facility Standards Score');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `franchise_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Franchise Compliance Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `franchise_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|probation|warning');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `incentive_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Eligibility Flag');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `inventory_turn_rate` SET TAGS ('dbx_business_glossary_term' = 'Inventory Turn Rate');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `market_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Market Share Percentage');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `new_vehicle_sales_actual` SET TAGS ('dbx_business_glossary_term' = 'New Vehicle Sales Actual');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `new_vehicle_sales_attainment_pct` SET TAGS ('dbx_business_glossary_term' = 'New Vehicle Sales Attainment Percentage');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `new_vehicle_sales_objective` SET TAGS ('dbx_business_glossary_term' = 'New Vehicle Sales Objective');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `nps_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Benchmark');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `parts_fill_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Parts Fill Rate Percentage');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `parts_revenue_actual` SET TAGS ('dbx_business_glossary_term' = 'Parts Revenue Actual');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `parts_revenue_objective` SET TAGS ('dbx_business_glossary_term' = 'Parts Revenue Objective');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `scorecard_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Period End Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `scorecard_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Period Start Date');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|published|final|revised');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `service_absorption_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Absorption Rate Percentage');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `service_revenue_actual` SET TAGS ('dbx_business_glossary_term' = 'Service Revenue Actual');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `service_revenue_objective` SET TAGS ('dbx_business_glossary_term' = 'Service Revenue Objective');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `training_compliance_pct` SET TAGS ('dbx_business_glossary_term' = 'Training Compliance Percentage');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `used_vehicle_sales_actual` SET TAGS ('dbx_business_glossary_term' = 'Used Vehicle Sales Actual');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `used_vehicle_sales_attainment_pct` SET TAGS ('dbx_business_glossary_term' = 'Used Vehicle Sales Attainment Percentage');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `used_vehicle_sales_objective` SET TAGS ('dbx_business_glossary_term' = 'Used Vehicle Sales Objective');
ALTER TABLE `vibe_automotive_v1`.`dealer`.`performance_scorecard` ALTER COLUMN `warranty_claim_approval_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Approval Rate Percentage');
