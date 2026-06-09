-- Schema for Domain: product | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`product` COMMENT 'Authoritative catalog of finished chemical products, formulations, grades, and SKUs offered to customers. Manages product specifications, technical data sheets, GHS classification, SDS document linkage, regulatory status (REACH, TSCA), application guidelines, packaging configurations, product lifecycle state, product hierarchies, and cross-references. Covers performance materials, plastics, agricultural solutions, and specialty chemicals.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`chemical_product` (
    `chemical_product_id` BIGINT COMMENT 'Unique identifier for the chemical product. Primary key for the chemical product master record. This is the single source of truth for product identity across all enterprise systems.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: Links product to authoritative CAS registry for hazard classification, REACH/TSCA reporting, and consistent chemical identification.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for product cost allocation and profitability reporting; finance tracks manufacturing costs per cost center.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Links product to default GL revenue account for journal entries; required for accurate posting of sales transactions.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Tracks R&D or capital project costs per product; internal orders are used to capture development expenditures.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Required for Product Launch Traceability report linking each product to the R&D project that created it, enabling cost allocation and regulatory filing.',
    `compound_registry_id` BIGINT COMMENT 'Foreign key linking to research.compound_registry. Business justification: Needed for Regulatory Compliance Dashboard to map each product to its primary compound record for hazard classification and REACH reporting.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Procurement Planning uses a designated primary vendor per chemical product to generate purchase orders, cost analysis, and supplier performance reporting.',
    `product_family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Chemical products belong to a product family for classification and reporting; adding product_family_id creates the necessary link and removes the silo.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Product Manager assignment; used in product stewardship reports and regulatory compliance tracking.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Enables revenue attribution and margin analysis per profit center, essential for product-level financial statements.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Required for Regional Pricing and Regulatory Reporting linking product to its default sales territory.',
    `analytical_method_id` BIGINT COMMENT 'Foreign key linking to research.analytical_method. Business justification: Critical for Quality Control Specification to reference the validated analytical method used for product release testing.',
    `application_guidelines` STRING COMMENT 'Recommended use cases and application instructions for the product. Describes target industries, processes, and best practices for product utilization.',
    `base_unit_of_measure` STRING COMMENT 'Primary unit of measure for inventory, sales, and production transactions. KG: kilogram, L: liter, MT: metric ton, GAL: gallon, LB: pound, TON: short ton.. Valid values are `KG|L|MT|GAL|LB|TON`',
    `business_unit` STRING COMMENT 'Organizational business unit responsible for the product lifecycle, P&L accountability, and go-to-market strategy.',
    `chemical_name` STRING COMMENT 'IUPAC systematic chemical name or common chemical name describing the molecular composition. Used for regulatory reporting and technical documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the product master record was first created in the system. Used for data lineage, audit trails, and new product tracking.',
    `density_kg_per_l` DECIMAL(18,2) COMMENT 'Product density in kilograms per liter at standard temperature and pressure. Used for volume-to-weight conversions in logistics and formulation calculations.',
    `discontinuation_date` DATE COMMENT 'Date the product was or will be withdrawn from active sale. Null for active products. Used for end-of-life planning and inventory liquidation.',
    `fda_approval_required` BOOLEAN COMMENT 'Indicates whether the product requires FDA approval for food-contact, pharmaceutical, or cosmetic applications. True if FDA oversight applies.',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Lowest temperature at which vapors ignite when exposed to an ignition source. Critical for flammability classification, storage requirements, and fire safety planning.',
    `ghs_classification` STRING COMMENT 'GHS hazard classification codes (e.g., H226 Flammable liquid, H302 Harmful if swallowed). Used for SDS authoring, label generation, and workplace safety communication.',
    `ghs_pictograms` STRING COMMENT 'Comma-separated list of GHS pictogram codes required on product labels (e.g., GHS02 Flame, GHS07 Exclamation Mark). Communicates hazards visually per global standards.',
    `hap_content_percent` DECIMAL(18,2) COMMENT 'Percentage of EPA-listed hazardous air pollutants by weight. Triggers additional reporting and control requirements under Clean Air Act regulations.',
    `hazard_class` STRING COMMENT 'DOT hazard class for transportation (e.g., Class 3 Flammable Liquids, Class 8 Corrosives). Determines shipping requirements, packaging specifications, and carrier restrictions.',
    `introduction_date` DATE COMMENT 'Date the product was first made available for commercial sale. Used for product age analysis, lifecycle planning, and portfolio management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in the product master record. Critical for change tracking, data synchronization, and audit compliance.',
    `lifecycle_state` STRING COMMENT 'Current stage in the product lifecycle. Active: available for sale. Discontinued: no longer manufactured but may have inventory. Developmental: in R&D phase. Phased Out: transitioning to discontinuation. Pending Approval: awaiting regulatory or internal approval. Obsolete: fully retired.. Valid values are `active|discontinued|developmental|phased_out|pending_approval|obsolete`',
    `list_price_usd` DECIMAL(18,2) COMMENT 'Published list price per base unit in USD before discounts or negotiations. Starting point for customer pricing discussions. Confidential business data.',
    `material_number` STRING COMMENT 'SAP Material Master number. The authoritative business identifier for the product in SAP S/4HANA MM module. Used across procurement, production, sales, and inventory transactions.. Valid values are `^[A-Z0-9]{8,18}$`',
    `packaging_configuration` STRING COMMENT 'Standard packaging options available for the product (e.g., 55-gallon drum, 1000L IBC tote, bulk tanker, 25kg bag). Affects pricing, logistics, and customer ordering.',
    `packing_group` STRING COMMENT 'DOT packing group indicating degree of danger. I: high danger, II: medium danger, III: low danger. Determines packaging performance standards for hazmat transport.. Valid values are `I|II|III`',
    `ph_value` DECIMAL(18,2) COMMENT 'pH measurement indicating acidity or alkalinity on a 0-14 scale. Critical for corrosivity assessment, handling requirements, and application compatibility.',
    `physical_form` STRING COMMENT 'Physical state of the product at standard temperature and pressure. Critical for storage requirements, handling procedures, and transportation classification. [ENUM-REF-CANDIDATE: liquid|solid|powder|granular|gas|paste|emulsion|suspension — 8 candidates stripped; promote to reference product]',
    `primary_chemical_sds_id` BIGINT COMMENT 'Unique identifier linking to the current SDS document in the document management system. SDS provides comprehensive safety, handling, and emergency information.',
    `product_line` STRING COMMENT 'Mid-level product categorization within a product family. Used for sales planning, marketing campaigns, and business unit reporting.',
    `product_name` STRING COMMENT 'Official commercial product name as marketed to customers. Primary human-readable identifier used in sales literature, technical data sheets, and customer communications.',
    `product_type` STRING COMMENT 'Classification of product by commercial offering model. Bulk: high-volume commodity. Packaged: pre-packaged finished goods. Specialty: high-value low-volume. Custom Blend: customer-specific formulation. Intermediate: used in further manufacturing.. Valid values are `bulk|packaged|specialty|custom_blend|intermediate`',
    `reach_registration_number` STRING COMMENT 'ECHA registration number for substances manufactured or imported into the EU above 1 tonne per year. Required for legal sale in EU markets.. Valid values are `^[0-9]{2}-[0-9]{10}-[0-9]{2}-[0-9]{4}$`',
    `reach_status` STRING COMMENT 'Current REACH compliance status. Registered: full dossier submitted. Pre-registered: intent declared. Exempt: below tonnage threshold or exempted substance. Not Applicable: not sold in EU. Pending: registration in progress.. Valid values are `registered|pre_registered|exempt|not_applicable|pending`',
    `shelf_life_days` STRING COMMENT 'Number of days the product maintains specification quality under proper storage conditions from manufacturing date. Used for FEFO inventory management and expiration tracking.',
    `standard_cost_usd` DECIMAL(18,2) COMMENT 'Standard manufacturing cost per base unit in USD. Used for inventory valuation, margin analysis, and financial reporting. Confidential business data.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum safe storage temperature in degrees Celsius. Exceeding this temperature may degrade product quality or create safety hazards.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum safe storage temperature in degrees Celsius. Critical for warehouse environmental controls and product quality preservation.',
    `trade_name` STRING COMMENT 'Registered trademark or brand name under which the product is sold. May differ from the technical product name for marketing purposes.',
    `tsca_status` STRING COMMENT 'EPA TSCA inventory status for US market. Active: on inventory and commercially used. Inactive: on inventory but not currently manufactured. Exempt: polymer or other exemption. Not On Inventory: requires PMN before manufacture.. Valid values are `active|inactive|exempt|not_on_inventory`',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials transport. Required on shipping documents, labels, and placards per DOT and international transport regulations.. Valid values are `^UN[0-9]{4}$`',
    `viscosity_cps` DECIMAL(18,2) COMMENT 'Dynamic viscosity measured in centipoise at standard temperature. Affects pumping requirements, mixing behavior, and application characteristics.',
    `voc_content_percent` DECIMAL(18,2) COMMENT 'Percentage of volatile organic compounds by weight. Subject to EPA and state air quality regulations. Critical for environmental compliance and emissions reporting.',
    CONSTRAINT pk_chemical_product PRIMARY KEY(`chemical_product_id`)
) COMMENT 'Core master record for every finished chemical product, performance material, plastic, agricultural solution, or specialty chemical offered to customers. Captures authoritative product identity: product name, trade name, chemical name, CAS number, product family, product line, business unit, product type (bulk, packaged, specialty), physical form (liquid, solid, powder, gas), product lifecycle state (active, discontinued, developmental, phased_out), introduction date, discontinuation date, internal product code, storage temperature range, shelf life, and hazmat transport classification (UN number, hazard class, packing group). This is the SSOT for all product identity in the enterprise — SAP S/4HANA Material Master (MM) is the system of record.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Unique identifier for the SKU record. Primary key.',
    `chemical_product_id` BIGINT COMMENT 'Reference to the parent chemical product that this SKU represents a specific orderable configuration of.',
    `sds_id` BIGINT COMMENT 'Reference identifier linking to the current Safety Data Sheet document for this SKU. SDS provides hazard information and safe handling instructions.',
    `tds_id` BIGINT COMMENT 'Reference identifier linking to the Technical Data Sheet document containing product specifications, properties, and application guidelines.',
    `application_area` STRING COMMENT 'Primary industry or application area where this SKU is used (e.g., Automotive, Construction, Electronics, Agriculture, Pharmaceuticals, Water Treatment).',
    `barcode` STRING COMMENT 'Machine-readable barcode identifier (UPC, EAN, or GS1-128) printed on product packaging for scanning in warehouse and logistics operations.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by Chemical Abstracts Service to every chemical substance. Used for regulatory reporting and SDS documentation.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SKU record was first created in the system.',
    `discontinuation_date` DATE COMMENT 'Date when this SKU was or will be discontinued and removed from the active product catalog. Null for active SKUs.',
    `effective_date` DATE COMMENT 'Date when this SKU configuration became available for ordering and shipping. Used for product lifecycle management.',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Lowest temperature at which vapors of the chemical will ignite when exposed to an ignition source. Critical safety parameter for flammable liquids.',
    `ghs_classification` STRING COMMENT 'GHS hazard classification codes (e.g., H226, H302, H315) describing the chemical hazards of this product. Used for SDS and labeling.',
    `grade` STRING COMMENT 'Chemical grade or quality level of the product in this SKU (e.g., Technical Grade, Reagent Grade, Pharmaceutical Grade, Industrial Grade).',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total weight including product and packaging materials per package, measured in kilograms. Used for freight calculations and shipping documentation.',
    `gtin` STRING COMMENT 'Global Trade Item Number uniquely identifying this SKU in the global supply chain. Used for EDI transactions and retail distribution.. Valid values are `^[0-9]{8,14}$`',
    `hazard_class` STRING COMMENT 'DOT hazard classification for transportation (e.g., Class 3 Flammable Liquid, Class 8 Corrosive). Required for shipping documentation and compliance.',
    `is_controlled_substance` BOOLEAN COMMENT 'Flag indicating whether this chemical is a controlled substance requiring special licensing, reporting, and security measures under DEA or EPA regulations.',
    `is_hazmat` BOOLEAN COMMENT 'Flag indicating whether this SKU is classified as a hazardous material requiring special handling, storage, and transportation procedures.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered for this SKU. Used in sales order validation and customer quotations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this SKU record was last updated or modified.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the minimum order quantity field. [ENUM-REF-CANDIDATE: kg|l|mt|gal|lb|drum|ibc|bag|ea — 9 candidates stripped; promote to reference product]',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the chemical product content per package, excluding packaging materials, measured in kilograms.',
    `pack_size` DECIMAL(18,2) COMMENT 'Quantity of product contained in one package unit. Used with unit_of_measure to define the orderable quantity.',
    `packaging_type` STRING COMMENT 'Type of container or packaging used for this SKU configuration. [ENUM-REF-CANDIDATE: drum|ibc|bag|bulk|tote|cylinder|pail|bottle|tank|railcar — 10 candidates stripped; promote to reference product]',
    `ph_value` DECIMAL(18,2) COMMENT 'pH measurement indicating acidity or alkalinity of the chemical product on a scale of 0-14. Important for handling, compatibility, and application.',
    `reach_registration_number` STRING COMMENT 'European REACH registration number for this chemical substance. Required for sales in EU markets.',
    `shelf_life_days` STRING COMMENT 'Number of days from manufacturing date that the product maintains its specified quality and performance characteristics under proper storage conditions.',
    `sku_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying this specific SKU configuration. Used in ordering, shipping, and inventory systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `sku_description` STRING COMMENT 'Human-readable description of the SKU including product name, grade, packaging type, and size. Used on sales orders, shipping documents, and invoices.',
    `sku_status` STRING COMMENT 'Current lifecycle status of the SKU. Active SKUs are orderable; inactive and discontinued SKUs cannot be ordered; blocked SKUs are temporarily unavailable.. Valid values are `active|inactive|discontinued|pending_approval|blocked|phase_out`',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Ratio of the density of the chemical to the density of water at a specified temperature. Used for volume-to-weight conversions and quality control.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature in degrees Celsius at which the product must be stored to maintain stability and quality.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature in degrees Celsius at which the product must be stored to maintain stability and quality.',
    `tsca_status` STRING COMMENT 'Status of the chemical substance under US EPA TSCA inventory. Listed substances can be manufactured or imported in the US.. Valid values are `listed|exempt|not_listed|pending`',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials transport. Required on shipping papers, labels, and placards.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the pack size (kilograms, liters, metric tons, gallons, pounds, drums, intermediate bulk containers, bags, each). [ENUM-REF-CANDIDATE: kg|l|mt|gal|lb|drum|ibc|bag|ea — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Stock Keeping Unit record representing a specific orderable and shippable configuration of a chemical product. Each SKU maps to a unique combination of product, grade, packaging type, pack size, and unit of measure. Captures SKU code, description, net weight, gross weight, unit of measure (kg, L, MT, drum, IBC, bag), packaging type, hazard class, UN number, shelf life (days), storage temperature range, minimum order quantity (MOQ), and SKU status. Links to the parent chemical_product and to packaging_config. SAP SD material variant is the system of record.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`grade` (
    `grade_id` BIGINT COMMENT 'Unique identifier for the product grade record. Primary key.',
    `chemical_product_id` BIGINT COMMENT 'Reference to the parent chemical product for which this grade is defined. Links to the product master catalog.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Assigns a Grade Product Manager; supports grade‑specific cost and compliance reporting.',
    `quality_manager_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `sds_id` BIGINT COMMENT 'Reference identifier linking to the Safety Data Sheet (SDS) or Material Safety Data Sheet (MSDS) document for this grade. Critical for EHS (Environment Health and Safety) compliance.',
    `tds_id` BIGINT COMMENT 'Reference identifier linking to the technical data sheet document containing detailed specifications, properties, and application guidelines for this grade.',
    `acs_reagent_flag` BOOLEAN COMMENT 'Indicates whether this grade meets American Chemical Society (ACS) reagent specifications for laboratory and analytical use.',
    `application_sector` STRING COMMENT 'Primary industry sector or application area for which this grade is intended (e.g., pharmaceutical, food and beverage, electronics, agriculture, industrial manufacturing). [ENUM-REF-CANDIDATE: pharmaceutical|food_beverage|electronics|agriculture|industrial|research_laboratory|cosmetics|automotive|construction — 9 candidates stripped; promote to reference product]',
    `base_price_per_kg` DECIMAL(18,2) COMMENT 'Standard base price per kilogram for this grade in the default currency, used as a reference for pricing agreements and quotations. Subject to volume discounts and contract terms.',
    `cas_number` STRING COMMENT 'CAS (Chemical Abstracts Service) Registry Number uniquely identifying the chemical substance for this grade. Standard format: XXXXXX-XX-X.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `certificate_of_analysis_required_flag` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis (COA) must be issued with each lot or shipment of this grade, typically required for pharmaceutical, food, and high-purity grades.',
    `certificate_of_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether a Certificate of Compliance (COC) must be issued with shipments of this grade, certifying conformance to regulatory and customer specifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product grade record was first created in the system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'Date when this grade was discontinued or withdrawn from the catalog. Null for active grades. Used for product lifecycle tracking and phase-out management.',
    `effective_start_date` DATE COMMENT 'Date when this grade became available for sale and production. Used for product lifecycle tracking and historical analysis.',
    `ep_grade_flag` BOOLEAN COMMENT 'Indicates whether this grade meets European Pharmacopoeia (EP) monograph standards for pharmaceutical use in European markets.',
    `fcc_grade_flag` BOOLEAN COMMENT 'Indicates whether this grade meets Food Chemicals Codex (FCC) standards for food-contact and food-additive applications.',
    `ghs_classification` STRING COMMENT 'GHS (Globally Harmonized System) hazard classification codes applicable to this grade (e.g., H302, H315, H319). Used for Safety Data Sheet (SDS) generation and labeling compliance.',
    `gmp_compliant_flag` BOOLEAN COMMENT 'Indicates whether this grade is manufactured under Good Manufacturing Practice (GMP) standards, required for pharmaceutical and food-contact applications.',
    `grade_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the grade within the product catalog (e.g., TG, RG, FG, PG, EG, AG for Technical, Reagent, Food, Pharmaceutical, Electronic, Agricultural grades).. Valid values are `^[A-Z0-9]{2,10}$`',
    `grade_description` STRING COMMENT 'Detailed description of the grade, including its intended use, distinguishing characteristics, and typical applications.',
    `grade_name` STRING COMMENT 'Full descriptive name of the grade (e.g., Technical Grade, Reagent Grade, Food Grade, Pharmaceutical Grade, Electronic Grade, Agricultural Grade).',
    `grade_status` STRING COMMENT 'Current lifecycle status of the product grade in the catalog. Determines availability for sales and production.. Valid values are `active|inactive|discontinued|under_development|pending_approval`',
    `handling_requirements` STRING COMMENT 'Special handling, storage, and safety requirements specific to this grade (e.g., temperature control, moisture sensitivity, inert atmosphere, light protection). References Safety Data Sheet (SDS) and Process Safety Management (PSM) protocols.',
    `intended_use_description` STRING COMMENT 'Detailed description of the intended applications and use cases for this grade, including typical customer processes and end-product integration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product grade record was last updated. Used for change tracking and audit trail.',
    `lead_time_days` STRING COMMENT 'Standard production and delivery lead time in days for this grade, used for order promising and supply chain planning.',
    `maximum_impurity_ppm` DECIMAL(18,2) COMMENT 'Maximum allowable impurity concentration in parts per million (PPM) for this grade. Used in quality specifications and Certificate of Analysis (COA).',
    `minimum_order_quantity_kg` DECIMAL(18,2) COMMENT 'Minimum Order Quantity (MOQ) in kilograms for this grade, driven by production batch economics and packaging constraints.',
    `minimum_purity_percentage` DECIMAL(18,2) COMMENT 'Minimum chemical purity level required for this grade, expressed as a percentage (e.g., 99.50 for 99.5% purity). Critical for Quality Control (QC) and Certificate of Analysis (COA) compliance.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or comments related to this grade that do not fit in structured fields.',
    `packaging_configuration` STRING COMMENT 'Standard packaging options available for this grade (e.g., 25kg bags, 200L drums, 1000L IBC totes, bulk tanker). May list multiple configurations separated by semicolons.',
    `pricing_tier` STRING COMMENT 'Pricing tier classification for this grade, reflecting the quality level and market positioning. Higher purity and specialty grades typically command premium pricing.. Valid values are `standard|premium|ultra_premium|economy`',
    `reach_registered_flag` BOOLEAN COMMENT 'Indicates whether this grade is registered under the European REACH (Registration, Evaluation, Authorization and Restriction of Chemicals) regulation for sale in the EU.',
    `regulatory_classification` STRING COMMENT 'Primary regulatory classification or standard applicable to this grade (e.g., GMP-compliant, USP Grade, EP Grade, FCC Grade, ACS Reagent). May reference multiple standards separated by semicolons.',
    `shelf_life_months` STRING COMMENT 'Expected shelf life of this grade in months under proper storage conditions, used for inventory management (FEFO - First Expired First Out) and lot tracking.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum storage temperature in degrees Celsius required to maintain grade specifications and product stability.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum storage temperature in degrees Celsius required to maintain grade specifications and product stability.',
    `tsca_listed_flag` BOOLEAN COMMENT 'Indicates whether this grade is listed on the EPA TSCA (Toxic Substances Control Act) inventory for commercial use in the United States.',
    `usp_grade_flag` BOOLEAN COMMENT 'Indicates whether this grade meets United States Pharmacopeia (USP) monograph standards for pharmaceutical use.',
    CONSTRAINT pk_grade PRIMARY KEY(`grade_id`)
) COMMENT 'Defines the quality grades and purity tiers available for a chemical product (e.g., Technical Grade, Reagent Grade, Food Grade, Pharmaceutical Grade, Electronic Grade, Agricultural Grade). Captures grade code, grade name, grade description, minimum purity percentage, applicable regulatory standards (GMP, USP, EP, FCC), intended application sector, and grade-specific handling requirements. A single chemical product may have multiple grades, each with distinct specifications and pricing. Owned by the product domain as part of the product catalog.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`product_specification` (
    `product_specification_id` BIGINT COMMENT 'Unique identifier for the product specification record. Primary key for the product specification entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom this specification is defined. Nullable for standard specifications. Populated for customer-specific specifications that define unique quality requirements per contract or technical agreement.',
    `chemical_product_id` BIGINT COMMENT 'Reference to the chemical product, grade, or Stock Keeping Unit (SKU) that this specification applies to. Links to the product master catalog.',
    `superseded_specification_product_specification_id` BIGINT COMMENT 'Reference to the previous specification version that this version replaces. Nullable for initial specifications. Supports version history tracking and regulatory audit trail for specification changes.',
    `acceptance_criteria` STRING COMMENT 'Textual description of the acceptance rule for this parameter. Used for qualitative assessments or complex criteria that cannot be expressed as simple numeric ranges (e.g., clear colorless liquid, no visible particulates, conforms to reference standard).',
    `approval_authority` STRING COMMENT 'Role or individual responsible for approving this specification version. Typically Quality Assurance (QA) manager, regulatory affairs director, or technical director. Required for audit trail and compliance with Good Manufacturing Practice (GMP) and ISO 9001.',
    `approval_date` DATE COMMENT 'Date on which this specification version was formally approved. Establishes the audit trail for specification lifecycle management and supports Management of Change (MOC) processes.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this specification version. Captured for regulatory audit trail and compliance with Good Manufacturing Practice (GMP) documentation requirements.',
    `change_reason` STRING COMMENT 'Business justification for creating this specification version. Documents the reason for specification changes as required by Management of Change (MOC) processes. Examples include regulatory update, process improvement, customer requirement, Corrective and Preventive Action (CAPA) response.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this specification record was first created in the system. Supports audit trail and regulatory compliance with Good Manufacturing Practice (GMP) documentation requirements.',
    `criticality_level` STRING COMMENT 'Classification of the parameters importance to product quality and safety. Critical parameters directly impact safety or efficacy and trigger immediate batch rejection if Out of Specification (OOS). Major parameters affect product performance. Minor parameters are informational or aesthetic.. Valid values are `critical|major|minor`',
    `customer_specific_flag` BOOLEAN COMMENT 'Indicates whether this specification is tailored for a specific customer contract or represents the standard product specification. True if customer-specific, false if standard. Customer-specific specifications may have tighter limits or additional parameters.',
    `document_url` STRING COMMENT 'Link to the full specification document stored in the document management system. Provides access to detailed test procedures, sampling instructions, and supporting documentation.',
    `effective_date` DATE COMMENT 'Date from which this specification version becomes binding for quality control testing and release decisions. Used to determine which specification applies to a given production batch or lot.',
    `expiry_date` DATE COMMENT 'Date after which this specification version is no longer valid for new testing. Nullable for specifications with indefinite validity. Superseded specifications retain expiry date for audit purposes.',
    `ghs_classification_relevance` STRING COMMENT 'Describes how this specification parameter relates to Globally Harmonized System (GHS) hazard classification and Safety Data Sheet (SDS) content. For example, pH specifications may determine corrosivity classification; VOC content affects environmental hazard labeling.',
    `iso_standard_reference` STRING COMMENT 'Reference to the International Organization for Standardization (ISO) standard that governs this specification parameter or test method. Examples include ISO 9001 for quality management, ISO 14001 for environmental parameters, ISO 17025 for testing competence.',
    `last_modified_by` STRING COMMENT 'Identifier of the user who last modified this specification record. Required for audit trail and compliance with Good Manufacturing Practice (GMP) and 21 CFR Part 11 electronic records requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this specification record. Tracks changes for audit trail and supports Management of Change (MOC) processes.',
    `lims_test_code` STRING COMMENT 'Test code or identifier in the Laboratory Information Management System (LIMS) used to execute this specification parameter. Links this specification to LabWare LIMS for test execution, result capture, and Certificate of Analysis (COA) generation.',
    `maximum_value` DECIMAL(18,2) COMMENT 'Upper acceptance limit for the quality parameter. Test results above this value indicate Out of Specification (OOS) condition. Nullable for parameters with only lower limits.',
    `minimum_value` DECIMAL(18,2) COMMENT 'Lower acceptance limit for the quality parameter. Test results below this value indicate Out of Specification (OOS) condition. Nullable for parameters with only upper limits.',
    `notes` STRING COMMENT 'Additional comments, instructions, or context for this specification parameter. May include special handling instructions, historical context, or clarifications for laboratory technicians and Quality Control (QC) personnel.',
    `parameter_name` STRING COMMENT 'Name of the quality parameter being specified. Examples include assay, pH (Potential of Hydrogen), viscosity, moisture content, color, density, particle size, heavy metals concentration, residual solvents, Volatile Organic Compound (VOC) content, and other chemical or physical properties.',
    `reach_registration_relevance` STRING COMMENT 'Describes how this specification parameter supports Registration Evaluation Authorization and Restriction of Chemicals (REACH) registration and compliance. For example, impurity limits may be required to demonstrate substance identity and composition per REACH dossier.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this parameter is mandated by regulatory authorities such as Environmental Protection Agency (EPA), Occupational Safety and Health Administration (OSHA), Registration Evaluation Authorization and Restriction of Chemicals (REACH), Toxic Substances Control Act (TSCA), or Food and Drug Administration (FDA). True if regulatory-mandated, false if internal quality control only.',
    `sampling_plan` STRING COMMENT 'Description of the sampling strategy for this parameter. Defines sample size, sampling frequency, and sampling points (e.g., three samples from top, middle, bottom of batch, composite sample from each reactor vessel). Links to Good Manufacturing Practice (GMP) requirements.',
    `sds_section_reference` STRING COMMENT 'Reference to the section of the Safety Data Sheet (SDS) or Material Safety Data Sheet (MSDS) where this specification parameter is documented. Supports linkage between quality specifications and safety documentation.',
    `specification_number` STRING COMMENT 'Business identifier for the specification document. Externally-known unique code used in Certificate of Analysis (COA) and Certificate of Compliance (COC) generation.. Valid values are `^[A-Z0-9]{4,20}$`',
    `specification_status` STRING COMMENT 'Current lifecycle state of the specification. Active specifications are used for Certificate of Analysis (COA) generation and Quality Control (QC) release decisions. Superseded specifications are retained for audit trail.. Valid values are `draft|under-review|approved|active|superseded|obsolete`',
    `specification_type` STRING COMMENT 'Classification of the specification based on its purpose in the quality control lifecycle. Release specifications define final product acceptance criteria; in-process specifications govern intermediate checkpoints; shelf-life and stability specifications define storage and aging limits.. Valid values are `release|in-process|shelf-life|stability|raw-material|intermediate`',
    `target_value` DECIMAL(18,2) COMMENT 'Ideal or nominal value for the quality parameter. Used for Statistical Process Control (SPC) and process optimization. Nullable for parameters defined only by acceptance ranges.',
    `test_frequency` STRING COMMENT 'Frequency at which this parameter must be tested. Per-batch and per-lot testing occur for every production run. Periodic testing (daily, weekly, monthly) applies to stability and shelf-life specifications. On-demand testing is triggered by specific events or investigations. [ENUM-REF-CANDIDATE: per-batch|per-lot|daily|weekly|monthly|quarterly|annual|on-demand — 8 candidates stripped; promote to reference product]',
    `test_method_reference` STRING COMMENT 'Reference to the standardized or internal test method used to measure this parameter. May reference ASTM (American Society for Testing and Materials), ISO (International Organization for Standardization), USP (United States Pharmacopeia), or internal Standard Operating Procedure (SOP) codes.',
    `tsca_compliance_relevance` STRING COMMENT 'Describes how this specification parameter supports Toxic Substances Control Act (TSCA) compliance and reporting. For example, residual monomer content may be required for TSCA inventory listing or Chemical Data Reporting (CDR).',
    `unit_of_measure` STRING COMMENT 'Unit in which the parameter value is expressed. Examples include Parts Per Million (PPM), percent, pH units, centipoise (cP) for viscosity, grams per cubic centimeter (g/cm³) for density, microns for particle size. Must align with test method reference.',
    `version` STRING COMMENT 'Version number of the specification to support lifecycle changes and regulatory audit trail. Follows major.minor versioning convention.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    CONSTRAINT pk_product_specification PRIMARY KEY(`product_specification_id`)
) COMMENT 'Authoritative technical specification record for a chemical product, grade, or SKU, defining the quality parameters and acceptance criteria used in COA/COC generation and QC release. Captures specification version, effective date, expiry date, specification type (release, in-process, shelf-life, stability), parameter name (assay, pH, viscosity, moisture, color, density, particle size, heavy metals, residual solvents), test method reference (ASTM, ISO, USP, internal), minimum value, maximum value, target value, unit of measure, specification status, and approval authority. Versioned to support lifecycle changes and regulatory audit trail. Links to LabWare LIMS for test execution and to quality domain for COA generation.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`tds` (
    `tds_id` BIGINT COMMENT 'Unique identifier for the technical data sheet record. Primary key.',
    `chemical_product_id` BIGINT COMMENT 'Reference to the parent chemical product for which this TDS is published. Links to the chemical_product master data.',
    `appearance` STRING COMMENT 'Visual appearance characteristics of the product such as color, clarity, and texture. Aids in quality verification and customer identification.',
    `application_summary` STRING COMMENT 'Summary of recommended applications and use cases for the chemical product. Guides customers on appropriate usage scenarios.',
    `approved_by` STRING COMMENT 'Name or identifier of the technical authority who approved this TDS version for publication. Ensures technical accuracy and regulatory compliance.',
    `approved_date` DATE COMMENT 'Date on which this TDS version received final technical approval. Part of document control and audit trail.',
    `boiling_point_unit` STRING COMMENT 'Temperature unit for boiling point measurement, either Celsius or Fahrenheit.. Valid values are `°C|°F`',
    `boiling_point_value` DECIMAL(18,2) COMMENT 'Temperature at which the product transitions from liquid to vapor phase at standard atmospheric pressure. Important for process design and safety.',
    `compatibility_notes` STRING COMMENT 'Information on material compatibility and incompatibility with other chemicals, substrates, or container materials. Prevents adverse reactions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this TDS record was first created in the system. Part of audit trail for data governance.',
    `document_file_path` STRING COMMENT 'Internal file system or content management system path to the TDS document. Used for document retrieval and version control.',
    `document_number` STRING COMMENT 'Externally-known unique document number assigned to this TDS for customer and distributor reference. Follows company TDS numbering convention.. Valid values are `^TDS-[A-Z0-9]{6,12}$`',
    `document_url` STRING COMMENT 'Web URL or URI path to the published TDS document file (PDF or other format). Enables digital distribution and customer self-service access.. Valid values are `^https?://.*`',
    `effective_date` DATE COMMENT 'Date from which this TDS version becomes the authoritative technical reference for the product. Used to manage version transitions and customer communication.',
    `expiration_date` DATE COMMENT 'Date after which this TDS version is no longer valid and should not be referenced. Nullable for current versions without planned obsolescence.',
    `flash_point_unit` STRING COMMENT 'Temperature unit for flash point measurement, either Celsius or Fahrenheit.. Valid values are `°C|°F`',
    `flash_point_value` DECIMAL(18,2) COMMENT 'Lowest temperature at which vapors ignite when exposed to an ignition source. Critical safety parameter for flammable materials.',
    `handling_precautions` STRING COMMENT 'Safety precautions and best practices for handling the product including personal protective equipment (PPE) requirements and exposure controls.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which this TDS is published. Supports multi-language TDS distribution for global markets.. Valid values are `^[A-Z]{2}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this TDS record was last modified. Tracks data currency and supports change detection.',
    `odor` STRING COMMENT 'Characteristic odor or scent of the chemical product. Important for safety identification and customer expectations.',
    `performance_data_reference` STRING COMMENT 'Reference to supporting performance test data, technical bulletins, or case studies that demonstrate product efficacy and application results.',
    `ph_value` DECIMAL(18,2) COMMENT 'Measured pH value of the product indicating acidity or alkalinity. Critical chemical property for application compatibility and safety.',
    `physical_form` STRING COMMENT 'Physical state or form of the chemical product at standard conditions. Critical for handling and storage guidance. [ENUM-REF-CANDIDATE: liquid|solid|powder|granular|paste|gel|gas|emulsion|suspension — 9 candidates stripped; promote to reference product]',
    `product_description` STRING COMMENT 'Detailed narrative description of the chemical product, its composition, and key characteristics as presented to customers in the TDS.',
    `recommended_use_concentration` STRING COMMENT 'Guidance on typical or recommended concentration ranges for product application. May include dilution ratios or usage rates.',
    `regulatory_compliance_notes` STRING COMMENT 'Summary of key regulatory compliance information including REACH registration status, TSCA listing, FDA approvals, and other jurisdiction-specific clearances.',
    `revision_notes` STRING COMMENT 'Summary of changes made in this TDS version compared to the previous version. Supports change management and customer communication.',
    `sds_document_number` STRING COMMENT 'Reference to the associated Safety Data Sheet document number. Links TDS to the corresponding SDS for comprehensive safety information.. Valid values are `^SDS-[A-Z0-9]{6,12}$`',
    `solubility_description` STRING COMMENT 'Description of product solubility characteristics in various solvents (water, organic solvents). Guides formulation and application decisions.',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Ratio of product density to water density at specified temperature. Used for volume-to-weight conversions and quality control.',
    `storage_conditions` STRING COMMENT 'Recommended storage conditions including temperature range, humidity control, and container requirements to maintain product quality and safety.',
    `tds_status` STRING COMMENT 'Current lifecycle state of the TDS document. Controls visibility and usage in customer-facing channels.. Valid values are `draft|under_review|approved|published|superseded|obsolete`',
    `version_number` STRING COMMENT 'Version identifier for this TDS document. Incremented with each revision to track document evolution and ensure customers reference the correct edition.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `viscosity_unit` STRING COMMENT 'Unit of measure for the viscosity value. Common units include centipoise (cP), centistokes (cSt), and Pascal-seconds.. Valid values are `cP|cSt|mPa·s|Pa·s`',
    `viscosity_value` DECIMAL(18,2) COMMENT 'Measured viscosity of the product indicating flow resistance. Critical for processing, pumping, and application equipment selection.',
    CONSTRAINT pk_tds PRIMARY KEY(`tds_id`)
) COMMENT 'Technical Data Sheet (TDS) document record for a chemical product, capturing the authoritative technical and application information published to customers and distributors. Stores TDS document number, version, effective date, language, product applications, physical and chemical properties summary, handling and storage guidance, recommended use concentrations, compatibility notes, performance data references, and document URL/path. Versioned and linked to the parent chemical_product. Supports customer technical sales and regulatory submissions.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`sds` (
    `sds_id` BIGINT COMMENT 'Unique identifier for the Safety Data Sheet record. Primary key for the SDS master data.',
    `chemical_product_id` BIGINT COMMENT 'Reference to the chemical product for which this SDS is issued. Links to the product master catalog.',
    `accidental_release_measures` STRING COMMENT 'Personal precautions, protective equipment, emergency procedures, and methods for containment and cleanup of spills or leaks, as per GHS Section 6.',
    `approval_date` DATE COMMENT 'Date when this SDS was formally approved for distribution and use.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or authority who approved this SDS for release.',
    `boiling_point_c` DECIMAL(18,2) COMMENT 'Temperature at which the substance transitions from liquid to gas at standard atmospheric pressure, measured in degrees Celsius.',
    `california_prop65_listed` BOOLEAN COMMENT 'Indicates whether the chemical is listed under California Proposition 65 as known to cause cancer, birth defects, or reproductive harm.',
    `cas_number` STRING COMMENT 'CAS Registry Number uniquely identifying the chemical substance. Format: XXXXXX-XX-X. May be a primary CAS or mixture identifier.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `color` STRING COMMENT 'Visual color or appearance of the chemical product.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the jurisdiction to which this SDS applies (e.g., USA, DEU, GBR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDS record was first created in the system.',
    `disposal_considerations` STRING COMMENT 'Recommended methods for safe disposal of the substance and contaminated packaging, including waste treatment methods and applicable regulations, as per GHS Section 13.',
    `document_number` STRING COMMENT 'Externally-known unique document number for the SDS, used for regulatory filing and customer reference. Format: SDS-XXXXXX.. Valid values are `^SDS-[A-Z0-9]{6,12}$`',
    `document_status` STRING COMMENT 'Current lifecycle status of the SDS document: Draft (under preparation), Active (current official version), Superseded (replaced by newer version), Archived (historical record).. Valid values are `Draft|Active|Superseded|Archived`',
    `document_url` STRING COMMENT 'URL or file path to the full PDF or electronic version of the SDS document stored in the document management system.',
    `dot_hazard_class` STRING COMMENT 'US DOT hazard class for transportation of dangerous goods (e.g., Class 3 Flammable Liquid, Class 8 Corrosive).',
    `dot_packing_group` STRING COMMENT 'DOT packing group indicating the degree of danger: I (high danger), II (medium danger), III (low danger).. Valid values are `I|II|III`',
    `dot_un_number` STRING COMMENT 'Four-digit UN number assigned to the substance for international transport of dangerous goods. Format: UNXXXX.. Valid values are `^UN[0-9]{4}$`',
    `ec_number` STRING COMMENT 'EC Number (EINECS, ELINCS, or NLP) assigned by the European Chemicals Agency for substance identification under REACH. Format: XXX-XXX-X.. Valid values are `^[0-9]{3}-[0-9]{3}-[0-9]$`',
    `ecological_information` STRING COMMENT 'Environmental impact data including aquatic toxicity (LC50, EC50), persistence and degradability, bioaccumulative potential, and mobility in soil, as per GHS Section 12.',
    `effective_date` DATE COMMENT 'Date from which this SDS revision becomes the official version for regulatory and operational use.',
    `exposure_limits` STRING COMMENT 'Occupational exposure limits including OSHA PEL (Permissible Exposure Limit), ACGIH TLV (Threshold Limit Value), and other applicable exposure standards, as per GHS Section 8.',
    `firefighting_measures` STRING COMMENT 'Suitable extinguishing media, unsuitable extinguishing media, and special hazards arising from the substance or mixture during fire, as per GHS Section 5.',
    `first_aid_measures` STRING COMMENT 'Summary of first aid instructions for exposure routes (inhalation, skin contact, eye contact, ingestion) as per GHS Section 4.',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Lowest temperature at which vapors of the substance will ignite when exposed to an ignition source, measured in degrees Celsius. Critical for flammability classification.',
    `ghs_classification` STRING COMMENT 'Complete GHS hazard classification string for the chemical product, including hazard classes and categories (e.g., Flam. Liq. 2, Acute Tox. 3, Skin Corr. 1B).',
    `handling_precautions` STRING COMMENT 'Safe handling advice including measures to prevent fire, explosion, and exposure, as per GHS Section 7.',
    `hazard_statements` STRING COMMENT 'Comma-separated list of GHS hazard statement codes (H-codes) describing the nature of the hazards (e.g., H225, H302, H314, H400).',
    `iata_shipping_name` STRING COMMENT 'Proper shipping name for air transport as per IATA Dangerous Goods Regulations.',
    `imdg_shipping_name` STRING COMMENT 'Proper shipping name for sea transport as per IMDG Code.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the SDS is written (e.g., EN, DE, FR, ES).. Valid values are `^[A-Z]{2}$`',
    `melting_point_c` DECIMAL(18,2) COMMENT 'Temperature at which the substance transitions from solid to liquid at standard atmospheric pressure, measured in degrees Celsius.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDS record was last modified in the system.',
    `odor` STRING COMMENT 'Characteristic odor of the chemical product (e.g., pungent, sweet, odorless).',
    `ph_value` DECIMAL(18,2) COMMENT 'pH value of the chemical product or its aqueous solution, indicating acidity or alkalinity. Range: 0.00 to 14.00.',
    `physical_state` STRING COMMENT 'Physical form of the chemical product at ambient conditions (e.g., solid, liquid, gas, powder).. Valid values are `Solid|Liquid|Gas|Powder|Granular|Paste`',
    `pictogram_codes` STRING COMMENT 'Comma-separated list of GHS pictogram codes representing hazard symbols (e.g., GHS02 Flame, GHS05 Corrosion, GHS07 Exclamation Mark, GHS09 Environment).',
    `ppe_requirements` STRING COMMENT 'Recommended personal protective equipment for handling the substance, including respiratory protection, hand protection, eye protection, and skin protection, as per GHS Section 8.',
    `precautionary_statements` STRING COMMENT 'Comma-separated list of GHS precautionary statement codes (P-codes) describing recommended measures to minimize or prevent adverse effects (e.g., P210, P280, P305+P351+P338).',
    `prepared_by` STRING COMMENT 'Name or identifier of the person or department responsible for preparing or updating this SDS.',
    `reach_registration_number` STRING COMMENT 'REACH registration number issued by ECHA for substances manufactured or imported in the EU in quantities of 1 tonne or more per year.',
    `regulatory_information` STRING COMMENT 'Additional regulatory information including national and regional regulations (TSCA, REACH, DSL, ENCS, IECSC, KECL, PICCS, AICS) and safety, health, and environmental regulations, as per GHS Section 15.',
    `revision_date` DATE COMMENT 'Date when this revision of the SDS was issued or last updated. Critical for regulatory compliance and version control.',
    `revision_number` STRING COMMENT 'Sequential revision number of the SDS document. Increments with each update to the safety data sheet.',
    `sara_313_reportable` BOOLEAN COMMENT 'Indicates whether the chemical is subject to SARA Title III Section 313 Toxics Release Inventory (TRI) reporting requirements.',
    `signal_word` STRING COMMENT 'GHS signal word indicating the severity level of the hazard: Danger (more severe) or Warning (less severe).. Valid values are `Danger|Warning`',
    `solubility_in_water` STRING COMMENT 'Description of the substances solubility in water (e.g., soluble, insoluble, partially soluble, miscible) and quantitative data if available.',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Ratio of the density of the substance to the density of water at a specified temperature. Dimensionless value.',
    `storage_requirements` STRING COMMENT 'Conditions for safe storage including incompatibilities, temperature limits, ventilation, and container specifications, as per GHS Section 7.',
    `supersedes_date` DATE COMMENT 'Date of the previous SDS version that this revision replaces. Used for audit trail and version history.',
    `toxicological_information` STRING COMMENT 'Summary of toxicological data including acute toxicity (LD50, LC50), skin corrosion/irritation, eye damage/irritation, sensitization, mutagenicity, carcinogenicity, reproductive toxicity, and target organ effects, as per GHS Section 11.',
    `tsca_status` STRING COMMENT 'Regulatory status of the chemical substance under the US EPA TSCA Inventory. Indicates whether the substance is listed, exempt, or requires notification.. Valid values are `Listed|Exempt|Not Listed|Pending`',
    `vapor_pressure_mmhg` DECIMAL(18,2) COMMENT 'Pressure exerted by the vapor of the substance in equilibrium with its liquid or solid form at a given temperature, measured in millimeters of mercury (mmHg).',
    `voc_content_percent` DECIMAL(18,2) COMMENT 'Percentage by weight of volatile organic compounds in the product. Critical for environmental and air quality regulations.',
    CONSTRAINT pk_sds PRIMARY KEY(`sds_id`)
) COMMENT 'Safety Data Sheet (SDS/MSDS) master record for a chemical product, compliant with GHS/OSHA HazCom 2012 and REACH Article 31. Captures SDS document number, revision number, revision date, GHS hazard classification, signal word (Danger/Warning), hazard statements (H-codes), precautionary statements (P-codes), pictogram codes, first aid measures, firefighting measures, accidental release measures, handling and storage requirements, exposure controls/PPE, physical and chemical properties, toxicological information, ecological information, disposal considerations, transport information (DOT, IATA, IMDG), regulatory information (TSCA, REACH, SARA 313), and SDS language/country. System of record: Intelex EHS Management.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` (
    `product_ghs_classification_id` BIGINT COMMENT 'Unique identifier for the GHS classification record.',
    `chemical_product_id` BIGINT COMMENT 'Reference to the chemical product being classified under GHS.',
    `sds_id` BIGINT COMMENT 'Reference identifier linking this classification to the corresponding Safety Data Sheet document in the document management system.',
    `superseded_by_classification_product_ghs_classification_id` BIGINT COMMENT 'Reference to the newer GHS classification record that supersedes this one, enabling classification version history tracking.',
    `cas_number` STRING COMMENT 'CAS Registry Number uniquely identifying the chemical substance (e.g., 67-64-1 for acetone).',
    `classification_authority` STRING COMMENT 'Entity responsible for the classification: self-classification by manufacturer, ECHA harmonized classification, competent authority, or third-party assessor.. Valid values are `self_classification|echa_harmonized|competent_authority|third_party`',
    `classification_basis` STRING COMMENT 'Methodology or data source used to determine the classification: experimental test data, read-across from analogous substances, QSAR (Quantitative Structure-Activity Relationship) modeling, expert judgment, literature review, or bridging principles.. Valid values are `test_data|read_across|qsar|expert_judgment|literature_review|bridging`',
    `classification_date` DATE COMMENT 'Date when the GHS classification was performed or last updated.',
    `classification_notes` STRING COMMENT 'Free-text notes providing additional context, rationale, or special considerations for the classification decision.',
    `classification_status` STRING COMMENT 'Current lifecycle status of the GHS classification record.. Valid values are `draft|active|superseded|under_review|withdrawn`',
    `classification_version` STRING COMMENT 'Version number of the GHS classification (e.g., GHS Rev 7, GHS Rev 8) indicating which revision of the Globally Harmonized System was applied.',
    `classifier_name` STRING COMMENT 'Name of the individual or team responsible for performing the GHS classification.',
    `clp_notification_number` STRING COMMENT 'Notification number assigned by ECHA for substances notified under the CLP Regulation.',
    `cmr_classification` STRING COMMENT 'Specific CMR classification categories if applicable (e.g., Carc. 1A, Muta. 1B, Repr. 2), indicating carcinogenic, mutagenic, or reproductive toxicity hazards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this GHS classification record was first created in the system.',
    `ec_number` STRING COMMENT 'European Community number (EINECS, ELINCS, or NLP number) identifying the substance in the EU.',
    `effective_from_date` DATE COMMENT 'Date from which this GHS classification becomes effective and must be used for labeling and SDS purposes.',
    `effective_until_date` DATE COMMENT 'Date until which this GHS classification remains valid; nullable for current active classifications.',
    `environmental_hazard_categories` STRING COMMENT 'Comma-separated list of environmental hazard categories corresponding to the classes (e.g., Acute 1, Chronic 2, Chronic 3).',
    `environmental_hazard_classes` STRING COMMENT 'Comma-separated list of environmental hazard classes assigned (e.g., Hazardous to the Aquatic Environment, Hazardous to the Ozone Layer).',
    `hazard_statement_codes` STRING COMMENT 'Comma-separated list of GHS hazard statement codes (e.g., H225, H302, H315, H319, H411) describing the nature and severity of hazards.',
    `health_hazard_categories` STRING COMMENT 'Comma-separated list of health hazard categories corresponding to the classes (e.g., Category 1, Category 2, Category 1A, Category 1B).',
    `health_hazard_classes` STRING COMMENT 'Comma-separated list of health hazard classes assigned (e.g., Acute Toxicity, Skin Corrosion, Carcinogenicity, Reproductive Toxicity, Respiratory Sensitization).',
    `label_generation_required` BOOLEAN COMMENT 'Boolean flag indicating whether a GHS-compliant label must be generated for this classification.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this GHS classification record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the GHS classification to ensure ongoing compliance.',
    `physical_hazard_categories` STRING COMMENT 'Comma-separated list of physical hazard categories corresponding to the classes (e.g., Category 2, Category 1A, Category 3).',
    `physical_hazard_classes` STRING COMMENT 'Comma-separated list of physical hazard classes assigned (e.g., Flammable Liquids, Explosives, Oxidizing Liquids, Corrosive to Metals).',
    `pictogram_codes` STRING COMMENT 'Comma-separated list of GHS pictogram codes (e.g., GHS01, GHS02, GHS05, GHS07, GHS09) representing the hazard symbols required on labels.',
    `precautionary_statement_codes` STRING COMMENT 'Comma-separated list of GHS precautionary statement codes (e.g., P210, P280, P301+P312, P501) describing recommended measures to minimize or prevent adverse effects.',
    `reach_registration_number` STRING COMMENT 'REACH registration number if the substance is registered under REACH regulation, linking the classification to the REACH dossier.',
    `regulatory_region` STRING COMMENT 'Geographic region or jurisdiction for which this classification applies (e.g., EU, USA, Canada, China, Australia), as GHS implementation may vary by region.',
    `review_date` DATE COMMENT 'Date when the GHS classification was last reviewed for accuracy and regulatory compliance.',
    `reviewer_name` STRING COMMENT 'Name of the individual or team who reviewed and approved the GHS classification.',
    `signal_word` STRING COMMENT 'GHS signal word indicating the relative level of severity of hazard: Danger (more severe), Warning (less severe), or None.. Valid values are `danger|warning|none`',
    `source_system` STRING COMMENT 'Name of the source system from which this classification record originated (e.g., Intelex EHS, SAP EHS, LIMS).',
    `test_data_reference` STRING COMMENT 'Reference to the specific test reports, study numbers, or LIMS records that support the classification (e.g., study IDs, OECD guideline numbers).',
    `tsca_inventory_status` STRING COMMENT 'Status of the substance on the TSCA Chemical Substance Inventory: active (commercial use), inactive (no current commercial use), or not listed.. Valid values are `active|inactive|not_listed`',
    CONSTRAINT pk_product_ghs_classification PRIMARY KEY(`product_ghs_classification_id`)
) COMMENT 'GHS (Globally Harmonized System) hazard classification record for a chemical product, capturing the official classification outcome per GHS/CLP regulation. Stores classification version, classification date, classifying authority (self-classification, ECHA harmonized), physical hazard classes and categories (flammable liquid Cat 2, explosive, oxidizer), health hazard classes (acute toxicity, skin corrosion, CMR categories), environmental hazard classes (aquatic toxicity), hazard statement codes, precautionary statement codes, signal word, pictogram list, and classification basis (test data, read-across, QSAR). Supports REACH, CLP, and GHS label generation. Linked to Intelex EHS.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` (
    `regulatory_status_id` BIGINT COMMENT 'Unique identifier for the regulatory compliance status record.',
    `chemical_product_id` BIGINT COMMENT 'Reference to the chemical product subject to this regulatory status record.',
    `approval_date` DATE COMMENT 'Date when the regulatory authority officially approved or accepted the registration or notification.',
    `authorization_expiry_date` DATE COMMENT 'Date when the granted authorization expires and renewal application is required.',
    `authorization_number` STRING COMMENT 'Authorization number granted by the regulatory authority for continued use of a restricted or SVHC substance under specific conditions.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance described in the open scientific literature. Format: XXXXXX-XX-X.. Valid values are `^d{2,7}-d{2}-d$`',
    `comments` STRING COMMENT 'Additional notes, clarifications, or context regarding this regulatory status record, including any special conditions or pending actions.',
    `compliance_status` STRING COMMENT 'Current compliance state of the product under the specified regulation and jurisdiction. Registered (fully compliant and registered), Notified (notification submitted), Exempt (exemption granted), Restricted (use restrictions apply), Prohibited (banned), Pending (application in progress).. Valid values are `REGISTERED|NOTIFIED|EXEMPT|RESTRICTED|PROHIBITED|PENDING`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory status record was first created in the system.',
    `ec_number` STRING COMMENT 'Seven-digit identifier assigned to chemical substances for regulatory purposes within the European Union. Format: XXX-XXX-X.. Valid values are `^d{3}-d{3}-d$`',
    `ghs_classification` STRING COMMENT 'GHS hazard classification codes assigned to this substance (e.g., H302, H315, H319). Multiple codes may be listed separated by commas.',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction or regulatory region where this compliance status applies. USA (United States), EUR (European Union), CHN (China), JPN (Japan), KOR (South Korea), CAN (Canada).. Valid values are `USA|EUR|CHN|JPN|KOR|CAN`',
    `last_review_date` DATE COMMENT 'Date when this regulatory status record was last reviewed and verified for accuracy and currency.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory status record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this regulatory status record to ensure ongoing compliance.',
    `pfas_flag` BOOLEAN COMMENT 'Indicates whether this product contains PFAS (per- and polyfluoroalkyl substances), subject to emerging regulatory restrictions.',
    `pmn_number` STRING COMMENT 'EPA-assigned number for a Pre-Manufacture Notice submitted for a new chemical substance not on the TSCA Inventory.',
    `prop_65_listing_flag` BOOLEAN COMMENT 'Indicates whether this substance is listed under California Proposition 65 as known to cause cancer, birth defects, or reproductive harm.',
    `reach_registration_type` STRING COMMENT 'Type of REACH registration dossier submitted. Full (standard registration), Intermediate (on-site or transported isolated intermediate), Transported Isolated (intermediate transported between sites), Not Applicable (non-REACH regulation).. Valid values are `FULL|INTERMEDIATE|TRANSPORTED_ISOLATED|NOT_APPLICABLE`',
    `registration_date` DATE COMMENT 'Date when the product was officially registered or notified under the applicable regulatory framework.',
    `registration_expiry_date` DATE COMMENT 'Date when the current registration expires and renewal or re-notification is required. Nullable for regulations without expiry.',
    `registration_number` STRING COMMENT 'Official registration or notification number issued by the regulatory authority for this product under the specified regulation.',
    `regulation_type` STRING COMMENT 'Type of regulatory framework applicable to this product. REACH (Registration Evaluation Authorization and Restriction of Chemicals), TSCA (Toxic Substances Control Act), SARA 313 (Superfund Amendments and Reauthorization Act Section 313), Prop 65 (California Proposition 65), RoHS (Restriction of Hazardous Substances), SVHC (Substance of Very High Concern).. Valid values are `REACH|TSCA|SARA_313|PROP_65|ROHS|SVHC`',
    `regulatory_authority` STRING COMMENT 'Name of the government agency or regulatory body that issued or oversees this compliance status (e.g., EPA, ECHA, METI, MEE).',
    `responsible_party_email` STRING COMMENT 'Email address of the responsible party for regulatory compliance inquiries and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_party_name` STRING COMMENT 'Name of the individual or organizational unit responsible for maintaining this regulatory status record and ensuring ongoing compliance.',
    `restriction_conditions` STRING COMMENT 'Detailed description of any restrictions, limitations, or special conditions imposed on the manufacture, import, use, or sale of this product under the applicable regulation.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates whether this product complies with RoHS Directive restrictions on hazardous substances in electrical and electronic equipment.',
    `sara_313_reportable_flag` BOOLEAN COMMENT 'Indicates whether this substance is subject to SARA Section 313 Toxics Release Inventory (TRI) reporting requirements.',
    `submission_date` DATE COMMENT 'Date when the registration, notification, or compliance dossier was submitted to the regulatory authority.',
    `substance_role` STRING COMMENT 'Role of the organization in the supply chain for this substance under the regulatory framework. Manufacturer (produces the substance), Importer (imports into jurisdiction), Only Representative (non-EU manufacturer representative), Downstream User (uses the substance in formulations).. Valid values are `MANUFACTURER|IMPORTER|ONLY_REPRESENTATIVE|DOWNSTREAM_USER`',
    `svhc_candidate_list_flag` BOOLEAN COMMENT 'Indicates whether this substance is included on the ECHA Candidate List of Substances of Very High Concern for potential authorization under REACH.',
    `tonnage_band` STRING COMMENT 'Annual production or import volume band for REACH registration purposes, measured in metric tonnes per year. Categories: 1-10 tonnes, 10-100 tonnes, 100-1000 tonnes, over 1000 tonnes, or not applicable for non-REACH regulations.. Valid values are `1_TO_10|10_TO_100|100_TO_1000|OVER_1000|NOT_APPLICABLE`',
    `tsca_inventory_status` STRING COMMENT 'Status of the substance on the EPA TSCA Chemical Substance Inventory. Active (commercially active), Inactive (not currently manufactured or imported), Not on Inventory (requires PMN), Not Applicable (non-US regulation).. Valid values are `ACTIVE|INACTIVE|NOT_ON_INVENTORY|NOT_APPLICABLE`',
    CONSTRAINT pk_regulatory_status PRIMARY KEY(`regulatory_status_id`)
) COMMENT 'Regulatory compliance status record for a chemical product across applicable regulatory frameworks and jurisdictions. Captures regulation type (REACH, TSCA, SARA 313, California Prop 65, RoHS, SVHC, PFAS), jurisdiction (EU, US, China, Japan, Korea, Canada), registration or notification number, registration date, registration expiry, tonnage band (for REACH), substance role (manufacturer, importer, only representative), compliance status (registered, notified, exempt, restricted, prohibited), restriction conditions, and last review date. Enables regulatory reporting to EPA, ECHA, and ACC Responsible Care. System of record: Intelex EHS Management.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`hierarchy` (
    `hierarchy_id` BIGINT COMMENT 'Unique identifier for the product hierarchy node. Primary key for the product hierarchy entity.',
    `parent_node_hierarchy_id` BIGINT COMMENT 'Reference to the parent node in the hierarchy structure. Null for top-level division nodes. Enables recursive hierarchy traversal and roll-up aggregations for EBITDA reporting and sales analytics.',
    `application_category` STRING COMMENT 'Primary end-use application or industry segment for products in this node. Examples: Automotive Coatings, Construction Materials, Electronics Manufacturing, Consumer Goods, Agriculture Crop Protection. Supports market segmentation and application-based analytics.',
    `approval_status` STRING COMMENT 'Workflow approval status for hierarchy changes. Draft: under construction. Pending Approval: submitted for review. Approved: active and released. Rejected: change request denied. Supports Management of Change (MOC) processes.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this hierarchy node or hierarchy change. Used for accountability and compliance with MOC procedures.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this hierarchy node or change was approved. Used for audit trail and MOC compliance reporting.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit responsible for this product hierarchy node. Used for P&L reporting, EBITDA analysis by business unit, and organizational accountability.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this hierarchy node record was first created in the system. Used for audit trail, data lineage, and compliance reporting.',
    `distribution_channel` STRING COMMENT 'SAP S/4HANA distribution channel code for products in this node. Examples: 10=Direct Sales, 20=Distributor, 30=E-Commerce. Supports channel-specific pricing and analytics.. Valid values are `^[A-Z0-9]{2}$`',
    `division_code` STRING COMMENT 'Code identifying the top-level division. Examples: PERF (Performance Materials), AGRI (Agricultural Solutions), SPEC (Specialty Chemicals). Used for executive-level portfolio reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `ebitda_reporting_flag` BOOLEAN COMMENT 'Indicates whether this hierarchy node is used for EBITDA reporting and financial performance tracking. True for nodes that represent P&L responsibility centers.',
    `effective_end_date` DATE COMMENT 'Date when this hierarchy node is no longer active for new product assignments. Null for open-ended nodes. Historical products retain their classification for reporting continuity.',
    `effective_start_date` DATE COMMENT 'Date when this hierarchy node becomes active and available for product classification. Supports time-based hierarchy changes for organizational restructuring and portfolio realignment.',
    `external_hierarchy_code` STRING COMMENT 'External system or customer-facing hierarchy code used for EDI transactions, customer portals, or third-party integrations. May differ from internal SAP codes.',
    `ghs_hazard_category` STRING COMMENT 'Predominant GHS hazard classification for products in this hierarchy node. Used for safety reporting, hazmat storage planning, and EHS compliance. Examples: Flammable Liquids Category 2, Acute Toxicity Category 3, Corrosive to Metals.',
    `hierarchy_level` STRING COMMENT 'Numeric level of the node within the hierarchy structure. Typically: 1=Division, 2=Business Unit, 3=Product Family, 4=Product Line, 5=Product Group. Supports drill-down analytics and aggregation logic.',
    `hierarchy_type` STRING COMMENT 'Classification of the hierarchy purpose. Commercial: sales and EBITDA reporting. Technical: product formulation and R&D. Regulatory: TSCA, REACH, GHS grouping. Application: end-use industry segmentation. Geographic: regional product portfolio management.. Valid values are `commercial|technical|regulatory|application|geographic`',
    `is_leaf_node` BOOLEAN COMMENT 'Indicates whether this node is a leaf node (has no children) in the hierarchy. True for the lowest level nodes where individual SKUs are assigned. Used for validation and hierarchy integrity checks.',
    `legacy_hierarchy_code` STRING COMMENT 'Historical product hierarchy code from legacy ERP systems prior to SAP S/4HANA implementation. Retained for data lineage, historical reporting, and migration traceability.',
    `level_name` STRING COMMENT 'Descriptive name of the hierarchy level. Standard values: division, business_unit, product_family, product_line, product_group, sub_group. Used for reporting labels and user interface display.. Valid values are `division|business_unit|product_family|product_line|product_group|sub_group`',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this hierarchy node record. Used for change tracking and data governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this hierarchy node record was last modified. Used for audit trail, change tracking, and data synchronization.',
    `node_code` STRING COMMENT 'Business identifier code for the hierarchy node. Used in SAP S/4HANA product hierarchy configuration and external reporting systems. Alphanumeric code uniquely identifying the node within the hierarchy structure.. Valid values are `^[A-Z0-9]{4,20}$`',
    `node_depth` STRING COMMENT 'Calculated depth of the node from the root of the hierarchy tree. Root nodes have depth 0. Used for hierarchy traversal algorithms and reporting level filtering.',
    `node_description` STRING COMMENT 'Detailed description of the hierarchy node including scope, product categories included, and business purpose. Provides context for classification decisions and portfolio management.',
    `node_name` STRING COMMENT 'Human-readable name of the hierarchy node. Used for display in reports, dashboards, and user interfaces. Examples: Performance Materials, Agricultural Solutions, Specialty Chemicals, Industrial Polymers.',
    `node_status` STRING COMMENT 'Current lifecycle status of the hierarchy node. Active: in use for classification and reporting. Inactive: temporarily disabled. Pending: awaiting approval. Deprecated: scheduled for retirement. Archived: historical reference only.. Valid values are `active|inactive|pending|deprecated|archived`',
    `notes` STRING COMMENT 'Free-text notes and comments about the hierarchy node. Used for documenting classification decisions, special handling instructions, or historical context.',
    `path` STRING COMMENT 'Full path from root to this node using node codes separated by forward slashes. Example: DIV01/BU05/FAM12/LINE34. Enables fast ancestor/descendant queries and breadcrumb navigation.',
    `product_family_code` STRING COMMENT 'Code identifying the product family within the business unit. Groups related product lines with similar chemistry, applications, or market segments.. Valid values are `^[A-Z0-9]{2,10}$`',
    `product_line_manager` STRING COMMENT 'Name of the product line manager or business owner responsible for this hierarchy node. Used for accountability, approval workflows, and organizational reporting.',
    `regulatory_classification` STRING COMMENT 'Primary regulatory status category for products in this hierarchy node. Used for TSCA submissions, REACH compliance reporting, and regulatory grouping. Supports filtering for regulatory audits and compliance analytics.. Valid values are `tsca_listed|reach_registered|ghs_classified|fda_approved|epa_registered|not_regulated`',
    `sales_organization` STRING COMMENT 'SAP S/4HANA sales organization code responsible for products in this hierarchy node. Used for sales analytics, commission calculations, and regional performance reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `sap_product_hierarchy_code` STRING COMMENT '18-character SAP S/4HANA product hierarchy code (PRODH field). Concatenated representation of the full hierarchy path used in SAP MM and SD modules for material grouping and sales reporting.. Valid values are `^[A-Z0-9]{18}$`',
    `sort_sequence` STRING COMMENT 'Numeric value controlling the display order of sibling nodes within the same parent. Lower values appear first. Used for consistent presentation in reports and user interfaces.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this hierarchy node record in SAP S/4HANA. Used for audit trail and data governance.',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Multi-level product classification hierarchy for commercial reporting, portfolio management, and SAP material grouping. Captures hierarchy node code, node name, hierarchy level (division > business unit > product family > product line > product group), parent node reference, hierarchy type (commercial, technical, regulatory), effective date, and node status. Supports EBITDA reporting by product line, sales analytics by business unit, regulatory grouping for TSCA/REACH submissions, and product application categorization. Managed in SAP S/4HANA product hierarchy configuration.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`packaging_config` (
    `packaging_config_id` BIGINT COMMENT 'Unique identifier for the packaging configuration record. Primary key.',
    `chemical_product_id` BIGINT COMMENT 'Reference to the chemical product or SKU (Stock Keeping Unit) that this packaging configuration applies to.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the nominal capacity. Common units include L (liters), GAL (gallons), M3 (cubic meters), KG (kilograms), LB (pounds).. Valid values are `L|GAL|M3|KG|LB`',
    `closure_type` STRING COMMENT 'Type of closure or sealing mechanism used on the packaging container (e.g., screw cap, bung, valve, crimp seal, tamper-evident seal).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging configuration record was first created in the system.',
    `customer_specific_flag` BOOLEAN COMMENT 'Indicates whether this packaging configuration is designed for a specific customer or customer segment with unique packaging requirements.',
    `dot_label_required` BOOLEAN COMMENT 'Indicates whether DOT hazardous materials transportation labels are required on this packaging configuration.',
    `effective_end_date` DATE COMMENT 'Date when this packaging configuration is no longer effective and should not be used for new orders. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this packaging configuration becomes effective and available for use in order fulfillment and warehouse operations.',
    `fill_volume_liters` DECIMAL(18,2) COMMENT 'Maximum fill volume of the chemical product in liters that can be loaded into this packaging configuration.',
    `fill_weight_kg` DECIMAL(18,2) COMMENT 'Maximum fill weight of the chemical product in kilograms that can be loaded into this packaging configuration.',
    `food_grade_certified_flag` BOOLEAN COMMENT 'Indicates whether this packaging configuration is certified for food-contact chemicals and meets FDA (Food and Drug Administration) food-grade requirements.',
    `ghs_label_required` BOOLEAN COMMENT 'Indicates whether GHS hazard communication labels are required on this packaging configuration.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight in kilograms of the packaging configuration when filled, including product, container, and closure. Used for transportation and logistics planning.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether this packaging configuration is certified for transporting hazardous materials under DOT, IATA, and IMDG regulations.',
    `height_mm` DECIMAL(18,2) COMMENT 'Height of the packaging container in millimeters. Used for warehouse slotting, stacking calculations, and transportation planning.',
    `iata_label_required` BOOLEAN COMMENT 'Indicates whether IATA dangerous goods air transport labels are required on this packaging configuration.',
    `imdg_label_required` BOOLEAN COMMENT 'Indicates whether IMDG Code maritime transport labels are required on this packaging configuration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging configuration record was last modified or updated.',
    `length_mm` DECIMAL(18,2) COMMENT 'Length of rectangular packaging (IBCs, totes, boxes) in millimeters. Used for warehouse slotting and transportation planning.',
    `material_of_construction` STRING COMMENT 'Material used to construct the packaging container. Options include HDPE (High-Density Polyethylene), steel, stainless steel, fiber, aluminum, and lined containers.. Valid values are `hdpe|steel|stainless_steel|fiber|aluminum|lined`',
    `nominal_capacity` DECIMAL(18,2) COMMENT 'Nominal or rated capacity of the packaging container, expressed in the unit specified by capacity_unit_of_measure.',
    `notes` STRING COMMENT 'Free-text notes providing additional information about the packaging configuration, including special handling instructions, compatibility notes, or regulatory remarks.',
    `outer_diameter_mm` DECIMAL(18,2) COMMENT 'Outer diameter of cylindrical packaging (drums, cylinders, pails) in millimeters. Used for warehouse slotting and space planning.',
    `packaging_code` STRING COMMENT 'Unique business identifier for the packaging configuration, used in SAP EWM (Extended Warehouse Management) and order fulfillment systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `packaging_config_status` STRING COMMENT 'Current lifecycle status of the packaging configuration. Active configurations are available for order fulfillment; inactive/obsolete are phased out; pending approval are under review; restricted require special authorization.. Valid values are `active|inactive|pending_approval|obsolete|restricted`',
    `packaging_group` STRING COMMENT 'UN Packaging Group classification indicating the degree of danger: I (high danger), II (medium danger), III (low danger). Determines packaging performance requirements.. Valid values are `I|II|III`',
    `packaging_type` STRING COMMENT 'Type of packaging container used for the chemical product. Includes drum, IBC (Intermediate Bulk Container), bulk tanker, bag, cylinder, pail, tote, flexitank, and isotank. [ENUM-REF-CANDIDATE: drum|ibc|bulk_tanker|bag|cylinder|pail|tote|flexitank|isotank — 9 candidates stripped; promote to reference product]',
    `pallet_type` STRING COMMENT 'Type of pallet used for this packaging configuration (e.g., EUR pallet, standard 48x40, block pallet, chemical-resistant pallet).',
    `pharmaceutical_grade_flag` BOOLEAN COMMENT 'Indicates whether this packaging configuration meets pharmaceutical-grade standards for API (Active Pharmaceutical Ingredient) and pharmaceutical chemical packaging.',
    `preferred_flag` BOOLEAN COMMENT 'Indicates whether this is the preferred or default packaging configuration for the associated product SKU (Stock Keeping Unit).',
    `region_restriction` STRING COMMENT 'Geographic regions where this packaging configuration is approved or restricted for use, based on local regulatory requirements (e.g., USA, CAN, MEX, EUR, CHN). Pipe-separated list of ISO 3166-1 alpha-3 country codes.',
    `returnable_flag` BOOLEAN COMMENT 'Indicates whether this packaging configuration is returnable (e.g., returnable drums, IBCs, cylinders) requiring deposit tracking and reverse logistics.',
    `stack_height_max` STRING COMMENT 'Maximum number of pallet layers that can be safely stacked vertically in warehouse storage, considering packaging strength and product stability.',
    `tare_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the empty packaging container in kilograms, excluding product. Used for net weight calculations and transportation compliance.',
    `un_packaging_code` STRING COMMENT 'United Nations packaging certification code indicating the packaging meets UN performance standards for hazardous materials transport. Examples: 4G (fiberboard box), 1A1 (steel drum), 1H1 (plastic drum), 31HA1 (IBC composite).. Valid values are `^[0-9][A-Z][0-9A-Z]{1,4}$`',
    `units_per_pallet` STRING COMMENT 'Number of packaging units (drums, IBCs, bags, etc.) that can be loaded on a single pallet for warehouse storage and transportation.',
    `width_mm` DECIMAL(18,2) COMMENT 'Width of rectangular packaging (IBCs, totes, boxes) in millimeters. Used for warehouse slotting and transportation planning.',
    CONSTRAINT pk_packaging_config PRIMARY KEY(`packaging_config_id`)
) COMMENT 'Packaging configuration master defining all approved packaging formats for chemical product SKUs. Captures packaging type (drum, IBC, bulk tanker, bag, cylinder, pail, tote, flexitank, isotank), material of construction (HDPE, steel, stainless steel, fiber, aluminum, lined), nominal capacity, fill weight, fill volume, tare weight, closure type, UN packaging certification code (4G, 1A1, 1H1, 31HA1), packaging group (I, II, III), label requirements (GHS, DOT, IATA), pallet configuration (units per pallet, pallet type, stack height), and packaging status. Supports DOT/IATA/IMDG hazmat packaging compliance, warehouse slotting in SAP EWM, and customer order fulfillment.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`composition` (
    `composition_id` BIGINT COMMENT 'Unique identifier for the product composition record.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the finished chemical product to which this composition belongs.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Required for BOM: links each product composition entry to the specific raw material master record, enabling formulation, cost, and regulatory reporting.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier providing the component.',
    `component_approval_date` DATE COMMENT 'Date when the component received regulatory approval.',
    `component_cas_number` STRING COMMENT 'Standard CAS number uniquely identifying the chemical component.. Valid values are `^d{2,7}-d{2}-d$`',
    `component_concentration_range_flag` BOOLEAN COMMENT 'Indicates whether the concentration is expressed as a range.',
    `component_concentration_unit` STRING COMMENT 'Unit of measurement for the component concentration.. Valid values are `percent|weight_percent|volume_percent|ppm|ppb`',
    `component_concentration_value` DECIMAL(18,2) COMMENT 'Numeric concentration of the component.',
    `component_ec_number` STRING COMMENT 'EC number identifying the component within European regulatory lists.. Valid values are `^d{3}-d{2}-d$`',
    `component_expiration_date` DATE COMMENT 'Date after which the component is considered expired.',
    `component_function` STRING COMMENT 'Role of the component within the product formulation.. Valid values are `active|solvent|stabilizer|surfactant|filler|other`',
    `component_hazard_class` STRING COMMENT 'Globally Harmonized System hazard class applicable to the component.. Valid values are `flammable|corrosive|toxic|environmental|oxidizer|irritant`',
    `component_hazard_statement` STRING COMMENT 'Standard hazard statement describing the risks of the component.',
    `component_iupac_name` STRING COMMENT 'Systematic IUPAC name of the component.',
    `component_lot_number` STRING COMMENT 'Lot or batch number assigned to the component by the supplier.',
    `component_physical_state` STRING COMMENT 'Physical state of the component at room temperature.. Valid values are `solid|liquid|gas|solution`',
    `component_precautionary_statement` STRING COMMENT 'Standard precautionary statement for safe handling of the component.',
    `component_purity` DECIMAL(18,2) COMMENT 'Purity of the component expressed as a percentage.',
    `component_purity_unit` STRING COMMENT 'Unit for the component purity value.. Valid values are `percent`',
    `component_quantity` DECIMAL(18,2) COMMENT 'Absolute quantity of the component used in the formulation.',
    `component_quantity_unit` STRING COMMENT 'Unit of measurement for the component quantity.. Valid values are `kg|g|mg|lb|oz`',
    `component_regulatory_number` STRING COMMENT 'Regulatory registration or listing number for the component.',
    `component_regulatory_status` STRING COMMENT 'Regulatory status of the component under applicable chemical regulations.. Valid values are `registered|listed|exempt|restricted`',
    `component_trade_name` STRING COMMENT 'Commercial trade name used for the component.',
    `composition_status` STRING COMMENT 'Current lifecycle status of the composition record.. Valid values are `active|inactive|deprecated`',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether the component information is protected as confidential business information.',
    `disclosure_threshold` STRING COMMENT 'Regulatory threshold that triggers mandatory disclosure of the component.. Valid values are `osha|reach|sara313|none`',
    `effective_date` DATE COMMENT 'Date when the composition became effective for the product.',
    `end_date` DATE COMMENT 'Date when the composition was retired or superseded.',
    `notes` STRING COMMENT 'Additional free‑form notes about the composition.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the composition record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the composition record.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the composition data.. Valid values are `sap_mm|labware_lims|intelex_ehs`',
    `version` STRING COMMENT 'Version identifier for the composition record.',
    CONSTRAINT pk_composition PRIMARY KEY(`composition_id`)
) COMMENT 'Chemical composition disclosure record for a product, capturing the ingredient-level breakdown required for SDS Section 3 (Composition/Information on Ingredients) and REACH substance identification. Stores component CAS number, IUPAC name, trade name, EC number, concentration (exact or range), concentration unit, function in mixture (active ingredient, solvent, stabilizer, surfactant, filler), classification of component, disclosure threshold (OSHA, REACH, SARA 313), and confidentiality flag (CBI — Confidential Business Information). Supports SDS authoring, REACH mixture notification, and TSCA reporting.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`cross_reference` (
    `cross_reference_id` BIGINT COMMENT 'System-generated unique identifier for each product cross‑reference record.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the primary chemical product for which the cross‑reference is defined.',
    `approval_authority` STRING COMMENT 'Name or role of the person/department that approved the cross‑reference.',
    `approval_date` DATE COMMENT 'Date on which the cross‑reference was formally approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cross‑reference record was first created in the system.',
    `cross_reference_status` STRING COMMENT 'Current lifecycle status of the cross‑reference record.. Valid values are `active|inactive|pending|retired`',
    `customer_approval_required` BOOLEAN COMMENT 'True if the customer must approve the substitution before execution.',
    `customer_notification_required` BOOLEAN COMMENT 'Indicates whether the customer must be notified when this substitution is applied.',
    `effective_from` DATE COMMENT 'Date from which the cross‑reference becomes valid for operational use.',
    `effective_until` DATE COMMENT 'Date after which the cross‑reference is no longer valid (null if open‑ended).',
    `equivalence_type` STRING COMMENT 'Degree of similarity between the primary product and the referenced product.. Valid values are `identical|equivalent|similar|substitute`',
    `external_reference_code` STRING COMMENT 'Code assigned by an external party (competitor, distributor, or legacy system) that maps to the referenced product.',
    `notes` STRING COMMENT 'Free‑form comments or rationale for the cross‑reference.',
    `quality_hold_substitution_allowed` BOOLEAN COMMENT 'True if substitution is permitted when the primary product is on a quality hold.',
    `reference_owner` STRING COMMENT 'Business unit or team that owns and maintains the cross‑reference record.',
    `reference_type` STRING COMMENT 'Category describing the origin or nature of the reference (e.g., internal, competitor, legacy).. Valid values are `internal|competitor|legacy|customer_specific|distributor`',
    `regulatory_status` STRING COMMENT 'Regulatory compliance classification of the referenced product relative to the primary product.. Valid values are `REACH_compliant|TSCA_compliant|non_compliant`',
    `source_system` STRING COMMENT 'Name of the source system where the cross‑reference originated (e.g., SAP, CRM).',
    `stock_out_substitution_allowed` BOOLEAN COMMENT 'True if substitution may be used automatically when primary product is out of stock.',
    `substitution_condition` STRING COMMENT 'Free‑text description of conditions under which the substitution may be applied (e.g., stock‑out, quality hold).',
    `substitution_direction` STRING COMMENT 'Indicates whether the substitution relationship works both ways or only from primary to referenced product.. Valid values are `bidirectional|one_way`',
    `substitution_type` STRING COMMENT 'Classification of substitution based on business policy (direct, conditional, or emergency).. Valid values are `direct|conditional|emergency`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the cross‑reference record.',
    CONSTRAINT pk_cross_reference PRIMARY KEY(`cross_reference_id`)
) COMMENT 'Cross-reference and substitution master record — the single source of truth (SSOT) for all product equivalence mappings, approved substitutions, and external reference linkages. Links a chemical product to equivalent products, approved substitutes (direct, conditional, emergency), competitor products, legacy product codes, customer-specific part numbers, and distributor catalog numbers. Captures reference type, external reference code, reference owner, equivalence type, substitution type, substitution conditions (stock-out, quality hold, customer approval required), substitution direction (bidirectional or one-way), approval authority, approval date, customer notification requirement, validity dates, and status. Supports customer order management, SAP SD availability check substitution logic, product substitution workflows during fulfillment, competitive intelligence, and supply chain continuity planning. This entity consolidates all substitution rules previously tracked separately — there is no other substitution entity in this domain.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`substitution` (
    `substitution_id` BIGINT COMMENT 'System-generated unique identifier for the product substitution rule record.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the product that may be substituted.',
    `substitution_substitute_product_chemical_product_id` BIGINT COMMENT 'Identifier of the product that can replace the original product.',
    `approval_authority` STRING COMMENT 'Name or role of the person/committee that approved the substitution rule.',
    `approval_date` DATE COMMENT 'Date when the substitution rule was formally approved.',
    `condition_customer_approval_required` BOOLEAN COMMENT 'True when the customer must explicitly approve the substitution.',
    `condition_quality_hold` BOOLEAN COMMENT 'True when substitution is permitted only if the original product is under a quality hold.',
    `condition_stock_out` BOOLEAN COMMENT 'True when substitution is allowed only if the original product is out of stock.',
    `customer_notification_required` BOOLEAN COMMENT 'True when the customer must be notified of the substitution before fulfillment.',
    `direction` STRING COMMENT 'Indicates whether substitution can occur both ways or only from original to substitute.. Valid values are `bidirectional|one_way`',
    `effective_from` DATE COMMENT 'Date from which the substitution rule becomes active.',
    `effective_until` DATE COMMENT 'Date after which the substitution rule is no longer valid (null if open‑ended).',
    `notes` STRING COMMENT 'Additional remarks or special instructions related to the substitution.',
    `reason` STRING COMMENT 'Free‑text description of why the substitution rule was created (e.g., cost reduction, supply risk).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the substitution record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the substitution record.',
    `record_version` STRING COMMENT 'Incremental version number for optimistic concurrency control.',
    `source_system` STRING COMMENT 'Name of the source system that originated the substitution record (e.g., SAP SD, custom MDM).',
    `substitution_status` STRING COMMENT 'Current lifecycle status of the substitution rule.. Valid values are `active|inactive|pending|revoked`',
    `substitution_type` STRING COMMENT 'Classification of substitution logic: direct (one-to-one), conditional (based on criteria), or emergency (unplanned).. Valid values are `direct|conditional|emergency`',
    CONSTRAINT pk_substitution PRIMARY KEY(`substitution_id`)
) COMMENT 'Approved product substitution rule record defining when and how one chemical product or SKU may be substituted for another during order fulfillment or production. Captures substitution type (direct, conditional, emergency), substitute product reference, substitution direction (bidirectional or one-way), approval authority, approval date, conditions for substitution (stock-out, quality hold, customer approval required), customer notification requirement, and substitution status. Supports SAP SD availability check substitution logic and supply chain continuity planning.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` (
    `reach_dossier_id` BIGINT COMMENT 'Unique surrogate key for each REACH registration dossier record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Each REACH dossier pertains to a specific chemical product; linking enables traceability and reporting. No existing reverse FK, so direction dossier → product is appropriate.',
    `cas_number` STRING COMMENT 'Unique identifier for the chemical substance assigned by the CAS registry.. Valid values are `^d{2,7}-d{2}-d$`',
    `compliance_notes` STRING COMMENT 'Free‑text notes on compliance actions, exemptions, or special conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dossier record was first created in the system.',
    `csr_document_reference` STRING COMMENT 'Reference or file identifier for the associated Chemical Safety Report document.',
    `csr_required` BOOLEAN COMMENT 'Indicates whether a full Chemical Safety Report is required for this substance.',
    `dossier_status` STRING COMMENT 'Current lifecycle state of the REACH dossier.. Valid values are `draft|submitted|approved|rejected|withdrawn`',
    `dossier_update_date` DATE COMMENT 'Most recent date the dossier information was updated.',
    `ec_number` STRING COMMENT 'European Community identifier for the substance.. Valid values are `^EC-d+$`',
    `echa_submission_date` DATE COMMENT 'Date the dossier was submitted to the ECHA portal.',
    `echa_submission_reference` STRING COMMENT 'Reference code for the submission package in the ECHA REACH-IT portal.. Valid values are `^[A-Z0-9]{8,}$`',
    `expiry_date` DATE COMMENT 'Date when the REACH registration expires or must be renewed.',
    `exposure_scenarios_count` STRING COMMENT 'Total number of exposure scenarios defined within the dossier.',
    `hazard_classification` STRING COMMENT 'GHS hazard class assigned to the substance.. Valid values are `flammable|corrosive|toxic|environmental_hazard|none`',
    `product_category` STRING COMMENT 'High‑level business category of the chemical product.. Valid values are `performance_material|plastic|agricultural_solution|specialty_chemical`',
    `registrant_role` STRING COMMENT 'Role of the registrant in the REACH dossier (lead registrant, member, or coordinator).. Valid values are `lead|member|coordinator`',
    `registration_date` DATE COMMENT 'Date the REACH registration was initially submitted to ECHA.',
    `registration_number` STRING COMMENT 'Official REACH registration number assigned by ECHA.. Valid values are `^[A-Z0-9-]+$`',
    `regulatory_status` STRING COMMENT 'Overall regulatory status of the substance across applicable frameworks.. Valid values are `registered|pending|rejected`',
    `risk_assessment_flag` BOOLEAN COMMENT 'Indicates whether a risk assessment has been completed for the dossier.',
    `sief_membership` STRING COMMENT 'Indicates whether the dossier is part of a Substance Information Exchange Forum (SIEF).. Valid values are `yes|no`',
    `source_system` STRING COMMENT 'Source system that originated the dossier record (e.g., Intelex EHS).',
    `substance_iupac_name` STRING COMMENT 'Systematic chemical name of the substance as defined by IUPAC.',
    `tonnage_band` STRING COMMENT 'Annual tonnage range for which the substance is registered.. Valid values are `0-1t|1-10t|10-100t|>100t`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dossier record.',
    CONSTRAINT pk_reach_dossier PRIMARY KEY(`reach_dossier_id`)
) COMMENT 'REACH registration dossier record — the single source of truth (SSOT) for substance registration under EU REACH Regulation (EC) No 1907/2006, including the full Chemical Safety Report (CSR) and all exposure scenarios. Captures REACH registration number, substance identity (IUPAC name, CAS, EC number), registrant role (lead registrant, member), SIEF membership, tonnage band, registration date, dossier update date, ECHA submission reference, CSR requirement flag, and dossier status. Contains all exposure scenarios as child records: scenario title, use descriptor codes (SU, PC, PROC, AC, ERC), contributing scenario name, operational conditions (temperature, duration, frequency, amount used), risk management measures (PPE, ventilation, containment), DNEL values, PNEC values, risk characterization ratios (RCR), and scenario validity dates. Supports extended SDS (eSDS) generation for downstream users. Managed in Intelex EHS and submitted to ECHA REACH-IT. This entity is the sole owner of exposure scenario data — there is no separate exposure scenario entity.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` (
    `exposure_scenario_id` BIGINT COMMENT 'System-generated unique identifier for the exposure scenario record.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the chemical product to which this exposure scenario applies.',
    `amount_used_kg` DECIMAL(18,2) COMMENT 'Quantity of the chemical used in the scenario, expressed in kilograms.',
    `article_category_code` STRING COMMENT 'Code for the article form (e.g., solid, liquid) of the chemical in the scenario.',
    `contributing_scenario_name` STRING COMMENT 'Name of any parent or related scenario that contributes to this exposure scenario.',
    `dnel_unit` STRING COMMENT 'Unit of measurement for the DNEL (e.g., mg/m³).',
    `dnel_value` DECIMAL(18,2) COMMENT 'Quantitative DNEL value derived for the scenario.',
    `environmental_release_category_code` STRING COMMENT 'Code indicating the type of environmental release considered in the scenario.',
    `notes` STRING COMMENT 'Free‑text field for any supplemental information or comments.',
    `operational_duration_minutes` STRING COMMENT 'Length of time the exposure condition is applied, measured in minutes.',
    `operational_frequency_per_day` STRING COMMENT 'Number of times the exposure condition occurs each day.',
    `operational_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the chemical is used or processed, expressed in degrees Celsius.',
    `pnec_unit` STRING COMMENT 'Unit of measurement for the PNEC (e.g., µg/L).',
    `pnec_value` DECIMAL(18,2) COMMENT 'PNEC value used for environmental risk assessment.',
    `process_category_code` STRING COMMENT 'Code describing the manufacturing or usage process category for the scenario.',
    `product_category_code` STRING COMMENT 'Code indicating the product category of the chemical under REACH PC classification.',
    `rcr_value` DECIMAL(18,2) COMMENT 'Ratio of exposure to the DNEL/PNEC, indicating risk level.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the scenario record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scenario record.',
    `regulatory_status` STRING COMMENT 'Regulatory framework(s) applicable to the scenario.. Valid values are `REACH|TSCA|GHS|EU|US`',
    `risk_management_measure_containment` STRING COMMENT 'Physical containment measures (e.g., fume hood) needed for the scenario.',
    `risk_management_measure_ppe` STRING COMMENT 'Description of required PPE for safe handling under this scenario.',
    `risk_management_measure_ventilation` STRING COMMENT 'Ventilation controls required to mitigate exposure.',
    `scenario_code` STRING COMMENT 'Business code used to reference the scenario in regulatory documents and internal systems.',
    `scenario_effective_date` DATE COMMENT 'Date from which the scenario is considered valid.',
    `scenario_expiry_date` DATE COMMENT 'Date after which the scenario is no longer valid.',
    `scenario_name` STRING COMMENT 'Human‑readable title describing the exposure scenario.',
    `scenario_status` STRING COMMENT 'Current lifecycle status of the scenario.. Valid values are `active|inactive|retired|draft`',
    `sector_of_use_code` STRING COMMENT 'Code representing the industrial sector where the chemical is used (REACH SU classification).',
    `source_system` STRING COMMENT 'Originating operational system (e.g., SAP QM, Intelex EHS).',
    `version_number` STRING COMMENT 'Incremental version of the scenario record.',
    CONSTRAINT pk_exposure_scenario PRIMARY KEY(`exposure_scenario_id`)
) COMMENT 'Chemical Safety Report (CSR) exposure scenario record defining the conditions of safe use for a chemical substance or mixture under REACH. Captures exposure scenario title, use descriptor codes (sector of use SU, product category PC, process category PROC, article category AC, environmental release category ERC), contributing scenario name, operational conditions (OC: temperature, duration, frequency, amount used), risk management measures (RMM: PPE, ventilation, containment), derived no-effect level (DNEL), predicted no-effect concentration (PNEC), risk characterization ratio (RCR), and scenario validity date. Appended to extended SDS (eSDS) for downstream users.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`product_order` (
    `product_order_id` BIGINT COMMENT 'System-generated unique identifier for the sales order record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who placed the order.',
    `asset_change_request_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset_change_request. Business justification: Change‑management process ties equipment change requests to the sales order that triggered the modification, ensuring regulatory traceability.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: REQUIRED: Order Entry captures the buying contact who placed the order, supporting sales attribution, commission calculations, and contact‑order reporting.',
    `contract_id` BIGINT COMMENT 'Reference to a blanket or framework contract, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Cost Allocation Report: each sales order must be charged to an internal cost center for accurate expense tracking and financial reporting.',
    `distributor_id` BIGINT COMMENT 'Foreign key linking to sales.distributor. Business justification: Links orders placed through a distributor; required for distributor performance and rebate calculations.',
    `employee_id` BIGINT COMMENT 'Internal employee responsible for the sale.',
    `forecast_version_id` BIGINT COMMENT 'Foreign key linking to planning.forecast_version. Business justification: Order Planning Audit uses the forecast version that drove demand planning for the sales order, required for regulatory reporting and demand accuracy analysis.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Project Accounting process requires associating a sales order with an internal order to track project‑related costs and budgets.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to planning.mrp_run. Business justification: MRP Run linkage records which MRP execution generated the plan for a sales order, needed for traceability and performance KPI reporting.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Tracks Opportunity win to Order creation for pipeline‑to‑revenue analysis.',
    `patent_filing_id` BIGINT COMMENT 'Foreign key linking to research.patent_filing. Business justification: Patent Royalty Tracking requires linking each order to the patent filing that protects the sold chemical for royalty accounting.',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement. Business justification: Ensures each order references the price agreement applied, needed for pricing compliance audit.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: REQUIRED: Orders for key accounts use a specific price list; storing price_list_id enables contract‑price compliance reporting.',
    `formula_id` BIGINT COMMENT 'Foreign key linking to formulation.formula. Business justification: Required for Order master reporting: the primary formula defining the product family is stored on the sales order to support profitability analysis and regulatory traceability.',
    `site_id` BIGINT COMMENT 'Reference to the address used for invoicing.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Needed for Profitability Analysis: linking orders to profit centers enables revenue attribution and margin reporting per business unit.',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_proposal. Business justification: REQUIRED: Special pricing proposals are attached to orders; linking enables proposal acceptance tracking and profitability review.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Required for Quote‑to‑Order conversion report; orders are created from approved sales quotes.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Product Development Traceability Report links sales orders to originating R&D project for regulatory compliance and cost allocation.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Assigns each order to a sales territory for regional sales reporting and quota tracking.',
    `sds_id` BIGINT COMMENT 'Reference to the attached Safety Data Sheet or regulatory compliance document.',
    `shipping_address_site_id` BIGINT COMMENT 'Reference to the destination address for delivery.',
    `sop_cycle_id` BIGINT COMMENT 'Foreign key linking to planning.sop_cycle. Business justification: SOP Cycle assignment links a sales order to the Sales & Operations Planning cycle used for its demand‑supply balancing, required for cycle performance metrics.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: WBS Tracking report links each order to a Work Breakdown Structure element for detailed project cost control.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the order record was first persisted.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the transaction currency.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the order.',
    `distribution_channel` STRING COMMENT 'Channel through which the product is sold (e.g., wholesale, retail).',
    `division` STRING COMMENT 'Business division responsible for the product line.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert foreign currency to company reporting currency.',
    `freight_terms` STRING COMMENT 'Responsibility for freight costs.. Valid values are `prepaid|collect|third_party`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total order value before taxes, discounts, and freight.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the order contains regulated hazardous substances.',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities.. Valid values are `EXW|FCA|FOB|CFR|CIF|DDP`',
    `is_backorder` BOOLEAN COMMENT 'True when any line items are pending due to stock shortage.',
    `is_split` BOOLEAN COMMENT 'True when the order is fulfilled in multiple shipments.',
    `line_count` STRING COMMENT 'Number of distinct line items on the order.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes, discounts, and freight.',
    `order_number` STRING COMMENT 'External order number visible to customers and used in communications.',
    `order_source` STRING COMMENT 'System or channel through which the order was created.. Valid values are `SAP|CRM|EDI`',
    `order_status` STRING COMMENT 'Current lifecycle state of the order.. Valid values are `draft|open|confirmed|fulfilled|closed|cancelled`',
    `order_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the order was entered into the system.',
    `order_type` STRING COMMENT 'Classification of the order based on business process and fulfillment rules.. Valid values are `standard|rush|blanket|consignment|return`',
    `payment_terms` STRING COMMENT 'Credit terms agreed with the customer (e.g., NET30).',
    `plant_code` STRING COMMENT 'Manufacturing plant assigned to fulfill the order.',
    `priority` STRING COMMENT 'Priority level used for scheduling and resource allocation.. Valid values are `low|medium|high|critical`',
    `requested_delivery_date` DATE COMMENT 'Date the customer expects the order to be delivered.',
    `sales_org` STRING COMMENT 'Organizational unit responsible for the sale.',
    `sales_region` STRING COMMENT 'Geographic region assigned to the sales organization.',
    `shipping_method` STRING COMMENT 'Mode of transportation selected for delivery.. Valid values are `ground|air|sea|rail`',
    `special_handling_instructions` STRING COMMENT 'Customer‑provided notes for handling, packaging, or compliance.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status, e.g., reason for cancellation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated for the order.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Aggregate volume of all line items in cubic meters.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Aggregate weight of all line items in kilograms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the order record.',
    CONSTRAINT pk_product_order PRIMARY KEY(`product_order_id`)
) COMMENT 'Core master record for a customer sales order capturing the full order header: customer account, order type (standard, rush, blanket, consignment, return), requested delivery date, incoterms, payment terms, total order value, currency, plant assignment, sales organization, distribution channel, and division. Serves as the authoritative SSOT for all customer order commitments in the order-to-cash lifecycle. Links to quotation (source), blanket order (if call-off), and downstream confirmations, deliveries, and status events. Maps to SAP SD transaction VA01/VA02.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`line_item` (
    `line_item_id` BIGINT COMMENT 'Primary key for line_item',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: Needed for Regulatory Reporting to map each ordered chemical to its CAS registry entry for hazard classification and REACH compliance.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Required for order fulfillment and regulatory compliance reports: each line item must reference the master chemical product to derive pricing, hazard classification, and traceability.',
    `compound_registry_id` BIGINT COMMENT 'Foreign key linking to research.compound_registry. Business justification: Regulatory Hazard Reporting requires associating sold items with the compound registry entry (CAS) for SDS generation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Detailed Costing report allocates line‑item costs to specific cost centers for granular expense analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sales order entry audit requires recording which employee created each line item for commission and compliance reporting.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: MES production scheduling assigns each order line to specific equipment for batch manufacturing, required for traceability and capacity planning.',
    `experimental_formulation_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formulation. Business justification: Formulation Release Management links each sold line item to the approved experimental formulation used to produce the chemical.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Required for Order‑to‑Production planning: each sales order line must be tied to the exact formula version that will be manufactured, enabling batch scheduling and compliance reporting.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: Production planning links each order line to the functional location (plant/area) where it will be produced, essential for allocation and compliance reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: GL Posting process: each line item must map to a GL account for revenue recognition and financial statement generation.',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Supports Traceability & Recall Management by linking each order line to the specific lot record of the shipped material.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Required for Order Fulfillment to retrieve material specifications, hazard data, and compliance info for each line item.',
    `opportunity_product_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity_product. Business justification: Links each order line to the opportunity product that generated it, supporting win‑loss and forecasting reports.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to planning.planned_order. Business justification: Order line fulfillment tracking links each sales order line to the MRP‑generated planned production order that will satisfy it, essential for production scheduling and order status reporting.',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: REQUIRED: Each order line must reference the exact price‑list item applied, supporting price audit and margin analysis.',
    `product_order_id` BIGINT COMMENT 'Identifier of the parent sales order to which this line belongs.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Needed for procurement allocation process to map each sales order line to the PO that supplies the material.',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Maps order line items to their originating quote lines for margin and variance analysis.',
    `handling_instruction_id` BIGINT COMMENT 'Foreign key linking to order.handling_instruction. Business justification: Line items reference handling instructions; moving to a FK normalizes data and removes the free-text column.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Supports supplier allocation per line for sourcing decisions and vendor performance tracking.',
    `batch_determination_flag` BOOLEAN COMMENT 'Indicates whether batch allocation is required for this line (True) or not (False).',
    `coa_required_flag` BOOLEAN COMMENT 'True if a COA must be attached to the shipment for regulatory or customer reasons.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed by the supply chain after availability check.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date‑time when the line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price fields.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount value applied to this line item.',
    `ehs_hazard_statement` STRING COMMENT 'Standard GHS hazard statement associated with the material.',
    `ehs_precautionary_statement` STRING COMMENT 'Standard GHS precautionary statement for safe handling.',
    `expiration_date` DATE COMMENT 'Date after which the product batch is no longer sellable.',
    `hazmat_class` STRING COMMENT 'GHS hazard class for the product. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9 — promote to reference product]',
    `is_gmp_compliant` BOOLEAN COMMENT 'True if the product is manufactured under Good Manufacturing Practice standards.',
    `last_update_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the line record.',
    `line_comment` STRING COMMENT 'Free‑form comment entered by order entry personnel.',
    `line_number` STRING COMMENT 'Sequential number of the line within the order, starting at 1.',
    `line_status` STRING COMMENT 'Current processing status of the line item.. Valid values are `open|confirmed|shipped|cancelled|backordered`',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Net price multiplied by confirmed quantity before tax.',
    `lot_number` STRING COMMENT 'Lot identifier for traceability of the produced batch.',
    `material_gl_account_code` STRING COMMENT 'GL account used for revenue recognition of this material.',
    `material_sds_url` STRING COMMENT 'Link to the electronic Safety Data Sheet for the material.',
    `moq_enforced_flag` BOOLEAN COMMENT 'True when the line must meet the customers minimum order quantity requirement.',
    `net_price` DECIMAL(18,2) COMMENT 'Net price per unit before taxes and discounts, in the order currency.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity requested by the customer, expressed in the unit of measure.',
    `partial_delivery_allowed_flag` BOOLEAN COMMENT 'True if the line can be split across multiple deliveries.',
    `plant` STRING COMMENT 'SAP plant code where the product will be produced or shipped from.',
    `pricing_condition` STRING COMMENT 'Code representing the pricing condition applied (e.g., discount, surcharge).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the line item meets all applicable chemical regulations (REACH, TSCA, EPA).',
    `requested_delivery_date` DATE COMMENT 'Date the customer requested for delivery of this line item.',
    `shelf_life_days` STRING COMMENT 'Number of days the product remains usable from the production date.',
    `storage_location` STRING COMMENT 'Warehouse or storage location identifier for inventory allocation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applicable to this line item.',
    `temperature_control_flag` BOOLEAN COMMENT 'True if the product must be stored or transported at a controlled temperature.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the ordered quantity (kilograms, liters, metric tons, drums).. Valid values are `kg|L|MT|drum`',
    CONSTRAINT pk_line_item PRIMARY KEY(`line_item_id`)
) COMMENT 'Individual line item within a customer sales order representing a specific chemical product SKU, grade, or formulation being ordered. Captures line number, material number (SAP), product description, ordered quantity, unit of measure (kg, L, MT, drums), confirmed quantity, net price, pricing conditions, requested delivery date per line, plant, storage location, batch determination flag, COA/COC requirement flag, and special handling instructions (e.g., hazmat class, temperature-controlled). Supports MOQ enforcement and partial delivery rules.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` (
    `order_confirmation_id` BIGINT COMMENT 'System-generated unique identifier for the order confirmation record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer who placed the order.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Confirmation approval must be signed off by an authorized employee to satisfy internal controls and compliance.',
    `product_order_id` BIGINT COMMENT 'Identifier of the original sales order that this confirmation relates to.',
    `handling_instruction_id` BIGINT COMMENT 'Foreign key linking to order.handling_instruction. Business justification: Order confirmations also store handling instructions; linking to handling_instruction standardizes handling guidance across confirmations.',
    `batch_number` STRING COMMENT 'Allocated production batch number for the confirmed product.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier responsible for delivery.',
    `coa_attached` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis is attached to the confirmation.',
    `coc_attached` BOOLEAN COMMENT 'Indicates whether a Certificate of Compliance is attached to the confirmation.',
    `confirmation_number` STRING COMMENT 'External confirmation number issued to the customer for this order confirmation.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the confirmation was issued to the customer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the confirmation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `delivery_date_confirmed` DATE COMMENT 'Delivery date confirmed by the supplier.',
    `delivery_date_requested` DATE COMMENT 'Delivery date originally requested by the customer.',
    `dot_classification` STRING COMMENT 'U.S. Department of Transportation classification for hazardous material transport. [ENUM-REF-CANDIDATE: class_1|class_2|class_3|class_4|class_5|class_6|class_7|class_8|class_9 — promote to reference product]',
    `expiration_date` DATE COMMENT 'Expiration date of the product lot, if applicable.',
    `freight_terms` STRING COMMENT 'Incoterm governing the shipment responsibilities. [ENUM-REF-CANDIDATE: EXW|FCA|FOB|CFR|CIF|DAP|DDP — promote to reference product]',
    `ghs_hazard_class` STRING COMMENT 'GHS hazard classification for the product. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9 — promote to reference product]',
    `is_deviation` BOOLEAN COMMENT 'True if the confirmation deviates from the original customer request (e.g., quantity, packaging).',
    `lot_number` STRING COMMENT 'Lot identifier for the batch of product supplied.',
    `notes` STRING COMMENT 'Free‑form field for any extra information or remarks.',
    `order_confirmation_status` STRING COMMENT 'Current workflow state of the order confirmation.. Valid values are `draft|pending|confirmed|rejected|cancelled|completed`',
    `payment_terms` STRING COMMENT 'Agreed payment terms for the order.. Valid values are `NET30|NET45|NET60|COD|PREPAID|ON_ACCOUNT`',
    `plant_code` STRING COMMENT 'Code of the manufacturing plant that will supply the confirmed order.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Unit price agreed for the confirmed quantity.',
    `quantity_confirmed` DECIMAL(18,2) COMMENT 'Quantity of product confirmed for delivery.',
    `regulatory_compliance_flag` STRING COMMENT 'Indicates compliance status with applicable regulations (e.g., REACH, TSCA).. Valid values are `compliant|non_compliant|pending`',
    `shipping_method` STRING COMMENT 'Method selected for transporting the confirmed order.. Valid values are `air|ground|sea|rail|courier|pickup`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Applicable tax amount for the confirmed order.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the order confirmation.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Gross monetary amount before discounts, taxes, and adjustments.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net amount payable after discounts and taxes.',
    `tracking_number` STRING COMMENT 'Carrier‑provided tracking identifier for the shipment.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the confirmed quantity.. Valid values are `kg|lb|L|gal|m3|ton`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the confirmation record.',
    CONSTRAINT pk_order_confirmation PRIMARY KEY(`order_confirmation_id`)
) COMMENT 'Official order acknowledgment document sent to the customer confirming acceptance of a sales order. Captures confirmation number, confirmed order quantities, confirmed delivery dates, confirmed pricing, plant of supply, batch allocation status, COA/COC commitment, special handling confirmations (GHS hazard class, DOT classification), and any deviations from the original customer request. Serves as the contractual commitment record between Chemical Mfg and the customer.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` (
    `order_delivery_schedule_id` BIGINT COMMENT 'Unique identifier for the delivery schedule line.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the product being scheduled for delivery.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Needed for the Lot Traceability report; each delivery schedule line must reference the specific production lot to satisfy GHS/REACH reporting.',
    `product_order_id` BIGINT COMMENT 'Identifier of the sales order to which this schedule line belongs.',
    `trial_batch_id` BIGINT COMMENT 'Foreign key linking to research.trial_batch. Business justification: Pilot Production Scheduling links delivery schedules to the trial batch used for pilot runs, enabling traceability.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Production planning assigns a scheduler; the employee ID is needed for workload balancing and audit of schedule changes.',
    `shipment_plan_id` BIGINT COMMENT 'Identifier of the logistics route planned for this delivery.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Delivery scheduling needs to know the exact stock position (warehouse location) from which inventory will be drawn for JIT shipping.',
    `batch_number` STRING COMMENT 'Manufacturing batch number linked to the scheduled product.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier responsible for the delivery.',
    `carrier_scac` STRING COMMENT 'Standard Carrier Alpha Code identifying the transportation carrier.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity that has been confirmed for delivery by the customer or logistics partner.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule line record was created.',
    `delivery_window_end` TIMESTAMP COMMENT 'End of the allowed delivery time window as agreed with the customer.',
    `delivery_window_start` TIMESTAMP COMMENT 'Start of the allowed delivery time window as agreed with the customer.',
    `freight_terms` STRING COMMENT 'Terms of freight payment (e.g., prepaid, collect, third party).. Valid values are `prepaid|collect|third_party`',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the scheduled product is classified as hazardous.',
    `hazmat_class` STRING COMMENT 'GHS classification code for the hazardous material (e.g., 3, 6, 8).',
    `humidity_requirement_percent` DECIMAL(18,2) COMMENT 'Allowed humidity range for the product during transport.',
    `incoterm` STRING COMMENT 'Standard trade term governing delivery responsibilities.. Valid values are `EXW|FCA|FOB|CFR|CIF|DDP`',
    `is_jit` BOOLEAN COMMENT 'True if the schedule line is part of a JIT delivery program.',
    `notes` STRING COMMENT 'Free-text field for any special instructions or comments related to the delivery schedule.',
    `order_delivery_schedule_status` STRING COMMENT 'Current lifecycle status of the delivery schedule line.. Valid values are `planned|confirmed|in_transit|delivered|cancelled`',
    `packaging_type` STRING COMMENT 'Type of packaging used for the delivery (e.g., drum, tote, bulk).',
    `priority` STRING COMMENT 'Business priority of the delivery schedule line.. Valid values are `high|medium|low`',
    `regulatory_compliance_code` STRING COMMENT 'Code indicating specific regulatory compliance requirements for the product (e.g., REACH, TSCA).',
    `schedule_line_number` STRING COMMENT 'Sequential number of the schedule line within the order.',
    `scheduled_date` DATE COMMENT 'Planned calendar date for the delivery.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Exact end time of the scheduled delivery window.',
    `scheduled_quantity` DECIMAL(18,2) COMMENT 'Quantity originally planned for this delivery schedule line.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Exact start time of the scheduled delivery window.',
    `shipping_condition` STRING COMMENT 'Incoterm defining the point of responsibility transfer between seller and buyer.. Valid values are `exworks|fob|cif|ddp`',
    `temperature_requirement_c` DECIMAL(18,2) COMMENT 'Maximum or minimum temperature condition required for the product during transport.',
    `transportation_mode` STRING COMMENT 'Mode of transport selected for the delivery (e.g., truck, rail, ship, air, pipeline).. Valid values are `truck|rail|ship|air|pipeline`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule line.',
    CONSTRAINT pk_order_delivery_schedule PRIMARY KEY(`order_delivery_schedule_id`)
) COMMENT 'Planned delivery schedule associated with a sales order or blanket order, defining agreed shipment windows, delivery quantities per period, and scheduling agreement call-offs. Captures schedule line dates, confirmed quantities, transportation planning point, shipping condition, route, and delivery priority. Supports just-in-time (JIT) delivery programs for automotive and industrial customers. Maps to SAP SD scheduling agreements (VA31) and delivery schedule lines.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` (
    `outbound_delivery_id` BIGINT COMMENT 'System-generated unique identifier for the outbound delivery record.',
    `carrier_id` BIGINT COMMENT 'Identifier of the logistics carrier assigned to the delivery.',
    `product_order_id` BIGINT COMMENT 'Identifier of the sales order that triggered this delivery.',
    `site_id` BIGINT COMMENT 'Identifier of the customer or party receiving the shipment.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Outbound delivery picking references a specific stock position; linking supports picking optimization and audit of shipped inventory.',
    `actual_delivery_date` DATE COMMENT 'Date when the delivery was actually completed.',
    `batch_numbers` STRING COMMENT 'Comma‑separated list of production batch numbers assigned to the shipped material.',
    `coa_attachment_status` STRING COMMENT 'Indicates whether a COA document is attached to the delivery.. Valid values are `attached|missing`',
    `coc_attachment_status` STRING COMMENT 'Indicates whether a COC document is attached to the delivery.. Valid values are `attached|missing`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the outbound delivery record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the freight cost.',
    `delivery_number` STRING COMMENT 'External delivery document number assigned by SAP EWM/SD.',
    `delivery_priority` STRING COMMENT 'Priority level assigned to the delivery.. Valid values are `high|medium|low`',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the outbound delivery.. Valid values are `planned|released|picked|packed|shipped|cancelled`',
    `delivery_type` STRING COMMENT 'Classification of the delivery based on service level or special handling.. Valid values are `standard|expedited|temperature_controlled|hazardous`',
    `delivery_window_end` TIMESTAMP COMMENT 'End timestamp of the agreed delivery time window.',
    `delivery_window_start` TIMESTAMP COMMENT 'Start timestamp of the agreed delivery time window.',
    `dot_hazard_class` STRING COMMENT 'Department of Transportation hazard class code for the material.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Monetary cost of transportation for the delivery.',
    `freight_terms` STRING COMMENT 'Incoterm‑style freight payment terms.. Valid values are `prepaid|collect|third_party`',
    `goods_issue_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods issue posting occurred, marking the physical shipment.',
    `hazardous_material_indicator` BOOLEAN COMMENT 'Flag indicating whether the delivery contains hazardous chemicals.',
    `incoterms` STRING COMMENT 'International commercial terms governing the delivery. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAT|DAP|DDP|FAS|FOB|CFR|CIF — promote to reference product]',
    `packing_instructions` STRING COMMENT 'Special packing requirements or instructions for the delivery.',
    `required_delivery_date` DATE COMMENT 'Customer‑requested delivery date.',
    `ship_to_name` STRING COMMENT 'Display name of the ship‑to party.',
    `shipping_address` STRING COMMENT 'Physical address of the ship‑to location.',
    `shipping_instruction_reference` STRING COMMENT 'Reference to the detailed shipping instruction document.',
    `shipping_point_code` STRING COMMENT 'Code of the plant or warehouse location from which the goods are shipped.',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates if the delivery requires temperature control.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature requirement for temperature‑controlled shipments.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature requirement for temperature‑controlled shipments.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Aggregate volume of all items in the delivery, expressed in cubic meters.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Aggregate weight of all items in the delivery, expressed in kilograms.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for the delivery.. Valid values are `road|rail|air|sea|pipeline`',
    `un_number` STRING COMMENT 'United Nations identification number for hazardous material, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the outbound delivery record.',
    CONSTRAINT pk_outbound_delivery PRIMARY KEY(`outbound_delivery_id`)
) COMMENT 'Outbound delivery document created in SAP EWM/SD to execute the physical shipment of chemical products against a sales order. Captures delivery number, delivery date, ship-to party, shipping point, total weight, total volume, hazardous material indicator, UN number, DOT hazard class, packing instructions, batch numbers assigned, COA/COC attachment status, and goods issue posting date. Integrates with Oracle Transportation Management for carrier assignment and freight execution.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`status_event` (
    `status_event_id` BIGINT COMMENT 'Primary key for status_event',
    `product_order_id` BIGINT COMMENT 'Identifier of the sales order to which this status event belongs.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Event logs must capture which employee triggered a status change for audit and root‑cause analysis.',
    `actual_date` DATE COMMENT 'Date on which the milestone was actually completed.',
    `event_notes` STRING COMMENT 'Additional comments, observations, or instructions associated with the status change.',
    `event_source_reference` STRING COMMENT 'Logical name of the system or process that generated the event.. Valid values are `SAP_SD|OTM|MES|WMS|Manual`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the status change event occurred.',
    `event_type` STRING COMMENT 'Category of the status event, e.g., order_created, credit_check_passed, production_scheduled, goods_issued, delivered, invoiced, cancelled.',
    `is_manual` BOOLEAN COMMENT 'True if the event was recorded by a user; false if generated automatically by a system.',
    `new_status` STRING COMMENT 'Order status after this event was applied.',
    `planned_date` DATE COMMENT 'Target date that was originally scheduled for this milestone.',
    `previous_status` STRING COMMENT 'Order status before this event was applied.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the event record was first inserted into the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the event record.',
    `responsible_party` STRING COMMENT 'Business party or role accountable for the event execution.',
    `triggering_system` STRING COMMENT 'Name of the automated system or service that caused the status transition.',
    `variance_days` STRING COMMENT 'Number of days the actual date deviated from the planned date; positive indicates delay.',
    CONSTRAINT pk_status_event PRIMARY KEY(`status_event_id`)
) COMMENT 'Immutable event log capturing every status transition and fulfillment milestone in the sales order lifecycle from creation through delivery, invoicing, and closure. Records event timestamp, previous status, new status, milestone type (order created, order confirmed, credit check passed, production scheduled, batch released, quality released, goods issued, picked up, in transit, customs cleared, delivered, POD received, invoiced), planned date, actual date, variance in days, triggering user or system, event source (SAP SD, OTM, MES, WMS, manual), responsible party, and event notes. Supports full order lifecycle traceability, SLA monitoring, on-time delivery (OTD) KPI calculation, proactive customer communication, customer inquiry resolution, and regulatory audit trail for controlled substance shipment tracking.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`product_hold` (
    `product_hold_id` BIGINT COMMENT 'Primary key for hold',
    `account_id` BIGINT COMMENT 'Identifier of the customer who placed the order.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory holds require identifying the employee who placed the hold for accountability and reporting.',
    `product_order_id` BIGINT COMMENT 'Identifier of the sales order to which this hold is applied.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount associated with a credit or financial hold.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hold record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the hold amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `hold_number` STRING COMMENT 'Business identifier assigned to the hold, used in communications and reporting.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold.. Valid values are `active|released|escalated|cancelled`',
    `hold_type` STRING COMMENT 'Category of the hold, indicating the underlying business reason.. Valid values are `credit|quality|regulatory|export|customer_dispute|other`',
    `is_regulatory_compliant` BOOLEAN COMMENT 'Indicates whether the hold satisfies all applicable regulatory requirements.',
    `placed_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was initially placed on the order.',
    `priority` STRING COMMENT 'Priority level assigned to the hold for escalation handling.. Valid values are `low|medium|high|critical`',
    `reason_code` STRING COMMENT 'Standardized code representing the specific reason for the hold.',
    `reason_description` STRING COMMENT 'Free‑text description providing details about why the hold was placed.',
    `release_authorization` STRING COMMENT 'Identifier of the person or system that authorized the hold release.',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was released or cleared.',
    `resolution_notes` STRING COMMENT 'Notes documenting actions taken to resolve or release the hold.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the hold record.',
    CONSTRAINT pk_product_hold PRIMARY KEY(`product_hold_id`)
) COMMENT 'Record of a hold placed on a sales order preventing further processing or shipment. Captures hold ID, hold type (credit hold, quality hold, regulatory hold, export compliance hold, customer dispute hold), hold reason code, hold placed by, hold placed timestamp, hold release timestamp, release authorization, and resolution notes. Supports credit management integration with SAP FI/CO and quality hold integration with QM module. Tracks order blockage duration for SLA and customer service reporting.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`returns_order` (
    `returns_order_id` BIGINT COMMENT 'System-generated surrogate key uniquely identifying the return order record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who initiated the return.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Returns are processed per lot to manage quality quarantine and regulatory compliance; linking enables the Returns Quality Inspection workflow.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Return processing is performed by a specific employee; tracking supports credit memo audit and quality investigations.',
    `product_order_id` BIGINT COMMENT 'System identifier of the original sales order linked to this return.',
    `actual_return_date` DATE COMMENT 'Date the returned goods were actually received.',
    `coa_attached` BOOLEAN COMMENT 'True if a Certificate of Analysis (COA) is attached to the return record.',
    `coc_attached` BOOLEAN COMMENT 'True if a Certificate of Compliance (COC) is attached to the return record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this return order record was first captured in the lakehouse.',
    `credit_memo_eligible` BOOLEAN COMMENT 'Indicates whether the return qualifies for a credit memo to the customer.',
    `currency_code` STRING COMMENT 'Three‑letter currency code for monetary values (e.g., USD, EUR).',
    `disposal_instruction` STRING COMMENT 'Business instruction for how the returned product should be handled after receipt.. Valid values are `restock|destroy|rework|scrap|return_to_supplier`',
    `expected_return_date` DATE COMMENT 'Planned date by which the returned goods are expected to arrive at the plant.',
    `inspection_result_code` STRING COMMENT 'Standardized code representing the outcome of the inspection.',
    `inspection_status` STRING COMMENT 'Current status of the quality inspection performed on the returned product.. Valid values are `pending|passed|failed|rework_needed`',
    `logistics_provider` STRING COMMENT 'Name or code of the carrier responsible for transporting the return.',
    `net_refund_amount` DECIMAL(18,2) COMMENT 'Refund amount after tax and any applicable deductions.',
    `notes` STRING COMMENT 'Additional free‑form comments or instructions related to the return.',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant or warehouse receiving the returned goods.',
    `quality_issue_description` STRING COMMENT 'Free‑text description of any quality problems discovered.',
    `quality_issue_flag` BOOLEAN COMMENT 'Indicates whether a quality issue was identified during inspection.',
    `refund_amount_gross` DECIMAL(18,2) COMMENT 'Total monetary value of the return before taxes and deductions.',
    `return_condition` STRING COMMENT 'Physical condition of the returned product.. Valid values are `new|like_new|used|damaged|scrap`',
    `return_date` TIMESTAMP COMMENT 'Timestamp when the return order was created or submitted by the customer.',
    `return_order_number` STRING COMMENT 'Business-visible identifier assigned to the return order by the source system.',
    `return_quantity` DECIMAL(18,2) COMMENT 'Quantity of product being returned, expressed in the unit of measure.',
    `return_reason_code` STRING COMMENT 'Standardized code describing why the product is being returned.. Valid values are `defective|damaged|wrong_product|excess_inventory|quality_complaint|other`',
    `returns_order_status` STRING COMMENT 'Current lifecycle state of the return order.. Valid values are `draft|submitted|approved|rejected|closed|cancelled`',
    `shipping_method` STRING COMMENT 'Mode of transportation used for the return shipment.. Valid values are `ground|air|rail|sea`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the refund.',
    `tracking_number` STRING COMMENT 'Carrier‑provided tracking identifier for the return shipment.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the return quantity (e.g., kg, L, pcs).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this return order record.',
    CONSTRAINT pk_returns_order PRIMARY KEY(`returns_order_id`)
) COMMENT 'Customer return order (RMA) capturing the authorization and processing of product returns from customers. Captures return order number, original sales order reference, return reason code (OOS, damaged, wrong product, excess inventory, quality complaint), return quantity, return condition, plant receiving the return, credit memo eligibility, disposal instructions (restock, destroy, rework), and return logistics details. Maps to SAP SD Returns Order (VA01 with order type RE) and reverse logistics workflow.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` (
    `handling_instruction_id` BIGINT COMMENT 'Primary key for handling_instruction',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Special handling instructions are authored by a responsible employee; audit trail is required for safety and regulatory reviews.',
    `applicable_cas_number` STRING COMMENT 'Chemical Abstracts Service number identifying the chemical substance.. Valid values are `^d{2,7}-d{2}-d$`',
    `applicable_product_code` STRING COMMENT 'Product code (SKU) to which this handling instruction applies.',
    `applicable_region` STRING COMMENT 'Three‑letter country code indicating the geographic region where the instruction applies.. Valid values are `^[A-Z]{3}$`',
    `attachment_flag` BOOLEAN COMMENT 'Indicates whether supporting documents (COA, COC) are attached.',
    `carrier_restriction` STRING COMMENT 'Allowed transportation modes for the product.. Valid values are `air|sea|road|rail|any`',
    `compliance_document_reference` STRING COMMENT 'Identifier of the regulatory document (e.g., SOP, MSDS) that mandates this instruction.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the instruction record was created.',
    `effective_end_date` DATE COMMENT 'Date after which the instruction is no longer applicable (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which the instruction is valid for use.',
    `emergency_contact_email` STRING COMMENT 'Email address for emergency communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Name of the person or department to contact in an emergency.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for emergency communications.',
    `handling_fee_amount` DECIMAL(18,2) COMMENT 'Monetary charge associated with the special handling.',
    `handling_fee_currency` STRING COMMENT 'Three‑letter ISO currency code for the handling fee.. Valid values are `^[A-Z]{3}$`',
    `handling_instruction_status` STRING COMMENT 'Current lifecycle status of the instruction.. Valid values are `active|inactive|retired|draft`',
    `hazard_code` STRING COMMENT 'UN identification number for the hazardous material.',
    `hazardous_material_class` STRING COMMENT 'Hazard class of the material (limited to primary six classes; additional classes may be added via reference table).. Valid values are `class_1|class_2|class_3|class_4|class_5|class_6`',
    `humidity_max_percent` DECIMAL(18,2) COMMENT 'Highest allowable relative humidity level.',
    `humidity_min_percent` DECIMAL(18,2) COMMENT 'Lowest allowable relative humidity level.',
    `inert_atmosphere_required` BOOLEAN COMMENT 'Indicates whether an inert gas environment is mandatory.',
    `instruction_code` STRING COMMENT 'Business code used to reference the instruction in ERP and logistics systems.',
    `instruction_name` STRING COMMENT 'Human‑readable name describing the handling instruction.',
    `instruction_type` STRING COMMENT 'Category of the instruction indicating the primary handling requirement.. Valid values are `temperature_control|segregation|inert_atmosphere|pressure_vessel|special_packaging|hazardous_material_handling`',
    `is_mandatory` BOOLEAN COMMENT 'True if the instruction must be followed for the product.',
    `labeling_requirement` STRING COMMENT 'Labeling details such as hazard symbols, temperature icons, or carrier marks.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the instruction.',
    `packaging_requirement` STRING COMMENT 'Specific packaging needed (e.g., double‑walled, UN‑rated container).',
    `pressure_max_bar` DECIMAL(18,2) COMMENT 'Highest permissible pressure for the product.',
    `pressure_min_bar` DECIMAL(18,2) COMMENT 'Lowest permissible pressure for the product.',
    `pressure_vessel_required` BOOLEAN COMMENT 'Indicates whether transport must use a pressure‑rated vessel.',
    `regulatory_basis` STRING COMMENT 'Regulatory framework that drives the handling requirement.. Valid values are `DOT_49CFR|IATA_DGR|IMDG|EPA|OSHA`',
    `segregation_requirement` STRING COMMENT 'Instructions to keep the product separate from incompatible chemicals.',
    `special_equipment_needed` STRING COMMENT 'Equipment required for handling (e.g., forklift, crane, ventilated pallet).',
    `storage_location_requirement` STRING COMMENT 'Specific storage location constraints (e.g., refrigerated warehouse, ventilated area).',
    `temperature_control_method` STRING COMMENT 'Method used to maintain temperature (e.g., refrigerated, heated, ambient).',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Highest permissible temperature for storage or transport.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Lowest permissible temperature for storage or transport.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the instruction.',
    `version_number` STRING COMMENT 'Incremental version of the instruction for change tracking.',
    CONSTRAINT pk_handling_instruction PRIMARY KEY(`handling_instruction_id`)
) COMMENT 'Customer-specific or product-specific handling instructions for chemical products requiring non-standard treatment during order fulfillment. Captures instruction type (temperature-controlled storage/transport, segregation from incompatible materials, inert atmosphere, pressure vessel requirements), applicable product codes, effective date range, packaging requirements, labeling requirements, carrier restrictions, and regulatory basis (DOT 49 CFR, IATA DGR, IMDG Code). Ensures safe and compliant handling from warehouse pick through final delivery.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` (
    `fulfillment_milestone_id` BIGINT COMMENT 'Primary key for fulfillment_milestone',
    `product_order_id` BIGINT COMMENT 'Identifier of the sales order to which this milestone belongs.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Milestone ownership is assigned to a specific employee; needed for performance tracking and exception handling.',
    `actual_date` DATE COMMENT 'Date on which the milestone was actually completed.',
    `batch_number` STRING COMMENT 'Identifier of the production batch associated with the milestone, when applicable.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier handling the shipment.',
    `compliance_document_attached` BOOLEAN COMMENT 'Indicates whether required regulatory documents (e.g., SDS, COA) are attached to the milestone record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the lakehouse.',
    `customs_clearance_status` STRING COMMENT 'Current status of customs clearance for cross‑border shipments.. Valid values are `cleared|pending|failed`',
    `delivery_window_end` DATE COMMENT 'End date of the expected delivery window for the order.',
    `delivery_window_start` DATE COMMENT 'Start date of the expected delivery window for the order.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the milestone is considered critical for on‑time delivery (True) or not (False).',
    `location_code` STRING COMMENT 'Code identifying the plant, warehouse, or logistics hub where the milestone occurs.',
    `milestone_status` STRING COMMENT 'Current state of the milestone indicating whether it is pending, completed, delayed, or cancelled.. Valid values are `pending|completed|delayed|cancelled`',
    `milestone_type` STRING COMMENT 'Category of the fulfillment step (e.g., order confirmed, production scheduled, batch released, goods issued, in transit, delivered).. Valid values are `order_confirmed|production_scheduled|batch_released|goods_issued|in_transit|delivered`',
    `notes` STRING COMMENT 'Free‑form comments or special handling instructions related to the milestone.',
    `planned_date` DATE COMMENT 'Date originally scheduled for the milestone to be achieved.',
    `proof_of_delivery_received` BOOLEAN COMMENT 'True when a signed proof of delivery (POD) has been captured for the shipment.',
    `responsible_party` STRING COMMENT 'Internal team, department, or external partner accountable for executing the milestone.',
    `shipping_mode` STRING COMMENT 'Mode of transportation used for the shipment related to the milestone.. Valid values are `air|sea|road|rail`',
    `source_system` STRING COMMENT 'Originating system that generated the milestone record (e.g., SAP Sales & Distribution, Oracle Transportation Management, Manufacturing Execution System, Warehouse Management System).. Valid values are `SAP_SD|OTM|MES|WMS`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the milestone record.',
    `variance_days` STRING COMMENT 'Difference in days between planned_date and actual_date (positive = delay, negative = early).',
    CONSTRAINT pk_fulfillment_milestone PRIMARY KEY(`fulfillment_milestone_id`)
) COMMENT 'Tracks key fulfillment milestones for a sales order from confirmation through final delivery, providing end-to-end order visibility for customer service and supply chain teams. Captures milestone type (order confirmed, production scheduled, batch released, goods issued, in transit, customs cleared, delivered, POD received), planned date, actual date, variance in days, responsible party, and milestone source system (SAP SD, OTM, MES). Enables on-time delivery (OTD) KPI calculation and proactive customer communication.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` (
    `proof_of_delivery_id` BIGINT COMMENT 'System-generated unique identifier for the proof of delivery record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer who received the shipment.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle used for the delivery (e.g., trailer number).',
    `product_order_id` BIGINT COMMENT 'Identifier of the sales order associated with this delivery.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: POD process records the internal employee who received the shipment, required for traceability and liability.',
    `batch_number` STRING COMMENT 'Batch identifier associated with the shipped product.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier that performed the delivery.',
    `carrier_scac` STRING COMMENT 'Standard Carrier Alpha Code identifying the carrier.',
    `condition` STRING COMMENT 'Condition of the goods upon receipt.. Valid values are `intact|damaged|short|overage|missing`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the POD record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the signed amount.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `delivery_location` STRING COMMENT 'Physical address or site where the goods were delivered.',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment was physically received by the customer.',
    `discrepancy_notes` STRING COMMENT 'Free‑text notes describing any discrepancies observed.',
    `humidity_percent` DOUBLE COMMENT 'Relative humidity measured at the delivery site at receipt.',
    `is_closed` BOOLEAN COMMENT 'Indicates whether the delivery fulfillment cycle is closed.',
    `is_invoice_released` BOOLEAN COMMENT 'Indicates whether the POD triggered invoice release in SAP SD.',
    `lot_number` STRING COMMENT 'Lot number of the chemical product delivered.',
    `pod_document_number` STRING COMMENT 'Reference number of the POD document (paper or electronic).',
    `pod_method` STRING COMMENT 'Method used to capture the POD (e.g., electronic signature, paper scan, EDI 214).. Valid values are `electronic_signature|paper_scan|edi_214`',
    `pod_number` STRING COMMENT 'External reference number assigned to the POD document.',
    `pod_receipt_timestamp` TIMESTAMP COMMENT 'Timestamp when the POD document was recorded in the system.',
    `proof_of_delivery_status` STRING COMMENT 'Current lifecycle status of the POD record.. Valid values are `delivered|pending|rejected|cancelled|partial`',
    `quantity_uom` STRING COMMENT 'Unit of measure for the signed quantity.. Valid values are `kg|lb|gal|L|pcs`',
    `receiving_contact_name` STRING COMMENT 'Name of the person who signed for the delivery.',
    `receiving_contact_phone` STRING COMMENT 'Phone number of the receiving contact.',
    `signed_amount` DECIMAL(18,2) COMMENT 'Monetary value of the goods as confirmed by the POD.',
    `signed_quantity` DECIMAL(18,2) COMMENT 'Quantity of product confirmed as received by the customer.',
    `temperature_celsius` DOUBLE COMMENT 'Temperature recorded at the delivery site at receipt.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the POD record.',
    CONSTRAINT pk_proof_of_delivery PRIMARY KEY(`proof_of_delivery_id`)
) COMMENT 'Proof of Delivery (POD) record confirming that a chemical shipment has been received by the customer at the agreed delivery point. Captures POD document number, delivery number, actual delivery date and time, receiving contact name, delivery location, signed quantity, condition on receipt (intact, damaged, short), discrepancy notes, POD method (electronic signature, paper scan, EDI 214), and POD receipt timestamp. Triggers invoice release in SAP SD and closes the order fulfillment cycle.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique identifier for the product certification record.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the product this certification applies to.',
    `renewed_certification_id` BIGINT COMMENT 'Self-referencing FK on certification (renewed_certification_id)',
    `audit_date` DATE COMMENT 'Date of the most recent audit related to the certification.',
    `certificate_number` STRING COMMENT 'Unique number assigned by the certifying body.',
    `certification_status` STRING COMMENT 'Current status of the certification.. Valid values are `active|expired|suspended|withdrawn`',
    `certification_type` STRING COMMENT 'Type of certification held by the product.. Valid values are `ISO 9001|ISO 14001|Food Grade|Pharma Grade|Kosher|Halal`',
    `certifying_body` STRING COMMENT 'Organization that issued the certification.',
    `effective_end_date` DATE COMMENT 'Date when the certification ceases to be effective, if different from expiry.',
    `effective_start_date` DATE COMMENT 'Date when the certification becomes effective.',
    `expiry_date` DATE COMMENT 'Date when the certification expires.',
    `issue_date` DATE COMMENT 'Date when the certification was issued.',
    `jurisdiction` STRING COMMENT 'Specific regulatory authority or jurisdiction.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the certification.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the certification record was created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    `record_version` STRING COMMENT 'Version number for optimistic concurrency control.',
    `registration_number` STRING COMMENT 'Official registration number associated with the certification.',
    `regulatory_region` STRING COMMENT 'Geographic region or regulatory jurisdiction for the certification.',
    `renewal_interval_months` STRING COMMENT 'Number of months between required renewals.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the certification requires renewal.',
    `scope_of_certification` STRING COMMENT 'Description of the product scope covered by the certification.',
    `source_system` STRING COMMENT 'System of record where the certification data originated.',
    `version_number` STRING COMMENT 'Version identifier of the certification document.',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Product certification master record tracking all quality, safety, and regulatory certifications held by a chemical product or grade. Captures certification type (ISO 9001, ISO 14001, food-grade/FCC, pharmaceutical-grade/USP/EP, kosher, halal, NSF/ANSI 60, FDA FCN, organic, ISCC PLUS), certifying body, certificate number, issue date, expiry date, scope of certification, audit date, renewal requirements, and certification status (active, expired, suspended, withdrawn). Supports customer qualification questionnaires, food-contact compliance, pharma supply chain audits, and sustainability certifications (ISCC, RSB). Critical for Chemical Mfg customers in food, pharma, and personal care sectors who require certified supply chain documentation.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`order_amendment` (
    `order_amendment_id` BIGINT COMMENT 'Unique identifier for the order amendment record.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the product line before substitution.',
    `employee_id` BIGINT COMMENT 'System identifier of the user who entered the amendment request.',
    `site_id` BIGINT COMMENT 'Address identifier for shipment before the amendment.',
    `product_order_id` BIGINT COMMENT 'Identifier of the original sales order being amended.',
    `superseded_order_amendment_id` BIGINT COMMENT 'Self-referencing FK on order_amendment (superseded_order_amendment_id)',
    `after_delivery_date` DATE COMMENT 'Requested delivery date after the amendment.',
    `after_price_per_unit` DECIMAL(18,2) COMMENT 'Unit price of the product after the amendment.',
    `after_quantity` DECIMAL(18,2) COMMENT 'Ordered quantity value after the amendment.',
    `amendment_number` STRING COMMENT 'Business identifier for the amendment, often sequential per order.',
    `amendment_timestamp` TIMESTAMP COMMENT 'Date‑time when the amendment was created in the source system.',
    `amendment_type` STRING COMMENT 'Category of change applied to the original order.. Valid values are `quantity_change|delivery_date_change|product_substitution|pricing_adjustment|ship_to_change|cancellation`',
    `approval_status` STRING COMMENT 'Current approval workflow status for the amendment.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the amendment was approved or rejected.',
    `attachment_flag` BOOLEAN COMMENT 'True if any supporting documents (e.g., COA, COC) are attached to the amendment.',
    `before_delivery_date` DATE COMMENT 'Requested delivery date before the amendment.',
    `before_price_per_unit` DECIMAL(18,2) COMMENT 'Unit price of the product before the amendment.',
    `before_quantity` DECIMAL(18,2) COMMENT 'Ordered quantity value prior to the amendment.',
    `change_initiator` STRING COMMENT 'Indicates whether the amendment was requested by the customer or an internal stakeholder.. Valid values are `customer|internal`',
    `change_summary` STRING COMMENT 'Concise summary of all changes made by the amendment.',
    `coa_attached` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis is attached.',
    `coc_attached` BOOLEAN COMMENT 'Indicates whether a Certificate of Compliance is attached.',
    `comments` STRING COMMENT 'Free‑form comments entered by the initiator or approver.',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Monetary impact of the amendment on the order total.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment record was first captured.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost impact.',
    `impact_assessment` STRING COMMENT 'Narrative assessment of cost, schedule, and compliance impacts.',
    `is_customer_reconfirmed` BOOLEAN COMMENT 'Indicates whether the customer has re‑confirmed the amended order.',
    `order_amendment_status` STRING COMMENT 'Current lifecycle status of the amendment.. Valid values are `draft|submitted|approved|implemented|rejected|cancelled`',
    `reason_code` STRING COMMENT 'Standardized code representing the business reason for the amendment.',
    `reason_description` STRING COMMENT 'Free‑text description of why the amendment was required.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the amendment complies with all applicable chemical regulations.',
    `schedule_impact_days` STRING COMMENT 'Number of days the amendment shifts the delivery schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the amendment record.',
    `version_number` STRING COMMENT 'Version counter for the amendment record; increments on each edit before finalization.',
    CONSTRAINT pk_order_amendment PRIMARY KEY(`order_amendment_id`)
) COMMENT 'Formal change record documenting modifications to a confirmed sales order, capturing amendment number, amendment date, change initiator (customer or internal), change type (quantity change, delivery date change, product substitution, pricing adjustment, ship-to change, cancellation of lines), before and after values for each changed field, customer re-confirmation status, approval workflow status, reason code, and impact assessment (cost impact, schedule impact). Critical in chemical B2B where order modifications require formal change management, customer written acceptance, and full audit trail for commercial dispute resolution. Each amendment is immutable once confirmed.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`pricing_condition_assignment` (
    `pricing_condition_assignment_id` BIGINT COMMENT 'Primary key for the PricingConditionAssignment association',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to the chemical product',
    `condition_id` BIGINT COMMENT 'Foreign key linking to the pricing condition',
    `condition_application_rule` STRING COMMENT 'Business rule defining how the condition is applied (e.g., per quantity, per value)',
    `priority` STRING COMMENT 'Order of evaluation when multiple conditions apply',
    `validity_end_date` DATE COMMENT 'Date after which the condition is no longer effective for the product',
    `validity_start_date` DATE COMMENT 'Date from which the condition becomes effective for the product',
    CONSTRAINT pk_pricing_condition_assignment PRIMARY KEY(`pricing_condition_assignment_id`)
) COMMENT 'This association captures the assignment of pricing conditions to chemical products. It records which condition applies to which product along with attributes that exist only in the context of this relationship, such as priority and validity period.. Existence Justification: In chemical manufacturing, each chemical product can have multiple pricing conditions (e.g., base price, discounts, surcharges) and each pricing condition can be applied to many chemical products. The assignment of a condition to a product is actively managed in SAP with attributes such as priority and validity dates, making the relationship a standalone business entity.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`allocation` (
    `allocation_id` BIGINT COMMENT 'Primary key for the allocation association',
    `line_item_id` BIGINT COMMENT 'FK to the sales order line item',
    `po_line_id` BIGINT COMMENT 'FK to the purchase order line',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity of material allocated from the PO line to the sales line',
    `delivery_date` DATE COMMENT 'Planned delivery date for the allocated quantity',
    CONSTRAINT pk_allocation PRIMARY KEY(`allocation_id`)
) COMMENT 'Represents the allocation of purchased raw material (po_line) to a customer sales order line_item. Each record captures the quantity and delivery date specific to that allocation.. Existence Justification: In chemical manufacturing, a sales order line can be fulfilled by multiple purchase order lines, and a purchase order line can supply multiple sales order lines. Planners allocate specific quantities and delivery dates from PO lines to each sales line, creating a managed allocation record.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`product`.`product_family` (
    `product_family_id` BIGINT COMMENT 'Primary key for product_family',
    `parent_family_id` BIGINT COMMENT 'Identifier of the immediate parent family, if this family is a sub‑family.',
    `parent_product_family_id` BIGINT COMMENT 'Self-referencing FK on product_family (parent_product_family_id)',
    `application_guidelines` STRING COMMENT 'Recommended usage and application instructions for the family.',
    `base_price` DECIMAL(18,2) COMMENT 'Standard list price for the family before discounts or regional adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the product family record was first created in the system.',
    `product_family_description` STRING COMMENT 'Detailed textual description of the product family, including key characteristics.',
    `effective_from` DATE COMMENT 'Date when the product family became effective for sales.',
    `effective_until` DATE COMMENT 'Date when the product family is retired or no longer sold (null if open‑ended).',
    `family_code` STRING COMMENT 'External reference code or SKU prefix that uniquely identifies the family across systems.',
    `family_name` STRING COMMENT 'Human‑readable name of the product family used in catalogs and reports.',
    `family_type` STRING COMMENT 'Categorization of the family by product segment within chemical manufacturing.',
    `ghs_classification` STRING COMMENT 'GHS hazard classification for the family. [ENUM-REF-CANDIDATE: 0|1|2|3|4|5|6|7|8|9 — promote to reference product]',
    `hazardous` BOOLEAN COMMENT 'Flag indicating whether the family is classified as hazardous.',
    `hazardous_class` STRING COMMENT 'Specific hazardous class according to regulatory standards.',
    `last_reviewed_by` STRING COMMENT 'User identifier of the person who performed the last review.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance or data quality review.',
    `market_region` STRING COMMENT 'Primary geographic market region where the family is sold.',
    `packaging_configuration` STRING COMMENT 'Standard packaging options (e.g., drum, tote, bulk) offered for the family.',
    `product_hierarchy_level` STRING COMMENT 'Numeric level indicating the familys position in the product hierarchy (e.g., 1 = top level).',
    `regulatory_status` STRING COMMENT 'Regulatory compliance status of the family across major jurisdictions.',
    `safety_data_sheet_url` STRING COMMENT 'Link to the electronic Safety Data Sheet (SDS) for the family.',
    `product_family_status` STRING COMMENT 'Current lifecycle state of the product family.',
    `typical_weight_kg` DECIMAL(18,2) COMMENT 'Average net weight per standard unit of the family, expressed in kilograms.',
    `unit_of_measure` STRING COMMENT 'Default unit of measure used for inventory and sales of the family.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the product family record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_product_family PRIMARY KEY(`product_family_id`)
) COMMENT 'Master reference table for product_family. Referenced by product_family_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ADD CONSTRAINT `fk_product_chemical_product_product_family_id` FOREIGN KEY (`product_family_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_family`(`product_family_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sds`(`sds_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_tds_id` FOREIGN KEY (`tds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`tds`(`tds_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ADD CONSTRAINT `fk_product_grade_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ADD CONSTRAINT `fk_product_grade_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sds`(`sds_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ADD CONSTRAINT `fk_product_grade_tds_id` FOREIGN KEY (`tds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`tds`(`tds_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ADD CONSTRAINT `fk_product_product_specification_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ADD CONSTRAINT `fk_product_product_specification_superseded_specification_product_specification_id` FOREIGN KEY (`superseded_specification_product_specification_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_specification`(`product_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ADD CONSTRAINT `fk_product_tds_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ADD CONSTRAINT `fk_product_sds_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ADD CONSTRAINT `fk_product_product_ghs_classification_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ADD CONSTRAINT `fk_product_product_ghs_classification_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sds`(`sds_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ADD CONSTRAINT `fk_product_product_ghs_classification_superseded_by_classification_product_ghs_classification_id` FOREIGN KEY (`superseded_by_classification_product_ghs_classification_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_ghs_classification`(`product_ghs_classification_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ADD CONSTRAINT `fk_product_regulatory_status_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ADD CONSTRAINT `fk_product_hierarchy_parent_node_hierarchy_id` FOREIGN KEY (`parent_node_hierarchy_id`) REFERENCES `chemical_mfg_ecm`.`product`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ADD CONSTRAINT `fk_product_packaging_config_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ADD CONSTRAINT `fk_product_composition_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ADD CONSTRAINT `fk_product_cross_reference_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ADD CONSTRAINT `fk_product_substitution_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ADD CONSTRAINT `fk_product_substitution_substitution_substitute_product_chemical_product_id` FOREIGN KEY (`substitution_substitute_product_chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ADD CONSTRAINT `fk_product_reach_dossier_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ADD CONSTRAINT `fk_product_exposure_scenario_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ADD CONSTRAINT `fk_product_product_order_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `chemical_mfg_ecm`.`product`.`sds`(`sds_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ADD CONSTRAINT `fk_product_line_item_handling_instruction_id` FOREIGN KEY (`handling_instruction_id`) REFERENCES `chemical_mfg_ecm`.`product`.`handling_instruction`(`handling_instruction_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ADD CONSTRAINT `fk_product_order_confirmation_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ADD CONSTRAINT `fk_product_order_confirmation_handling_instruction_id` FOREIGN KEY (`handling_instruction_id`) REFERENCES `chemical_mfg_ecm`.`product`.`handling_instruction`(`handling_instruction_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ADD CONSTRAINT `fk_product_order_delivery_schedule_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ADD CONSTRAINT `fk_product_order_delivery_schedule_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ADD CONSTRAINT `fk_product_outbound_delivery_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ADD CONSTRAINT `fk_product_status_event_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ADD CONSTRAINT `fk_product_product_hold_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ADD CONSTRAINT `fk_product_returns_order_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ADD CONSTRAINT `fk_product_fulfillment_milestone_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ADD CONSTRAINT `fk_product_proof_of_delivery_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_renewed_certification_id` FOREIGN KEY (`renewed_certification_id`) REFERENCES `chemical_mfg_ecm`.`product`.`certification`(`certification_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ADD CONSTRAINT `fk_product_order_amendment_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ADD CONSTRAINT `fk_product_order_amendment_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_order`(`product_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ADD CONSTRAINT `fk_product_order_amendment_superseded_order_amendment_id` FOREIGN KEY (`superseded_order_amendment_id`) REFERENCES `chemical_mfg_ecm`.`product`.`order_amendment`(`order_amendment_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`pricing_condition_assignment` ADD CONSTRAINT `fk_product_pricing_condition_assignment_chemical_product_id` FOREIGN KEY (`chemical_product_id`) REFERENCES `chemical_mfg_ecm`.`product`.`chemical_product`(`chemical_product_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`allocation` ADD CONSTRAINT `fk_product_allocation_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `chemical_mfg_ecm`.`product`.`line_item`(`line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_family` ADD CONSTRAINT `fk_product_product_family_parent_family_id` FOREIGN KEY (`parent_family_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_family`(`product_family_id`);
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_family` ADD CONSTRAINT `fk_product_product_family_parent_product_family_id` FOREIGN KEY (`parent_product_family_id`) REFERENCES `chemical_mfg_ecm`.`product`.`product_family`(`product_family_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `chemical_mfg_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Compound Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `product_family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Analytical Method Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `application_guidelines` SET TAGS ('dbx_business_glossary_term' = 'Application Guidelines');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = 'KG|L|MT|GAL|LB|TON');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `density_kg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Density (Kilograms per Liter)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Product Discontinuation Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `fda_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Approval Required');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `ghs_pictograms` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Pictograms');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `hap_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Air Pollutant (HAP) Content (Percent)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `introduction_date` SET TAGS ('dbx_business_glossary_term' = 'Product Introduction Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `lifecycle_state` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle State');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `lifecycle_state` SET TAGS ('dbx_value_regex' = 'active|discontinued|developmental|phased_out|pending_approval|obsolete');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `list_price_usd` SET TAGS ('dbx_business_glossary_term' = 'List Price (United States Dollar)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `list_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `packaging_configuration` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'Potential of Hydrogen (pH) Value');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `physical_form` SET TAGS ('dbx_business_glossary_term' = 'Physical Form');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `primary_chemical_sds_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'bulk|packaged|specialty|custom_blend|intermediate');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{10}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `reach_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `reach_status` SET TAGS ('dbx_value_regex' = 'registered|pre_registered|exempt|not_applicable|pending');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost (United States Dollar)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `standard_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `tsca_status` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `tsca_status` SET TAGS ('dbx_value_regex' = 'active|inactive|exempt|not_on_inventory');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `viscosity_cps` SET TAGS ('dbx_business_glossary_term' = 'Viscosity (Centipoise)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`chemical_product` ALTER COLUMN `voc_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Volatile Organic Compound (VOC) Content (Percent)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `tds_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Data Sheet (TDS) Document Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `application_area` SET TAGS ('dbx_business_glossary_term' = 'Application Area');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point in Celsius');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `is_controlled_substance` SET TAGS ('dbx_business_glossary_term' = 'Is Controlled Substance');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Material (HAZMAT)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight in Kilograms');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'Potential of Hydrogen (pH) Value');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Days');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `sku_description` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Description');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `sku_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending_approval|blocked|phase_out');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature in Celsius');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature in Celsius');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `tsca_status` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `tsca_status` SET TAGS ('dbx_value_regex' = 'listed|exempt|not_listed|pending');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sku` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Product Grade Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `quality_manager_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `tds_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Data Sheet Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `acs_reagent_flag` SET TAGS ('dbx_business_glossary_term' = 'American Chemical Society (ACS) Reagent Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `application_sector` SET TAGS ('dbx_business_glossary_term' = 'Application Sector');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `base_price_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Base Price Per Kilogram');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `base_price_per_kg` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `certificate_of_analysis_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `certificate_of_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Compliance (COC) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `ep_grade_flag` SET TAGS ('dbx_business_glossary_term' = 'European Pharmacopoeia (EP) Grade Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `fcc_grade_flag` SET TAGS ('dbx_business_glossary_term' = 'Food Chemicals Codex (FCC) Grade Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `gmp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliant Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `grade_code` SET TAGS ('dbx_business_glossary_term' = 'Grade Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `grade_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `grade_description` SET TAGS ('dbx_business_glossary_term' = 'Grade Description');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `grade_name` SET TAGS ('dbx_business_glossary_term' = 'Grade Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `grade_status` SET TAGS ('dbx_business_glossary_term' = 'Grade Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `grade_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|under_development|pending_approval');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Handling Requirements');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `intended_use_description` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Description');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `maximum_impurity_ppm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Impurity Parts Per Million (PPM)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `minimum_order_quantity_kg` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Kilograms');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `minimum_purity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purity Percentage');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `packaging_configuration` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|ultra_premium|economy');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `reach_registered_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registered Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Months');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Maximum Celsius');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Minimum Celsius');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `tsca_listed_flag` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Listed Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`grade` ALTER COLUMN `usp_grade_flag` SET TAGS ('dbx_business_glossary_term' = 'United States Pharmacopeia (USP) Grade Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `superseded_specification_product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Specification Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `criticality_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `customer_specific_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Specific Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Specification Document Uniform Resource Locator (URL)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `ghs_classification_relevance` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification Relevance');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `iso_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) Standard Reference');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `lims_test_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Test Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `maximum_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Value');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `minimum_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Value');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `reach_registration_relevance` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Relevance');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `sampling_plan` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `sds_section_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Section Reference');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'draft|under-review|approved|active|superseded|obsolete');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_value_regex' = 'release|in-process|shelf-life|stability|raw-material|intermediate');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `test_frequency` SET TAGS ('dbx_business_glossary_term' = 'Test Frequency');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `test_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `tsca_compliance_relevance` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Compliance Relevance');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_specification` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `tds_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Data Sheet (TDS) ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `appearance` SET TAGS ('dbx_business_glossary_term' = 'Product Appearance');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `application_summary` SET TAGS ('dbx_business_glossary_term' = 'Product Application Summary');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'TDS Approved By');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'TDS Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `boiling_point_unit` SET TAGS ('dbx_business_glossary_term' = 'Boiling Point Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `boiling_point_unit` SET TAGS ('dbx_value_regex' = '°C|°F');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `boiling_point_value` SET TAGS ('dbx_business_glossary_term' = 'Boiling Point Value');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `compatibility_notes` SET TAGS ('dbx_business_glossary_term' = 'Material Compatibility Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `document_file_path` SET TAGS ('dbx_business_glossary_term' = 'TDS Document File Path');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Technical Data Sheet (TDS) Document Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^TDS-[A-Z0-9]{6,12}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'TDS Document URL');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `document_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'TDS Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'TDS Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `flash_point_unit` SET TAGS ('dbx_business_glossary_term' = 'Flash Point Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `flash_point_unit` SET TAGS ('dbx_value_regex' = '°C|°F');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `flash_point_value` SET TAGS ('dbx_business_glossary_term' = 'Flash Point Value');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `handling_precautions` SET TAGS ('dbx_business_glossary_term' = 'Handling Precautions');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'TDS Language Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `odor` SET TAGS ('dbx_business_glossary_term' = 'Product Odor');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `performance_data_reference` SET TAGS ('dbx_business_glossary_term' = 'Performance Data Reference');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH (Potential of Hydrogen) Value');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `physical_form` SET TAGS ('dbx_business_glossary_term' = 'Physical Form');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `recommended_use_concentration` SET TAGS ('dbx_business_glossary_term' = 'Recommended Use Concentration');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `revision_notes` SET TAGS ('dbx_business_glossary_term' = 'TDS Revision Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `sds_document_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `sds_document_number` SET TAGS ('dbx_value_regex' = '^SDS-[A-Z0-9]{6,12}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `solubility_description` SET TAGS ('dbx_business_glossary_term' = 'Solubility Description');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `tds_status` SET TAGS ('dbx_business_glossary_term' = 'TDS Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `tds_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|published|superseded|obsolete');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'TDS Version Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `viscosity_unit` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `viscosity_unit` SET TAGS ('dbx_value_regex' = 'cP|cSt|mPa·s|Pa·s');
ALTER TABLE `chemical_mfg_ecm`.`product`.`tds` ALTER COLUMN `viscosity_value` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Value');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `accidental_release_measures` SET TAGS ('dbx_business_glossary_term' = 'Accidental Release Measures');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'SDS Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'SDS Approved By');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `boiling_point_c` SET TAGS ('dbx_business_glossary_term' = 'Boiling Point (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `california_prop65_listed` SET TAGS ('dbx_business_glossary_term' = 'California Proposition 65 Listed');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Color');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'SDS Country Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `disposal_considerations` SET TAGS ('dbx_business_glossary_term' = 'Disposal Considerations');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^SDS-[A-Z0-9]{6,12}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'SDS Document Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'Draft|Active|Superseded|Archived');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'SDS Document URL');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `dot_packing_group` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Packing Group');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `dot_packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `dot_un_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) United Nations (UN) Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `dot_un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `ec_number` SET TAGS ('dbx_business_glossary_term' = 'European Community (EC) Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `ec_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{3}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `ecological_information` SET TAGS ('dbx_business_glossary_term' = 'Ecological Information');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'SDS Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `exposure_limits` SET TAGS ('dbx_business_glossary_term' = 'Occupational Exposure Limits');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `firefighting_measures` SET TAGS ('dbx_business_glossary_term' = 'Firefighting Measures');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `first_aid_measures` SET TAGS ('dbx_business_glossary_term' = 'First Aid Measures');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `handling_precautions` SET TAGS ('dbx_business_glossary_term' = 'Handling Precautions');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `hazard_statements` SET TAGS ('dbx_business_glossary_term' = 'GHS Hazard Statements (H-codes)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `iata_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Shipping Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `imdg_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Dangerous Goods (IMDG) Shipping Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'SDS Language Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `melting_point_c` SET TAGS ('dbx_business_glossary_term' = 'Melting Point (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `odor` SET TAGS ('dbx_business_glossary_term' = 'Odor');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'Potential of Hydrogen (pH) Value');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'Solid|Liquid|Gas|Powder|Granular|Paste');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `pictogram_codes` SET TAGS ('dbx_business_glossary_term' = 'GHS Pictogram Codes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `precautionary_statements` SET TAGS ('dbx_business_glossary_term' = 'GHS Precautionary Statements (P-codes)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'SDS Prepared By');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `regulatory_information` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Information');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'SDS Revision Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'SDS Revision Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `sara_313_reportable` SET TAGS ('dbx_business_glossary_term' = 'Superfund Amendments and Reauthorization Act (SARA) 313 Reportable');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `signal_word` SET TAGS ('dbx_business_glossary_term' = 'GHS Signal Word');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `signal_word` SET TAGS ('dbx_value_regex' = 'Danger|Warning');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `solubility_in_water` SET TAGS ('dbx_business_glossary_term' = 'Solubility in Water');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `supersedes_date` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `toxicological_information` SET TAGS ('dbx_business_glossary_term' = 'Toxicological Information');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `tsca_status` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `tsca_status` SET TAGS ('dbx_value_regex' = 'Listed|Exempt|Not Listed|Pending');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `vapor_pressure_mmhg` SET TAGS ('dbx_business_glossary_term' = 'Vapor Pressure (mmHg)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`sds` ALTER COLUMN `voc_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Volatile Organic Compound (VOC) Content Percent');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `product_ghs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'GHS (Globally Harmonized System) Classification ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'SDS (Safety Data Sheet) Document ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `superseded_by_classification_product_ghs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Classification ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS (Chemical Abstracts Service) Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `classification_authority` SET TAGS ('dbx_business_glossary_term' = 'Classification Authority');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `classification_authority` SET TAGS ('dbx_value_regex' = 'self_classification|echa_harmonized|competent_authority|third_party');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `classification_basis` SET TAGS ('dbx_business_glossary_term' = 'Classification Basis');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `classification_basis` SET TAGS ('dbx_value_regex' = 'test_data|read_across|qsar|expert_judgment|literature_review|bridging');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `classification_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `classification_notes` SET TAGS ('dbx_business_glossary_term' = 'Classification Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_business_glossary_term' = 'Classification Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|under_review|withdrawn');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `classification_version` SET TAGS ('dbx_business_glossary_term' = 'GHS Classification Version');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `classifier_name` SET TAGS ('dbx_business_glossary_term' = 'Classifier Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `clp_notification_number` SET TAGS ('dbx_business_glossary_term' = 'CLP (Classification Labelling and Packaging) Notification Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `cmr_classification` SET TAGS ('dbx_business_glossary_term' = 'CMR (Carcinogenic Mutagenic Reprotoxic) Classification');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `ec_number` SET TAGS ('dbx_business_glossary_term' = 'EC (European Community) Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `environmental_hazard_categories` SET TAGS ('dbx_business_glossary_term' = 'Environmental Hazard Categories');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `environmental_hazard_classes` SET TAGS ('dbx_business_glossary_term' = 'Environmental Hazard Classes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `hazard_statement_codes` SET TAGS ('dbx_business_glossary_term' = 'Hazard Statement Codes (H-Codes)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `health_hazard_categories` SET TAGS ('dbx_business_glossary_term' = 'Health Hazard Categories');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `health_hazard_categories` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `health_hazard_categories` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `health_hazard_classes` SET TAGS ('dbx_business_glossary_term' = 'Health Hazard Classes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `health_hazard_classes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `health_hazard_classes` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `label_generation_required` SET TAGS ('dbx_business_glossary_term' = 'Label Generation Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `physical_hazard_categories` SET TAGS ('dbx_business_glossary_term' = 'Physical Hazard Categories');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `physical_hazard_classes` SET TAGS ('dbx_business_glossary_term' = 'Physical Hazard Classes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `pictogram_codes` SET TAGS ('dbx_business_glossary_term' = 'GHS Pictogram Codes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `precautionary_statement_codes` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Statement Codes (P-Codes)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'REACH Registration Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `signal_word` SET TAGS ('dbx_business_glossary_term' = 'Signal Word');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `signal_word` SET TAGS ('dbx_value_regex' = 'danger|warning|none');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `test_data_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Data Reference');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `tsca_inventory_status` SET TAGS ('dbx_business_glossary_term' = 'TSCA (Toxic Substances Control Act) Inventory Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_ghs_classification` ALTER COLUMN `tsca_inventory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|not_listed');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `regulatory_status_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'REGISTERED|NOTIFIED|EXEMPT|RESTRICTED|PROHIBITED|PENDING');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `ec_number` SET TAGS ('dbx_business_glossary_term' = 'European Community (EC) Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `ec_number` SET TAGS ('dbx_value_regex' = '^d{3}-d{3}-d$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'USA|EUR|CHN|JPN|KOR|CAN');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `pfas_flag` SET TAGS ('dbx_business_glossary_term' = 'Per- and Polyfluoroalkyl Substances (PFAS) Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `pmn_number` SET TAGS ('dbx_business_glossary_term' = 'Pre-Manufacture Notice (PMN) Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `prop_65_listing_flag` SET TAGS ('dbx_business_glossary_term' = 'California Proposition 65 Listing Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `reach_registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `reach_registration_type` SET TAGS ('dbx_value_regex' = 'FULL|INTERMEDIATE|TRANSPORTED_ISOLATED|NOT_APPLICABLE');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `registration_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `regulation_type` SET TAGS ('dbx_business_glossary_term' = 'Regulation Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `regulation_type` SET TAGS ('dbx_value_regex' = 'REACH|TSCA|SARA_313|PROP_65|ROHS|SVHC');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Email');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `restriction_conditions` SET TAGS ('dbx_business_glossary_term' = 'Restriction Conditions');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `sara_313_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Superfund Amendments and Reauthorization Act (SARA) 313 Reportable Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `substance_role` SET TAGS ('dbx_business_glossary_term' = 'Substance Role');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `substance_role` SET TAGS ('dbx_value_regex' = 'MANUFACTURER|IMPORTER|ONLY_REPRESENTATIVE|DOWNSTREAM_USER');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `svhc_candidate_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Substance of Very High Concern (SVHC) Candidate List Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `tonnage_band` SET TAGS ('dbx_business_glossary_term' = 'Tonnage Band');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `tonnage_band` SET TAGS ('dbx_value_regex' = '1_TO_10|10_TO_100|100_TO_1000|OVER_1000|NOT_APPLICABLE');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `tsca_inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Inventory Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`regulatory_status` ALTER COLUMN `tsca_inventory_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|NOT_ON_INVENTORY|NOT_APPLICABLE');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` SET TAGS ('dbx_subdomain' = 'supply_logistics');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `parent_node_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Hierarchy Node Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `application_category` SET TAGS ('dbx_business_glossary_term' = 'Application Category');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `division_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `ebitda_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reporting Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `external_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'External Hierarchy Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `ghs_hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Hazard Category');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'commercial|technical|regulatory|application|geographic');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `is_leaf_node` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf Node Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `legacy_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Legacy Hierarchy Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `level_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `level_name` SET TAGS ('dbx_value_regex' = 'division|business_unit|product_family|product_line|product_group|sub_group');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `node_depth` SET TAGS ('dbx_business_glossary_term' = 'Node Depth');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `node_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Description');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `node_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated|archived');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `product_family_code` SET TAGS ('dbx_business_glossary_term' = 'Product Family Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `product_family_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `product_line_manager` SET TAGS ('dbx_business_glossary_term' = 'Product Line Manager');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'tsca_listed|reach_registered|ghs_classified|fda_approved|epa_registered|not_regulated');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `sales_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `sap_product_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Product Hierarchy Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `sap_product_hierarchy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{18}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `sort_sequence` SET TAGS ('dbx_business_glossary_term' = 'Sort Sequence');
ALTER TABLE `chemical_mfg_ecm`.`product`.`hierarchy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` SET TAGS ('dbx_subdomain' = 'supply_logistics');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `packaging_config_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'L|GAL|M3|KG|LB');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `closure_type` SET TAGS ('dbx_business_glossary_term' = 'Closure Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `customer_specific_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer-Specific Packaging Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `dot_label_required` SET TAGS ('dbx_business_glossary_term' = 'DOT (Department of Transportation) Label Required');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `fill_volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Fill Volume (Liters)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `fill_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Fill Weight (Kilograms)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `food_grade_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Food Grade Certified Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `ghs_label_required` SET TAGS ('dbx_business_glossary_term' = 'GHS (Globally Harmonized System) Label Required');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `height_mm` SET TAGS ('dbx_business_glossary_term' = 'Height (Millimeters)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `iata_label_required` SET TAGS ('dbx_business_glossary_term' = 'IATA (International Air Transport Association) Label Required');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `imdg_label_required` SET TAGS ('dbx_business_glossary_term' = 'IMDG (International Maritime Dangerous Goods) Label Required');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `length_mm` SET TAGS ('dbx_business_glossary_term' = 'Length (Millimeters)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `material_of_construction` SET TAGS ('dbx_business_glossary_term' = 'Material of Construction');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `material_of_construction` SET TAGS ('dbx_value_regex' = 'hdpe|steel|stainless_steel|fiber|aluminum|lined');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `nominal_capacity` SET TAGS ('dbx_business_glossary_term' = 'Nominal Capacity');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `outer_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Outer Diameter (Millimeters)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `packaging_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `packaging_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `packaging_config_status` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `packaging_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|obsolete|restricted');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `packaging_group` SET TAGS ('dbx_business_glossary_term' = 'Packaging Group (PG)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `packaging_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `pallet_type` SET TAGS ('dbx_business_glossary_term' = 'Pallet Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `pharmaceutical_grade_flag` SET TAGS ('dbx_business_glossary_term' = 'Pharmaceutical Grade Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `preferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Packaging Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `region_restriction` SET TAGS ('dbx_business_glossary_term' = 'Region Restriction');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `returnable_flag` SET TAGS ('dbx_business_glossary_term' = 'Returnable Packaging Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `stack_height_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stack Height');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `tare_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (Kilograms)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `un_packaging_code` SET TAGS ('dbx_business_glossary_term' = 'UN (United Nations) Packaging Certification Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `un_packaging_code` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9A-Z]{1,4}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `units_per_pallet` SET TAGS ('dbx_business_glossary_term' = 'Units Per Pallet');
ALTER TABLE `chemical_mfg_ecm`.`product`.`packaging_config` ALTER COLUMN `width_mm` SET TAGS ('dbx_business_glossary_term' = 'Width (Millimeters)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `composition_id` SET TAGS ('dbx_business_glossary_term' = 'Product Composition ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Component Supplier ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Component Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_concentration_range_flag` SET TAGS ('dbx_business_glossary_term' = 'Concentration Range Indicator');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Component Concentration Unit');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_concentration_unit` SET TAGS ('dbx_value_regex' = 'percent|weight_percent|volume_percent|ppm|ppb');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_concentration_value` SET TAGS ('dbx_business_glossary_term' = 'Component Concentration Value');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_ec_number` SET TAGS ('dbx_business_glossary_term' = 'European Community (EC) Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_ec_number` SET TAGS ('dbx_value_regex' = '^d{3}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Component Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_function` SET TAGS ('dbx_business_glossary_term' = 'Component Function in Mixture');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_function` SET TAGS ('dbx_value_regex' = 'active|solvent|stabilizer|surfactant|filler|other');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'GHS Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_hazard_class` SET TAGS ('dbx_value_regex' = 'flammable|corrosive|toxic|environmental|oxidizer|irritant');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_hazard_statement` SET TAGS ('dbx_business_glossary_term' = 'GHS Hazard Statement');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_iupac_name` SET TAGS ('dbx_business_glossary_term' = 'International Union of Pure and Applied Chemistry (IUPAC) Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Component Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_physical_state` SET TAGS ('dbx_business_glossary_term' = 'Component Physical State');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas|solution');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_precautionary_statement` SET TAGS ('dbx_business_glossary_term' = 'GHS Precautionary Statement');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_purity` SET TAGS ('dbx_business_glossary_term' = 'Component Purity Percentage');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_purity_unit` SET TAGS ('dbx_business_glossary_term' = 'Component Purity Unit');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_purity_unit` SET TAGS ('dbx_value_regex' = 'percent');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_quantity` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity Unit');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_quantity_unit` SET TAGS ('dbx_value_regex' = 'kg|g|mg|lb|oz');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_regulatory_number` SET TAGS ('dbx_business_glossary_term' = 'Component Regulatory Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Component Regulatory Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_regulatory_status` SET TAGS ('dbx_value_regex' = 'registered|listed|exempt|restricted');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `component_trade_name` SET TAGS ('dbx_business_glossary_term' = 'Component Trade Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `composition_status` SET TAGS ('dbx_business_glossary_term' = 'Composition Record Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `composition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Business Information (CBI) Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `disclosure_threshold` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Threshold Applicable');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `disclosure_threshold` SET TAGS ('dbx_value_regex' = 'osha|reach|sara313|none');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Composition Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Composition End Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Composition Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap_mm|labware_lims|intelex_ehs');
ALTER TABLE `chemical_mfg_ecm`.`product`.`composition` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Composition Version');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `cross_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Product Cross Reference Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `cross_reference_status` SET TAGS ('dbx_business_glossary_term' = 'Cross Reference Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `cross_reference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `customer_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `equivalence_type` SET TAGS ('dbx_business_glossary_term' = 'Equivalence Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `equivalence_type` SET TAGS ('dbx_value_regex' = 'identical|equivalent|similar|substitute');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cross Reference Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `quality_hold_substitution_allowed` SET TAGS ('dbx_business_glossary_term' = 'Quality‑Hold Substitution Allowed');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `reference_owner` SET TAGS ('dbx_business_glossary_term' = 'Reference Owner');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `reference_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `reference_type` SET TAGS ('dbx_value_regex' = 'internal|competitor|legacy|customer_specific|distributor');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'REACH_compliant|TSCA_compliant|non_compliant');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `stock_out_substitution_allowed` SET TAGS ('dbx_business_glossary_term' = 'Stock‑Out Substitution Allowed');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `substitution_condition` SET TAGS ('dbx_business_glossary_term' = 'Substitution Condition');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `substitution_direction` SET TAGS ('dbx_business_glossary_term' = 'Substitution Direction');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `substitution_direction` SET TAGS ('dbx_value_regex' = 'bidirectional|one_way');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `substitution_type` SET TAGS ('dbx_business_glossary_term' = 'Substitution Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `substitution_type` SET TAGS ('dbx_value_regex' = 'direct|conditional|emergency');
ALTER TABLE `chemical_mfg_ecm`.`product`.`cross_reference` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `substitution_id` SET TAGS ('dbx_business_glossary_term' = 'Product Substitution Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Original Product Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `substitution_substitute_product_chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Product Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `condition_customer_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `condition_quality_hold` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Condition Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `condition_stock_out` SET TAGS ('dbx_business_glossary_term' = 'Stock‑Out Condition Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Substitution Direction');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'bidirectional|one_way');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Substitution Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `substitution_status` SET TAGS ('dbx_business_glossary_term' = 'Substitution Rule Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `substitution_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|revoked');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_business_glossary_term' = 'Substitution Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_value_regex' = 'direct|conditional|emergency');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `reach_dossier_id` SET TAGS ('dbx_business_glossary_term' = 'Reach Dossier Identifier (REACH_DOSSIER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service Number (CAS)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes (COMPLIANCE_NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `csr_document_reference` SET TAGS ('dbx_business_glossary_term' = 'CSR Document Reference (CSR_DOC_REF)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `csr_required` SET TAGS ('dbx_business_glossary_term' = 'Chemical Safety Report Required Flag (CSR_REQUIRED)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `dossier_status` SET TAGS ('dbx_business_glossary_term' = 'Dossier Lifecycle Status (DOSSIER_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `dossier_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|withdrawn');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `dossier_update_date` SET TAGS ('dbx_business_glossary_term' = 'Dossier Update Date (DOSSIER_UPDATE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `ec_number` SET TAGS ('dbx_business_glossary_term' = 'European Community Number (EC_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `ec_number` SET TAGS ('dbx_value_regex' = '^EC-d+$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `echa_submission_date` SET TAGS ('dbx_business_glossary_term' = 'ECHA Submission Date (ECHA_SUB_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `echa_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'ECHA Submission Reference (ECHA_SUB_REF)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `echa_submission_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Dossier Expiry Date (EXPIRY_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `exposure_scenarios_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Exposure Scenarios (EXPOSURE_SCENARIOS_COUNT)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification (HAZARD_CLASS)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'flammable|corrosive|toxic|environmental_hazard|none');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category (PRODUCT_CATEGORY)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'performance_material|plastic|agricultural_solution|specialty_chemical');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `registrant_role` SET TAGS ('dbx_business_glossary_term' = 'Registrant Role (REGISTRANT_ROLE)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `registrant_role` SET TAGS ('dbx_value_regex' = 'lead|member|coordinator');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date (REG_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'REACH Registration Number (REG_NUM)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status (REGULATORY_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'registered|pending|rejected');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `risk_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Completed Flag (RISK_ASSESSMENT_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `sief_membership` SET TAGS ('dbx_business_glossary_term' = 'SIEF Membership Indicator (SIEF_MEMBER)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `sief_membership` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `substance_iupac_name` SET TAGS ('dbx_business_glossary_term' = 'Substance IUPAC Name (IUPAC_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `tonnage_band` SET TAGS ('dbx_business_glossary_term' = 'Tonnage Band (TONNAGE_BAND)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `tonnage_band` SET TAGS ('dbx_value_regex' = '0-1t|1-10t|10-100t|>100t');
ALTER TABLE `chemical_mfg_ecm`.`product`.`reach_dossier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `exposure_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Exposure Scenario Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `amount_used_kg` SET TAGS ('dbx_business_glossary_term' = 'Amount Used (kg)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `article_category_code` SET TAGS ('dbx_business_glossary_term' = 'Article Category (AC) Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `contributing_scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Contributing Scenario Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `dnel_unit` SET TAGS ('dbx_business_glossary_term' = 'DNEL Unit');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `dnel_value` SET TAGS ('dbx_business_glossary_term' = 'Derived No‑Effect Level (DNEL)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `environmental_release_category_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Release Category (ERC) Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Scenario Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `operational_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Operational Duration (minutes)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `operational_frequency_per_day` SET TAGS ('dbx_business_glossary_term' = 'Operational Frequency (per day)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `operational_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Operational Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `pnec_unit` SET TAGS ('dbx_business_glossary_term' = 'PNEC Unit');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `pnec_value` SET TAGS ('dbx_business_glossary_term' = 'Predicted No‑Effect Concentration (PNEC)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `process_category_code` SET TAGS ('dbx_business_glossary_term' = 'Process Category (PROC) Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category (PC) Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `rcr_value` SET TAGS ('dbx_business_glossary_term' = 'Risk Characterisation Ratio (RCR)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'REACH|TSCA|GHS|EU|US');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `risk_management_measure_containment` SET TAGS ('dbx_business_glossary_term' = 'Containment Requirement');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `risk_management_measure_ppe` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `risk_management_measure_ventilation` SET TAGS ('dbx_business_glossary_term' = 'Ventilation Requirement');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `scenario_code` SET TAGS ('dbx_business_glossary_term' = 'Exposure Scenario Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `scenario_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Scenario Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `scenario_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Scenario Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Exposure Scenario Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `scenario_status` SET TAGS ('dbx_business_glossary_term' = 'Exposure Scenario Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `scenario_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `sector_of_use_code` SET TAGS ('dbx_business_glossary_term' = 'Sector of Use (SU) Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`product`.`exposure_scenario` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUSTOMER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `asset_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (CONTRACT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `distributor_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (SALES_REP_ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `patent_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Formula Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Identifier (BILL_ADDR_ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Proposal Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Identifier (COMPL_DOC_ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `shipping_address_site_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Identifier (SHIP_ADDR_ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `shipping_address_site_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `shipping_address_site_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Cycle Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISC_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel (DIST_CHAN)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division Code (DIVISION)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate (EXCH_RATE)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms (FREIGHT_TERMS)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Order Amount (GROSS_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag (HAZ_MAT_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (INCO_TERM)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FCA|FOB|CFR|CIF|DDP');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `is_backorder` SET TAGS ('dbx_business_glossary_term' = 'Backorder Indicator (BACKORDER_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `is_split` SET TAGS ('dbx_business_glossary_term' = 'Order Split Indicator (SPLIT_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `line_count` SET TAGS ('dbx_business_glossary_term' = 'Order Line Count (LINE_COUNT)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Order Amount (NET_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number (SO_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source (ORDER_SOURCE)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'SAP|CRM|EDI');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status (SO_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|open|confirmed|fulfilled|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Creation Timestamp (SO_CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type (SO_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|rush|blanket|consignment|return');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERM)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority (PRIORITY)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date (REQ_DEL_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `sales_org` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code (SALES_ORG)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region (SALES_REGION)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method (SHIP_METHOD)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'ground|air|sea|rail');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions (SPECIAL_HANDLING)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Status Reason (SO_STATUS_REASON)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Order Volume (VOL_M3)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Order Weight (WT_KG)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `opportunity_product_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `handling_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instruction Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `batch_determination_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Determination Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `coa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `ehs_hazard_statement` SET TAGS ('dbx_business_glossary_term' = 'Hazard Statement');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `ehs_precautionary_statement` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Statement');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Class');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `is_gmp_compliant` SET TAGS ('dbx_business_glossary_term' = 'GMP Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `last_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `line_comment` SET TAGS ('dbx_business_glossary_term' = 'Line Comment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|confirmed|shipped|cancelled|backordered');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `material_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `material_sds_url` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet URL');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `moq_enforced_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity Enforced Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Unit Price');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `partial_delivery_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Delivery Allowed Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `temperature_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`product`.`line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|L|MT|drum');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `order_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Order Confirmation ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `handling_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instruction Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `coa_attached` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis Attached');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `coc_attached` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Compliance Attached');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number (CN)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `delivery_date_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `delivery_date_requested` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `dot_classification` SET TAGS ('dbx_business_glossary_term' = 'DOT Hazard Classification');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lot Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms (Incoterms)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `ghs_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `is_deviation` SET TAGS ('dbx_business_glossary_term' = 'Deviation From Original Request');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `order_confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Order Confirmation Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `order_confirmation_status` SET TAGS ('dbx_value_regex' = 'draft|pending|confirmed|rejected|cancelled|completed');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'NET30|NET45|NET60|COD|PREPAID|ON_ACCOUNT');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit (PPU)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `quantity_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'air|ground|sea|rail|courier|pickup');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|L|gal|m3|ton');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_confirmation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `order_delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Order Delivery Schedule ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `trial_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Research Trial Batch Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `shipment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Transportation Route ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `carrier_scac` SET TAGS ('dbx_business_glossary_term' = 'Carrier SCAC Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Quantity');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Class');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `humidity_requirement_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Requirement (%)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm (International Commercial Terms)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `incoterm` SET TAGS ('dbx_value_regex' = 'EXW|FCA|FOB|CFR|CIF|DDP');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `is_jit` SET TAGS ('dbx_business_glossary_term' = 'Just-In-Time Delivery Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Scheduling Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `order_delivery_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `order_delivery_schedule_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|in_transit|delivered|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `regulatory_compliance_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `schedule_line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Sequence Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `scheduled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Quantity');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_business_glossary_term' = 'Shipping Condition');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_value_regex' = 'exworks|fob|cif|ddp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `temperature_requirement_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement (°C)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|ship|air|pipeline');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_delivery_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `outbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Delivery ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Party ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `batch_numbers` SET TAGS ('dbx_business_glossary_term' = 'Batch Numbers');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `coa_attachment_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis Attachment Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `coa_attachment_status` SET TAGS ('dbx_value_regex' = 'attached|missing');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `coc_attachment_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Compliance Attachment Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `coc_attachment_status` SET TAGS ('dbx_value_regex' = 'attached|missing');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'planned|released|picked|packed|shipped|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `delivery_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `delivery_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|temperature_controlled|hazardous');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'DOT Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `goods_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `packing_instructions` SET TAGS ('dbx_business_glossary_term' = 'Packing Instructions');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `ship_to_name` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Party Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `shipping_address` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `shipping_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `shipping_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `shipping_instruction_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipping Instruction Reference');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `shipping_point_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (m³)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|rail|air|sea|pipeline');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'UN Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`outbound_delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Status Event Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `event_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Event Source Reference');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `event_source_reference` SET TAGS ('dbx_value_regex' = 'SAP_SD|OTM|MES|WMS|Manual');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type (Milestone)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `is_manual` SET TAGS ('dbx_business_glossary_term' = 'Is Manual Entry');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Order Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Order Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `triggering_system` SET TAGS ('dbx_business_glossary_term' = 'Triggering System');
ALTER TABLE `chemical_mfg_ecm`.`product`.`status_event` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Variance (Days)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `product_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Placed By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (SO_ID)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Hold Amount (Monetary Value)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Number (HOLD_NO)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|escalated|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'credit|quality|regulatory|export|customer_dispute|other');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `is_regulatory_compliant` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placement Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Hold Priority');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code (HR_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `release_authorization` SET TAGS ('dbx_business_glossary_term' = 'Release Authorization Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `returns_order_id` SET TAGS ('dbx_business_glossary_term' = 'Return Order ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Original Sales Order ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `coa_attached` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis Attached');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `coc_attached` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Compliance Attached');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `credit_memo_eligible` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Eligibility');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `disposal_instruction` SET TAGS ('dbx_business_glossary_term' = 'Disposal Instruction');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `disposal_instruction` SET TAGS ('dbx_value_regex' = 'restock|destroy|rework|scrap|return_to_supplier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `inspection_result_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|rework_needed');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `logistics_provider` SET TAGS ('dbx_business_glossary_term' = 'Logistics Provider');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `net_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Refund Amount');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Return Order Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `quality_issue_description` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Description');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `quality_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `refund_amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Refund Amount');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `return_condition` SET TAGS ('dbx_business_glossary_term' = 'Return Condition');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `return_condition` SET TAGS ('dbx_value_regex' = 'new|like_new|used|damaged|scrap');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Order Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `return_order_number` SET TAGS ('dbx_business_glossary_term' = 'Return Order Number (RON)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `return_quantity` SET TAGS ('dbx_business_glossary_term' = 'Return Quantity');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'defective|damaged|wrong_product|excess_inventory|quality_complaint|other');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `returns_order_status` SET TAGS ('dbx_business_glossary_term' = 'Return Order Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `returns_order_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'ground|air|rail|sea');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`returns_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `handling_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Instruction Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `applicable_cas_number` SET TAGS ('dbx_business_glossary_term' = 'Applicable CAS Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `applicable_cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `applicable_product_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `applicable_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `applicable_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `carrier_restriction` SET TAGS ('dbx_business_glossary_term' = 'Carrier Restriction');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `carrier_restriction` SET TAGS ('dbx_value_regex' = 'air|sea|road|rail|any');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `compliance_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Reference');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `emergency_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Email');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `emergency_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `emergency_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `emergency_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `handling_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Handling Fee Amount');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `handling_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Handling Fee Currency');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `handling_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `handling_instruction_status` SET TAGS ('dbx_business_glossary_term' = 'Handling Instruction Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `handling_instruction_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `hazard_code` SET TAGS ('dbx_business_glossary_term' = 'Hazard Code (UN Number)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `hazardous_material_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Class');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `hazardous_material_class` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|class_4|class_5|class_6');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `humidity_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Relative Humidity (%)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `humidity_min_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Relative Humidity (%)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `inert_atmosphere_required` SET TAGS ('dbx_business_glossary_term' = 'Inert Atmosphere Required');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `instruction_code` SET TAGS ('dbx_business_glossary_term' = 'Handling Instruction Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `instruction_name` SET TAGS ('dbx_business_glossary_term' = 'Handling Instruction Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `instruction_type` SET TAGS ('dbx_business_glossary_term' = 'Handling Instruction Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `instruction_type` SET TAGS ('dbx_value_regex' = 'temperature_control|segregation|inert_atmosphere|pressure_vessel|special_packaging|hazardous_material_handling');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `labeling_requirement` SET TAGS ('dbx_business_glossary_term' = 'Labeling Requirement');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Handling Instruction Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `packaging_requirement` SET TAGS ('dbx_business_glossary_term' = 'Packaging Requirement');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `pressure_max_bar` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pressure (bar)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `pressure_min_bar` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pressure (bar)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `pressure_vessel_required` SET TAGS ('dbx_business_glossary_term' = 'Pressure Vessel Required');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'DOT_49CFR|IATA_DGR|IMDG|EPA|OSHA');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `segregation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Segregation Requirement');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `special_equipment_needed` SET TAGS ('dbx_business_glossary_term' = 'Special Equipment Needed');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `storage_location_requirement` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Requirement');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `temperature_control_method` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Method');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`handling_instruction` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `fulfillment_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Milestone Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `compliance_document_attached` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Attached');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|failed');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Milestone Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Location Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status (MS)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'pending|completed|delayed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type (MT)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'order_confirmed|production_scheduled|batch_released|goods_issued|in_transit|delivered');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `proof_of_delivery_received` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Received');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `shipping_mode` SET TAGS ('dbx_business_glossary_term' = 'Shipping Mode');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `shipping_mode` SET TAGS ('dbx_value_regex' = 'air|sea|road|rail');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_SD|OTM|MES|WMS');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`fulfillment_milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Milestone Variance (Days)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Vehicle Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `carrier_scac` SET TAGS ('dbx_business_glossary_term' = 'Carrier SCAC Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Received Condition');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `condition` SET TAGS ('dbx_value_regex' = 'intact|damaged|short|overage|missing');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Receiving Humidity (%)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `is_closed` SET TAGS ('dbx_business_glossary_term' = 'POD Closure Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `is_invoice_released` SET TAGS ('dbx_business_glossary_term' = 'Invoice Release Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `pod_document_number` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Document Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `pod_method` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Method');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `pod_method` SET TAGS ('dbx_value_regex' = 'electronic_signature|paper_scan|edi_214');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `pod_number` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Number (POD)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `pod_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'POD Receipt Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `proof_of_delivery_status` SET TAGS ('dbx_value_regex' = 'delivered|pending|rejected|cancelled|partial');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|gal|L|pcs');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `receiving_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Contact Name');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `receiving_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `receiving_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `receiving_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Receiving Contact Phone');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `receiving_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `receiving_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `signed_amount` SET TAGS ('dbx_business_glossary_term' = 'Signed Amount (USD)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `signed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `signed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `signed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Signed Quantity');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Receiving Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`proof_of_delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Certification ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `renewed_certification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|withdrawn');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'ISO 9001|ISO 14001|Food Grade|Pharma Grade|Kosher|Halal');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `renewal_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Interval (Months)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `scope_of_certification` SET TAGS ('dbx_business_glossary_term' = 'Scope of Certification');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`product`.`certification` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `order_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Amendment ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID Before Amendment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiator User ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Ship‑To Address ID Before Amendment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `superseded_order_amendment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `after_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date After Amendment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `after_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Unit Price After Amendment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `after_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity After Amendment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `amendment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amendment Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'quantity_change|delivery_date_change|product_substitution|pricing_adjustment|ship_to_change|cancellation');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Presence Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `before_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date Before Amendment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `before_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Unit Price Before Amendment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `before_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Before Amendment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `change_initiator` SET TAGS ('dbx_business_glossary_term' = 'Change Initiator (Customer or Internal)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `change_initiator` SET TAGS ('dbx_value_regex' = 'customer|internal');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `coa_attached` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis Attached Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `coc_attached` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Compliance Attached Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Amendment Comments');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Description');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `is_customer_reconfirmed` SET TAGS ('dbx_business_glossary_term' = 'Customer Reconfirmation Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `order_amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `order_amendment_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|implemented|rejected|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact (Days)');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`product`.`order_amendment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version Number');
ALTER TABLE `chemical_mfg_ecm`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`pricing_condition_assignment` SET TAGS ('dbx_association_edges' = 'product.chemical_product,pricing.pricing_condition');
ALTER TABLE `chemical_mfg_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `pricing_condition_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Pricingconditionassignment - Pricing Condition Assignment Id');
ALTER TABLE `chemical_mfg_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Pricingconditionassignment - Chemical Product Id');
ALTER TABLE `chemical_mfg_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `condition_id` SET TAGS ('dbx_business_glossary_term' = 'Pricingconditionassignment - Pricing Condition Id');
ALTER TABLE `chemical_mfg_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `condition_application_rule` SET TAGS ('dbx_business_glossary_term' = 'Application Rule');
ALTER TABLE `chemical_mfg_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Condition Priority');
ALTER TABLE `chemical_mfg_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Condition End Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`pricing_condition_assignment` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Condition Start Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`allocation` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `chemical_mfg_ecm`.`product`.`allocation` SET TAGS ('dbx_association_edges' = 'order.line_item,supply.po_line');
ALTER TABLE `chemical_mfg_ecm`.`product`.`allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Allocation Id');
ALTER TABLE `chemical_mfg_ecm`.`product`.`allocation` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Order Line Id');
ALTER TABLE `chemical_mfg_ecm`.`product`.`allocation` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Po Line Id');
ALTER TABLE `chemical_mfg_ecm`.`product`.`allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `chemical_mfg_ecm`.`product`.`allocation` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_family` SET TAGS ('dbx_subdomain' = 'product_master');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_family` ALTER COLUMN `product_family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Identifier');
ALTER TABLE `chemical_mfg_ecm`.`product`.`product_family` ALTER COLUMN `parent_product_family_id` SET TAGS ('dbx_self_ref_fk' = 'true');
