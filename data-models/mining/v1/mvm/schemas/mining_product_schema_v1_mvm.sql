-- Schema for Domain: product | Business: Mining | Version: v1_mvm
-- Generated on: 2026-05-05 14:20:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`product` COMMENT 'Defines the commodity product catalog including all saleable mineral products (iron ore fines, lump, copper concentrate, thermal coal, lithium hydroxide, nickel matte) with specifications, grade parameters, moisture limits, and packaging standards. Acts as the SSOT for product identity.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`product`.`commodity` (
    `commodity_id` BIGINT COMMENT 'Unique identifier for the commodity. Primary key for the commodity master catalog.',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Mining companies maintain dedicated GL accounts for each commodity type (iron ore revenue, copper revenue, coal revenue) for financial reporting, commodity-level P&L, and revenue recognition. Essentia',
    `benchmark_pricing_index` STRING COMMENT 'The market pricing index or benchmark used for commercial pricing of this commodity (e.g., Platts Iron Ore Index, LME Copper, Newcastle Coal Index, Fastmarkets Lithium Hydroxide).',
    `cim_definition_standard` STRING COMMENT 'CIM definition standard reference for the commodity used in Canadian mineral resource and reserve reporting.',
    `commodity_class` STRING COMMENT 'High-level classification of the commodity type. Used for strategic segmentation and market analysis.. Valid values are `base_metal|precious_metal|energy_mineral|industrial_mineral|battery_mineral|bulk_commodity`',
    `commodity_code` STRING COMMENT 'Standardized business identifier code for the commodity used across systems and external reporting. Aligns with SAP material master commodity grouping and JORC commodity classification.. Valid values are `^[A-Z0-9]{4,12}$`',
    `commodity_description` STRING COMMENT 'Detailed business description of the commodity including its characteristics, typical applications, and distinguishing features.',
    `commodity_group` STRING COMMENT 'Higher-level grouping or family to which this commodity belongs for reporting and analysis purposes (e.g., Iron Ore Products, Copper Products, Coal Products).',
    `commodity_name` STRING COMMENT 'Full business name of the commodity (e.g., Iron Ore, Copper Concentrate, Thermal Coal, Lithium Hydroxide, Nickel Matte).',
    `commodity_status` STRING COMMENT 'Current lifecycle status of the commodity in the product catalog. Active commodities are currently produced and sold.. Valid values are `active|inactive|discontinued|under_development`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this commodity record was first created in the system.',
    `effective_from_date` DATE COMMENT 'The date from which this commodity record became active and valid in the product catalog.',
    `effective_to_date` DATE COMMENT 'The date until which this commodity record is valid. Null indicates the record is currently active with no planned end date.',
    `environmental_classification` STRING COMMENT 'Environmental impact classification or category for the commodity based on extraction, processing, and disposal considerations.',
    `export_license_required` BOOLEAN COMMENT 'Indicates whether an export license or permit is required for international shipment of this commodity due to regulatory or strategic controls.',
    `hs_code` STRING COMMENT 'International Harmonized System tariff classification code used for customs, trade documentation, and export/import compliance.. Valid values are `^[0-9]{6,10}$`',
    `is_hazardous_material` BOOLEAN COMMENT 'Indicates whether the commodity is classified as a hazardous material requiring special handling, storage, and transportation protocols.',
    `jorc_commodity_type` STRING COMMENT 'JORC-compliant commodity type classification used for resource and reserve reporting to ensure alignment with Australian mineral reporting standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this commodity record was last updated or modified.',
    `primary_end_use_market` STRING COMMENT 'The principal industry or market segment that consumes this commodity (e.g., steel manufacturing, energy generation, battery production, construction materials).',
    `regulatory_classification` STRING COMMENT 'Regulatory or compliance classification code for the commodity as defined by governing bodies (e.g., JORC resource category, SEC S-K 1300 classification, CIM definition standards).',
    `royalty_applicable` BOOLEAN COMMENT 'Indicates whether government or third-party royalties apply to the production and sale of this commodity.',
    `samrec_commodity_code` STRING COMMENT 'SAMREC-compliant commodity code for operations reporting under South African mineral resource standards.',
    `standard_packaging_type` STRING COMMENT 'The standard packaging or shipment format for this commodity (e.g., bulk vessel, containerized, bagged, drummed).',
    `standard_unit_of_measure` STRING COMMENT 'The standard unit of measure used for quantifying and trading this commodity across all transactions and reporting.. Valid values are `tonne|kilogram|pound|troy_ounce|cubic_metre`',
    `strategic_importance_level` STRING COMMENT 'Internal strategic importance rating of the commodity to the business based on revenue contribution, market position, and long-term value.. Valid values are `critical|high|medium|low`',
    `trading_currency` STRING COMMENT 'The standard currency in which this commodity is priced and traded internationally. Three-letter ISO 4217 currency code.. Valid values are `^[A-Z]{3}$`',
    `typical_grade_range` STRING COMMENT 'The typical range of mineral grade or purity for this commodity as produced (e.g., 62-65% Fe for iron ore, 25-30% Cu for copper concentrate). Expressed as a text range for flexibility.',
    `typical_recovery_rate_percent` DECIMAL(18,2) COMMENT 'The typical percentage of valuable mineral extracted during processing for this commodity. Used for production planning and resource estimation.',
    CONSTRAINT pk_commodity PRIMARY KEY(`commodity_id`)
) COMMENT 'Master catalog of mineral commodity types produced by the mining operation (iron ore, copper, coal, lithium, nickel). Each record defines a top-level commodity identity with commodity code, commodity class (base metal, precious metal, energy mineral, industrial mineral, battery mineral), primary end-use market, standard unit of measure, and regulatory classification. Acts as the root of the product hierarchy with saleable_product records beneath it. Aligns with JORC commodity classification and SAP material master commodity grouping.';

