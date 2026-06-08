-- Schema for Domain: product | Business: Manufacturing | Version: v1_mvm
-- Generated on: 2026-05-06 09:42:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `manufacturing_ecm`.`product` COMMENT 'Product catalog and offering management domain serving as the SSOT for all manufactured products, automation systems, electrification solutions, and smart infrastructure components. Manages SKU master data, product families, configurations, pricing structures, product lifecycle stages from NPI to end-of-life, and product portfolio management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `manufacturing_ecm`.`product`.`sku_master` (
    `sku_master_id` BIGINT COMMENT 'Unique identifier for the SKU master record. Primary key for the SKU master data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost Allocation Report requires each SKU to be charged to a cost center for manufacturing cost tracking.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: sku_master.product_family_code is a denormalized string reference to the product family. Adding a proper FK sku_master.family_id -> product.family.family_id normalizes this relationship, enabling refe',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: NPI traceability: in industrial manufacturing, each SKU is developed through a New Product Introduction engineering project. Product managers and program managers need to trace which engineering proje',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Financial reporting of sales per SKU needs a dedicated revenue GL account for posting invoices.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Primary Supplier Assignment report requires each SKU to reference its main vendor for cost, lead‑time, and compliance decisions.',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and consumption: A (high value, tight control), B (moderate value), C (low value, relaxed control). Used for inventory policy and cycle counting frequency.. Valid values are `A|B|C`',
    `base_uom` STRING COMMENT 'The fundamental unit of measure for inventory tracking and stock keeping. All other UoM conversions are calculated relative to this base unit. [ENUM-REF-CANDIDATE: EA|PC|KG|LB|M|FT|L|GAL|M2|FT2|M3|FT3|SET|KIT — 14 candidates stripped; promote to reference product]',
    `commercial_description` STRING COMMENT 'Marketing-optimized product description for sales and customer communication. Multi-language support maintained in PLM system.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard cost. Typically the companys base or functional currency for financial reporting.. Valid values are `^[A-Z]{3}$`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the product is manufactured or substantially transformed. Required for customs declarations and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SKU master record was first created in the system. Audit trail for data governance and compliance.',
    `dimension_uom` STRING COMMENT 'Unit of measure for length, width, and height dimensions. Standardized for consistent warehouse and logistics operations.. Valid values are `MM|CM|M|IN|FT`',
    `discontinuation_date` DATE COMMENT 'Date when the SKU is discontinued and no longer available for new orders. Supports end-of-life planning and inventory liquidation strategies.',
    `eccn_code` STRING COMMENT 'Export Control Classification Number assigned under the U.S. Export Administration Regulations (EAR). Determines export licensing requirements and trade compliance obligations.. Valid values are `^[0-9][A-Z][0-9]{3}(.[a-z])?$`',
    `effective_date` DATE COMMENT 'Date when the SKU becomes active and available for transactions. Used for new product introductions and lifecycle transitions.',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight of the product including packaging, measured in the weight UoM. Used for logistics planning, freight calculation, and warehouse capacity management.',
    `hazard_class` STRING COMMENT 'UN hazard classification code indicating the primary hazard type (e.g., 3 for flammable liquids, 8 for corrosive substances). Used for transportation and storage compliance.. Valid values are `^[1-9](.[1-6])?$`',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether the SKU is classified as a hazardous material requiring special handling, storage, and transportation procedures per regulatory requirements.',
    `height` DECIMAL(18,2) COMMENT 'Height dimension of the product or its packaging, measured in the dimension UoM. Used for warehouse slotting and transportation planning.',
    `hts_code` STRING COMMENT 'Harmonized Tariff Schedule classification code for customs and international trade. Used to determine import duties, tariffs, and trade statistics reporting.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SKU master record. Used for change tracking and data synchronization across systems.',
    `length` DECIMAL(18,2) COMMENT 'Length dimension of the product or its packaging, measured in the dimension UoM. Used for warehouse slotting and transportation planning.',
    `lifecycle_status` STRING COMMENT 'Current stage in the product lifecycle from New Product Introduction (NPI) through end-of-life. Governs availability for new orders, production scheduling, and inventory management decisions.. Valid values are `npi|active|mature|phase_out|discontinued|obsolete`',
    `long_description` STRING COMMENT 'Detailed product description for technical documentation, sales catalogs, and customer-facing materials. Includes full technical specifications and feature details.',
    `lot_control_required` BOOLEAN COMMENT 'Flag indicating whether the SKU requires lot or batch number tracking for traceability, quality control, and recall management purposes.',
    `make_or_buy_code` STRING COMMENT 'Procurement strategy indicator: make (manufactured in-house), buy (purchased from suppliers), or both (dual-sourced). Drives MRP planning logic and sourcing decisions.. Valid values are `make|buy|both`',
    `material_number` STRING COMMENT 'SAP material number from S/4HANA MM module. Legacy identifier maintained for ERP integration and cross-system traceability.. Valid values are `^[0-9]{10,18}$`',
    `net_weight` DECIMAL(18,2) COMMENT 'Weight of the product excluding packaging, measured in the weight UoM. Used for material content reporting and customs declarations.',
    `packing_group` STRING COMMENT 'UN packing group classification indicating the degree of danger: I (high danger), II (medium danger), III (low danger). Determines packaging and handling requirements.. Valid values are `I|II|III`',
    `plm_item_code` STRING COMMENT 'Unique identifier from Siemens Teamcenter PLM system. Links the SKU master record to engineering design data, CAD models, BOMs, and technical documentation.',
    `product_type` STRING COMMENT 'Classification of the SKU by manufacturing and inventory treatment. Determines BOM structure, production planning, and inventory valuation methods. [ENUM-REF-CANDIDATE: finished_good|semi_finished|raw_material|component|assembly|service_part|consumable|tool — 8 candidates stripped; promote to reference product]',
    `production_to_base_conversion` DECIMAL(18,2) COMMENT 'Conversion factor to translate production UoM quantities to base UoM. Used for MRP calculations and production planning.',
    `production_uom` STRING COMMENT 'Unit of measure used in manufacturing execution and shop floor control. Aligns with MES work order quantities and production reporting. [ENUM-REF-CANDIDATE: EA|PC|KG|LB|M|FT|L|GAL|M2|FT2|M3|FT3|SET|KIT|BATCH|LOT — 16 candidates stripped; promote to reference product]',
    `revision_level` STRING COMMENT 'Current engineering revision or version of the product design. Managed through ECO/ECN processes in PLM. Critical for configuration management and change control.. Valid values are `^[A-Z0-9]{1,10}$`',
    `sales_to_base_conversion` DECIMAL(18,2) COMMENT 'Conversion factor to translate sales UoM quantities to base UoM. Example: if sales UoM is BOX and base UoM is EA, and one box contains 12 pieces, the factor is 12.000000.',
    `sales_uom` STRING COMMENT 'Unit of measure used for customer orders and sales transactions. May differ from base UoM to accommodate customer ordering preferences. [ENUM-REF-CANDIDATE: EA|PC|KG|LB|M|FT|L|GAL|M2|FT2|M3|FT3|SET|KIT|BOX|PALLET — 16 candidates stripped; promote to reference product]',
    `sds_reference` STRING COMMENT 'Reference identifier or document number for the Safety Data Sheet (formerly MSDS) containing detailed hazard information, handling instructions, and emergency procedures.',
    `serial_control_required` BOOLEAN COMMENT 'Flag indicating whether the SKU requires individual serial number tracking for warranty management, asset tracking, and field service support.',
    `shelf_life_days` STRING COMMENT 'Number of days the product remains usable or saleable from the date of manufacture or receipt. Used for inventory rotation, expiration management, and quality control.',
    `short_description` STRING COMMENT 'Concise product description for internal operational use, typically 40 characters or less. Used in MES shop floor displays and warehouse picking lists.',
    `sku_code` STRING COMMENT 'The authoritative, externally-known unique identifier for the SKU. Used across all systems including SAP S/4HANA MM, Siemens Teamcenter PLM, and Siemens Opcenter MES. This is the business key for the product.. Valid values are `^[A-Z0-9]{8,20}$`',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard unit cost for inventory valuation and cost accounting. Maintained in the base currency and updated periodically through cost roll-up processes. Note: pricing structures are owned by the sales domain.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials as defined by the UN Recommendations on the Transport of Dangerous Goods. Required for shipping documentation and regulatory compliance.. Valid values are `^UN[0-9]{4}$`',
    `volume` DECIMAL(18,2) COMMENT 'Volumetric measurement of the product or its packaging, measured in the volume UoM. Used for warehouse capacity planning and freight optimization.',
    `volume_uom` STRING COMMENT 'Unit of measure for volume. Used in logistics and warehouse management calculations.. Valid values are `L|ML|M3|GAL|FT3|IN3`',
    `weight_uom` STRING COMMENT 'Unit of measure for gross and net weight values. Standardized across the enterprise for consistent logistics and shipping calculations.. Valid values are `KG|LB|G|OZ|MT|TON`',
    `width` DECIMAL(18,2) COMMENT 'Width dimension of the product or its packaging, measured in the dimension UoM. Used for warehouse slotting and transportation planning.',
    CONSTRAINT pk_sku_master PRIMARY KEY(`sku_master_id`)
) COMMENT 'Single source of truth for all Stock Keeping Units (SKUs) across the manufactured product portfolio. Captures the authoritative SKU identifier, description, unit of measure, weight, dimensions, hazardous material classification (UN number, hazard class, packing group, SDS reference), export control classification (ECCN), and lifecycle status. Serves as the foundational master record referenced by BOM, MES, ERP (SAP S/4HANA MM), and PLM (Siemens Teamcenter) systems. Every manufactured item, automation system component, electrification solution, and smart infrastructure element is registered here before it can be produced, sold, or shipped. Includes base/sales/production UoM with conversion factors and multi-language commercial descriptions. Note: product pricing structures are owned by the sales domain; this domain owns product identity, structure, and commercial catalog definition only.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`product`.`family` (
    `family_id` BIGINT COMMENT 'Primary key for family',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Product families are mapped to inventory and revenue GL accounts for product-line financial segment reporting. family already has profit_center_id but no GL link. Industrial manufacturing controllers ',
    `parent_family_id` BIGINT COMMENT 'Reference to the parent product family in the multi-level hierarchy. Enables nested family structures (e.g., Industrial Automation > Drives > Low Voltage Drives). Null for top-level families.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit Center Performance Report groups families to evaluate profitability by product line.',
    `business_unit` STRING COMMENT 'Name or code of the business unit or division responsible for this product family. Defines ownership for P&L accountability, product management, and strategic roadmap decisions.',
    `certification_requirements` STRING COMMENT 'Comma-separated list of required certifications and compliance standards for products in this family (e.g., UL, CE, IEC 61131, ISO 9001, ATEX, IECEx). Defines regulatory and safety compliance scope.',
    `competitive_positioning` STRING COMMENT 'Strategic positioning statement describing how this product family competes in the market (e.g., technology leader, cost leader, niche specialist). Used for marketing strategy and sales enablement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product family record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for standard cost and list price (e.g., USD, EUR, CNY). Defines the monetary unit for financial attributes.. Valid values are `^[A-Z]{3}$`',
    `cybersecurity_classification` STRING COMMENT 'Cybersecurity risk classification for products in this family based on connectivity, data handling, and criticality to customer operations. Drives security testing, vulnerability management, and compliance with IEC 62443 and NIST Cybersecurity Framework.. Valid values are `critical|high|medium|low|not_applicable`',
    `data_source_system` STRING COMMENT 'Name or code of the source system from which this product family record originated (e.g., SAP S/4HANA, Siemens Teamcenter PLM, Informatica MDM). Used for data lineage and integration troubleshooting.',
    `distribution_channel` STRING COMMENT 'Primary distribution channel for products in this family (e.g., direct sales, distributor, OEM, e-commerce). Influences pricing, logistics, and customer engagement strategy.',
    `effective_end_date` DATE COMMENT 'Date when this product family was or will be discontinued or retired from the catalog. Null for active families. Used for phase-out planning and end-of-life management.',
    `effective_start_date` DATE COMMENT 'Date when this product family became active and available for sale or production. Marks the beginning of the familys lifecycle in the product catalog.',
    `environmental_compliance` STRING COMMENT 'Environmental and sustainability compliance standards applicable to this family (e.g., RoHS, REACH, WEEE, ISO 14001, Energy Star). Ensures adherence to environmental regulations and corporate sustainability commitments.',
    `erp_material_group` STRING COMMENT 'Material group code assigned in SAP S/4HANA (MATKL). Used for procurement, inventory management, and financial reporting. Links to purchasing conditions and valuation classes.',
    `family_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the product family. Used in SAP S/4HANA SD for catalog navigation and PLM (Siemens Teamcenter) for product classification. Serves as the business identifier for cross-system integration.. Valid values are `^[A-Z0-9]{3,20}$`',
    `family_description` STRING COMMENT 'Detailed business description of the product family, including its purpose, key characteristics, typical applications, and differentiating features. Used for marketing collateral, sales enablement, and product documentation.',
    `family_name` STRING COMMENT 'Human-readable name of the product family (e.g., Industrial Drives, Low-Voltage Switchgear, Smart Building Controllers, Programmable Logic Controllers). Primary display label for catalog navigation and reporting.',
    `family_type` STRING COMMENT 'Classification of the product family by offering type. Distinguishes between finished goods (end products), components (parts), assemblies (sub-systems), services (maintenance/support), software (embedded/standalone), systems (integrated solutions), and spare parts. [ENUM-REF-CANDIDATE: finished_goods|components|assemblies|services|software|systems|spare_parts — 7 candidates stripped; promote to reference product]',
    `geographic_availability` STRING COMMENT 'Comma-separated list of geographic regions or countries where products in this family are available for sale (e.g., EMEA, APAC, Americas, USA, DEU, CHN). Reflects regulatory approvals, distribution network, and go-to-market scope.',
    `hazardous_material_indicator` BOOLEAN COMMENT 'Indicates whether products in this family contain or are classified as hazardous materials requiring special handling, storage, or transportation (e.g., batteries, chemicals, flammable substances). Drives compliance with OSHA, EPA, and transportation regulations.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the product family hierarchy tree. Level 1 represents top-level families (e.g., Automation Systems). Level 2 represents sub-families (e.g., Drives). Level 3+ represents further nested classifications. Used for catalog navigation depth and reporting rollups.',
    `innovation_priority` STRING COMMENT 'Priority level for innovation and new product development within this family. High priority families receive accelerated R&D investment and technology roadmap focus.. Valid values are `high|medium|low`',
    `iot_enabled` BOOLEAN COMMENT 'Indicates whether products in this family have embedded IoT (Internet of Things) or IIoT (Industrial Internet of Things) connectivity for remote monitoring, predictive maintenance, or data analytics. Supports digital services and smart infrastructure offerings.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person or system that last modified this product family record. Supports audit trail and accountability for master data changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product family record was last updated. Used for change tracking, data synchronization, and audit compliance.',
    `lead_time_days` STRING COMMENT 'Standard manufacturing or procurement lead time in days for products in this family. Used for order promising, production planning (MRP), and inventory policy setting.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the product family. Active families are available for sale and production. Discontinued families are no longer offered. Phase-out families are being retired. NPI (New Product Introduction) families are in launch phase. End-of-life families support existing installations only. Under-development families are pre-launch.. Valid values are `active|discontinued|phase_out|new_product_introduction|end_of_life|under_development`',
    `list_price` DECIMAL(18,2) COMMENT 'Representative list price or price range midpoint for products in this family. Used for catalog display, quotation guidance, and revenue forecasting. Actual SKU prices may vary based on configuration and customer agreements.',
    `manufacturing_strategy` STRING COMMENT 'Primary manufacturing strategy for products in this family. Make-to-stock (MTS) builds to forecast. Make-to-order (MTO) builds to customer orders. Engineer-to-order (ETO) customizes designs. Configure-to-order (CTO) assembles from standard modules. Assemble-to-order (ATO) final assembly from components.. Valid values are `make_to_stock|make_to_order|engineer_to_order|configure_to_order|assemble_to_order`',
    `market_segment` STRING COMMENT 'Primary market segment or vertical industry that this product family serves. Aligns with go-to-market strategy and sales organization structure. Used for revenue reporting, market analysis, and strategic planning. [ENUM-REF-CANDIDATE: industrial_automation|building_automation|energy_management|transportation|process_industries|discrete_manufacturing|infrastructure|oem_solutions — 8 candidates stripped; promote to reference product]',
    `mean_time_between_failures` DECIMAL(18,2) COMMENT 'Average Mean Time Between Failures (MTBF) in hours for products in this family. Key reliability metric used for maintenance planning, service level agreements, and product quality benchmarking.',
    `mean_time_to_repair` DECIMAL(18,2) COMMENT 'Average Mean Time To Repair (MTTR) in hours for products in this family. Indicates serviceability and downtime impact. Used for maintenance planning and SLA (Service Level Agreement) definition.',
    `plm_category` STRING COMMENT 'Classification code or category assigned in the PLM system (Siemens Teamcenter). Used for document management, BOM (Bill of Materials) structure, and engineering change control (ECO/ECN).',
    `procurement_type` STRING COMMENT 'Indicates whether products in this family are manufactured in-house, purchased from suppliers, or a combination of both. Drives sourcing strategy and supply chain planning.. Valid values are `manufactured|purchased|both`',
    `product_line_owner` STRING COMMENT 'Name or identifier of the product manager or product line owner responsible for this family. Accountable for portfolio strategy, pricing, and lifecycle management.',
    `product_portfolio_strategy` STRING COMMENT 'Strategic classification of the product family in the corporate portfolio. Invest families receive R&D funding and growth initiatives. Maintain families sustain current market position. Harvest families maximize cash flow with minimal investment. Divest families are candidates for discontinuation or sale.. Valid values are `invest|maintain|harvest|divest`',
    `record_status` STRING COMMENT 'Administrative status of this master data record. Active records are current and in use. Inactive records are deprecated but retained for historical reference. Pending approval records await governance review. Archived records are retained for compliance but not operational use.. Valid values are `active|inactive|pending_approval|archived`',
    `sales_organization` STRING COMMENT 'Primary sales organization code responsible for selling products in this family. Defines sales territory, pricing authority, and revenue attribution in SAP S/4HANA SD.',
    `service_level_tier` STRING COMMENT 'Default service level tier for products in this family. Defines response time commitments, spare parts availability, and support escalation paths. Influences service pricing and customer expectations.. Valid values are `standard|premium|critical|basic`',
    `standard_cost` DECIMAL(18,2) COMMENT 'Average standard cost per unit for products in this family, used for financial planning and margin analysis. Expressed in the companys base currency. Aggregated from individual SKU costs.',
    `target_customer_segment` STRING COMMENT 'Primary customer segment or persona targeted by this product family (e.g., large industrial OEMs, mid-size system integrators, building owners, utilities). Guides marketing campaigns and sales territory planning.',
    `target_margin_percent` DECIMAL(18,2) COMMENT 'Target gross margin percentage for products in this family, expressed as a percentage (e.g., 35.50 for 35.5%). Used for pricing strategy, product mix optimization, and profitability analysis.',
    `technology_platform` STRING COMMENT 'Underlying technology platform or architecture shared by products in this family (e.g., SIMATIC Platform, SINAMICS Drive Platform, Desigo Building Automation Platform). Enables commonality analysis and platform lifecycle planning.',
    `warranty_period_months` STRING COMMENT 'Standard warranty period in months offered for products in this family. Defines the baseline service commitment and influences pricing and service revenue forecasting.',
    CONSTRAINT pk_family PRIMARY KEY(`family_id`)
) COMMENT 'Defines the hierarchical grouping of related manufactured products into product families and sub-families (e.g., Industrial Drives, Low-Voltage Switchgear, Smart Building Controllers). Manages the product portfolio taxonomy used for planning, pricing, and go-to-market segmentation. Supports multi-level hierarchy with parent-child relationships, market segment alignment, and product line ownership. Referenced by PLM (Siemens Teamcenter) and SAP S/4HANA SD for catalog navigation and revenue reporting.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`product`.`configuration` (
    `configuration_id` BIGINT COMMENT 'Primary key for configuration',
    `bom_id` BIGINT COMMENT 'Reference to the Bill of Materials (BOM) that defines the components and assemblies required to manufacture this configuration.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: configuration.product_family_code is a denormalized string reference to the product family. A configurable product variant belongs to a product family — this is essential for grouping configurations b',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Product configurations carry base_price and total_configuration_price requiring revenue GL account assignment for order-to-cash revenue recognition and configuration-level pricing analytics. Industria',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Each configuration variant represents a distinct sellable offering; profit center assignment enables product-line P&L reporting at the configuration level. Industrial manufacturing controllers track m',
    `routing_id` BIGINT COMMENT 'Identifier for the manufacturing routing or process plan used to produce this configuration. Defines the sequence of operations.',
    `sku_master_id` BIGINT COMMENT 'Reference to the base product or product family that this configuration is derived from. Links to the product master catalog.',
    `superseded_by_configuration_id` BIGINT COMMENT 'Reference to the configuration that replaces this one when it becomes obsolete. Supports product migration and upgrade paths.',
    `application_type` STRING COMMENT 'Intended application or use case for this configuration. Describes the operational context where the product will be deployed.',
    `approval_date` DATE COMMENT 'Date when this configuration was formally approved for use in quoting and order fulfillment. Part of the configuration governance process.',
    `base_price` DECIMAL(18,2) COMMENT 'Starting price for the base product before configuration options are applied. Expressed in the default currency.',
    `certification_requirements` STRING COMMENT 'List of required certifications and compliance standards for this configuration, such as CE, UL, ISO certifications. Varies by market and application.',
    `configuration_code` STRING COMMENT 'Unique business identifier for the configured product variant. Used in CPQ (Configure-Price-Quote) workflows and order processing systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `configuration_description` STRING COMMENT 'Detailed description of the configured product variant, including key features, options selected, and intended use case.',
    `configuration_name` STRING COMMENT 'Human-readable name or title for the configured product variant. Describes the specific configuration in business terms.',
    `configuration_status` STRING COMMENT 'Current lifecycle status of the product configuration. Indicates whether the configuration is available for quoting and ordering. [ENUM-REF-CANDIDATE: draft|active|inactive|obsolete|pending_approval|approved|rejected — 7 candidates stripped; promote to reference product]',
    `configuration_type` STRING COMMENT 'Classification of the configuration approach. Standard configurations are pre-defined, custom configurations are unique to customer requirements, engineer-to-order requires design work, make-to-order uses existing designs with custom parameters, configure-to-order selects from predefined options, and assemble-to-order combines standard modules.. Valid values are `standard|custom|engineer_to_order|make_to_order|configure_to_order|assemble_to_order`',
    `constraint_rules` STRING COMMENT 'Business rules and constraints that govern valid option combinations for this configuration. Defines incompatibilities, dependencies, and mandatory selections.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration record was first created in the system. Part of the audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing fields. Indicates the currency in which prices are expressed.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Target customer segment or industry vertical for this configuration. Examples include automotive, energy, infrastructure, building automation.',
    `dimensions_height_mm` DECIMAL(18,2) COMMENT 'Height dimension of the configured product in millimeters. Critical for packaging, shipping, and installation planning.',
    `dimensions_length_mm` DECIMAL(18,2) COMMENT 'Length dimension of the configured product in millimeters. Critical for packaging, shipping, and installation planning.',
    `dimensions_width_mm` DECIMAL(18,2) COMMENT 'Width dimension of the configured product in millimeters. Critical for packaging, shipping, and installation planning.',
    `effective_end_date` DATE COMMENT 'Date after which this configuration is no longer available for new orders. Supports product phase-out and end-of-life management.',
    `effective_start_date` DATE COMMENT 'Date from which this configuration becomes available for quoting and ordering. Supports phased product launches and market introductions.',
    `is_orderable` BOOLEAN COMMENT 'Flag indicating whether this configuration can currently be ordered. Used to control availability in CPQ (Configure-Price-Quote) and order management systems.',
    `is_quotable` BOOLEAN COMMENT 'Flag indicating whether this configuration can be included in customer quotes. May be quotable but not yet orderable during pre-launch phases.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration record was last updated. Tracks the most recent change to any field in the record.',
    `lead_time_days` STRING COMMENT 'Standard manufacturing and delivery lead time for this configuration in days. Used for order promising and scheduling.',
    `manufacturing_complexity` STRING COMMENT 'Assessment of the manufacturing complexity for this configuration. Impacts production planning, resource allocation, and lead time.. Valid values are `low|medium|high|very_high`',
    `minimum_order_quantity` STRING COMMENT 'Minimum number of units that must be ordered for this configuration. Used to enforce economic order quantities and production efficiency.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this configuration. Used for internal communication and documentation.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Electrical power rating of the configured product in kilowatts. Relevant for electrification solutions and automation systems.',
    `price_adjustment` DECIMAL(18,2) COMMENT 'Total price adjustment resulting from selected configuration options. Can be positive (upcharge) or negative (discount).',
    `pricing_model` STRING COMMENT 'Pricing approach used for this configuration. Determines how the final price is calculated based on base product and selected options.. Valid values are `base_plus_options|bundled|tiered|custom_quote|cost_plus|value_based`',
    `regional_availability` STRING COMMENT 'Geographic regions or markets where this configuration is available for sale. Comma-separated list of region codes or market identifiers.',
    `requires_engineering_review` BOOLEAN COMMENT 'Flag indicating whether orders for this configuration require engineering review and approval before production. Common for engineer-to-order configurations.',
    `selected_options` STRING COMMENT 'Comma-separated or structured list of specific option codes selected for this configuration variant. Represents the actual choices made from the available option set.',
    `technical_specification_document` STRING COMMENT 'Reference to the technical specification document or datasheet that provides detailed engineering specifications for this configuration.',
    `total_configuration_price` DECIMAL(18,2) COMMENT 'Final calculated price for the configured product variant, including base price and all option adjustments.',
    `version_number` STRING COMMENT 'Version identifier for this configuration. Supports configuration change management and revision control.',
    `voltage_rating` STRING COMMENT 'Operating voltage specification for the configured product. Critical for electrical compatibility and safety compliance.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the configured product in kilograms. Used for shipping, logistics planning, and installation requirements.',
    CONSTRAINT pk_configuration PRIMARY KEY(`configuration_id`)
) COMMENT 'Manages configurable product variants and option sets for make-to-order and engineer-to-order automation systems and electrification solutions. Captures configuration rules, valid option combinations, constraint logic, base model references, and configured variant codes. Supports CPQ (Configure-Price-Quote) workflows in Salesforce CRM and variant configuration in SAP S/4HANA. Tracks which configuration options are available per product family, regional market, and customer segment.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`product`.`bom_header` (
    `bom_header_id` BIGINT COMMENT 'Unique identifier for the BOM header record. Primary key for the BOM header entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Engineering cost allocation tracks BOM creation expenses against the responsible cost center.',
    `ecn_id` BIGINT COMMENT 'Foreign key linking to engineering.ecn. Business justification: ECN-to-BOM synchronization: the Engineering Change Notice is the formal release document that triggers BOM updates in ERP. MES/ERP synchronization workflows and supplier notification processes require',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: ECO-driven BOM change traceability: every product BOM revision in industrial manufacturing is authorized by an Engineering Change Order. Change impact reports and ERP audit trails require linking bom_',
    `plant_data_id` BIGINT COMMENT 'Reference to the manufacturing plant or production facility where this BOM is valid and used. BOMs can be plant-specific to accommodate local manufacturing processes and material availability.',
    `family_id` BIGINT COMMENT 'FK to product.family',
    `product_revision_id` BIGINT COMMENT 'Foreign key linking to product.product_revision. Business justification: bom_header.revision_level is a denormalized string reference to the engineering revision. In manufacturing, a Bill of Materials is always associated with a specific engineering revision — the BOM defi',
    `sku_master_id` BIGINT COMMENT 'Reference to the manufactured product, automation system, or electrification solution that this BOM defines. Links to the product master data.',
    `alternative_bom_indicator` STRING COMMENT 'Identifier for alternative BOM versions for the same product. Allows multiple valid BOMs for a product to support different manufacturing methods, material substitutions, or regional variations.',
    `approval_date` DATE COMMENT 'Date when this BOM version was formally approved for production use. Marks the completion of engineering review and quality validation processes.',
    `base_quantity` DECIMAL(18,2) COMMENT 'The reference quantity for which the BOM is defined. All component quantities in the BOM lines are specified relative to this base quantity. Typically 1 unit of the finished product.',
    `base_unit_of_measure` STRING COMMENT 'Unit of measure for the base quantity. Defines the measurement unit (EA, KG, M, L, etc.) for the finished product quantity.',
    `bom_category` STRING COMMENT 'Structural classification of the BOM. Standard for fixed structures, Configurable for variant BOMs, Phantom for transient assemblies, Reference for documentation, Kit for bundled items.. Valid values are `standard|configurable|phantom|reference|kit`',
    `bom_description` STRING COMMENT 'Textual description of the BOM purpose, scope, or special characteristics. Provides context for the BOM structure and its intended application.',
    `bom_number` STRING COMMENT 'Business identifier for the BOM. Externally-known unique code used across PLM and ERP systems for referencing the BOM structure.',
    `bom_status` STRING COMMENT 'Current lifecycle status of the BOM header. Tracks progression from draft through approval to active production use and eventual obsolescence. [ENUM-REF-CANDIDATE: draft|in_review|approved|active|frozen|obsolete|archived — 7 candidates stripped; promote to reference product]',
    `bom_type` STRING COMMENT 'Classification of the BOM by its intended use. Engineering BOM for design, Manufacturing BOM for production, Sales BOM for customer-facing configurations, Service BOM for maintenance, Planning BOM for MRP, Costing BOM for financial analysis.. Valid values are `engineering|manufacturing|sales|service|planning|costing`',
    `bom_usage` STRING COMMENT 'Intended application context for this BOM. Defines whether the BOM is used for production runs, prototyping, spare parts management, rework operations, simulation, or testing purposes.. Valid values are `production|prototype|spare_parts|rework|simulation|testing`',
    `configuration_profile` STRING COMMENT 'Reference to the variant configuration profile for configurable products. Links the BOM to the product configurator rules and constraints.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this BOM header record was first created in the system. Immutable audit field for record lifecycle tracking.',
    `effective_date` DATE COMMENT 'Date from which this BOM version becomes valid and can be used for production planning and manufacturing execution. Supports phased rollout of engineering changes.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether this BOM must comply with environmental regulations (RoHS, REACH, WEEE, ISO 14001). Used to enforce material restrictions and sustainability requirements.',
    `erp_system_code` STRING COMMENT 'Unique identifier for this BOM in the ERP system (SAP S/4HANA PP). Used for cross-system reconciliation and data lineage tracking.',
    `expiration_date` DATE COMMENT 'Date after which this BOM version is no longer valid for production use. Nullable for BOMs without a planned end date. Used to phase out obsolete BOM structures.',
    `explosion_type` STRING COMMENT 'Defines how the BOM structure is expanded in planning and costing. Single-level shows immediate components, Multi-level shows full hierarchy, Summarized aggregates across levels.. Valid values are `single_level|multi_level|summarized`',
    `is_configurable` BOOLEAN COMMENT 'Indicates whether this BOM supports variant configuration. True for BOMs with configurable components or optional features that can be selected during order entry.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether this BOM is for a critical product requiring special handling, quality controls, or regulatory compliance. Used to trigger enhanced review and approval workflows.',
    `is_phantom` BOOLEAN COMMENT 'Indicates whether this is a phantom BOM. Phantom BOMs represent transient assemblies that are not stocked but are consumed immediately in the parent assembly.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this BOM header record. Used for change tracking and audit trail purposes.',
    `lot_size` DECIMAL(18,2) COMMENT 'Standard production batch size for which this BOM is optimized. Used in Material Requirements Planning (MRP) and production scheduling to determine component requirements.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the BOM. Used for manufacturing notes, quality alerts, or design rationale.',
    `plm_system_code` STRING COMMENT 'Unique identifier for this BOM in the source PLM system (Siemens Teamcenter). Used for synchronization and traceability between PLM and ERP systems.',
    `production_version` STRING COMMENT 'Identifier linking the BOM to a specific production process and routing. Enables multiple production methods for the same product with different BOM and routing combinations.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this BOM is subject to regulatory compliance requirements (CE marking, UL certification, IEC standards, etc.). Triggers additional documentation and validation workflows.',
    CONSTRAINT pk_bom_header PRIMARY KEY(`bom_header_id`)
) COMMENT 'Bill of Materials (BOM) header record defining the top-level assembly structure for manufactured products, automation systems, and electrification solutions. Captures BOM type (engineering BOM, manufacturing BOM, sales BOM), BOM status, effective date range, plant assignment, base quantity, and revision level. Managed in Siemens Teamcenter PLM and synchronized to SAP S/4HANA PP for production planning. The BOM header is the authoritative structural definition of a manufactured product.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`product`.`product_bom_line` (
    `product_bom_line_id` BIGINT COMMENT 'Unique identifier for the BOM line item. Primary key for the product_bom_line entity.',
    `bom_header_id` BIGINT COMMENT 'Foreign key reference to the parent BOM header that this line belongs to. Each BOM line must belong to exactly one BOM header.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Production planning reports require each BOM line to reference the engineering component master to ensure design consistency and cost roll‑up.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to engineering.drawing. Business justification: Manufacturing execution system uses the drawing ID per BOM line to fetch exact assembly drawings for work orders and quality inspections.',
    `sku_master_id` BIGINT COMMENT 'Foreign key reference to the component material or part from the SKU master data that is required for this assembly. Each BOM line references exactly one component SKU.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: BOM Supplier Allocation process tracks which vendor supplies each component, essential for production scheduling and quality audits.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or production resource where this component is consumed. Used for shop floor material staging and kitting.',
    `alternative_item_group` STRING COMMENT 'Identifier for a group of interchangeable components that can substitute for each other in the assembly. Used for flexible BOM structures and supply chain resilience.',
    `alternative_item_priority` STRING COMMENT 'Priority ranking for this component within its alternative item group. Lower numbers indicate higher priority for material selection during MRP and production execution.',
    `assembly_level` STRING COMMENT 'The hierarchical level of this component in the multi-level BOM structure. Level 0 is the finished product, level 1 is direct sub-assembly, level 2 is sub-sub-assembly, etc. Used for BOM explosion and implosion.',
    `backflush_indicator` BOOLEAN COMMENT 'Flag indicating whether this component is consumed automatically via backflushing when the operation is confirmed (True) or requires manual goods issue (False). Used in lean manufacturing and MES integration.',
    `bulk_material_indicator` BOOLEAN COMMENT 'Flag indicating whether this component is a bulk material (liquids, powders, gases) that requires special handling, storage, and measurement during production.',
    `change_number` STRING COMMENT 'Internal change control number tracking modifications to this BOM line. Used for audit trail and version control in engineering change management.',
    `component_height_mm` DECIMAL(18,2) COMMENT 'Height dimension of the component in millimeters. Used for variable-size materials and spatial planning in assembly.',
    `component_length_mm` DECIMAL(18,2) COMMENT 'Length dimension of the component in millimeters. Used for variable-size materials and spatial planning in assembly.',
    `component_origin` STRING COMMENT 'Procurement strategy for this component: make (manufactured in-house), buy (purchased from supplier), make_or_buy (flexible sourcing), subcontract (outsourced manufacturing).. Valid values are `make|buy|make_or_buy|subcontract`',
    `component_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the component in kilograms. Used for calculating total assembly weight, shipping weight, and material handling requirements.',
    `component_width_mm` DECIMAL(18,2) COMMENT 'Width dimension of the component in millimeters. Used for variable-size materials and spatial planning in assembly.',
    `cost_relevance_indicator` BOOLEAN COMMENT 'Flag indicating whether this component should be included in product costing calculations. Text items and phantom assemblies are typically not cost-relevant.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this BOM line record. Used for accountability and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM line record was first created in the system. Used for audit trail and data lineage.',
    `critical_component_flag` BOOLEAN COMMENT 'Indicates whether this component is critical for production and requires special attention in material planning, procurement, and availability checking.',
    `ecn_number` STRING COMMENT 'Reference to the Engineering Change Notice that authorized this BOM line change. Provides traceability to engineering change documentation.',
    `eco_number` STRING COMMENT 'Reference to the Engineering Change Order that introduced or modified this BOM line. Links BOM changes to formal engineering change management processes.',
    `effective_end_date` DATE COMMENT 'The date after which this BOM line is no longer active and should not be used in new production orders. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this BOM line becomes active and should be used in production planning and execution. Supports date-effectivity for phased component changes.',
    `fixed_quantity_indicator` BOOLEAN COMMENT 'Indicates whether the component quantity is fixed regardless of parent assembly batch size (True) or scales proportionally with batch size (False). Used for setup materials and consumables.',
    `installation_point` STRING COMMENT 'Physical location or position identifier where this component is installed in the parent assembly. Used for assembly instructions and service documentation.',
    `item_category` STRING COMMENT 'Classification of the BOM line item type: stock (regular inventory item), non_stock (direct procurement), phantom (pass-through assembly with no inventory), text (documentation only), variable_size (length/weight variable), co_product (joint output), by_product (secondary output). [ENUM-REF-CANDIDATE: stock|non_stock|phantom|text|variable_size|co_product|by_product — 7 candidates stripped; promote to reference product]',
    `lead_time_offset_days` STRING COMMENT 'Number of days before the parent assembly start date that this component must be available. Used for backward scheduling in production planning and MRP runs.',
    `line_number` STRING COMMENT 'Sequential line item number within the BOM header, used for ordering and referencing specific components in the assembly structure.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this BOM line record. Used for accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM line record was last modified. Used for change tracking and audit trail.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, comments, or special handling requirements for this component in the assembly process.',
    `operation_sequence` STRING COMMENT 'The routing operation number at which this component is consumed or installed in the manufacturing process. Links BOM to routing for integrated production planning.',
    `product_bom_line_status` STRING COMMENT 'Current lifecycle status of this BOM line: active (in use), inactive (temporarily disabled), pending (awaiting approval), obsolete (phased out), blocked (quality hold), released (approved for production).. Valid values are `active|inactive|pending|obsolete|blocked|released`',
    `quantity_per_assembly` DECIMAL(18,2) COMMENT 'The required quantity of this component needed to produce one unit of the parent assembly. Supports up to 6 decimal places for precision in chemical, pharmaceutical, and electronics manufacturing.',
    `revision_level` STRING COMMENT 'Engineering revision level or version of this BOM line. Tracks design iterations and ensures correct component versions are used in production.',
    `scrap_factor_percent` DECIMAL(18,2) COMMENT 'Expected scrap or waste percentage for this component during the manufacturing process. Used by MRP to calculate additional material requirements. Value between 0.00 and 100.00.',
    `spare_part_indicator` BOOLEAN COMMENT 'Indicates whether this component is also available as a spare part for after-sales service and maintenance. Used for service parts planning and documentation.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the component quantity (e.g., EA=Each, PC=Piece, KG=Kilogram, L=Liter, M=Meter). Must align with the component SKU base unit of measure. [ENUM-REF-CANDIDATE: EA|PC|KG|G|L|ML|M|CM|FT|IN|LB|OZ|SET|BOX|ROLL|SHEET — 16 candidates stripped; promote to reference product]',
    CONSTRAINT pk_product_bom_line PRIMARY KEY(`product_bom_line_id`)
) COMMENT 'Individual component line items within a Bill of Materials (BOM), representing the parent-child assembly relationships for manufactured products. Captures component SKU reference, quantity per assembly, unit of measure, item category (stock, non-stock, phantom), scrap factor, lead time offset, alternative item group, and engineering change order (ECO) reference. Supports multi-level BOM explosion for MRP runs in SAP S/4HANA PP and production routing in Siemens Opcenter MES. Each bom_line belongs to exactly one bom_header and references exactly one component from sku_master.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`product`.`product_revision` (
    `product_revision_id` BIGINT COMMENT 'Unique identifier for the product revision record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Engineering change orders (ECOs/ECNs) — evidenced by ecn_number and eco_number on product_revision — incur engineering labor, tooling, and testing costs charged to cost centers. Industrial manufacturi',
    `ecn_id` BIGINT COMMENT 'Foreign key linking to engineering.ecn. Business justification: ECN-to-product-revision traceability: the Engineering Change Notice is the formal release document that authorizes a product revision. Regulatory compliance and customer notification workflows require',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Change management traceability: every product revision in industrial manufacturing is triggered by an Engineering Change Order. Auditors and PPAP documentation require tracing product_revision back to',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Engineering-to-product revision traceability: in industrial manufacturing, a product revision is directly derived from an engineering revision. PPAP submissions, regulatory filings, and interchangeabi',
    `sku_master_id` BIGINT COMMENT 'Reference to the parent product for which this revision applies. Links to the product master record.',
    `superseded_revision_product_revision_id` BIGINT COMMENT 'Reference to the previous product revision that this revision replaces. Maintains revision lineage and traceability.',
    `approval_date` DATE COMMENT 'Date when this revision was formally approved for release to manufacturing.',
    `approval_status` STRING COMMENT 'Current approval state of the revision within the engineering change control workflow.. Valid values are `not_submitted|pending|approved|rejected|conditional`',
    `bom_affected_flag` BOOLEAN COMMENT 'Indicates whether this revision includes changes to the product Bill of Materials structure or component list.',
    `change_impact_level` STRING COMMENT 'Assessment of the magnitude and scope of impact this revision has on form, fit, function, manufacturing process, or supply chain.. Valid values are `minor|moderate|major|critical`',
    `change_reason_code` STRING COMMENT 'Categorization of the primary business reason or driver for this engineering revision.. Valid values are `design_improvement|cost_reduction|quality_issue|regulatory_compliance|supplier_change|customer_request`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revision record was first created in the source system.',
    `customer_notification_required_flag` BOOLEAN COMMENT 'Indicates whether customers must be formally notified of this revision due to impact on form, fit, function, or regulatory compliance.',
    `drawing_affected_flag` BOOLEAN COMMENT 'Indicates whether this revision includes changes to engineering drawings, CAD (Computer-Aided Design) models, or technical documentation.',
    `effectivity_date` DATE COMMENT 'Date when this revision becomes effective for manufacturing and procurement. Determines when the new revision must be used in production.',
    `effectivity_serial_end` STRING COMMENT 'Ending serial number through which this revision is effective, when effectivity is controlled by serial number range.',
    `effectivity_serial_start` STRING COMMENT 'Starting serial number from which this revision is effective, when effectivity is controlled by serial number.',
    `effectivity_type` STRING COMMENT 'Method by which the revision effectivity is controlled (by date, serial number range, lot/batch, or immediate implementation).. Valid values are `date|serial_number|lot_batch|immediate`',
    `interchangeability_code` STRING COMMENT 'Defines whether this revision can be substituted for previous revisions in existing assemblies or field installations.. Valid values are `fully_interchangeable|forward_compatible|not_interchangeable`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this revision record was last updated in the source system.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or instructions related to this revision for engineering, manufacturing, or quality teams.',
    `obsolete_date` DATE COMMENT 'Date when this revision was marked as obsolete and no longer valid for new production orders.',
    `ppap_required_flag` BOOLEAN COMMENT 'Indicates whether this revision requires a new Production Part Approval Process submission to customers.',
    `process_affected_flag` BOOLEAN COMMENT 'Indicates whether this revision requires changes to manufacturing processes, work instructions, or shop floor procedures.',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this revision requires re-certification or approval from regulatory bodies (UL, CE, OSHA, EPA, etc.).',
    `release_date` DATE COMMENT 'Date when this revision was officially released to production and made available for use in manufacturing operations.',
    `revision_code` STRING COMMENT 'Engineering revision level identifier (e.g., A, B, C, 01, 02). Represents the sequential version of the product design.. Valid values are `^[A-Z0-9]{1,10}$`',
    `revision_description` STRING COMMENT 'Detailed description of the changes introduced in this revision, including design modifications, material changes, or process improvements.',
    `revision_status` STRING COMMENT 'Current lifecycle status of the product revision indicating its approval and release state.. Valid values are `draft|pending_approval|approved|released|obsolete|superseded`',
    `source_system` STRING COMMENT 'Name of the source PLM (Product Lifecycle Management) or ERP (Enterprise Resource Planning) system from which this revision record originated.',
    `source_system_code` STRING COMMENT 'Unique identifier of this revision record in the source PLM (Product Lifecycle Management) system for traceability and reconciliation.',
    `specification_affected_flag` BOOLEAN COMMENT 'Indicates whether this revision includes changes to product specifications, performance requirements, or acceptance criteria.',
    `testing_affected_flag` BOOLEAN COMMENT 'Indicates whether this revision requires changes to quality testing procedures, inspection plans, or validation protocols.',
    `tooling_affected_flag` BOOLEAN COMMENT 'Indicates whether this revision requires changes to manufacturing tooling, fixtures, jigs, or molds.',
    CONSTRAINT pk_product_revision PRIMARY KEY(`product_revision_id`)
) COMMENT 'Manages engineering revision history for manufactured products, tracking each revision level, Engineering Change Order (ECO) and Engineering Change Notice (ECN) references, revision description, effectivity date, and approval status. Captures the delta between revisions including affected BOM lines, drawing changes, and specification updates. Ensures traceability from product design through manufacturing execution per ISO 9001 document control requirements. Sourced from Siemens Teamcenter PLM.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`product`.`product_specification` (
    `product_specification_id` BIGINT COMMENT 'Unique identifier for the product specification record. Primary key.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to engineering.drawing. Business justification: Drawing-to-specification linkage: product specifications reference the controlling technical drawing for dimensional and tolerance requirements. CE marking, UL certification, and customer qualificatio',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Specification derivation traceability: product specifications (commercial/manufacturing) are derived from engineering specifications (design intent). Regulatory submissions, customer qualification pac',
    `product_revision_id` BIGINT COMMENT 'Foreign key linking to product.product_revision. Business justification: product_specification.revision_number is a denormalized string reference to the engineering revision. A technical specification is authored and valid for a specific engineering revision of a product —',
    `sku_master_id` BIGINT COMMENT 'Reference to the parent product in the product catalog. Links this specification to the master product record.',
    `altitude_rating_meters` DECIMAL(18,2) COMMENT 'Maximum operating altitude in meters above sea level. Defines altitude limitations for product operation due to air pressure and cooling considerations.',
    `application_suitability` STRING COMMENT 'Intended application areas and use cases. Describes the industrial applications, environments, or processes for which the product is designed and suitable.',
    `approved_date` DATE COMMENT 'Date when this specification version was formally approved. Tracks the approval milestone in the specification lifecycle.',
    `color_finish` STRING COMMENT 'Product color and surface finish. Describes the external appearance and coating (e.g., RAL 7035 light grey, powder coated, anodized aluminum).',
    `communication_protocol` STRING COMMENT 'Supported communication protocols for data exchange. Lists the industrial communication standards the product supports (e.g., PROFINET, EtherNet/IP, Modbus TCP, OPC UA).',
    `connection_type` STRING COMMENT 'Electrical connection or terminal type. Describes the method for connecting wires or cables to the product (e.g., screw terminals, spring clamp, plug connector).',
    `current_rating_amperes` DECIMAL(18,2) COMMENT 'Maximum continuous current rating in amperes. Defines the electrical current capacity of the product.',
    `datasheet_reference` STRING COMMENT 'Reference identifier or document number for the associated product datasheet. Links to the detailed technical datasheet managed in the engineering document management system.',
    `dimensions_height_mm` DECIMAL(18,2) COMMENT 'Product height dimension in millimeters. Defines the physical height for installation planning and space requirements.',
    `dimensions_length_mm` DECIMAL(18,2) COMMENT 'Product length dimension in millimeters. Defines the physical length for installation planning and space requirements.',
    `dimensions_width_mm` DECIMAL(18,2) COMMENT 'Product width dimension in millimeters. Defines the physical width for installation planning and space requirements.',
    `effective_date` DATE COMMENT 'Date when this specification version becomes effective and applicable for use in engineering, manufacturing, and sales processes.',
    `expiration_date` DATE COMMENT 'Date when this specification version is no longer valid or has been superseded by a newer revision. Null for active specifications without planned obsolescence.',
    `frequency_rating_hz` STRING COMMENT 'Operating frequency rating in Hertz. Specifies the electrical frequency the product is designed for (e.g., 50Hz, 60Hz, 50/60Hz).',
    `humidity_rating_percent` STRING COMMENT 'Relative humidity rating or range for product operation. Specifies the acceptable humidity conditions (e.g., 5-95% RH non-condensing).',
    `installation_manual_reference` STRING COMMENT 'Reference identifier or document number for the installation manual. Links to the installation instructions managed in the engineering document management system.',
    `ip_rating` STRING COMMENT 'Ingress Protection rating per IEC 60529 standard. Defines the level of protection against solid objects and liquids (e.g., IP65, IP67, IP20).. Valid values are `^IP[0-9]{2}[A-Z]?$`',
    `material_composition` STRING COMMENT 'Primary materials used in product construction. Lists the key materials and their properties (e.g., stainless steel housing, polycarbonate cover, copper conductors).',
    `mounting_type` STRING COMMENT 'Physical mounting method for the product. Specifies how the product is installed (e.g., DIN rail, panel mount, wall mount).. Valid values are `din_rail|panel_mount|wall_mount|floor_mount|rack_mount|embedded`',
    `nema_rating` STRING COMMENT 'NEMA enclosure rating for North American markets. Defines environmental protection level (e.g., NEMA1, NEMA4, NEMA4X, NEMA12).. Valid values are `^NEMA[0-9]{1,2}[A-Z]?$`',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the specification. Captures supplementary information for engineering, quality, or sales teams.',
    `operating_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum operating ambient temperature in degrees Celsius. Defines the upper temperature limit for safe and reliable product operation.',
    `operating_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum operating ambient temperature in degrees Celsius. Defines the lower temperature limit for safe and reliable product operation.',
    `performance_parameter` STRING COMMENT 'Key performance parameters and metrics. Describes critical performance characteristics such as response time, accuracy, throughput, or efficiency ratings specific to the product type.',
    `power_rating_watts` DECIMAL(18,2) COMMENT 'Electrical power rating in watts. Specifies the maximum power consumption or output capacity of the product.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this specification record was first created in the system. Tracks the initial capture of the specification data.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this specification record was last modified. Tracks the most recent update to any field in the specification record.',
    `safety_data_sheet_reference` STRING COMMENT 'Reference identifier for the Safety Data Sheet. Links to the SDS document for products containing hazardous materials, managed in the engineering document management system.',
    `shock_resistance` STRING COMMENT 'Mechanical shock resistance specification. Describes the products ability to withstand mechanical shock per applicable test standards (e.g., IEC 60068-2-27).',
    `source_system` STRING COMMENT 'Operational system of record where this specification was originally created or is mastered. Identifies whether the specification originates from Siemens Teamcenter PLM, SAP S/4HANA, or manual entry.. Valid values are `teamcenter_plm|sap_s4hana|manual_entry`',
    `source_system_code` STRING COMMENT 'Unique identifier of this specification record in the source system. Enables traceability back to the originating system for data lineage and reconciliation.',
    `specification_description` STRING COMMENT 'Detailed textual description of the product specification. Provides comprehensive technical and commercial details not captured in structured fields.',
    `specification_name` STRING COMMENT 'Human-readable name or title of the product specification. Describes the specification purpose or scope.',
    `specification_number` STRING COMMENT 'Unique business identifier for the product specification document. Used for external reference and traceability across engineering, quality, and sales teams.. Valid values are `^SPEC-[A-Z0-9]{8,12}$`',
    `specification_status` STRING COMMENT 'Current lifecycle status of the product specification. Tracks the approval and active state of the specification document.. Valid values are `draft|under_review|approved|active|obsolete|superseded`',
    `specification_type` STRING COMMENT 'Classification of the specification document type. Indicates whether the specification covers technical parameters, commercial terms, or a combination.. Valid values are `technical|commercial|combined|performance|safety|environmental`',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum storage temperature in degrees Celsius. Defines the upper temperature limit for product storage when not in operation.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum storage temperature in degrees Celsius. Defines the lower temperature limit for product storage when not in operation.',
    `vibration_resistance` STRING COMMENT 'Vibration resistance specification. Describes the products ability to withstand mechanical vibration per applicable test standards (e.g., IEC 60068-2-6).',
    `voltage_rating` STRING COMMENT 'Electrical voltage rating or range for the product. Specifies the nominal operating voltage and acceptable voltage range (e.g., 24VDC, 110-240VAC, 400V 3-phase).',
    `weight_kg` DECIMAL(18,2) COMMENT 'Product weight in kilograms. Defines the mass for shipping, handling, and installation planning.',
    CONSTRAINT pk_product_specification PRIMARY KEY(`product_specification_id`)
) COMMENT 'Technical and commercial specifications for manufactured products, automation systems, and electrification solutions. Captures electrical ratings, mechanical dimensions, environmental ratings (IP class, NEMA class), operating temperature range, performance parameters, and application suitability. Includes references to associated technical documentation (datasheets, installation manuals, safety data sheets) managed in the engineering domains document management system. Serves as the authoritative technical specification record referenced by engineering, quality, and sales teams. Managed in Siemens Teamcenter PLM and SAP S/4HANA. Note: certification records (UL, CE, IEC, ATEX, RoHS/REACH) are tracked separately in the certification product.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`product`.`product_certification` (
    `product_certification_id` BIGINT COMMENT 'Unique identifier for the product certification record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: product_certification already tracks cost_amount and cost_currency_code, confirming real certification spend. Linking to cost_center enables certification budget vs. actual reporting — a standard comp',
    `quality_audit_id` BIGINT COMMENT 'Foreign key linking to quality.quality_audit. Business justification: Product certifications (CE, UL, ISO) are validated through quality audits — the certifying body conducts an audit before issuing the certificate. Linking product_certification to the quality_audit tha',
    `sku_master_id` BIGINT COMMENT 'Reference to the manufactured product, automation system, electrification solution, or smart infrastructure component that holds this certification.',
    `applicable_markets` STRING COMMENT 'Geographic markets, regions, or countries where this certification enables product sale and distribution (e.g., European Union, North America, APAC). Pipe-separated list of ISO 3166-1 alpha-3 country codes or region identifiers.',
    `applicable_standards` STRING COMMENT 'Technical standards, regulations, or directives against which the product was certified (e.g., IEC 61131-2, EN 60204-1, UL 508). Pipe-separated list of standard identifiers.',
    `audit_date` DATE COMMENT 'Date of the most recent audit or inspection conducted by the certifying body to verify ongoing compliance.',
    `certificate_document_url` STRING COMMENT 'URL or file path to the digital copy of the certification certificate document stored in the document management system.',
    `certification_level` STRING COMMENT 'Classification or rating level assigned by the certification (e.g., ATEX Zone 1, IP67, Safety Integrity Level SIL 2, Performance Level PLd).',
    `certification_number` STRING COMMENT 'Unique certificate number or listing identifier issued by the certifying body (e.g., UL file number, CE declaration number, IEC certificate ID).',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification indicating whether it is valid, expired, pending renewal, or revoked.. Valid values are `Active|Expired|Pending Renewal|Suspended|Revoked|Under Review`',
    `certification_type` STRING COMMENT 'Type of regulatory or safety certification obtained. Indicates the certification standard or framework under which the product was evaluated. [ENUM-REF-CANDIDATE: UL Listing|CE Marking|IEC Compliance|ATEX Rating|RoHS Declaration|REACH Declaration|ECCN Classification|FCC Certification|CSA Approval|TUV Certification — 10 candidates stripped; promote to reference product]',
    `certifying_body` STRING COMMENT 'Name of the organization or authority that issued the certification (e.g., Underwriters Laboratories, TUV Rheinland, Notified Body, National Standards Authority).',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to obtain and maintain this certification, including testing fees, audit fees, and certification body charges.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the certification cost amount (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system.',
    `cybersecurity_certification` STRING COMMENT 'Cybersecurity certification or compliance level achieved by the product (e.g., IEC 62443-4-1, IEC 62443-4-2, NIST Cybersecurity Framework).',
    `declaration_of_conformity_number` STRING COMMENT 'Unique identifier for the manufacturers Declaration of Conformity document associated with this certification, particularly for CE marking.',
    `eccn_code` STRING COMMENT 'Export Control Classification Number assigned under the U.S. Commerce Control List for dual-use items subject to export regulations.',
    `effective_date` DATE COMMENT 'Date from which the certification becomes valid and the product is authorized for market access under the certification scope.',
    `energy_efficiency_rating` STRING COMMENT 'Energy efficiency classification or rating assigned to the product (e.g., Energy Star, EU Energy Label class A+++, IEC 60034-30-1 efficiency class IE3).',
    `environmental_certification` STRING COMMENT 'Environmental management or sustainability certification obtained (e.g., ISO 14001, LEED, BREEAM, Cradle to Cradle).',
    `expiry_date` DATE COMMENT 'Date on which the certification expires and requires renewal. Null for certifications with indefinite validity subject to ongoing compliance.',
    `functional_safety_certification` STRING COMMENT 'Functional safety certification level achieved by the product (e.g., IEC 61508 SIL 2, ISO 13849 PLd, IEC 61511).',
    `is_customer_facing` BOOLEAN COMMENT 'Indicates whether this certification is typically disclosed to customers in product documentation, datasheets, or sales materials as a market differentiator.',
    `issue_date` DATE COMMENT 'Date on which the certification was officially issued or granted by the certifying body.',
    `mandatory_for_markets` STRING COMMENT 'List of markets or regions where this certification is legally mandatory for product sale (as opposed to voluntary). Pipe-separated ISO 3166-1 alpha-3 country codes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last modified or updated in the system.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next surveillance audit or re-certification assessment by the certifying body.',
    `product_scope` STRING COMMENT 'Description of the product models, configurations, or variants covered under this certification. Defines the boundary of what is certified.',
    `quality_certification` STRING COMMENT 'Quality management system certification under which the product was manufactured (e.g., ISO 9001, IATF 16949, AS9100).',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the product complies with REACH regulation for chemical substance registration and restriction in the European Union.',
    `remarks` STRING COMMENT 'Additional notes, conditions, limitations, or special requirements associated with the certification. May include restrictions on use, environmental conditions, or configuration dependencies.',
    `renewal_date` DATE COMMENT 'Target or scheduled date for certification renewal or re-assessment to maintain continuous compliance.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the product complies with RoHS Directive restricting the use of hazardous substances in electrical and electronic equipment.',
    `test_report_number` STRING COMMENT 'Reference number of the test report or assessment documentation that supports the certification issuance.',
    `weee_compliant` BOOLEAN COMMENT 'Indicates whether the product complies with WEEE Directive for proper disposal and recycling of electronic waste.',
    CONSTRAINT pk_product_certification PRIMARY KEY(`product_certification_id`)
) COMMENT 'Tracks regulatory and safety certifications obtained for manufactured products including UL listings, CE marking, IEC compliance, ATEX ratings, RoHS/REACH declarations, and export control classifications (ECCN). Captures certifying body, certificate number, issue date, expiry date, applicable markets/regions, product scope, and renewal status. Critical for market access compliance and customer-facing documentation. Supports ISO 9001 quality records and regulatory reporting to UL, CE, and OSHA.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`product`.`plant_data` (
    `plant_data_id` BIGINT COMMENT 'Primary key for plant_data',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Plant‑level cost reporting requires linking plant data to the plants cost center.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: plant_data carries valuation_class which in SAP-style manufacturing ERPs maps directly to an inventory GL account governing all goods movement postings. This product-plant-to-GL link is fundamental to',
    `plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: product.plant_data IS the plant-specific view of a SKU — it exists per plant and contains plant-specific MRP, procurement, and storage parameters. The plain plant_code attribute is a denormalized refe',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Associate plant‑specific data with the SKU it describes; enables plant‑level planning per SKU',
    `abc_indicator` STRING COMMENT 'ABC classification for inventory management prioritization. A=High-value items requiring tight control, B=Medium-value items, C=Low-value items with relaxed control.. Valid values are `A|B|C`',
    `availability_check_group` STRING COMMENT 'Two-character key that controls which stock types are included in ATP (Available-to-Promise) checks for sales orders and production orders.. Valid values are `^[A-Z0-9]{2}$`',
    `backflush_indicator` BOOLEAN COMMENT 'Indicates whether components are backflushed (automatically issued) when production order confirmations are posted. True=Backflush enabled, False=Manual goods issue required.',
    `batch_management_required` BOOLEAN COMMENT 'Indicates whether batch/lot tracking is required for this material at this plant. True=Batch management active, False=No batch tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this plant data record was first created in the system.',
    `cycle_counting_indicator` STRING COMMENT 'Single-character code that determines the frequency of cycle counting for this material. Used to schedule physical inventory counts.. Valid values are `^[A-Z0-9]{1}$`',
    `discontinuation_date` DATE COMMENT 'Date on which this material will be discontinued at this plant. Used for phase-out planning and last-time-buy notifications.',
    `effective_out_date` DATE COMMENT 'Date from which this plant data record becomes inactive. Used to manage time-dependent plant data changes.',
    `fixed_lot_size` DECIMAL(18,2) COMMENT 'Fixed order quantity used when lot size procedure is set to fixed lot size. MRP will always propose this quantity.',
    `gr_processing_time_days` STRING COMMENT 'Number of days required for goods receipt processing, quality inspection, and stock placement after physical delivery.',
    `in_house_production_time_days` STRING COMMENT 'Number of working days required to manufacture this material from raw materials to finished goods at this plant. Used in production scheduling and MRP.',
    `inspection_setup_required` BOOLEAN COMMENT 'Indicates whether a quality inspection setup (inspection lot creation) is required for goods receipts of this material at this plant. True=Inspection required, False=No inspection.',
    `issue_storage_location` STRING COMMENT 'Four-character code identifying the default storage location from which materials are issued to production orders or sales orders.. Valid values are `^[A-Z0-9]{4}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this plant data record was last updated.',
    `lot_size_procedure` STRING COMMENT 'Lot-sizing procedure used in MRP to determine order quantities. EX=Lot-for-lot, HB=Replenish to maximum stock level, FX=Fixed lot size, WB=Weekly lot size, PK=Period lot size, LS=Lot size key.. Valid values are `EX|HB|FX|WB|PK|LS`',
    `material_number` STRING COMMENT 'Unique material identifier (SKU) from the material master. Links this plant data record to the global material master.. Valid values are `^[A-Z0-9]{8,18}$`',
    `maximum_lot_size` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered or produced in a single lot for this material at this plant. Used in MRP calculations.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Target maximum inventory level for this material at this plant. Used in replenishment planning to determine order quantities.',
    `minimum_lot_size` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered or produced in a single lot for this material at this plant. Used in MRP calculations.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum number of days of remaining shelf life required for goods receipt acceptance. Batches with less remaining shelf life are rejected.',
    `modified_by_user` STRING COMMENT 'User ID of the person who last modified this plant data record. Used for audit trail and change tracking.. Valid values are `^[A-Z0-9]{12}$`',
    `mrp_controller` STRING COMMENT 'Three-character code identifying the person or group responsible for MRP and procurement activities for this material at this plant.. Valid values are `^[A-Z0-9]{3}$`',
    `mrp_type` STRING COMMENT 'MRP procedure that controls how material requirements are planned. PD=MRP, VB=Manual reorder point, VM=Forecast-based planning, VV=Time-phased planning, ND=No planning, R1=Reorder point planning, R2=Replenishment planning. [ENUM-REF-CANDIDATE: PD|VB|VM|VV|ND|R1|R2 — 7 candidates stripped; promote to reference product]',
    `negative_stock_allowed` BOOLEAN COMMENT 'Indicates whether negative stock balances are permitted for this material at this plant. True=Negative stock allowed, False=System blocks transactions that would create negative stock.',
    `planned_delivery_time_days` STRING COMMENT 'Number of calendar days from order placement to goods receipt. Used by MRP to schedule procurement proposals and calculate reorder points.',
    `plant_status` STRING COMMENT 'Current lifecycle status of this material at this plant. Active=Normal production/sales, Blocked=Temporarily unavailable, Discontinued=End-of-life, Phase_out=Being phased out, New_product_introduction=NPI stage.. Valid values are `active|blocked|discontinued|phase_out|new_product_introduction`',
    `procurement_type` STRING COMMENT 'Indicates how the material is procured at this plant. E=In-house production, F=External procurement (purchasing), X=Both production and external procurement.. Valid values are `E|F|X`',
    `production_storage_location` STRING COMMENT 'Four-character code identifying the default storage location within the plant where finished goods from production are received.. Valid values are `^[A-Z0-9]{4}$`',
    `profit_center` STRING COMMENT 'Ten-character code identifying the profit center responsible for this material at this plant. Used for internal profitability analysis.. Valid values are `^[A-Z0-9]{10}$`',
    `quality_inspection_type` STRING COMMENT 'QM inspection type that determines when quality inspections are triggered. 01=Goods receipt from vendor, 02=Goods receipt from production, 03=Goods issue to customer, 04=Stock transfer, 05=Physical inventory, 08=Recurring inspection, 09=Audit inspection. [ENUM-REF-CANDIDATE: 01|02|03|04|05|08|09 — 7 candidates stripped; promote to reference product]',
    `reorder_point` DECIMAL(18,2) COMMENT 'Stock level at which MRP triggers a procurement proposal. Calculated based on lead time demand plus safety stock.',
    `rounding_value` DECIMAL(18,2) COMMENT 'Rounding value for lot sizes. MRP rounds proposed order quantities up to the nearest multiple of this value.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum stock level maintained as buffer against demand fluctuations and supply disruptions. MRP triggers procurement when stock falls below this level plus reorder point.',
    `scheduling_margin_key` STRING COMMENT 'Key that defines float times (opening period, float before production, float after production) used in production scheduling to add buffer time.. Valid values are `^[A-Z0-9]{3}$`',
    `serialization_level` STRING COMMENT 'Controls serial number management for this material at this plant. 0=No serial numbers, 1=Serial number at goods receipt, 2=Serial number at goods issue, 3=Serial number at goods receipt and issue, 4=Serial number at production.. Valid values are `0|1|2|3|4`',
    `shelf_life_expiration_days` STRING COMMENT 'Total shelf life period in days from production date to expiration date. Used for batch management and FEFO (First Expired First Out) logic.',
    `special_procurement_type` STRING COMMENT 'Special procurement key for subcontracting, consignment, stock transfer, or other special procurement scenarios. 10=Withdrawal from warehouse, 20=Production in another plant, 30=External procurement, 40=Subcontracting, 50=Phantom assembly, 51=Phantom assembly with lead time, 52=Collective order, 70=Stock transfer, 80=Consignment, 90=Pipeline. [ENUM-REF-CANDIDATE: 10|20|30|40|50|51|52|70|80|90 — 10 candidates stripped; promote to reference product]',
    `valuation_class` STRING COMMENT 'Four-digit code that determines the general ledger accounts to which inventory movements are posted. Links material movements to financial accounting.. Valid values are `^[0-9]{4}$`',
    CONSTRAINT pk_plant_data PRIMARY KEY(`plant_data_id`)
) COMMENT 'Plant-specific master data extensions for each SKU, capturing manufacturing plant assignment, MRP type, lot size procedure, safety stock level, reorder point, planned delivery time, production storage location, and quality inspection type. Represents the SAP S/4HANA MM/PP plant view of the material master, enabling plant-level production planning, MRP runs, and inventory management. Each SKU may have different plant data records per manufacturing facility.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ADD CONSTRAINT `fk_product_sku_master_family_id` FOREIGN KEY (`family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`family` ADD CONSTRAINT `fk_product_family_parent_family_id` FOREIGN KEY (`parent_family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_family_id` FOREIGN KEY (`family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ADD CONSTRAINT `fk_product_configuration_superseded_by_configuration_id` FOREIGN KEY (`superseded_by_configuration_id`) REFERENCES `manufacturing_ecm`.`product`.`configuration`(`configuration_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_plant_data_id` FOREIGN KEY (`plant_data_id`) REFERENCES `manufacturing_ecm`.`product`.`plant_data`(`plant_data_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_family_id` FOREIGN KEY (`family_id`) REFERENCES `manufacturing_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_product_revision_id` FOREIGN KEY (`product_revision_id`) REFERENCES `manufacturing_ecm`.`product`.`product_revision`(`product_revision_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ADD CONSTRAINT `fk_product_bom_header_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_bom_header_id` FOREIGN KEY (`bom_header_id`) REFERENCES `manufacturing_ecm`.`product`.`bom_header`(`bom_header_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ADD CONSTRAINT `fk_product_product_bom_line_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ADD CONSTRAINT `fk_product_product_revision_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ADD CONSTRAINT `fk_product_product_revision_superseded_revision_product_revision_id` FOREIGN KEY (`superseded_revision_product_revision_id`) REFERENCES `manufacturing_ecm`.`product`.`product_revision`(`product_revision_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ADD CONSTRAINT `fk_product_product_specification_product_revision_id` FOREIGN KEY (`product_revision_id`) REFERENCES `manufacturing_ecm`.`product`.`product_revision`(`product_revision_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ADD CONSTRAINT `fk_product_product_specification_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ADD CONSTRAINT `fk_product_product_certification_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ADD CONSTRAINT `fk_product_plant_data_sku_master_id` FOREIGN KEY (`sku_master_id`) REFERENCES `manufacturing_ecm`.`product`.`sku_master`(`sku_master_id`);

