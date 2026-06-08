-- Schema for Domain: product | Business: Automotive | Version: v1_ecm
-- Generated on: 2026-05-07 00:14:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `automotive_ecm`.`product` COMMENT 'SSOT for the commercial vehicle product catalog and program portfolio. Owns nameplate definitions, model year program plans, option and package configurations, BOM (Bill of Materials) product structures, MSRP price books, feature-to-market availability matrices, and SKU (Stock Keeping Unit) structures. Distinct from engineering (which owns technical design data) and vehicle (which owns VIN-level production instances).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `automotive_ecm`.`product`.`bom_header` (
    `bom_header_id` BIGINT COMMENT 'Unique identifier for the BOM header record. Primary key for the commercial product-level BOM structure.',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_bom. Business justification: Product BOM generation uses the Engineering BOM version; needed for the BOM Release Report and change control.',
    `adas_level` STRING COMMENT 'The SAE autonomy level supported by this BOM configuration. L0 = no automation; L1 = driver assistance; L2 = partial automation; L3 = conditional automation; L4 = high automation; L5 = full automation. Drives Electronic Control Unit (ECU) content and software Over-the-Air (OTA) update requirements.. Valid values are `L0|L1|L2|L3|L4|L5`',
    `alternative_bom_group` STRING COMMENT 'Grouping identifier for alternative BOM configurations that serve the same functional purpose but differ in sourcing, supplier, or regional requirements. Supports supply chain flexibility and dual-sourcing strategies.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `approved_by` STRING COMMENT 'The user ID or name of the product manager, engineering lead, or quality authority who approved this BOM for production release. Supports accountability and PPAP documentation requirements.. Valid values are `^[A-Z0-9_]{3,50}$`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM was formally approved for production use. Milestone timestamp for traceability and regulatory compliance documentation.',
    `base_unit_of_measure` STRING COMMENT 'The unit in which the BOM header quantity is expressed. Typically EA (each) for complete vehicle assemblies or KIT for bundled option packages.. Valid values are `EA|PC|SET|KIT|ASSY`',
    `bom_status` STRING COMMENT 'Current lifecycle state of the BOM header. Active BOMs are in production use; superseded BOMs have been replaced by newer revisions; obsolete BOMs are end-of-life; frozen BOMs are locked for regulatory or homologation purposes.. Valid values are `draft|active|superseded|obsolete|frozen|pending_approval`',
    `bom_type` STRING COMMENT 'Classification of the BOM purpose. Commercial BOMs are product-domain owned structures for SKU definition and pricing; engineering BOMs are design structures owned by engineering domain; service BOMs support after-sales parts; manufacturing BOMs are plant-specific production structures.. Valid values are `commercial|engineering|service|manufacturing|planning|sales`',
    `bom_usage` STRING COMMENT 'The intended application context for this BOM. Production BOMs are for series manufacturing; prototype BOMs support R&D; CKD (Completely Knocked Down) and SKD (Semi Knocked Down) BOMs are for export assembly operations. [ENUM-REF-CANDIDATE: production|prototype|pre_series|pilot|service|CKD|SKD — 7 candidates stripped; promote to reference product]',
    `change_number` STRING COMMENT 'The most recent engineering change order identifier that modified this BOM. Links to PLM change management workflows and supports traceability for Failure Mode and Effects Analysis (FMEA) and corrective actions.. Valid values are `^ECO-[A-Z0-9]{6,15}$`',
    `configuration_profile` STRING COMMENT 'A coded representation of the option and feature set included in this BOM. Used for variant configuration in SAP SD, dealer ordering systems (DMS), and customer configurators.. Valid values are `^[A-Z0-9_]{3,30}$`',
    `connectivity_package` STRING COMMENT 'The level of connected vehicle and telematics capability included in this BOM. Basic = 4G LTE; Premium = 5G with cloud services; V2X = Vehicle-to-Everything communication for smart city integration.. Valid values are `none|basic|premium|V2X`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM header record was first created in the system. Audit trail for data lineage and compliance with ISO 9001 quality management documentation requirements.',
    `effective_from_date` DATE COMMENT 'The date from which this BOM version becomes valid and applicable for production, sales configuration, and order fulfillment. Aligns with model year start or mid-year product refresh timing.',
    `effective_to_date` DATE COMMENT 'The date until which this BOM version remains valid. Nullable for open-ended BOMs. Used to manage model year transitions, End of Production (EOP), and product phase-out scenarios.',
    `emissions_standard` STRING COMMENT 'The regulatory emissions certification standard that this BOM configuration meets. Determines legal salability in jurisdictions with emissions regulations (EPA, CARB, UNECE).. Valid values are `EPA_TIER3|CARB_LEV3|EURO6|EURO7|CHINA6|BS6`',
    `engineering_release_date` DATE COMMENT 'The date on which the engineering design for this BOM was formally released from the Product Lifecycle Management (PLM) system (Teamcenter, Windchill) to manufacturing. Marks the transition from design to production readiness.',
    `eop_date` DATE COMMENT 'The planned or actual date when series production ceases for this BOM configuration. Triggers service parts planning, warranty reserve calculations, and dealer inventory clearance programs.',
    `homologation_status` STRING COMMENT 'The regulatory approval state for this BOM configuration. Certified BOMs have passed all required safety, emissions, and compliance testing (NCAP, FMVSS, WLTP). Required for legal sale and registration in target markets.. Valid values are `pending|approved|certified|rejected|expired`',
    `is_configurable` BOOLEAN COMMENT 'Indicates whether this BOM supports customer-selectable options and variant configuration. True for BOMs with option packages; False for fixed-configuration BOMs. Drives dealer ordering system behavior and customer configurator logic.',
    `lot_size_minimum` STRING COMMENT 'The minimum production batch quantity for which this BOM is economically viable. Drives production scheduling, changeover planning, and capacity utilization in Manufacturing Execution Systems (MES).',
    `market_region` STRING COMMENT 'The geographic market or regulatory region for which this BOM is configured. Drives homologation requirements (UNECE, Euro NCAP, NHTSA), emissions standards (EPA, CARB, WLTP), and localized feature content. [ENUM-REF-CANDIDATE: NAM|EUR|CHN|JPN|MEA|LATAM|APAC — 7 candidates stripped; promote to reference product]',
    `model_year` STRING COMMENT 'The model year designation for which this BOM is applicable. Critical for automotive product lifecycle management, regulatory compliance (CAFE, EPA ratings), and dealer ordering systems.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM header record was last updated. Supports change tracking, audit trails, and synchronization with PLM and ERP systems.',
    `msrp_base_amount` DECIMAL(18,2) COMMENT 'The baseline MSRP for this BOM configuration before options, packages, and destination charges. Used for dealer pricing, customer quotations, and competitive positioning. Currency is USD unless otherwise specified in market-specific price books.',
    `nameplate_code` STRING COMMENT 'The brand or model nameplate identifier (e.g., F-150, Camry, Model_S) that this BOM supports. Links to the commercial product catalog and marketing nomenclature.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or cross-references related to this BOM. May include links to Technical Service Bulletins (TSB), engineering memos, or supplier coordination notes.',
    `plant_code` STRING COMMENT 'The production plant or assembly facility where this BOM is applicable. Supports multi-plant manufacturing strategies, regional sourcing variations, and Just-in-Time (JIT) / Just-in-Sequence (JIS) supply chain execution.. Valid values are `^[A-Z0-9]{4,10}$`',
    `powertrain_type` STRING COMMENT 'The propulsion system category for this BOM. ICE = Internal Combustion Engine; HEV = Hybrid Electric Vehicle; PHEV = Plug-in Hybrid Electric Vehicle; BEV = Battery Electric Vehicle; FCEV = Fuel Cell Electric Vehicle. Drives component selection, regulatory compliance (EPA, CARB), and dealer training requirements.. Valid values are `ICE|HEV|PHEV|BEV|FCEV`',
    `revision_level` STRING COMMENT 'Version identifier for this BOM iteration. Incremented with each engineering change order (ECO) or product configuration update. Supports traceability for Production Part Approval Process (PPAP) and Advanced Product Quality Planning (APQP).. Valid values are `^[A-Z0-9]{1,10}$`',
    `safety_certification_level` STRING COMMENT 'The crash test rating achieved by this BOM configuration from New Car Assessment Programme (NCAP) testing. Influences marketing claims, insurance premiums, and regulatory compliance in target markets.. Valid values are `5_star|4_star|3_star|not_rated|pending`',
    `sop_date` DATE COMMENT 'The planned or actual date when series production begins for this BOM configuration. Critical milestone for supply chain activation, dealer allocation planning, and launch readiness.',
    `source_system` STRING COMMENT 'The originating system of record for this BOM header. Identifies whether the BOM was created in SAP, PLM (Teamcenter, Windchill, ENOVIA), or manually entered. Supports data lineage and integration troubleshooting.. Valid values are `SAP_MM|SAP_PP|TEAMCENTER|WINDCHILL|ENOVIA|MANUAL`',
    `standard_cost_amount` DECIMAL(18,2) COMMENT 'The planned manufacturing cost for this BOM at standard production volumes. Includes material, labor, and overhead. Used for margin analysis, make-vs-buy decisions, and financial planning. Currency is USD unless otherwise specified.',
    `total_assembly_weight_kg` DECIMAL(18,2) COMMENT 'The cumulative weight of all components in this BOM, expressed in kilograms. Critical for vehicle curb weight calculation, Corporate Average Fuel Economy (CAFE) compliance, and freight logistics planning.',
    `total_component_count` STRING COMMENT 'The total number of distinct component line items (BOM components) included in this BOM structure. Used for complexity assessment, supply chain planning, and Material Requirements Planning (MRP).',
    `variant_code` STRING COMMENT 'Product variant or trim level identifier (e.g., LX, Sport, Premium, AWD). Differentiates configurations within a nameplate for option package and feature matrix management.. Valid values are `^[A-Z0-9_]{2,15}$`',
    `vin_pattern` STRING COMMENT 'The VIN prefix or pattern template associated with this BOM configuration. Positions 1-11 of the VIN encode manufacturer, plant, model, and body style. Supports VIN decoding and vehicle domain linkage.. Valid values are `^[A-HJ-NPR-Z0-9*]{17}$`',
    `warranty_program_code` STRING COMMENT 'The standard warranty coverage program applicable to this BOM configuration. Links to warranty claim processing, service bulletin distribution, and Total Cost of Ownership (TCO) calculations.. Valid values are `^[A-Z0-9_]{3,15}$`',
    CONSTRAINT pk_bom_header PRIMARY KEY(`bom_header_id`)
) COMMENT 'Product-level BOM (Bill of Materials) header record representing the commercial product structure for a given SKU or model year program. Captures BOM number, BOM type (commercial/engineering/service), effective date range, revision level, plant applicability, BOM status (active/superseded/obsolete), and total component count. This is the commercial BOM owned by the product domain — distinct from the engineering BOM managed in Teamcenter/Windchill, which is owned by the engineering domain.';

