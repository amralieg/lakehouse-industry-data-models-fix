-- Schema for Domain: product | Business: Oil Gas | Version: v1_mvm
-- Generated on: 2026-05-04 09:29:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`product` COMMENT 'Serves as the SSOT for the petroleum product catalog including crude oil grades (WTI, Brent, sour/sweet), natural gas specifications, LNG, LPG, NGL streams, refined products (gasoline, diesel, jet fuel, fuel oil), and petrochemicals. Manages product quality specifications, API gravity, sulfur content, RON ratings, pricing benchmarks, and regulatory product classifications across the entire value chain.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`petroleum_product` (
    `petroleum_product_id` BIGINT COMMENT 'Unique system identifier for the petroleum product record. Primary key for the petroleum product master catalog.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Petroleum products are managed within legal entities for regulatory reporting (EPA fuel categories), customs compliance (HS codes), excise tax administration, and financial consolidation. Essential fo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Petroleum products incur direct operational costs (storage, handling, testing, blending) that must be allocated to cost centers for management accounting, variance analysis, and operational budgeting ',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: Petroleum products are often produced/marketed by specific operators; operator attribution enables operational reporting, product inventory tracking by operator, commercial relationship management, an',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity measurement in degrees API. Indicates the density of petroleum liquids relative to water. Light crude >31.1°, medium 22.3-31.1°, heavy <22.3°. Critical for pricing, refining yield optimization, and transportation planning.',
    `blending_component_flag` BOOLEAN COMMENT 'Indicates whether the product is used as a blending component (True) or sold as a finished product (False). Blending components include naphtha, reformate, alkylate, MTBE, ethanol.',
    `boe_conversion_factor` DECIMAL(18,2) COMMENT 'Conversion factor to normalize product volume to Barrel of Oil Equivalent for reserves reporting and production aggregation. Typically 1.0 for crude oil, ~6.0 for natural gas (6 mcf = 1 BOE).',
    `carbon_intensity_g_mj` DECIMAL(18,2) COMMENT 'Lifecycle greenhouse gas emissions intensity in grams of CO2 equivalent per megajoule of energy. Used for LCFS compliance, carbon trading, and ESG reporting.',
    `cetane_number` DECIMAL(18,2) COMMENT 'Cetane number for diesel fuel products. Measures ignition quality and combustion performance. Typical range 40-55. Null for non-diesel products.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product record was first created in the system. Audit trail for data governance and lineage tracking.',
    `density_kg_m3` DECIMAL(18,2) COMMENT 'Density at standard conditions (15°C, 1 atm) in kilograms per cubic meter. Used for volume-to-mass conversions, custody transfer, and inventory management.',
    `discontinuation_date` DATE COMMENT 'Date when the product was discontinued or phased out from the catalog. Null for active products. Used for product lifecycle management and historical reporting.',
    `effective_date` DATE COMMENT 'Date when this product record became active in the catalog. Used for temporal product lifecycle tracking and historical analysis.',
    `epa_fuel_category` STRING COMMENT 'EPA fuel category classification for environmental compliance and emissions reporting. Examples: Conventional Gasoline, Reformulated Gasoline (RFG), Ultra-Low Sulfur Diesel (ULSD).',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Flash point temperature in degrees Celsius. Lowest temperature at which vapors ignite when exposed to an ignition source. Critical for safety classification and transportation regulations.',
    `hazard_class` STRING COMMENT 'DOT/UN hazard classification for transportation and storage. Examples: Class 3 Flammable Liquids, Class 2.1 Flammable Gas. Determines packaging, labeling, and handling requirements.',
    `heating_value_mj_kg` DECIMAL(18,2) COMMENT 'Gross heating value (higher heating value) in megajoules per kilogram. Represents energy content of the fuel. Used for energy balance calculations and pricing.',
    `hs_code` STRING COMMENT 'International Harmonized System tariff classification code. Used for customs declarations, import/export documentation, and trade compliance. 6-10 digit code depending on jurisdiction.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this product record. Supports change tracking, audit trails, and data quality monitoring.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the product in the catalog. Determines availability for trading, production planning, and commercial transactions.. Valid values are `active|inactive|pending_approval|discontinued|restricted|phased_out`',
    `origin_region` STRING COMMENT 'Geographic region or basin where the product is typically sourced or produced. Examples: Permian Basin, North Sea, Middle East, Gulf Coast. Used for supply chain planning and quality differentiation.',
    `packing_group` STRING COMMENT 'UN packing group indicating degree of danger: I (high danger), II (medium danger), III (low danger). Used for transportation classification and packaging requirements.. Valid values are `I|II|III`',
    `phase_state` STRING COMMENT 'Physical phase state of the product at standard temperature and pressure conditions. Determines storage, handling, and transportation requirements.. Valid values are `liquid|gas|solid|supercritical`',
    `pour_point_c` DECIMAL(18,2) COMMENT 'Pour point temperature in degrees Celsius. Lowest temperature at which the product will flow under prescribed conditions. Important for cold weather operations and storage.',
    `product_code` STRING COMMENT 'Externally-known unique business identifier for the petroleum product. Used across trading, logistics, and commercial systems. Examples: WTI-CRUDE-01, BRENT-ICE, ULSD-10PPM.. Valid values are `^[A-Z0-9]{6,20}$`',
    `product_family` STRING COMMENT 'Hierarchical product family grouping for reporting and analytics. Examples: Light Sweet Crude, Heavy Sour Crude, Reformulated Gasoline, Conventional Diesel, Ethylene, Propylene.',
    `product_name` STRING COMMENT 'Human-readable commercial name of the petroleum product. Examples: West Texas Intermediate Crude Oil, Ultra-Low Sulfur Diesel, Liquefied Natural Gas, Propane.',
    `product_subfamily` STRING COMMENT 'Secondary hierarchical classification within the product family. Provides granular segmentation for specialized product variants.',
    `product_type` STRING COMMENT 'Primary classification discriminator for the petroleum product. Defines the major product family within the value chain. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|lng|lpg|ngl|gasoline|diesel|jet_fuel|fuel_oil|naphtha|kerosene|petrochemical|lubricant|asphalt|wax|other — 16 candidates stripped; promote to reference product]',
    `regulatory_product_code` STRING COMMENT 'Government or regulatory agency product classification code. Used for EPA reporting, SEC reserves disclosure, FERC filings, and state regulatory submissions.',
    `renewable_content_pct` DECIMAL(18,2) COMMENT 'Percentage of renewable or bio-based content in the product. Used for Renewable Fuel Standard (RFS) compliance, Low Carbon Fuel Standard (LCFS) reporting, and ESG metrics. Zero for conventional petroleum products.',
    `ron_rating` DECIMAL(18,2) COMMENT 'Research Octane Number for gasoline products. Measures resistance to engine knock. Typical range 87-98 RON. Null for non-gasoline products.',
    `shelf_life_days` STRING COMMENT 'Maximum storage duration in days before product quality degradation or specification non-compliance. Null for products with indefinite shelf life under proper storage conditions.',
    `specification_reference` STRING COMMENT 'Reference to detailed product specification document or standard. Examples: ASTM D975 for diesel fuel, ASTM D4814 for gasoline, API 5L for line pipe steel grade.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum recommended storage temperature in degrees Celsius. Prevents thermal degradation, excessive vapor generation, and safety hazards.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum recommended storage temperature in degrees Celsius. Critical for maintaining product quality and preventing solidification or phase separation.',
    `sulfur_content_pct` DECIMAL(18,2) COMMENT 'Sulfur content expressed as weight percentage. Sweet crude <0.5%, sour crude >0.5%. Critical for environmental compliance (EPA, IMO 2020), refining complexity, and product pricing differentials.',
    `tan_value` DECIMAL(18,2) COMMENT 'Total Acid Number expressed in mg KOH/g. Measures acidity and corrosiveness of crude oil and refined products. High TAN (>0.5) indicates corrosive crude requiring special metallurgy.',
    `tradeable_commodity_flag` BOOLEAN COMMENT 'Indicates whether the product is actively traded on commodity exchanges or spot markets (True) or is an internal intermediate product (False).',
    `un_number` STRING COMMENT 'Four-digit UN number for hazardous materials classification. Required for transportation documentation, safety data sheets, and emergency response. Example: UN1203 for gasoline.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for commercial transactions and inventory reporting. Examples: bbl (barrel), gal (gallon), m3 (cubic meter), kg (kilogram), mt (metric ton), mmbtu (million BTU), mcf (thousand cubic feet). [ENUM-REF-CANDIDATE: bbl|gal|m3|kg|mt|mmbtu|mcf|scf|ton — 9 candidates stripped; promote to reference product]',
    `vapor_pressure_kpa` DECIMAL(18,2) COMMENT 'Reid Vapor Pressure (RVP) measured in kilopascals. Indicates volatility and evaporation tendency. Critical for gasoline blending, storage tank design, and environmental compliance.',
    `viscosity_cst` DECIMAL(18,2) COMMENT 'Kinematic viscosity measured in centistokes at standard temperature (typically 40°C or 100°C). Affects pumping, atomization, and combustion characteristics.',
    CONSTRAINT pk_petroleum_product PRIMARY KEY(`petroleum_product_id`)
) COMMENT 'Master catalog and Single Source of Truth (SSOT) for all petroleum product identities across the value chain. Each product record represents a distinct marketable product — crude oil grades (WTI, Brent, Maya, Urals), natural gas, LNG, LPG, NGL fractions, refined fuels (gasoline, diesel, jet fuel, fuel oil, naphtha), and petrochemicals. Captures product type discriminator, product family/subfamily, API gravity, sulfur content, phase state, regulatory product codes, and lifecycle status. All downstream entities (quality specs, assays, pricing, blending, classifications) reference this master via FK.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`crude_grade` (
    `crude_grade_id` BIGINT COMMENT 'Unique identifier for the crude oil grade. Primary key for the crude grade reference master.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Crude grades are purchased and managed by legal entities for customs valuation, import/export compliance, tax reporting, and trade settlement. Critical for international crude trading and regulatory c',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Crude grades originate from specific leases; lease attribution is fundamental for royalty calculations, production accounting, reserve attribution, and regulatory reporting. Every crude grade in oil &',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Crude grades often have primary suppliers/traders (e.g., Saudi Aramco for Arab Light). Tracking primary vendor enables sourcing strategy, supply reliability, and vendor relationship management for cru',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Crude grades are produced/marketed by specific profit centers for P&L attribution, margin analysis, and segment reporting in upstream and trading operations.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity measurement in degrees API, indicating the density of the crude oil relative to water. Light crude: >31.1°API. Medium crude: 22.3-31.1°API. Heavy crude: <22.3°API. Critical for refinery yield optimization and pricing.',
    `api_gravity_band` STRING COMMENT 'Categorical classification of crude oil by API gravity. Light: >31.1°API. Medium: 22.3-31.1°API. Heavy: 10-22.3°API. Extra Heavy: <10°API. Used for refinery planning and commercial segmentation.. Valid values are `light|medium|heavy|extra_heavy`',
    `assay_date` DATE COMMENT 'Date when the crude oil assay was performed or last updated. Assays should be refreshed periodically as crude quality can vary over time due to reservoir changes or production operations.',
    `carbon_intensity_kg_co2_per_bbl` DECIMAL(18,2) COMMENT 'Estimated carbon intensity of production and processing in kg CO2 equivalent per barrel. Includes upstream production emissions and refining emissions. Used for ESG reporting, carbon accounting, and low-carbon crude sourcing decisions.',
    `carbon_residue_percent` DECIMAL(18,2) COMMENT 'Conradson or Ramsbottom carbon residue by weight percentage. Indicates the tendency of crude to form coke during thermal processing. High carbon residue reduces gasoline and diesel yields. Typical range: 1-15%.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crude grade record was first created in the system. Audit trail for data governance and compliance.',
    `crude_grade_status` STRING COMMENT 'Current lifecycle status of the crude grade in the product catalog. Active: available for trading and refining. Inactive: temporarily unavailable. Discontinued: no longer sourced. Under Evaluation: being assessed for future use. Restricted: limited availability or regulatory constraints.. Valid values are `active|inactive|discontinued|under_evaluation|restricted`',
    `delivery_point` STRING COMMENT 'Standard delivery or pricing point for this crude grade. Examples: Cushing Oklahoma, Sullom Voe Terminal, Ras Tanura, Rotterdam, Houston Ship Channel. Critical for logistics planning and freight cost calculation.',
    `effective_date` DATE COMMENT 'Date when this crude grade record became effective in the product catalog. Used for temporal tracking of crude grade specifications and pricing parameters.',
    `environmental_classification` STRING COMMENT 'Environmental processing classification based on emissions intensity and processing requirements. Conventional: standard refining emissions. Heavy Sour: higher SOx and CO2 emissions. High TAN: corrosion management required. High Metals: catalyst replacement frequency. Bitumen: upgrading required.. Valid values are `conventional|heavy_sour|high_tan|high_metals|bitumen`',
    `expiration_date` DATE COMMENT 'Date when this crude grade record expires or is superseded. Null indicates currently active record. Used for historical analysis and audit trail of crude grade changes.',
    `grade_classification` STRING COMMENT 'Classification of the crude grade by market role. Benchmark: globally traded pricing reference (WTI, Brent). Equity: company-owned production stream. Spot: opportunistic market purchase. Proprietary: custom refinery blend. Blend: mixed crude stream.. Valid values are `benchmark|equity|spot|proprietary|blend`',
    `grade_code` STRING COMMENT 'Unique business identifier code for the crude grade used in trading systems, refinery planning, and commercial contracts. Examples: WTI_CUSHING, BRENT_DATED, DUBAI_OMAN, URALS_RCMB, MAYA, ARAB_LIGHT.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `grade_name` STRING COMMENT 'Full commercial name of the crude oil grade. Examples: West Texas Intermediate Cushing, Dated Brent, Dubai/Oman, Urals RCMB, Maya, Arab Light, Bonny Light.',
    `h2s_content_ppm` DECIMAL(18,2) COMMENT 'Hydrogen sulfide content measured in parts per million (ppm). H2S is highly toxic and corrosive. Concentrations >100 ppm require special handling procedures and safety equipment. Critical for HSE risk assessment.',
    `metals_content_ppm` DECIMAL(18,2) COMMENT 'Total metals content (vanadium, nickel, iron) measured in parts per million (ppm). Metals poison refinery catalysts and reduce equipment life. High metals content reduces crude value and requires specialized processing.',
    `modified_by_user` STRING COMMENT 'User identifier or system account that last modified this crude grade record. Supports audit trail and data stewardship accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this crude grade record was last modified. Tracks data currency and supports change management processes.',
    `nitrogen_content_ppm` DECIMAL(18,2) COMMENT 'Nitrogen content measured in parts per million (ppm). Nitrogen compounds poison refinery catalysts and contribute to NOx emissions. Typical range: 100-5000 ppm. Impacts refining economics and environmental compliance.',
    `origin_basin` STRING COMMENT 'Geological basin or region where the crude oil is produced. Examples: Permian Basin, North Sea, Western Canadian Sedimentary Basin, Ghawar Field, Orinoco Belt. Used for supply chain planning and geopolitical risk assessment.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the crude oil origin. Examples: USA, GBR, SAU, RUS, VEN, NGA. Used for trade compliance, sanctions screening, and supply chain risk management.. Valid values are `^[A-Z]{3}$`',
    `origin_field_name` STRING COMMENT 'Specific oil field or production area where the crude is produced. Examples: Cushing Hub, Forties Field, Ghawar, Samotlor, Cantarell. Provides granular supply chain traceability and quality consistency tracking.',
    `pour_point_c` DECIMAL(18,2) COMMENT 'Pour point temperature in degrees Celsius, the lowest temperature at which the crude oil will flow under gravity. Critical for cold climate operations, storage, and transportation planning.',
    `pricing_differential_usd_per_bbl` DECIMAL(18,2) COMMENT 'Typical pricing differential versus the benchmark index in USD per barrel. Positive values indicate premium to benchmark; negative values indicate discount. Reflects quality, location, and market factors. Confidential commercial data.',
    `refinery_compatibility_rating` STRING COMMENT 'Overall compatibility rating for processing in company refineries. Excellent: ideal crude slate component. Good: suitable with standard processing. Fair: requires blending or special handling. Poor: limited use cases. Restricted: requires capital upgrades or special metallurgy.. Valid values are `excellent|good|fair|poor|restricted`',
    `regulatory_classification` STRING COMMENT 'Regulatory classification for transportation and handling. May include DOT hazard class, UN number, IMDG classification, and special handling requirements. Example: UN 1267 Petroleum Crude Oil Class 3 Flammable Liquid.',
    `salt_content_ptb` DECIMAL(18,2) COMMENT 'Salt content measured in pounds per thousand barrels (PTB). High salt content causes corrosion and fouling in refinery equipment. Desalting is required before processing. Typical specification: <10 PTB for refinery feed.',
    `sulfur_classification` STRING COMMENT 'Binary classification of crude oil by sulfur content. Sweet: ≤0.5% sulfur (lower processing cost, higher value). Sour: >0.5% sulfur (requires additional HDS processing, lower value). Key pricing and refinery selection criterion.. Valid values are `sweet|sour`',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'Sulfur content by weight percentage. Critical quality parameter for refining economics and environmental compliance. Sweet crude: ≤0.5% sulfur. Sour crude: >0.5% sulfur. Impacts hydrodesulfurization (HDS) processing costs.',
    `tan_value` DECIMAL(18,2) COMMENT 'Total Acid Number measured in mg KOH/g, indicating the acidity of the crude oil. High TAN (>0.5) causes corrosion in refinery equipment and requires special metallurgy. Critical for refinery compatibility assessment and pricing adjustments.',
    `transportation_mode` STRING COMMENT 'Primary mode of transportation for this crude grade from origin to delivery point. Pipeline: long-distance pipeline network. Tanker: ocean-going crude carrier. Rail: rail tank car. Truck: tank truck. Barge: inland waterway barge.. Valid values are `pipeline|tanker|rail|truck|barge`',
    `viscosity_cst` DECIMAL(18,2) COMMENT 'Kinematic viscosity measured in centistokes (cSt) at reference temperature (typically 40°C or 100°F). Indicates flow characteristics and pumpability. High viscosity crude requires heating for transportation and processing.',
    `viscosity_reference_temp_c` DECIMAL(18,2) COMMENT 'Reference temperature in degrees Celsius at which viscosity was measured. Standard temperatures are 40°C or 100°C. Required for accurate viscosity comparison and pipeline flow calculations.',
    `wax_content_percent` DECIMAL(18,2) COMMENT 'Paraffin wax content by weight percentage. High wax content can cause pipeline blockages in cold conditions and affects refinery processing. Typical range: 0-30%.',
    `yield_diesel_percent` DECIMAL(18,2) COMMENT 'Typical diesel and middle distillate yield percentage from refinery processing. Includes diesel, jet fuel, and kerosene streams. Medium crudes typically yield 30-40% middle distillates. Key driver of refinery margin.',
    `yield_gasoline_percent` DECIMAL(18,2) COMMENT 'Typical gasoline yield percentage from refinery processing of this crude grade. Includes naphtha and reformate streams. Light sweet crudes typically yield 25-35% gasoline. Critical for refinery economics and crude selection.',
    `yield_residual_percent` DECIMAL(18,2) COMMENT 'Typical residual fuel oil yield percentage from atmospheric and vacuum distillation. Heavy crudes yield 30-50% residuals. High residual yield reduces refinery margin unless coking or other upgrading capacity is available.',
    CONSTRAINT pk_crude_grade PRIMARY KEY(`crude_grade_id`)
) COMMENT 'Reference master for crude oil grades and pricing benchmarks used in trading, refining, and marketing. Each record represents a distinct crude stream — WTI Cushing, Dated Brent, Dubai/Oman, Urals RCMB, Maya, Arab Light/Medium/Heavy, Bonny Light, and proprietary equity crudes. Captures API gravity band (light/medium/heavy), sulfur classification (sweet ≤0.5% / sour >0.5%), TAN, viscosity at reference temperature, pour point, wax content, assay reference, benchmark pricing index, and origin basin/field. References petroleum_product for catalog identity.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`quality_spec` (
    `quality_spec_id` BIGINT COMMENT 'Unique identifier for the product quality specification record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Quality specifications are defined and maintained at legal entity level for regulatory compliance (EPA, ASTM standards), market requirements, and contractual obligations. Different entities may have d',
    `vendor_qualification_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_qualification. Business justification: Vendor qualification processes verify suppliers can meet specific quality specifications for products and services. AVL (Approved Vendor List) status depends on demonstrated capability to meet API, IS',
    `applicable_market` STRING COMMENT 'Geographic market or regulatory jurisdiction where this specification applies (e.g., US Gulf Coast, European Union, Asia-Pacific, California CARB, Federal Tier 3). Used to manage regional product quality variations.',
    `approval_authority` STRING COMMENT 'Name or role of the individual or committee that approved this specification for use (e.g., Chief Quality Officer, Refining Operations Manager, Product Quality Committee).',
    `approval_date` DATE COMMENT 'Date on which this specification was formally approved for operational use.',
    `contract_reference` STRING COMMENT 'Reference to the commercial contract or term agreement that mandates this specification. Null if the specification is not contract-specific.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this specification record was first created in the system.',
    `criticality_level` STRING COMMENT 'Business impact classification of this parameter: critical (failure results in product rejection or regulatory violation), major (significant quality concern), minor (informational or optimization parameter).. Valid values are `critical|major|minor`',
    `effective_date` DATE COMMENT 'Date from which this quality specification becomes active and enforceable for custody transfer, compliance, or contract fulfillment.',
    `expiration_date` DATE COMMENT 'Date on which this specification is superseded or no longer valid. Null for open-ended specifications.',
    `last_modified_by` STRING COMMENT 'User ID or name of the individual who last updated this specification record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this specification record was last modified.',
    `maximum_value` DECIMAL(18,2) COMMENT 'Upper acceptance limit for the quality parameter. Values above this threshold fail the specification. Null if no maximum is defined.',
    `minimum_value` DECIMAL(18,2) COMMENT 'Lower acceptance limit for the quality parameter. Values below this threshold fail the specification. Null if no minimum is defined.',
    `parameter_name` STRING COMMENT 'Name of the quality parameter being specified (e.g., API Gravity, Sulfur Content, Research Octane Number (RON), Cetane Number, Flash Point, Viscosity, Cloud Point, Pour Point, Freeze Point, Smoke Point, H2S Content, Total Acid Number (TAN), Reid Vapor Pressure, Distillation T90, Aromatics Content).',
    `pass_fail_logic` STRING COMMENT 'Rule used to determine specification compliance: within_range (value must be between min and max), below_max (value must not exceed maximum), above_min (value must meet or exceed minimum), equals_target (value must match target within tolerance).. Valid values are `within_range|below_max|above_min|equals_target`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or governing authority that mandates this specification (e.g., EPA, CARB, BSEE, FERC, European Commission, API). Null if not regulatory-driven.',
    `regulatory_citation` STRING COMMENT 'Specific regulation, code section, or standard citation that requires this specification (e.g., 40 CFR Part 80, EN 590:2013, ASTM D1655-21, California Code of Regulations Title 13). Null if not regulatory-driven.',
    `sampling_frequency` STRING COMMENT 'Required frequency for testing this parameter (e.g., per batch, daily, per cargo, continuous, weekly). Defines the cadence of quality verification.',
    `sampling_method` STRING COMMENT 'Standard procedure for collecting representative samples for testing (e.g., API MPMS Chapter 8.1, ASTM D4057, ISO 3170). Ensures sample integrity and test validity.',
    `spec_code` STRING COMMENT 'Unique alphanumeric code identifying this specification within the enterprise product catalog (e.g., SPEC-WTI-001, ULSD-W22).',
    `spec_name` STRING COMMENT 'Business name or title of this quality specification envelope (e.g., WTI Export Grade, ULSD Winter Spec, Jet A-1 ASTM D1655).',
    `spec_status` STRING COMMENT 'Current lifecycle status of the specification: draft (under development), active (in use), superseded (replaced by newer version), retired (no longer applicable), under_review (pending approval or revision).. Valid values are `draft|active|superseded|retired|under_review`',
    `spec_type` STRING COMMENT 'Classification of the specification context: custody_transfer (used for product handover and payment), refinery_gate (receipt or delivery at refinery), contract (specific to a commercial agreement), regulatory (mandated by EPA, BSEE, or other authority), internal_control (process optimization), export (international shipment), import (receiving from external source). [ENUM-REF-CANDIDATE: custody_transfer|refinery_gate|contract|regulatory|internal_control|export|import — 7 candidates stripped; promote to reference product]',
    `spec_version` STRING COMMENT 'Version identifier for this specification, used to track revisions over time (e.g., v1.0, 2023-Q2, Rev 3).',
    `specification_notes` STRING COMMENT 'Additional context, clarifications, or special instructions related to this quality specification (e.g., seasonal adjustments, alternative test methods, historical context).',
    `target_value` DECIMAL(18,2) COMMENT 'Ideal or target value for the quality parameter, representing optimal product quality. Used for process control and optimization. Null if not applicable.',
    `test_method_description` STRING COMMENT 'Brief description of the test method or procedure used to determine the parameter value.',
    `test_method_standard` STRING COMMENT 'Industry-standard test method used to measure this parameter (e.g., ASTM D287, ASTM D4294, ASTM D2699, ASTM D613, ASTM D93, EN 590, IP 365, ISO 3104). Specifies the laboratory procedure for custody transfer and compliance verification.',
    `tolerance_type` STRING COMMENT 'Method used to define acceptable deviation from target: absolute (fixed numeric range), percentage (relative to target), statistical (based on standard deviation or confidence interval).. Valid values are `absolute|percentage|statistical`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the parameter values (e.g., degrees API, wt%, ppm, cSt, degrees C, degrees F, kPa, psi, mg KOH/g).',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this specification record in the system.',
    CONSTRAINT pk_quality_spec PRIMARY KEY(`quality_spec_id`)
) COMMENT 'Defines the authoritative quality specification envelope for each petroleum product — the acceptance limits used in custody transfer, refinery gate receipt, and regulatory compliance. Captures parameter name, minimum/maximum/target values, test method (ASTM, EN, IP standard number), and applicable market or contract context. Typical parameters include API gravity range, sulfur content (wt%), RON/MON for gasolines, cetane number for diesel, flash point, viscosity, cloud/pour/freeze point, smoke point for jet fuel, and H2S limits. Each spec record links to petroleum_product and serves as the reference for pass/fail determination in quality_test_result.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`assay` (
    `assay_id` BIGINT COMMENT 'Unique identifier for the crude oil or condensate assay record. Primary key for the product assay entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Assays are performed for legal entity compliance, customs valuation (API gravity, sulfur content), trade documentation, and financial reporting. Essential for crude trading and refinery feedstock acco',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Crude assay costs (laboratory analysis, third-party testing) are charged to exploration or trading cost centers for crude evaluation and acquisition decision support.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key reference to the crude grade or condensate type that this assay characterizes. Links to the product catalog master data.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Third-party laboratories performing crude assays are vendors providing analytical services. Links assay data to vendor for quality assurance, accreditation verification, and service procurement manage',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Crude assays are lease-specific when production streams are not commingled. Critical for refinery planning, crude valuation, and marketing. Business process: crude marketing strategy and pricing diffe',
    `analysis_date` DATE COMMENT 'Date when the laboratory assay analysis was performed. Critical for tracking assay currency and determining which assay to use for refinery planning.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the crude oil or condensate measured at 60°F. Key quality indicator inversely related to density. Light crudes have higher API gravity (>31.1°), heavy crudes lower (<22.3°).',
    `aromatics_content_vol_pct` DECIMAL(18,2) COMMENT 'Total aromatic hydrocarbon content as volume percent. Aromatics affect octane number in gasoline, cetane number in diesel, and smoke point in jet fuel.',
    `asphaltene_content_wt_pct` DECIMAL(18,2) COMMENT 'Asphaltene content as weight percent. High asphaltene content affects crude stability, blending compatibility, and processing difficulty in heavy oil upgrading.',
    `assay_status` STRING COMMENT 'Current lifecycle status of the assay record. Validated and approved assays are used for refinery linear programming (LP) models and crude evaluation.. Valid values are `draft|validated|approved|superseded|archived`',
    `carbon_residue_wt_pct` DECIMAL(18,2) COMMENT 'Conradson Carbon Residue as weight percent. Indicates coke-forming tendency of the crude, particularly important for vacuum residue processing and coking unit feed evaluation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assay record was first created in the system. Part of audit trail for data lineage and compliance.',
    `diesel_yield_vol_pct` DECIMAL(18,2) COMMENT 'Volume percent yield of diesel fraction (520-650°F) from distillation. Diesel fraction is processed into automotive diesel, heating oil, and marine fuel.',
    `distillation_method` STRING COMMENT 'Laboratory distillation method used to generate the yield curve. ASTM D86 is atmospheric batch distillation; TBP (True Boiling Point) uses ASTM D2892 (atmospheric) and D5236 (vacuum) for detailed fractionation.. Valid values are `ASTM D86|TBP|ASTM D2892|ASTM D5236`',
    `flash_point_f` STRING COMMENT 'Lowest temperature at which vapors above the crude will ignite when exposed to an ignition source. Critical safety parameter for storage and transportation classification.',
    `gross_heating_value_btu_per_lb` STRING COMMENT 'Gross heating value (higher heating value) in British Thermal Units per pound. Used for energy content calculations and fuel value assessment.',
    `h2s_content_ppm` STRING COMMENT 'Hydrogen sulfide content in parts per million. H2S is highly toxic and corrosive. Crudes with >100 ppm H2S require special handling and safety protocols.',
    `hydrogen_content_wt_pct` DECIMAL(18,2) COMMENT 'Hydrogen content as weight percent. Higher hydrogen content indicates more paraffinic character and better refining yields. Used in hydrogen balance calculations.',
    `iron_content_ppm` DECIMAL(18,2) COMMENT 'Iron metal content in parts per million. Elevated iron indicates contamination from pipelines, storage tanks, or production equipment.',
    `kerosene_yield_vol_pct` DECIMAL(18,2) COMMENT 'Volume percent yield of kerosene fraction (380-520°F) from distillation. Kerosene is used for jet fuel and heating oil production.',
    `mercaptan_sulfur_ppm` STRING COMMENT 'Mercaptan sulfur content in parts per million. Mercaptans are odorous sulfur compounds that must be removed or converted in refining to meet product specifications.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assay record was last modified. Tracks updates to assay data as new analyses are performed or corrections are made.',
    `naphtha_yield_vol_pct` DECIMAL(18,2) COMMENT 'Volume percent yield of naphtha fraction (IBP-380°F) from ASTM D86 or True Boiling Point (TBP) distillation. Naphtha is feedstock for gasoline blending and petrochemical reforming.',
    `nickel_content_ppm` DECIMAL(18,2) COMMENT 'Nickel metal content in parts per million. Nickel and vanadium are catalyst poisons in FCC and hydrocracking units, concentrated in heavy residue fractions.',
    `nitrogen_content_ppm` STRING COMMENT 'Total nitrogen content in parts per million. Nitrogen compounds poison catalysts in fluid catalytic cracking (FCC) and hydrotreating units.',
    `olefins_content_vol_pct` DECIMAL(18,2) COMMENT 'Olefin (unsaturated hydrocarbon) content as volume percent. Olefins are typically low in crude oil but increase in thermally cracked products. Affect stability and gum formation.',
    `pour_point_f` STRING COMMENT 'Lowest temperature at which the crude oil will pour or flow under prescribed conditions. Critical for pipeline transportation and storage in cold climates.',
    `reid_vapor_pressure_psi` DECIMAL(18,2) COMMENT 'Reid Vapor Pressure measured in pounds per square inch at 100°F. Indicates volatility and light-end content. Important for safety and environmental compliance.',
    `residue_yield_vol_pct` DECIMAL(18,2) COMMENT 'Volume percent yield of vacuum residue (1050°F+). Residue is processed in coking, visbreaking, or deasphalting units, or used as fuel oil or asphalt feedstock.',
    `salt_content_ptb` DECIMAL(18,2) COMMENT 'Salt content expressed as pounds per thousand barrels (PTB). High salt content causes corrosion in crude distillation unit (CDU) overhead systems and requires desalting.',
    `saturates_content_vol_pct` DECIMAL(18,2) COMMENT 'Saturated hydrocarbon (paraffins and naphthenes) content as volume percent. Saturates are desirable for diesel cetane number and lube oil base stocks.',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Specific gravity of the crude relative to water at standard conditions (60°F/60°F). Used in volume-to-mass conversions and refinery yield calculations.',
    `sulfur_content_wt_pct` DECIMAL(18,2) COMMENT 'Total sulfur content of the whole crude expressed as weight percent. Critical for classifying crude as sweet (<0.5%) or sour (>0.5%) and determining hydrodesulfurization (HDS) requirements.',
    `tan_mg_koh_per_g` DECIMAL(18,2) COMMENT 'Total Acid Number representing naphthenic acid content, measured in milligrams of potassium hydroxide per gram of sample. High TAN crudes (>0.5) cause corrosion in refinery equipment.',
    `uopk_characterization_factor` DECIMAL(18,2) COMMENT 'UOP K characterization factor calculated from boiling point and specific gravity. Indicates paraffinic (K>12), naphthenic (K=11-12), or aromatic (K<11) character of the crude.',
    `vanadium_content_ppm` DECIMAL(18,2) COMMENT 'Vanadium metal content in parts per million. High vanadium content (>50 ppm) requires special catalyst formulations and impacts refinery economics.',
    `version` STRING COMMENT 'Version identifier for this assay record. Multiple assays may exist for the same crude grade over time as new laboratory analyses are performed or field conditions change.',
    `vgo_yield_vol_pct` DECIMAL(18,2) COMMENT 'Volume percent yield of vacuum gas oil fraction (650-1050°F). VGO is feedstock for fluid catalytic cracking (FCC) and hydrocracking units to produce gasoline and diesel.',
    `viscosity_at_100f_cst` DECIMAL(18,2) COMMENT 'Kinematic viscosity measured at 100°F in centistokes. Affects pumping requirements, pipeline pressure drop calculations, and refinery processing.',
    `viscosity_at_210f_cst` DECIMAL(18,2) COMMENT 'Kinematic viscosity measured at 210°F in centistokes. Used with 100°F viscosity to calculate viscosity index and temperature-viscosity relationships.',
    `water_content_vol_pct` DECIMAL(18,2) COMMENT 'Water and sediment content as volume percent. Affects custody transfer measurements and must be removed before refining to prevent equipment damage.',
    `wax_content_wt_pct` DECIMAL(18,2) COMMENT 'Paraffin wax content as weight percent. High wax content affects pour point, pipeline flow, and requires dewaxing in lube oil production.',
    CONSTRAINT pk_assay PRIMARY KEY(`assay_id`)
) COMMENT 'Versioned crude oil and condensate assay records containing full physicochemical characterization data. Each assay captures TBP distillation curve, ASTM D86 yields by cut point (naphtha, kerosene, diesel, VGO, residue), density and viscosity profiles, sulfur/nitrogen distribution across fractions, metals content (Ni, V, Fe), UOPK characterization factor, naphthenic acid (TAN) profile, and wax/asphaltene content. Assays are versioned by analysis date and linked to crude_grade. Primary consumers are refinery planning (LP models, Aspen HYSYS), crude evaluation, and trading (quality-based pricing adjustments).';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`refined_product` (
    `refined_product_id` BIGINT COMMENT 'Unique identifier for the refined petroleum product. Primary key for the refined product master entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Refined products are manufactured and sold by legal entities for excise duty compliance, customs reporting (harmonized tariff codes), environmental regulations, and financial statement preparation. Es',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Refined products incur production costs (refining, blending, quality control, packaging) allocated to cost centers for product costing, margin analysis, and operational performance tracking in downstr',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Refined products result from capital projects (new refining units, upgrading facilities, blending systems) authorized via AFEs. Links product output to capital investment for asset capitalization and ',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Refineries may be operated under JOAs in joint venture arrangements. Tracking which JOA operates the refinery producing specific refined products is required for cost allocation, partner billing (JIB)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Refined products (gasoline, diesel, jet fuel) are managed by downstream profit centers for margin analysis, crack spread tracking, and refinery performance measurement.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: refined_product has a denormalized STRING column `specification_standard` (e.g., EN 590, ASTM D975, DEF STAN 91-091) that references the applicable quality specification. quality_spec is the authorita',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity measurement of the refined product, indicating density relative to water. Higher values indicate lighter products. Measured in degrees API.',
    `aromatics_content_percent` DECIMAL(18,2) COMMENT 'Total aromatics content as percentage by volume. Affects combustion characteristics and emissions. Regulated in many jurisdictions for environmental compliance.',
    `ash_content_percent` DECIMAL(18,2) COMMENT 'Ash content as percentage by mass, representing inorganic residue after combustion. Important for fuel oils and indicates potential for deposit formation.',
    `benzene_content_percent` DECIMAL(18,2) COMMENT 'Benzene content as percentage by volume. Regulated for environmental and health reasons, particularly in gasoline products. EPA Tier 3 limits benzene to 0.62% annual average.',
    `blending_component_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this product is a blending component (True) used to create finished products, or a finished product itself (False). Blending components include reformate, alkylate, MTBE, ethanol.',
    `carbon_residue_percent` DECIMAL(18,2) COMMENT 'Carbon residue (Conradson or Ramsbottom method) as percentage by mass, indicating tendency to form carbonaceous deposits. Relevant for heavier fuel products.',
    `cetane_number` DECIMAL(18,2) COMMENT 'Cetane number for diesel products, measuring ignition quality and combustion performance. Higher values indicate better ignition characteristics. Typical range 40-60.',
    `cold_filter_plugging_point_celsius` DECIMAL(18,2) COMMENT 'Cold Filter Plugging Point (CFPP) in degrees Celsius, the lowest temperature at which diesel fuel will pass through a standardized filter. Critical for cold weather operability.',
    `color_astm` STRING COMMENT 'ASTM color designation of the product (e.g., ASTM D1500 scale 0.5-8.0 for petroleum products, or Saybolt color for lighter products). Indicates product purity and quality.',
    `copper_strip_corrosion` STRING COMMENT 'Copper strip corrosion test result (e.g., 1a, 1b, 2a), indicating corrosiveness of the product to copper and copper alloys. Important for fuel system compatibility.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product record was first created in the system. Used for audit trail and data lineage tracking.',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT 'Density of the refined product measured in kilograms per cubic meter (kg/m³) at standard temperature (15°C). Used for volume-to-mass conversions and custody transfer.',
    `distillation_range_celsius` STRING COMMENT 'Distillation temperature range in degrees Celsius (e.g., 150-250°C), indicating the boiling point distribution of hydrocarbon components. Defines volatility characteristics.',
    `effective_date` DATE COMMENT 'Date when this product specification became effective and available for commercial transactions. Used for managing specification changes and product transitions.',
    `excise_duty_category` STRING COMMENT 'Excise duty or tax category code applicable to this product under relevant tax jurisdictions. Determines applicable excise rates and reporting requirements.',
    `expiration_date` DATE COMMENT 'Date when this product specification expires or is superseded. Null for products with indefinite availability. Used for managing product lifecycle and specification transitions.',
    `export_domestic_classification` STRING COMMENT 'Classification indicating whether the product is sold domestically, exported internationally, or both. Affects pricing, taxation, and regulatory compliance requirements.. Valid values are `DOMESTIC|EXPORT|BOTH`',
    `flash_point_celsius` DECIMAL(18,2) COMMENT 'Flash point temperature in degrees Celsius, the lowest temperature at which vapors ignite when exposed to an ignition source. Critical safety and transportation classification parameter.',
    `freeze_point_celsius` DECIMAL(18,2) COMMENT 'Freeze point temperature in degrees Celsius, particularly relevant for jet fuel. The temperature at which hydrocarbon crystals form, affecting fuel flow and filter plugging.',
    `harmonized_tariff_code` STRING COMMENT 'Harmonized System tariff classification code (6-10 digits) for international trade and customs purposes. Used for import/export documentation and duty calculation.. Valid values are `^[0-9]{6,10}$`',
    `hazard_class` STRING COMMENT 'Hazard classification for transportation and storage (e.g., Class 3 Flammable Liquids). Determines handling, storage, and transportation requirements.',
    `heating_value_mj_per_kg` DECIMAL(18,2) COMMENT 'Net (lower) heating value of the product in megajoules per kilogram (MJ/kg), representing energy content. Used for energy balance calculations and pricing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product record was last modified. Used for change tracking and audit purposes.',
    `lubricity_microns` DECIMAL(18,2) COMMENT 'Lubricity measurement in microns (wear scar diameter at 60°C), indicating lubricating properties of diesel fuel. Critical for fuel injection system protection, especially in ULSD.',
    `olefins_content_percent` DECIMAL(18,2) COMMENT 'Olefins content as percentage by volume. Influences gasoline stability and emissions. Subject to regulatory limits in some markets.',
    `oxygenate_content_percent` DECIMAL(18,2) COMMENT 'Oxygenate content (ethanol, MTBE, ETBE) as percentage by volume. Mandated in many jurisdictions for emissions reduction. Affects fuel properties and compatibility.',
    `packing_group` STRING COMMENT 'UN packing group classification (I=high danger, II=medium danger, III=low danger) indicating degree of hazard for transportation purposes.. Valid values are `I|II|III`',
    `pour_point_celsius` DECIMAL(18,2) COMMENT 'Pour point temperature in degrees Celsius, the lowest temperature at which the product will flow. Critical for cold weather operability and storage.',
    `product_grade` STRING COMMENT 'Specific grade or quality designation of the refined product (e.g., Premium, Regular, Ultra Low Sulfur, High Sulfur, Grade A-1, ISO 8217 RMG380). Defines quality tier within product type.',
    `product_status` STRING COMMENT 'Current lifecycle status of the refined product in the catalog. ACTIVE=currently produced and sold, INACTIVE=temporarily not available, DISCONTINUED=permanently removed from catalog, PENDING_APPROVAL=awaiting regulatory or commercial approval, RESTRICTED=limited availability or special authorization required.. Valid values are `ACTIVE|INACTIVE|DISCONTINUED|PENDING_APPROVAL|RESTRICTED`',
    `ron_rating` DECIMAL(18,2) COMMENT 'Research Octane Number rating for gasoline products, measuring resistance to engine knocking. Applicable to MOGAS and AVGAS products. Typical range 87-100.',
    `sediment_content_percent` DECIMAL(18,2) COMMENT 'Sediment and particulate content as percentage by mass. Indicates product cleanliness and potential for filter plugging and equipment wear.',
    `smoke_point_mm` DECIMAL(18,2) COMMENT 'Smoke point measurement in millimeters for jet fuel and kerosene, indicating burning quality and tendency to produce smoke. Higher values indicate cleaner combustion.',
    `sulfur_content_ppm` DECIMAL(18,2) COMMENT 'Sulfur content of the refined product measured in parts per million (ppm). Critical for environmental compliance and product classification (e.g., ULSD typically <15 ppm).',
    `un_number` STRING COMMENT 'UN number for hazardous materials classification and transportation (e.g., UN1203 for gasoline, UN1202 for diesel). Required for shipping documentation and safety compliance.. Valid values are `^UN[0-9]{4}$`',
    `vapor_pressure_kpa` DECIMAL(18,2) COMMENT 'Reid Vapor Pressure (RVP) measured in kilopascals (kPa), indicating volatility and evaporation tendency. Critical for gasoline products and environmental compliance.',
    `viscosity_cst` DECIMAL(18,2) COMMENT 'Kinematic viscosity of the product measured in centistokes (cSt) at a specified temperature. Indicates flow characteristics, particularly important for fuel oils and lubricants.',
    `water_content_ppm` DECIMAL(18,2) COMMENT 'Water content measured in parts per million (ppm). Excessive water can cause corrosion, microbial growth, and operational issues. Critical quality parameter for all refined products.',
    CONSTRAINT pk_refined_product PRIMARY KEY(`refined_product_id`)
) COMMENT 'Master entity for finished refined petroleum products including motor gasoline (MOGAS), aviation gasoline (AVGAS), jet fuel (Jet A, Jet A-1), diesel (ULSD, HSFO), marine fuel oil (VLSFO, HSFO), LPG, naphtha, kerosene, bitumen, and lubricant base oils. Captures product grade, specification standard, blending component flag, export/domestic classification, and applicable excise/duty category.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`ngl_stream` (
    `ngl_stream_id` BIGINT COMMENT 'Unique identifier for the NGL stream record. Primary key for the NGL stream master catalog.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the gas processing facility or plant where the NGL stream originates.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: NGL streams are managed by legal entities for regulatory compliance (customs tariff codes, UN numbers), tax reporting, trade settlement, and financial consolidation in midstream operations.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: NGL component contracts (ethane, propane, butane, natural gasoline) are negotiated separately with purity specifications, pricing indexed to Mont Belvieu or Conway, and delivery terms. Midstream comme',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NGL streams incur processing, fractionation, storage, and transportation costs allocated to cost centers for midstream operations accounting, product margin analysis, and operational budgeting.',
    `equipment_id` BIGINT COMMENT 'Reference to the fractionation train or gas processing facility where this NGL stream is produced.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: NGL streams from joint venture gas processing plants are governed by JOAs. Business process: NGL fractionation cost allocation, product split calculations among partners, partner entitlement by NGL co',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: NGL streams are extracted from lease production; lease attribution is required for accurate royalty disbursement, revenue allocation to working interest owners, and state/federal production tax report',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: ngl_stream is a master catalog for NGL streams (ethane, propane, butane, etc.) which are petroleum products. petroleum_product is the SSOT for all petroleum product identities across the value chain. ',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.pricing_benchmark. Business justification: ngl_stream has a denormalized STRING column `pricing_index` that references the pricing benchmark used for NGL pricing (e.g., Mont Belvieu propane index, Conway ethane index). Replacing it with pricin',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: NGL streams may be sourced from specific vendors (gas processors, fractionators) for supply agreements. Enables sourcing strategy, supply reliability tracking, and vendor relationship management for N',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: NGL streams (ethane, propane, butane) are revenue-generating products managed by midstream profit centers for product margin tracking and fractionation economics.',
    `autoignition_temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Autoignition temperature of the NGL stream in degrees Fahrenheit, used for fire safety and process design.',
    `component_type` STRING COMMENT 'Primary NGL component classification identifying the dominant hydrocarbon fraction in the stream. [ENUM-REF-CANDIDATE: ethane|propane|normal_butane|isobutane|natural_gasoline|mixed_ngl|pentanes_plus — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NGL stream record was first created in the system.',
    `customs_tariff_code` STRING COMMENT 'Harmonized System tariff code for the NGL stream used in international trade and customs declarations.. Valid values are `^[0-9]{6,10}$`',
    `effective_date` DATE COMMENT 'Date when this NGL stream specification became effective in the product catalog and operational systems.',
    `ethane_mol_percent` DECIMAL(18,2) COMMENT 'Mole percentage of ethane (C2H6) in the NGL stream composition, critical for petrochemical feedstock specifications.',
    `expiration_date` DATE COMMENT 'Date when this NGL stream specification expires or is scheduled for decommissioning. Null for active indefinite streams.',
    `flash_point_fahrenheit` DECIMAL(18,2) COMMENT 'Flash point temperature of the NGL stream in degrees Fahrenheit, critical for safety and handling procedures.',
    `fuel_blending_approved_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this NGL stream is approved for blending into motor fuels or heating fuels.',
    `h2s_content_ppm` DECIMAL(18,2) COMMENT 'Hydrogen sulfide content in the NGL stream measured in parts per million, critical for safety and product quality specifications.',
    `hazard_classification` STRING COMMENT 'Hazard classification code for the NGL stream per DOT/PHMSA regulations for transportation and handling safety.',
    `heating_value_btu_per_gallon` DECIMAL(18,2) COMMENT 'Gross heating value of the NGL stream measured in BTU per gallon, used for energy content specification and pricing adjustments.',
    `isobutane_mol_percent` DECIMAL(18,2) COMMENT 'Mole percentage of isobutane (i-C4H10) in the NGL stream composition, important for alkylation feedstock and blending operations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this NGL stream record was last updated or modified.',
    `last_quality_test_date` DATE COMMENT 'Date of the most recent laboratory quality test performed on this NGL stream to verify composition and specifications.',
    `mercury_content_ppb` DECIMAL(18,2) COMMENT 'Mercury content in the NGL stream measured in parts per billion, important for equipment protection and environmental compliance.',
    `modified_by_user` STRING COMMENT 'User identifier or system account that last modified this NGL stream record, used for audit trail and data governance.',
    `normal_butane_mol_percent` DECIMAL(18,2) COMMENT 'Mole percentage of normal butane (n-C4H10) in the NGL stream composition.',
    `pentanes_plus_mol_percent` DECIMAL(18,2) COMMENT 'Mole percentage of pentanes and heavier hydrocarbons (C5+) in the NGL stream, also known as natural gasoline component.',
    `petrochemical_feedstock_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this NGL stream is designated for use as petrochemical feedstock (ethylene cracking, alkylation, etc.).',
    `pricing_basis` STRING COMMENT 'Pricing methodology used for commercial transactions of this NGL stream.. Valid values are `spot|contract|formula|netback`',
    `product_grade` STRING COMMENT 'Quality grade or specification designation for the NGL stream (e.g., HD-5 Propane, Commercial Propane, Polymer Grade Propylene).',
    `propane_mol_percent` DECIMAL(18,2) COMMENT 'Mole percentage of propane (C3H8) in the NGL stream composition.',
    `purity_percent` DECIMAL(18,2) COMMENT 'Purity percentage of the primary component in the NGL stream, critical for petrochemical feedstock and product specifications.',
    `regulatory_product_code` STRING COMMENT 'Regulatory product classification code assigned by governing bodies (EPA, FERC, state agencies) for compliance reporting and tracking.',
    `shrinkage_factor_percent` DECIMAL(18,2) COMMENT 'Percentage shrinkage factor representing the volume loss during NGL extraction from raw natural gas, used for production allocation and revenue calculations.',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Specific gravity of the NGL stream relative to water at 60°F, used for volume-to-mass conversions and custody transfer calculations.',
    `specification_notes` STRING COMMENT 'Free-text field for additional specification details, quality variances, seasonal adjustments, or special handling instructions for the NGL stream.',
    `storage_classification` STRING COMMENT 'Storage method classification for the NGL stream based on its physical properties and handling requirements.. Valid values are `pressurized|refrigerated|ambient|underground_cavern`',
    `stream_code` STRING COMMENT 'Unique business identifier for the NGL stream used across operations, typically assigned by the gas processing facility or fractionation plant.. Valid values are `^[A-Z0-9]{4,12}$`',
    `stream_name` STRING COMMENT 'Descriptive name of the NGL stream or fraction (e.g., Ethane Product, Propane Mix, C5+ Natural Gasoline).',
    `stream_status` STRING COMMENT 'Current operational status of the NGL stream in the product catalog and production operations.. Valid values are `active|inactive|suspended|planned|decommissioned`',
    `sulfur_content_ppm` DECIMAL(18,2) COMMENT 'Total sulfur content in the NGL stream measured in parts per million, important for product quality and environmental compliance.',
    `transportation_mode` STRING COMMENT 'Primary transportation mode used for moving this NGL stream from the processing facility to downstream markets or storage.. Valid values are `pipeline|rail|truck|marine|storage`',
    `un_number` STRING COMMENT 'United Nations identification number for the NGL stream used in international transportation and hazardous materials documentation.. Valid values are `^UN[0-9]{4}$`',
    `vapor_pressure_psi` DECIMAL(18,2) COMMENT 'Reid Vapor Pressure of the NGL stream measured in PSI at 100°F, critical for transportation safety and product specifications.',
    `water_content_ppm` DECIMAL(18,2) COMMENT 'Water content in the NGL stream measured in parts per million, critical for pipeline transportation specifications and corrosion prevention.',
    CONSTRAINT pk_ngl_stream PRIMARY KEY(`ngl_stream_id`)
) COMMENT 'Master catalog for Natural Gas Liquids (NGL) streams and fractions including ethane, propane, normal butane, isobutane, natural gasoline (C5+), and mixed NGL. Captures stream composition (mol%), heating value, vapor pressure (RVP), shrinkage factor, fractionation train origin, and applicable NGL pricing index (Mont Belvieu, Conway). Used by gas processing, petrochemical feedstock planning, and revenue allocation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` (
    `pricing_benchmark_id` BIGINT COMMENT 'Unique identifier for the product pricing benchmark record. Primary key for the product pricing benchmark entity.',
    `assessment_window_end` STRING COMMENT 'For daily assessed benchmarks, the end time of the assessment window during which market activity is observed (e.g., 16:30 London time for Brent, 14:30 US Central for WTI). Defines the close of the price discovery period.',
    `assessment_window_start` STRING COMMENT 'For daily assessed benchmarks, the start time of the assessment window during which market activity is observed (e.g., 16:00 London time for Brent, 14:30 US Central for WTI). Critical for understanding price discovery timing.',
    `benchmark_code` STRING COMMENT 'Short code or ticker symbol for the pricing benchmark (e.g., WTI, BRENT, HH, JKM, TTF, NBP, MOPS). Used for system integration and trading platform identification.',
    `benchmark_description` STRING COMMENT 'Detailed business description of the pricing benchmark including its market significance, typical use cases, and any special characteristics or calculation methodologies that commercial and trading teams need to understand.',
    `benchmark_name` STRING COMMENT 'The official name of the pricing benchmark or price index (e.g., West Texas Intermediate, Brent Crude, Henry Hub, Japan Korea Marker, Title Transfer Facility, National Balancing Point, Mean of Platts Singapore).',
    `benchmark_status` STRING COMMENT 'Current lifecycle status of the pricing benchmark. Active benchmarks are currently published and used in contracts, inactive are no longer published but historical data exists, suspended are temporarily halted, discontinued are permanently retired.. Valid values are `active|inactive|suspended|discontinued|under_review`',
    `benchmark_type` STRING COMMENT 'Classification of the pricing benchmark by market instrument type. Spot represents immediate delivery prices, futures are exchange-traded contracts, forward are OTC contracts, swap are differential contracts, index are composite calculations, and average are time-weighted averages.. Valid values are `spot|futures|forward|swap|index|average`',
    `commodity_type` STRING COMMENT 'The petroleum product category that this benchmark represents. Crude oil includes WTI and Brent, natural gas includes Henry Hub and TTF, LNG includes JKM, refined products include gasoline and diesel, and petrochemicals include ethylene and propylene. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|lng|lpg|ngl|gasoline|diesel|jet_fuel|fuel_oil|petrochemical — 10 candidates stripped; promote to reference product]',
    `contract_month` STRING COMMENT 'For futures and forward benchmarks, the delivery or settlement month (e.g., January 2024, Q1 2024, Summer 2024). Null for spot benchmarks. Used for forward curve construction.',
    `contract_symbol` STRING COMMENT 'For exchange-traded benchmarks, the official contract symbol or ticker used on the trading platform (e.g., CL for NYMEX WTI Crude, BZ for ICE Brent Crude, NG for NYMEX Henry Hub Natural Gas).',
    `crack_spread_type` STRING COMMENT 'For refining margin benchmarks, the crack spread configuration (e.g., 3-2-1 crack spread representing 3 barrels crude to 2 barrels gasoline and 1 barrel distillate, 5-3-2 crack spread). Null for non-refining benchmarks.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this benchmark record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the benchmark is quoted (e.g., USD, EUR, GBP, JPY). Essential for multi-currency price formula calculations and foreign exchange risk management.. Valid values are `^[A-Z]{3}$`',
    `data_source_system` STRING COMMENT 'The upstream system or data feed from which benchmark prices are received (e.g., Bloomberg Terminal, Reuters Eikon, Platts Direct Feed, CME DataMine). Used for data lineage and reconciliation.',
    `delivery_basis` STRING COMMENT 'The Incoterms delivery basis for the benchmark price (e.g., FOB for Free on Board, CIF for Cost Insurance and Freight, DAP for Delivered at Place). Determines which party bears transportation and insurance costs.. Valid values are `fob|cif|dap|exw|fas|cfr`',
    `delivery_location` STRING COMMENT 'The physical or notional delivery point or hub associated with the benchmark (e.g., Cushing Oklahoma for WTI, Sullom Voe for Brent, Henry Hub Louisiana for natural gas). Defines the geographic basis for the price.',
    `effective_end_date` DATE COMMENT 'The date on which this benchmark definition ceased to be effective. Null for currently active benchmarks. Used for temporal validity and contract transition management when benchmarks are discontinued or redefined.',
    `effective_start_date` DATE COMMENT 'The date from which this benchmark definition became effective and available for use in price formulas and contracts. Used for temporal validity and historical price formula reconstruction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this benchmark record was most recently updated. Used for change tracking and audit purposes.',
    `minimum_price_increment` DECIMAL(18,2) COMMENT 'The smallest price movement or tick size for the benchmark (e.g., $0.01 per barrel for crude oil futures, $0.001 per MMBtu for natural gas). Used for price precision and rounding rules in contracts.',
    `price_adjustment_formula` STRING COMMENT 'The mathematical formula or methodology used to adjust the benchmark for quality, location, or timing differences (e.g., API gravity adjustment formula, sulfur premium/discount schedule). Used in commercial price formula construction.',
    `pricing_agency` STRING COMMENT 'The price reporting agency or exchange that publishes and maintains this benchmark (e.g., Platts, Argus Media, ICIS, CME Group, ICE, NYMEX). Critical for price formula construction and contract settlement.',
    `publication_time` TIMESTAMP COMMENT 'The standard time at which the benchmark price is officially published each day or period (e.g., 17:00 London time for Platts assessments, 14:30 US Central for NYMEX settlement). Used for price formula effective time determination.',
    `quality_specification` STRING COMMENT 'The product quality parameters that define the benchmark grade (e.g., API gravity 39.6 degrees and sulfur content 0.24% for WTI, API gravity 38 degrees and sulfur content 0.37% for Brent). Used for quality adjustment calculations.',
    `quotation_frequency` STRING COMMENT 'The frequency at which the pricing benchmark is published or updated. Real-time for exchange-traded instruments, daily for most spot assessments, monthly for term contract indices.. Valid values are `real_time|daily|weekly|monthly|quarterly|annual`',
    `regulatory_classification` STRING COMMENT 'The regulatory classification of the benchmark under financial market regulations (e.g., critical benchmark under EU BMR, IOSCO PRA principles compliant, CFTC regulated). Important for compliance and audit purposes.',
    `settlement_method` STRING COMMENT 'The method by which contracts referencing this benchmark are settled. Cash or financially settled means no physical delivery occurs, physical or physically delivered means actual commodity transfer is required.. Valid values are `cash|physical|financially_settled|physically_delivered`',
    `time_zone` STRING COMMENT 'The time zone in which the benchmark assessment or trading occurs (e.g., US/Central, Europe/London, Asia/Singapore). Essential for coordinating global trading and settlement activities.',
    `trading_exchange` STRING COMMENT 'For exchange-traded benchmarks, the name of the futures exchange where the contract trades (e.g., NYMEX, ICE Futures Europe, CME Group, TOCOM). Null for OTC or assessed benchmarks.',
    `unit_of_measure` STRING COMMENT 'The standard unit in which the benchmark price is expressed (e.g., $/bbl for crude oil, $/MMBtu for natural gas, $/MT for petrochemicals, $/gallon for refined products). Critical for price conversion and normalization.',
    `usage_count` STRING COMMENT 'The number of active commercial contracts, pricing agreements, or revenue formulas that currently reference this benchmark. Used for impact analysis when benchmarks change or are discontinued.',
    CONSTRAINT pk_pricing_benchmark PRIMARY KEY(`pricing_benchmark_id`)
) COMMENT 'Manages pricing benchmarks and price indices for petroleum products — WTI, Brent, Dubai/Oman, Henry Hub, JKM (Japan Korea Marker), TTF, NBP, Platts ULSD, MOPS (Mean of Platts Singapore), and crack spreads. Captures benchmark name, commodity type, pricing agency (Platts, Argus, ICIS), quotation frequency, currency, unit of measure ($/bbl, $/MMBtu, $/MT), and effective date range. Used by commercial, revenue, and trading domains for price formula construction.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`quality_test_result` (
    `quality_test_result_id` BIGINT COMMENT 'Unique identifier for the quality test result record. Primary key for the quality test result entity.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Quality tests are performed at specific facilities (terminals, tank farms, refineries). Facility-level quality reporting, custody transfer reconciliation, and regulatory compliance audits require link',
    `certificate_of_quality_id` BIGINT COMMENT 'Foreign key linking to product.certificate_of_quality. Business justification: quality_test_result has a denormalized STRING column `coq_reference_number` that references the Certificate of Quality associated with the test result. Individual quality test results are the underlyi',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Quality test results support legal entity quality assurance programs, regulatory compliance reporting, trade documentation, and custody transfer validation. Essential for multi-entity quality manageme',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality testing costs (lab fees, equipment, labor) are allocated to cost centers for operational expense tracking, variance analysis, and LOE reporting in oil-and-gas operations.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Test costs must post to specific GL accounts for financial reporting, cost element classification, and compliance with oil-and-gas accounting standards (successful efforts or full cost).',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Quality testing costs for products under JOA governance must be allocated to partners. Business process: JOA quality assurance cost allocation, partner dispute resolution over product quality, custody',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: External laboratories conducting quality tests are procurement vendors (analytical services). Enables vendor performance tracking, accreditation verification, and service contract management for quali',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Quality testing at lease custody transfer points determines product acceptance and pricing adjustments. Required for revenue allocation and contract compliance. Business process: monthly production ac',
    `original_test_quality_test_result_id` BIGINT COMMENT 'Reference to the original quality test result ID if this is a retest, enabling traceability of quality investigations.',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the petroleum product being tested (crude oil grade, refined product, LNG, LPG, NGL, petrochemical).',
    `quality_spec_id` BIGINT COMMENT 'Reference to the quality specification standard against which this test result is evaluated.',
    `equipment_id` BIGINT COMMENT 'Unique identifier of the laboratory instrument or equipment used to perform the test (for calibration tracking and traceability).',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result was reviewed and approved by authorized laboratory personnel.',
    `approved_by` STRING COMMENT 'Identifier of the laboratory supervisor or quality manager who reviewed and approved the test result.',
    `batch_number` STRING COMMENT 'Production batch or lot number of the petroleum product being tested, enabling traceability to production run.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality test result record was first created in the system.',
    `custody_transfer_flag` BOOLEAN COMMENT 'Indicates whether this test result is associated with a custody transfer event requiring Certificate of Quality for commercial settlement.',
    `deviation_from_spec` DECIMAL(18,2) COMMENT 'Calculated difference between the measured value and the specification limit (positive indicates above max or below min specification).',
    `equipment_calibration_date` DATE COMMENT 'Date when the test equipment was last calibrated, ensuring measurement accuracy and traceability.',
    `laboratory_accreditation` STRING COMMENT 'Accreditation certificate number or code demonstrating the laboratory meets ISO/IEC 17025 or equivalent quality standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality test result record was last updated in the system.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric value measured by the laboratory test for the specified parameter.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Statistical uncertainty or margin of error associated with the measured value, expressed in the same units as the measurement.',
    `parameter_tested` STRING COMMENT 'Name of the quality parameter being measured (e.g., API Gravity, Sulfur Content, RON, Flash Point, Pour Point, Viscosity, Reid Vapor Pressure, Distillation Temperature, TAN).',
    `pass_fail_status` STRING COMMENT 'Indicates whether the measured value meets the specification requirements (pass), fails to meet requirements (fail), meets requirements with conditions (conditional), or requires retesting (retest).. Valid values are `pass|fail|conditional|retest`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this test result is required for regulatory compliance reporting (EPA, BSEE, state environmental agencies).',
    `remarks` STRING COMMENT 'Free-text comments or observations recorded by the laboratory technician regarding sample condition, test anomalies, or special handling.',
    `retest_indicator` BOOLEAN COMMENT 'Flag indicating whether this test is a retest of a previous sample due to out-of-spec results or quality dispute.',
    `sample_collection_date` DATE COMMENT 'Date when the product sample was collected from the custody transfer point, tank, or pipeline.',
    `sample_type` STRING COMMENT 'Type of sample collected: composite (blended from multiple points), spot (single point in time), running (continuous during transfer), or automatic (system-collected).. Valid values are `composite|spot|running|automatic`',
    `specification_max` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the tested parameter as defined in the product quality specification.',
    `specification_min` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the tested parameter as defined in the product quality specification.',
    `test_date` DATE COMMENT 'Date when the laboratory quality test was performed on the sample.',
    `test_method_code` STRING COMMENT 'Standardized code identifying the laboratory test method used (e.g., ASTM D86 for distillation, ASTM D4052 for density, ASTM D5453 for sulfur content, ASTM D1298 for API gravity, ASTM D2699 for RON).. Valid values are `^ASTM [A-Z][0-9]{4}$|^API MPMS [0-9.]+$|^ISO [0-9]{4,5}$|^IP [0-9]{3}$`',
    `test_method_name` STRING COMMENT 'Full descriptive name of the test method used (e.g., Standard Test Method for Distillation of Petroleum Products at Atmospheric Pressure).',
    `test_pressure` DECIMAL(18,2) COMMENT 'Pressure at which the test was conducted, relevant for vapor pressure and other pressure-dependent measurements.',
    `test_priority` STRING COMMENT 'Priority classification of the test: routine (standard schedule), urgent (expedited), regulatory (compliance-driven), or dispute (quality claim investigation).. Valid values are `routine|urgent|regulatory|dispute`',
    `test_status` STRING COMMENT 'Current status of the test in the laboratory workflow.. Valid values are `scheduled|in_progress|completed|cancelled|on_hold`',
    `test_temperature` DECIMAL(18,2) COMMENT 'Temperature at which the test was conducted, critical for temperature-dependent properties like viscosity and density.',
    `test_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the laboratory quality test was completed, including time zone information.',
    `unit_of_measure` STRING COMMENT 'Unit in which the measured value is expressed (e.g., degrees API for gravity, ppm or wt% for sulfur, cSt for viscosity, degrees C/F for temperature, kPa/psi for pressure, mg KOH/g for TAN). [ENUM-REF-CANDIDATE: degrees API|ppm|wt%|cSt|mmHg|degC|degF|kPa|psi|mg KOH/g — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_quality_test_result PRIMARY KEY(`quality_test_result_id`)
) COMMENT 'Transactional record of laboratory quality test results performed on petroleum product samples at custody transfer points, tank farms, loading terminals, and refinery gates. Captures sample ID, test date, test method (ASTM D86, D4052, D5453, D1298), parameter tested, measured value, unit, pass/fail against spec, laboratory ID, and certificate of quality (CoQ) reference. Links to petroleum_product, product_quality_spec, and the relevant shipment or batch.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` (
    `certificate_of_quality_id` BIGINT COMMENT 'Unique system identifier for the Certificate of Quality record. Primary key for the certificate_of_quality product.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Certificates of Quality are issued at loading/discharge terminals. Linking CoQ to the issuing facility enables terminal-level CoQ audit trails, export documentation compliance, and custody transfer ve',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Certificates of Quality are issued by legal entities for customs clearance, trade settlement, letter of credit compliance, and regulatory documentation. Essential for international petroleum product t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: COQ issuance costs (inspection, lab analysis, certification) are allocated to terminal or trading cost centers for custody transfer expense tracking in oil-and-gas operations.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: A Certificate of Quality issued at custody transfer for crude oil directly references the specific crude grade being transferred (e.g., WTI Cushing, Brent Blend, Arab Light). certificate_of_quality al',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Third-party laboratories issuing CoQs are vendors in procurement system. Critical for custody transfer, quality assurance, and regulatory compliance in commodity trading and supply chain operations.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Certificates of quality for cargoes lifted under JOA partner entitlements require JOA linkage. Business process: Partner lifting certification, JOA entitlement verification, cargo allocation documenta',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Certificates of Quality issued at lease delivery points for custody transfer and export. Links product quality certification to lease production for cargo documentation. Business process: cargo loadin',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the petroleum product being certified (crude oil grade, refined product, LNG, LPG, NGL, petrochemical).',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: certificate_of_quality has a denormalized STRING column `specification_reference` that identifies the quality specification against which the CoQ was issued. quality_spec is the authoritative entity. ',
    `refined_product_id` BIGINT COMMENT 'Foreign key linking to product.refined_product. Business justification: A Certificate of Quality issued for refined petroleum products (gasoline, diesel, jet fuel) directly references the specific refined product specification. Adding refined_product_id provides direct ac',
    `analysis_date` DATE COMMENT 'Date on which the laboratory analysis and testing of the product sample was performed. May differ from issue date.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the crude oil or petroleum product, measured in degrees API. Key quality parameter for crude oil classification (light, medium, heavy).',
    `batch_number` STRING COMMENT 'Production batch or lot number of the petroleum product being certified. Used for traceability across the supply chain.',
    `certificate_number` STRING COMMENT 'Externally-known unique certificate number issued by the laboratory or inspection authority. Used for legal reference and trade settlement.. Valid values are `^COQ-[A-Z0-9]{8,12}$`',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the Certificate of Quality. Tracks whether the certificate is in draft, officially issued, amended, superseded by a newer version, voided, or under dispute.. Valid values are `draft|issued|amended|superseded|voided|disputed`',
    `cetane_index` DECIMAL(18,2) COMMENT 'Cetane index for diesel fuel. Indicates the ignition quality of diesel fuel. Higher values indicate better ignition characteristics.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this Certificate of Quality record was first created in the data platform. Used for audit trail and data lineage.',
    `digital_signature` STRING COMMENT 'Cryptographic digital signature or hash of the certificate for authenticity verification. Prevents tampering and ensures document integrity.',
    `distillation_fbp_c` DECIMAL(18,2) COMMENT 'Final Boiling Point from distillation analysis in degrees Celsius. Maximum temperature reached during distillation testing.',
    `distillation_ibp_c` DECIMAL(18,2) COMMENT 'Initial Boiling Point from distillation analysis in degrees Celsius. First temperature at which vapor is produced during distillation testing.',
    `distillation_t50_c` DECIMAL(18,2) COMMENT 'Temperature at which 50% of the product has been distilled. Key indicator of the products volatility profile.',
    `distillation_t90_c` DECIMAL(18,2) COMMENT 'Temperature at which 90% of the product has been distilled. Important for fuel performance and emissions characteristics.',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Flash point of the product in degrees Celsius. Critical safety parameter for handling, storage, and transportation classification.',
    `inspector_certification` STRING COMMENT 'Professional certification or license number of the inspector (e.g., API Inspector certification, state chemist license). Validates inspector qualifications.',
    `issue_date` DATE COMMENT 'Date on which the Certificate of Quality was officially issued by the laboratory or inspection authority. Legally binding date for trade settlement.',
    `laboratory_accreditation` STRING COMMENT 'Accreditation standard and certificate number of the issuing laboratory (e.g., ISO/IEC 17025:2017, UKAS accreditation number). Validates laboratory competence.',
    `meets_specification_flag` BOOLEAN COMMENT 'Boolean indicator of whether all tested parameters meet the specified quality limits. True if product is on-spec, False if off-spec.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this Certificate of Quality record was last modified. Tracks amendments, corrections, or status changes.',
    `mon_rating` DECIMAL(18,2) COMMENT 'Motor Octane Number for gasoline products. Measures fuel performance under high-load conditions. Used with RON to calculate (R+M)/2 octane rating.',
    `pour_point_c` DECIMAL(18,2) COMMENT 'Pour point of the product in degrees Celsius. Indicates the lowest temperature at which the product will flow. Important for cold weather operations.',
    `product_grade` STRING COMMENT 'Specific grade or quality designation of the product (e.g., WTI, Brent, Premium Unleaded 95 RON, Jet A-1, ULSD). Industry-standard product classification.',
    `quantity_loaded` DECIMAL(18,2) COMMENT 'Total quantity of product loaded for this cargo, measured in the unit specified by quantity_uom. Used for custody transfer and billing.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the loaded quantity. Common units: BBL (barrels), MT (metric tons), M3 (cubic meters), GAL (gallons), LTR (liters).. Valid values are `BBL|MT|M3|GAL|LTR`',
    `reid_vapor_pressure_psi` DECIMAL(18,2) COMMENT 'Reid Vapor Pressure measured in PSI. Indicates the volatility of gasoline and light petroleum products. Critical for environmental and safety compliance.',
    `remarks` STRING COMMENT 'Free-text remarks, notes, or observations from the inspector or laboratory. May include special conditions, deviations, or clarifications.',
    `ron_rating` DECIMAL(18,2) COMMENT 'Research Octane Number for gasoline products. Measures the fuels resistance to knocking during combustion. Key specification for motor gasoline.',
    `salt_content_ptb` DECIMAL(18,2) COMMENT 'Salt content measured in pounds per thousand barrels. Important for refinery processing and corrosion prevention.',
    `sampling_date` DATE COMMENT 'Date on which the product sample was collected from the cargo, tank, or pipeline for laboratory testing.',
    `sampling_point` STRING COMMENT 'Physical location or equipment identifier where the product sample was collected (e.g., loading arm, tank outlet, pipeline meter station).',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Specific gravity (relative density) of the product at standard conditions. Used for volume-to-mass conversions and quality assessment.',
    `sulfur_content_pct` DECIMAL(18,2) COMMENT 'Sulfur content of the product expressed as weight percentage. Critical for environmental compliance and product classification (sweet vs. sour crude).',
    `tan_value` DECIMAL(18,2) COMMENT 'Total Acid Number measured in mg KOH/g. Indicates the acidity of crude oil. High TAN crudes are corrosive and require special refinery processing.',
    `vessel_imo_number` STRING COMMENT 'Unique seven-digit IMO number assigned to the vessel for international identification. Used for regulatory compliance and tracking.. Valid values are `^IMO[0-9]{7}$`',
    `vessel_name` STRING COMMENT 'Name of the vessel, tanker, or pipeline through which the product was transported. Applicable for marine and pipeline shipments.',
    `viscosity_cst` DECIMAL(18,2) COMMENT 'Kinematic viscosity of the product measured in centistokes at a specified temperature. Critical for fuel oil and heavy crude specifications.',
    `viscosity_temperature_c` DECIMAL(18,2) COMMENT 'Temperature in degrees Celsius at which the viscosity was measured. Typically 40°C or 50°C for petroleum products.',
    `water_content_pct` DECIMAL(18,2) COMMENT 'Water and sediment content expressed as volume percentage. Used for custody transfer adjustments and quality assessment.',
    CONSTRAINT pk_certificate_of_quality PRIMARY KEY(`certificate_of_quality_id`)
) COMMENT 'Official Certificate of Quality (CoQ) document issued at custody transfer for crude oil and product cargoes. Captures cargo/batch reference, product grade, loading port, vessel/pipeline, date of analysis, all tested parameters with results vs. specification limits, issuing laboratory, inspector name, and digital certificate number. Legally binding document used in trade settlement, dispute resolution, and regulatory compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` (
    `safety_data_sheet_id` BIGINT COMMENT 'Primary key for safety_data_sheet',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Safety Data Sheets are maintained by legal entities for regulatory compliance (OSHA, REACH, GHS), liability management, and jurisdictional requirements. Different entities may have different regulator',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: In joint ventures, the operator or specific partners are responsible for maintaining and distributing safety data sheets. Tracking which partner issued/maintains the SDS is required for HSE compliance',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Material masters require SDS document references for hazardous materials management and regulatory compliance. Procurement systems link SDS to material codes for OSHA/REACH compliance, storage classif',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the petroleum product or chemical for which this safety data sheet is issued. Links to the product master catalog.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: SDS requirements vary by regulatory authority jurisdiction: OSHA (US), WHMIS (Canada), CLP/REACH (EU), GHS implementations globally. Links SDS documents to governing authority for jurisdiction-specifi',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: SDS documents are often provided by product vendors/suppliers. Tracking vendor enables regulatory compliance, SDS update management, and supplier accountability for hazard communication in procurement',
    `accidental_release_containment_methods` STRING COMMENT 'Recommended methods and materials for containing and cleaning up spills or releases, including absorbent materials, recovery procedures, and disposal considerations.',
    `appearance` STRING COMMENT 'Visual description of the products appearance including color, clarity, and physical form (e.g., clear amber liquid, white crystalline powder).',
    `autoignition_temperature_c` DECIMAL(18,2) COMMENT 'Minimum temperature at which the product will spontaneously ignite without an external ignition source, measured in degrees Celsius.',
    `conditions_to_avoid` STRING COMMENT 'Environmental conditions that may cause hazardous reactions or decomposition, such as heat, sparks, static electricity, shock, or incompatible materials.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this safety data sheet record was first created in the data management system.',
    `disposal_considerations` STRING COMMENT 'Recommended disposal methods and regulatory requirements for the product and contaminated containers, including waste treatment options and applicable waste codes.',
    `document_status` STRING COMMENT 'Current lifecycle status of the safety data sheet document indicating whether it is in draft, active use, superseded by a newer version, archived, or withdrawn.. Valid values are `draft|active|superseded|archived|withdrawn`',
    `ecological_information` STRING COMMENT 'Environmental impact data including aquatic toxicity, persistence and degradability, bioaccumulative potential, mobility in soil, and effects on wildlife.',
    `effective_date` DATE COMMENT 'Date from which this safety data sheet becomes the official document for the product, replacing any prior versions.',
    `emergency_phone_number` STRING COMMENT '24-hour emergency contact telephone number for incidents involving the product, typically a poison control center or manufacturer emergency line.',
    `expiration_date` DATE COMMENT 'Date when this safety data sheet expires and must be reviewed or replaced, typically required every 3-5 years depending on jurisdiction.',
    `exposure_limits` STRING COMMENT 'Workplace air concentration exposure limits including OSHA Permissible Exposure Limit (PEL) and ACGIH Threshold Limit Value (TLV), expressed as time-weighted average (TWA), short-term exposure limit (STEL), or ceiling limit.',
    `firefighting_extinguishing_media` STRING COMMENT 'Appropriate fire extinguishing agents for fires involving the product (e.g., foam, CO2, dry chemical, water spray). Critical for emergency response planning.',
    `firefighting_special_hazards` STRING COMMENT 'Special fire and explosion hazards associated with the product, including toxic combustion products, explosive vapor formation, and reactivity with water.',
    `first_aid_eye_contact` STRING COMMENT 'Recommended first aid procedures for eye contact with the product, including flushing duration, removal of contact lenses, and when to seek medical attention.',
    `first_aid_ingestion` STRING COMMENT 'Recommended first aid procedures if the product is swallowed, including whether to induce vomiting, aspiration hazards, and medical treatment guidance.',
    `first_aid_inhalation` STRING COMMENT 'Recommended first aid procedures if the product is inhaled, including moving to fresh air, oxygen administration, and when to seek medical attention.',
    `first_aid_skin_contact` STRING COMMENT 'Recommended first aid procedures for skin contact with the product, including washing procedures, removal of contaminated clothing, and medical treatment guidance.',
    `flammability_limits_lower_pct` DECIMAL(18,2) COMMENT 'Lower explosive limit (LEL) or lower flammability limit, expressed as volume percent in air, below which the vapor-air mixture is too lean to ignite.',
    `flammability_limits_upper_pct` DECIMAL(18,2) COMMENT 'Upper explosive limit (UEL) or upper flammability limit, expressed as volume percent in air, above which the vapor-air mixture is too rich to ignite.',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Lowest temperature at which vapors of the product will ignite when exposed to an ignition source, measured in degrees Celsius. Critical for fire hazard assessment.',
    `ghs_classification` STRING COMMENT 'Globally Harmonized System hazard classification for the product, including hazard classes and categories (e.g., Flammable Liquids Category 2, Acute Toxicity Category 4).',
    `handling_precautions` STRING COMMENT 'Safe handling practices and precautions to minimize exposure and prevent accidents, including grounding requirements, ventilation needs, and incompatible materials to avoid.',
    `hazard_class` STRING COMMENT 'UN transport hazard class or division number indicating the primary hazard for transportation (e.g., Class 3 Flammable Liquids, Class 2.1 Flammable Gases).',
    `hazard_pictograms` STRING COMMENT 'List of GHS hazard pictogram codes applicable to the product (e.g., GHS02 Flame, GHS07 Exclamation Mark, GHS08 Health Hazard), separated by semicolons.',
    `hazard_statements` STRING COMMENT 'Standardized GHS hazard statements describing the nature and degree of the hazards (e.g., H225 Highly flammable liquid and vapor, H304 May be fatal if swallowed and enters airways).',
    `hazardous_decomposition_products` STRING COMMENT 'Hazardous substances that may be formed when the product decomposes or burns, such as carbon monoxide, hydrogen sulfide, sulfur oxides, or nitrogen oxides.',
    `incompatible_materials` STRING COMMENT 'Materials and chemical classes that should not come into contact with the product due to risk of hazardous reactions, including strong oxidizers, acids, bases, or reactive metals.',
    `issue_date` DATE COMMENT 'Date when this version of the safety data sheet was officially issued or published by the responsible party.',
    `issuing_authority` STRING COMMENT 'Name of the organization or entity responsible for issuing and maintaining the safety data sheet, typically the manufacturer, importer, or distributor.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language in which the safety data sheet is written (e.g., ENG for English, SPA for Spanish).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this safety data sheet record was last updated or modified in the data management system.',
    `odor` STRING COMMENT 'Characteristic odor or smell of the product (e.g., petroleum-like, sweet, pungent, odorless), important for leak detection and worker awareness.',
    `packing_group` STRING COMMENT 'UN packing group indicating the degree of danger for transport: I (high danger), II (medium danger), III (low danger). Not applicable for all hazard classes.. Valid values are `I|II|III`',
    `physical_state` STRING COMMENT 'Physical state or form of the product at normal temperature and pressure (solid, liquid, gas, vapor, or aerosol).. Valid values are `solid|liquid|gas|vapor|aerosol`',
    `ppe_requirements` STRING COMMENT 'Comprehensive personal protective equipment requirements including respiratory protection, hand protection (glove material and breakthrough time), eye and face protection, and skin and body protection specifications for safe handling of the product.',
    `precautionary_statements` STRING COMMENT 'Standardized GHS precautionary statements describing recommended measures to minimize or prevent adverse effects (e.g., P210 Keep away from heat/sparks/open flames, P280 Wear protective gloves/eye protection).',
    `proper_shipping_name` STRING COMMENT 'Official UN proper shipping name for the product as it must appear on shipping documents and package markings for transport of dangerous goods.',
    `regulatory_information` STRING COMMENT 'Summary of applicable regulatory requirements including TSCA status, SARA Title III reporting, California Proposition 65, REACH registration, and other jurisdiction-specific regulations.',
    `revision_date` DATE COMMENT 'Date when the safety data sheet was last revised or updated, indicating the most recent modification to the document content.',
    `sds_number` STRING COMMENT 'Unique business identifier for the safety data sheet document, typically assigned by the issuing authority or manufacturer.',
    `sds_version` STRING COMMENT 'Version number or revision identifier of the safety data sheet, used to track updates and changes over time.',
    `signal_word` STRING COMMENT 'GHS signal word indicating the relative level of severity of hazard: Danger for more severe hazards, Warning for less severe hazards.. Valid values are `Danger|Warning`',
    `solubility_in_water` STRING COMMENT 'Description of the products solubility or miscibility in water (e.g., negligible, slightly soluble, miscible, insoluble), important for spill response and environmental impact.',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Ratio of the density of the product to the density of water at a specified temperature. Values less than 1.0 indicate the product floats on water; greater than 1.0 indicates it sinks.',
    `stability` STRING COMMENT 'Indication of whether the product is chemically stable under normal storage and handling conditions, or if it may undergo hazardous reactions.. Valid values are `stable|unstable`',
    `storage_requirements` STRING COMMENT 'Safe storage conditions and requirements including temperature limits, ventilation needs, container specifications, segregation from incompatible materials, and special storage considerations.',
    `toxicological_information` STRING COMMENT 'Summary of toxicological data including acute toxicity (LD50/LC50), routes of exposure, target organs, chronic health effects, carcinogenicity, and reproductive toxicity.',
    `un_number` STRING COMMENT 'Four-digit United Nations identification number for dangerous goods used in international transport (e.g., UN1203 for gasoline, UN1075 for LPG).. Valid values are `^UN[0-9]{4}$`',
    `vapor_pressure_kpa` DECIMAL(18,2) COMMENT 'Pressure exerted by the vapor of the product at a specified temperature, measured in kilopascals. Indicates volatility and evaporation rate.',
    CONSTRAINT pk_safety_data_sheet PRIMARY KEY(`safety_data_sheet_id`)
) COMMENT 'Manages Safety Data Sheets (SDS/MSDS) for petroleum products and chemicals — covering GHS hazard classification, physical/chemical properties, first aid measures, fire-fighting measures, accidental release measures, handling and storage, exposure controls/PPE, transport information (UN number, packing group), and regulatory information. Captures SDS version, effective date, issuing authority, and language. Required for HSE compliance and REACH/OSHA HazCom.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`price_history` (
    `price_history_id` BIGINT COMMENT 'Primary key for price_history',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Price history supports legal entity financial reporting, tax valuation, SEC pricing compliance (first-in-first-out pricing), and intercompany transfer pricing documentation. Critical for financial sta',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Price history data is used for cost allocation, transfer pricing between cost centers, variance analysis, and operational budgeting. Essential for internal pricing and cost management.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Price negotiations in joint ventures involve specific partners as buyers/sellers. Tracking which partner was the counterparty is essential for contract management, revenue recognition, transfer pricin',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: price_history records historical realized and posted prices for petroleum products. For crude oil price records, the specific crude grade (WTI, Brent, Arab Light) is a critical dimension that determin',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the petroleum product for which the price is recorded. Links to the product master catalog.',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_benchmark. Business justification: Links historical price records to the pricing benchmark used for that transaction. price_history currently has pricing_index as a STRING field containing benchmark names. Adding FK to product_pricing_',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Product pricing is tracked by profit center for revenue recognition, realized margin calculation, and performance attribution in oil-and-gas trading and marketing operations.',
    `api_gravity` DECIMAL(18,2) COMMENT 'The API gravity of the crude oil or petroleum product at the time of pricing, used for quality-based price adjustments.',
    `benchmark_price` DECIMAL(18,2) COMMENT 'The base reference price from the applicable pricing index before any adjustments or differentials are applied. Expressed in the pricing currency per unit of measure.',
    `contract_reference` STRING COMMENT 'Reference to the sales contract, purchase agreement, or term contract under which this price was established or applied.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this price history record was first created in the system, supporting audit trail and data lineage requirements.',
    `final_price` DECIMAL(18,2) COMMENT 'The actual price per unit after applying all differentials and adjustments to the benchmark price. This is the realized or posted price used for revenue calculation and contract settlement.',
    `fiscal_period` STRING COMMENT 'The fiscal accounting period (month and year) to which this price record is assigned for financial reporting purposes.',
    `last_modified_by` STRING COMMENT 'The user identifier or system account that most recently modified this price history record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this price history record was most recently updated, supporting audit trail and change tracking requirements.',
    `market_region` STRING COMMENT 'The geographic market or trading region where this price is applicable, such as Gulf Coast, Permian Basin, North Sea, or Asia Pacific.',
    `price_adjustment_reason` STRING COMMENT 'Explanation for any price revision or adjustment, documenting the business rationale for changes to previously posted prices.',
    `price_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the price is denominated. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|AUD|JPY|CNY — 7 candidates stripped; promote to reference product]',
    `price_date` DATE COMMENT 'The specific date on which the price was set, posted, or realized. Primary business event timestamp for the price record.',
    `price_differential` DECIMAL(18,2) COMMENT 'The adjustment amount (positive or negative) applied to the benchmark price to arrive at the final price. Reflects quality, location, and market factors.',
    `price_effective_timestamp` TIMESTAMP COMMENT 'The precise date and time when this price became effective for transactions and settlements.',
    `price_expiration_timestamp` TIMESTAMP COMMENT 'The precise date and time when this price ceased to be effective, marking the end of its applicability period.',
    `price_notes` STRING COMMENT 'Additional comments, explanations, or contextual information about the price record, including special conditions or market factors.',
    `price_record_number` STRING COMMENT 'Business identifier for the price record, used for external reference and audit trail purposes.',
    `price_source` STRING COMMENT 'The authoritative source or system from which the price was obtained, such as trading platform, pricing service, contract agreement, or internal calculation.',
    `price_source_system` STRING COMMENT 'The name of the source system or application from which the price data was extracted or received, such as trading system, ERP, or pricing service feed.',
    `price_status` STRING COMMENT 'The current status of the price record in its lifecycle: preliminary (initial estimate), confirmed (validated), revised (updated after initial posting), final (locked for accounting), or cancelled (voided).. Valid values are `preliminary|confirmed|revised|final|cancelled`',
    `price_type` STRING COMMENT 'Classification of the price record indicating the nature of the pricing: posted price (published reference), spot market price (immediate delivery), realized price (actual received), netback value (after transportation and processing costs), transfer price (inter-company), benchmark price (index reference), or contract price (negotiated term). [ENUM-REF-CANDIDATE: posted|spot|realized|netback|transfer|benchmark|contract — 7 candidates stripped; promote to reference product]',
    `price_unit_of_measure` STRING COMMENT 'The unit of measure for which the price is quoted: Barrel (BBL), Metric Ton (MT), Thousand Cubic Feet (MCF), Million British Thermal Units (MMBTU), Gallon (GAL), Pound (LB), Kilogram (KG), or Cubic Meter (M3). [ENUM-REF-CANDIDATE: BBL|MT|MCF|MMBTU|GAL|LB|KG|M3 — 8 candidates stripped; promote to reference product]',
    `pricing_period_end_date` DATE COMMENT 'The ending date of the period for which this price is applicable. For spot prices, may equal start date.',
    `pricing_period_start_date` DATE COMMENT 'The beginning date of the period for which this price is applicable. Used for daily, monthly, or custom period pricing.',
    `pricing_point` STRING COMMENT 'The physical or commercial location where the price applies, such as wellhead, custody transfer point, refinery gate, or delivery terminal.',
    `processing_cost` DECIMAL(18,2) COMMENT 'The per-unit processing or treatment cost deducted from the benchmark price to calculate netback value, expressed in the same currency and unit of measure as the price.',
    `product_grade` STRING COMMENT 'The specific grade or quality specification of the product for which the price applies, such as sweet crude, sour crude, premium gasoline, or pipeline quality natural gas.',
    `sec_pricing_flag` BOOLEAN COMMENT 'Indicates whether this price record is used for SEC reserves valuation and disclosure purposes, specifically for calculating the 12-month average price required by SEC regulations.',
    `settlement_reference` STRING COMMENT 'Reference to the revenue settlement, invoice, or joint interest billing statement that used this price for calculation purposes.',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'The sulfur content percentage of the product at the time of pricing, used for quality-based price differentials between sweet and sour grades.',
    `transportation_cost` DECIMAL(18,2) COMMENT 'The per-unit transportation cost deducted from the benchmark price to calculate netback value, expressed in the same currency and unit of measure as the price.',
    `volume_basis` STRING COMMENT 'Description of the volume measurement basis for the price, such as gross volume, net volume, standard conditions, or specific temperature and pressure references.',
    `created_by` STRING COMMENT 'The user identifier or system account that created this price history record in the system.',
    CONSTRAINT pk_price_history PRIMARY KEY(`price_history_id`)
) COMMENT 'Transactional record of historical realized and posted prices for petroleum products — capturing daily/monthly posted prices, spot market prices, netback values, and transfer prices by product grade, market, and pricing period. Includes benchmark price, differential applied, final realized price, currency, volume basis, and price source. Used for revenue analysis, contract settlement verification, and SEC reserves valuation (SEC 12-month average price).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ADD CONSTRAINT `fk_product_assay_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ADD CONSTRAINT `fk_product_refined_product_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_certificate_of_quality_id` FOREIGN KEY (`certificate_of_quality_id`) REFERENCES `oil_gas_ecm`.`product`.`certificate_of_quality`(`certificate_of_quality_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_original_test_quality_test_result_id` FOREIGN KEY (`original_test_quality_test_result_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_test_result`(`quality_test_result_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_refined_product_id` FOREIGN KEY (`refined_product_id`) REFERENCES `oil_gas_ecm`.`product`.`refined_product`(`refined_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ADD CONSTRAINT `fk_product_safety_data_sheet_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ADD CONSTRAINT `fk_product_price_history_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ADD CONSTRAINT `fk_product_price_history_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ADD CONSTRAINT `fk_product_price_history_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `oil_gas_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `blending_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Blending Component Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `boe_conversion_factor` SET TAGS ('dbx_business_glossary_term' = 'Barrel of Oil Equivalent (BOE) Conversion Factor');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `carbon_intensity_g_mj` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity Grams per Megajoule (g/MJ)');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `cetane_number` SET TAGS ('dbx_business_glossary_term' = 'Cetane Number');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `density_kg_m3` SET TAGS ('dbx_business_glossary_term' = 'Density Kilograms per Cubic Meter (kg/m³)');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `epa_fuel_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Fuel Category');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `heating_value_mj_kg` SET TAGS ('dbx_business_glossary_term' = 'Heating Value Megajoules per Kilogram (MJ/kg)');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|discontinued|restricted|phased_out');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `origin_region` SET TAGS ('dbx_business_glossary_term' = 'Origin Region');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `phase_state` SET TAGS ('dbx_business_glossary_term' = 'Phase State');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `phase_state` SET TAGS ('dbx_value_regex' = 'liquid|gas|solid|supercritical');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `pour_point_c` SET TAGS ('dbx_business_glossary_term' = 'Pour Point Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `product_subfamily` SET TAGS ('dbx_business_glossary_term' = 'Product Subfamily');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `regulatory_product_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Product Code');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `renewable_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Renewable Content Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `ron_rating` SET TAGS ('dbx_business_glossary_term' = 'Research Octane Number (RON) Rating');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Maximum Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Minimum Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `sulfur_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `tan_value` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) Value');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `tradeable_commodity_flag` SET TAGS ('dbx_business_glossary_term' = 'Tradeable Commodity Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `vapor_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Vapor Pressure Kilopascals (kPa)');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `viscosity_cst` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Centistokes (cSt)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `api_gravity_band` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity Band');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `api_gravity_band` SET TAGS ('dbx_value_regex' = 'light|medium|heavy|extra_heavy');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `assay_date` SET TAGS ('dbx_business_glossary_term' = 'Crude Assay Date');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `carbon_intensity_kg_co2_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity in Kilograms Carbon Dioxide (CO2) per Barrel (BBL)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `carbon_residue_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbon Residue Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `crude_grade_status` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Status');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `crude_grade_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|under_evaluation|restricted');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `delivery_point` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_value_regex' = 'conventional|heavy_sour|high_tan|high_metals|bitumen');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `grade_classification` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `grade_classification` SET TAGS ('dbx_value_regex' = 'benchmark|equity|spot|proprietary|blend');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `grade_code` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Code');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `grade_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `grade_name` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Name');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `h2s_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content in Parts Per Million (ppm)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `metals_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Metals Content in Parts Per Million (ppm)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `nitrogen_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Content in Parts Per Million (ppm)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `origin_basin` SET TAGS ('dbx_business_glossary_term' = 'Origin Basin');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `origin_field_name` SET TAGS ('dbx_business_glossary_term' = 'Origin Field Name');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `pour_point_c` SET TAGS ('dbx_business_glossary_term' = 'Pour Point in Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `pricing_differential_usd_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Pricing Differential in United States Dollars (USD) per Barrel (BBL)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `pricing_differential_usd_per_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `refinery_compatibility_rating` SET TAGS ('dbx_business_glossary_term' = 'Refinery Compatibility Rating');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `refinery_compatibility_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|restricted');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `salt_content_ptb` SET TAGS ('dbx_business_glossary_term' = 'Salt Content in Pounds per Thousand Barrels (PTB)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `sulfur_classification` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `sulfur_classification` SET TAGS ('dbx_value_regex' = 'sweet|sour');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `tan_value` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) Value');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Primary Transportation Mode');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'pipeline|tanker|rail|truck|barge');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `viscosity_cst` SET TAGS ('dbx_business_glossary_term' = 'Viscosity in Centistokes (cSt)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `viscosity_reference_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Reference Temperature in Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `wax_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Wax Content Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `yield_diesel_percent` SET TAGS ('dbx_business_glossary_term' = 'Diesel Yield Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `yield_gasoline_percent` SET TAGS ('dbx_business_glossary_term' = 'Gasoline Yield Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `yield_residual_percent` SET TAGS ('dbx_business_glossary_term' = 'Residual Fuel Yield Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` SET TAGS ('dbx_subdomain' = 'quality_management');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Specification ID');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `applicable_market` SET TAGS ('dbx_business_glossary_term' = 'Applicable Market');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `criticality_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `maximum_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Acceptable Value');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `minimum_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Acceptable Value');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Parameter Name');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `pass_fail_logic` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Logic');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `pass_fail_logic` SET TAGS ('dbx_value_regex' = 'within_range|below_max|above_min|equals_target');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `spec_code` SET TAGS ('dbx_business_glossary_term' = 'Specification Code');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `spec_name` SET TAGS ('dbx_business_glossary_term' = 'Specification Name');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|retired|under_review');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `spec_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `spec_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `specification_notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `test_method_description` SET TAGS ('dbx_business_glossary_term' = 'Test Method Description');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `test_method_standard` SET TAGS ('dbx_business_glossary_term' = 'Test Method Standard');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `tolerance_type` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Type');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `tolerance_type` SET TAGS ('dbx_value_regex' = 'absolute|percentage|statistical');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` SET TAGS ('dbx_subdomain' = 'quality_management');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `assay_id` SET TAGS ('dbx_business_glossary_term' = 'Product Assay Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Date');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `aromatics_content_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Total Aromatics Content (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `asphaltene_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Asphaltene Content (Weight Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `assay_status` SET TAGS ('dbx_business_glossary_term' = 'Assay Record Status');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `assay_status` SET TAGS ('dbx_value_regex' = 'draft|validated|approved|superseded|archived');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `carbon_residue_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Conradson Carbon Residue (CCR) Weight Percent');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `diesel_yield_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Diesel Fraction Yield (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `distillation_method` SET TAGS ('dbx_business_glossary_term' = 'Distillation Test Method');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `distillation_method` SET TAGS ('dbx_value_regex' = 'ASTM D86|TBP|ASTM D2892|ASTM D5236');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `flash_point_f` SET TAGS ('dbx_business_glossary_term' = 'Flash Point Temperature (Degrees Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `gross_heating_value_btu_per_lb` SET TAGS ('dbx_business_glossary_term' = 'Gross Heating Value (BTU per Pound)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `h2s_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `hydrogen_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Content (Weight Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `iron_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Iron (Fe) Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `kerosene_yield_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Kerosene Fraction Yield (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `mercaptan_sulfur_ppm` SET TAGS ('dbx_business_glossary_term' = 'Mercaptan Sulfur Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `naphtha_yield_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Naphtha Fraction Yield (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `nickel_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Nickel (Ni) Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `nitrogen_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Total Nitrogen Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `olefins_content_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Olefins Content (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `pour_point_f` SET TAGS ('dbx_business_glossary_term' = 'Pour Point Temperature (Degrees Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `reid_vapor_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Reid Vapor Pressure (RVP) in PSI');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `residue_yield_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Vacuum Residue Yield (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `salt_content_ptb` SET TAGS ('dbx_business_glossary_term' = 'Salt Content (Pounds per Thousand Barrels)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `saturates_content_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Saturates Content (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity at 60°F/60°F');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `sulfur_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Total Sulfur Content (Weight Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `tan_mg_koh_per_g` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) in mg KOH/g');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `uopk_characterization_factor` SET TAGS ('dbx_business_glossary_term' = 'Universal Oil Products (UOP) K Characterization Factor');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `vanadium_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Vanadium (V) Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Assay Version Number');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `vgo_yield_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Vacuum Gas Oil (VGO) Yield (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `viscosity_at_100f_cst` SET TAGS ('dbx_business_glossary_term' = 'Kinematic Viscosity at 100°F (Centistokes)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `viscosity_at_210f_cst` SET TAGS ('dbx_business_glossary_term' = 'Kinematic Viscosity at 210°F (Centistokes)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `water_content_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Water Content (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `wax_content_wt_pct` SET TAGS ('dbx_business_glossary_term' = 'Wax Content (Weight Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `refined_product_id` SET TAGS ('dbx_business_glossary_term' = 'Refined Product Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `aromatics_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Aromatics Content (Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `ash_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Ash Content (Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `benzene_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Benzene Content (Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `blending_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Blending Component Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `carbon_residue_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbon Residue (Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `cetane_number` SET TAGS ('dbx_business_glossary_term' = 'Cetane Number');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `cold_filter_plugging_point_celsius` SET TAGS ('dbx_business_glossary_term' = 'Cold Filter Plugging Point (Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `color_astm` SET TAGS ('dbx_business_glossary_term' = 'American Society for Testing and Materials (ASTM) Color');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `copper_strip_corrosion` SET TAGS ('dbx_business_glossary_term' = 'Copper Strip Corrosion Rating');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `density_kg_per_m3` SET TAGS ('dbx_business_glossary_term' = 'Density (Kilograms per Cubic Meter)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `distillation_range_celsius` SET TAGS ('dbx_business_glossary_term' = 'Distillation Range (Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `excise_duty_category` SET TAGS ('dbx_business_glossary_term' = 'Excise Duty Category');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `export_domestic_classification` SET TAGS ('dbx_business_glossary_term' = 'Export/Domestic Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `export_domestic_classification` SET TAGS ('dbx_value_regex' = 'DOMESTIC|EXPORT|BOTH');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `flash_point_celsius` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `freeze_point_celsius` SET TAGS ('dbx_business_glossary_term' = 'Freeze Point (Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Tariff Code');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `heating_value_mj_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Heating Value (Megajoules per Kilogram)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `lubricity_microns` SET TAGS ('dbx_business_glossary_term' = 'Lubricity (Microns)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `olefins_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Olefins Content (Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `oxygenate_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Oxygenate Content (Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `pour_point_celsius` SET TAGS ('dbx_business_glossary_term' = 'Pour Point (Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `product_status` SET TAGS ('dbx_business_glossary_term' = 'Product Status');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `product_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|DISCONTINUED|PENDING_APPROVAL|RESTRICTED');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `ron_rating` SET TAGS ('dbx_business_glossary_term' = 'Research Octane Number (RON) Rating');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `sediment_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sediment Content (Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `smoke_point_mm` SET TAGS ('dbx_business_glossary_term' = 'Smoke Point (Millimeters)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `sulfur_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `vapor_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Reid Vapor Pressure (Kilopascals)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `viscosity_cst` SET TAGS ('dbx_business_glossary_term' = 'Kinematic Viscosity (Centistokes)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `water_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Water Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `ngl_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Stream Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Processing Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Fractionation Train Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `autoignition_temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Autoignition Temperature in Degrees Fahrenheit');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Component Type');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `customs_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Customs Tariff Code');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `customs_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `ethane_mol_percent` SET TAGS ('dbx_business_glossary_term' = 'Ethane Mole Percent Composition');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `flash_point_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Flash Point in Degrees Fahrenheit');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `fuel_blending_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Blending Approved Indicator Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `h2s_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification Code');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `heating_value_btu_per_gallon` SET TAGS ('dbx_business_glossary_term' = 'Heating Value in British Thermal Units (BTU) per Gallon');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `isobutane_mol_percent` SET TAGS ('dbx_business_glossary_term' = 'Isobutane Mole Percent Composition');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `last_quality_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Quality Test Date');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `mercury_content_ppb` SET TAGS ('dbx_business_glossary_term' = 'Mercury Content in Parts Per Billion (PPB)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `normal_butane_mol_percent` SET TAGS ('dbx_business_glossary_term' = 'Normal Butane Mole Percent Composition');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `pentanes_plus_mol_percent` SET TAGS ('dbx_business_glossary_term' = 'Pentanes Plus (C5+) Mole Percent Composition');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `petrochemical_feedstock_flag` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Feedstock Indicator Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_value_regex' = 'spot|contract|formula|netback');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Product Grade');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `propane_mol_percent` SET TAGS ('dbx_business_glossary_term' = 'Propane Mole Percent Composition');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `purity_percent` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Purity Percent');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `regulatory_product_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Product Code');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `shrinkage_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Shrinkage Factor Percent');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity at 60°F/60°F');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `specification_notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `storage_classification` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Storage Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `storage_classification` SET TAGS ('dbx_value_regex' = 'pressurized|refrigerated|ambient|underground_cavern');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `stream_code` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Stream Code');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `stream_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `stream_name` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Stream Name');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `stream_status` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Stream Status');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `stream_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|decommissioned');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `sulfur_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Transportation Mode');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'pipeline|rail|truck|marine|storage');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `vapor_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Reid Vapor Pressure (RVP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `water_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Water Content in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` SET TAGS ('dbx_subdomain' = 'pricing_benchmark');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `assessment_window_end` SET TAGS ('dbx_business_glossary_term' = 'Assessment Window End Time');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `assessment_window_start` SET TAGS ('dbx_business_glossary_term' = 'Assessment Window Start Time');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `benchmark_code` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Code');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `benchmark_description` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Description');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `benchmark_name` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Name');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Status');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|discontinued|under_review');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Type');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_value_regex' = 'spot|futures|forward|swap|index|average');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `contract_month` SET TAGS ('dbx_business_glossary_term' = 'Contract Month');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `contract_symbol` SET TAGS ('dbx_business_glossary_term' = 'Contract Symbol');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `crack_spread_type` SET TAGS ('dbx_business_glossary_term' = 'Crack Spread Type');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_business_glossary_term' = 'Delivery Basis');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_value_regex' = 'fob|cif|dap|exw|fas|cfr');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `minimum_price_increment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Price Increment');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `price_adjustment_formula` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Formula');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `pricing_agency` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agency');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `publication_time` SET TAGS ('dbx_business_glossary_term' = 'Publication Time');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `quality_specification` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `quotation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Quotation Frequency');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `quotation_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|quarterly|annual');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'cash|physical|financially_settled|physically_delivered');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `trading_exchange` SET TAGS ('dbx_business_glossary_term' = 'Trading Exchange');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` SET TAGS ('dbx_subdomain' = 'quality_management');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `quality_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Result ID');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `certificate_of_quality_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Quality Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `original_test_quality_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Original Test ID');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product ID');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Specification ID');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Identification');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `custody_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `deviation_from_spec` SET TAGS ('dbx_business_glossary_term' = 'Deviation from Specification');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `equipment_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Calibration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `laboratory_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation Number');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `parameter_tested` SET TAGS ('dbx_business_glossary_term' = 'Parameter Tested');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Status');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|retest');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Test Remarks');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `retest_indicator` SET TAGS ('dbx_business_glossary_term' = 'Retest Indicator');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'composite|spot|running|automatic');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `specification_max` SET TAGS ('dbx_business_glossary_term' = 'Specification Maximum Value');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `specification_min` SET TAGS ('dbx_business_glossary_term' = 'Specification Minimum Value');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Date');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `test_method_code` SET TAGS ('dbx_business_glossary_term' = 'Test Method Code');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `test_method_code` SET TAGS ('dbx_value_regex' = '^ASTM [A-Z][0-9]{4}$|^API MPMS [0-9.]+$|^ISO [0-9]{4,5}$|^IP [0-9]{3}$');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `test_method_name` SET TAGS ('dbx_business_glossary_term' = 'Test Method Name');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `test_pressure` SET TAGS ('dbx_business_glossary_term' = 'Test Pressure');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `test_priority` SET TAGS ('dbx_business_glossary_term' = 'Test Priority Level');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `test_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|regulatory|dispute');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|on_hold');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `test_temperature` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` SET TAGS ('dbx_subdomain' = 'quality_management');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `certificate_of_quality_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Quality (CoQ) Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Laboratory Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `refined_product_id` SET TAGS ('dbx_business_glossary_term' = 'Refined Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `certificate_number` SET TAGS ('dbx_value_regex' = '^COQ-[A-Z0-9]{8,12}$');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'draft|issued|amended|superseded|voided|disputed');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `cetane_index` SET TAGS ('dbx_business_glossary_term' = 'Cetane Index');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `digital_signature` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `digital_signature` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `distillation_fbp_c` SET TAGS ('dbx_business_glossary_term' = 'Distillation Final Boiling Point (FBP) Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `distillation_ibp_c` SET TAGS ('dbx_business_glossary_term' = 'Distillation Initial Boiling Point (IBP) Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `distillation_t50_c` SET TAGS ('dbx_business_glossary_term' = 'Distillation T50 Temperature Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `distillation_t90_c` SET TAGS ('dbx_business_glossary_term' = 'Distillation T90 Temperature Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `inspector_certification` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `laboratory_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `meets_specification_flag` SET TAGS ('dbx_business_glossary_term' = 'Meets Specification Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `mon_rating` SET TAGS ('dbx_business_glossary_term' = 'Motor Octane Number (MON) Rating');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `pour_point_c` SET TAGS ('dbx_business_glossary_term' = 'Pour Point Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `quantity_loaded` SET TAGS ('dbx_business_glossary_term' = 'Quantity Loaded');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'BBL|MT|M3|GAL|LTR');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `reid_vapor_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Reid Vapor Pressure (RVP) Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Certificate Remarks');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `ron_rating` SET TAGS ('dbx_business_glossary_term' = 'Research Octane Number (RON) Rating');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `salt_content_ptb` SET TAGS ('dbx_business_glossary_term' = 'Salt Content Pounds per Thousand Barrels (PTB)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `sampling_date` SET TAGS ('dbx_business_glossary_term' = 'Sampling Date');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `sampling_point` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `sulfur_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `tan_value` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) Value');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `vessel_imo_number` SET TAGS ('dbx_business_glossary_term' = 'Vessel International Maritime Organization (IMO) Number');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `vessel_imo_number` SET TAGS ('dbx_value_regex' = '^IMO[0-9]{7}$');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `viscosity_cst` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Centistokes (cSt)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `viscosity_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Measurement Temperature Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `water_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Water Content Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `accidental_release_containment_methods` SET TAGS ('dbx_business_glossary_term' = 'Accidental Release - Containment and Cleanup Methods');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `appearance` SET TAGS ('dbx_business_glossary_term' = 'Appearance');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `autoignition_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Autoignition Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `conditions_to_avoid` SET TAGS ('dbx_business_glossary_term' = 'Conditions to Avoid');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `disposal_considerations` SET TAGS ('dbx_business_glossary_term' = 'Disposal Considerations');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|archived|withdrawn');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `ecological_information` SET TAGS ('dbx_business_glossary_term' = 'Ecological Information');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `emergency_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Phone Number');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `emergency_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `emergency_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `exposure_limits` SET TAGS ('dbx_business_glossary_term' = 'Occupational Exposure Limits');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `firefighting_extinguishing_media` SET TAGS ('dbx_business_glossary_term' = 'Firefighting - Suitable Extinguishing Media');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `firefighting_special_hazards` SET TAGS ('dbx_business_glossary_term' = 'Firefighting - Special Hazards');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `first_aid_eye_contact` SET TAGS ('dbx_business_glossary_term' = 'First Aid Measures - Eye Contact');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `first_aid_ingestion` SET TAGS ('dbx_business_glossary_term' = 'First Aid Measures - Ingestion');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `first_aid_inhalation` SET TAGS ('dbx_business_glossary_term' = 'First Aid Measures - Inhalation');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `first_aid_skin_contact` SET TAGS ('dbx_business_glossary_term' = 'First Aid Measures - Skin Contact');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `flammability_limits_lower_pct` SET TAGS ('dbx_business_glossary_term' = 'Lower Flammability Limit (Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `flammability_limits_upper_pct` SET TAGS ('dbx_business_glossary_term' = 'Upper Flammability Limit (Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `handling_precautions` SET TAGS ('dbx_business_glossary_term' = 'Handling Precautions');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `hazard_pictograms` SET TAGS ('dbx_business_glossary_term' = 'Hazard Pictograms');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `hazard_statements` SET TAGS ('dbx_business_glossary_term' = 'Hazard Statements');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `hazardous_decomposition_products` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Decomposition Products');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `incompatible_materials` SET TAGS ('dbx_business_glossary_term' = 'Incompatible Materials');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `odor` SET TAGS ('dbx_business_glossary_term' = 'Odor');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas|vapor|aerosol');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `precautionary_statements` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Statements');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Proper Shipping Name');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `regulatory_information` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Information');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `sds_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Number');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `sds_version` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Version');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `signal_word` SET TAGS ('dbx_business_glossary_term' = 'Signal Word');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `signal_word` SET TAGS ('dbx_value_regex' = 'Danger|Warning');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `solubility_in_water` SET TAGS ('dbx_business_glossary_term' = 'Solubility in Water');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `stability` SET TAGS ('dbx_business_glossary_term' = 'Chemical Stability');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `stability` SET TAGS ('dbx_value_regex' = 'stable|unstable');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `toxicological_information` SET TAGS ('dbx_business_glossary_term' = 'Toxicological Information');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `vapor_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Vapor Pressure (Kilopascals)');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` SET TAGS ('dbx_subdomain' = 'pricing_benchmark');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_history_id` SET TAGS ('dbx_business_glossary_term' = 'Price History Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `benchmark_price` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Price');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `final_price` SET TAGS ('dbx_business_glossary_term' = 'Final Price');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Reason');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Price Currency Code');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_date` SET TAGS ('dbx_business_glossary_term' = 'Price Date');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Effective Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Expiration Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_notes` SET TAGS ('dbx_business_glossary_term' = 'Price Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_record_number` SET TAGS ('dbx_business_glossary_term' = 'Price Record Number');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_source_system` SET TAGS ('dbx_business_glossary_term' = 'Price Source System');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'preliminary|confirmed|revised|final|cancelled');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `pricing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Period End Date');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `pricing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Period Start Date');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `pricing_point` SET TAGS ('dbx_business_glossary_term' = 'Pricing Point');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `processing_cost` SET TAGS ('dbx_business_glossary_term' = 'Processing Cost');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `sec_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Pricing Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `settlement_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reference');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `transportation_cost` SET TAGS ('dbx_business_glossary_term' = 'Transportation Cost');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `volume_basis` SET TAGS ('dbx_business_glossary_term' = 'Volume Basis');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