CREATE OR REPLACE TABLE `mining_ecm`.`product`.`saleable_product` (
    `saleable_product_id` BIGINT COMMENT 'Unique identifier for each distinct saleable mineral product variant. Primary key. This is the system of record identifier that sales contracts, shipment nominations, quality certificates, and pricing schedules reference.',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory. Business justification: Export products require quality certificates from specific accredited laboratories for market access and customer acceptance. Tracks the approved certifying laboratory relationship for regulatory comp',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Establishes the fundamental product hierarchy: each saleable product is a variant of a commodity type (e.g., iron ore fines, lump, pellets are all variants of the iron ore commodity). The existing com',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Mining operations track which cost centre (processing plant, mine site) produces each saleable product for AISC/C1 cost reporting, product profitability analysis, and cost allocation. Essential for ma',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Mining companies create customer-specific product grades (e.g., iron ore fines to exact Fe% for a steel mill, coal blends for specific power plants). Enables customer-specific product catalog manageme',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Revenue recognition and inventory valuation require linking products to specific GL accounts (finished goods inventory accounts). Essential for automated inventory postings, month-end close, and IAS 2',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Saleable products are sourced from specific orebodies, establishing product traceability and provenance. Critical for quality variance analysis, customer provenance requirements, mine-to-market chain ',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Required for IFRS 8 segment reporting, commodity-level P&L, and product line profitability tracking. Mining companies report financial performance by commodity/product segment; this link enables produ',
    `royalty_obligation_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_obligation. Business justification: Royalty accrual and payment process: each saleable product is subject to specific royalty obligations (state/federal mineral royalties on iron ore, coal, copper). Linking saleable_product to its appli',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Saleable products must be traceable to source tenement for royalty obligations, regulatory compliance, and responsible sourcing certification. Required for statutory production reporting and ESG prove',
    `available_for_sale_flag` BOOLEAN COMMENT 'Indicates whether the product is currently available for inclusion in new sales contracts and shipment nominations. False when product is temporarily unavailable due to plant maintenance, feedstock constraints, or quality holds.',
    `benchmark_index` STRING COMMENT 'Name of the published commodity price index or assessment used as the reference for contract pricing. Examples: Platts IODEX 62% Fe CFR China, LME Nickel 3-month, IHS McCloskey Newcastle Coal, Fastmarkets MB Lithium Hydroxide CIF Asia. Empty for products with purely negotiated pricing.',
    `carbon_footprint_kg_co2e_per_tonne` DECIMAL(18,2) COMMENT 'Estimated greenhouse gas emissions intensity for producing one tonne of this saleable product, expressed as kilograms of CO2 equivalent. Includes Scope 1 and Scope 2 emissions from mining, processing, and on-site logistics. Used for customer carbon accounting and regulatory reporting.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country where the mineral was mined and processed. Required for customs declarations, trade compliance, and country-of-origin certifications. Examples: AUS (Australia), CAN (Canada), CHL (Chile), ZAF (South Africa).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this saleable product record was first created in the system. Represents when the product was formally added to the commercial product catalog.',
    `effective_from_date` DATE COMMENT 'Date from which this product definition and specifications are valid and can be referenced in new sales contracts. Supports versioning when product specifications are updated.',
    `effective_to_date` DATE COMMENT 'Date until which this product definition is valid. Null for currently active products. Populated when product is superseded by a new specification version or discontinued. Existing contracts referencing this product remain valid through their term.',
    `environmental_certification` STRING COMMENT 'Environmental or sustainability certification(s) held for this product, if any. Examples: ResponsibleSteel, Copper Mark, Initiative for Responsible Mining Assurance (IRMA), ISO 14001 Certified Site. Increasingly required by customers for ESG compliance and supply chain transparency.',
    `export_license_required_flag` BOOLEAN COMMENT 'Indicates whether an export license or permit is required from the country of origin government to ship this product internationally. True for strategic minerals, rare earths, or products subject to export controls or quotas.',
    `grade_specification` STRING COMMENT 'Target grade or concentration of the valuable mineral component expressed as percentage or parts per million. Examples: 62.0% Fe, 25% Cu, 70% Ni, 99.5% LiOH·H2O. This is the headline specification that drives product pricing and customer acceptance.',
    `hazmat_classification` STRING COMMENT 'International hazardous materials classification code if the product is regulated for transport. Examples: UN 3077 (Environmentally Hazardous Substance, Solid), UN 3264 (Corrosive Liquid, Acidic, Inorganic). Empty if product is non-hazardous. Governs shipping documentation, vessel requirements, and emergency response procedures.',
    `hs_code` STRING COMMENT 'International Harmonized System tariff classification code used for customs declarations and trade statistics. 6-digit HS code is internationally standardized; additional digits may be country-specific. Examples: 260111 (Iron ore and concentrates, non-agglomerated), 260300 (Copper ores and concentrates), 283691 (Lithium carbonates).. Valid values are `^[0-9]{6,10}$`',
    `impurity_limits` STRING COMMENT 'Specification of maximum allowable concentrations for deleterious impurity elements that negatively impact customer processing or final product quality. Expressed as comma-separated element:limit pairs. Examples: P:0.08%, S:0.05%, As:0.01% for iron ore; Hg:1ppm, Cd:5ppm for copper concentrate. Penalties may apply if limits are exceeded.',
    `incoterm_default` STRING COMMENT 'Default Incoterm used for pricing and risk transfer in sales contracts for this product. FOB (Free on Board) and CIF (Cost, Insurance and Freight) are most common for bulk mineral commodities. Defines seller and buyer responsibilities for logistics, insurance, and customs. [ENUM-REF-CANDIDATE: EXW|FCA|FAS|FOB|CFR|CIF|CPT|CIP|DAP|DPU|DDP — 11 candidates stripped; promote to reference product]',
    `lead_time_days` STRING COMMENT 'Standard lead time in calendar days from order confirmation to product availability for shipment. Includes production scheduling, processing, quality testing, and stockpile accumulation time. Does not include shipping transit time.',
    `lifecycle_status` STRING COMMENT 'Current stage in the products commercial lifecycle. Development: under testing, not yet offered. Qualified: approved for sale, customer trials ongoing. Active: fully commercialized and available. Sunset: being phased out, existing contracts honored. Discontinued: no longer offered or produced. Governs whether product can be included in new sales contracts.. Valid values are `development|qualified|active|sunset|discontinued`',
    `minimum_order_quantity_tonnes` DECIMAL(18,2) COMMENT 'Minimum commercial order quantity in metric tonnes. Driven by production batch sizes, shipping economics (vessel parcel sizes), and inventory management. Typical values: 50,000-170,000 tonnes for bulk iron ore/coal shipments, 500-2,000 tonnes for concentrates, 20-100 tonnes for specialty chemicals.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in this saleable product record. Used for change tracking and data synchronization across systems.',
    `moisture_content_max_pct` DECIMAL(18,2) COMMENT 'Maximum allowable moisture content as percentage of total mass. Critical specification for shipping weight calculations, pricing adjustments, and customer process efficiency. Typical ranges: iron ore 8-10%, coal 10-15%, concentrates 8-12%.',
    `notes` STRING COMMENT 'Free-text field for additional product information, special handling instructions, customer preferences, or internal comments not captured in structured fields. Used for operational context and knowledge transfer.',
    `packaging_standard` STRING COMMENT 'Standard packaging or shipping format for the product. Bulk options for high-volume commodities (iron ore, coal), containerized or bagged options for specialty products (lithium chemicals, precious metal concentrates). Determines logistics costs and handling requirements. [ENUM-REF-CANDIDATE: bulk_vessel|bulk_rail|bulk_truck|ibc_tote|drum|bag_1mt|bag_25kg|container_20ft|container_40ft — 9 candidates stripped; promote to reference product]',
    `pricing_basis` STRING COMMENT 'Mechanism by which the product price is determined in sales contracts. Spot: current market price at time of shipment. Monthly/Quarterly Average: average of published index over period. Annual Contract: negotiated fixed or formula price for calendar/fiscal year. Determines revenue predictability and exposure to commodity price volatility.. Valid values are `spot|monthly_average|quarterly_average|annual_contract|fixed_price|cost_plus`',
    `processing_route` STRING COMMENT 'Description of the mineral processing pathway from Run of Mine (ROM) ore to final saleable product. Examples: Crushing-Screening-DMS, SAG-Ball Mill-Flotation, HPGR-Magnetic Separation, Leach-SX-EW, Roast-Leach-Crystallization. Provides traceability to processing plant and technology used.',
    `product_code` STRING COMMENT 'Externally-known unique business identifier for the saleable product used in commercial documentation, contracts, and customer communications. Typically follows company-specific coding standards combining commodity type, grade, and form.. Valid values are `^[A-Z0-9]{6,12}$`',
    `product_form` STRING COMMENT 'Physical form or state of the processed mineral product. Determines handling requirements, shipping methods, and customer application suitability. Examples: fines (fine particles <6.3mm), lump (coarse particles 6.3-31.5mm), concentrate (beneficiated high-grade product), hydroxide (chemical compound), matte (intermediate smelting product). [ENUM-REF-CANDIDATE: fines|lump|concentrate|hydroxide|matte|cathode|pellets|briquettes|powder|ingot — 10 candidates stripped; promote to reference product]',
    `product_manager_name` STRING COMMENT 'Name of the commercial product manager or marketing manager responsible for this products market positioning, pricing strategy, and customer relationships. Business reference, not classified as PII.',
    `product_name` STRING COMMENT 'Human-readable commercial name of the saleable product as it appears on invoices, contracts, and marketing materials. Examples: Iron Ore Fines 62% Fe, Copper Concentrate 25% Cu, Thermal Coal 6000 kcal NAR, Lithium Hydroxide Monohydrate Battery Grade.',
    `product_specification_document_reference` STRING COMMENT 'Reference identifier or URI to the authoritative product specification document that defines all technical parameters, test methods, sampling protocols, and acceptance criteria. Typically a controlled document in the company document management system.',
    `quality_certificate_required_flag` BOOLEAN COMMENT 'Indicates whether a third-party or company-issued quality certificate (assay certificate, certificate of analysis) must accompany each shipment. True for most mineral concentrates and specialty products where grade and impurity verification is contractually required.',
    `shelf_life_days` STRING COMMENT 'Maximum storage duration in days before product quality may degrade below specification. Relevant for moisture-sensitive products (lithium chemicals, some concentrates) or products subject to oxidation. Null for stable bulk commodities with indefinite shelf life.',
    `sizing_specification` STRING COMMENT 'Particle size distribution specification defining the acceptable range of particle sizes, typically expressed as percentage passing through standard mesh screens. Example: 90% passing 6.3mm, 10% max passing 150 micron. Critical for customer handling systems and process performance.',
    `target_market_segment` STRING COMMENT 'Primary customer industry segment or end-use application for which this product variant is designed and marketed. Influences specification tolerances, packaging, and logistics requirements. [ENUM-REF-CANDIDATE: steel_mills|smelters|refineries|battery_manufacturers|chemical_plants|power_generation|construction|automotive|electronics — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_saleable_product PRIMARY KEY(`saleable_product_id`)
) COMMENT 'Each distinct saleable mineral product variant within a commodity, representing a unique commercial product with its own market identity. Examples: iron ore fines (62% Fe), iron ore lump (62.5% Fe), copper concentrate (25% Cu), thermal coal (6000 kcal NAR), lithium hydroxide monohydrate (battery grade), nickel matte (70% Ni). Captures product code, product form (fines/lump/concentrate/hydroxide/matte/cathode), processing route origin, target market segment, commercial lifecycle status (development, qualified, active, sunset, discontinued), and product availability flags. This is the SSOT for product identity — the entity that sales contracts, shipment nominations, and quality certificates reference. Lifecycle status governs whether the product can be offered commercially.';

CREATE OR REPLACE TABLE `mining_ecm`.`product`.`specification` (
    `specification_id` BIGINT COMMENT 'Unique identifier for the product specification record. Primary key.',
    `counterparty_id` BIGINT COMMENT 'Reference to the specific customer for whom this specification was created, applicable only when is_customer_specific is true.',
    `analytical_method_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_method. Business justification: Product specifications define required analytical methods for contractual quality assurance. Export products require specific accredited methods (e.g., ISO methods for iron ore). Links specification r',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: A specification defines the complete technical and commercial requirements for a specific saleable product. This is a core 1:N relationship (one saleable_product has many specification versions over t',
    `supersedes_specification_id` BIGINT COMMENT 'Reference to the previous product specification that this version replaces, enabling specification lineage tracking.',
    `approval_date` DATE COMMENT 'Date on which this product specification was formally approved for use in sales contracts and quality assurance processes.',
    `approved_by` STRING COMMENT 'Name or identifier of the competent person or authority who approved this product specification for commercial use.',
    `ash_percent` DECIMAL(18,2) COMMENT 'Ash content percentage for coal products, representing the non-combustible mineral matter remaining after complete combustion.',
    `bulk_density_t_per_m3` DECIMAL(18,2) COMMENT 'Bulk density of the product in tonnes per cubic meter, critical for storage, transport planning, and vessel loading calculations.',
    `calorific_value_kcal_per_kg` DECIMAL(18,2) COMMENT 'Gross calorific value for coal products in kilocalories per kilogram, representing the energy content and primary pricing parameter for thermal coal.',
    `commodity_type` STRING COMMENT 'Primary mineral commodity category that this specification applies to (iron ore, copper, coal, lithium, nickel, gold, zinc, lead, bauxite, manganese). [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|zinc|lead|bauxite|manganese — promote to reference product]. Valid values are `iron_ore|copper|coal|lithium|nickel|gold`',
    `contractual_reference` STRING COMMENT 'Reference to the master offtake agreement, sales contract, or commercial framework under which this specification is defined and enforced.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product specification record was first created in the system.',
    `effective_from_date` DATE COMMENT 'Date from which this product specification becomes valid and can be used in sales contracts and quality assurance processes.',
    `effective_to_date` DATE COMMENT 'Date until which this product specification remains valid. Null indicates an open-ended specification that is currently active.',
    `grade_basis` STRING COMMENT 'Basis on which chemical grade parameters are measured and reported (dry basis, as received, moisture free, air dried) for consistent quality assessment.. Valid values are `dry_basis|as_received|moisture_free|air_dried`',
    `guaranteed_al2o3_percent_max` DECIMAL(18,2) COMMENT 'Contractually guaranteed maximum alumina content percentage, above which penalties or rejection may apply due to processing constraints.',
    `guaranteed_cu_percent_min` DECIMAL(18,2) COMMENT 'Contractually guaranteed minimum copper content percentage for copper concentrate products, below which penalties or rejection may apply.',
    `guaranteed_fe_percent_min` DECIMAL(18,2) COMMENT 'Contractually guaranteed minimum iron content percentage for iron ore products, below which penalties or rejection may apply.',
    `guaranteed_moisture_percent_max` DECIMAL(18,2) COMMENT 'Contractually guaranteed maximum moisture content percentage, above which penalties, weight adjustments, or rejection may apply.',
    `guaranteed_sio2_percent_max` DECIMAL(18,2) COMMENT 'Contractually guaranteed maximum silica content percentage, above which penalties or rejection may apply due to quality constraints.',
    `guaranteed_sulfur_percent_max` DECIMAL(18,2) COMMENT 'Contractually guaranteed maximum sulfur content percentage, above which penalties or rejection may apply due to environmental and processing constraints.',
    `is_customer_specific` BOOLEAN COMMENT 'Flag indicating whether this specification is tailored for a specific customer (true) or represents a standard product offering (false).',
    `is_export_specification` BOOLEAN COMMENT 'Flag indicating whether this specification is used for export sales (true) or domestic sales (false), affecting regulatory compliance and documentation requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product specification record was last modified, enabling change tracking and audit trail.',
    `moisture_measurement_method` STRING COMMENT 'Standard method used for moisture content determination (oven drying, Karl Fischer titration, microwave, infrared, thermogravimetric analysis).. Valid values are `oven_drying|karl_fischer|microwave|infrared|tga`',
    `p80_microns` DECIMAL(18,2) COMMENT 'Particle size in microns at which 80% of the material by weight passes through, a key comminution and processing parameter.',
    `packaging_requirement` STRING COMMENT 'Required packaging method for the product (bulk, bagged, containerized, intermediate bulk container, drums, supersacks) as specified in the sales contract.. Valid values are `bulk|bagged|containerized|ibc|drums|supersacks`',
    `quality_standard_reference` STRING COMMENT 'Reference to the international or industry quality standard (ISO, ASTM, JORC, CIM) that this specification complies with or is based upon.',
    `size_measurement_method` STRING COMMENT 'Standard method used for particle size distribution determination (wet screening, dry screening, laser diffraction, sieve analysis).. Valid values are `wet_screening|dry_screening|laser_diffraction|sieve_analysis`',
    `specification_code` STRING COMMENT 'Unique business identifier for the product specification used in contracts, quality certificates, and commercial documentation.. Valid values are `^[A-Z0-9]{4,20}$`',
    `specification_description` STRING COMMENT 'Detailed textual description of the product specification including any special conditions, handling requirements, or customer-specific modifications.',
    `specification_name` STRING COMMENT 'Human-readable name of the product specification (e.g., Premium Fines 62% Fe, Copper Concentrate Standard Grade, Thermal Coal 6000 kcal/kg).',
    `specification_status` STRING COMMENT 'Current lifecycle status of the product specification indicating whether it is in draft, actively used in contracts, superseded by a newer version, obsolete, suspended, or under review.. Valid values are `draft|active|superseded|obsolete|suspended|under_review`',
    `specification_type` STRING COMMENT 'Classification of the specification indicating whether it represents typical values, guaranteed minimums/maximums, contractual commitments, internal quality targets, or export standards.. Valid values are `typical|guaranteed|contractual|internal|export`',
    `tml_percent` DECIMAL(18,2) COMMENT 'Transportable Moisture Limit for Group A cargoes under IMSBC Code, representing the maximum moisture content at which the cargo can be safely shipped without liquefaction risk.',
    `top_size_mm` DECIMAL(18,2) COMMENT 'Maximum particle size in millimeters, representing the largest particles present in the product after screening or crushing.',
    `typical_al2o3_percent` DECIMAL(18,2) COMMENT 'Typical alumina content percentage, a key impurity parameter for iron ore and other mineral products affecting downstream processing efficiency.',
    `typical_cu_percent` DECIMAL(18,2) COMMENT 'Typical copper content percentage for copper concentrate products, representing the average Cu grade expected under normal production conditions.',
    `typical_fe_percent` DECIMAL(18,2) COMMENT 'Typical iron content percentage for iron ore products, representing the average Fe grade expected under normal production conditions.',
    `typical_moisture_percent` DECIMAL(18,2) COMMENT 'Typical moisture content percentage representing the average moisture level expected under normal production and storage conditions.',
    `typical_sio2_percent` DECIMAL(18,2) COMMENT 'Typical silica content percentage, a key gangue mineral parameter affecting product quality and downstream processing requirements.',
    `typical_sulfur_percent` DECIMAL(18,2) COMMENT 'Typical sulfur content percentage, a critical impurity parameter for iron ore, coal, and copper products affecting environmental compliance and processing.',
    `version_number` STRING COMMENT 'Version identifier for the specification following semantic versioning (e.g., 1.0, 2.1) to track revisions and updates over time.. Valid values are `^[0-9]+.[0-9]+$`',
    `volatile_matter_percent` DECIMAL(18,2) COMMENT 'Volatile matter content percentage for coal products, indicating the proportion of gaseous products released during heating, affecting combustion characteristics.',
    CONSTRAINT pk_specification PRIMARY KEY(`specification_id`)
) COMMENT 'Defines the complete technical and commercial specification for each saleable product as the single specification SSOT across ALL quality dimensions. Encompasses: chemical grade parameters (Fe%, Cu%, Al2O3%, SiO2%, S%, P%), moisture parameters (maximum contractual moisture, TML for Group A cargoes, free vs inherent moisture, measurement method, sampling frequency, moisture penalty/rejection thresholds), particle size distribution (P80, top size, bottom size, oversize/undersize limits, lump/fines ranges, measurement method — wet/dry screening, laser diffraction), physical properties (bulk density, lump-to-fines ratio, HGI), and thermal parameters (CV, ash, VM, FC for coal). Captures both typical and guaranteed specification values. Individual parameter limits are expressed through linked product_grade_limit records referencing the grade_parameter catalog — this is the ONLY path for specifying quality boundaries (no separate moisture or size entities). Serves as the contractual specification reference used in offtake agreements and sales contracts.';