CREATE OR REPLACE TABLE `automotive_ecm`.`product`.`product_bom_line` (
    `product_bom_line_id` BIGINT COMMENT 'Unique identifier for the product_bom_line data product (auto-inserted pre-linking).',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Product BOM line items belong to a BOM header; the FK creates the required parent‑child relationship.',
    CONSTRAINT pk_product_bom_line PRIMARY KEY(`product_bom_line_id`)
) COMMENT 'Individual component line items within a product BOM (Bill of Materials). Captures BOM line number, part number, part description, part type (raw material/sub-assembly/purchased component/fastener), quantity per vehicle, unit of measure, effective date range, plant applicability, alternative item group, scrap factor percentage, and PPAP (Production Part Approval Process) status. Enables product cost rollup, MRP (Material Requirements Planning) explosion, and supply chain sourcing alignment.';

CREATE OR REPLACE TABLE `automotive_ecm`.`product`.`product_segment` (
    `product_segment_id` BIGINT COMMENT 'Unique identifier for the vehicle market segment. Primary key.',
    `parent_segment_product_segment_id` BIGINT COMMENT 'Reference to the parent segment in the hierarchy. Null for top-level segments.',
    `adas_level_range` STRING COMMENT 'Range of SAE automation levels typically offered in this segment (e.g., L0-L2, L2-L3), following SAE J3016 standard.. Valid values are `^L[0-5]-L[0-5]$`',
    `annual_sales_volume_target` STRING COMMENT 'Target annual sales volume across all nameplates in this segment, used for capacity planning and market share analysis.',
    `body_style_category` STRING COMMENT 'Primary body style category associated with this segment (e.g., sedan, SUV, pickup, van, coupe). [ENUM-REF-CANDIDATE: sedan|coupe|hatchback|suv|crossover|pickup|van|wagon|convertible|roadster|minivan|commercial — 12 candidates stripped; promote to reference product]',
    `cafe_fleet_category` STRING COMMENT 'CAFE fleet category for fuel economy averaging and compliance (e.g., passenger car, light truck, medium-duty, heavy-duty, exempt).. Valid values are `passenger_car|light_truck|medium_duty|heavy_duty|exempt`',
    `cargo_volume_range_cu_ft` STRING COMMENT 'Typical cargo volume range for vehicles in this segment, measured in cubic feet (e.g., 10-20, 30-50).',
    `competitive_set_definition` STRING COMMENT 'Description of the competitive set for this segment, listing key competitor nameplates and brands used for benchmarking and market share analysis.',
    `connectivity_capability` STRING COMMENT 'Typical connectivity capability level for vehicles in this segment (e.g., none, basic telematics, advanced connected services, V2X, full connected mobility).. Valid values are `none|basic|advanced|v2x|full_connected`',
    `created_by_user` STRING COMMENT 'User identifier of the person who created this segment record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this segment definition was retired or superseded. Null for currently active segments.',
    `effective_start_date` DATE COMMENT 'Date when this segment definition became effective for market planning and reporting purposes.',
    `emissions_standard_target` STRING COMMENT 'Target emissions standard for vehicles in this segment (e.g., EPA Tier 3, Euro 6d, CARB LEV III, WLTP Class 3).',
    `hierarchy_level` STRING COMMENT 'Numeric level in the segment hierarchy tree (e.g., 1 for top-level categories like Passenger Vehicle, 2 for sub-categories like SUV, 3 for granular segments like Compact SUV).',
    `homologation_regions` STRING COMMENT 'Comma-separated list of regions where this segment is homologated and available for sale (e.g., USA, CAN, MEX, EUR, CHN, JPN, AUS).',
    `industry_classification_code` STRING COMMENT 'Additional industry-standard classification code from bodies such as UNECE, EPA, or regional automotive authorities.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this segment is currently active and used in market planning, competitive analysis, and sales reporting.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the market segment (e.g., emerging, growth, mature, declining, discontinued).. Valid values are `emerging|growth|mature|declining|discontinued`',
    `market_positioning_tier` STRING COMMENT 'Market positioning tier for competitive analysis (e.g., economy, mainstream, premium, luxury, performance, commercial).. Valid values are `economy|mainstream|premium|luxury|performance|commercial`',
    `market_share_target_pct` DECIMAL(18,2) COMMENT 'Target market share percentage for this segment within the total addressable market.',
    `modified_by_user` STRING COMMENT 'User identifier of the person who last modified this segment record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was last modified.',
    `ncap_rating_applicability` STRING COMMENT 'Applicable NCAP rating program for safety assessment in this segment (e.g., Euro NCAP, US NCAP, China NCAP, Latin NCAP, ASEAN NCAP).. Valid values are `euro_ncap|us_ncap|china_ncap|latin_ncap|asean_ncap|not_applicable`',
    `ota_update_capability` BOOLEAN COMMENT 'Indicates whether vehicles in this segment typically support OTA software updates.',
    `powertrain_category` STRING COMMENT 'Primary powertrain type associated with this segment: ICE (Internal Combustion Engine), HEV (Hybrid Electric Vehicle), PHEV (Plug-in Hybrid Electric Vehicle), BEV (Battery Electric Vehicle), FCEV (Fuel Cell Electric Vehicle), or Hybrid.. Valid values are `ice|hev|phev|bev|fcev|hybrid`',
    `price_range_max_usd` DECIMAL(18,2) COMMENT 'Maximum Manufacturer Suggested Retail Price (MSRP) for vehicles in this segment, in USD.',
    `price_range_min_usd` DECIMAL(18,2) COMMENT 'Minimum Manufacturer Suggested Retail Price (MSRP) for vehicles in this segment, in USD.',
    `primary_use_case` STRING COMMENT 'Primary intended use case for vehicles in this segment (e.g., personal commuting, family transportation, commercial delivery, fleet operations, performance driving, luxury travel, utility work). [ENUM-REF-CANDIDATE: personal|family|commercial|fleet|performance|luxury|utility — 7 candidates stripped; promote to reference product]',
    `regulatory_category` STRING COMMENT 'Regulatory classification category used for compliance reporting (e.g., passenger car, light truck, medium-duty vehicle, heavy-duty vehicle) as defined by NHTSA, EPA, or CARB.',
    `sae_classification_code` STRING COMMENT 'SAE International standard classification code for vehicle type and segment (e.g., J1979, J2735 vehicle class codes).. Valid values are `^[A-Z0-9]{2,8}$`',
    `seating_capacity_range` STRING COMMENT 'Typical seating capacity range for vehicles in this segment (e.g., 2-4, 5-7, 8-12).. Valid values are `^[0-9]{1,2}-[0-9]{1,2}$`',
    `segment_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the market segment (e.g., COMP-CAR, MID-SUV, FULL-PKP).. Valid values are `^[A-Z0-9]{3,10}$`',
    `segment_description` STRING COMMENT 'Detailed description of the market segment, including typical characteristics, target customer profile, and competitive positioning.',
    `segment_name` STRING COMMENT 'Full business name of the vehicle market segment (e.g., Compact Car, Midsize SUV, Full-Size Pickup, Commercial Van, Luxury Sedan, Electric Crossover).',
    `strategic_priority` STRING COMMENT 'Strategic priority level assigned to this segment for investment and resource allocation decisions.. Valid values are `critical|high|medium|low|sunset`',
    `target_customer_profile` STRING COMMENT 'Description of the primary target customer demographic and psychographic profile for this segment (e.g., young families, urban professionals, fleet operators).',
    CONSTRAINT pk_product_segment PRIMARY KEY(`product_segment_id`)
) COMMENT 'Reference classification of vehicle market segments used to position nameplates competitively (e.g., Compact Car, Midsize SUV, Full-Size Pickup, Commercial Van, Luxury Sedan, Electric Crossover). Captures segment code, segment name, segment hierarchy level, parent segment, SAE/industry classification code, competitive set definition, and applicable regulatory category. Used in market planning, competitive benchmarking, CAFE fleet averaging, and sales reporting.';

CREATE OR REPLACE TABLE `automotive_ecm`.`product`.`catalog_publication` (
    `catalog_publication_id` BIGINT COMMENT 'Unique identifier for the catalog publication event. Primary key.',
    `approved_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who approved the catalog for publication. Supports governance and compliance requirements for catalog release authorization.',
    `catalog_version_id` BIGINT COMMENT 'Reference to the specific catalog version being published. Links to the catalog version master.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that executed the publication event. Used for audit trail and accountability.',
    `primary_catalog_employee_id` BIGINT COMMENT 'Identifier of the user or system account that executed the publication event. Used for audit trail and accountability.',
    `superseded_by_publication_catalog_publication_id` BIGINT COMMENT 'Reference to the newer publication that replaces this one, if applicable. Supports publication version chain tracking.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the catalog publication was formally approved for release. Part of the publication lifecycle audit trail.',
    `approved_by_user_name` STRING COMMENT 'Full name of the approver for human-readable audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the publication record was first created in the system. Represents the start of the publication preparation process.',
    `distribution_confirmation_flag` BOOLEAN COMMENT 'Indicates whether the target system has confirmed successful receipt and processing of the published catalog. True if confirmed, False if pending or failed.',
    `distribution_confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the target system confirmed successful receipt of the catalog publication. Nullable if confirmation is pending or not received.',
    `distribution_method` STRING COMMENT 'Technical method used to distribute the catalog: push (system-initiated send), pull (consumer-initiated retrieval), batch (scheduled bulk transfer), real-time (immediate synchronous), or scheduled (time-based automated).. Valid values are `push|pull|batch|real_time|scheduled`',
    `distribution_retry_count` STRING COMMENT 'Number of times the system attempted to distribute this catalog publication to the target system. Used for monitoring distribution reliability and troubleshooting failures.',
    `effective_end_date` DATE COMMENT 'Date when the published catalog expires and is no longer valid for new orders or configurations. Nullable for open-ended publications.',
    `effective_start_date` DATE COMMENT 'Date when the published catalog becomes active and valid for use in ordering, configuration, and sales processes. May differ from publication date to allow advance distribution.',
    `file_checksum` STRING COMMENT 'Cryptographic hash (e.g., MD5, SHA-256) of the published catalog file to ensure data integrity during transmission and detect corruption.',
    `file_name` STRING COMMENT 'Name of the file or data package containing the published catalog, if applicable. Used for file-based distribution tracking.',
    `file_size_bytes` BIGINT COMMENT 'Size of the published catalog file in bytes. Used for distribution monitoring and capacity planning.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code for the catalog content (e.g., en, fr, de, es, ja). Supports multilingual catalog distribution.. Valid values are `^[a-z]{2}$`',
    `last_distribution_error` STRING COMMENT 'Error message or code from the most recent failed distribution attempt, if applicable. Supports troubleshooting and root cause analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the publication record was last updated. Tracks the most recent change to publication metadata or status.',
    `model_year` STRING COMMENT 'The model year (MY) of the vehicle catalog being published, representing the production year designation for the vehicles in this catalog (e.g., 2024, 2025).',
    `nameplate_count` STRING COMMENT 'Number of distinct nameplates (vehicle model lines) included in this catalog publication. Supports publication scope tracking.',
    `priority_level` STRING COMMENT 'Business priority of the publication: critical (urgent regulatory or safety update), high (important product launch), normal (routine catalog update), or low (minor correction).. Valid values are `critical|high|normal|low`',
    `publication_date` TIMESTAMP COMMENT 'Date and time when the catalog was formally published and released to the target system or channel. Represents the actual distribution event timestamp.',
    `publication_format` STRING COMMENT 'Technical file or data format of the published catalog: Extensible Markup Language (XML), JavaScript Object Notation (JSON), Comma-Separated Values (CSV), Portable Document Format (PDF), Excel spreadsheet, Electronic Data Interchange (EDI) X12, EDIFACT, or proprietary format. [ENUM-REF-CANDIDATE: xml|json|csv|pdf|excel|edi_x12|edifact|proprietary — 8 candidates stripped; promote to reference product]',
    `publication_notes` STRING COMMENT 'Free-text notes or comments about the publication event, including special instructions, known issues, or distribution details.',
    `publication_number` STRING COMMENT 'Business identifier for the publication event, formatted as PUB-YYYYMMDD-XXXXXX for external reference and audit trail.. Valid values are `^PUB-[0-9]{8}-[A-Z0-9]{6}$`',
    `publication_status` STRING COMMENT 'Current lifecycle state of the publication: draft (in preparation), approved (ready for release), published (actively distributed), recalled (withdrawn due to error), superseded (replaced by newer version), or archived (historical record).. Valid values are `draft|approved|published|recalled|superseded|archived`',
    `publication_type` STRING COMMENT 'Category of publication indicating the target audience: dealer ordering systems (DMS), consumer configurators, regulatory filings (NHTSA/EPA), internal sales tools, supplier portals, or fleet management systems.. Valid values are `dealer|consumer|regulatory|internal|supplier|fleet`',
    `published_by_user_name` STRING COMMENT 'Full name of the user who published the catalog, for human-readable audit trail and reporting.',
    `recall_reason` STRING COMMENT 'Explanation for why the catalog publication was recalled or withdrawn, if applicable. Captures business justification for publication reversal.',
    `recall_timestamp` TIMESTAMP COMMENT 'Date and time when the catalog publication was recalled or withdrawn. Part of the publication lifecycle audit trail.',
    `record_count` STRING COMMENT 'Total number of catalog records (e.g., Stock Keeping Units (SKUs), configurations, options) included in this publication. Used for validation and reconciliation.',
    `regulatory_filing_date` DATE COMMENT 'Date when the catalog was submitted to regulatory authorities, if applicable. Supports compliance audit trail.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier for the associated regulatory filing submission, if applicable. Links catalog publication to compliance documentation.',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Indicates whether this catalog publication requires submission to regulatory authorities (e.g., National Highway Traffic Safety Administration (NHTSA), Environmental Protection Agency (EPA), California Air Resources Board (CARB)). True if regulatory filing is required.',
    `target_channel` STRING COMMENT 'Distribution channel or interface through which the catalog is published: Dealer Management System (DMS), web configurator, mobile application, Application Programming Interface (API), File Transfer Protocol (FTP), Electronic Data Interchange (EDI), regulatory portal, or dealer portal. [ENUM-REF-CANDIDATE: dms|web_configurator|mobile_app|api|ftp|edi|regulatory_portal|dealer_portal — 8 candidates stripped; promote to reference product]',
    `target_country_code` STRING COMMENT 'Three-letter ISO country code for the specific country market of this publication (e.g., USA, CAN, DEU, JPN). Supports country-specific catalog requirements and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `target_region` STRING COMMENT 'Geographic region or market for which this catalog publication is intended (e.g., North America, Europe, Asia-Pacific). Supports regional catalog variations and compliance requirements.',
    `target_system` STRING COMMENT 'Name or identifier of the downstream system receiving this publication (e.g., CDK Global DMS, Salesforce Automotive Cloud, dealer portal, consumer configurator web application, NHTSA filing system).',
    `trim_count` STRING COMMENT 'Number of distinct trim levels included in this catalog publication. Supports publication scope tracking and validation.',
    `validation_error_count` STRING COMMENT 'Number of validation errors detected during pre-publication quality checks. Zero indicates clean publication.',
    `validation_status` STRING COMMENT 'Result of pre-publication data quality validation checks: passed (all validations successful), failed (critical errors detected), warning (non-critical issues found), or not_validated (validation skipped).. Valid values are `passed|failed|warning|not_validated`',
    `validation_warning_count` STRING COMMENT 'Number of validation warnings (non-critical issues) detected during pre-publication quality checks.',
    CONSTRAINT pk_catalog_publication PRIMARY KEY(`catalog_publication_id`)
) COMMENT 'Tracks the formal publication events of the commercial product catalog to downstream consumers — dealer ordering systems (DMS), consumer configurators, sales portals, and regulatory filings. Captures publication ID, catalog version, publication type (dealer/consumer/regulatory/internal), target system/channel, publication date, effective date range, published-by user, publication status (draft/approved/published/recalled), and distribution confirmation. Provides an audit trail of when and to whom catalog versions were released.';

CREATE OR REPLACE TABLE `automotive_ecm`.`product`.`package_availability` (
    `package_availability_id` BIGINT COMMENT 'Primary key for the PackageAvailability association',
    `aftersales_option_package_id` BIGINT COMMENT 'Foreign key linking to the option package',
    `catalog_publication_id` BIGINT COMMENT 'Foreign key linking to product.catalog_publication. Business justification: Package availability records belong to a specific catalog publication; linking them enables traceability of which publication defines the availability status and launch date.',
    `dealership_id` BIGINT COMMENT 'Foreign key linking to the dealership',
    `availability_status` STRING COMMENT 'Current status of the package at the dealer (e.g., Available, Discontinued, Pending)',
    `launch_date` DATE COMMENT 'Date when the option package becomes available for sale at the dealer',
    CONSTRAINT pk_package_availability PRIMARY KEY(`package_availability_id`)
) COMMENT 'Associates an option package with a dealership, capturing the availability status and launch date for that package at the dealer. Each record links one option package to one dealership and stores attributes that belong only to this relationship.. Existence Justification: Dealerships actively manage which option packages they carry, setting an availability status and launch date for each package. Each option package can be offered by many dealerships, and each dealership can offer many option packages, creating a many‑to‑many relationship that carries its own attributes.';

CREATE OR REPLACE TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` (
    `pricing_condition_assignment_id` BIGINT COMMENT 'Primary key for the PricingConditionAssignment association',
    `billing_price_condition_id` BIGINT COMMENT 'Foreign key linking to the pricing condition',
    `catalog_version_id` BIGINT COMMENT 'Foreign key linking to product.catalog_version. Business justification: Pricing condition assignments are defined per catalog version; linking them provides versioned pricing context for each assignment.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to the vehicle SKU',
    `condition_status` STRING COMMENT 'Lifecycle status of the condition assignment (e.g., active, expired)',
    `condition_type` STRING COMMENT 'Type of pricing condition (e.g., discount, tax, freight)',
    `condition_value` DECIMAL(18,2) COMMENT 'Monetary or percentage value of the pricing condition for this SKU',
    `effective_end_date` DATE COMMENT 'Date after which the condition no longer applies to the SKU',
    `effective_start_date` DATE COMMENT 'Date from which the condition becomes applicable to the SKU',
    CONSTRAINT pk_pricing_condition_assignment PRIMARY KEY(`pricing_condition_assignment_id`)
) COMMENT 'Represents the assignment of a pricing condition to a specific vehicle SKU. Each record links one SKU to one pricing condition and captures attributes that exist only in the context of this assignment, such as the condition value and its validity period.. Existence Justification: A pricing condition (e.g., discount, tax, freight) can be applied to many vehicle SKUs, and each SKU can have multiple pricing conditions such as MSRP, discounts, taxes, and fees. The pricing team actively creates, updates, and deletes these assignments, and each assignment carries attributes like value, validity dates, type, and status. This operational management makes the relationship a true many‑to‑many business entity.';

CREATE OR REPLACE TABLE `automotive_ecm`.`product`.`catalog_version` (
    `catalog_version_id` BIGINT COMMENT 'Primary key for catalog_version',
    `msrp_price_book_id` BIGINT COMMENT 'Identifier of the price book associated with this catalog version.',
    `previous_catalog_version_id` BIGINT COMMENT 'Self-referencing FK on catalog_version (previous_catalog_version_id)',
    `approval_status` STRING COMMENT 'Approval workflow status for the catalog version.',
    `approved_by` STRING COMMENT 'Name of the person who approved the catalog version.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the catalog version was approved.',
    `catalog_type` STRING COMMENT 'Category of catalog version indicating its purpose.',
    `change_summary` STRING COMMENT 'Brief summary of major changes compared to the previous catalog version.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the catalog version record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code used for pricing in this catalog version.',
    `effective_end_date` DATE COMMENT 'Date when the catalog version is superseded or expires.',
    `effective_start_date` DATE COMMENT 'Date when the catalog version becomes effective for sales.',
    `is_current` BOOLEAN COMMENT 'Indicates whether this version is the currently active catalog.',
    `market_segment` STRING COMMENT 'Primary market segment targeted by this catalog version.',
    `region_coverage` STRING COMMENT 'Geographic regions where this catalog version is offered.',
    `release_notes` STRING COMMENT 'Free‑form notes describing changes, new features, or fixes in this version.',
    `sku_structure_code` BIGINT COMMENT 'Identifier of the SKU structure definition used for this catalog version.',
    `catalog_version_status` STRING COMMENT 'Current lifecycle status of the catalog version.',
    `total_models` STRING COMMENT 'Number of distinct vehicle models included in this catalog version.',
    `total_options` STRING COMMENT 'Number of option packages defined in this catalog version.',
    `updated_by` STRING COMMENT 'User or system that performed the latest update to the catalog version record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the catalog version record.',
    `version_name` STRING COMMENT 'Descriptive name for the catalog version.',
    `version_number` STRING COMMENT 'Human‑readable version identifier (e.g., 2024Q1, v2.3).',
    `version_source_system` STRING COMMENT 'Source system that originated the catalog version data (e.g., PLM, ERP).',
    `created_by` STRING COMMENT 'User or system that created the catalog version record.',
    CONSTRAINT pk_catalog_version PRIMARY KEY(`catalog_version_id`)
) COMMENT 'Master reference table for catalog_version. Referenced by catalog_version_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `automotive_ecm`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `automotive_ecm`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ADD CONSTRAINT `fk_product_product_segment_parent_segment_product_segment_id` FOREIGN KEY (`parent_segment_product_segment_id`) REFERENCES `automotive_ecm`.`product`.`product_segment`(`product_segment_id`);
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ADD CONSTRAINT `fk_product_catalog_publication_catalog_version_id` FOREIGN KEY (`catalog_version_id`) REFERENCES `automotive_ecm`.`product`.`catalog_version`(`catalog_version_id`);
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ADD CONSTRAINT `fk_product_catalog_publication_superseded_by_publication_catalog_publication_id` FOREIGN KEY (`superseded_by_publication_catalog_publication_id`) REFERENCES `automotive_ecm`.`product`.`catalog_publication`(`catalog_publication_id`);
ALTER TABLE `automotive_ecm`.`product`.`package_availability` ADD CONSTRAINT `fk_product_package_availability_catalog_publication_id` FOREIGN KEY (`catalog_publication_id`) REFERENCES `automotive_ecm`.`product`.`catalog_publication`(`catalog_publication_id`);
ALTER TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` ADD CONSTRAINT `fk_product_pricing_condition_assignment_catalog_version_id` FOREIGN KEY (`catalog_version_id`) REFERENCES `automotive_ecm`.`product`.`catalog_version`(`catalog_version_id`);
ALTER TABLE `automotive_ecm`.`product`.`catalog_version` ADD CONSTRAINT `fk_product_catalog_version_previous_catalog_version_id` FOREIGN KEY (`previous_catalog_version_id`) REFERENCES `automotive_ecm`.`product`.`catalog_version`(`catalog_version_id`);

-- ========= TAGS =========
ALTER SCHEMA `automotive_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `automotive_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header ID');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Bom Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `adas_level` SET TAGS ('dbx_business_glossary_term' = 'Advanced Driver Assistance Systems (ADAS) Level');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `adas_level` SET TAGS ('dbx_value_regex' = 'L0|L1|L2|L3|L4|L5');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `alternative_bom_group` SET TAGS ('dbx_business_glossary_term' = 'Alternative BOM Group');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `alternative_bom_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `approved_by` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,50}$');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|PC|SET|KIT|ASSY');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `bom_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|obsolete|frozen|pending_approval');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Type');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'commercial|engineering|service|manufacturing|planning|sales');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `bom_usage` SET TAGS ('dbx_business_glossary_term' = 'BOM Usage');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `change_number` SET TAGS ('dbx_value_regex' = '^ECO-[A-Z0-9]{6,15}$');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `configuration_profile` SET TAGS ('dbx_business_glossary_term' = 'Configuration Profile');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `configuration_profile` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,30}$');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `connectivity_package` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Package');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `connectivity_package` SET TAGS ('dbx_value_regex' = 'none|basic|premium|V2X');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective From Date');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective To Date');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `emissions_standard` SET TAGS ('dbx_business_glossary_term' = 'Emissions Standard');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `emissions_standard` SET TAGS ('dbx_value_regex' = 'EPA_TIER3|CARB_LEV3|EURO6|EURO7|CHINA6|BS6');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `engineering_release_date` SET TAGS ('dbx_business_glossary_term' = 'Engineering Release Date');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `eop_date` SET TAGS ('dbx_business_glossary_term' = 'End of Production (EOP) Date');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `homologation_status` SET TAGS ('dbx_business_glossary_term' = 'Homologation Status');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `homologation_status` SET TAGS ('dbx_value_regex' = 'pending|approved|certified|rejected|expired');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `is_configurable` SET TAGS ('dbx_business_glossary_term' = 'Is Configurable Flag');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `lot_size_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `msrp_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Base Amount');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `msrp_base_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `nameplate_code` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Code');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `nameplate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Notes');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Code');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Type');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_value_regex' = 'ICE|HEV|PHEV|BEV|FCEV');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'BOM Revision Level');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `revision_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `safety_certification_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Level');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `safety_certification_level` SET TAGS ('dbx_value_regex' = '5_star|4_star|3_star|not_rated|pending');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `sop_date` SET TAGS ('dbx_business_glossary_term' = 'Start of Production (SOP) Date');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_MM|SAP_PP|TEAMCENTER|WINDCHILL|ENOVIA|MANUAL');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Amount');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `total_assembly_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Assembly Weight (Kilograms)');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `total_component_count` SET TAGS ('dbx_business_glossary_term' = 'Total Component Count');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `variant_code` SET TAGS ('dbx_business_glossary_term' = 'Variant Code');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `variant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `vin_pattern` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN) Pattern');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `vin_pattern` SET TAGS ('dbx_value_regex' = '^[A-HJ-NPR-Z0-9*]{17}$');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `warranty_program_code` SET TAGS ('dbx_business_glossary_term' = 'Warranty Program Code');
ALTER TABLE `automotive_ecm`.`product`.`bom_header` ALTER COLUMN `warranty_program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,15}$');
ALTER TABLE `automotive_ecm`.`product`.`product_bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`product`.`product_bom_line` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `automotive_ecm`.`product`.`product_bom_line` ALTER COLUMN `product_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for product_bom_line');
ALTER TABLE `automotive_ecm`.`product`.`product_bom_line` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `product_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Product Segment Identifier (ID)');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `parent_segment_product_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Segment Identifier (ID)');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `adas_level_range` SET TAGS ('dbx_business_glossary_term' = 'Advanced Driver Assistance Systems (ADAS) Level Range');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `adas_level_range` SET TAGS ('dbx_value_regex' = '^L[0-5]-L[0-5]$');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `annual_sales_volume_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Sales Volume Target');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `body_style_category` SET TAGS ('dbx_business_glossary_term' = 'Body Style Category');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `cafe_fleet_category` SET TAGS ('dbx_business_glossary_term' = 'Corporate Average Fuel Economy (CAFE) Fleet Category');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `cafe_fleet_category` SET TAGS ('dbx_value_regex' = 'passenger_car|light_truck|medium_duty|heavy_duty|exempt');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `cargo_volume_range_cu_ft` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume Range (Cubic Feet - cu ft)');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `competitive_set_definition` SET TAGS ('dbx_business_glossary_term' = 'Competitive Set Definition');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `connectivity_capability` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Capability');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `connectivity_capability` SET TAGS ('dbx_value_regex' = 'none|basic|advanced|v2x|full_connected');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `emissions_standard_target` SET TAGS ('dbx_business_glossary_term' = 'Emissions Standard Target');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Segment Hierarchy Level');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `homologation_regions` SET TAGS ('dbx_business_glossary_term' = 'Homologation Regions');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `industry_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Code');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Lifecycle Status');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'emerging|growth|mature|declining|discontinued');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `market_positioning_tier` SET TAGS ('dbx_business_glossary_term' = 'Market Positioning Tier');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `market_positioning_tier` SET TAGS ('dbx_value_regex' = 'economy|mainstream|premium|luxury|performance|commercial');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `market_share_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Market Share Target Percentage (pct)');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `ncap_rating_applicability` SET TAGS ('dbx_business_glossary_term' = 'New Car Assessment Programme (NCAP) Rating Applicability');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `ncap_rating_applicability` SET TAGS ('dbx_value_regex' = 'euro_ncap|us_ncap|china_ncap|latin_ncap|asean_ncap|not_applicable');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `ota_update_capability` SET TAGS ('dbx_business_glossary_term' = 'Over-the-Air (OTA) Update Capability');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `powertrain_category` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Category');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `powertrain_category` SET TAGS ('dbx_value_regex' = 'ice|hev|phev|bev|fcev|hybrid');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `price_range_max_usd` SET TAGS ('dbx_business_glossary_term' = 'Price Range Maximum (United States Dollar - USD)');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `price_range_min_usd` SET TAGS ('dbx_business_glossary_term' = 'Price Range Minimum (United States Dollar - USD)');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `primary_use_case` SET TAGS ('dbx_business_glossary_term' = 'Primary Use Case');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Category');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `sae_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Society of Automotive Engineers (SAE) Classification Code');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `sae_classification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `seating_capacity_range` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity Range');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `seating_capacity_range` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}-[0-9]{1,2}$');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|sunset');
ALTER TABLE `automotive_ecm`.`product`.`product_segment` ALTER COLUMN `target_customer_profile` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Profile');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` SET TAGS ('dbx_subdomain' = 'catalog_operations');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `catalog_publication_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Publication ID');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `catalog_version_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Version ID');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Published By User ID');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `primary_catalog_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Published By User ID');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `primary_catalog_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `primary_catalog_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `superseded_by_publication_catalog_publication_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Publication ID');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Name');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `distribution_confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Distribution Confirmation Flag');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `distribution_confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Distribution Confirmation Timestamp');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `distribution_method` SET TAGS ('dbx_business_glossary_term' = 'Distribution Method');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `distribution_method` SET TAGS ('dbx_value_regex' = 'push|pull|batch|real_time|scheduled');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `distribution_retry_count` SET TAGS ('dbx_business_glossary_term' = 'Distribution Retry Count');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `file_checksum` SET TAGS ('dbx_business_glossary_term' = 'File Checksum');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `last_distribution_error` SET TAGS ('dbx_business_glossary_term' = 'Last Distribution Error');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `nameplate_count` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Count');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `publication_format` SET TAGS ('dbx_business_glossary_term' = 'Publication Format');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `publication_notes` SET TAGS ('dbx_business_glossary_term' = 'Publication Notes');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `publication_number` SET TAGS ('dbx_business_glossary_term' = 'Publication Number');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `publication_number` SET TAGS ('dbx_value_regex' = '^PUB-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'Publication Status');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `publication_status` SET TAGS ('dbx_value_regex' = 'draft|approved|published|recalled|superseded|archived');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `publication_type` SET TAGS ('dbx_business_glossary_term' = 'Publication Type');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `publication_type` SET TAGS ('dbx_value_regex' = 'dealer|consumer|regulatory|internal|supplier|fleet');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `published_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Published By User Name');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `published_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `published_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `recall_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recall Timestamp');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `record_count` SET TAGS ('dbx_business_glossary_term' = 'Record Count');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `target_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Channel');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `target_country_code` SET TAGS ('dbx_business_glossary_term' = 'Target Country Code');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `target_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `target_region` SET TAGS ('dbx_business_glossary_term' = 'Target Region');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `target_system` SET TAGS ('dbx_business_glossary_term' = 'Target System');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `trim_count` SET TAGS ('dbx_business_glossary_term' = 'Trim Count');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `validation_error_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Count');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_validated');
ALTER TABLE `automotive_ecm`.`product`.`catalog_publication` ALTER COLUMN `validation_warning_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Warning Count');
ALTER TABLE `automotive_ecm`.`product`.`package_availability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `automotive_ecm`.`product`.`package_availability` SET TAGS ('dbx_subdomain' = 'catalog_operations');
ALTER TABLE `automotive_ecm`.`product`.`package_availability` SET TAGS ('dbx_association_edges' = 'product.option_package,dealer.dealership');
ALTER TABLE `automotive_ecm`.`product`.`package_availability` ALTER COLUMN `package_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Packageavailability - Package Availability Id');
ALTER TABLE `automotive_ecm`.`product`.`package_availability` ALTER COLUMN `aftersales_option_package_id` SET TAGS ('dbx_business_glossary_term' = 'Packageavailability - Option Package Id');
ALTER TABLE `automotive_ecm`.`product`.`package_availability` ALTER COLUMN `catalog_publication_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Publication Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`product`.`package_availability` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Packageavailability - Dealership Id');
ALTER TABLE `automotive_ecm`.`product`.`package_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Package Availability Status');
ALTER TABLE `automotive_ecm`.`product`.`package_availability` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Package Launch Date');
ALTER TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_subdomain' = 'catalog_operations');
ALTER TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_association_edges' = 'product.sku,billing.price_condition');
ALTER TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `pricing_condition_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Pricingconditionassignment - Pricing Condition Assignment Id');
ALTER TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `billing_price_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Pricingconditionassignment - Price Condition Id');
ALTER TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `catalog_version_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Version Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Pricingconditionassignment - Sku Id');
ALTER TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `condition_value` SET TAGS ('dbx_business_glossary_term' = 'Condition Value');
ALTER TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`product`.`catalog_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`product`.`catalog_version` SET TAGS ('dbx_subdomain' = 'catalog_operations');
ALTER TABLE `automotive_ecm`.`product`.`catalog_version` ALTER COLUMN `catalog_version_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Version Identifier');
ALTER TABLE `automotive_ecm`.`product`.`catalog_version` ALTER COLUMN `previous_catalog_version_id` SET TAGS ('dbx_self_ref_fk' = 'true');
