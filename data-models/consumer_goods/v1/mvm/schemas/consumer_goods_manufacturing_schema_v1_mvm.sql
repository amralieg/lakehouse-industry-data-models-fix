-- Schema for Domain: manufacturing | Business: Consumer Goods | Version: v1_mvm
-- Generated on: 2026-05-05 11:04:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `consumer_goods_ecm`.`manufacturing` COMMENT 'Owns production planning, scheduling, and execution across manufacturing facilities. Manages production orders, batch records, work orders, MES integration (Siemens Opcenter), line performance (OEE), yield tracking, MRP runs, GMP compliance events, changeover management, and shop floor data collection aligned with ISO 22716 standards.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` (
    `manufacturing_facility_id` BIGINT COMMENT 'Unique identifier for the manufacturing facility. Primary key. Role: MASTER_RESOURCE.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Every manufacturing plant is assigned to a legal entity (company code) for statutory financial reporting, intercompany billing, and P&L allocation. In SAP-based consumer goods ERP, plant-to-company-co',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Facility compliance reporting must reference the jurisdiction governing its operations for regulatory filings and audit purposes.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Required for Supply Network Planning report to map each plant to its network node, enabling ATP, capacity, and logistics calculations; domain experts expect this mapping.',
    `address_line_1` STRING COMMENT 'Primary street address line for the manufacturing facility location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or additional location details. Organizational contact data classified as confidential.',
    `city` STRING COMMENT 'City or municipality where the manufacturing facility is located.',
    `commissioning_date` DATE COMMENT 'Date when the facility was officially commissioned and began production operations.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the manufacturing facility is located (e.g., USA, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the manufacturing facility record was first created in the system.',
    `email_address` STRING COMMENT 'Primary email contact for the manufacturing facility operations team. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `energy_consumption_kwh_per_year` DECIMAL(18,2) COMMENT 'Annual energy consumption of the facility measured in kilowatt-hours, used for sustainability reporting and cost management.',
    `epa_site_number` STRING COMMENT 'EPA facility identifier for environmental compliance tracking and reporting under EPA regulations.',
    `erp_plant_code` STRING COMMENT 'Plant identifier in the SAP S/4HANA ERP system used for integration with MM, PP, SD, and WM modules.',
    `facility_name` STRING COMMENT 'Official business name of the manufacturing facility or plant site.',
    `facility_type` STRING COMMENT 'Classification of the manufacturing facility based on primary production function: mixing (formulation), filling (liquid/semi-solid), packaging (secondary), co-manufacturing (third-party), integrated (end-to-end), or contract (toll manufacturing).. Valid values are `mixing|filling|packaging|co-manufacturing|integrated|contract`',
    `fda_establishment_number` STRING COMMENT 'FDA-issued establishment identifier for facilities manufacturing FDA-regulated products (cosmetics, OTC drugs, food). Required for US market distribution.. Valid values are `^[0-9]{7,10}$`',
    `gmp_certification_date` DATE COMMENT 'Date when the facility received its current GMP certification.',
    `gmp_certified` BOOLEAN COMMENT 'Indicates whether the facility holds current Good Manufacturing Practice certification required for consumer goods production.',
    `gmp_expiration_date` DATE COMMENT 'Date when the current GMP certification expires and requires renewal.',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the facility holds ISO 14001 Environmental Management System certification.',
    `iso_22716_compliance_tier` STRING COMMENT 'Internal classification of the facilitys compliance level with ISO 22716 cosmetics GMP standards: tier_1 (full compliance), tier_2 (partial compliance), tier_3 (basic compliance), non_compliant.. Valid values are `tier_1|tier_2|tier_3|non_compliant`',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the facility holds ISO 9001 Quality Management System certification.',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality or compliance audit conducted at the facility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the manufacturing facility record was last updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the facility location in decimal degrees for mapping and logistics optimization.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the facility location in decimal degrees for mapping and logistics optimization.',
    `mes_system_integrated` BOOLEAN COMMENT 'Indicates whether the facility is integrated with Siemens Opcenter MES for real-time production tracking and shop floor data collection.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next quality or compliance audit at the facility.',
    `number_of_production_lines` STRING COMMENT 'Total count of active production lines within the facility available for manufacturing operations.',
    `operational_status` STRING COMMENT 'Current operational state of the manufacturing facility in its lifecycle.. Valid values are `active|inactive|maintenance|startup|decommissioned|seasonal`',
    `osha_establishment_number` STRING COMMENT 'OSHA establishment identifier for workplace safety reporting and compliance tracking.',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the facility: owned (company-owned), leased (long-term lease), contract (third-party operated), joint_venture (shared ownership).. Valid values are `owned|leased|contract|joint_venture`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the manufacturing facility. Organizational contact data classified as confidential.',
    `plant_code` STRING COMMENT 'Unique business identifier for the manufacturing plant used across SAP S/4HANA PP module and operational systems. Typically 4-10 alphanumeric characters.. Valid values are `^[A-Z0-9]{4,10}$`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the facility address. Organizational contact data classified as confidential.',
    `primary_product_category` STRING COMMENT 'Main product category or line manufactured at this facility (e.g., skincare, haircare, household cleaning, personal care).',
    `production_capacity_units_per_day` DECIMAL(18,2) COMMENT 'Maximum daily production capacity of the facility measured in finished goods units per day under normal operating conditions.',
    `shift_pattern` STRING COMMENT 'Standard operating shift pattern for the facility: single (8 hours), two_shift (16 hours), three_shift (24 hours), continuous (24/7), flexible (variable).. Valid values are `single|two_shift|three_shift|continuous|flexible`',
    `square_footage` DECIMAL(18,2) COMMENT 'Total floor area of the manufacturing facility in square feet, including production, warehouse, and administrative spaces.',
    `state_province` STRING COMMENT 'State, province, or regional administrative division where the facility is located.',
    `sustainability_rating` STRING COMMENT 'Internal sustainability performance rating for the facility based on environmental impact, energy efficiency, waste reduction, and sustainable sourcing practices.. Valid values are `platinum|gold|silver|bronze|not_rated`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the facility location (e.g., America/New_York, Europe/Berlin) used for production scheduling and shift planning.',
    `water_consumption_cubic_meters_per_year` DECIMAL(18,2) COMMENT 'Annual water consumption of the facility measured in cubic meters, tracked for environmental compliance and sustainability reporting.',
    `workforce_headcount` STRING COMMENT 'Total number of employees (full-time equivalent) assigned to the manufacturing facility.',
    CONSTRAINT pk_manufacturing_facility PRIMARY KEY(`manufacturing_facility_id`)
) COMMENT 'Master record for each manufacturing facility (plant/site) in the Consumer Goods network. Captures plant code, site name, address, GMP certification status, ISO 22716 compliance tier, production capacity (units/day), facility type (mixing, filling, packaging, co-manufacturing), regulatory registration numbers (FDA establishment ID, EPA site ID), and operational status. SSOT for all plant-level master data referenced by production orders, batch records, and OEE metrics.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` (
    `production_line_id` BIGINT COMMENT 'Unique identifier for the production line. Primary key for the production line master record.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Line qualification and capacity planning by product category: consumer goods manufacturers dedicate lines to categories (liquid personal care, powder home care). Linking production_line to category en',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Production lines are capitalized fixed assets. Linking to fixed_asset enables depreciation scheduling, net book value reporting, and capex project tracking for line investments — standard asset manage',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: GMP compliance requires each production line to operate under an approved inspection plan defining in-process quality checks. Consumer goods manufacturers link lines to inspection plans for line clear',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Production line belongs to a specific manufacturing facility; replace generic facility reference with direct link to manufacturing_facility.',
    `allergen_handling_flag` BOOLEAN COMMENT 'Indicates whether this production line handles products containing allergens. Critical for cross-contamination prevention and regulatory compliance.',
    `allergen_types` STRING COMMENT 'Comma-separated list of allergen types handled on this line (e.g., nuts, dairy, gluten). Used for allergen management and cleaning validation protocols.',
    `asset_tag_number` STRING COMMENT 'Physical asset tag number assigned to the production line for asset management and tracking purposes. Links to the fixed asset register in the ERP system.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `automation_level` STRING COMMENT 'Degree of automation on the production line. Indicates the level of human intervention required and impacts labor planning and quality consistency.. Valid values are `manual|semi_automated|fully_automated|lights_out`',
    `changeover_time_standard_minutes` DECIMAL(18,2) COMMENT 'Standard time in minutes required to change over the production line from one product or batch to another. Used for production scheduling and OEE loss calculation.',
    `cleaning_validation_protocol` STRING COMMENT 'Reference to the cleaning validation protocol document applicable to this production line. Ensures GMP compliance and prevents cross-contamination.',
    `commissioning_date` DATE COMMENT 'Date when the production line was commissioned and became operational. Used for asset lifecycle tracking and depreciation calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production line record was first created in the system. Used for data lineage and audit trail purposes.',
    `crew_size_standard` STRING COMMENT 'Standard number of operators required to run the production line at full capacity. Used for labor planning and cost allocation.',
    `design_speed_units_per_hour` DECIMAL(18,2) COMMENT 'Theoretical maximum production capacity of the line measured in units per hour under ideal conditions. Used for capacity planning and scheduling.',
    `energy_consumption_kwh_per_unit` DECIMAL(18,2) COMMENT 'Average energy consumption per unit produced on this line, measured in kilowatt-hours. Key metric for sustainability reporting and cost analysis.',
    `environmental_control_required` BOOLEAN COMMENT 'Indicates whether the production line requires controlled environmental conditions such as temperature, humidity, or air quality. Critical for GMP compliance and product quality.',
    `gmp_classification` STRING COMMENT 'GMP classification level of the production line indicating the quality and cleanliness standards required for products manufactured on this line. Critical for regulatory compliance and product safety.. Valid values are `gmp_a|gmp_b|gmp_c|gmp_d|non_gmp`',
    `humidity_range_percent` STRING COMMENT 'Acceptable relative humidity range for the production line as a percentage. Format: min-max (e.g., 40-60). Used for environmental monitoring and compliance.',
    `installed_power_kw` DECIMAL(18,2) COMMENT 'Total installed electrical power capacity of the production line in kilowatts. Used for energy consumption tracking and sustainability reporting.',
    `last_major_overhaul_date` DATE COMMENT 'Date of the most recent major overhaul or refurbishment of the production line. Used for maintenance planning and asset condition assessment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production line record was last updated. Used for change tracking and data quality monitoring.',
    `line_code` STRING COMMENT 'Business identifier code for the production line. Unique within the facility and used for operational reference in MES systems and production scheduling.. Valid values are `^[A-Z0-9]{3,12}$`',
    `line_length_meters` DECIMAL(18,2) COMMENT 'Physical length of the production line in meters. Used for facility layout planning and material flow analysis.',
    `line_name` STRING COMMENT 'Human-readable name of the production line. Used for display in dashboards, reports, and operator interfaces.',
    `line_type` STRING COMMENT 'Classification of the production line based on its primary manufacturing function. Determines the type of operations and products that can be processed on this line.. Valid values are `filling|blending|packaging|assembly|labeling|palletizing`',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'Average time in hours between equipment failures on this production line. Key reliability metric used for maintenance optimization and capacity planning.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Average time in hours required to repair and restore the production line to operational status after a failure. Used for downtime analysis and maintenance resource planning.',
    `mes_asset_tag` STRING COMMENT 'Unique asset identifier for this production line in the Siemens Opcenter MES system. Used for real-time data collection, production tracking, and integration with shop floor systems.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `modified_by_user` STRING COMMENT 'User identifier of the person who last modified this production line record. Used for audit trail and accountability.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance activity for this production line. Used for maintenance scheduling and production planning coordination.',
    `nominal_oee_target_percent` DECIMAL(18,2) COMMENT 'Target OEE percentage for this production line. OEE is calculated as Availability × Performance × Quality and represents the benchmark for line performance evaluation.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or operational considerations specific to this production line.',
    `operational_status` STRING COMMENT 'Current operational status of the production line. Indicates whether the line is available for production scheduling and execution.. Valid values are `active|inactive|maintenance|decommissioned|startup|idle`',
    `plc_system_type` STRING COMMENT 'Type and model of the PLC system controlling the production line. Used for technical support, integration planning, and system upgrade management.',
    `quality_inspection_frequency` STRING COMMENT 'Standard frequency for quality control inspections on this production line. Defines the QC sampling plan and compliance with GMP requirements.. Valid values are `continuous|hourly|per_batch|per_shift|daily`',
    `record_source_system` STRING COMMENT 'Source system from which this production line record originated (e.g., SAP S/4HANA PP, Siemens Opcenter MES). Used for data lineage and integration troubleshooting.',
    `scada_integration_enabled` BOOLEAN COMMENT 'Indicates whether the production line is integrated with the SCADA system for real-time monitoring and control. Enables remote visibility and data collection.',
    `scrap_rate_target_percent` DECIMAL(18,2) COMMENT 'Target scrap rate percentage for this production line. Used for quality performance benchmarking and waste reduction initiatives.',
    `shift_pattern` STRING COMMENT 'Standard operating shift pattern for this production line. Defines the daily operating schedule and impacts capacity calculations.. Valid values are `single_shift|two_shift|three_shift|continuous|custom`',
    `temperature_range_celsius` STRING COMMENT 'Acceptable operating temperature range for the production line in Celsius. Format: min-max (e.g., 18-25). Used for environmental monitoring and compliance.',
    CONSTRAINT pk_production_line PRIMARY KEY(`production_line_id`)
) COMMENT 'Master record for each physical production line within a manufacturing facility. Captures line code, line name, facility reference, line type (filling, blending, packaging, assembly), design speed (units/hour), nominal OEE target, GMP classification, MES asset tag (Siemens Opcenter), changeover time standard (minutes), and current operational status. Enables OEE benchmarking, scheduling capacity allocation, and MES integration at the line level.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` (
    `manufacturing_bom_id` BIGINT COMMENT 'Unique identifier for the bill of materials record. Primary key for the manufacturing BOM entity.',
    `approved_supplier_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_supplier_list. Business justification: GMP and quality regulations in consumer goods require BOM components to be sourced only from approved suppliers. Linking manufacturing_bom to approved_supplier_list enables compliance validation at BO',
    `contract_line_id` BIGINT COMMENT 'Foreign key linking to procurement.contract_line. Business justification: BOM components are sourced under specific contract lines that define unit price, quality specification, and lead time. In consumer goods, sourcing teams map BOM components to contract lines for standa',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_brand. Business justification: In consumer goods, brand teams govern BOM ingredient standards, sustainability certifications, and claim compliance per brand (e.g., free-from or natural brand promises). Brand-level BOM governanc',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: BOM component-to-material master traceability: manufacturing BOM components are materials (raw/packaging). Consumer goods manufacturers link BOM lines to the material master for procurement, regulator',
    `sku_id` BIGINT COMMENT 'Reference to the finished good or semi-finished SKU that this BOM defines. Links to the product master for which this material structure applies.',
    `product_bom_id` BIGINT COMMENT 'Foreign key linking to product.product_bom. Business justification: PLM-to-ERP BOM synchronization: the manufacturing BOM is derived from the engineering BOM (product_bom). Consumer goods manufacturers reconcile these during ECO/change management and PLM handoff. A do',
    `restricted_substance_id` BIGINT COMMENT 'Foreign key linking to regulatory.restricted_substance. Business justification: BOM components must be screened against restricted substance lists (REACH, Prop 65, FDA prohibited ingredients) during BOM approval. Linking manufacturing_bom to restricted_substance enables automated',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Incoming material quality control requires each BOM component to reference its quality specification (limits, test methods). Consumer goods manufacturers enforce this link for supplier qualification, ',
    `supplier_id` BIGINT COMMENT 'Reference to the preferred or sole-source supplier for this component. Used for procurement planning, supplier performance tracking, and supply chain risk management. Nullable if multiple suppliers are available.',
    `allergen_flag` BOOLEAN COMMENT 'Indicates whether this component contains or may contain allergens as defined by FDA and EU REACH regulations. True if allergen present. Used for product labeling, consumer safety warnings, and regulatory compliance.',
    `alternative_item_group` STRING COMMENT 'Identifier for a group of interchangeable components that can substitute for each other in production. Used for supply chain flexibility, multi-sourcing strategies, and material availability optimization.',
    `alternative_item_priority` STRING COMMENT 'The selection priority for this component within its alternative item group. Lower numbers indicate higher priority. Used by MRP to determine preferred material selection when multiple alternatives are available.',
    `approval_date` DATE COMMENT 'The date when this BOM version was formally approved for production use. Establishes the official release date for regulatory compliance and change control purposes.',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved this BOM version for production use. Required for GMP compliance and quality assurance. Typically a product development manager, quality manager, or regulatory affairs specialist.',
    `backflush_indicator` BOOLEAN COMMENT 'Indicates whether this component is automatically consumed (backflushed) when the finished good is confirmed in the MES system, rather than requiring explicit material issue transactions. True if backflushed. Common for high-volume, low-value components.',
    `base_quantity` DECIMAL(18,2) COMMENT 'The reference quantity of the finished good for which the component quantities are defined. Typically 1 unit, 100 units, or 1 batch. All component quantities are expressed per this base quantity.',
    `base_unit_of_measure` STRING COMMENT 'The unit of measure for the base quantity (e.g., EA for each, KG for kilogram, L for liter, BOX for box). Must align with the SKU primary UOM.',
    `bom_number` STRING COMMENT 'The externally-known unique business identifier for this BOM, typically assigned by the PLM or ERP system. Used for cross-system reference and production order material requirements.',
    `bom_status` STRING COMMENT 'Current lifecycle status of the BOM. Active BOMs are used for production planning and MRP runs. Inactive or obsolete BOMs are retained for historical reference and regulatory traceability.. Valid values are `active|inactive|pending|obsolete|under_review`',
    `bom_type` STRING COMMENT 'Classification of the BOM structure. Production BOM is used for standard manufacturing, co-product for joint production scenarios, phantom for intermediate assemblies not stocked, engineering for R&D prototypes, and planning for demand forecasting.. Valid values are `production|co-product|phantom|engineering|planning`',
    `component_effective_end_date` DATE COMMENT 'The date after which this specific component is no longer valid within the BOM structure. Nullable for open-ended components. Used for material phase-out and supplier transition management.',
    `component_effective_start_date` DATE COMMENT 'The date from which this specific component becomes valid within the BOM structure. Supports phased material transitions, supplier changes, and cost optimization initiatives.',
    `component_item_category` STRING COMMENT 'Classification of the component type. Stock items are inventory-managed materials, non-stock are direct procurement items, phantom are intermediate assemblies not physically stocked, text items are instructions, and variable size items have flexible dimensions.. Valid values are `stock|non-stock|phantom|text|variable_size`',
    `component_quantity` DECIMAL(18,2) COMMENT 'The quantity of this component required to produce the base quantity of the finished good. Used for MRP explosion, production order material requirements, and COGS calculation.',
    `component_unit_of_measure` STRING COMMENT 'The unit of measure for the component quantity (e.g., KG for raw materials, EA for packaging units, L for liquids). Must align with the component material master UOM.',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of total product cost attributed to this component. Used for COGS calculation, profitability analysis, and cost optimization initiatives. Sum of all component cost allocations should equal 100% for the BOM.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM record was first created in the system. Used for audit trail, change tracking, and regulatory compliance documentation per ISO 9001 requirements.',
    `critical_component_flag` BOOLEAN COMMENT 'Indicates whether this component is critical for product quality, safety, or regulatory compliance. True if critical. Triggers enhanced quality control, supplier qualification requirements, and inventory safety stock policies.',
    `effective_end_date` DATE COMMENT 'The date after which this BOM version is no longer valid for new production orders. Nullable for open-ended BOMs. Used for phase-out management and regulatory compliance transitions.',
    `effective_start_date` DATE COMMENT 'The date from which this BOM version becomes valid for production planning and MRP explosion. Supports planned material transitions and new product launches.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether this component is classified as a hazardous material requiring special handling, storage, and disposal per OSHA and EPA regulations. True if hazardous. Triggers safety data sheet requirements and GMP compliance protocols.',
    `inci_name` STRING COMMENT 'The standardized INCI name for cosmetic ingredients as required by FDA and EU regulations. Used for product labeling, regulatory submissions, and consumer transparency. Mandatory for personal care and cosmetic products.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM record was last updated. Tracks formulation changes, component substitutions, and regulatory updates. Critical for change control and GMP compliance.',
    `lead_time_days` STRING COMMENT 'The procurement or production lead time for this component in days. Used for MRP scheduling, production order release timing, and inventory planning. Includes supplier lead time plus internal processing time.',
    `lot_size_requirement` STRING COMMENT 'Defines the lot sizing rule for this component in production orders. Exact requires precise quantity, minimum allows overages, multiple requires quantities in specific increments, none has no restriction. Impacts material planning and waste management.. Valid values are `exact|minimum|multiple|none`',
    `minimum_lot_size` DECIMAL(18,2) COMMENT 'The minimum quantity that must be procured or produced for this component. Driven by supplier MOQ, production batch constraints, or economic order quantity calculations. Nullable if no minimum applies.',
    `plm_system_reference` STRING COMMENT 'External reference identifier linking this BOM to the source PLM system record. Enables traceability to engineering change orders, formulation documents, and R&D specifications.',
    `regulatory_compliance_notes` STRING COMMENT 'Free-text field capturing regulatory compliance requirements, restrictions, or special handling instructions for this component. Includes FDA registration numbers, EU REACH compliance status, GMP requirements, and safety data sheet references.',
    `scrap_factor_percentage` DECIMAL(18,2) COMMENT 'The expected waste or loss percentage for this component during production. Used to adjust gross material requirements in MRP runs. Typical values range from 0% to 10% depending on material type and process complexity.',
    `sustainability_certification` STRING COMMENT 'Certification or standard that this component meets for sustainable sourcing (e.g., FSC for paper, RSPO for palm oil, Fair Trade, Organic). Used for corporate sustainability reporting and consumer transparency initiatives.',
    `version` STRING COMMENT 'Version identifier for the BOM structure. Incremented when material composition changes due to reformulation, cost optimization, or regulatory compliance updates. Supports change control and audit trail.',
    CONSTRAINT pk_manufacturing_bom PRIMARY KEY(`manufacturing_bom_id`)
) COMMENT 'Bill of Materials master record (header + component lines) defining the complete material structure for each finished good or semi-finished SKU. Header captures BOM number, BOM type (production, co-product, phantom), base quantity, unit of measure, validity dates, PLM system reference, and BOM status. Component lines capture item number, material reference (raw material, packaging, semi-finished), component quantity per base quantity, scrap factor percentage, item category (stock, non-stock, phantom), INCI name for cosmetic ingredients, allergen flag, hazardous material flag, and component validity dates. SSOT for MRP explosion, production order material requirements, COGS calculation, and regulatory ingredient disclosure per FDA/EU REACH. This is the single authoritative source for all BOM component data — no separate component entity exists.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`manufacturing`.`routing` (
    `routing_id` BIGINT COMMENT 'Unique identifier for the production routing master record. Primary key.',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: In-process quality control (IPC) in consumer goods manufacturing ties each routing to an inspection plan defining checkpoints per operation. routing.ipc_checkpoint_count is a denormalization signal. G',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: routing.plant_code is a denormalized STRING reference to the manufacturing facility where this routing is valid. Adding manufacturing_facility_id as a proper FK normalizes this relationship, enabling ',
    `product_bom_id` BIGINT COMMENT 'Reference to the Bill of Materials (BOM) that defines the raw materials and components consumed by this routing. Links routing to material requirements.',
    `sku_id` BIGINT COMMENT 'Reference to the finished or semi-finished SKU that this routing defines the manufacturing process for.',
    `approval_status` STRING COMMENT 'Approval status of the routing for production use. Approved routings are validated and authorized; pending routings await review; rejected routings require rework.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this routing was approved for production use. Supports audit trail and compliance requirements.',
    `base_quantity` DECIMAL(18,2) COMMENT 'Standard production lot size for which the routing operation times and resource requirements are defined. Used as the basis for scaling production schedules.',
    `base_unit_of_measure` STRING COMMENT 'Unit of measure for the base quantity (e.g., KG, L, EA, M). Aligns with GS1 unit codes.. Valid values are `^[A-Z]{2,5}$`',
    `changeover_time_minutes` DECIMAL(18,2) COMMENT 'Time required to transition production lines from the previous product to this routing. Critical for production scheduling and minimizing downtime.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the standard cost amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this routing record was first created in the system. Supports audit trail and data lineage.',
    `expected_scrap_percentage` DECIMAL(18,2) COMMENT 'Overall expected scrap percentage for the routing, representing anticipated waste or defects. Used for material planning and cost estimation.',
    `expected_yield_percentage` DECIMAL(18,2) COMMENT 'Overall expected yield percentage for the routing, representing the ratio of good output to total input. Used for production planning and variance analysis.',
    `gmp_critical_flag` BOOLEAN COMMENT 'Indicates whether this routing includes GMP-critical operations requiring enhanced documentation, validation, and compliance controls per ISO 22716 and FDA regulations.',
    `ipc_checkpoint_count` STRING COMMENT 'Number of in-process control checkpoints defined in this routing. IPC checkpoints are quality inspection points during production per ISO 22716 and GMP requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this routing record was last modified. Supports audit trail and change tracking.',
    `lot_size_restriction` STRING COMMENT 'Constraint on production lot sizes for this routing. Fixed requires exact base quantity; minimum/maximum define bounds; multiple requires lot sizes to be multiples of base quantity; none allows any lot size.. Valid values are `none|fixed|minimum|maximum|multiple`',
    `maximum_lot_size` DECIMAL(18,2) COMMENT 'Maximum production lot size allowed for this routing. Nullable if no maximum constraint exists.',
    `minimum_lot_size` DECIMAL(18,2) COMMENT 'Minimum production lot size allowed for this routing. Nullable if no minimum constraint exists.',
    `operation_sequence` STRING COMMENT 'JSON array or delimited string capturing the complete sequence of operation steps. Each operation includes: operation_number, work_center_code, operation_description, control_key (internal_processing|external_processing|milestone), setup_time_minutes, machine_time_minutes, labor_time_minutes, yield_quantity, scrap_percentage, gmp_critical_step_flag, ipc_checkpoint_flag. This is the single authoritative source for all routing operation data — no separate operation entity exists.',
    `production_scheduler_code` STRING COMMENT 'Code identifying the production scheduling strategy or algorithm used for this routing (e.g., forward scheduling, backward scheduling, finite capacity).. Valid values are `^[A-Z0-9]{4,10}$`',
    `routing_description` STRING COMMENT 'Detailed textual description of the routing, including its purpose, scope, and any special instructions for production planners and shop floor operators.',
    `routing_number` STRING COMMENT 'Business identifier for the routing. Externally-known unique code used in production planning and scheduling systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `routing_status` STRING COMMENT 'Current lifecycle status of the routing. Active routings are available for production scheduling; draft routings are under development; inactive routings are temporarily disabled; obsolete routings are retired; under_review routings are pending approval.. Valid values are `draft|active|inactive|obsolete|under_review`',
    `routing_type` STRING COMMENT 'Classification of the routing defining its usage pattern. Standard routings are default production paths; reference routings are templates; rate routings define production rates; alternative routings provide backup paths; special routings are for one-time or custom production runs.. Valid values are `standard|reference|rate|alternative|special`',
    `standard_cost_amount` DECIMAL(18,2) COMMENT 'Standard production cost per base quantity for this routing, including labor, machine, and overhead costs. Used for cost accounting and variance analysis.',
    `total_labor_time_minutes` DECIMAL(18,2) COMMENT 'Cumulative labor time across all operations in the routing, used for workforce planning and standard cost calculation.',
    `total_machine_time_minutes` DECIMAL(18,2) COMMENT 'Cumulative machine processing time across all operations in the routing, used for capacity planning and Overall Equipment Effectiveness (OEE) calculations.',
    `total_setup_time_minutes` DECIMAL(18,2) COMMENT 'Cumulative setup time across all operations in the routing, used for capacity planning and scheduling.',
    `total_standard_lead_time_hours` DECIMAL(18,2) COMMENT 'Total cumulative lead time in hours required to complete all operations in this routing, including setup, processing, and queue times. Used for Material Requirements Planning (MRP) and capacity planning.',
    `valid_from_date` DATE COMMENT 'Date from which this routing becomes effective and available for production scheduling.',
    `valid_to_date` DATE COMMENT 'Date until which this routing remains effective. Nullable for open-ended routings.',
    `version` STRING COMMENT 'Version identifier for the routing, enabling tracking of routing changes over time. Supports engineering change management and audit trails.. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Production routing master (header + operation steps) defining the complete manufacturing process sequence for a finished or semi-finished SKU. Header captures routing number, routing type (standard, reference, rate), base quantity, plant, validity dates, and total standard lead time. Operation steps capture operation number, work center assignment, standard values (setup time, machine time, labor time), control key (internal processing, external processing, milestone), yield quantity, scrap percentage, GMP critical step flag, and IPC checkpoint flag. SSOT for production scheduling, capacity planning, standard cost calculation, and GMP batch record generation per ISO 22716. This is the single authoritative source for all routing operation data — no separate operation entity exists. Aligned with SAP PP Routing master.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` (
    `production_order_id` BIGINT COMMENT 'Unique identifier for the production order. Primary key for the production order entity.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Production orders for regulated consumer goods (OTC, cosmetics under EU 1223/2009) must be executed under valid compliance obligations. Regulatory and supply chain teams verify open obligations before',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost accounting report requires each production order to be charged to a finance cost center for OPEX allocation.',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Production orders trigger an inspection plan; linking allows the order execution system to retrieve the exact inspection plan governing sampling and testing for that batch.',
    `manufacturing_bom_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_bom. Business justification: Production order consumes a specific manufacturing BOM; adding manufacturing_bom_id FK connects BOM to order and eliminates isolation of manufacturing_bom.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Production Planning Dashboard ties orders to brands to enable demand forecasting and coordinated marketing launch planning.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: Production orders are the execution output of supply plans. Linking production_order to the originating supply plan enables supply plan adherence reporting, capacity utilization variance analysis, and',
    `production_line_id` BIGINT COMMENT 'FK to manufacturing.production_line',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: Production order compliance reporting requires linking each order to the products registration record to verify GMP compliance and traceability.',
    `routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.routing. Business justification: Each production order follows a routing; adding routing_id FK links routing to order and eliminates isolation of routing.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Order fulfillment process requires linking each production order to the originating sales order to track manufacturing against sales commitments.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU being produced in this production order. Links to the product master data.',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Production orders are costed against standard costs for manufacturing variance analysis (actual vs. standard). This is a core cost accounting process in consumer goods — planned_cost on the order is d',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to customer.trade_account. Business justification: Required for Production Order to Customer Account linkage for OTIF SLA reporting and order fulfillment traceability.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Promotional Production Fulfillment Tracking: production orders are released to manufacture promotional volumes committed in trade promotions. Consumer goods planners and finance teams track promotiona',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred for the production order. Includes material, labor, and overhead costs. Used for variance analysis.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when production execution completed. Used for OEE calculation and performance analysis.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when production execution began on the shop floor. Captured from MES system.',
    `batch_number` STRING COMMENT 'Unique batch or lot number assigned to the production run. Critical for traceability and recall management per GMP requirements.. Valid values are `^[A-Z0-9]{8,20}$`',
    `changeover_time_minutes` STRING COMMENT 'Time in minutes required for line changeover before starting this production order. Used for scheduling and efficiency analysis.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Actual quantity produced and confirmed as good output. Represents yield after quality inspection.',
    `cost_object` STRING COMMENT 'Cost object (production order number or process order) used for collecting actual costs. Links to CO-PC product costing.. Valid values are `^[A-Z0-9]{12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the production order was created in the system. First event in order lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost amounts. Typically company code currency.. Valid values are `^[A-Z]{3}$`',
    `downtime_minutes` STRING COMMENT 'Total unplanned downtime in minutes during production execution. Impacts OEE availability component.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether this production order is subject to GMP compliance requirements per ISO 22716 standards. True for regulated products.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the production order record. Used for change tracking and audit compliance.',
    `material_number` STRING COMMENT 'SAP material number for the finished good being produced. Business identifier for the product in ERP system.. Valid values are `^[A-Z0-9]{8,18}$`',
    `mrp_controller` STRING COMMENT 'Three-character code identifying the MRP controller responsible for planning this material. Links to planner master data.. Valid values are `^[A-Z0-9]{3}$`',
    `notes` STRING COMMENT 'Free-text notes or comments related to the production order. Captures special instructions, issues, or observations from shop floor.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Overall Equipment Effectiveness percentage for this production run. Calculated as Availability × Performance × Quality. Industry standard KPI.',
    `order_number` STRING COMMENT 'Business identifier for the production order. Externally-known unique order number assigned by SAP S/4HANA PP system.. Valid values are `^[A-Z0-9]{10,12}$`',
    `order_quantity` DECIMAL(18,2) COMMENT 'Planned quantity to be produced in base unit of measure. Target output for the production order.',
    `order_status` STRING COMMENT 'Current lifecycle status of the production order. CRTD=Created, REL=Released, PCNF=Partially Confirmed, TECO=Technically Complete, CNF=Confirmed, DLV=Delivered, CLSD=Closed. [ENUM-REF-CANDIDATE: CRTD|REL|PCNF|TECO|CNF|DLV|CLSD — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of production order. PP01=Standard Production, PP03=Rework, PP05=Co-Product, PP10=Process Order, PP20=Batch Order.. Valid values are `PP01|PP03|PP05|PP10|PP20`',
    `planned_cost` DECIMAL(18,2) COMMENT 'Standard or planned cost for producing the order quantity. Calculated from BOM and routing costs.',
    `plant_code` STRING COMMENT 'Four-character code identifying the manufacturing facility where production occurs. Maps to SAP plant master.. Valid values are `^[A-Z0-9]{4}$`',
    `priority` STRING COMMENT 'Priority level for production scheduling. 1=Highest priority (rush/expedite), 5=Lowest priority (standard). Used for sequencing and resource allocation.. Valid values are `1|2|3|4|5`',
    `production_supervisor` STRING COMMENT 'Name of the production supervisor responsible for overseeing execution of this order on the shop floor.',
    `production_version` STRING COMMENT 'Production version defining the specific BOM and routing combination used. Enables multiple production methods for same material.. Valid values are `^[A-Z0-9]{4}$`',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether quality inspection is mandatory before goods receipt. Drives QM integration and inspection lot creation.',
    `released_by` STRING COMMENT 'User ID of the person who released the production order for execution. Audit trail for production authorization.',
    `released_timestamp` TIMESTAMP COMMENT 'Date and time when the production order was released for shop floor execution. Triggers material availability check and capacity reservation.',
    `scheduled_finish_date` DATE COMMENT 'Planned date when production is scheduled to complete. Used for capacity planning and delivery commitments.',
    `scheduled_start_date` DATE COMMENT 'Planned date when production is scheduled to begin. Set during production planning and MRP run.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of material scrapped or rejected during production. Used for yield analysis and cost accounting.',
    `settlement_rule` STRING COMMENT 'Rule for settling production order costs. FUL=Full settlement, PAR=Partial settlement, PER=Periodic settlement.. Valid values are `FUL|PAR|PER`',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for quantities. Standard ISO codes such as EA (each), KG (kilogram), L (liter), M (meter).. Valid values are `^[A-Z]{2,3}$`',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Actual yield percentage calculated as (confirmed_quantity / order_quantity) * 100. Key performance metric for production efficiency.',
    `created_by` STRING COMMENT 'User ID of the person who created the production order in the system. Audit trail for order origination.',
    CONSTRAINT pk_production_order PRIMARY KEY(`production_order_id`)
) COMMENT 'Core transactional record representing a manufacturing production order issued to produce a specific SKU quantity at a facility. Captures order number, order type (PP01 standard, PP03 rework), SKU reference, plant, production line, scheduled start/finish dates, actual start/finish dates, order quantity, confirmed quantity, scrap quantity, order status (created, released, partially confirmed, technically complete, closed), MRP controller, and cost object. SSOT for production execution tracking in SAP S/4HANA PP.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` (
    `batch_record_id` BIGINT COMMENT 'Unique identifier for the electronic batch manufacturing record (eBMR). Primary key for GMP-compliant batch traceability.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Batch cost roll‑up uses finance cost center to allocate raw material and labor expenses per batch.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Promotional Batch Traceability: promotional packs and limited-edition SKUs are produced in batches tied to specific promotion events. Quality, supply chain, and finance teams require batch-to-promotio',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.product_formulation. Business justification: GMP batch manufacturing record requirement: FDA 21 CFR Part 211 and ISO 22716 require batch records to reference the approved formulation version used. Consumer goods QA auditors and regulators expect',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Regulatory traceability: links each production batch to its inventory lot batch for recall investigations and quality audits.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Batch record should reference the specific manufacturing facility for traceability.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand Batch Traceability Report requires linking each batch to its brand for recall, quality and marketing performance analysis.',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_packaging_spec. Business justification: GMP batch record packaging traceability: consumer goods batch records must document the packaging specification version used during production for artwork compliance, label accuracy audits, and regula',
    `production_line_id` BIGINT COMMENT 'Reference to the specific production line used for this batch. Links to equipment master data.',
    `production_order_id` BIGINT COMMENT 'Reference to the production order that authorized this batch manufacturing run. Links to SAP PP production order master.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Batch‑to‑PO traceability is needed for audit, recall, and cost allocation linking each manufactured batch to its sourcing PO.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: GMP batch disposition requires confirming each batch was manufactured under a valid regulatory registration. Regulatory affairs teams run batch release reports filtered by registration status and expi',
    `routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.routing. Business justification: batch_record captures the complete GMP-compliant execution history of a production run. It stores routing_version (STRING) as a denormalized reference, but lacks a direct FK to the routing master. Add',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Batch traceability for recalls and quality investigations needs to associate each batch with the sales order that generated the demand.',
    `sku_id` BIGINT COMMENT 'Reference to the finished goods SKU produced in this batch. Links to product master data.',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Batch records capture actual vs. standard cost for batch cost variance reporting — a GMP and financial control requirement in consumer goods. standard_cost_amount on batch_record is denormalized from ',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual cost per unit incurred for this batch. Includes material, labor, and overhead variances.',
    `batch_number` STRING COMMENT 'Unique manufacturing batch identifier assigned at production initiation. Used for product traceability and recall management per GMP requirements.. Valid values are `^[A-Z0-9]{8,20}$`',
    `batch_size_actual` DECIMAL(18,2) COMMENT 'Actual production quantity achieved for this batch. Used for yield calculation and inventory reconciliation.',
    `batch_size_planned` DECIMAL(18,2) COMMENT 'Planned production quantity for this batch as specified in the production order. Measured in base unit of measure.',
    `batch_status` STRING COMMENT 'Current lifecycle status of the batch. Controls inventory availability and distribution eligibility per GMP workflow.. Valid values are `in_process|released|rejected|quarantine|recalled|expired`',
    `bom_version` STRING COMMENT 'Version of the bill of materials used for this batch. Ensures traceability of raw material specifications.. Valid values are `^[A-Z0-9.]{1,20}$`',
    `changeover_minutes` STRING COMMENT 'Time in minutes required for line changeover before this batch. Key metric for SMED and lean manufacturing initiatives.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this batch record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for cost amounts. Supports multi-currency manufacturing operations.. Valid values are `^[A-Z]{3}$`',
    `downtime_minutes` STRING COMMENT 'Total unplanned downtime in minutes during batch production. Used for OEE calculation and maintenance planning.',
    `electronic_signature_count` STRING COMMENT 'Number of electronic signatures captured during batch record lifecycle. Required for FDA 21 CFR Part 11 compliance.',
    `expiry_date` DATE COMMENT 'Date after which the product should not be used or sold. Critical for FEFO inventory management and consumer safety.',
    `gmp_deviation_count` STRING COMMENT 'Number of GMP deviations recorded for this batch. Used for quality trend analysis and CAPA tracking.',
    `gmp_deviation_flag` BOOLEAN COMMENT 'Indicates whether any GMP deviations were recorded during batch production. Triggers quality review workflow.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this batch record was last updated. Audit trail for GMP compliance and data integrity.',
    `lot_genealogy_complete_flag` BOOLEAN COMMENT 'Indicates whether complete raw material lot traceability has been captured for this batch. Required for recall readiness.',
    `manufacturing_date` DATE COMMENT 'Calendar date of batch production. Printed on product packaging for consumer information and regulatory compliance.',
    `manufacturing_end_timestamp` TIMESTAMP COMMENT 'Date and time when batch production was completed and final packaging finished. Used for cycle time analysis.',
    `manufacturing_start_timestamp` TIMESTAMP COMMENT 'Date and time when batch production was initiated on the shop floor. Captured from MES system.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Overall equipment effectiveness achieved during batch production. Composite metric of availability, performance, and quality.',
    `quality_release_flag` BOOLEAN COMMENT 'Indicates whether the batch has been released by Quality Assurance for distribution. Required before inventory availability.',
    `quality_release_timestamp` TIMESTAMP COMMENT 'Date and time when Quality Assurance approved the batch for release. Marks transition from quarantine to available inventory.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether this batch is subject to a product recall. Triggers supply chain hold and customer notification.',
    `recall_initiated_date` DATE COMMENT 'Date when recall was initiated for this batch. Used for regulatory reporting and recall effectiveness tracking.',
    `record_locked_flag` BOOLEAN COMMENT 'Indicates whether this batch record is locked from further edits. Required for GMP record integrity after quality release.',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Indicates whether batch is on regulatory hold pending investigation or approval. Prevents distribution until cleared.',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Quantity of product requiring rework during batch production. Indicator of process capability and quality issues.',
    `routing_version` STRING COMMENT 'Version of the production routing used for this batch. Documents the manufacturing process steps executed.. Valid values are `^[A-Z0-9.]{1,20}$`',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of product scrapped during batch production. Used for yield calculation and waste reduction analysis.',
    `shelf_life_days` STRING COMMENT 'Number of days between manufacturing date and expiry date. Derived from product stability testing.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for batch size quantities (e.g., KG, LTR, EA, CS). Aligns with GS1 standards.. Valid values are `^[A-Z]{2,6}$`',
    `veeva_vault_document_reference` STRING COMMENT 'Reference to the master batch record document stored in Veeva Vault. Links to regulatory document management system.. Valid values are `^VV[A-Z0-9]{10,30}$`',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Ratio of actual batch size to planned batch size expressed as percentage. Key performance indicator for manufacturing efficiency.',
    CONSTRAINT pk_batch_record PRIMARY KEY(`batch_record_id`)
) COMMENT 'Electronic batch manufacturing record (eBMR) capturing the complete GMP-compliant execution history for a production batch. Captures batch number, production order reference, SKU, batch size, manufacturing date, expiry date (FEFO), facility, production line, batch status (in-process, released, rejected, quarantine, recalled), GMP deviation flag, electronic signature records, yield percentage, and Veeva Vault document reference. SSOT for GMP batch traceability per ISO 22716 and FDA 21 CFR Part 211.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` (
    `oee_record_id` BIGINT COMMENT 'Unique identifier for the OEE measurement record. Primary key for the OEE record entity.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: GMP traceability reporting in consumer goods requires correlating OEE performance (availability, quality rate) with specific lot/batch outcomes. Quality teams use this link to identify whether low OEE',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: OEE records are captured per manufacturing facility; add direct FK for accurate reporting.',
    `production_line_id` BIGINT COMMENT 'Identifier of the specific production line for which OEE was measured.',
    `production_order_id` BIGINT COMMENT 'Identifier of the manufacturing work order executed during this shift.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU that was produced during this shift. Links OEE performance to specific product.',
    `actual_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Average actual time in seconds to produce one unit during the shift, calculated as Actual Operating Time / Total Units Produced.',
    `actual_operating_time_minutes` DECIMAL(18,2) COMMENT 'Actual time the production line was operating during the shift in minutes, after subtracting unplanned downtime.',
    `availability_rate` DECIMAL(18,2) COMMENT 'Percentage of planned production time that the line was actually operating, calculated as (Planned Production Time - Downtime) / Planned Production Time. Component of OEE calculation.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number produced during the shift. Critical for traceability and GMP compliance.',
    `changeover_count` STRING COMMENT 'Number of product or format changeovers performed during the shift. Impacts availability and performance metrics.',
    `changeover_time_minutes` DECIMAL(18,2) COMMENT 'Total time spent on changeovers during the shift in minutes.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the OEE measurement, including explanations for anomalies or performance issues.',
    `data_collection_method` STRING COMMENT 'Method by which OEE data was captured (automated from sensors, manual entry, or semi-automated).. Valid values are `automated|manual|semi_automated`',
    `downtime_minutes` DECIMAL(18,2) COMMENT 'Total unplanned downtime during the shift in minutes, including equipment failures, material shortages, and unscheduled stoppages.',
    `good_units_produced` BIGINT COMMENT 'Count of units that passed quality inspection and met specifications, calculated as Total Units Produced - Total Units Rejected.',
    `ideal_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Theoretical minimum time in seconds to produce one unit at maximum design speed under optimal conditions.',
    `mes_data_source` STRING COMMENT 'Source system identifier for the OEE data, typically Siemens Opcenter MES or equivalent system.',
    `micro_stop_count` STRING COMMENT 'Number of brief stoppages (typically under 5 minutes) that impact performance but may not be classified as downtime.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Composite OEE metric calculated as Availability Rate × Performance Rate × Quality Rate. Single measure of manufacturing productivity and effectiveness.',
    `oee_status` STRING COMMENT 'Current lifecycle status of the OEE record indicating validation and approval state.. Valid values are `draft|validated|approved|rejected`',
    `operator_count` STRING COMMENT 'Number of operators assigned to the production line during the shift.',
    `performance_rate` DECIMAL(18,2) COMMENT 'Percentage of ideal production speed achieved, calculated as (Ideal Cycle Time × Total Units Produced) / Actual Operating Time. Component of OEE calculation.',
    `planned_production_time_minutes` DECIMAL(18,2) COMMENT 'Total scheduled production time for the shift in minutes, excluding planned downtime such as breaks and scheduled maintenance.',
    `quality_loss_minutes` DECIMAL(18,2) COMMENT 'Time equivalent of production lost due to quality defects and rework in minutes.',
    `quality_rate` DECIMAL(18,2) COMMENT 'Percentage of good units produced without defects, calculated as (Total Units Produced - Total Units Rejected) / Total Units Produced. Component of OEE calculation.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when the OEE record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the OEE record was last modified.',
    `rework_units` BIGINT COMMENT 'Count of units that required rework or reprocessing to meet quality standards during the shift.',
    `scrap_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of scrap material generated during the shift in kilograms.',
    `shift_date` DATE COMMENT 'Calendar date on which the production shift occurred. Principal business event timestamp for OEE measurement.',
    `shift_name` STRING COMMENT 'Descriptive name of the production shift (e.g., day, evening, night).. Valid values are `day|evening|night|morning|afternoon|graveyard`',
    `shift_number` STRING COMMENT 'Sequential shift identifier within the shift date (e.g., 1 for first shift, 2 for second shift, 3 for third shift).',
    `speed_loss_minutes` DECIMAL(18,2) COMMENT 'Time lost due to production running below ideal cycle time in minutes, representing performance inefficiency.',
    `total_units_produced` BIGINT COMMENT 'Total count of units produced during the shift, including both good units and rejected units.',
    `total_units_rejected` BIGINT COMMENT 'Total count of units rejected due to quality defects during the shift.',
    `unplanned_stop_count` STRING COMMENT 'Number of unplanned production stoppages during the shift.',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the OEE record was validated by production management.',
    CONSTRAINT pk_oee_record PRIMARY KEY(`oee_record_id`)
) COMMENT 'Overall Equipment Effectiveness (OEE) measurement record captured per production line per shift. Captures OEE record ID, facility, production line, shift date, shift number, planned production time (minutes), downtime (minutes), speed loss (minutes), quality loss (minutes), availability rate, performance rate, quality rate, composite OEE percentage, total units produced, total units rejected, and MES data source (Siemens Opcenter). SSOT for line performance analytics and continuous improvement programs.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` (
    `downtime_event_id` BIGINT COMMENT 'Unique identifier for the downtime event record. Primary key for the downtime event entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Downtime costs are charged to the responsible cost center for departmental cost accountability and budget variance reporting. In consumer goods manufacturing, downtime financial impact is directly all',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to manufacturing.equipment. Business justification: downtime_event records individual stoppages on a production line and captures equipment_failure_mode (STRING) as a description. Adding equipment_id as a FK to the equipment master enables direct linka',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Downtime financial impact (financial_impact_amount) must be posted to a specific GL account (e.g., production loss expense, maintenance cost). In consumer goods ERP, downtime costs are directly journa',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: When a downtime event triggers batch_hold_required, the specific lot/batch must be quarantined in inventory. Consumer goods GMP regulations require direct traceability from equipment failure events to',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Downtime events are tied to a manufacturing facility; replace generic reference with direct FK.',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: GMP regulations require equipment failures and process deviations causing downtime to be documented as nonconformances. Consumer goods manufacturers link downtime events to nonconformance records for ',
    `production_line_id` BIGINT COMMENT 'Identifier of the production line where the downtime event occurred.',
    `production_order_id` BIGINT COMMENT 'Identifier of the production order that was impacted by this downtime event.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Equipment downtime caused by substandard or non-conforming materials is traced to the responsible supplier for supplier performance management and scorecard input. In consumer goods manufacturing, sup',
    `batch_hold_required` BOOLEAN COMMENT 'Indicates whether production batches affected by this downtime event require quality hold pending investigation.',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective action taken to resolve the downtime event and restore production.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this downtime event record was first created in the data platform.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Source system or method by which the downtime event was captured (MES automatic detection, manual operator entry, sensor, SCADA).. Valid values are `mes_automatic|manual_entry|sensor|scada`',
    `downtime_category` STRING COMMENT 'High-level classification of the downtime event type. [ENUM-REF-CANDIDATE: mechanical_failure|electrical_failure|changeover|material_shortage|operator_absence|planned_maintenance|cleaning_sanitation|quality_hold|tooling_issue|system_failure|unplanned_maintenance — promote to reference product]. Valid values are `mechanical_failure|electrical_failure|changeover|material_shortage|operator_absence|planned_maintenance`',
    `downtime_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the downtime event ended and production resumed. Null if downtime is ongoing.',
    `downtime_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the downtime event began. Captured from MES system or manual entry.',
    `downtime_type` STRING COMMENT 'Indicates whether the downtime was planned (scheduled maintenance, changeover) or unplanned (breakdown, shortage).. Valid values are `planned|unplanned`',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the downtime event measured in minutes. Calculated as the difference between end and start timestamps.',
    `equipment_failure_mode` STRING COMMENT 'Specific failure mode of the equipment that caused the downtime, used for reliability analysis and FMEA.',
    `escalation_level` STRING COMMENT 'Level of management escalation required or triggered by this downtime event based on duration and impact.. Valid values are `none|supervisor|manager|director|executive`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the downtime event in local currency, including lost production value and recovery costs.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the downtime event and its resolution comply with GMP requirements per ISO 22716.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the downtime event, root cause investigation, or resolution.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether automated notifications were sent to relevant stakeholders about this downtime event.',
    `oee_impact_flag` BOOLEAN COMMENT 'Indicates whether this downtime event is included in OEE availability loss calculations.',
    `preventive_action_required` BOOLEAN COMMENT 'Indicates whether preventive action is required to avoid recurrence of this downtime event.',
    `production_loss_units` DECIMAL(18,2) COMMENT 'Estimated number of production units lost due to this downtime event, based on standard production rate.',
    `reported_timestamp` TIMESTAMP COMMENT 'Timestamp when the downtime event was first reported or logged in the system.',
    `resolution_status` STRING COMMENT 'Current status of the downtime event resolution process.. Valid values are `open|in_progress|resolved|closed`',
    `responsible_department` STRING COMMENT 'Department responsible for addressing or preventing this type of downtime event.. Valid values are `production|maintenance|quality|materials|engineering|utilities`',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the root cause of the downtime event. Aligned with facility-specific root cause taxonomy.',
    `root_cause_description` STRING COMMENT 'Detailed textual description of the root cause analysis findings for this downtime event.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether the downtime event was associated with a safety incident or near-miss.',
    `severity_level` STRING COMMENT 'Severity classification of the downtime event based on impact to production schedule and safety.. Valid values are `critical|high|medium|low`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this downtime event record was last updated in the data platform.',
    CONSTRAINT pk_downtime_event PRIMARY KEY(`downtime_event_id`)
) COMMENT 'Individual downtime event record capturing each unplanned or planned stoppage on a production line or work center. Captures event ID, facility, production line, work center, downtime start/end timestamps, duration (minutes), downtime category (mechanical failure, changeover, material shortage, operator absence, planned maintenance, cleaning/sanitation), root cause code, responsible department, production order impacted, and corrective action taken. Feeds OEE loss analysis and maintenance work order creation.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` (
    `yield_record_id` BIGINT COMMENT 'Unique identifier for the yield tracking record. Primary key for the yield record entity.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: yield_record captures input vs. output quantities at each stage of the manufacturing process and stores batch_number (STRING) as a reference. Adding batch_record_id as a FK to the batch_record (eBMR) ',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Yield-to-inventory reconciliation is a core consumer goods manufacturing KPI. The yield_record captures actual output quantities that are posted to inventory as a specific lot/batch. This link enables',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: yield_record.plant_code is a denormalized STRING reference to the manufacturing facility. Adding manufacturing_facility_id as a proper FK normalizes this relationship, enabling direct joins to facilit',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: yield_record.production_line_code is a denormalized STRING reference to the production line where yield was measured. Adding production_line_id as a proper FK normalizes this relationship, enabling di',
    `production_order_id` BIGINT COMMENT 'Reference to the production order for which this yield record is captured. Links yield data to the manufacturing order in SAP S/4HANA PP module.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Yield-by-SKU analytics and standard cost variance reporting: consumer goods finance and operations teams report yield performance and cost variances directly by SKU without joining through production_',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Yield variance cost impact (yield_variance_cost_impact) requires standard cost per unit to calculate financial loss from yield shortfalls. standard_cost_per_unit is denormalized from standard_cost. Di',
    `actual_yield_percentage` DECIMAL(18,2) COMMENT 'Actual yield percentage achieved calculated as (output_quantity / input_quantity) * 100. Key Performance Indicator (KPI) for manufacturing efficiency.',
    `batch_number` STRING COMMENT 'Manufacturing batch identifier for traceability and Good Manufacturing Practice (GMP) compliance. Critical for product recall and quality investigations.. Valid values are `^[A-Z0-9]{6,20}$`',
    `batch_record_status` STRING COMMENT 'Current lifecycle status of the batch record documentation. Tracks progression through Good Manufacturing Practice (GMP) review and approval workflow.. Valid values are `DRAFT|IN_PROGRESS|COMPLETED|REVIEWED|APPROVED|REJECTED`',
    `comments` STRING COMMENT 'Free-text comments or notes from production operators or quality personnel regarding yield performance, issues encountered, or corrective actions taken.',
    `cost_center_code` STRING COMMENT 'Cost center responsible for this manufacturing operation. Used for Cost of Goods Sold (COGS) allocation and variance accounting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this yield record was first created in the system. Audit trail for data governance and compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this yield record. Typically the plants local currency or corporate reporting currency.. Valid values are `^[A-Z]{3}$`',
    `erp_document_number` STRING COMMENT 'Document number in the Enterprise Resource Planning (ERP) system (SAP S/4HANA) that records the goods movement associated with this yield. Links to material document for inventory reconciliation.. Valid values are `^[A-Z0-9]{10,20}$`',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether this yield record meets Good Manufacturing Practice (GMP) documentation and traceability requirements. Critical for regulatory audits and product release.',
    `input_quantity` DECIMAL(18,2) COMMENT 'Total quantity of raw materials or semi-finished goods consumed as input for this operation. Used to calculate theoretical yield and material consumption variance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this yield record was last updated. Audit trail for data governance and Good Manufacturing Practice (GMP) compliance.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the yield measurement was captured at the work center. Critical for Manufacturing Execution System (MES) integration and real-time production monitoring.',
    `mes_transaction_reference` STRING COMMENT 'Unique transaction identifier from the Manufacturing Execution System (MES) that originated this yield record. Enables traceability to Siemens Opcenter MES source data.. Valid values are `^[A-Z0-9]{10,30}$`',
    `operation_end_timestamp` TIMESTAMP COMMENT 'Date and time when the manufacturing operation completed. Used to calculate cycle time and Overall Equipment Effectiveness (OEE).',
    `operation_start_timestamp` TIMESTAMP COMMENT 'Date and time when the manufacturing operation began. Used to calculate cycle time and Overall Equipment Effectiveness (OEE).',
    `output_quantity` DECIMAL(18,2) COMMENT 'Total quantity of finished or semi-finished goods produced as output from this operation. Represents the good production yield before scrap and rework.',
    `quality_inspection_lot_number` STRING COMMENT 'Quality Control (QC) inspection lot number associated with this yield record. Links yield data to quality inspection results for Good Manufacturing Practice (GMP) compliance.. Valid values are `^[A-Z0-9]{8,20}$`',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Quantity of material that required rework or reprocessing to meet quality specifications. Impacts production efficiency and cycle time.',
    `routing_operation_number` STRING COMMENT 'Specific operation sequence number within the production routing where yield is measured. Identifies the manufacturing step in the Bill of Materials (BOM) routing.. Valid values are `^[0-9]{4,10}$`',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of material that failed quality checks and was scrapped during this operation. Contributes to yield loss and Cost of Goods Sold (COGS) variance.',
    `shift_code` STRING COMMENT 'Production shift identifier during which the yield measurement was captured. Used for shift-level performance analysis and labor productivity tracking.. Valid values are `SHIFT_1|SHIFT_2|SHIFT_3|DAY|NIGHT|WEEKEND`',
    `theoretical_yield_percentage` DECIMAL(18,2) COMMENT 'Expected yield percentage based on Bill of Materials (BOM) specifications and standard operating procedures. Baseline for variance analysis.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for all quantity fields in this yield record. Must be consistent across input, output, scrap, and rework quantities. [ENUM-REF-CANDIDATE: KG|L|EA|M|M2|M3|TON|LB|GAL|OZ — 10 candidates stripped; promote to reference product]',
    `yield_loss_reason_code` STRING COMMENT 'Standardized code identifying the root cause of yield variance. Used for Pareto analysis and continuous improvement initiatives. Examples: EQUIP_FAIL, MAT_DEFECT, PROC_ERROR, QUAL_REJECT.. Valid values are `^[A-Z0-9]{2,10}$`',
    `yield_loss_reason_description` STRING COMMENT 'Detailed description of the yield loss root cause. Provides context for quality investigations and corrective action planning.',
    `yield_variance_cost_impact` DECIMAL(18,2) COMMENT 'Financial impact of yield variance calculated as (theoretical_yield - actual_yield) * standard_cost_per_unit. Feeds into Cost of Goods Sold (COGS) variance reporting.',
    `yield_variance_percentage` DECIMAL(18,2) COMMENT 'Variance between actual and theoretical yield expressed as percentage. Calculated as (actual_yield_percentage - theoretical_yield_percentage). Negative values indicate yield loss.',
    CONSTRAINT pk_yield_record PRIMARY KEY(`yield_record_id`)
) COMMENT 'Yield tracking record capturing input vs. output quantities at each stage of the manufacturing process for a production order or batch. Captures yield record ID, production order reference, batch number, routing operation, work center, input quantity, output quantity, scrap quantity, rework quantity, theoretical yield percentage, actual yield percentage, yield variance, unit of measure, and yield loss reason code. Enables yield variance analysis, COGS accuracy, and GMP batch record reconciliation.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` (
    `production_confirmation_id` BIGINT COMMENT 'Unique identifier for the production confirmation record. Primary key for shop floor execution tracking.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which labor and overhead costs for this operation are allocated for financial accounting.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Production confirmations trigger goods-issue to a destination DC in consumer goods ERP/WMS integration. Linking confirmed production output to the receiving distribution facility supports inventory re',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Production confirmations trigger automatic journal entries in ERP (goods issue, activity confirmation, goods receipt postings). Linking confirmation to journal_entry provides the audit trail from shop',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Production confirmation is the ERP event (SAP movement type 101 goods receipt) that creates a lot/batch in inventory. Consumer goods manufacturers require this link to trace confirmed yield quantities',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: production_confirmation is the shop floor execution and confirmation record capturing the complete lifecycle of each manufacturing operation. It already references manufacturing_facility and productio',
    `production_order_id` BIGINT COMMENT 'Reference to the parent production order under which this operation was executed.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Production confirmation reports must reference the sales order they fulfill for accurate shipping and invoicing.',
    `sku_id` BIGINT COMMENT 'Reference to the finished or semi-finished material (SKU) produced by this operation.',
    `stock_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_movement. Business justification: Production confirmation is the ERP event that triggers goods receipt stock movements (SAP movement type 101). Consumer goods manufacturers require this direct link for production-to-inventory reconcil',
    `activity_type` STRING COMMENT 'SAP CO activity type code representing the type of work performed (e.g., machine hours, labor hours, setup hours) for cost allocation purposes.. Valid values are `^[A-Z0-9]{4,6}$`',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when the operation was completed and confirmed by the operator. Used for OEE calculation and production order settlement.',
    `actual_labor_time_minutes` DECIMAL(18,2) COMMENT 'Actual operator labor time spent on this operation including manual work, monitoring, and quality checks. Measured in minutes.',
    `actual_machine_time_minutes` DECIMAL(18,2) COMMENT 'Actual time the machine or equipment was actively running during this operation. Excludes setup and downtime. Measured in minutes.',
    `actual_setup_time_minutes` DECIMAL(18,2) COMMENT 'Actual time spent on machine setup, changeover, and preparation activities before production began. Measured in minutes.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the operator began executing this operation on the shop floor. Captured from MES or manual confirmation.',
    `confirmation_notes` STRING COMMENT 'Free-text notes or comments entered by the operator or supervisor regarding this operation execution, including any issues or observations.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'System timestamp when this confirmation record was created and submitted to the ERP or MES system.',
    `confirmation_type` STRING COMMENT 'Classification of the confirmation event indicating whether this is a partial progress update, final completion, milestone checkpoint, rework confirmation, or cancellation.. Valid values are `partial|final|milestone|rework|cancelled`',
    `confirmed_scrap_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of defective or waste material generated during this operation. Used for yield variance analysis and quality tracking.',
    `confirmed_yield_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of good output produced and confirmed for this operation. Measured in the base unit of measure for the material.',
    `downtime_minutes` DECIMAL(18,2) COMMENT 'Total unplanned downtime during this operation due to equipment failure, material shortage, or other interruptions. Measured in minutes.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether this operation was executed in compliance with GMP standards as required for regulated consumer goods products.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this confirmation record was last updated or modified. Used for change tracking and audit purposes.',
    `mes_transaction_reference` STRING COMMENT 'Unique transaction reference from the Siemens Opcenter MES system that originated this confirmation. Used for traceability and system reconciliation.. Valid values are `^MES[A-Z0-9]{10,20}$`',
    `oee_availability_percent` DECIMAL(18,2) COMMENT 'Calculated availability component of OEE for this operation, representing the percentage of scheduled time that equipment was available for production.',
    `oee_performance_percent` DECIMAL(18,2) COMMENT 'Calculated performance component of OEE for this operation, representing actual production speed versus ideal speed.',
    `oee_quality_percent` DECIMAL(18,2) COMMENT 'Calculated quality component of OEE for this operation, representing the percentage of good output versus total output produced.',
    `operation_number` STRING COMMENT 'Sequential operation identifier within the production order routing. Typically a 4-digit numeric code representing the step in the manufacturing process.. Valid values are `^[0-9]{4}$`',
    `operation_status` STRING COMMENT 'Current lifecycle status of the manufacturing operation indicating its execution state in the production workflow.. Valid values are `open|in_progress|completed|cancelled|on_hold`',
    `posting_date` DATE COMMENT 'Financial posting date when this confirmation was recorded in the ERP system for inventory and cost accounting purposes.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this operation output requires quality inspection before release to inventory or next operation.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this confirmation has been reversed or cancelled due to error correction or process adjustment.',
    `reversal_reason_code` STRING COMMENT 'Standardized code explaining why this confirmation was reversed, if applicable. Used for process improvement and error tracking.. Valid values are `^[A-Z0-9]{2,4}$`',
    `rework_flag` BOOLEAN COMMENT 'Indicates whether this confirmation represents a rework operation to correct defects from a previous production run.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned completion date and time for this operation as determined by production scheduling or MES system.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned start date and time for this operation as determined by production scheduling or MES system.',
    `shift_code` STRING COMMENT 'Production shift identifier during which this operation was executed (e.g., SHIFT_1, DAY, NIGHT). Used for shift performance analysis.. Valid values are `^(SHIFT_[1-3]|DAY|NIGHT|SWING)$`',
    `source_system_code` STRING COMMENT 'Identifier of the originating system that created this confirmation record (SAP PP, Siemens Opcenter MES, or manual entry).. Valid values are `SAP_PP|OPCENTER_MES|MANUAL`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the confirmed quantities (e.g., KG for kilograms, EA for each, LT for liters). Aligns with material master UOM.. Valid values are `^[A-Z]{2,3}$`',
    `variance_reason_code` STRING COMMENT 'Standardized code explaining any significant variance between planned and actual quantities or times. Used for root cause analysis.. Valid values are `^[A-Z0-9]{2,6}$`',
    `work_order_number` STRING COMMENT 'Business identifier for the work order assigned to this manufacturing operation. Externally visible reference used across shop floor systems.. Valid values are `^WO[0-9]{8,12}$`',
    CONSTRAINT pk_production_confirmation PRIMARY KEY(`production_confirmation_id`)
) COMMENT 'Shop floor execution and confirmation record capturing the complete lifecycle of each manufacturing operation within a production order — from assignment and scheduling through actual execution and final confirmation. Captures work order number, parent production order reference, operation number, work center, assigned operator, scheduled start/end, actual start/end, confirmation type (partial, final), confirmed yield quantity, confirmed scrap quantity, actual setup/machine/labor time, operation status (open, in-progress, completed, cancelled), posting date, and MES transaction reference (Siemens Opcenter). SSOT for granular shop floor execution tracking, labor confirmation, production order settlement, and OEE calculation. Subsumes discrete work order assignment data.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` (
    `planned_order_id` BIGINT COMMENT 'Unique system-generated identifier for the planned order record. Primary key for the planned order entity.',
    `production_order_id` BIGINT COMMENT 'Reference to the production order that was created from this planned order upon conversion. Null if not yet converted.',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: MRP/IBP planned orders are pegged to demand plan versions for demand-supply traceability. Consumer goods planners use this pegging to assess forecast accuracy impact on production scheduling and to pe',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: MRP demand pegging: in consumer goods make-to-order and ATP scenarios, planned orders are generated directly from sales orders. This FK enables S&OP demand traceability reports linking planned product',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: MRP/IBP planned orders in consumer goods are generated to replenish specific distribution centers. Linking planned_order to distribution_facility enables DC-level replenishment planning, demand-driven',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Promotion Event Demand Signal Traceability: in IBP/S&OP planning, demand signals from specific promotion events (not just parent trade promotions) drive planned orders. Supply planners need event-leve',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_brand. Business justification: S&OP and IBP processes in consumer goods are organized by brand portfolio. Brand managers review planned supply vs. demand at brand level. Direct brand FK on planned_order enables brand-level supply p',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: In IBP/MRP execution, supply plans generate planned orders. Linking planned_order back to the originating supply plan enables plan-vs-actual execution tracking and supply plan adherence reporting — a ',
    `planning_period_id` BIGINT COMMENT 'Foreign key linking to supply.planning_period. Business justification: Planned orders belong to a structured planning period/bucket in IBP/APO. Linking to planning_period enables period-level production plan aggregation, S&OP cycle reporting, and planning horizon managem',
    `product_bom_id` BIGINT COMMENT 'Foreign key linking to product.product_bom. Business justification: MRP/IBP material requirements explosion: planned orders reference a specific BOM version to explode component requirements for procurement and production scheduling. Consumer goods supply planners exp',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: In MRP/IBP processes, planned orders for externally procured materials convert directly into purchase requisitions. This link enables end-to-end demand-to-procurement traceability, MRP exception manag',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: MRP/IBP planned orders for regulated products must validate that a current regulatory registration exists for the target market before firming. Supply planners use this to prevent scheduling productio',
    `safety_stock_id` BIGINT COMMENT 'Foreign key linking to supply.safety_stock. Business justification: Safety stock replenishment signals trigger planned orders in MRP. Linking planned_order to the safety_stock policy that triggered it enables safety stock policy effectiveness analysis and supports inv',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) that this planned order is for. Links to the product master data.',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Planned orders use standard costs to calculate planned production costs for S&OP financial planning and budget vs. plan variance analysis. In consumer goods IBP/MRP processes, planned order cost valua',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to consumer.subscription. Business justification: In DTC Consumer Goods, active subscriptions drive MRP demand signals that generate planned_orders. Supply planners need to link planned production back to the subscription demand source to manage repl',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to customer.trade_account. Business justification: Supports demand‑planning reports linking planned production to specific customer accounts and forecast agreements.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Planned Promotional Production aligns MRP planned orders with upcoming trade promotions to ensure supply availability.',
    `availability_date` DATE COMMENT 'The date when the produced or procured material from this planned order is expected to be available for consumption or shipment.',
    `conversion_date` DATE COMMENT 'The date when this planned order was converted to a production order. Null if not yet converted.',
    `conversion_status` STRING COMMENT 'Indicates whether this planned order has been converted to a production order: NOT_CONVERTED (still in planning), PARTIALLY_CONVERTED (split conversion), FULLY_CONVERTED (completely converted).. Valid values are `NOT_CONVERTED|PARTIALLY_CONVERTED|FULLY_CONVERTED`',
    `created_by_user` STRING COMMENT 'User ID or system identifier of the person or automated process that created this planned order.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this planned order record was first created in the system.',
    `demand_source_type` STRING COMMENT 'Classification of the demand signal that triggered this planned order: FORECAST (demand planning), CUSTOMER_ORDER (firm sales order), STOCK_TRANSFER (inter-plant), SAFETY_STOCK (replenishment), PROMOTION (trade promotion demand).. Valid values are `FORECAST|CUSTOMER_ORDER|STOCK_TRANSFER|SAFETY_STOCK|PROMOTION`',
    `exception_message_code` STRING COMMENT 'Code representing MRP exception conditions (e.g., EX01 = reschedule in, EX02 = reschedule out, EX03 = cancel, EX10 = expedite). Empty if no exception.. Valid values are `^(EX[0-9]{2})?$`',
    `exception_message_text` STRING COMMENT 'Human-readable description of the MRP exception condition requiring planner attention.',
    `firming_date` DATE COMMENT 'The date when this planned order was firmed by a planner. Null if not yet firmed.',
    `firming_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this planned order is firmed (locked from automatic MRP changes). True = firmed, False = subject to MRP rescheduling.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether this planned order must comply with GMP regulations. True for pharmaceutical and cosmetic products requiring ISO 22716 compliance.',
    `ibp_plan_version` STRING COMMENT 'Version identifier from SAP IBP system that generated the demand signal driving this planned order. Format: IBP-YYYYMM.. Valid values are `^IBP-[0-9]{6}$`',
    `last_modified_by_user` STRING COMMENT 'User ID or system identifier of the person or automated process that last modified this planned order.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this planned order record was last updated or modified.',
    `lot_size_key` STRING COMMENT 'Code indicating the lot-sizing procedure used: EX (exact lot size), HB (lot-for-lot), FX (fixed lot size), PD (periodic lot size), WM (weekly lot size).. Valid values are `EX|HB|FX|PD|WM`',
    `mrp_controller` STRING COMMENT 'Code identifying the MRP controller or planning group responsible for this material and plant combination.. Valid values are `^[A-Z0-9]{3,10}$`',
    `mrp_run_code` BIGINT COMMENT 'Reference to the specific MRP run that generated or last modified this planned order. Links to MRP execution history.',
    `notes` STRING COMMENT 'Free-text field for planners to add comments, special instructions, or contextual information about this planned order.',
    `order_number` STRING COMMENT 'Business-readable unique identifier for the planned order, typically system-generated following organizational numbering conventions.. Valid values are `^[A-Z0-9]{8,12}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the planned order: DRAFT (initial creation), FIRMED (locked from MRP changes), RELEASED (approved for execution), CONVERTED (converted to production order), DELETED (marked for deletion), CANCELLED (cancelled before conversion).. Valid values are `DRAFT|FIRMED|RELEASED|CONVERTED|DELETED|CANCELLED`',
    `order_type` STRING COMMENT 'Classification of the planned order origin: MPS (Master Production Schedule), MRP (Material Requirements Planning generated), CBP (Consumption-Based Planning), MANUAL (manually created), FORECAST (forecast-driven), SAFETY (safety stock replenishment).. Valid values are `MPS|MRP|CBP|MANUAL|FORECAST|SAFETY`',
    `planned_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU planned to be produced or procured in this order, expressed in the base unit of measure.',
    `planning_period` STRING COMMENT 'The planning time bucket this order belongs to, expressed as YYYY-Wnn (week), YYYY-Mnn (month), or YYYY-Qn (quarter). Used for MPS and S&OP alignment.. Valid values are `^[0-9]{4}-(W[0-9]{2}|M[0-9]{2}|Q[1-4])$`',
    `planning_strategy_group` STRING COMMENT 'Two-digit code defining the planning strategy (e.g., 10 = make-to-stock, 20 = make-to-order, 40 = planning with final assembly, 50 = planning without final assembly).. Valid values are `^[0-9]{2}$`',
    `priority_code` STRING COMMENT 'Priority level assigned to this planned order for scheduling and resource allocation: LOW, NORMAL, HIGH, URGENT.. Valid values are `LOW|NORMAL|HIGH|URGENT`',
    `procurement_type` STRING COMMENT 'Indicates whether this planned order is for in-house production (IN_HOUSE), external procurement (EXTERNAL), or can be either (BOTH).. Valid values are `IN_HOUSE|EXTERNAL|BOTH`',
    `production_version` STRING COMMENT 'Identifies the specific combination of BOM (Bill of Materials) and routing to be used for production. Links to production master data.. Valid values are `^[0-9]{4}$`',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'The inventory level that triggers generation of a planned order for replenishment.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The safety stock level maintained for this SKU at this plant, influencing planned order generation.',
    `schedule_version` STRING COMMENT 'Version identifier for the MPS schedule that generated or governs this planned order. Enables tracking of schedule changes over time.. Valid values are `^V[0-9]{3}$`',
    `scheduled_finish_date` DATE COMMENT 'The planned date when production or procurement activities for this order should be completed and goods available.',
    `scheduled_start_date` DATE COMMENT 'The planned date when production or procurement activities for this order should begin.',
    `sop_cycle_reference` STRING COMMENT 'Reference to the S&OP planning cycle that this planned order aligns with. Format: SOP-YYYY-Mnn or SOP-YYYY-Qn.. Valid values are `^SOP-[0-9]{4}-(M[0-9]{2}|Q[1-4])$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the planned quantity (e.g., EA for each, KG for kilogram, L for liter). Follows ISO standard unit codes.. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_planned_order PRIMARY KEY(`planned_order_id`)
) COMMENT 'Production planning record representing the complete planning pipeline from S&OP/IBP through MRP execution to production order conversion. Encompasses both Master Production Schedule (MPS) entries (planned quantities by SKU/facility/period with schedule versioning) and MRP-generated planned orders (system-proposed production or procurement proposals). Captures planned order ID, order type (MPS, MRP planned, CBP), SKU, plant, MRP run reference, planned quantity, scheduled start/finish dates, planning period (week/month), schedule version, S&OP cycle reference, IBP plan version, firming indicator, schedule status (draft, firmed, released, converted, deleted), exception message code, planner ID, and conversion status. SSOT for MRP exception management, MPS governance, and the complete production planning pipeline from demand signal through to production order creation.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` (
    `equipment_id` BIGINT COMMENT 'Primary key for equipment',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Equipment maintenance and operating costs are charged to a dedicated cost center (e.g., maintenance cost center) separate from the production lines cost center. This enables equipment-level cost trac',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Manufacturing equipment is capitalized as fixed assets under IFRS/GAAP. Linking equipment to its fixed_asset record enables depreciation tracking, capex reporting, and asset register compliance — a ma',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the plant entity that houses the equipment.',
    `parent_equipment_id` BIGINT COMMENT 'Self-referencing FK on equipment (parent_equipment_id)',
    `production_line_id` BIGINT COMMENT 'Reference to the production line on which the equipment operates.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Capital equipment is acquired via purchase orders. Linking equipment to its acquisition PO enables capex tracking, asset capitalization, warranty period validation against PO date, and audit trail for',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Manufacturing equipment is procured from suppliers; the equipment vendor/OEM is a supplier in the procurement system. This link enables spare parts procurement, maintenance contract management, and wa',
    `asset_tag` STRING COMMENT 'Internal tag or barcode used to physically label the equipment.',
    `calibration_due_date` DATE COMMENT 'Scheduled date for the next calibration.',
    `capacity_units` STRING COMMENT 'Unit of measure for the equipments capacity.',
    `capacity_value` DECIMAL(18,2) COMMENT 'Numeric capacity of the equipment expressed in the specified units.',
    `compliance_gmp` BOOLEAN COMMENT 'Indicates whether the equipment complies with GMP standards.',
    `currency` STRING COMMENT 'Currency in which the acquisition cost is expressed.',
    `department` STRING COMMENT 'Organizational department responsible for the equipment.',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Total energy consumed by the equipment in kilowatt‑hours.',
    `equipment_description` STRING COMMENT 'Free‑form text describing the equipments purpose and characteristics.',
    `equipment_name` STRING COMMENT 'Human‑readable name or designation of the equipment.',
    `equipment_status` STRING COMMENT 'Current operational state of the equipment.',
    `equipment_type` STRING COMMENT 'Category of equipment based on function or form factor.',
    `hazard_classification` STRING COMMENT 'Level of hazard associated with equipment operation.',
    `installation_date` DATE COMMENT 'Date the equipment was installed and became operational.',
    `last_calibration_date` DATE COMMENT 'Date when the equipment was last calibrated.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance.',
    `location_code` STRING COMMENT 'Code identifying the plant or facility where the equipment resides.',
    `maintenance_cost` DECIMAL(18,2) COMMENT 'Cost incurred for the most recent maintenance activity.',
    `maintenance_frequency_days` STRING COMMENT 'Number of days between routine maintenance events.',
    `model_number` STRING COMMENT 'Model identifier assigned by the manufacturer.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating hours between equipment failures.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair equipment after a failure.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next maintenance activity.',
    `oee_actual` DECIMAL(18,2) COMMENT 'Measured Overall Equipment Effectiveness percentage.',
    `oee_target` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness percentage.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Maximum power consumption of the equipment in kilowatts.',
    `purchase_date` DATE COMMENT 'Date the equipment was purchased.',
    `safety_rating` STRING COMMENT 'Safety classification of the equipment.',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the equipment.',
    `total_usage_hours` DECIMAL(18,2) COMMENT 'Cumulative operating hours since installation.',
    `voltage` DECIMAL(18,2) COMMENT 'Nominal operating voltage of the equipment.',
    `warranty_end_date` DATE COMMENT 'Date when the equipment warranty expires.',
    `warranty_start_date` DATE COMMENT 'Date when the equipment warranty period begins.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight of the equipment in kilograms.',
    CONSTRAINT pk_equipment PRIMARY KEY(`equipment_id`)
) COMMENT 'Master reference table for equipment. Referenced by equipment_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_manufacturing_bom_id` FOREIGN KEY (`manufacturing_bom_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom`(`manufacturing_bom_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ADD CONSTRAINT `fk_manufacturing_oee_record_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ADD CONSTRAINT `fk_manufacturing_oee_record_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ADD CONSTRAINT `fk_manufacturing_oee_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_parent_equipment_id` FOREIGN KEY (`parent_equipment_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `consumer_goods_ecm`.`manufacturing`.`production_line`(`production_line_id`);