CREATE OR REPLACE TABLE `mining_ecm`.`product`.`grade_parameter` (
    `grade_parameter_id` BIGINT COMMENT 'Unique identifier for the grade parameter. Primary key for the grade parameter reference catalog.',
    `alternative_names` STRING COMMENT 'Comma-separated list of alternative names, synonyms, or abbreviations used for this parameter across different systems, regions, or customer specifications (e.g., Fe may also be known as Iron, Fe Total, Fe%; CV as Calorific Value, Heating Value, Energy Content). Supports data integration and customer communication.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this parameter record was first created in the system. Supports audit trail and data lineage tracking.',
    `data_source_system` STRING COMMENT 'Primary operational system from which parameter definitions and measurement results originate (e.g., LabWare LIMS, SAP QM, Geovia GEMS, MinePlan). Supports data lineage tracking and system integration mapping.',
    `decimal_precision` STRING COMMENT 'Number of decimal places to which parameter values should be reported and rounded (e.g., 2 for percentages like 62.35%, 0 for whole numbers, 4 for trace elements in ppm). Ensures consistency in assay reporting and contract specifications.',
    `effective_from_date` DATE COMMENT 'Date from which this parameter definition became active and available for use in product specifications and quality assessments. Supports temporal tracking of parameter catalog changes and ensures historical accuracy of product specifications.',
    `effective_to_date` DATE COMMENT 'Date on which this parameter definition was retired or superseded. Null for currently active parameters. Supports historical analysis and ensures that legacy product specifications can be accurately reconstructed.',
    `grade_parameter_status` STRING COMMENT 'Current lifecycle status of the parameter definition: active (in use), inactive (temporarily not used), deprecated (being phased out), under_review (pending validation or approval). Controls which parameters are available for new product specifications.. Valid values are `active|inactive|deprecated|under_review`',
    `is_bonus_element` BOOLEAN COMMENT 'Indicates whether exceeding specified thresholds for this parameter results in commercial bonuses or price premiums (True). Typically applies to valuable elements or quality characteristics that enhance product value (e.g., high Fe content in iron ore, high CV in coal).',
    `is_contractual_parameter` BOOLEAN COMMENT 'Indicates whether this parameter is typically included in sales contracts and commercial specifications (True) or is used only for internal quality control and process optimization (False). Contractual parameters drive pricing adjustments, penalties, and bonuses.',
    `is_penalty_element` BOOLEAN COMMENT 'Indicates whether exceeding specified limits for this parameter results in commercial penalties or price deductions (True). Typically applies to deleterious elements like sulfur, phosphorus, arsenic, and excess moisture that negatively impact downstream processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this parameter record was last updated. Supports change tracking and data quality monitoring.',
    `lims_parameter_code` STRING COMMENT 'The parameter code used in the Laboratory Information Management System (LIMS) for sample tracking and assay result recording. Enables integration between the product catalog and laboratory systems. May differ from the standard parameter_code due to legacy system conventions.',
    `measurement_method` STRING COMMENT 'Standard analytical or testing method used to determine the parameter value (e.g., XRF - X-Ray Fluorescence, ICP-OES - Inductively Coupled Plasma Optical Emission Spectrometry, gravimetric analysis, sieve analysis, bomb calorimetry, proximate analysis). References the laboratory procedure code or industry standard method.',
    `parameter_category` STRING COMMENT 'Business classification grouping parameters by commercial significance: major_element (primary value drivers like Fe, Cu), minor_element (secondary constituents), trace_element (low-concentration elements), deleterious_element (penalty elements like S, P, As), moisture_content (H2O measures), size_distribution (particle sizing), energy_property (CV, calorific measures), physical_property (density, hardness). [ENUM-REF-CANDIDATE: major_element|minor_element|trace_element|deleterious_element|moisture_content|size_distribution|energy_property|physical_property — 8 candidates stripped; promote to reference product]',
    `parameter_code` STRING COMMENT 'Unique alphanumeric code identifying the quality parameter (e.g., FE, CU, AL2O3, SIO2, S, P, MN, TIO2, LOI, LCE, H2O, P80, CV, ASH, VM, FC). Used as the standard reference key across product specifications, assay results, and quality control systems.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `parameter_description` STRING COMMENT 'Detailed technical description of what the parameter measures, its significance for product quality and downstream processing, and any special considerations for interpretation. Provides context for laboratory staff, quality control teams, and commercial personnel.',
    `parameter_name` STRING COMMENT 'Full descriptive name of the quality parameter (e.g., Iron Content, Copper Content, Alumina, Silica, Sulfur, Phosphorus, Manganese, Titanium Dioxide, Loss on Ignition, Lithium Carbonate Equivalent, Total Moisture, Particle Size P80, Calorific Value, Ash Content, Volatile Matter, Fixed Carbon).',
    `parameter_type` STRING COMMENT 'Classification of the parameter by measurement dimension: chemical (elemental composition and compounds), moisture (water content measures), particle_size (size distribution metrics), thermal (energy and combustion properties), physical (density, hardness, abrasion characteristics).. Valid values are `chemical|moisture|particle_size|thermal|physical`',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether this parameter must be reported to regulatory authorities for environmental compliance, resource reporting, or trade documentation (True). Examples include hazardous elements, radioactive materials, or parameters required for JORC/NI 43-101 resource disclosures.',
    `reporting_basis` STRING COMMENT 'Moisture basis on which the parameter value is reported: as_received (natural state including moisture), dry_basis (moisture removed), air_dried (equilibrated with ambient air), moisture_free (completely dried), daf (dry ash-free basis for coal). Critical for accurate comparison of assay results and contract specifications.. Valid values are `as_received|dry_basis|air_dried|moisture_free|daf`',
    `typical_range_maximum` DECIMAL(18,2) COMMENT 'Upper bound of the typical value range observed for this parameter across the companys mineral products. Used for data validation and quality control checks. Expressed in the parameters unit of measure.',
    `typical_range_minimum` DECIMAL(18,2) COMMENT 'Lower bound of the typical value range observed for this parameter across the companys mineral products. Used for data validation and quality control checks. Expressed in the parameters unit of measure.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for reporting parameter values (e.g., %, ppm, mm, µm, kcal/kg, MJ/kg, t/m³, kg/m³, HGI index). Ensures consistency across laboratory results, product specifications, and commercial contracts.',
    CONSTRAINT pk_grade_parameter PRIMARY KEY(`grade_parameter_id`)
) COMMENT 'Controlled reference catalog of all measurable quality parameters used to specify and assess mineral product quality across all dimensions: chemical (Fe, Cu, Al2O3, SiO2, S, P, Mn, TiO2, LOI, LCE), moisture (H2O total, free moisture, inherent moisture, TML), particle size (P80, top size, undersize, oversize, lump fraction), thermal (CV, ash, VM, FC), and physical (bulk density, HGI, abrasion index). Each parameter has a unique code, parameter type classification (chemical/moisture/size/thermal/physical), standard unit of measure (%, ppm, mm, kcal/kg, MJ/kg, t/m³), primary measurement method, and applicable commodity scope. Provides the controlled vocabulary referenced by product_grade_limit for setting specification boundaries across all quality dimensions.';