-- ========= TAGS =========
ALTER SCHEMA `manufacturing_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `manufacturing_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Master ID');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `base_uom` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UoM)');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `commercial_description` SET TAGS ('dbx_business_glossary_term' = 'Commercial Description');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `dimension_uom` SET TAGS ('dbx_business_glossary_term' = 'Dimension Unit of Measure (UoM)');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `dimension_uom` SET TAGS ('dbx_value_regex' = 'MM|CM|M|IN|FT');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `eccn_code` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}(.[a-z])?$');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `hazard_class` SET TAGS ('dbx_value_regex' = '^[1-9](.[1-6])?$');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `height` SET TAGS ('dbx_business_glossary_term' = 'Height Dimension');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `hts_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `hts_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `length` SET TAGS ('dbx_business_glossary_term' = 'Length Dimension');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'npi|active|mature|phase_out|discontinued|obsolete');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Long Description');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `lot_control_required` SET TAGS ('dbx_business_glossary_term' = 'Lot Control Required Indicator');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `make_or_buy_code` SET TAGS ('dbx_business_glossary_term' = 'Make or Buy Code');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `make_or_buy_code` SET TAGS ('dbx_value_regex' = 'make|buy|both');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10,18}$');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `plm_item_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Item ID');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `production_to_base_conversion` SET TAGS ('dbx_business_glossary_term' = 'Production to Base Unit of Measure (UoM) Conversion Factor');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `production_uom` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure (UoM)');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'Revision Level');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `revision_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `sales_to_base_conversion` SET TAGS ('dbx_business_glossary_term' = 'Sales to Base Unit of Measure (UoM) Conversion Factor');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `sales_uom` SET TAGS ('dbx_business_glossary_term' = 'Sales Unit of Measure (UoM)');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `sds_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `serial_control_required` SET TAGS ('dbx_business_glossary_term' = 'Serial Control Required Indicator');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Days');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UoM)');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'L|ML|M3|GAL|FT3|IN3');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure (UoM)');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `weight_uom` SET TAGS ('dbx_value_regex' = 'KG|LB|G|OZ|MT|TON');
ALTER TABLE `manufacturing_ecm`.`product`.`sku_master` ALTER COLUMN `width` SET TAGS ('dbx_business_glossary_term' = 'Width Dimension');
ALTER TABLE `manufacturing_ecm`.`product`.`family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`product`.`family` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Identifier');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `parent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Product Family ID');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirements');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `competitive_positioning` SET TAGS ('dbx_business_glossary_term' = 'Competitive Positioning');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `competitive_positioning` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `cybersecurity_classification` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Classification');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `cybersecurity_classification` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|not_applicable');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `environmental_compliance` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Standards');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `erp_material_group` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Material Group');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `family_code` SET TAGS ('dbx_business_glossary_term' = 'Product Family Code');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `family_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `family_description` SET TAGS ('dbx_business_glossary_term' = 'Product Family Description');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Product Family Name');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `family_type` SET TAGS ('dbx_business_glossary_term' = 'Product Family Type');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Product Family Hierarchy Level');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `innovation_priority` SET TAGS ('dbx_business_glossary_term' = 'Innovation Priority');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `innovation_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `iot_enabled` SET TAGS ('dbx_business_glossary_term' = 'Internet of Things (IoT) Enabled');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (Days)');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Product Family Lifecycle Status');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|phase_out|new_product_introduction|end_of_life|under_development');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `list_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `manufacturing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Strategy');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `manufacturing_strategy` SET TAGS ('dbx_value_regex' = 'make_to_stock|make_to_order|engineer_to_order|configure_to_order|assemble_to_order');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `mean_time_between_failures` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF)');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `mean_time_to_repair` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR)');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `plm_category` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Category');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'manufactured|purchased|both');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `product_line_owner` SET TAGS ('dbx_business_glossary_term' = 'Product Line Owner');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `product_portfolio_strategy` SET TAGS ('dbx_business_glossary_term' = 'Product Portfolio Strategy');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `product_portfolio_strategy` SET TAGS ('dbx_value_regex' = 'invest|maintain|harvest|divest');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Master Data Record Status');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|archived');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `service_level_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Tier');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `service_level_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|critical|basic');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `target_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Margin Percentage');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `target_margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `technology_platform` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform');
ALTER TABLE `manufacturing_ecm`.`product`.`family` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Standard Warranty Period (Months)');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Identifier');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Base Product ID');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `superseded_by_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Configuration ID');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Price');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `base_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirements');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `configuration_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `configuration_type` SET TAGS ('dbx_business_glossary_term' = 'Configuration Type');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `configuration_type` SET TAGS ('dbx_value_regex' = 'standard|custom|engineer_to_order|make_to_order|configure_to_order|assemble_to_order');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `constraint_rules` SET TAGS ('dbx_business_glossary_term' = 'Constraint Rules');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `dimensions_height_mm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions Height Millimeters');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `dimensions_length_mm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions Length Millimeters');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `dimensions_width_mm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions Width Millimeters');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `is_orderable` SET TAGS ('dbx_business_glossary_term' = 'Is Orderable');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `is_quotable` SET TAGS ('dbx_business_glossary_term' = 'Is Quotable');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `manufacturing_complexity` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Complexity');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `manufacturing_complexity` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating Kilowatts');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `price_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Configuration Price Adjustment');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `price_adjustment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'base_plus_options|bundled|tiered|custom_quote|cost_plus|value_based');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `regional_availability` SET TAGS ('dbx_business_glossary_term' = 'Regional Availability');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `requires_engineering_review` SET TAGS ('dbx_business_glossary_term' = 'Requires Engineering Review');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `selected_options` SET TAGS ('dbx_business_glossary_term' = 'Selected Options');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `technical_specification_document` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Document');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `total_configuration_price` SET TAGS ('dbx_business_glossary_term' = 'Total Configuration Price');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `total_configuration_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `voltage_rating` SET TAGS ('dbx_business_glossary_term' = 'Voltage Rating');
ALTER TABLE `manufacturing_ecm`.`product`.`configuration` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kilograms');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` SET TAGS ('dbx_subdomain' = 'assembly_structure');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header ID');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `ecn_id` SET TAGS ('dbx_business_glossary_term' = 'Ecn Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `plant_data_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `family_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `product_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Product Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `alternative_bom_indicator` SET TAGS ('dbx_business_glossary_term' = 'Alternative Bill of Materials (BOM) Indicator');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `bom_category` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Category');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `bom_category` SET TAGS ('dbx_value_regex' = 'standard|configurable|phantom|reference|kit');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `bom_description` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Description');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Type');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'engineering|manufacturing|sales|service|planning|costing');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `bom_usage` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Usage');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `bom_usage` SET TAGS ('dbx_value_regex' = 'production|prototype|spare_parts|rework|simulation|testing');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `configuration_profile` SET TAGS ('dbx_business_glossary_term' = 'Configuration Profile');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `erp_system_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) System ID');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `explosion_type` SET TAGS ('dbx_business_glossary_term' = 'Explosion Type');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `explosion_type` SET TAGS ('dbx_value_regex' = 'single_level|multi_level|summarized');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `is_configurable` SET TAGS ('dbx_business_glossary_term' = 'Is Configurable Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `is_phantom` SET TAGS ('dbx_business_glossary_term' = 'Is Phantom Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `plm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System ID');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `manufacturing_ecm`.`product`.`bom_header` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` SET TAGS ('dbx_subdomain' = 'assembly_structure');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `product_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bill of Materials (BOM) Line ID');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header ID');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Component Stock Keeping Unit (SKU) ID');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `alternative_item_group` SET TAGS ('dbx_business_glossary_term' = 'Alternative Item Group');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `alternative_item_priority` SET TAGS ('dbx_business_glossary_term' = 'Alternative Item Priority');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `assembly_level` SET TAGS ('dbx_business_glossary_term' = 'Assembly Level');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `backflush_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backflush Indicator');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `bulk_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Bulk Material Indicator');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Change Number');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `component_height_mm` SET TAGS ('dbx_business_glossary_term' = 'Component Height Millimeters (MM)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `component_length_mm` SET TAGS ('dbx_business_glossary_term' = 'Component Length Millimeters (MM)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `component_origin` SET TAGS ('dbx_business_glossary_term' = 'Component Origin');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `component_origin` SET TAGS ('dbx_value_regex' = 'make|buy|make_or_buy|subcontract');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `component_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Component Weight Kilograms (KG)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `component_width_mm` SET TAGS ('dbx_business_glossary_term' = 'Component Width Millimeters (MM)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `cost_relevance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost Relevance Indicator');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `critical_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Component Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `ecn_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Notice (ECN) Number');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `fixed_quantity_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fixed Quantity Indicator');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `installation_point` SET TAGS ('dbx_business_glossary_term' = 'Installation Point');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'BOM Item Category');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `lead_time_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Offset Days');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Number');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Notes');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `operation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Operation Sequence Number');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `product_bom_line_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Line Status');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `product_bom_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|obsolete|blocked|released');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `quantity_per_assembly` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Assembly');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'Revision Level');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `scrap_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Scrap Factor Percentage');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `spare_part_indicator` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Indicator');
ALTER TABLE `manufacturing_ecm`.`product`.`product_bom_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` SET TAGS ('dbx_subdomain' = 'assembly_structure');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `product_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Product Revision ID');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `ecn_id` SET TAGS ('dbx_business_glossary_term' = 'Ecn Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `superseded_revision_product_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Revision ID');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected|conditional');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `bom_affected_flag` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Affected Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `change_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Change Impact Level');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `change_impact_level` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'design_improvement|cost_reduction|quality_issue|regulatory_compliance|supplier_change|customer_request');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `drawing_affected_flag` SET TAGS ('dbx_business_glossary_term' = 'Drawing Affected Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `effectivity_date` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `effectivity_serial_end` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Serial Number End');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `effectivity_serial_start` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Serial Number Start');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `effectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Effectivity Type');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `effectivity_type` SET TAGS ('dbx_value_regex' = 'date|serial_number|lot_batch|immediate');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `interchangeability_code` SET TAGS ('dbx_business_glossary_term' = 'Interchangeability Code');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `interchangeability_code` SET TAGS ('dbx_value_regex' = 'fully_interchangeable|forward_compatible|not_interchangeable');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revision Notes');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `obsolete_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `ppap_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Required Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `process_affected_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Affected Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `revision_code` SET TAGS ('dbx_business_glossary_term' = 'Revision Code');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `revision_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `revision_description` SET TAGS ('dbx_business_glossary_term' = 'Revision Description');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `revision_status` SET TAGS ('dbx_business_glossary_term' = 'Revision Status');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `revision_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|released|obsolete|superseded');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `specification_affected_flag` SET TAGS ('dbx_business_glossary_term' = 'Specification Affected Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `testing_affected_flag` SET TAGS ('dbx_business_glossary_term' = 'Testing Affected Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`product_revision` ALTER COLUMN `tooling_affected_flag` SET TAGS ('dbx_business_glossary_term' = 'Tooling Affected Flag');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification ID');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `product_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Product Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `altitude_rating_meters` SET TAGS ('dbx_business_glossary_term' = 'Altitude Rating (Meters)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `application_suitability` SET TAGS ('dbx_business_glossary_term' = 'Application Suitability');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `color_finish` SET TAGS ('dbx_business_glossary_term' = 'Color and Finish');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Connection Type');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `current_rating_amperes` SET TAGS ('dbx_business_glossary_term' = 'Current Rating (Amperes)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `datasheet_reference` SET TAGS ('dbx_business_glossary_term' = 'Datasheet Reference');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `dimensions_height_mm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions Height (Millimeters)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `dimensions_length_mm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions Length (Millimeters)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `dimensions_width_mm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions Width (Millimeters)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `frequency_rating_hz` SET TAGS ('dbx_business_glossary_term' = 'Frequency Rating (Hz)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `humidity_rating_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Rating (Percent)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `installation_manual_reference` SET TAGS ('dbx_business_glossary_term' = 'Installation Manual Reference');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `ip_rating` SET TAGS ('dbx_business_glossary_term' = 'Ingress Protection (IP) Rating');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `ip_rating` SET TAGS ('dbx_value_regex' = '^IP[0-9]{2}[A-Z]?$');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `mounting_type` SET TAGS ('dbx_business_glossary_term' = 'Mounting Type');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `mounting_type` SET TAGS ('dbx_value_regex' = 'din_rail|panel_mount|wall_mount|floor_mount|rack_mount|embedded');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `nema_rating` SET TAGS ('dbx_business_glossary_term' = 'National Electrical Manufacturers Association (NEMA) Rating');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `nema_rating` SET TAGS ('dbx_value_regex' = '^NEMA[0-9]{1,2}[A-Z]?$');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `operating_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Maximum (Celsius)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `operating_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Minimum (Celsius)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `performance_parameter` SET TAGS ('dbx_business_glossary_term' = 'Performance Parameter');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `power_rating_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Rating (Watts)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `safety_data_sheet_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `shock_resistance` SET TAGS ('dbx_business_glossary_term' = 'Shock Resistance');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'teamcenter_plm|sap_s4hana|manual_entry');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `specification_description` SET TAGS ('dbx_business_glossary_term' = 'Specification Description');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `specification_name` SET TAGS ('dbx_business_glossary_term' = 'Specification Name');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_value_regex' = '^SPEC-[A-Z0-9]{8,12}$');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|obsolete|superseded');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_value_regex' = 'technical|commercial|combined|performance|safety|environmental');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Maximum (Celsius)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Minimum (Celsius)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `vibration_resistance` SET TAGS ('dbx_business_glossary_term' = 'Vibration Resistance');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `voltage_rating` SET TAGS ('dbx_business_glossary_term' = 'Voltage Rating');
ALTER TABLE `manufacturing_ecm`.`product`.`product_specification` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `product_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Certification Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `quality_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Audit Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `applicable_markets` SET TAGS ('dbx_business_glossary_term' = 'Applicable Markets');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Audit Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Uniform Resource Locator (URL)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'Active|Expired|Pending Renewal|Suspended|Revoked|Under Review');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost Amount');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `cybersecurity_certification` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Certification');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `declaration_of_conformity_number` SET TAGS ('dbx_business_glossary_term' = 'Declaration of Conformity (DoC) Number');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `eccn_code` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Effective Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `energy_efficiency_rating` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency Rating');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `environmental_certification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `functional_safety_certification` SET TAGS ('dbx_business_glossary_term' = 'Functional Safety Certification');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `is_customer_facing` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Facing Certification');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `mandatory_for_markets` SET TAGS ('dbx_business_glossary_term' = 'Mandatory for Markets');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Certification Audit Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `quality_certification` SET TAGS ('dbx_business_glossary_term' = 'Quality Management Certification');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration, Evaluation, Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Certification Remarks');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Renewal Date');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Test Report Number');
ALTER TABLE `manufacturing_ecm`.`product`.`product_certification` ALTER COLUMN `weee_compliant` SET TAGS ('dbx_business_glossary_term' = 'Waste Electrical and Electronic Equipment (WEEE) Compliant');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` SET TAGS ('dbx_subdomain' = 'assembly_structure');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `plant_data_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Data Identifier');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `availability_check_group` SET TAGS ('dbx_business_glossary_term' = 'Availability Check Group');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `availability_check_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `backflush_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backflush Indicator');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `batch_management_required` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Required');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `cycle_counting_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cycle Counting Indicator');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `cycle_counting_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1}$');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `effective_out_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Out Date');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `fixed_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Fixed Lot Size');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `gr_processing_time_days` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Processing Time (Days)');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `in_house_production_time_days` SET TAGS ('dbx_business_glossary_term' = 'In-House Production Time (Days)');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `inspection_setup_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Setup Required');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `issue_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Issue Storage Location');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `issue_storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `lot_size_procedure` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Procedure');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `lot_size_procedure` SET TAGS ('dbx_value_regex' = 'EX|HB|FX|WB|PK|LS');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `maximum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lot Size');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `minimum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life (Days)');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `negative_stock_allowed` SET TAGS ('dbx_business_glossary_term' = 'Negative Stock Allowed');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time (Days)');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `plant_status` SET TAGS ('dbx_business_glossary_term' = 'Plant Status');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `plant_status` SET TAGS ('dbx_value_regex' = 'active|blocked|discontinued|phase_out|new_product_introduction');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'E|F|X');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `production_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Production Storage Location');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `production_storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `quality_inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Type');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `rounding_value` SET TAGS ('dbx_business_glossary_term' = 'Rounding Value');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `scheduling_margin_key` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Margin Key');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `scheduling_margin_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `serialization_level` SET TAGS ('dbx_business_glossary_term' = 'Serialization Level');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `serialization_level` SET TAGS ('dbx_value_regex' = '0|1|2|3|4');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `shelf_life_expiration_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiration (Days)');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `special_procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Special Procurement Type');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `manufacturing_ecm`.`product`.`plant_data` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