-- ========= TAGS =========
ALTER SCHEMA `consumer_goods_ecm`.`manufacturing` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `consumer_goods_ecm`.`manufacturing` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `energy_consumption_kwh_per_year` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (Kilowatt-Hours Per Year)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `epa_site_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Site ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `erp_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Plant ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'mixing|filling|packaging|co-manufacturing|integrated|contract');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `fda_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Establishment ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `fda_establishment_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7,10}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `gmp_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `gmp_certified` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `gmp_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certified');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `iso_22716_compliance_tier` SET TAGS ('dbx_business_glossary_term' = 'ISO 22716 Compliance Tier');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `iso_22716_compliance_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|non_compliant');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `mes_system_integrated` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Integrated');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `number_of_production_lines` SET TAGS ('dbx_business_glossary_term' = 'Number of Production Lines');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|startup|decommissioned|seasonal');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `osha_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Establishment Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|contract|joint_venture');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `primary_product_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Category');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `production_capacity_units_per_day` SET TAGS ('dbx_business_glossary_term' = 'Production Capacity (Units Per Day)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single|two_shift|three_shift|continuous|flexible');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|not_rated');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `water_consumption_cubic_meters_per_year` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption (Cubic Meters Per Year)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `workforce_headcount` SET TAGS ('dbx_business_glossary_term' = 'Workforce Headcount');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `allergen_handling_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Handling Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `allergen_types` SET TAGS ('dbx_business_glossary_term' = 'Allergen Types');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated|lights_out');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `changeover_time_standard_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time Standard (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `cleaning_validation_protocol` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Validation Protocol');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `crew_size_standard` SET TAGS ('dbx_business_glossary_term' = 'Standard Crew Size');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `design_speed_units_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Design Speed (Units Per Hour)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `energy_consumption_kwh_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (Kilowatt-Hours Per Unit)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `environmental_control_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Control Required');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'gmp_a|gmp_b|gmp_c|gmp_d|non_gmp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `humidity_range_percent` SET TAGS ('dbx_business_glossary_term' = 'Operating Humidity Range (Percent)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `installed_power_kw` SET TAGS ('dbx_business_glossary_term' = 'Installed Power (Kilowatts)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `last_major_overhaul_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Overhaul Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Production Line Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `line_length_meters` SET TAGS ('dbx_business_glossary_term' = 'Production Line Length (Meters)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Production Line Name');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Production Line Type');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'filling|blending|packaging|assembly|labeling|palletizing');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `mean_time_between_failures_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Hours');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR) Hours');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `mes_asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Asset Tag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `mes_asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `nominal_oee_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Nominal Overall Equipment Effectiveness (OEE) Target Percent');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Production Line Notes');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned|startup|idle');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `plc_system_type` SET TAGS ('dbx_business_glossary_term' = 'Programmable Logic Controller (PLC) System Type');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `quality_inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Frequency');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `quality_inspection_frequency` SET TAGS ('dbx_value_regex' = 'continuous|hourly|per_batch|per_shift|daily');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `scada_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control And Data Acquisition (SCADA) Integration Enabled');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `scrap_rate_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Scrap Rate Target Percent');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single_shift|two_shift|three_shift|continuous|custom');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_line` ALTER COLUMN `temperature_range_celsius` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Range (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `manufacturing_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Bill of Materials (BOM) ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `restricted_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `alternative_item_group` SET TAGS ('dbx_business_glossary_term' = 'Alternative Item Group');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `alternative_item_priority` SET TAGS ('dbx_business_glossary_term' = 'Alternative Item Priority');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `backflush_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backflush Indicator');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|obsolete|under_review');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Type');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'production|co-product|phantom|engineering|planning');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `component_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Component Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `component_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Component Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `component_item_category` SET TAGS ('dbx_business_glossary_term' = 'Component Item Category');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `component_item_category` SET TAGS ('dbx_value_regex' = 'stock|non-stock|phantom|text|variable_size');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `component_quantity` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `component_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Component Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `critical_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Component Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `inci_name` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Name');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `lot_size_requirement` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Requirement');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `lot_size_requirement` SET TAGS ('dbx_value_regex' = 'exact|minimum|multiple|none');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `minimum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `plm_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System Reference');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `scrap_factor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Factor Percentage');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `expected_scrap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Expected Scrap Percentage');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `expected_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Expected Yield Percentage');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `gmp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Critical Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `ipc_checkpoint_count` SET TAGS ('dbx_business_glossary_term' = 'In-Process Control (IPC) Checkpoint Count');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `lot_size_restriction` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Restriction');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `lot_size_restriction` SET TAGS ('dbx_value_regex' = 'none|fixed|minimum|maximum|multiple');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `maximum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lot Size');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `minimum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `operation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Operation Sequence');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `production_scheduler_code` SET TAGS ('dbx_business_glossary_term' = 'Production Scheduler Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `production_scheduler_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_description` SET TAGS ('dbx_business_glossary_term' = 'Routing Description');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Status');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|obsolete|under_review');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Type');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_value_regex' = 'standard|reference|rate|alternative|special');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Amount');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `total_labor_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Time (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `total_machine_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Machine Time (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `total_setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Setup Time (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `total_standard_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Standard Lead Time (Hours)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Routing Version');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`routing` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `manufacturing_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Bom Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `production_line_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Cost');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time in Minutes');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Production Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `cost_object` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Object');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `cost_object` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Creation Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Production Downtime in Minutes');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Production Order Notes');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,12}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Order Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Production Order Status');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Production Order Type');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'PP01|PP03|PP05|PP10|PP20');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Cost');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `planned_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Production Order Priority');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `production_supervisor` SET TAGS ('dbx_business_glossary_term' = 'Production Supervisor Name');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `production_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `released_by` SET TAGS ('dbx_business_glossary_term' = 'Released By User');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Release Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_business_glossary_term' = 'Cost Settlement Rule');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_value_regex' = 'FUL|PAR|PER');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Production Yield Percentage');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` SET TAGS ('dbx_subdomain' = 'quality_execution');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_size_actual` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Actual');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_size_planned` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Planned');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'in_process|released|rejected|quarantine|recalled|expired');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `bom_version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `bom_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{1,20}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `changeover_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Minutes');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Minutes');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `electronic_signature_count` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Count');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `gmp_deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Deviation Count');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `gmp_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Deviation Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `lot_genealogy_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Lot Genealogy Complete Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `manufacturing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing End Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `manufacturing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Start Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `quality_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Release Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `quality_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Release Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `recall_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiated Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `record_locked_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Locked Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `routing_version` SET TAGS ('dbx_business_glossary_term' = 'Routing Version');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `routing_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{1,20}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_value_regex' = '^VV[A-Z0-9]{10,30}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` SET TAGS ('dbx_subdomain' = 'quality_execution');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `oee_record_id` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Record ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `actual_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Cycle Time (Seconds)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `actual_operating_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Operating Time (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `availability_rate` SET TAGS ('dbx_business_glossary_term' = 'Availability Rate');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `changeover_count` SET TAGS ('dbx_business_glossary_term' = 'Changeover Count');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'OEE Record Comments');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'automated|manual|semi_automated');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `good_units_produced` SET TAGS ('dbx_business_glossary_term' = 'Good Units Produced');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `ideal_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ideal Cycle Time (Seconds)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `mes_data_source` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Data Source');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `micro_stop_count` SET TAGS ('dbx_business_glossary_term' = 'Micro Stop Count');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `oee_status` SET TAGS ('dbx_business_glossary_term' = 'OEE Record Status');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `oee_status` SET TAGS ('dbx_value_regex' = 'draft|validated|approved|rejected');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `operator_count` SET TAGS ('dbx_business_glossary_term' = 'Operator Count');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `performance_rate` SET TAGS ('dbx_business_glossary_term' = 'Performance Rate');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `planned_production_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Time (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `quality_loss_minutes` SET TAGS ('dbx_business_glossary_term' = 'Quality Loss (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `quality_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Rate');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `rework_units` SET TAGS ('dbx_business_glossary_term' = 'Rework Units');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `scrap_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Scrap Weight (Kilograms)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `shift_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Name');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `shift_name` SET TAGS ('dbx_value_regex' = 'day|evening|night|morning|afternoon|graveyard');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `shift_number` SET TAGS ('dbx_business_glossary_term' = 'Shift Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `speed_loss_minutes` SET TAGS ('dbx_business_glossary_term' = 'Speed Loss (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `total_units_produced` SET TAGS ('dbx_business_glossary_term' = 'Total Units Produced');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `total_units_rejected` SET TAGS ('dbx_business_glossary_term' = 'Total Units Rejected');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `unplanned_stop_count` SET TAGS ('dbx_business_glossary_term' = 'Unplanned Stop Count');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`oee_record` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` SET TAGS ('dbx_subdomain' = 'quality_execution');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_event_id` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `batch_hold_required` SET TAGS ('dbx_business_glossary_term' = 'Batch Hold Required Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'mes_automatic|manual_entry|sensor|scada');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Downtime Category');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_category` SET TAGS ('dbx_value_regex' = 'mechanical_failure|electrical_failure|changeover|material_shortage|operator_absence|planned_maintenance');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_type` SET TAGS ('dbx_business_glossary_term' = 'Downtime Type');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_type` SET TAGS ('dbx_value_regex' = 'planned|unplanned');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `equipment_failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Equipment Failure Mode');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|supervisor|manager|director|executive');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `oee_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Impact Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `preventive_action_required` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Required Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `production_loss_units` SET TAGS ('dbx_business_glossary_term' = 'Production Loss in Units');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `responsible_department` SET TAGS ('dbx_value_regex' = 'production|maintenance|quality|materials|engineering|utilities');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`downtime_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` SET TAGS ('dbx_subdomain' = 'quality_execution');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Record ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `actual_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percentage');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `batch_record_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Status');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `batch_record_status` SET TAGS ('dbx_value_regex' = 'DRAFT|IN_PROGRESS|COMPLETED|REVIEWED|APPROVED|REJECTED');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `erp_document_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Document Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `erp_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `input_quantity` SET TAGS ('dbx_business_glossary_term' = 'Input Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `operation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operation End Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `operation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operation Start Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `output_quantity` SET TAGS ('dbx_business_glossary_term' = 'Output Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `quality_inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Lot Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `quality_inspection_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `routing_operation_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Operation Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `routing_operation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'SHIFT_1|SHIFT_2|SHIFT_3|DAY|NIGHT|WEEKEND');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `theoretical_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Yield Percentage');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `yield_loss_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Reason Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `yield_loss_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `yield_loss_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Reason Description');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `yield_variance_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Yield Variance Cost Impact');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `yield_variance_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`yield_record` ALTER COLUMN `yield_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Variance Percentage');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_subdomain' = 'quality_execution');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `production_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Production Confirmation ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date Time');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `actual_labor_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Time (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `actual_machine_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Machine Time (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `actual_setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Setup Time (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date Time');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmation_notes` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Notes');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmation_type` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Type');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmation_type` SET TAGS ('dbx_value_regex' = 'partial|final|milestone|rework|cancelled');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmed_scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Scrap Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmed_yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Yield Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction ID');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_value_regex' = '^MES[A-Z0-9]{10,20}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `oee_availability_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Availability Percent');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `oee_performance_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Performance Percent');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `oee_quality_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Quality Percent');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `operation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `operation_status` SET TAGS ('dbx_business_glossary_term' = 'Operation Status');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `operation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|cancelled|on_hold');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `rework_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date Time');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date Time');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^(SHIFT_[1-3]|DAY|NIGHT|SWING)$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_PP|OPCENTER_MES|MANUAL');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`production_confirmation` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO[0-9]{8,12}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Production Order Identifier');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Source Sales Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `availability_date` SET TAGS ('dbx_business_glossary_term' = 'Material Availability Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Conversion to Production Order Status');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `conversion_status` SET TAGS ('dbx_value_regex' = 'NOT_CONVERTED|PARTIALLY_CONVERTED|FULLY_CONVERTED');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `demand_source_type` SET TAGS ('dbx_business_glossary_term' = 'Demand Source Type');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `demand_source_type` SET TAGS ('dbx_value_regex' = 'FORECAST|CUSTOMER_ORDER|STOCK_TRANSFER|SAFETY_STOCK|PROMOTION');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `exception_message_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Exception Message Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `exception_message_code` SET TAGS ('dbx_value_regex' = '^(EX[0-9]{2})?$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `exception_message_text` SET TAGS ('dbx_business_glossary_term' = 'Exception Message Description');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `firming_date` SET TAGS ('dbx_business_glossary_term' = 'Firming Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `firming_indicator` SET TAGS ('dbx_business_glossary_term' = 'Firming Indicator Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `ibp_plan_version` SET TAGS ('dbx_business_glossary_term' = 'Integrated Business Planning (IBP) Plan Version');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `ibp_plan_version` SET TAGS ('dbx_value_regex' = '^IBP-[0-9]{6}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `lot_size_key` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Calculation Key');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `lot_size_key` SET TAGS ('dbx_value_regex' = 'EX|HB|FX|PD|WM');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `mrp_run_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Run Identifier');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Planning Notes');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Number');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Status');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'DRAFT|FIRMED|RELEASED|CONVERTED|DELETED|CANCELLED');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Type');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'MPS|MRP|CBP|MANUAL|FORECAST|SAFETY');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `planning_period` SET TAGS ('dbx_business_glossary_term' = 'Planning Period');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `planning_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(W[0-9]{2}|M[0-9]{2}|Q[1-4])$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `planning_strategy_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Strategy Group');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `planning_strategy_group` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Planning Priority Code');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'LOW|NORMAL|HIGH|URGENT');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'IN_HOUSE|EXTERNAL|BOTH');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `production_version` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Master Production Schedule (MPS) Version');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `schedule_version` SET TAGS ('dbx_value_regex' = '^V[0-9]{3}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `sop_cycle_reference` SET TAGS ('dbx_business_glossary_term' = 'Sales and Operations Planning (S&OP) Cycle Reference');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `sop_cycle_reference` SET TAGS ('dbx_value_regex' = '^SOP-[0-9]{4}-(M[0-9]{2}|Q[1-4])$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`planned_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` ALTER COLUMN `parent_equipment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`manufacturing`.`equipment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