CREATE OR REPLACE TABLE `mining_ecm`.`product`.`grade_limit` (
    `grade_limit_id` BIGINT COMMENT 'Unique identifier for the product grade limit record. Primary key for this entity.',
    `analytical_method_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_method. Business justification: test_method_code on grade_limit is a denormalization of analytical_method. Grade limits specify the analytical method used to measure compliance (e.g., XRF for Fe, titration for moisture). Mining prod',
    `grade_parameter_id` BIGINT COMMENT 'FK to product.grade_parameter',
    `saleable_product_id` BIGINT COMMENT 'Reference to the mineral product (iron ore fines, lump, copper concentrate, thermal coal, lithium hydroxide, nickel matte) to which this grade limit applies.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Grade limits are defined within the context of a specific product specification — the minimum, maximum, target, and guaranteed values for each grade parameter are specification-version-specific. grade',
    `approval_authority` STRING COMMENT 'The role, position, or individual who has the authority to approve or modify this grade limit. Typically includes Chief Metallurgist, Technical Services Manager, Commercial Manager, or Competent Person under JORC Code. Ensures accountability and governance over specification changes that impact product quality and commercial commitments.',
    `approval_date` DATE COMMENT 'The date on which this grade limit was formally approved by the designated approval authority. Provides audit trail for specification governance and change control. Used to track when limits were authorized and to support compliance audits.',
    `bonus_rate` DECIMAL(18,2) COMMENT 'The financial bonus rate applied per unit improvement beyond the bonus threshold. Typically expressed as currency per percentage point or currency per ppm. Used to calculate provisional pricing adjustments and commercial premiums when grade parameters exceed target specifications. Confidential commercial term from sales contracts.',
    `bonus_threshold` DECIMAL(18,2) COMMENT 'The value at which financial bonuses or price premiums begin to apply. For beneficial elements, bonuses typically apply when the value exceeds this threshold. For deleterious elements, bonuses may apply when the value falls below this threshold. Triggers provisional pricing adjustments and commercial premiums.',
    `compliance_tolerance` DECIMAL(18,2) COMMENT 'The acceptable measurement uncertainty or tolerance band around the limit value within which minor excursions are considered acceptable due to analytical variability. Accounts for sampling error, analytical precision, and measurement repeatability. Used to avoid false rejections due to normal measurement variation. Expressed in the same unit as the grade parameter.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this grade limit record was first created in the system. Provides audit trail for data lineage and supports compliance with data governance requirements. Automatically populated by the system upon record insertion.',
    `effective_from_date` DATE COMMENT 'The date from which this grade limit becomes active and enforceable. Supports temporal validity and enables historical tracking of specification changes. Used to determine which limits apply to a given shipment or production batch based on the transaction date.',
    `effective_to_date` DATE COMMENT 'The date until which this grade limit remains active and enforceable. Null value indicates the limit is currently active with no planned end date. Supports temporal validity and enables historical tracking of specification changes. Used to determine which limits apply to a given shipment or production batch based on the transaction date.',
    `guaranteed_value` DECIMAL(18,2) COMMENT 'The contractually guaranteed value for this grade parameter committed to the customer. Failure to meet this guarantee may trigger price adjustments, penalties, or cargo rejection. More conservative than typical value to account for operational variability. Used in sales contracts and letters of credit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this grade limit record was most recently updated. Provides audit trail for change tracking and supports compliance with data governance requirements. Automatically updated by the system upon any record modification.',
    `limit_status` STRING COMMENT 'Current lifecycle status of the grade limit record. Active: currently in force and used for quality compliance checking. Superseded: replaced by a newer version. Draft: proposed limit pending approval. Under_review: existing limit being evaluated for revision. Suspended: temporarily not enforced due to operational or commercial reasons.. Valid values are `active|superseded|draft|under_review|suspended`',
    `limit_type` STRING COMMENT 'Classification of the grade limit based on its source and enforcement authority. Contractual: limits specified in customer sales contracts. Operational: limits defined by internal process capabilities and equipment constraints. Regulatory: limits mandated by environmental or safety regulations. Shipping: limits required for safe maritime transport (e.g., TML). Internal: limits set for quality control and process optimization purposes.. Valid values are `contractual|operational|regulatory|shipping|internal`',
    `maximum_limit` DECIMAL(18,2) COMMENT 'The absolute maximum acceptable value for this grade parameter. Values above this threshold may trigger cargo rejection or require remediation. For deleterious elements (e.g., silica, alumina, phosphorus, sulfur in iron ore), represents the ceiling specification. For beneficial elements, this field may be null as only minimum limits apply.',
    `minimum_limit` DECIMAL(18,2) COMMENT 'The absolute minimum acceptable value for this grade parameter. Values below this threshold may trigger cargo rejection or require remediation. For beneficial elements (e.g., iron in iron ore), represents the floor specification. For deleterious elements (e.g., phosphorus, sulfur), this field may be null as only maximum limits apply.',
    `notes` STRING COMMENT 'Free-text field for additional context, clarifications, or special conditions related to this grade limit. May include information about seasonal variations, customer-specific requirements, process constraints, or historical context for limit changes. Supports knowledge capture and operational decision-making.',
    `parameter_category` STRING COMMENT 'Classification of the grade parameter into broad categories: chemical (elemental composition), physical (density, hardness), moisture (water content), thermal (calorific value, ash content), particle_size (size distribution), impurity (deleterious elements). Enables grouping of related parameters for quality control and reporting.. Valid values are `chemical|physical|moisture|thermal|particle_size|impurity`',
    `penalty_rate` DECIMAL(18,2) COMMENT 'The financial penalty rate applied per unit deviation beyond the penalty threshold. Typically expressed as currency per percentage point or currency per ppm. Used to calculate provisional pricing adjustments and commercial deductions when grade parameters fall outside acceptable ranges. Confidential commercial term from sales contracts.',
    `penalty_threshold` DECIMAL(18,2) COMMENT 'The value at which financial penalties or price deductions begin to apply. For deleterious elements, penalties typically apply when the value exceeds this threshold. For beneficial elements, penalties may apply when the value falls below this threshold. Triggers provisional pricing adjustments and commercial deductions.',
    `rejection_limit` DECIMAL(18,2) COMMENT 'The absolute value at which the cargo or shipment will be rejected by the customer or deemed non-compliant with contractual specifications. Represents the hard boundary beyond which the product is considered off-specification and unsaleable. More extreme than penalty thresholds. Triggers cargo hold, rework, or disposal decisions.',
    `sampling_frequency` STRING COMMENT 'The required frequency at which samples must be collected and tested to verify compliance with this grade limit. Per_batch: one sample per production batch. Per_shift: one sample per operating shift. Per_day: daily composite sample. Per_shipment: one sample per cargo shipment. Per_railcar: one sample per rail wagon. Continuous: real-time online analyzer. Drives sampling plan design and quality control resource allocation.. Valid values are `per_batch|per_shift|per_day|per_shipment|per_railcar|continuous`',
    `target_value` DECIMAL(18,2) COMMENT 'The ideal or target value for this grade parameter that the mineral processing plant aims to achieve during beneficiation and blending operations. Represents the optimal specification point that maximizes product value and customer satisfaction. Used for process control setpoints and blend optimization.',
    `transportable_moisture_limit` DECIMAL(18,2) COMMENT 'The maximum moisture content at which the mineral concentrate or ore can be safely transported by sea without risk of liquefaction and cargo shift. Critical safety parameter for bulk carrier shipping of iron ore fines, nickel ore, and other fine concentrates. Compliance with TML is mandatory under International Maritime Solid Bulk Cargoes (IMSBC) Code. Only applicable to moisture-related grade parameters.',
    `typical_value` DECIMAL(18,2) COMMENT 'The typical or average value historically achieved for this grade parameter under normal operating conditions. Represents the expected value communicated to customers in product marketing materials and used for sales forecasting. Distinct from target (aspiration) and guaranteed (contractual commitment).',
    `unit_of_measure` STRING COMMENT 'Unit in which the grade parameter is measured and expressed. Common units: percent (%), parts per million (ppm), kilocalories per kilogram (kcal/kg), megajoules per kilogram (MJ/kg), millimeters (mm), microns, kilograms per cubic meter (kg/m3). Must align with assay reporting units from LIMS. [ENUM-REF-CANDIDATE: percent|ppm|kcal_kg|mj_kg|mm|micron|kg_m3 — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_grade_limit PRIMARY KEY(`grade_limit_id`)
) COMMENT 'Stores the minimum, maximum, target, typical, and guaranteed grade limits for each grade parameter within a product specification — covering chemical grades, moisture limits, particle size bounds, and thermal properties uniformly. Captures penalty threshold (value at which deductions begin), bonus threshold (value at which premiums apply), rejection limit (value causing cargo rejection), and provisional pricing adjustment triggers. Supports contractual guarantee limits, typical operating limits, and loading/shipping limits (e.g., TML for moisture). Enables automated quality compliance checking against assay results and real-time blend quality monitoring.';

CREATE OR REPLACE TABLE `mining_ecm`.`product`.`pricing_basis` (
    `pricing_basis_id` BIGINT COMMENT 'Unique identifier for the product pricing basis record. Primary key.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Pricing formulas in mining are heavily negotiated and customer-specific (e.g., Platts 62% Fe CFR China index minus $2.50 for Customer A, Argus index for Customer B). Essential for contract pricing exe',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Revenue recognition process: when a pricing basis is applied to a sale, the resulting revenue posts to a specific GL account. Mining ERP systems (SAP SD) map pricing condition types to GL accounts. A ',
    `saleable_product_id` BIGINT COMMENT 'Reference to the saleable mineral product (iron ore fines, lump, copper concentrate, thermal coal, lithium hydroxide, nickel matte) for which this pricing basis is defined.',
    `superseded_by_pricing_basis_id` BIGINT COMMENT 'Reference to the pricing basis record that supersedes this one, if applicable. Used to maintain version lineage and historical pricing basis evolution.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this pricing basis configuration. Part of governance and audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this pricing basis was formally approved for use. Part of governance and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this pricing basis record was first created in the system. Part of audit trail.',
    `delivery_location` STRING COMMENT 'The geographic location or port associated with the Incoterm and pricing basis (e.g., Port Hedland, Qingdao, Rotterdam, Singapore). Used in conjunction with Incoterm to define the pricing point.',
    `effective_from_date` DATE COMMENT 'The date from which this pricing basis becomes effective and applicable to new sales contracts. Part of the temporal validity window.',
    `effective_to_date` DATE COMMENT 'The date until which this pricing basis remains effective. Null indicates open-ended validity. Used for version control and historical pricing analysis.',
    `final_pricing_trigger` STRING COMMENT 'The business event or condition that triggers final pricing and settlement (e.g., Assay results received, 30 days after discharge, End of quotational period, LME prompt month settlement). Defines when provisional pricing is finalized.',
    `freight_component_included` BOOLEAN COMMENT 'Indicates whether freight cost is included in the pricing basis (true for CIF/CFR Incoterms, false for FOB). Determines if separate freight adjustment is required in contract pricing.',
    `incoterm` STRING COMMENT 'The International Commercial Terms (Incoterms) rule applicable to this pricing basis, defining the delivery point and risk transfer (e.g., FOB for Free on Board, CIF for Cost Insurance and Freight, CFR for Cost and Freight, DAP for Delivered at Place). [ENUM-REF-CANDIDATE: FOB|CIF|CFR|DAP|EXW|FCA|CPT|CIP|DPU|DDP — 10 candidates stripped; promote to reference product]',
    `index_provider` STRING COMMENT 'The organization or agency that publishes the price index (e.g., Platts, London Metal Exchange, Fastmarkets, IHS Markit, Argus Media).',
    `insurance_component_included` BOOLEAN COMMENT 'Indicates whether insurance cost is included in the pricing basis (true for CIF, false for CFR/FOB). Determines if separate insurance adjustment is required in contract pricing.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this pricing basis record was last modified. Part of audit trail for change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or clarifications related to this pricing basis (e.g., specific quality adjustment clauses, regional variations, customer-specific terms).',
    `price_adjustment_formula` STRING COMMENT 'The formula or methodology used to adjust the base index price for product-specific quality parameters, grade differentials, or impurities (e.g., Fe% premium/discount schedule, penalty for silica above threshold, copper treatment and refining charges). May reference separate specification tables.',
    `price_ceiling` DECIMAL(18,2) COMMENT 'The maximum price per unit above which the pricing basis will not rise, if a contractual ceiling is defined. Used in hedging and risk management. Null if no ceiling applies.',
    `price_floor` DECIMAL(18,2) COMMENT 'The minimum price per unit below which the pricing basis will not fall, if a contractual floor is defined. Used in hedging and risk management. Null if no floor applies.',
    `price_index_reference` STRING COMMENT 'The benchmark price index or reference used for pricing (e.g., Platts IODEX 62% Fe CFR China, LME Copper Grade A, Newcastle Coal Index, Fastmarkets Lithium Hydroxide CIF Asia, LME Nickel). This is the industry-standard pricing benchmark against which the product is priced.',
    `price_unit_of_measure` STRING COMMENT 'The unit of measure for pricing (e.g., USD/dmt for dry metric tonne, USD/t for tonne, USD/lb for pound, USD/kg for kilogram). Defines the denominator for the price.',
    `pricing_basis_code` STRING COMMENT 'Unique business code identifying the pricing basis configuration (e.g., IODEX_62FE_CFR, LME_CU_A, NCI_6000, FMB_LIOH_CIF).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `pricing_basis_name` STRING COMMENT 'Human-readable name of the pricing basis (e.g., Platts IODEX 62% Fe CFR China, LME Copper Grade A Cash, Newcastle Coal Index 6000 kcal/kg).',
    `pricing_basis_status` STRING COMMENT 'Current lifecycle status of the pricing basis configuration. Active indicates currently in use for new contracts; superseded indicates replaced by a newer version.. Valid values are `active|inactive|suspended|pending|superseded`',
    `pricing_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the product is priced (e.g., USD, AUD, CNY, EUR).. Valid values are `^[A-Z]{3}$`',
    `pricing_lag_days` STRING COMMENT 'The number of days between the reference event (e.g., Bill of Lading date, discharge date) and the start of the quotational period. Used to calculate the applicable pricing window.',
    `provisional_pricing_percentage` DECIMAL(18,2) COMMENT 'The percentage of the estimated final price paid at the time of provisional invoice, typically at shipment (e.g., 90.00 means 90% of estimated price is invoiced provisionally). Remainder is settled at final pricing.',
    `quotational_period_definition` STRING COMMENT 'Definition of the quotational period used for pricing, specifying the time window over which the benchmark index is averaged or observed (e.g., Month of shipment, Month following shipment, Average of 5 business days prior to Bill of Lading date, Prompt month LME cash settlement). Critical for provisional and final pricing calculations.',
    `refining_charge_applicable` BOOLEAN COMMENT 'Indicates whether refining charges apply to this pricing basis. Refining charges are fees for refining metal to final purity, typically applied in conjunction with treatment charges for concentrates.',
    `treatment_charge_applicable` BOOLEAN COMMENT 'Indicates whether treatment charges apply to this pricing basis. Treatment charges are fees deducted by smelters/refiners for processing concentrate into refined metal, common in copper and other base metal concentrates.',
    `version_number` STRING COMMENT 'Sequential version number for this pricing basis configuration. Incremented when pricing terms are revised. Supports historical tracking and contract version reconciliation.',
    CONSTRAINT pk_pricing_basis PRIMARY KEY(`pricing_basis_id`)
) COMMENT 'Defines the pricing basis and benchmark reference for each saleable product, including price index reference (Platts IODEX 62% Fe CFR China, LME Copper Grade A, Newcastle Coal Index, Fastmarkets Lithium Hydroxide CIF Asia, LME Nickel), pricing currency (USD, AUD, CNY), price unit (USD/dmt, USD/t, USD/lb, USD/kg), quotational period (QP) definition, provisional pricing percentage, final pricing trigger, and applicable Incoterms (FOB, CIF, CFR, DAP). Supports commodity trading and sales contract pricing configuration.';

CREATE OR REPLACE TABLE `mining_ecm`.`product`.`pricing_configuration` (
    `pricing_configuration_id` BIGINT COMMENT 'Primary key for pricing_configuration',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Quality penalty/bonus schedules are negotiated per customer (e.g., $0.50/dmt penalty per 0.1% SiO2 above 5.5% for Customer X, different for Customer Y). Required for invoice adjustments, quality claim',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Penalty and bonus financial postings: pricing configurations define bonus/penalty calculation rules that generate financial postings to specific GL accounts. Mining operations post grade penalty deduc',
    `grade_parameter_id` BIGINT COMMENT 'Foreign key linking to product.grade_parameter. Business justification: Pricing configurations for mineral products are frequently tied to a specific quality parameter that drives bonus/penalty calculations (e.g., Fe content for iron ore, Cu% for copper concentrate). pric',
    `pricing_basis_id` BIGINT COMMENT 'Foreign key linking to product.pricing_basis. Business justification: pricing_configuration is described as a unified commercial pricing configuration template combining pricing basis — it explicitly builds upon pricing_basis. The FK from pricing_configuration to pric',
    `saleable_product_id` BIGINT COMMENT 'Reference to the saleable mineral product (iron ore fines, lump, copper concentrate, thermal coal, lithium hydroxide, nickel matte) to which this pricing configuration applies.',
    `superseded_by_configuration_pricing_configuration_id` BIGINT COMMENT 'Reference to the newer pricing configuration that replaces this one, if superseded. Null if current.',
    `adjustment_calculation_method` STRING COMMENT 'Mathematical method used to calculate penalty/bonus adjustments (linear interpolation, stepped brackets, exponential scaling, or custom formula).. Valid values are `linear|stepped|exponential|custom`',
    `approved_by_user` STRING COMMENT 'Name or identifier of the commercial manager or executive who approved this pricing configuration for use in contracts.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing configuration was formally approved for commercial use.',
    `base_reference_grade` DECIMAL(18,2) COMMENT 'The baseline quality specification value for the parameter (e.g., 62.0% Fe, 5.0% SiO2). Deviations from this trigger penalties or bonuses.',
    `base_reference_unit` STRING COMMENT 'Unit of measure for the base reference grade (e.g., %, ppm, mm, g/t).',
    `bonus_cap_amount` DECIMAL(18,2) COMMENT 'Maximum total bonus amount that can be applied for this parameter, capping upside price adjustments.',
    `bonus_rate_per_unit` DECIMAL(18,2) COMMENT 'Price adjustment rate applied per unit above the base reference grade (e.g., +0.40 USD/dmt per 0.1% Fe above 62.0%).',
    `configuration_code` STRING COMMENT 'Business identifier code for this pricing configuration template, used in offtake agreements and commercial contracts.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `configuration_name` STRING COMMENT 'Descriptive name of the pricing configuration template (e.g., IODEX 62% Fe CFR China Standard, LME Copper Grade A Premium).',
    `configuration_status` STRING COMMENT 'Current lifecycle status of the pricing configuration template.. Valid values are `active|inactive|draft|superseded|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing configuration record was first created in the system.',
    `effective_from_date` DATE COMMENT 'Date from which this pricing configuration becomes active and applicable to new contracts or shipments.',
    `effective_to_date` DATE COMMENT 'Date until which this pricing configuration remains active. Null indicates open-ended validity.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) defining the delivery basis and responsibility transfer point (e.g., FOB - Free on Board, CIF - Cost Insurance and Freight, CFR - Cost and Freight). [ENUM-REF-CANDIDATE: FOB|CIF|CFR|EXW|FCA|CPT|CIP|DAP|DPU|DDP — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing configuration record was last updated.',
    `notes` STRING COMMENT 'Free-text notes capturing special conditions, exceptions, or clarifications for this pricing configuration (e.g., Applies only to Pilbara Blend Fines, Moisture penalty waived for Q1 2024).',
    `penalty_cap_amount` DECIMAL(18,2) COMMENT 'Maximum total penalty amount that can be applied for this parameter, preventing excessive price reductions.',
    `penalty_rate_per_unit` DECIMAL(18,2) COMMENT 'Price adjustment rate applied per unit below the base reference grade (e.g., -0.50 USD/dmt per 0.1% Fe below 62.0%).',
    `price_unit` STRING COMMENT 'Unit of measure for pricing (e.g., USD/dmt, USD/t, USD/lb, USD/kg). Defines the denominator for price calculations.',
    `pricing_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the pricing is denominated (e.g., USD, AUD, CNY).. Valid values are `^[A-Z]{3}$`',
    `provisional_pricing_percentage` DECIMAL(18,2) COMMENT 'Percentage of the estimated final price paid provisionally at shipment (typically 80-90%). Remainder settled after final assay and quotational period completion.',
    `quotational_period_definition` STRING COMMENT 'Definition of the quotational period used for pricing (e.g., Month of Bill of Lading, Month Prior to Shipment, Average of M+1 and M+2). Determines which market prices apply to a shipment.',
    `rejection_limit_lower` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the quality parameter. Material below this threshold may be rejected or subject to renegotiation.',
    `rejection_limit_upper` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the quality parameter (for deleterious elements). Material above this threshold may be rejected.',
    `version_number` STRING COMMENT 'Version number of this pricing configuration, incremented when the template is revised or superseded.',
    CONSTRAINT pk_pricing_configuration PRIMARY KEY(`pricing_configuration_id`)
) COMMENT 'Unified commercial pricing configuration template for each saleable product, combining pricing basis and penalty/bonus adjustment schedules. Captures: benchmark price index reference (Platts IODEX 62% Fe CFR China, LME Copper Grade A, Newcastle Coal Index, Fastmarkets Lithium Hydroxide CIF Asia, LME Nickel), pricing currency (USD, AUD, CNY), price unit (USD/dmt, USD/t, USD/lb), quotational period definition, provisional pricing percentage, Incoterms (FOB, CIF, CFR), AND per-parameter penalty/bonus rates (base reference grade, penalty rate per unit below base, bonus rate per unit above base, penalty/bonus caps, rejection limits). This is a product-level pricing TEMPLATE — actual transactional pricing and invoice calculations belong to the sales domain. Directly referenced by offtake agreements to determine how quality deviations translate to price adjustments.';

CREATE OR REPLACE TABLE `mining_ecm`.`product`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique identifier for the product certification record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Certification cost tracking for AISC/C1 reporting: product certifications (environmental, quality, export) incur audit fees and renewal costs tracked against a cost centre. Mining operations allocate ',
    `delivery_destination_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_destination. Business justification: Export certifications (phytosanitary, radiation, IMSBC compliance) are often destination-specific (e.g., China AQSIQ for iron ore, Japan radiation certificates). Required for logistics planning, custo',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Certification cost financial posting: certification fees (ISO audits, environmental certification body fees) post to specific GL accounts. Mining finance teams require GL account assignment on certifi',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Product certifications (environmental, quality, export) are often obtained specifically to satisfy regulatory conditions attached to a tenement licence. Linking enables compliance teams to demonstrate',
    `saleable_product_id` BIGINT COMMENT 'Reference to the saleable mineral product (iron ore fines, lump, copper concentrate, thermal coal, lithium hydroxide, nickel matte) that this certification applies to.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Export certifications and compliance certificates reference source tenement for provenance verification, conflict minerals compliance, and responsible sourcing standards. Required for ESG reporting an',
    `applicable_jurisdiction` STRING COMMENT 'The specific legal or regulatory jurisdiction under which this certification is governed. May include sub-national regions, trade zones, or regulatory frameworks (e.g., EU REACH, China AQSIQ, Korea MOE).',
    `applicable_market` STRING COMMENT 'The geographic market, country, or jurisdiction where this certification is required and valid. Examples: European Union, China, South Korea, Japan, United States. Use 3-letter ISO country codes where applicable (e.g., CHN, KOR, JPN, USA) or regional identifiers (e.g., EU).',
    `audit_date` DATE COMMENT 'The date on which the certification audit or inspection was conducted by the issuing authority or third-party auditor. Format: yyyy-MM-dd.',
    `auditor_name` STRING COMMENT 'The name of the individual auditor or audit firm that conducted the certification assessment.',
    `certificate_number` STRING COMMENT 'The unique certificate or registration number issued by the certifying authority. This is the externally-known identifier for the certification.',
    `certification_scope` STRING COMMENT 'A description of the scope of the certification, including what aspects of the product, process, or operation are covered. Examples: product composition, manufacturing process, environmental impact, quality management system, occupational health and safety.',
    `certification_status` STRING COMMENT 'The current lifecycle status of the certification. Active: currently valid and in force. Expired: validity period has ended. Suspended: temporarily not valid. Pending: application submitted, awaiting approval. Revoked: cancelled by authority. Renewed: re-issued after expiry.. Valid values are `active|expired|suspended|pending|revoked|renewed`',
    `certification_type` STRING COMMENT 'The category or type of certification. Examples include REACH registration (EU chemical regulation), China GB (Guobiao) standard approval, Korean KS certification, Japanese JIS (Japanese Industrial Standards) approval, hazardous goods classification certificate (IMDG, ADR, IATA), ISO 9001 quality management, ISO 14001 environmental management. [ENUM-REF-CANDIDATE: reach_registration|china_gb_standard|korean_ks_certification|japanese_jis_approval|hazardous_goods_classification|iso_9001|iso_14001 — 7 candidates stripped; promote to reference product]',
    `compliance_standard` STRING COMMENT 'The specific industry standard, regulatory code, or technical specification that the product must comply with under this certification. Examples: GB/T 20123 (China), KS M ISO 9001 (Korea), JIS M 8100 (Japan), REACH Annex XVII, ISO 14001:2015.',
    `cost` DECIMAL(18,2) COMMENT 'The total cost incurred to obtain or renew this certification, including application fees, audit fees, testing fees, and administrative costs. Expressed in the reporting currency.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the certification cost. Examples: USD, AUD, EUR, CNY.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date from which the certification becomes valid and the product can be legally sold in the applicable market. Format: yyyy-MM-dd.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. Nullable for certifications with indefinite validity. Format: yyyy-MM-dd.',
    `hazard_classification` STRING COMMENT 'The hazardous goods classification code assigned to the product for transport and handling. Examples: UN number (UN 3264 for corrosive liquids), IMDG class (Class 8 Corrosive), ADR class, IATA dangerous goods code. Critical for lithium products and concentrates.',
    `issue_date` DATE COMMENT 'The date on which the certification was officially issued by the authority. Format: yyyy-MM-dd.',
    `issuing_authority` STRING COMMENT 'The name of the regulatory body, government agency, or certification organization that issued the certificate. Examples: European Chemicals Agency (ECHA), Standardization Administration of China (SAC), Korean Agency for Technology and Standards (KATS), Japanese Standards Association (JSA), International Maritime Organization (IMO).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was last modified or updated in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `next_renewal_date` DATE COMMENT 'The date by which the certification must be renewed to maintain validity. Format: yyyy-MM-dd. Null if renewal is not required.',
    `product_grade_covered` STRING COMMENT 'The specific product grade, specification, or variant that this certification covers. For example, battery-grade lithium hydroxide monohydrate (>56.5% LiOH), copper concentrate (>25% Cu), iron ore fines (Fe 62% min). Critical for products with multiple grades.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the certification. Examples: conditional approval notes, restrictions, special handling requirements, or audit findings.',
    `renewal_frequency_months` STRING COMMENT 'The frequency in months at which the certification must be renewed. Examples: 12 (annual), 24 (biennial), 36 (triennial). Null if renewal is not required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this certification requires periodic renewal. True if renewal is required, False if the certification is indefinite or one-time.',
    `responsible_party` STRING COMMENT 'The name of the internal business unit, department, or individual responsible for managing and maintaining this certification. Examples: Product Compliance Team, HSE Department, Quality Assurance Manager.',
    `supporting_documentation_reference` STRING COMMENT 'A reference or file path to the supporting documentation, certificate files, audit reports, or compliance records associated with this certification. May be a document management system identifier or URL.',
    `un_number` STRING COMMENT 'The four-digit UN number assigned to hazardous materials for international transport. Format: UN followed by 4 digits (e.g., UN3264). Applicable to hazardous mineral products.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Tracks all product quality certifications, compliance approvals, and regulatory registrations required for each saleable product to be sold in specific markets. Includes certification type (REACH registration, China GB standard approval, Korean KS certification, Japanese JIS approval, hazardous goods classification certificate), issuing authority, certificate number, issue date, expiry date, applicable market/jurisdiction, and certification status. Critical for lithium battery-grade products and hazardous concentrate exports.';

CREATE OR REPLACE TABLE `mining_ecm`.`product`.`blend` (
    `blend_id` BIGINT COMMENT 'Unique identifier for the product blend recipe. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Blending operations occur at specific processing facilities tracked as cost centres. Required for production cost allocation, AISC calculation, and tracking blending costs against budget. Reusing exis',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Custom blends are created to meet individual customer specifications (e.g., blending ore sources to achieve contractual Fe/SiO2 ratios). Supports blend approval workflows, customer acceptance testing,',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Blending cost GL posting: blending operations incur processing costs (labour, equipment, stockpile handling) that post to specific GL accounts. Mining finance requires GL account on blend activities f',
    `plant_id` BIGINT COMMENT 'Reference to the specific facility or location where this blend is executed (e.g., ROM Pad 3, Port Stockpile A, Train Loadout 2).',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Blend production revenue and cost attribution: blending operations produce saleable product generating revenue attributed to a profit centre for segment reporting. Mining operations require profit cen',
    `saleable_product_id` BIGINT COMMENT 'Reference to the saleable product that this blend produces (e.g., iron ore fines 62% Fe, copper concentrate, thermal coal).',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Product blends target material from specific orebodies to achieve grade specifications. Blend recipes reference source orebodies for quality prediction, optimization algorithms, and production plannin',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Blended products must be traceable to their source tenement for royalty apportionment, tenement compliance reporting, and regulatory returns. A mining operations expert expects blend-to-tenement trace',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: A blend recipe targets a specific product specification — the blend is designed to meet the quality parameters defined in a specification. blend.target_specification_code is a STRING that denormalizes',
    `approval_authority` STRING COMMENT 'Role or position authorized to approve this blend recipe (e.g., Chief Metallurgist, Mine Planning Manager, Technical Services Superintendent).',
    `approval_date` DATE COMMENT 'Date when this blend recipe was formally approved for production use.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this blend recipe for production use.',
    `blend_code` STRING COMMENT 'Externally-known unique code identifying this blend recipe, used across mine planning, processing, and logistics systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `blend_name` STRING COMMENT 'Human-readable name of the blend recipe, typically reflecting target grade or customer specification (e.g., 62% Fe Lump Blend, Premium Thermal Coal Blend).',
    `blend_status` STRING COMMENT 'Current lifecycle status of the blend recipe: draft (under development), approved (ready for use), active (currently in production), suspended (temporarily inactive), retired (no longer used).. Valid values are `draft|approved|active|suspended|retired`',
    `blend_type` STRING COMMENT 'Classification of the blend by commodity type: ore_blend (iron ore, copper ore), coal_blend (thermal, metallurgical), concentrate_blend (processed mineral concentrate), custom_blend (customer-specific recipe).. Valid values are `ore_blend|coal_blend|concentrate_blend|custom_blend`',
    `blending_location_type` STRING COMMENT 'Type of facility where blending occurs: rom_pad (Run of Mine stockpile pad), stockpile (intermediate stockpile), train_loadout (rail loading facility), port_stockpile (port storage yard), ship_loader (vessel loading point).. Valid values are `rom_pad|stockpile|train_loadout|port_stockpile|ship_loader`',
    `commodity_type` STRING COMMENT 'Primary mineral commodity that this blend produces: iron_ore, copper, coal (thermal/metallurgical), lithium, nickel, gold, zinc, lead. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|zinc|lead — 8 candidates stripped; promote to reference product]',
    `complexity_rating` STRING COMMENT 'Operational complexity classification: simple (2-3 components, wide tolerance), moderate (3-4 components, standard tolerance), complex (5+ components, tight tolerance), advanced (requires real-time optimization and quality prediction).. Valid values are `simple|moderate|complex|advanced`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this blend recipe record was first created in the system.',
    `customer_specification_reference` STRING COMMENT 'Reference code to the customer contract or specification document that defines the quality requirements for this blend. Links blend to commercial agreements.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `effective_from_date` DATE COMMENT 'Date from which this blend recipe becomes valid and can be used in production operations.',
    `effective_to_date` DATE COMMENT 'Date until which this blend recipe remains valid. Nullable for open-ended blends. Used for seasonal blends or customer-specific campaigns.',
    `environmental_classification` STRING COMMENT 'Environmental handling requirements for this blend: standard (normal conditions), dust_sensitive (requires dust suppression), moisture_sensitive (requires weather protection), temperature_controlled (requires climate control).. Valid values are `standard|dust_sensitive|moisture_sensitive|temperature_controlled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this blend recipe record was last updated. Supports change tracking and audit compliance.',
    `maximum_component_count` STRING COMMENT 'Maximum number of source products allowed in this blend (typically 3-8). Limits operational complexity and maintains traceability.',
    `minimum_component_count` STRING COMMENT 'Minimum number of source products required to create this blend (typically 2-5). Ensures blend complexity and quality consistency.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this blend recipe record.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, historical performance observations, or customer-specific requirements.',
    `optimization_objective` STRING COMMENT 'Primary business objective for this blend: maximize_grade (highest quality), minimize_cost (lowest production cost), meet_specification (exact customer requirement), maximize_recovery (best yield), balance_inventory (stockpile management).. Valid values are `maximize_grade|minimize_cost|meet_specification|maximize_recovery|balance_inventory`',
    `quality_assurance_protocol` STRING COMMENT 'Level of quality testing and validation required: standard (routine sampling), enhanced (increased sampling frequency), premium (continuous monitoring), customer_specific (per contract requirements).. Valid values are `standard|enhanced|premium|customer_specific`',
    `quality_prediction_model_reference` STRING COMMENT 'Reference code to the predictive analytics model used to forecast blend quality outcomes based on source material properties. Supports real-time blend optimization.. Valid values are `^[A-Z0-9_-]{4,30}$`',
    `sampling_frequency` STRING COMMENT 'Required frequency for quality sampling and assay testing: per_batch (every blend batch), per_shift (8-12 hour intervals), per_day (daily composite), continuous (real-time monitoring), per_shipment (before dispatch).. Valid values are `per_batch|per_shift|per_day|continuous|per_shipment`',
    `target_alumina_percent` DECIMAL(18,2) COMMENT 'Target alumina content percentage for iron ore and mineral blends. Impacts smelting efficiency (typical range 1-4%).',
    `target_ash_percent` DECIMAL(18,2) COMMENT 'Target ash content percentage for coal blends. Lower ash content increases energy value and reduces waste (typical range 8-25%).',
    `target_energy_content_kcal_kg` DECIMAL(18,2) COMMENT 'Target calorific value for coal blends measured in kilocalories per kilogram. Critical for thermal coal pricing and power generation efficiency (typical range 4500-7000 kcal/kg).',
    `target_fe_grade_percent` DECIMAL(18,2) COMMENT 'Target iron content percentage for iron ore blends, typically 58-67% Fe. Critical for meeting customer specifications and pricing.',
    `target_moisture_percent` DECIMAL(18,2) COMMENT 'Target moisture content percentage for the blended product. Critical for shipping weight calculations and product quality (typical range 2-10%).',
    `target_phosphorus_percent` DECIMAL(18,2) COMMENT 'Target phosphorus content percentage for iron ore blends. Low phosphorus is critical for high-grade steel production (typical range 0.02-0.10%).',
    `target_silica_percent` DECIMAL(18,2) COMMENT 'Target silica content percentage for iron ore and mineral blends. Lower silica is preferred for steel-making (typical range 2-8%).',
    `tolerance_range_percent` DECIMAL(18,2) COMMENT 'Allowable deviation from target specification expressed as percentage (e.g., ±2% for Fe grade). Defines acceptable quality variance for the blend.',
    CONSTRAINT pk_blend PRIMARY KEY(`blend_id`)
) COMMENT 'Approved blending recipe that combines two or more source products to produce a target blended product meeting a defined specification. Captures blend identifier, target saleable product, target specification reference, blending location (ROM pad, train load-out, port stockpile, ship-loader feed), blend tolerance range, quality prediction model reference, and approval status. Critical for iron ore operations where multiple ore sources are blended to meet 62% Fe specification, and for coal operations blending energy and ash content. Supports mine-to-port blend optimisation and real-time blend tracking.';

CREATE OR REPLACE TABLE `mining_ecm`.`product`.`commodity_grade_scope` (
    `commodity_grade_scope_id` BIGINT COMMENT 'Primary key for the commodity_grade_scope association',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to the commodity whose quality specification this record contributes to.',
    `grade_parameter_id` BIGINT COMMENT 'Foreign key linking to the grade parameter that applies to this commodity.',
    `applicable_commodity_scope` STRING COMMENT 'Comma-separated list of mineral commodities to which this parameter applies (e.g., iron_ore, copper_concentrate, thermal_coal, metallurgical_coal, lithium_hydroxide, lithium_carbonate, nickel_matte, nickel_concentrate, gold_dore). Defines the product catalog scope where this parameter is relevant for quality specification. [Moved from grade_parameter: This comma-separated text field on grade_parameter is a denormalized encoding of the M:N relationship. It must be removed and replaced by proper FK records in commodity_grade_scope, which provides referential integrity, queryability, and the ability to store commodity-specific attributes (ranges, contractual flags, penalty/bonus flags) per combination.]',
    `effective_from_date` DATE COMMENT 'Date from which this grade parameter became applicable to this commodity. Supports versioning of the commodity quality specification over time.',
    `effective_to_date` DATE COMMENT 'Date on which this grade parameter ceased to apply to this commodity. Null indicates currently active applicability.',
    `is_bonus_element` BOOLEAN COMMENT 'Indicates whether exceeding specified thresholds for this parameter results in commercial price bonuses for this specific commodity. Bonus applicability is commodity-specific.',
    `is_contractual` BOOLEAN COMMENT 'Indicates whether this grade parameter is included in sales contracts and commercial specifications for this specific commodity. A parameter may be contractual for coal but informational-only for lithium.',
    `is_penalty_element` BOOLEAN COMMENT 'Indicates whether exceeding specified limits for this parameter results in commercial price penalties for this specific commodity. Penalty applicability is commodity-specific.',
    `scope_status` STRING COMMENT 'Lifecycle status of this commodity-parameter applicability record. Allows parameters to be retired from a commoditys scope without deleting the historical record.',
    `typical_range_maximum` DECIMAL(18,2) COMMENT 'Upper bound of the typical value range for this grade parameter as observed specifically for this commodity. Overrides the generic typical_range_maximum on grade_parameter with a commodity-specific value.',
    `typical_range_minimum` DECIMAL(18,2) COMMENT 'Lower bound of the typical value range for this grade parameter as observed specifically for this commodity. Overrides the generic typical_range_minimum on grade_parameter with a commodity-specific value.',
    CONSTRAINT pk_commodity_grade_scope PRIMARY KEY(`commodity_grade_scope_id`)
) COMMENT 'This association product represents the formally managed applicability contract between a commodity and a grade parameter. It captures which quality parameters govern each commodity type, along with the commodity-specific specification boundaries, contractual inclusion status, and commercial penalty/bonus flags that exist only in the context of a specific commodity-parameter combination. Each record defines one quality dimension of one commoditys specification envelope, actively maintained by metallurgists and commercial teams.. Existence Justification: In mining operations, each commodity type (iron ore, copper, coal) is governed by a formally managed set of quality parameters — metallurgists and commercial teams explicitly define which grade parameters apply to each commodity, along with commodity-specific ranges, contractual status, and penalty/bonus flags. This is not derivable from transactional data; it is a controlled reference catalog actively maintained by technical and commercial teams. A single grade parameter (e.g., moisture H2O) applies to multiple commodities, and a single commodity (e.g., iron ore) is governed by many grade parameters — making this a genuine operational M:N.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_supersedes_specification_id` FOREIGN KEY (`supersedes_specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ADD CONSTRAINT `fk_product_grade_limit_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ADD CONSTRAINT `fk_product_grade_limit_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ADD CONSTRAINT `fk_product_grade_limit_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ADD CONSTRAINT `fk_product_pricing_basis_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ADD CONSTRAINT `fk_product_pricing_basis_superseded_by_pricing_basis_id` FOREIGN KEY (`superseded_by_pricing_basis_id`) REFERENCES `mining_ecm`.`product`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ADD CONSTRAINT `fk_product_pricing_configuration_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ADD CONSTRAINT `fk_product_pricing_configuration_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `mining_ecm`.`product`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ADD CONSTRAINT `fk_product_pricing_configuration_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ADD CONSTRAINT `fk_product_pricing_configuration_superseded_by_configuration_pricing_configuration_id` FOREIGN KEY (`superseded_by_configuration_pricing_configuration_id`) REFERENCES `mining_ecm`.`product`.`pricing_configuration`(`pricing_configuration_id`);
ALTER TABLE `mining_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ADD CONSTRAINT `fk_product_commodity_grade_scope_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ADD CONSTRAINT `fk_product_commodity_grade_scope_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `mining_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `mining_ecm`.`product`.`commodity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`product`.`commodity` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Identifier (ID)');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `benchmark_pricing_index` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Pricing Index');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `cim_definition_standard` SET TAGS ('dbx_business_glossary_term' = 'Canadian Institute of Mining (CIM) Definition Standard');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `commodity_class` SET TAGS ('dbx_business_glossary_term' = 'Commodity Class');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `commodity_class` SET TAGS ('dbx_value_regex' = 'base_metal|precious_metal|energy_mineral|industrial_mineral|battery_mineral|bulk_commodity');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `commodity_group` SET TAGS ('dbx_business_glossary_term' = 'Commodity Group');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `commodity_name` SET TAGS ('dbx_business_glossary_term' = 'Commodity Name');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `commodity_status` SET TAGS ('dbx_business_glossary_term' = 'Commodity Status');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `commodity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|under_development');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Classification');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `export_license_required` SET TAGS ('dbx_business_glossary_term' = 'Export License Required Flag');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `is_hazardous_material` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Material Flag');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `jorc_commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Joint Ore Reserves Committee (JORC) Commodity Type');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `primary_end_use_market` SET TAGS ('dbx_business_glossary_term' = 'Primary End-Use Market');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `royalty_applicable` SET TAGS ('dbx_business_glossary_term' = 'Royalty Applicable Flag');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `samrec_commodity_code` SET TAGS ('dbx_business_glossary_term' = 'South African Mineral Resource Committee (SAMREC) Commodity Code');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `standard_packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Standard Packaging Type');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `standard_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `standard_unit_of_measure` SET TAGS ('dbx_value_regex' = 'tonne|kilogram|pound|troy_ounce|cubic_metre');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `strategic_importance_level` SET TAGS ('dbx_business_glossary_term' = 'Strategic Importance Level');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `strategic_importance_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `strategic_importance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `trading_currency` SET TAGS ('dbx_business_glossary_term' = 'Trading Currency');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `trading_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `typical_grade_range` SET TAGS ('dbx_business_glossary_term' = 'Typical Grade Range');
ALTER TABLE `mining_ecm`.`product`.`commodity` ALTER COLUMN `typical_recovery_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Typical Recovery Rate Percentage');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Identifier (ID)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Laboratory Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Gl Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `royalty_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Source Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `available_for_sale_flag` SET TAGS ('dbx_business_glossary_term' = 'Available for Sale Flag');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `benchmark_index` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Price Index');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `carbon_footprint_kg_co2e_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Kilograms Carbon Dioxide Equivalent (CO2e) per Tonne');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `environmental_certification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `export_license_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Export License Required Flag');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `grade_specification` SET TAGS ('dbx_business_glossary_term' = 'Grade Specification');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Classification');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Tariff Code');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `impurity_limits` SET TAGS ('dbx_business_glossary_term' = 'Impurity Element Limits');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `incoterm_default` SET TAGS ('dbx_business_glossary_term' = 'Default Incoterm (International Commercial Terms)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Commercial Lifecycle Status');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'development|qualified|active|sunset|discontinued');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `minimum_order_quantity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (Tonnes)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `moisture_content_max_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Moisture Content Percentage (Pct)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Product Notes');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `packaging_standard` SET TAGS ('dbx_business_glossary_term' = 'Packaging Standard');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_value_regex' = 'spot|monthly_average|quarterly_average|annual_contract|fixed_price|cost_plus');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `processing_route` SET TAGS ('dbx_business_glossary_term' = 'Processing Route (Run of Mine to Product)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `product_form` SET TAGS ('dbx_business_glossary_term' = 'Product Form');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `product_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Name');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `product_specification_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Document Reference');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `quality_certificate_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Required Flag');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `sizing_specification` SET TAGS ('dbx_business_glossary_term' = 'Particle Sizing Specification');
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ALTER COLUMN `target_market_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `mining_ecm`.`product`.`specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`product`.`specification` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification ID');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Required Analytical Method Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `supersedes_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Specification ID');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `ash_percent` SET TAGS ('dbx_business_glossary_term' = 'Ash Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `bulk_density_t_per_m3` SET TAGS ('dbx_business_glossary_term' = 'Bulk Density (Tonnes per Cubic Meter)');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `calorific_value_kcal_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Calorific Value (Kilocalories per Kilogram)');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'iron_ore|copper|coal|lithium|nickel|gold');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `contractual_reference` SET TAGS ('dbx_business_glossary_term' = 'Contractual Reference');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `grade_basis` SET TAGS ('dbx_business_glossary_term' = 'Grade Basis');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `grade_basis` SET TAGS ('dbx_value_regex' = 'dry_basis|as_received|moisture_free|air_dried');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `guaranteed_al2o3_percent_max` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Maximum Alumina (Al2O3) Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `guaranteed_cu_percent_min` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Copper (Cu) Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `guaranteed_fe_percent_min` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Iron (Fe) Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `guaranteed_moisture_percent_max` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Maximum Moisture Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `guaranteed_sio2_percent_max` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Maximum Silica (SiO2) Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `guaranteed_sulfur_percent_max` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Maximum Sulfur (S) Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `is_customer_specific` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Specific');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `is_export_specification` SET TAGS ('dbx_business_glossary_term' = 'Is Export Specification');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `moisture_measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Moisture Measurement Method');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `moisture_measurement_method` SET TAGS ('dbx_value_regex' = 'oven_drying|karl_fischer|microwave|infrared|tga');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `p80_microns` SET TAGS ('dbx_business_glossary_term' = 'P80 Particle Size (Microns)');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `packaging_requirement` SET TAGS ('dbx_business_glossary_term' = 'Packaging Requirement');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `packaging_requirement` SET TAGS ('dbx_value_regex' = 'bulk|bagged|containerized|ibc|drums|supersacks');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `quality_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Reference');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `size_measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Size Measurement Method');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `size_measurement_method` SET TAGS ('dbx_value_regex' = 'wet_screening|dry_screening|laser_diffraction|sieve_analysis');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `specification_code` SET TAGS ('dbx_business_glossary_term' = 'Specification Code');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `specification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `specification_description` SET TAGS ('dbx_business_glossary_term' = 'Specification Description');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `specification_name` SET TAGS ('dbx_business_glossary_term' = 'Specification Name');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|obsolete|suspended|under_review');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_value_regex' = 'typical|guaranteed|contractual|internal|export');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `tml_percent` SET TAGS ('dbx_business_glossary_term' = 'Transportable Moisture Limit (TML) Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `top_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Top Size (Millimeters)');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `typical_al2o3_percent` SET TAGS ('dbx_business_glossary_term' = 'Typical Alumina (Al2O3) Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `typical_cu_percent` SET TAGS ('dbx_business_glossary_term' = 'Typical Copper (Cu) Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `typical_fe_percent` SET TAGS ('dbx_business_glossary_term' = 'Typical Iron (Fe) Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `typical_moisture_percent` SET TAGS ('dbx_business_glossary_term' = 'Typical Moisture Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `typical_sio2_percent` SET TAGS ('dbx_business_glossary_term' = 'Typical Silica (SiO2) Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `typical_sulfur_percent` SET TAGS ('dbx_business_glossary_term' = 'Typical Sulfur (S) Percentage');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `mining_ecm`.`product`.`specification` ALTER COLUMN `volatile_matter_percent` SET TAGS ('dbx_business_glossary_term' = 'Volatile Matter (VM) Percentage');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` SET TAGS ('dbx_subdomain' = 'quality_grading');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `grade_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Parameter Identifier (ID)');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `alternative_names` SET TAGS ('dbx_business_glossary_term' = 'Alternative Parameter Names');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `decimal_precision` SET TAGS ('dbx_business_glossary_term' = 'Decimal Precision');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `grade_parameter_status` SET TAGS ('dbx_business_glossary_term' = 'Parameter Status');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `grade_parameter_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_review');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `is_bonus_element` SET TAGS ('dbx_business_glossary_term' = 'Is Bonus Element Flag');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `is_contractual_parameter` SET TAGS ('dbx_business_glossary_term' = 'Is Contractual Parameter Flag');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `is_penalty_element` SET TAGS ('dbx_business_glossary_term' = 'Is Penalty Element Flag');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `lims_parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Parameter Code');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Measurement Method');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `parameter_category` SET TAGS ('dbx_business_glossary_term' = 'Parameter Category');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `parameter_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `parameter_description` SET TAGS ('dbx_business_glossary_term' = 'Parameter Description');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `parameter_type` SET TAGS ('dbx_business_glossary_term' = 'Parameter Type');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `parameter_type` SET TAGS ('dbx_value_regex' = 'chemical|moisture|particle_size|thermal|physical');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `reporting_basis` SET TAGS ('dbx_business_glossary_term' = 'Reporting Basis');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `reporting_basis` SET TAGS ('dbx_value_regex' = 'as_received|dry_basis|air_dried|moisture_free|daf');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `typical_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Typical Range Maximum');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `typical_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Typical Range Minimum');
ALTER TABLE `mining_ecm`.`product`.`grade_parameter` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` SET TAGS ('dbx_subdomain' = 'quality_grading');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `grade_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Product Grade Limit Identifier (ID)');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `grade_parameter_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `bonus_rate` SET TAGS ('dbx_business_glossary_term' = 'Bonus Rate');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `bonus_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `bonus_threshold` SET TAGS ('dbx_business_glossary_term' = 'Bonus Threshold');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `compliance_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tolerance');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `guaranteed_value` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Value');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_business_glossary_term' = 'Limit Status');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_value_regex' = 'active|superseded|draft|under_review|suspended');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Type');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'contractual|operational|regulatory|shipping|internal');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `maximum_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Limit');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `minimum_limit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Limit');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `parameter_category` SET TAGS ('dbx_business_glossary_term' = 'Parameter Category');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `parameter_category` SET TAGS ('dbx_value_regex' = 'chemical|physical|moisture|thermal|particle_size|impurity');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Penalty Rate');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `penalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `penalty_threshold` SET TAGS ('dbx_business_glossary_term' = 'Penalty Threshold');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `rejection_limit` SET TAGS ('dbx_business_glossary_term' = 'Rejection Limit');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_value_regex' = 'per_batch|per_shift|per_day|per_shipment|per_railcar|continuous');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `transportable_moisture_limit` SET TAGS ('dbx_business_glossary_term' = 'Transportable Moisture Limit (TML)');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `typical_value` SET TAGS ('dbx_business_glossary_term' = 'Typical Value');
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `pricing_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Basis Identifier (ID)');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `superseded_by_pricing_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Pricing Basis Identifier (ID)');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `final_pricing_trigger` SET TAGS ('dbx_business_glossary_term' = 'Final Pricing Trigger');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `freight_component_included` SET TAGS ('dbx_business_glossary_term' = 'Freight Component Included Flag');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `index_provider` SET TAGS ('dbx_business_glossary_term' = 'Index Provider');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `insurance_component_included` SET TAGS ('dbx_business_glossary_term' = 'Insurance Component Included Flag');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `price_adjustment_formula` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Formula');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `price_ceiling` SET TAGS ('dbx_business_glossary_term' = 'Price Ceiling');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `price_ceiling` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `price_floor` SET TAGS ('dbx_business_glossary_term' = 'Price Floor');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `price_floor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `pricing_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Code');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `pricing_basis_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `pricing_basis_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Name');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `pricing_basis_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Status');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `pricing_basis_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|superseded');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `pricing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Currency Code');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `pricing_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `pricing_lag_days` SET TAGS ('dbx_business_glossary_term' = 'Pricing Lag Days');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `provisional_pricing_percentage` SET TAGS ('dbx_business_glossary_term' = 'Provisional Pricing Percentage');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `quotational_period_definition` SET TAGS ('dbx_business_glossary_term' = 'Quotational Period (QP) Definition');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `refining_charge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Refining Charge (RC) Applicable Flag');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `treatment_charge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Treatment Charge (TC) Applicable Flag');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `treatment_charge_applicable` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `treatment_charge_applicable` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `pricing_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Configuration Identifier');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `grade_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Parameter Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `pricing_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `superseded_by_configuration_pricing_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Configuration ID');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `adjustment_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Calculation Method');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `adjustment_calculation_method` SET TAGS ('dbx_value_regex' = 'linear|stepped|exponential|custom');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `base_reference_grade` SET TAGS ('dbx_business_glossary_term' = 'Base Reference Grade');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `base_reference_unit` SET TAGS ('dbx_business_glossary_term' = 'Base Reference Unit');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `bonus_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Cap Amount');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `bonus_rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Bonus Rate Per Unit');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|superseded|archived');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `penalty_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Cap Amount');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `penalty_rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Penalty Rate Per Unit');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `pricing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Currency Code');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `pricing_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `provisional_pricing_percentage` SET TAGS ('dbx_business_glossary_term' = 'Provisional Pricing Percentage');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `quotational_period_definition` SET TAGS ('dbx_business_glossary_term' = 'Quotational Period (QP) Definition');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `rejection_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Rejection Limit Lower');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `rejection_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Rejection Limit Upper');
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `mining_ecm`.`product`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`product`.`certification` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Certification Identifier (ID)');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `applicable_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdiction');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `applicable_market` SET TAGS ('dbx_business_glossary_term' = 'Applicable Market');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending|revoked|renewed');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `product_grade_covered` SET TAGS ('dbx_business_glossary_term' = 'Product Grade Covered');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency (Months)');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `mining_ecm`.`product`.`certification` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `mining_ecm`.`product`.`blend` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`product`.`blend` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `blend_id` SET TAGS ('dbx_business_glossary_term' = 'Product Blend Identifier (ID)');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Blending Facility Identifier (ID)');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Target Product Identifier (ID)');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Source Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Source Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `blend_code` SET TAGS ('dbx_business_glossary_term' = 'Blend Code');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `blend_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `blend_name` SET TAGS ('dbx_business_glossary_term' = 'Blend Name');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `blend_status` SET TAGS ('dbx_business_glossary_term' = 'Blend Status');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `blend_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|suspended|retired');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `blend_type` SET TAGS ('dbx_business_glossary_term' = 'Blend Type');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `blend_type` SET TAGS ('dbx_value_regex' = 'ore_blend|coal_blend|concentrate_blend|custom_blend');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `blending_location_type` SET TAGS ('dbx_business_glossary_term' = 'Blending Location Type');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `blending_location_type` SET TAGS ('dbx_value_regex' = 'rom_pad|stockpile|train_loadout|port_stockpile|ship_loader');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `complexity_rating` SET TAGS ('dbx_business_glossary_term' = 'Blend Complexity Rating');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `complexity_rating` SET TAGS ('dbx_value_regex' = 'simple|moderate|complex|advanced');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `customer_specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Specification Reference');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `customer_specification_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `customer_specification_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Classification');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_value_regex' = 'standard|dust_sensitive|moisture_sensitive|temperature_controlled');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `maximum_component_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Component Count');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `minimum_component_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Component Count');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Blend Notes');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `optimization_objective` SET TAGS ('dbx_business_glossary_term' = 'Optimization Objective');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `optimization_objective` SET TAGS ('dbx_value_regex' = 'maximize_grade|minimize_cost|meet_specification|maximize_recovery|balance_inventory');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `quality_assurance_protocol` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Protocol');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `quality_assurance_protocol` SET TAGS ('dbx_value_regex' = 'standard|enhanced|premium|customer_specific');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `quality_prediction_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Prediction Model Reference');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `quality_prediction_model_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,30}$');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_value_regex' = 'per_batch|per_shift|per_day|continuous|per_shipment');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `target_alumina_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Alumina (Al2O3) Percentage');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `target_ash_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Ash Percentage');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `target_energy_content_kcal_kg` SET TAGS ('dbx_business_glossary_term' = 'Target Energy Content (kcal/kg)');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `target_fe_grade_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Iron (Fe) Grade Percentage');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `target_moisture_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Moisture Percentage');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `target_phosphorus_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Phosphorus (P) Percentage');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `target_silica_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Silica (SiO2) Percentage');
ALTER TABLE `mining_ecm`.`product`.`blend` ALTER COLUMN `tolerance_range_percent` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Range Percentage');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` SET TAGS ('dbx_subdomain' = 'quality_grading');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` SET TAGS ('dbx_association_edges' = 'product.commodity,product.grade_parameter');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ALTER COLUMN `commodity_grade_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Grade Scope - Commodity Grade Scope Id');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Grade Scope - Commodity Id');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ALTER COLUMN `grade_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Grade Scope - Grade Parameter Id');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ALTER COLUMN `applicable_commodity_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicable Commodity Scope');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ALTER COLUMN `is_bonus_element` SET TAGS ('dbx_business_glossary_term' = 'Bonus Element Flag');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ALTER COLUMN `is_contractual` SET TAGS ('dbx_business_glossary_term' = 'Contractual Parameter Flag');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ALTER COLUMN `is_penalty_element` SET TAGS ('dbx_business_glossary_term' = 'Penalty Element Flag');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_business_glossary_term' = 'Scope Status');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ALTER COLUMN `typical_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Commodity-Specific Typical Range Maximum');
ALTER TABLE `mining_ecm`.`product`.`commodity_grade_scope` ALTER COLUMN `typical_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Commodity-Specific Typical Range Minimum');
