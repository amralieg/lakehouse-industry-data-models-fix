-- Schema for Domain: product | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`product` COMMENT 'Serves as the SSOT for the petroleum product catalog including crude oil grades (WTI, Brent, sour/sweet), natural gas specifications, LNG, LPG, NGL streams, refined products (gasoline, diesel, jet fuel, fuel oil), and petrochemicals. Manages product quality specifications, API gravity, sulfur content, RON ratings, pricing benchmarks, and regulatory product classifications across the entire value chain.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`petroleum_product` (
    `petroleum_product_id` BIGINT COMMENT 'Unique system identifier for the petroleum product record. Primary key for the petroleum product master catalog.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Product stewardship is fundamental in oil-and-gas operations. Each petroleum product requires a technical owner responsible for specifications, regulatory compliance, quality standards, and lifecycle ',
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
    `pricing_benchmark` STRING COMMENT 'Reference pricing index or benchmark used for commercial valuation. Examples: WTI (West Texas Intermediate), Brent ICE, Henry Hub, Platts, Argus. Links product to market pricing mechanisms.',
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
    `assay_id` BIGINT COMMENT 'Reference identifier to the detailed crude oil assay document. The assay contains comprehensive distillation curves, product yields, and quality specifications. Used for refinery linear programming (LP) models and crude selection optimization.. Valid values are `^[A-Z0-9_-]{5,30}$`',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Crude grade specifications require technical authority ownership for assay validation, pricing differential approval, and refinery compatibility assessments. Critical for crude trading operations and ',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the parent petroleum product catalog entry. Links this crude grade to the broader product master for catalog identity and product hierarchy.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Crude grades often have primary suppliers/traders (e.g., Saudi Aramco for Arab Light). Tracking primary vendor enables sourcing strategy, supply reliability, and vendor relationship management for cru',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Crude grades are produced/marketed by specific profit centers for P&L attribution, margin analysis, and segment reporting in upstream and trading operations.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity measurement in degrees API, indicating the density of the crude oil relative to water. Light crude: >31.1°API. Medium crude: 22.3-31.1°API. Heavy crude: <22.3°API. Critical for refinery yield optimization and pricing.',
    `api_gravity_band` STRING COMMENT 'Categorical classification of crude oil by API gravity. Light: >31.1°API. Medium: 22.3-31.1°API. Heavy: 10-22.3°API. Extra Heavy: <10°API. Used for refinery planning and commercial segmentation.. Valid values are `light|medium|heavy|extra_heavy`',
    `assay_date` DATE COMMENT 'Date when the crude oil assay was performed or last updated. Assays should be refreshed periodically as crude quality can vary over time due to reservoir changes or production operations.',
    `benchmark_index` STRING COMMENT 'Primary benchmark pricing index used for commercial valuation of this crude grade. WTI: West Texas Intermediate (NYMEX). BRENT: Dated Brent (ICE). DUBAI: Dubai/Oman average. URALS: Urals RCMB. MAYA: Maya Mexican. NONE: proprietary or spot pricing. [ENUM-REF-CANDIDATE: WTI|BRENT|DUBAI|OMAN|URALS|MAYA|NONE — 7 candidates stripped; promote to reference product]',
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
    `petroleum_product_id` BIGINT COMMENT 'Foreign key reference to the petroleum product (crude oil grade, refined product, NGL, LNG, LPG, or petrochemical) to which this quality specification applies.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Quality specifications require technical owner for test method validation, tolerance setting, and regulatory citation maintenance. Critical for contract compliance, custody transfer acceptance criteri',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Laboratory assays require certified analyst assignment for regulatory compliance, custody transfer validation, and quality certification. Essential for traceability in API gravity, sulfur content, and',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Crude assay costs (laboratory analysis, third-party testing) are charged to exploration or trading cost centers for crude evaluation and acquisition decision support.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Third-party laboratories performing crude assays are vendors providing analytical services. Links assay data to vendor for quality assurance, accreditation verification, and service procurement manage',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Crude assays are lease-specific when production streams are not commingled. Critical for refinery planning, crude valuation, and marketing. Business process: crude marketing strategy and pricing diffe',
    `analysis_date` DATE COMMENT 'Date when the laboratory assay analysis was performed. Critical for tracking assay currency and determining which assay to use for refinery planning.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the crude oil or condensate measured at 60°F. Key quality indicator inversely related to density. Light crudes have higher API gravity (>31.1°), heavy crudes lower (<22.3°).',
    `aromatics_content_vol_pct` DECIMAL(18,2) COMMENT 'Total aromatic hydrocarbon content as volume percent. Aromatics affect octane number in gasoline, cetane number in diesel, and smoke point in jet fuel.',
    `asphaltene_content_wt_pct` DECIMAL(18,2) COMMENT 'Asphaltene content as weight percent. High asphaltene content affects crude stability, blending compatibility, and processing difficulty in heavy oil upgrading.',
    `assay_status` STRING COMMENT 'Current lifecycle status of the assay record. Validated and approved assays are used for refinery linear programming (LP) models and crude evaluation.. Valid values are `draft|validated|approved|superseded|archived`',
    `carbon_residue_wt_pct` DECIMAL(18,2) COMMENT 'Conradson Carbon Residue as weight percent. Indicates coke-forming tendency of the crude, particularly important for vacuum residue processing and coking unit feed evaluation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assay record was first created in the system. Part of audit trail for data lineage and compliance.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key reference to the crude grade or condensate type that this assay characterizes. Links to the product catalog master data.',
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
    `sample_source` STRING COMMENT 'Geographic source or field location where the crude oil or condensate sample was collected for assay analysis. Important for tracking regional quality variations.',
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
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Links refined product catalog (gasoline, diesel, jet fuel, fuel oil) to petroleum_product master. petroleum_product is the SSOT for all petroleum product identities. Removes product_code, product_name',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Refined products (gasoline, diesel, jet fuel) require product manager ownership for specification compliance, blending optimization, pricing strategy, and market allocation. Critical for downstream co',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Refined products (gasoline, diesel, jet fuel) are managed by downstream profit centers for margin analysis, crack spread tracking, and refinery performance measurement.',
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
    `specification_standard` STRING COMMENT 'Industry or regulatory specification standard governing product quality (e.g., ASTM D975, EN 590, ISO 8217, DEF STAN 91-91). Defines the technical requirements the product must meet.',
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
    `equipment_id` BIGINT COMMENT 'Reference to the fractionation train or gas processing facility where this NGL stream is produced.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: NGL streams from joint venture gas processing plants are governed by JOAs. Business process: NGL fractionation cost allocation, product split calculations among partners, partner entitlement by NGL co',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: NGL streams may be sourced from specific vendors (gas processors, fractionators) for supply agreements. Enables sourcing strategy, supply reliability tracking, and vendor relationship management for N',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: NGL streams (ethane, propane, butane) are revenue-generating products managed by midstream profit centers for product margin tracking and fractionation economics.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: NGL fractionation streams require operational supervisor assignment for quality control, composition monitoring (ethane, propane, butane ratios), and safety management (H2S, mercury content). Essentia',
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
    `pricing_index` STRING COMMENT 'Primary pricing index or hub used for commercial valuation of this NGL stream (e.g., Mont Belvieu, Conway).. Valid values are `mont_belvieu|conway|edmonton|sarnia|custom`',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`lng_specification` (
    `lng_specification_id` BIGINT COMMENT 'Unique identifier for the LNG specification record. Primary key for the LNG specification master data entity.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Links LNG specification templates to the petroleum_product master catalog. petroleum_product is described as the SSOT for all petroleum product identities. This FK connects LNG specifications to the p',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: LNG products are managed by LNG business unit profit centers for commercial performance tracking, cargo margin analysis, and SPA (Sales and Purchase Agreement) profitability.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: LNG specifications require technical author assignment for Wobbe index compliance, heating value validation, and SPA (Sales and Purchase Agreement) quality terms. Critical for cargo acceptance, regasi',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: LNG supply contracts reference vendor-specific quality specifications and delivery terms. Links LNG quality specs to supplier for contract management, quality assurance, and custody transfer in LNG tr',
    `approval_date` DATE COMMENT 'Date on which this LNG specification was formally approved by the designated authority and released for operational use.',
    `approved_by` STRING COMMENT 'Name or identifier of the technical authority or commercial manager who approved this LNG specification for operational use.',
    `butane_plus_content_mol_pct` DECIMAL(18,2) COMMENT 'Combined content of butane and heavier hydrocarbons (C4+) expressed as mole percent (mol%). Higher C4+ content increases heating value and may require NGL extraction before pipeline injection.',
    `carbon_dioxide_content_mol_pct` DECIMAL(18,2) COMMENT 'Carbon dioxide content expressed as mole percent (mol%). CO2 is typically removed during liquefaction to prevent freezing. Specification limits are usually below 50 ppm.',
    `cargo_type` STRING COMMENT 'Classification of the LNG cargo delivery terms. Spot cargoes are one-time purchases; term cargoes are under long-term contract. FOB (Free On Board), DES (Delivered Ex-Ship), and CIF (Cost Insurance Freight) indicate delivery responsibility.. Valid values are `spot|term|FOB|DES|CIF`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LNG specification record was first created in the system. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `effective_date` DATE COMMENT 'Date from which this LNG specification becomes effective and applicable for cargo nominations, terminal operations, and quality assurance testing.',
    `ethane_content_mol_pct` DECIMAL(18,2) COMMENT 'Ethane content expressed as mole percent (mol%) of the LNG composition. Ethane is a key component of Natural Gas Liquids (NGL) and affects heating value and Wobbe Index.',
    `expiration_date` DATE COMMENT 'Date on which this LNG specification expires or is superseded by a revised specification. Nullable for specifications with indefinite validity.',
    `gross_heating_value_btu_per_scf` DECIMAL(18,2) COMMENT 'Gross heating value (higher heating value) expressed in British Thermal Units per standard cubic foot (BTU/scf) at 60°F and 14.73 psia. Common unit in North American LNG markets. Typical range is 1,000-1,100 BTU/scf.',
    `higher_heating_value_mj_per_nm3` DECIMAL(18,2) COMMENT 'Higher heating value (gross calorific value) of the LNG when regasified, expressed in megajoules per normal cubic meter (MJ/Nm³) at standard conditions (15°C, 1 atm). Typical range is 38-42 MJ/Nm³. Used for energy content billing and pipeline compatibility assessment.',
    `hydrogen_sulfide_content_ppm` DECIMAL(18,2) COMMENT 'Hydrogen sulfide content expressed in parts per million (ppm). H2S is a toxic and corrosive contaminant that must be removed during gas processing. Typical specification limit is less than 4 ppm.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this LNG specification record was last modified or updated in the system. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `liquefaction_train_origin` STRING COMMENT 'Name or identifier of the liquefaction train or facility where this LNG specification originates. Different trains at the same plant may produce slightly different compositions.',
    `lower_heating_value_mj_per_nm3` DECIMAL(18,2) COMMENT 'Lower heating value (net calorific value) of the LNG when regasified, expressed in megajoules per normal cubic meter (MJ/Nm³) at standard conditions. LHV excludes the latent heat of water vapor condensation.',
    `mercury_content_ng_per_nm3` DECIMAL(18,2) COMMENT 'Mercury content expressed in nanograms per normal cubic meter (ng/Nm³). Mercury causes corrosion of aluminum heat exchangers in liquefaction plants and must be removed to trace levels, typically below 10 ng/Nm³.',
    `methane_content_mol_pct` DECIMAL(18,2) COMMENT 'Methane content expressed as mole percent (mol%) of the LNG composition. Typical range is 85-99 mol%. Critical for heating value calculation and regasification planning.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this LNG specification record. Used for audit trail and data governance.',
    `ngl_extraction_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether Natural Gas Liquids (NGL) extraction is required before pipeline injection due to high C2+ content. True if extraction is required; False otherwise.',
    `nitrogen_content_mol_pct` DECIMAL(18,2) COMMENT 'Nitrogen content expressed as mole percent (mol%). Nitrogen is an inert diluent that reduces heating value and Wobbe Index. Typical specification limits are 0.1-1.0 mol%.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this LNG specification, such as seasonal variations, blending requirements, or operational constraints.',
    `oxygen_content_ppm` DECIMAL(18,2) COMMENT 'Oxygen content expressed in parts per million (ppm). Oxygen is removed during liquefaction to prevent combustion risk and corrosion. Typical specification limit is less than 10 ppm.',
    `pipeline_injection_compatible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the regasified LNG meets the receiving pipeline gas quality specifications without further processing or blending. True if compatible; False if NGL extraction or blending is required.',
    `pricing_benchmark` STRING COMMENT 'Pricing benchmark or index used for this LNG specification. JKM (Japan Korea Marker), TTF (Title Transfer Facility - European hub), HH (Henry Hub - US), Brent crude oil, JCC (Japan Crude Cocktail), or custom formula.. Valid values are `JKM|TTF|HH|Brent|JCC|custom`',
    `propane_content_mol_pct` DECIMAL(18,2) COMMENT 'Propane content expressed as mole percent (mol%) of the LNG composition. Propane contributes to heating value and is extracted as Liquefied Petroleum Gas (LPG) in some terminals.',
    `quality_band` STRING COMMENT 'Classification of LNG quality based on heating value and composition profile. Lean LNG has lower heating value and minimal heavier hydrocarbons; rich LNG contains higher C2+ content and greater heating value.. Valid values are `lean|standard|rich|premium|custom|spot`',
    `quality_tolerance_window_pct` DECIMAL(18,2) COMMENT 'Allowable percentage deviation from the specified composition and heating value parameters as defined in the SPA. Typical tolerance is ±2-5% for key parameters.',
    `regasification_terminal` STRING COMMENT 'Name or identifier of the regasification terminal or Floating Storage and Regasification Unit (FSRU) where this LNG specification is intended for delivery and vaporization.',
    `regulatory_classification` STRING COMMENT 'Regulatory classification code for the LNG product under applicable jurisdictions (e.g., UN number, hazard class, customs tariff code). Used for transportation, customs, and safety compliance.',
    `relative_density` DECIMAL(18,2) COMMENT 'Relative density (specific gravity) of the regasified LNG compared to air at the same temperature and pressure. Dimensionless value typically in the range 0.55-0.70. Used for Wobbe Index calculation and pipeline flow modeling.',
    `spa_reference_number` STRING COMMENT 'Reference number of the Sales and Purchase Agreement (SPA) that defines this LNG specification and quality tolerance windows. Links the specification to the commercial contract.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `specification_code` STRING COMMENT 'Externally-known unique business identifier for the LNG specification, used in Sales and Purchase Agreements (SPA), terminal operations, and cargo documentation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `specification_name` STRING COMMENT 'Human-readable name or title for the LNG specification, typically referencing the quality band, terminal, or contract reference.',
    `specification_status` STRING COMMENT 'Current lifecycle state of the LNG specification. Active specifications are in use for cargo nominations and terminal operations; draft specifications are under development; archived specifications are retained for historical reference.. Valid values are `active|inactive|draft|under_review|archived`',
    `total_sulfur_content_ppm` DECIMAL(18,2) COMMENT 'Total sulfur content including H2S, mercaptans, and other sulfur compounds, expressed in parts per million (ppm). Pipeline specifications typically require total sulfur below 20 ppm.',
    `version_number` STRING COMMENT 'Version number of the LNG specification document, following semantic versioning (major.minor). Incremented when specification parameters are revised or updated.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `water_content_ppm` DECIMAL(18,2) COMMENT 'Water content expressed in parts per million (ppm). Water must be removed during liquefaction to prevent hydrate formation and ice blockage. Typical specification is less than 1 ppm.',
    `wobbe_index_mj_per_nm3` DECIMAL(18,2) COMMENT 'Wobbe Index (WI) of the regasified LNG, calculated as HHV divided by the square root of relative density, expressed in MJ/Nm³. The Wobbe Index determines interchangeability of gas in burner applications. Typical range is 48-52 MJ/Nm³.',
    CONSTRAINT pk_lng_specification PRIMARY KEY(`lng_specification_id`)
) COMMENT 'Master specification entity for Liquefied Natural Gas (LNG) cargoes and terminal products. Captures methane content (mol%), higher heating value (HHV), Wobbe Index, C2/C3/C4+ composition, nitrogen content, liquefaction train origin, regasification terminal, LNG quality band (lean/rich), and applicable SPA quality tolerance windows. Used by LNG trading, shipping scheduling, and terminal operations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`petrochemical_product` (
    `petrochemical_product_id` BIGINT COMMENT 'Unique identifier for the petrochemical product. Primary key for the petrochemical product master catalog.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Petrochemical products from joint venture petrochemical facilities are governed by JOAs. Business process: Petrochemical JOA cost recovery, product allocation among partners, partner offtake rights, a',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Links petrochemical product catalog to petroleum_product master. petroleum_product is the SSOT for all petroleum product identities across the value chain. Petrochemicals (ethylene, propylene, benzene',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Petrochemical feedstocks often sourced from specific vendors (refineries, chemical plants). Enables sourcing strategy, supply reliability tracking, and vendor relationship management for petrochemical',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to product.safety_data_sheet. Business justification: Every petrochemical product requires a current SDS per OSHA HazCom standard. Links product to its authoritative hazard communication document, eliminating denormalized hazard data from product table.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Petrochemical products require steward ownership for GHS classification, REACH registration, TSCA compliance, and SDS maintenance. Essential for HSE regulatory compliance, feedstock selection decision',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Petrochemical products are managed by downstream chemicals profit centers for segment reporting, product line profitability, and integrated margin optimization.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance described in the open scientific literature. Critical for regulatory compliance and safety data sheet (SDS) management.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the petrochemical product record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `discontinuation_date` DATE COMMENT 'Date when the petrochemical product was or will be discontinued from the product portfolio. Null if the product is still active. Used for phase-out planning, customer notifications, and inventory liquidation. Format: yyyy-MM-dd.',
    `effective_date` DATE COMMENT 'Date when the petrochemical product record became active and available for commercial transactions, production planning, and inventory management. Format: yyyy-MM-dd.',
    `epa_reporting_required` BOOLEAN COMMENT 'Indicates whether the petrochemical product is subject to EPA reporting requirements such as Toxics Release Inventory (TRI), Chemical Data Reporting (CDR), or Greenhouse Gas Reporting Program (GHGRP). True if reporting is mandatory; false otherwise.',
    `feedstock_type` STRING COMMENT 'Primary hydrocarbon feedstock used in the manufacturing process of the petrochemical product. Naphtha and ethane are common steam cracker feedstocks; natural gas is used for methanol and ammonia production; crude oil fractions are used for aromatics extraction. [ENUM-REF-CANDIDATE: naphtha|ethane|propane|butane|natural_gas|crude_oil|gas_condensate|refinery_offgas — 8 candidates stripped; promote to reference product]',
    `greenhouse_gas_emissions_factor` DECIMAL(18,2) COMMENT 'Carbon dioxide equivalent (CO2e) emissions factor per unit of product manufactured or consumed, expressed in metric tons CO2e per unit. Used for carbon footprint calculations, ESG reporting, and climate risk assessment.',
    `hts_code` STRING COMMENT 'Ten-digit classification code used by U.S. Customs and Border Protection for import/export documentation and tariff determination. Format: XXXX.XX.XX.XX. Required for international trade compliance and duty calculation.. Valid values are `^[0-9]{4}.[0-9]{2}.[0-9]{2}.[0-9]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the petrochemical product record was most recently updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and data quality monitoring.',
    `lifecycle_status` STRING COMMENT 'Current state of the product in its commercial lifecycle. Active products are available for sale and production; inactive products are temporarily unavailable; discontinued products are no longer manufactured; under development products are in pilot or scale-up phase; regulatory review products await approval; phased out products are being withdrawn from market.. Valid values are `active|inactive|discontinued|under_development|regulatory_review|phased_out`',
    `molecular_formula` STRING COMMENT 'Chemical formula representing the types and numbers of atoms in a molecule of the petrochemical product (e.g., C2H4 for ethylene, C6H6 for benzene).',
    `packaging_type` STRING COMMENT 'Primary packaging or transportation mode for the petrochemical product. Bulk liquid and solid are for large-volume shipments; ISO tanks and railcars for intermodal transport; IBCs (Intermediate Bulk Containers) and drums for medium volumes; bags for solid products; cylinders for compressed gases; pipeline for continuous transport. [ENUM-REF-CANDIDATE: bulk_liquid|bulk_solid|iso_tank|railcar|truck|ibc_tote|drum|bag|cylinder|pipeline — 10 candidates stripped; promote to reference product]',
    `pricing_basis` STRING COMMENT 'Market index or benchmark used for pricing the petrochemical product (e.g., Mont Belvieu ethylene, ICIS benzene, Platts propylene). Defines the reference point for contract pricing and market valuation.',
    `process_route` STRING COMMENT 'Manufacturing process or technology route used to produce the petrochemical product (e.g., steam cracking, catalytic reforming, polymerization, alkylation, oxidation). Identifies the production pathway and technology licensor if applicable.',
    `product_category` STRING COMMENT 'High-level classification of the petrochemical product type. Olefins include ethylene and propylene; aromatics include benzene, toluene, xylenes (BTX); polymers include polyethylene, polypropylene, PVC; intermediates include methanol, styrene; solvents include toluene, xylene; specialty chemicals include additives and performance chemicals; fertilizers include ammonia and urea. [ENUM-REF-CANDIDATE: olefins|aromatics|polymers|intermediates|solvents|specialty_chemicals|fertilizers — 7 candidates stripped; promote to reference product]',
    `product_specification_document` STRING COMMENT 'Reference identifier or file path to the detailed product specification document containing complete technical data, test methods, quality parameters, and customer requirements. Used by quality control, sales, and technical service teams.',
    `product_type` STRING COMMENT 'Detailed sub-classification within the product category (e.g., HDPE, LDPE, LLDPE for polyethylene; ortho-xylene, meta-xylene, para-xylene for xylenes). Provides granular segmentation for inventory and sales management.',
    `purity_grade` STRING COMMENT 'Specification of the chemical purity level of the product expressed as a percentage or grade designation (e.g., 99.5% purity, polymer grade, chemical grade, technical grade). Critical for quality assurance and customer specifications.',
    `purity_percentage` DECIMAL(18,2) COMMENT 'Numerical representation of the chemical purity as a percentage (0.00 to 100.00). Used for quality control, pricing, and customer contract specifications.',
    `reach_registration_number` STRING COMMENT 'European Union registration number for chemical substances manufactured or imported in quantities of one tonne or more per year. Required for sales into EU markets and demonstrates compliance with REACH regulation.',
    `safety_data_sheet_revision_date` DATE COMMENT 'Date of the most recent revision to the Safety Data Sheet for the petrochemical product. SDS must be updated when new hazard information becomes available or regulatory requirements change. Format: yyyy-MM-dd.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the petrochemical product can be stored under recommended conditions while maintaining specification quality. After this period, product testing or disposal may be required. Null indicates indefinite shelf life under proper storage.',
    `standard_unit_of_measure` STRING COMMENT 'Primary unit of measure used for inventory, sales, and reporting of the petrochemical product. Kilograms (kg) and metric tons (mt) for mass; gallons (gal), barrels (bbl), cubic meters (m3) for volume; standard cubic feet (scf), thousand cubic feet (mcf), million standard cubic feet (mmscf) for gases. [ENUM-REF-CANDIDATE: kg|mt|lb|gal|bbl|m3|scf|mcf|mmscf — 9 candidates stripped; promote to reference product]',
    `storage_temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum recommended temperature for safe and stable storage of the petrochemical product, measured in degrees Celsius. Above this temperature, the product may degrade, polymerize, or pose increased safety risks.',
    `storage_temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum recommended temperature for safe and stable storage of the petrochemical product, measured in degrees Celsius. Below this temperature, the product may solidify, crystallize, or exhibit undesirable physical changes.',
    `tsca_status` STRING COMMENT 'Regulatory status under the U.S. Toxic Substances Control Act. Active substances are on the TSCA inventory and can be manufactured/imported; inactive substances require notification before commercial activity; exempt substances are excluded from TSCA; PMN (Pre-Manufacture Notice) required for new chemicals not on inventory.. Valid values are `active|inactive|exempt|pmnrequired`',
    `voc_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of volatile organic compounds in the petrochemical product by weight or volume. Used for air quality compliance, emissions calculations, and regulatory reporting under Clean Air Act and state regulations.',
    CONSTRAINT pk_petrochemical_product PRIMARY KEY(`petrochemical_product_id`)
) COMMENT 'Master catalog for petrochemical products manufactured from hydrocarbon feedstocks — including ethylene, propylene, benzene, toluene, xylenes (BTX), methanol, ammonia, polyethylene (HDPE/LDPE/LLDPE), polypropylene, PVC, styrene, and specialty chemicals. Captures CAS number, molecular formula, purity grade, feedstock type, process route, and applicable chemical safety classification (GHS/REACH).';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` (
    `pricing_benchmark_id` BIGINT COMMENT 'Unique identifier for the product pricing benchmark record. Primary key for the product pricing benchmark entity.',
    `differential_benchmark_id` BIGINT COMMENT 'For differential or basis benchmarks, reference to the parent benchmark against which the differential is calculated (e.g., Dubai/Oman differential to Brent, Mars differential to WTI). Null for absolute price benchmarks.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`classification` (
    `classification_id` BIGINT COMMENT 'Unique identifier for the product classification record. Primary key for the product classification entity.',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the petroleum product being classified. Links to the master product catalog covering crude oil grades, natural gas specifications, LNG, LPG, NGL streams, refined products, and petrochemicals.',
    `classification_code` STRING COMMENT 'The specific code value within the classification scheme. For HS codes: 6/8/10-digit tariff code. For UN/NA: dangerous goods number. For EPA: fuel registration category code. For FERC: commodity code. For SEC: reporting category code. For TARIFF: country-specific tariff schedule code. For EXCISE: duty category code. For FTA: preferential rate code. For INTERNAL: product family or subfamily code.',
    `classification_description` STRING COMMENT 'Human-readable description of the classification code. Provides business context and interpretation of the code value for reporting and compliance purposes.',
    `classification_source` STRING COMMENT 'The source or authority that determined this classification. Regulatory Authority = assigned by EPA, FERC, SEC, or other government body. Customs Broker = determined by licensed customs broker for import/export. Internal Tax = assigned by internal tax department. Internal Compliance = assigned by internal compliance team. Third Party Consultant = determined by external classification consultant.. Valid values are `regulatory_authority|customs_broker|internal_tax|internal_compliance|third_party_consultant`',
    `classification_status` STRING COMMENT 'Current lifecycle status of the classification record. Active = currently in use, Inactive = no longer applicable, Pending = awaiting regulatory approval or internal validation, Superseded = replaced by a newer classification.. Valid values are `active|inactive|pending|superseded`',
    `confidence` STRING COMMENT 'The confidence level or certainty of the classification assignment. Confirmed = validated by regulatory authority or expert. Probable = high confidence based on product specifications and industry standards. Provisional = preliminary classification pending validation or regulatory ruling.. Valid values are `confirmed|probable|provisional`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this product classification record was first created in the system. Supports audit trail and data lineage tracking.',
    `dangerous_goods_class` STRING COMMENT 'The UN/DOT hazard class for dangerous goods classification. Examples: Class 3 (Flammable Liquids) for crude oil and refined products, Class 2.1 (Flammable Gas) for natural gas and LPG. Nullable for non-hazardous products.',
    `duty_rate` DECIMAL(18,2) COMMENT 'The applicable duty or tax rate associated with this classification code, expressed as a percentage or per-unit amount. Used for customs declarations, excise duty calculations, and trade compliance. Nullable for non-tariff classifications.',
    `duty_rate_unit` STRING COMMENT 'The unit of measure for the duty rate. Percent = ad valorem duty as percentage of value, USD per BBL = duty per barrel of oil, USD per gallon = duty per gallon of refined product, USD per ton = duty per metric ton, USD per MMBTU = duty per million British thermal units for natural gas.. Valid values are `percent|usd_per_bbl|usd_per_gallon|usd_per_ton|usd_per_mmbtu`',
    `effective_date` DATE COMMENT 'The date from which this classification becomes valid and applicable for the product. Supports time-variant classification as tariff codes, regulations, and internal taxonomies evolve.',
    `epa_fuel_category` STRING COMMENT 'The EPA fuel registration category for refined petroleum products. Used for environmental compliance, emissions reporting, and fuel quality standards. Examples: Conventional Gasoline, Reformulated Gasoline (RFG), Ultra-Low Sulfur Diesel (ULSD), Heating Oil. Nullable for non-fuel products.',
    `expiration_date` DATE COMMENT 'The date on which this classification ceases to be valid. Nullable for classifications that remain active indefinitely. Supports historical tracking and regulatory compliance audits.',
    `ferc_commodity_code` STRING COMMENT 'The FERC commodity code used for natural gas pipeline tariff filings and wholesale market reporting. Applicable to natural gas, LNG, and NGL products. Nullable for crude oil and refined products.',
    `fta_program` STRING COMMENT 'The specific Free Trade Agreement or trade preference program under which preferential rates apply. Examples: USMCA (United States-Mexico-Canada Agreement), CAFTA-DR (Central America-Dominican Republic FTA), GSP (Generalized System of Preferences). Nullable if no preferential program applies.',
    `internal_product_family` STRING COMMENT 'The top-level internal product hierarchy classification. Examples: Upstream (crude oil, natural gas), Midstream (NGL, LNG, LPG), Downstream (gasoline, diesel, jet fuel, fuel oil), Petrochemicals (ethylene, propylene, benzene, aromatics). Used for internal reporting, profitability analysis, and cross-domain product categorization.',
    `internal_product_subfamily` STRING COMMENT 'The second-level internal product hierarchy classification within the product family. Examples: Light Sweet Crude, Heavy Sour Crude, Dry Gas, Wet Gas, Conventional Gasoline, Reformulated Gasoline, Jet A, Jet A-1, Olefins, Aromatics. Provides granular categorization for analytics and reporting.',
    `jurisdiction` STRING COMMENT 'The country, region, or regulatory authority for which this classification applies. Uses 3-letter ISO country codes (e.g., USA, CAN, MEX, GBR, SAU) or regulatory body abbreviations (e.g., EPA, FERC, SEC). For global standards like HS or UN, may be set to GLOBAL.',
    `modified_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this product classification record. Supports audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this product classification record was last modified. Supports audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, rationale, or special considerations for this classification. May include references to product specifications, regulatory guidance, or internal decision criteria.',
    `packing_group` STRING COMMENT 'The UN packing group indicating the degree of danger for dangerous goods. I = high danger, II = medium danger, III = low danger. Applicable only to dangerous goods classifications.. Valid values are `I|II|III`',
    `preferential_rate_flag` BOOLEAN COMMENT 'Indicates whether this classification qualifies for preferential duty rates under a Free Trade Agreement (FTA) or other trade preference program. True = preferential rate applies, False = standard duty rate applies.',
    `ruling_reference_number` STRING COMMENT 'The reference number of any official ruling, determination, or binding decision from a regulatory authority or customs agency that supports this classification. Examples: CBP ruling number, EPA determination letter number, FERC order number. Nullable if no formal ruling exists.',
    `scheme` STRING COMMENT 'The classification taxonomy or standard being applied. HS = Harmonized System tariff codes, UN_NA = United Nations/North America dangerous goods numbers, EPA = Environmental Protection Agency fuel registration categories, FERC = Federal Energy Regulatory Commission commodity codes, SEC = Securities and Exchange Commission reporting categories, TARIFF = country-specific import/export tariff schedules, EXCISE = excise duty categories, FTA = Free Trade Agreement preferential rates, INTERNAL = internal product family/subfamily hierarchy. [ENUM-REF-CANDIDATE: HS|UN_NA|EPA|FERC|SEC|TARIFF|EXCISE|FTA|INTERNAL — 9 candidates stripped; promote to reference product]',
    `sec_reporting_category` STRING COMMENT 'The SEC reporting category for petroleum reserves and production disclosure. Used for financial reporting and reserves classification under SEC Industry Guide 2. Examples: Crude Oil, Natural Gas, Natural Gas Liquids (NGL), Condensate. Nullable for downstream refined products and petrochemicals.',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this product classification record. Supports audit trail and accountability.',
    CONSTRAINT pk_classification PRIMARY KEY(`classification_id`)
) COMMENT 'Unified reference taxonomy mapping petroleum products to external and internal classification hierarchies. Covers HS (Harmonized System) 6/8/10-digit tariff codes, UN/NA dangerous goods numbers, EPA fuel registration categories, FERC commodity codes, SEC reporting categories, country-specific import/export tariff schedules, excise duty categories, FTA preferential rates, and internal product family/subfamily hierarchy. Each record links a petroleum_product to a classification scheme, code value, jurisdiction, effective date, and duty/rate where applicable. Supports customs declarations, regulatory reporting, trade compliance, and cross-domain product categorization.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`quality_test_result` (
    `quality_test_result_id` BIGINT COMMENT 'Unique identifier for the quality test result record. Primary key for the quality test result entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality testing costs (lab fees, equipment, labor) are allocated to cost centers for operational expense tracking, variance analysis, and LOE reporting in oil-and-gas operations.',
    `employee_id` BIGINT COMMENT 'Identifier of the laboratory technician who performed the test.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Test costs must post to specific GL accounts for financial reporting, cost element classification, and compliance with oil-and-gas accounting standards (successful efforts or full cost).',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Quality testing costs for products under JOA governance must be allocated to partners. Business process: JOA quality assurance cost allocation, partner dispute resolution over product quality, custody',
    `laboratory_id` BIGINT COMMENT 'Unique identifier for the laboratory facility that performed the test (internal lab or third-party certified lab).',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: External laboratories conducting quality tests are procurement vendors (analytical services). Enables vendor performance tracking, accreditation verification, and service contract management for quali',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Quality testing at lease custody transfer points determines product acceptance and pricing adjustments. Required for revenue allocation and contract compliance. Business process: monthly production ac',
    `original_test_quality_test_result_id` BIGINT COMMENT 'Reference to the original quality test result ID if this is a retest, enabling traceability of quality investigations.',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the petroleum product being tested (crude oil grade, refined product, LNG, LPG, NGL, petrochemical).',
    `quality_spec_id` BIGINT COMMENT 'Reference to the quality specification standard against which this test result is evaluated.',
    `sample_id` BIGINT COMMENT 'Unique identifier assigned to the petroleum product sample collected for testing. Links to the physical sample taken at custody transfer point, tank farm, loading terminal, or refinery gate.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment, cargo, or delivery associated with this quality test (for custody transfer quality verification).',
    `equipment_id` BIGINT COMMENT 'Unique identifier of the laboratory instrument or equipment used to perform the test (for calibration tracking and traceability).',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result was reviewed and approved by authorized laboratory personnel.',
    `approved_by` STRING COMMENT 'Identifier of the laboratory supervisor or quality manager who reviewed and approved the test result.',
    `batch_number` STRING COMMENT 'Production batch or lot number of the petroleum product being tested, enabling traceability to production run.',
    `coq_reference_number` STRING COMMENT 'Unique reference number of the Certificate of Quality document issued based on this test result, provided to buyer at custody transfer.',
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
    `sample_location` STRING COMMENT 'Physical location where the sample was collected (e.g., Tank 101, Loading Rack 3, Custody Transfer Meter Station A, Refinery Gate 2).',
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
    `cargo_id` BIGINT COMMENT 'Reference to the cargo or batch for which this certificate was issued. Links to the cargo nomination or shipment record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: COQ issuance costs (inspection, lab analysis, certification) are allocated to terminal or trading cost centers for custody transfer expense tracking in oil-and-gas operations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Certificates of Quality require certified inspector assignment for custody transfer validation, cargo acceptance, and regulatory compliance. Essential for marine operations, export/import documentatio',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Third-party laboratories issuing CoQs are vendors in procurement system. Critical for custody transfer, quality assurance, and regulatory compliance in commodity trading and supply chain operations.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Certificates of quality for cargoes lifted under JOA partner entitlements require JOA linkage. Business process: Partner lifting certification, JOA entitlement verification, cargo allocation documenta',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Certificates of Quality issued at lease delivery points for custody transfer and export. Links product quality certification to lease production for cargo documentation. Business process: cargo loadin',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the petroleum product being certified (crude oil grade, refined product, LNG, LPG, NGL, petrochemical).',
    `analysis_date` DATE COMMENT 'Date on which the laboratory analysis and testing of the product sample was performed. May differ from issue date.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the crude oil or petroleum product, measured in degrees API. Key quality parameter for crude oil classification (light, medium, heavy).',
    `batch_number` STRING COMMENT 'Production batch or lot number of the petroleum product being certified. Used for traceability across the supply chain.',
    `certificate_number` STRING COMMENT 'Externally-known unique certificate number issued by the laboratory or inspection authority. Used for legal reference and trade settlement.. Valid values are `^COQ-[A-Z0-9]{8,12}$`',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the Certificate of Quality. Tracks whether the certificate is in draft, officially issued, amended, superseded by a newer version, voided, or under dispute.. Valid values are `draft|issued|amended|superseded|voided|disputed`',
    `cetane_index` DECIMAL(18,2) COMMENT 'Cetane index for diesel fuel. Indicates the ignition quality of diesel fuel. Higher values indicate better ignition characteristics.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this Certificate of Quality record was first created in the data platform. Used for audit trail and data lineage.',
    `digital_signature` STRING COMMENT 'Cryptographic digital signature or hash of the certificate for authenticity verification. Prevents tampering and ensures document integrity.',
    `discharge_port` STRING COMMENT 'Name of the destination port or terminal where the cargo will be or was discharged. Used for trade settlement and logistics tracking.',
    `distillation_fbp_c` DECIMAL(18,2) COMMENT 'Final Boiling Point from distillation analysis in degrees Celsius. Maximum temperature reached during distillation testing.',
    `distillation_ibp_c` DECIMAL(18,2) COMMENT 'Initial Boiling Point from distillation analysis in degrees Celsius. First temperature at which vapor is produced during distillation testing.',
    `distillation_t50_c` DECIMAL(18,2) COMMENT 'Temperature at which 50% of the product has been distilled. Key indicator of the products volatility profile.',
    `distillation_t90_c` DECIMAL(18,2) COMMENT 'Temperature at which 90% of the product has been distilled. Important for fuel performance and emissions characteristics.',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Flash point of the product in degrees Celsius. Critical safety parameter for handling, storage, and transportation classification.',
    `inspector_certification` STRING COMMENT 'Professional certification or license number of the inspector (e.g., API Inspector certification, state chemist license). Validates inspector qualifications.',
    `issue_date` DATE COMMENT 'Date on which the Certificate of Quality was officially issued by the laboratory or inspection authority. Legally binding date for trade settlement.',
    `laboratory_accreditation` STRING COMMENT 'Accreditation standard and certificate number of the issuing laboratory (e.g., ISO/IEC 17025:2017, UKAS accreditation number). Validates laboratory competence.',
    `loading_port` STRING COMMENT 'Name of the port, terminal, or facility where the cargo was loaded. Critical for custody transfer documentation.',
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
    `specification_reference` STRING COMMENT 'Industry specification or standard against which the product was tested (e.g., ASTM D975 for diesel, EN 590, ISO 8217 for marine fuels). Defines acceptance criteria.',
    `sulfur_content_pct` DECIMAL(18,2) COMMENT 'Sulfur content of the product expressed as weight percentage. Critical for environmental compliance and product classification (sweet vs. sour crude).',
    `tan_value` DECIMAL(18,2) COMMENT 'Total Acid Number measured in mg KOH/g. Indicates the acidity of crude oil. High TAN crudes are corrosive and require special refinery processing.',
    `vessel_imo_number` STRING COMMENT 'Unique seven-digit IMO number assigned to the vessel for international identification. Used for regulatory compliance and tracking.. Valid values are `^IMO[0-9]{7}$`',
    `vessel_name` STRING COMMENT 'Name of the vessel, tanker, or pipeline through which the product was transported. Applicable for marine and pipeline shipments.',
    `viscosity_cst` DECIMAL(18,2) COMMENT 'Kinematic viscosity of the product measured in centistokes at a specified temperature. Critical for fuel oil and heavy crude specifications.',
    `viscosity_temperature_c` DECIMAL(18,2) COMMENT 'Temperature in degrees Celsius at which the viscosity was measured. Typically 40°C or 50°C for petroleum products.',
    `water_content_pct` DECIMAL(18,2) COMMENT 'Water and sediment content expressed as volume percentage. Used for custody transfer adjustments and quality assessment.',
    CONSTRAINT pk_certificate_of_quality PRIMARY KEY(`certificate_of_quality_id`)
) COMMENT 'Official Certificate of Quality (CoQ) document issued at custody transfer for crude oil and product cargoes. Captures cargo/batch reference, product grade, loading port, vessel/pipeline, date of analysis, all tested parameters with results vs. specification limits, issuing laboratory, inspector name, and digital certificate number. Legally binding document used in trade settlement, dispute resolution, and regulatory compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`blend_recipe` (
    `blend_recipe_id` BIGINT COMMENT 'Primary key for blend_recipe',
    `additive_id` BIGINT COMMENT 'Reference to the first additive or chemical used in the blend (e.g., octane booster, detergent, antioxidant, cetane improver).',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Blending additives are procured from specialized chemical vendors. Tracking supplier enables quality traceability, regulatory compliance (EPA fuel additive registration), and sourcing strategy for ref',
    `asset_facility_id` BIGINT COMMENT 'Reference to the refinery, terminal, or blending facility where the blend operation is performed.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Blend recipes require optimizer assignment for component ratio calculation, additive dosing, and target specification achievement (RON, sulfur, RVP). Critical for refinery operations, margin optimizat',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Blending operations incur direct costs (utilities, labor, additives) allocated to refinery cost centers for production cost tracking and operational performance measurement in downstream operations.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Blending costs post to GL accounts for inventory valuation, COGS calculation, and margin analysis in refining operations—critical for product profitability reporting.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Blending operations at joint venture facilities are governed by JOAs. Business process: Blending cost allocation to JOA partners, product optimization decisions requiring partner approval, blend compo',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the first component stream or crude cut used in the blend (e.g., Reformate, FCC Gasoline, Straight-Run Naphtha).',
    `quaternary_blend_component_stream_4_petroleum_product_id` BIGINT COMMENT 'Reference to the fourth component stream or crude cut used in the blend.',
    `quinary_blend_component_stream_5_petroleum_product_id` BIGINT COMMENT 'Reference to the fifth component stream or crude cut used in the blend.',
    `target_product_petroleum_product_id` BIGINT COMMENT 'Reference to the final blended product that this recipe produces (e.g., Premium Unleaded 93 RON, Ultra-Low Sulfur Diesel, Jet A-1).',
    `tertiary_blend_component_stream_3_petroleum_product_id` BIGINT COMMENT 'Reference to the third component stream or crude cut used in the blend.',
    `actual_blend_volume` DECIMAL(18,2) COMMENT 'Actual total volume of the blended product produced, measured in the same unit as target_volume_uom. Populated upon blend completion.',
    `actual_ron` DECIMAL(18,2) COMMENT 'Actual measured Research Octane Number (RON) of the completed blend, determined by laboratory testing.',
    `actual_sulfur_content` DECIMAL(18,2) COMMENT 'Actual measured sulfur content in the completed blend, determined by laboratory testing, measured in parts per million (ppm) or weight percent.',
    `additive_1_dosage` DECIMAL(18,2) COMMENT 'Dosage or concentration of additive 1 in the blend, typically measured in parts per million (ppm) or volume percentage.',
    `additive_1_dosage_uom` STRING COMMENT 'Unit of measure for additive 1 dosage: PPM (parts per million), VOL_PCT (volume percent), or WT_PCT (weight percent).. Valid values are `PPM|VOL_PCT|WT_PCT`',
    `blend_end_timestamp` TIMESTAMP COMMENT 'Date and time when the blend operation was completed, recorded by the blending control system or operator.',
    `blend_optimization_method` STRING COMMENT 'Method used to optimize the blend recipe: manual (operator-defined), linear_programming (LP solver), nonlinear_optimization (NLP solver), or ai_ml (artificial intelligence/machine learning model).. Valid values are `manual|linear_programming|nonlinear_optimization|ai_ml`',
    `blend_order_number` STRING COMMENT 'Externally-known unique business identifier for the blend order or recipe, typically assigned by the blending system or refinery operations.. Valid values are `^BLD-[0-9]{8}$`',
    `blend_start_timestamp` TIMESTAMP COMMENT 'Date and time when the blend operation actually started, recorded by the blending control system or operator.',
    `blend_status` STRING COMMENT 'Current lifecycle status of the blend order: planned (recipe defined but not started), in_progress (actively blending), completed (blend finished and quality verified), cancelled (blend order cancelled), on_hold (temporarily suspended), or failed (blend did not meet specifications).. Valid values are `planned|in_progress|completed|cancelled|on_hold|failed`',
    `blend_type` STRING COMMENT 'Classification of the blend by product category: gasoline blending, diesel blending, jet fuel blending, fuel oil blending, crude blending, or Liquefied Petroleum Gas (LPG) blending.. Valid values are `gasoline|diesel|jet_fuel|fuel_oil|crude|lpg`',
    `blending_unit` STRING COMMENT 'Specific blending unit, tank, or inline blending system used for the blend operation (e.g., Blender-01, Tank-301, Inline-Blender-A).',
    `component_stream_1_ratio` DECIMAL(18,2) COMMENT 'Target volume percentage (vol%) of component stream 1 in the final blend, expressed as a decimal (e.g., 35.50 for 35.5%).',
    `component_stream_2_ratio` DECIMAL(18,2) COMMENT 'Target volume percentage (vol%) of component stream 2 in the final blend.',
    `component_stream_3_ratio` DECIMAL(18,2) COMMENT 'Target volume percentage (vol%) of component stream 3 in the final blend.',
    `component_stream_4_ratio` DECIMAL(18,2) COMMENT 'Target volume percentage (vol%) of component stream 4 in the final blend.',
    `component_stream_5_ratio` DECIMAL(18,2) COMMENT 'Target volume percentage (vol%) of component stream 5 in the final blend.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this blend recipe or blend order record was first created in the system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this blend recipe or blend order record was last modified in the system.',
    `planned_blend_date` DATE COMMENT 'Scheduled date for the blend operation, used for production planning and scheduling.',
    `quality_test_result` STRING COMMENT 'Result of post-blend quality testing: passed (blend meets all specifications), failed (blend does not meet specifications), pending (testing in progress), or not_tested (quality test not yet performed).. Valid values are `passed|failed|pending|not_tested`',
    `target_api_gravity` DECIMAL(18,2) COMMENT 'Target API gravity for crude oil or refined product blends, a measure of petroleum liquid density relative to water.',
    `target_blend_volume` DECIMAL(18,2) COMMENT 'Planned total volume of the blended product to be produced, measured in barrels (BBL) or cubic meters.',
    `target_cetane_number` DECIMAL(18,2) COMMENT 'Target cetane number for diesel fuel blends, a measure of ignition quality for compression-ignition engines.',
    `target_flash_point` DECIMAL(18,2) COMMENT 'Target flash point temperature for the blended product, measured in degrees Celsius or Fahrenheit, critical for safety and transportation classification.',
    `target_mon` DECIMAL(18,2) COMMENT 'Target Motor Octane Number (MON) for gasoline blends, complementing RON for octane rating.',
    `target_product_grade` STRING COMMENT 'Specific grade or specification of the target blended product (e.g., Regular 87 RON, Premium 93 RON, ULSD 15ppm, Jet A-1 ASTM D1655).',
    `target_reid_vapor_pressure` DECIMAL(18,2) COMMENT 'Target Reid Vapor Pressure (RVP) for gasoline blends, measured in pounds per square inch (psi), critical for volatility control and emissions compliance.',
    `target_ron` DECIMAL(18,2) COMMENT 'Target Research Octane Number (RON) for gasoline blends, a key quality specification for spark-ignition engine fuels.',
    `target_sulfur_content` DECIMAL(18,2) COMMENT 'Target sulfur content in the blended product, measured in parts per million (ppm) or weight percent, critical for environmental compliance (e.g., ULSD 15ppm).',
    `target_viscosity` DECIMAL(18,2) COMMENT 'Target kinematic viscosity for fuel oil or lubricant blends, measured in centistokes (cSt) at a specified temperature.',
    `target_volume_uom` STRING COMMENT 'Unit of measure for the target blend volume: BBL (barrels), M3 (cubic meters), GAL (gallons), or L (liters).. Valid values are `BBL|M3|GAL|L`',
    `version` STRING COMMENT 'Version identifier for the blend recipe (e.g., v1.0, v2.3), allowing tracking of recipe changes and optimization over time.. Valid values are `^v[0-9]+.[0-9]+$`',
    CONSTRAINT pk_blend_recipe PRIMARY KEY(`blend_recipe_id`)
) COMMENT 'Manages petroleum product blending recipes and blend orders — defining the component streams (crude cuts, blending components, additives), target blend ratios (vol%), target quality parameters, blending facility, blend date, and resulting blended product. Used by refinery blending operations, gasoline blending (RON targeting), and crude blending for pipeline or vessel loading. Tracks planned vs. actual blend composition.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`additive` (
    `additive_id` BIGINT COMMENT 'Unique identifier for the additive product in the master catalog.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Additives require technical contact for treat rate optimization, compatibility assessment, supplier management, and regulatory approval tracking. Essential for blending operations, cost control, and E',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Additives are procured from chemical vendors. Direct vendor relationship enables sourcing strategy, pricing negotiation, vendor qualification, and regulatory compliance (EPA registration) for refining',
    `active_ingredient` STRING COMMENT 'Primary active chemical compound or ingredient responsible for the additives functional performance.',
    `additive_status` STRING COMMENT 'Current lifecycle status of the additive in the master catalog (active, inactive, discontinued, under evaluation, restricted).. Valid values are `active|inactive|discontinued|under_evaluation|restricted`',
    `application_purpose` STRING COMMENT 'Detailed description of the functional purpose and performance benefit delivered by the additive in the target product stream (e.g., improves cold flow properties, reduces corrosion, enhances detergency, increases cetane number).',
    `approved_supplier_list` STRING COMMENT 'Comma-separated list of approved supplier names or vendor codes authorized to supply this additive, used for procurement qualification and sourcing decisions.',
    `cas_number` STRING COMMENT 'CAS registry number uniquely identifying the chemical substance of the active ingredient.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `chemical_family` STRING COMMENT 'Primary chemical family or functional category of the additive (e.g., detergent/dispersant, antioxidant, corrosion inhibitor, demulsifier, pour point depressant, cold flow improver, cetane improver, lubricity additive, drag reducing agent, dye/marker, biocide, foam inhibitor). [ENUM-REF-CANDIDATE: detergent_dispersant|antioxidant|corrosion_inhibitor|demulsifier|pour_point_depressant|cold_flow_improver|cetane_improver|lubricity_additive|drag_reducing_agent|dye_marker|biocide|foam_inhibitor|other — 13 candidates stripped; promote to reference product]',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost per unit (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost per unit (gallon, liter, or kilogram) of the additive for procurement and blending cost calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this additive record was first created in the master catalog system.',
    `dot_hazard_class` STRING COMMENT 'DOT hazard class designation for the additive (e.g., Class 3 Flammable Liquid, Class 8 Corrosive) for transportation compliance.',
    `effective_date` DATE COMMENT 'Date from which this additive record became effective and available for use in blending operations.',
    `epa_registration_number` STRING COMMENT 'EPA fuel additive registration number if the additive is subject to EPA fuel additive registration requirements under 40 CFR Part 79.',
    `expiration_date` DATE COMMENT 'Date on which this additive record expires or is no longer valid for use, applicable for discontinued or time-limited approvals.',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Flash point of the additive in degrees Celsius, indicating the lowest temperature at which vapors can ignite.',
    `ghs_classification` STRING COMMENT 'GHS hazard classification codes for the additive (e.g., Flammable Liquid Category 3, Acute Toxicity Category 4) as per the Safety Data Sheet.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this additive record was last modified or updated in the master catalog system.',
    `maximum_treat_rate_ppm` DECIMAL(18,2) COMMENT 'Maximum allowable treat rate in parts per million (ppm) beyond which performance may degrade or regulatory limits may be exceeded.',
    `maximum_treat_rate_vol_pct` DECIMAL(18,2) COMMENT 'Maximum allowable treat rate expressed as volume percent (vol%) for safe and compliant blending.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special handling instructions, or operational comments related to the additive.',
    `packaging_type` STRING COMMENT 'Standard packaging type or container format in which the additive is supplied (e.g., drum, tote, bulk tank, pail, bottle).. Valid values are `drum|tote|bulk_tank|pail|bottle|other`',
    `product_code` STRING COMMENT 'Unique alphanumeric code assigned to the additive for procurement and inventory management, typically the suppliers SKU or internal material number.',
    `product_stream_compatibility` STRING COMMENT 'Comma-separated list of petroleum product streams or grades with which this additive is compatible (e.g., gasoline, diesel, jet fuel, fuel oil, lubricants, crude oil, LPG, LNG).',
    `recommended_treat_rate_ppm` DECIMAL(18,2) COMMENT 'Recommended dosage or treat rate of the additive expressed in parts per million (ppm) for optimal performance in the target product stream.',
    `recommended_treat_rate_vol_pct` DECIMAL(18,2) COMMENT 'Recommended dosage or treat rate of the additive expressed as volume percent (vol%) for blending operations.',
    `regulatory_approval_status` STRING COMMENT 'Current regulatory approval status of the additive for use in petroleum products (approved, pending, not required, restricted).. Valid values are `approved|pending|not_required|restricted`',
    `sds_reference_number` STRING COMMENT 'Reference number or document identifier for the Safety Data Sheet (SDS) associated with this additive.',
    `shelf_life_months` STRING COMMENT 'Shelf life of the additive in months under recommended storage conditions before performance degradation or expiration.',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Specific gravity of the additive at standard conditions (typically 15.6°C/60°F), used for volume-to-mass conversions in blending calculations.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum recommended storage temperature in degrees Celsius to prevent degradation or safety hazards.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum recommended storage temperature in degrees Celsius to maintain additive stability and performance.',
    `trade_name` STRING COMMENT 'Commercial trade name or brand name under which the additive is marketed by the supplier.',
    `un_number` STRING COMMENT 'UN number assigned to the additive for transportation and hazardous materials classification under international shipping regulations.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the additive quantity and pricing (e.g., gallon, liter, kilogram, pound, barrel).. Valid values are `gallon|liter|kilogram|pound|barrel|other`',
    `viscosity_cst` DECIMAL(18,2) COMMENT 'Kinematic viscosity of the additive in centistokes (cSt) at a specified temperature, relevant for blending and handling operations.',
    CONSTRAINT pk_additive PRIMARY KEY(`additive_id`)
) COMMENT 'Master catalog for fuel, lubricant, and process chemical additives used in petroleum product blending and treatment. Covers detergent/dispersant packages, antioxidants, corrosion inhibitors, demulsifiers, pour point depressants, cold flow improvers, cetane improvers, lubricity additives, drag reducing agents (DRA), and dye/marker additives. Captures trade name, chemical family, active ingredient, recommended treat rate (ppm or vol%), maximum treat rate, approved supplier list, product stream compatibility, and safety classification (GHS/SDS reference). Used by blending operations for recipe formulation and by procurement for sourcing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`loss_gain` (
    `loss_gain_id` BIGINT COMMENT 'Primary key for loss_gain',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility where the loss or gain occurred (refinery, terminal, pipeline, storage tank, FPSO, processing plant).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Product losses/gains (evaporation, measurement variance, theft) are allocated to facility cost centers for operational KPI tracking and variance analysis in oil-and-gas operations.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Loss/gain events require GL postings for inventory adjustments, P&L impact recognition, and regulatory reporting (e.g., SEC reserves reconciliation, joint venture billing).',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Product losses and gains at joint venture facilities must be allocated to partners per JOA terms. Business process: JOA loss allocation to partners, variance investigation and reporting, partner billi',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the petroleum product involved in the loss or gain event (crude oil grade, refined product, NGL, LNG, LPG, or petrochemical).',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Product losses and gains affect PSA cost recovery and profit oil calculations. Business process: PSA cost recovery adjustments for losses, government audits of loss claims, contractor entitlement impa',
    `accounting_period` STRING COMMENT 'The financial or operational accounting period (month-year or period code) to which this loss or gain is allocated.',
    `actual_volume_bbl` DECIMAL(18,2) COMMENT 'The actual measured volume in barrels after physical measurement, reconciliation, or inventory verification.',
    `api_gravity` DECIMAL(18,2) COMMENT 'The API gravity of the petroleum product at the time of the loss or gain event, used for volume-to-mass conversions.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective actions taken or planned to address the root cause of the loss or gain.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is required to prevent recurrence of the loss or gain event.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this loss or gain record was first created in the system.',
    `custody_transfer_point` STRING COMMENT 'The specific custody transfer point or measurement location where the loss or gain was identified (e.g., pipeline meter station, tank farm, loading rack).',
    `event_date` DATE COMMENT 'The date on which the loss or gain event occurred or was identified.',
    `expected_volume_bbl` DECIMAL(18,2) COMMENT 'The expected or theoretical volume in barrels based on custody transfer measurements, tank gauging, or pipeline nominations.',
    `financial_impact_usd` DECIMAL(18,2) COMMENT 'The estimated financial impact of the loss or gain in US dollars, calculated using product pricing at the time of the event.',
    `investigation_assigned_to` STRING COMMENT 'Name or identifier of the person or team responsible for investigating the loss or gain event.',
    `investigation_completion_date` DATE COMMENT 'The date on which the investigation into the loss or gain event was completed.',
    `investigation_status` STRING COMMENT 'Current status of the investigation into the loss or gain event.. Valid values are `not_started|in_progress|completed|closed|escalated|pending_approval`',
    `joint_venture_allocation_required` BOOLEAN COMMENT 'Indicates whether this loss or gain must be allocated among joint venture partners according to working interest or net revenue interest.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this loss or gain record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this loss or gain record was last modified in the system.',
    `loss_gain_category` STRING COMMENT 'High-level categorization of the loss or gain for reporting and analysis purposes.. Valid values are `physical_loss|measurement_variance|accounting_adjustment|operational_variance|regulatory_adjustment`',
    `loss_gain_number` STRING COMMENT 'Business identifier for the loss or gain event, typically generated by the production operations or custody transfer system.',
    `loss_gain_type` STRING COMMENT 'Classification of the loss or gain event by operational cause or measurement category. [ENUM-REF-CANDIDATE: evaporation_loss|pipeline_interface_loss|meter_inaccuracy|tank_breathing_loss|measurement_discrepancy|custody_transfer_variance|operational_loss|theft_loss|inventory_gain|measurement_gain|temperature_adjustment|density_adjustment — 12 candidates stripped; promote to reference product]',
    `measurement_method` STRING COMMENT 'The measurement method or technology used to identify the loss or gain variance. [ENUM-REF-CANDIDATE: tank_gauging|flow_meter|mass_meter|coriolis_meter|turbine_meter|ultrasonic_meter|manual_measurement|automated_measurement — 8 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes providing additional context, investigation findings, or operational details about the loss or gain event.',
    `percentage_variance` DECIMAL(18,2) COMMENT 'The loss or gain expressed as a percentage of the expected or measured volume. Used for loss control KPI tracking.',
    `pressure_observed_psi` DECIMAL(18,2) COMMENT 'The observed pressure in pounds per square inch at the time of measurement, used for volume correction calculations.',
    `record_status` STRING COMMENT 'Current lifecycle status of the loss or gain record in the system.. Valid values are `draft|submitted|approved|rejected|closed`',
    `regulatory_report_date` DATE COMMENT 'The date on which the regulatory report was filed for this loss or gain event.',
    `regulatory_report_number` STRING COMMENT 'The reference number of the regulatory report filed for this loss or gain event, if applicable.',
    `reportable_to_regulatory` BOOLEAN COMMENT 'Indicates whether this loss or gain event must be reported to regulatory authorities (EPA, BSEE, PHMSA, state agencies) based on volume thresholds or event type.',
    `root_cause_classification` STRING COMMENT 'The identified or suspected root cause of the loss or gain event, used for loss control programs and corrective action planning. [ENUM-REF-CANDIDATE: equipment_malfunction|meter_calibration_drift|temperature_variation|pressure_variation|human_error|sampling_error|calculation_error|theft|unknown|under_investigation — 10 candidates stripped; promote to reference product]',
    `temperature_observed_f` DECIMAL(18,2) COMMENT 'The observed temperature in Fahrenheit at the time of measurement, used for volume correction calculations.',
    `volume_variance_bbl` DECIMAL(18,2) COMMENT 'The volume variance in barrels (positive for gain, negative for loss). Used for crude oil and liquid petroleum products.',
    `volume_variance_mcf` DECIMAL(18,2) COMMENT 'The volume variance in thousand cubic feet for natural gas products (positive for gain, negative for loss).',
    `volume_variance_mt` DECIMAL(18,2) COMMENT 'The volume variance in metric tons (positive for gain, negative for loss). Used for LNG, LPG, and petrochemicals where mass measurement is standard.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this loss or gain record.',
    CONSTRAINT pk_loss_gain PRIMARY KEY(`loss_gain_id`)
) COMMENT 'Tracks volume losses and gains (L&G) in petroleum product handling — pipeline interface losses, evaporation losses, meter inaccuracies, tank breathing losses, and measurement discrepancies. Captures loss/gain type, product grade, facility, volume variance (bbl or MT), percentage variance, root cause classification, investigation status, and accounting period. Used for loss control programs, custody transfer reconciliation, and regulatory reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`regulatory_approval` (
    `regulatory_approval_id` BIGINT COMMENT 'Primary key for regulatory_approval',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Regulatory approval costs (application fees, consulting, testing) are charged to product management or compliance cost centers for budget tracking and cost recovery in joint ventures.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Approval fees and compliance costs post to specific GL accounts for regulatory expense tracking, capitalization decisions (if product development), and audit trail requirements.',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the petroleum product (crude oil grade, refined product, LNG, LPG, NGL, petrochemical) that is subject to this regulatory approval.',
    `applicable_market` STRING COMMENT 'Specific market, region, or trade zone where the product may be sold or distributed under this approval (e.g., California RFG market, EU marine fuel market, Asia-Pacific LNG market).',
    `application_date` DATE COMMENT 'Date on which the application for this regulatory approval was submitted to the regulatory authority.',
    `application_reference_number` STRING COMMENT 'Internal or regulatory authority reference number assigned to the approval application for tracking purposes.',
    `approval_conditions` STRING COMMENT 'Specific conditions, restrictions, or requirements imposed by the regulatory authority as part of the approval (e.g., maximum sulfur content, required labeling, geographic restrictions, volume limits, reporting obligations).',
    `approval_fee_amount` DECIMAL(18,2) COMMENT 'Total fee paid to the regulatory authority for the approval, registration, or certification. Includes application fees, annual fees, and renewal fees.',
    `approval_fee_currency` STRING COMMENT 'Currency in which the approval fee was paid, using ISO 4217 three-letter currency code (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `approval_number` STRING COMMENT 'Official approval, registration, or certification number issued by the regulatory authority. This is the externally-known unique identifier for the approval (e.g., EPA registration number, REACH registration number, IMO certification number).',
    `approval_scope` STRING COMMENT 'Scope of the approval defining what activities or operations are authorized (e.g., production, import, export, distribution, sale, marine transport, pipeline transport, storage).',
    `approval_status` STRING COMMENT 'Current lifecycle status of the regulatory approval. Indicates whether the approval is active and valid, pending initial review, expired and requiring renewal, suspended by authority, or revoked. [ENUM-REF-CANDIDATE: active|pending|expired|suspended|revoked|under_review|renewal_in_progress — 7 candidates stripped; promote to reference product]',
    `approval_type` STRING COMMENT 'Type of regulatory approval or certification. Includes EPA fuel registration (RFG, CARB), EU Fuel Quality Directive compliance, IMO 2020 VLSFO compliance, REACH chemical registration, and country-specific import/export product approvals. [ENUM-REF-CANDIDATE: epa_fuel_registration|carb_certification|eu_fuel_quality_directive|imo_vlsfo_compliance|reach_registration|import_license|export_license|product_certification|safety_data_sheet_approval|transport_classification — 10 candidates stripped; promote to reference product]',
    `audit_trail` STRING COMMENT 'Summary of key audit events, inspections, or regulatory reviews related to this approval. Captures history of compliance verification activities.',
    `certificate_number` STRING COMMENT 'Certificate or test report number issued by the certification body as evidence of conformity. Distinct from the regulatory approval number.',
    `certification_body` STRING COMMENT 'Name of the independent third-party certification or testing organization that performed the conformity assessment or testing required for the approval (e.g., Lloyds Register, Bureau Veritas, SGS, Intertek).',
    `compliance_notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to maintaining compliance with this approval (e.g., upcoming regulatory changes, audit findings, corrective actions).',
    `contact_email` STRING COMMENT 'Email address of the contact person responsible for this regulatory approval.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person` STRING COMMENT 'Name of the individual within the organization who is the primary point of contact for this regulatory approval and liaison with the regulatory authority.',
    `contact_phone` STRING COMMENT 'Phone number of the contact person responsible for this regulatory approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this regulatory approval record was first created in the system.',
    `document_repository_link` STRING COMMENT 'URL or file path to the document management system location where the approval certificate, application documents, and supporting evidence are stored.',
    `effective_date` DATE COMMENT 'Date on which the regulatory approval becomes valid and the product may legally be marketed, sold, or transported under this approval.',
    `expiration_date` DATE COMMENT 'Date on which the regulatory approval expires and is no longer valid. Null if the approval has no expiration (perpetual approval) or if expiration is event-driven rather than date-driven.',
    `issue_date` DATE COMMENT 'Date on which the regulatory authority officially issued or granted the approval.',
    `jurisdiction` STRING COMMENT 'Geographic or political jurisdiction where this approval is valid. May be a country (ISO 3-letter code), state/province, regional bloc (e.g., EU), or international (e.g., IMO global standards).',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this regulatory approval record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this regulatory approval record was last modified in the system.',
    `last_renewal_date` DATE COMMENT 'Date of the most recent renewal of this approval. Null if the approval has never been renewed.',
    `product_specification_reference` STRING COMMENT 'Reference to the product quality specification or technical standard that the product must meet to maintain this approval (e.g., ASTM D975, EN 590, ISO 8217). Links to the quality spec that was certified.',
    `regulatory_authority` STRING COMMENT 'Name of the government agency, regulatory body, or certification authority that issued the approval (e.g., EPA, CARB, ECHA, IMO, national ministry of energy, customs authority).',
    `regulatory_citation` STRING COMMENT 'Legal citation or reference to the specific regulation, directive, standard, or law under which this approval was granted (e.g., 40 CFR Part 80, EU Directive 2009/30/EC, IMO MARPOL Annex VI Regulation 14).',
    `renewal_due_date` DATE COMMENT 'Date by which the renewal application must be submitted to the regulatory authority to maintain continuous approval status. Null if renewal is not required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this approval requires periodic renewal (True) or is a one-time perpetual approval (False).',
    `responsible_party` STRING COMMENT 'Name of the legal entity or business unit within the organization that holds responsibility for maintaining this approval and ensuring ongoing compliance.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this regulatory approval record in the system.',
    CONSTRAINT pk_regulatory_approval PRIMARY KEY(`regulatory_approval_id`)
) COMMENT 'Manages regulatory approvals, registrations, and certifications required for petroleum products in specific markets — EPA fuel registration (RFG, CARB), EU fuel quality directive compliance, IMO 2020 VLSFO compliance, REACH chemical registration, and country-specific import/export product approvals. Captures approval authority, approval number, effective date, expiry date, applicable market/jurisdiction, and renewal status.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`lifecycle_status` (
    `lifecycle_status_id` BIGINT COMMENT 'Primary key for lifecycle_status',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Product lifecycle transitions (introduction, phase-out, discontinuation) require management approval for inventory disposition, customer notification, and contract impact assessment. Critical for chan',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key reference to the petroleum product whose lifecycle status is being tracked. Links to the master product catalog.',
    `approval_date` DATE COMMENT 'Date when the lifecycle status change was formally approved by the designated authority. May precede the effective date to allow for implementation planning and stakeholder notification.',
    `approval_reference_number` STRING COMMENT 'Unique reference number or document identifier for the approval decision. Links to Authorization for Expenditure (AFE), Management of Change (MOC) request, or regulatory filing number for traceability.',
    `approving_authority` STRING COMMENT 'Name or title of the executive, committee, or regulatory body that authorized the lifecycle status change. Typically includes VP of Refining, Product Management Director, or Regulatory Affairs for compliance-driven changes.',
    `contract_impact_assessment` STRING COMMENT 'Summary of the impact analysis on existing term contracts, offtake agreements, and production sharing agreements (PSA) affected by this lifecycle status change. Identifies contracts requiring amendment, force majeure invocation, or alternative supply arrangements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lifecycle status record was first created in the system. Provides audit trail for data lineage and compliance reporting.',
    `customer_notification_required_flag` BOOLEAN COMMENT 'Indicates whether contractual or regulatory obligations require formal notification to customers and offtake agreement partners about this status change. True for phase-out, discontinued, and regulatory-withdrawn statuses; typically false for development to pilot transitions.',
    `downstream_system_notification_status` STRING COMMENT 'Status of automated notifications sent to downstream operational systems (ERP, SCADA, trading platforms, supply chain management) about the lifecycle status change. Pending indicates notification queued; notified indicates message sent; acknowledged indicates receiving system confirmed receipt; failed indicates notification error requiring manual intervention.. Valid values are `pending|notified|acknowledged|failed`',
    `effective_date` DATE COMMENT 'Date when this lifecycle status became effective. Marks the official transition date for the product status change and triggers downstream system notifications.',
    `end_date` DATE COMMENT 'Date when this lifecycle status ended and transitioned to a new status. Null for the current active status record. Used for historical status tracking and audit trail.',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated financial impact of the lifecycle status change in USD, including revenue loss from discontinued sales, inventory write-down costs, contract penalties, and transition costs. Used for EBITDA forecasting and management reporting. Negative values indicate costs or losses.',
    `hse_impact_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle status change has health, safety, or environmental implications requiring HSE review and mitigation planning. True for regulatory-withdrawn status or when discontinuation involves hazardous material handling.',
    `hse_review_reference` STRING COMMENT 'Reference number for the HSE impact assessment or Management of Change (MOC) review conducted for this lifecycle status change. Links to HSE management system records for audit and compliance verification.',
    `inventory_disposition_plan` STRING COMMENT 'Description of the strategy for managing existing inventory when product status transitions to phase-out or discontinued. May include sell-through timelines, blending into other products, disposal methods, or transfer to other markets. Critical for OPEX planning and environmental compliance.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or automated process that last updated this lifecycle status record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this lifecycle status record. Used for data freshness monitoring and audit trail completeness.',
    `lifecycle_status_status` STRING COMMENT 'Current lifecycle stage of the petroleum product. Development indicates product formulation and testing phase; pilot indicates limited market trial; active indicates full commercial availability; phase-out indicates planned discontinuation with existing commitments honored; discontinued indicates no longer available for new orders; regulatory-withdrawn indicates removal from market due to regulatory action or compliance failure.. Valid values are `development|pilot|active|phase_out|discontinued|regulatory_withdrawn`',
    `market_applicability` STRING COMMENT 'Geographic markets or jurisdictions where this lifecycle status applies. May be global or restricted to specific regions due to regulatory differences, supply chain constraints, or strategic market positioning. Uses ISO 3166-1 alpha-3 country codes or regional identifiers.',
    `notification_lead_time_days` STRING COMMENT 'Number of days advance notice required before the status effective date per contractual terms or regulatory requirements. Typically 30-180 days for phase-out or discontinuation to allow customer planning and inventory management.',
    `notification_timestamp` TIMESTAMP COMMENT 'Timestamp when downstream system notifications were successfully transmitted. Used for audit trail and to verify compliance with notification lead time requirements.',
    `production_cutoff_date` DATE COMMENT 'Date when refining or manufacturing operations will cease production of this petroleum product. Applies to phase-out and discontinued statuses. Used for refinery scheduling, feedstock planning, and capacity reallocation decisions.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or government agency that governs this product lifecycle status change. Examples include EPA for environmental compliance, FERC for natural gas products, BSEE for offshore production, or state-level environmental agencies.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or docket identifier for the regulatory filing associated with this status change. Links to EPA submissions, FERC tariff amendments, or state agency notifications for compliance tracking.',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle status change requires formal filing or notification to regulatory authorities such as EPA, FERC, BSEE, or state environmental agencies. True for regulatory-withdrawn status and for discontinuation of products with environmental permits.',
    `sales_cutoff_date` DATE COMMENT 'Date after which no new sales orders or term contracts will be accepted for this petroleum product. Typically follows production cutoff date to allow sell-through of remaining inventory. Critical for sales force guidance and customer relationship management.',
    `status_change_notes` STRING COMMENT 'Additional free-text notes and context about the lifecycle status change, including stakeholder communications, lessons learned, or special handling instructions. Supports knowledge management and future decision-making.',
    `transition_reason_code` STRING COMMENT 'Standardized code indicating the primary business reason for the lifecycle status change. Market demand indicates customer or market-driven changes; regulatory compliance indicates changes due to environmental or safety regulations; technical obsolescence indicates superseded by newer formulations; strategic portfolio indicates corporate strategy alignment; cost optimization indicates economic viability decisions; safety concern indicates HSE-driven withdrawal.. Valid values are `market_demand|regulatory_compliance|technical_obsolescence|strategic_portfolio|cost_optimization|safety_concern`',
    `transition_reason_description` STRING COMMENT 'Detailed narrative explanation of the business rationale and circumstances that led to the lifecycle status change. Provides context for audit, compliance, and business intelligence purposes.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or automated process that created this lifecycle status record. Used for audit trail and data governance.',
    CONSTRAINT pk_lifecycle_status PRIMARY KEY(`lifecycle_status_id`)
) COMMENT 'Tracks the lifecycle status history of petroleum products through stages — development, pilot, active, phase-out, discontinued, and regulatory-withdrawn. Captures status transition date, reason for change, approving authority, market applicability, and replacement product reference. Enables product portfolio management and ensures downstream systems are notified of product discontinuation or specification changes.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`uom_conversion` (
    `uom_conversion_id` BIGINT COMMENT 'Unique identifier for the unit of measure conversion record. Primary key for the conversion table.',
    `inverse_conversion_id` BIGINT COMMENT 'Reference to the inverse conversion record (to-unit back to from-unit). Null if no explicit inverse record exists or if bidirectional_flag is True.',
    `superseded_by_conversion_uom_conversion_id` BIGINT COMMENT 'Reference to the conversion record that replaces this one when status is superseded. Maintains audit trail of conversion factor changes.',
    `api_gravity_max` DECIMAL(18,2) COMMENT 'Maximum API gravity value for which this conversion factor is valid. Used for density-dependent barrel-to-mass conversions. Null if conversion is not API-gravity-dependent.',
    `api_gravity_min` DECIMAL(18,2) COMMENT 'Minimum API gravity value for which this conversion factor is valid. Used for density-dependent barrel-to-mass conversions. Null if conversion is not API-gravity-dependent.',
    `applicable_region` STRING COMMENT 'Geographic region or jurisdiction where this conversion is applicable (e.g., USA, EUR, GBR, GLOBAL). Some conversions vary by regional standards.',
    `approval_authority` STRING COMMENT 'Role or individual who approved this conversion factor for use (e.g., Chief Petroleum Engineer, VP Production Accounting, Regulatory Compliance Manager).',
    `approval_date` DATE COMMENT 'Date on which this conversion factor was formally approved for use in production systems.',
    `audit_trail_notes` STRING COMMENT 'Free-text notes documenting the rationale for conversion factor changes, approvals, or special handling instructions. Critical for SOX compliance and audit support.',
    `bidirectional_flag` BOOLEAN COMMENT 'Indicates whether the conversion can be applied in both directions (from-to and to-from) using the reciprocal factor. True if bidirectional, False if unidirectional.',
    `business_unit` STRING COMMENT 'Business unit or division that uses this conversion (e.g., Upstream, Downstream, Midstream, Refining, Marketing). Null if enterprise-wide.',
    `calculation_method` STRING COMMENT 'Method used to perform the conversion: direct multiplication by factor, table lookup, formula-based calculation, or correction for temperature/pressure/density.. Valid values are `direct_factor|table_lookup|formula|temperature_corrected|pressure_corrected|density_adjusted`',
    `conversion_code` STRING COMMENT 'Business identifier code for the conversion rule, used for external reference and system integration.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `conversion_factor` DECIMAL(18,2) COMMENT 'Numeric multiplier used to convert from the source unit to the target unit. Precision to 8 decimal places to support accurate petroleum volume and energy calculations.',
    `conversion_name` STRING COMMENT 'Human-readable name describing the conversion (e.g., Barrels to Metric Tons - WTI Crude, MCF to BOE - Natural Gas).',
    `conversion_status` STRING COMMENT 'Current lifecycle status of the conversion record. Active conversions are used in production calculations; superseded conversions are retained for historical audit.. Valid values are `active|inactive|pending|superseded|deprecated`',
    `conversion_type` STRING COMMENT 'Category of physical measurement being converted (volume, mass, energy, temperature, pressure, density).. Valid values are `volume|mass|energy|temperature|pressure|density`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this conversion record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which this conversion factor becomes valid and should be used in calculations. Critical for historical accuracy in production accounting and revenue reporting.',
    `expiration_date` DATE COMMENT 'Date after which this conversion factor is no longer valid. Null if the conversion remains active indefinitely.',
    `from_unit` STRING COMMENT 'Source unit of measure being converted from (e.g., BBL, MCF, MT, GAL, MMCF, MMBTU, TONNES).. Valid values are `^[A-Z]{1,10}$`',
    `governing_standard` STRING COMMENT 'Industry standard or specification that defines this conversion methodology (e.g., API MPMS Ch. 11.1, ASTM D1250, ISO 91-1, GPA 2145).',
    `last_modified_by` STRING COMMENT 'User ID or name of the individual who last modified this conversion record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this conversion record was last updated.',
    `precision_decimal_places` STRING COMMENT 'Number of decimal places to which converted values should be rounded for reporting and financial calculations.',
    `product_type` STRING COMMENT 'Petroleum product type or grade this conversion applies to (e.g., WTI Crude, Brent Crude, Natural Gas, LNG, Diesel, Gasoline). Product-specific conversions account for density and API gravity variations.',
    `reference_pressure_kpa` DECIMAL(18,2) COMMENT 'Standard reference pressure in kilopascals at which the conversion factor is defined. Critical for gas volume conversions (e.g., standard cubic feet to actual cubic feet).',
    `reference_temperature_c` DECIMAL(18,2) COMMENT 'Standard reference temperature in Celsius at which the conversion factor is defined (typically 15°C or 60°F equivalent). Used for temperature-corrected volume conversions per ASTM D1250.',
    `regulatory_authority` STRING COMMENT 'Regulatory body or authority that mandates this conversion (e.g., SEC, BSEE, EPA, FERC). Null if not regulatory-driven.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this conversion is mandated by regulatory or compliance requirements (e.g., SEC reserves reporting, BSEE production reporting). True if regulatory-mandated.',
    `rounding_method` STRING COMMENT 'Rounding methodology to apply when converting values (e.g., round half up, round down, truncate). Critical for consistent financial and volumetric reporting.. Valid values are `round_half_up|round_half_down|round_up|round_down|truncate`',
    `source_system` STRING COMMENT 'Operational system or reference source from which this conversion was derived (e.g., SAP MM, Avocet Production, API MPMS Tables, Manual Entry).',
    `standard_version` STRING COMMENT 'Version or edition of the governing standard (e.g., 2004 Edition, Rev 2, Amendment 1).',
    `to_unit` STRING COMMENT 'Target unit of measure being converted to (e.g., MT, BOE, BBL, MMBTU, TONNES, MCF).. Valid values are `^[A-Z]{1,10}$`',
    `usage_context` STRING COMMENT 'Business process or system context where this conversion is applied (e.g., Production Accounting, Revenue Distribution, Logistics Planning, Financial Reporting, Regulatory Filing).',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this conversion record.',
    CONSTRAINT pk_uom_conversion PRIMARY KEY(`uom_conversion_id`)
) COMMENT 'Enterprise reference table for unit-of-measure conversion factors critical to petroleum volume and energy accounting. Covers barrels-to-metric-tons (product-specific, using API gravity or density), MCF-to-BOE, MMBtu-to-tonnes (LNG), gallons-to-barrels (NGL), and temperature/pressure correction factors (ASTM D1250 / API MPMS Ch. 11). Each conversion record specifies from-unit, to-unit, product type or API gravity range, conversion factor, effective date, and governing standard. Used enterprise-wide by production accounting, revenue, logistics, and finance for consistent volumetric and energy reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`substitution` (
    `substitution_id` BIGINT COMMENT 'Primary key for substitution',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Product substitutions require technical and commercial approval for quality equivalence, pricing adjustment, and customer acceptance. Essential for supply disruption response, contract flexibility, an',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the primary petroleum product that may be substituted. Links to the petroleum_product master data.',
    `substitution_substitute_product_petroleum_product_id` BIGINT COMMENT 'Reference to the substitute petroleum product that can replace the primary product. Links to the petroleum_product master data.',
    `applicable_market` STRING COMMENT 'Geographic markets, regions, or jurisdictions where this substitution is permitted, using three-letter ISO country codes or regional identifiers (e.g., USA, EUR, MEA, APAC).',
    `approval_authority` STRING COMMENT 'Name or role of the business authority, technical committee, or regulatory body that approved this substitution relationship (e.g., Chief Commercial Officer, Product Quality Committee, Regional Supply Chain Director).',
    `approval_date` DATE COMMENT 'Date on which the substitution relationship was formally approved by the designated authority.',
    `approval_reference_number` STRING COMMENT 'Reference number or document identifier for the formal approval decision, linking to authorization for expenditure (AFE), management of change (MOC), or technical review documentation.',
    `conditions` STRING COMMENT 'Specific technical, operational, or regulatory conditions that must be met for the substitution to be valid, including quality adjustments, blending requirements, or customer approval prerequisites.',
    `contract_reference` STRING COMMENT 'Reference to specific contracts, term agreements, or production sharing agreements (PSA) that govern or permit this substitution relationship.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this substitution relationship record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `customer_approval_required_flag` BOOLEAN COMMENT 'Indicates whether explicit customer or counterparty approval is required before executing this substitution in a commercial transaction or delivery.',
    `effective_date` DATE COMMENT 'Date from which the substitution relationship becomes valid and can be used in supply chain planning, commercial operations, and customer fulfillment.',
    `expiration_date` DATE COMMENT 'Date on which the substitution relationship expires or is no longer valid. Null indicates an open-ended substitution relationship.',
    `frequency` STRING COMMENT 'Permitted frequency or pattern for using this substitution (unrestricted use, occasional use, emergency situations only, one-time authorization, or seasonal availability).. Valid values are `unrestricted|occasional|emergency_only|one_time|seasonal`',
    `hse_impact_assessment` STRING COMMENT 'Summary of health, safety, and environmental considerations or impact assessment results for this substitution, including any changes to hazard classification, handling requirements, or emissions profiles.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this substitution relationship record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this substitution relationship record was last modified in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `notes` STRING COMMENT 'Additional free-text notes, operational guidance, or special instructions related to this substitution relationship for use by supply chain planners and commercial teams.',
    `price_adjustment_method` STRING COMMENT 'Method used to calculate pricing adjustments when the substitute product is used instead of the primary product (no adjustment, fixed differential, percentage adjustment, market index-based, or case-by-case negotiation).. Valid values are `none|fixed_differential|percentage_adjustment|market_index|negotiated`',
    `price_differential_amount` DECIMAL(18,2) COMMENT 'Fixed price differential amount applied when the substitute product is used, expressed in the pricing currency. Positive values indicate premium, negative values indicate discount.',
    `price_differential_percentage` DECIMAL(18,2) COMMENT 'Percentage-based price adjustment applied when the substitute product is used. Expressed as a decimal (e.g., 0.0250 for 2.5% premium or -0.0150 for 1.5% discount).',
    `pricing_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the price differential amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `quality_adjustment_description` STRING COMMENT 'Detailed description of the quality adjustments, blending ratios, additives, or treatment processes required to make the substitute product meet the specifications of the primary product.',
    `quality_adjustment_required_flag` BOOLEAN COMMENT 'Indicates whether quality adjustments, blending, or treatment are required when substituting the primary product with the substitute product.',
    `regulatory_compliance_notes` STRING COMMENT 'Documentation of regulatory considerations, compliance requirements, or restrictions that apply to this substitution (e.g., IMO 2020 sulfur limits, EPA fuel category restrictions, FERC tariff provisions).',
    `substitution_code` STRING COMMENT 'Unique business identifier for the substitution relationship, used in supply chain and commercial systems for quick reference.. Valid values are `^[A-Z0-9]{6,12}$`',
    `substitution_status` STRING COMMENT 'Current lifecycle status of the substitution relationship indicating whether it is currently approved and available for use.. Valid values are `active|inactive|pending_approval|suspended|expired`',
    `substitution_type` STRING COMMENT 'Classification of the substitution relationship indicating the nature and scope of substitutability (full replacement, partial replacement, conditional use, emergency only, or planned transition).. Valid values are `full|partial|conditional|emergency|planned`',
    `supply_disruption_priority` STRING COMMENT 'Priority ranking for this substitution option during supply disruptions or shortages. Lower numbers indicate higher priority (1 = first choice, 2 = second choice, etc.).',
    `technical_review_required_flag` BOOLEAN COMMENT 'Indicates whether a technical review or engineering assessment is required each time this substitution is executed, typically for complex or high-risk substitutions.',
    `use_case_description` STRING COMMENT 'Detailed description of the specific business scenarios, market conditions, or operational contexts in which this substitution is permitted (e.g., Jet A-1 substituting for Jet A in European markets, VLSFO substituting for HSFO post-IMO 2020 compliance).',
    `volume_limit_boe` DECIMAL(18,2) COMMENT 'Maximum volume of the substitute product that can be used in place of the primary product, expressed in barrels of oil equivalent (BOE). Null indicates no volume restriction.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this substitution relationship record in the system.',
    CONSTRAINT pk_substitution PRIMARY KEY(`substitution_id`)
) COMMENT 'Defines approved product substitution relationships — identifying which products can substitute for another in specific use cases (e.g., Jet A-1 substituting for Jet A in certain markets, VLSFO substituting for HSFO post-IMO 2020, or equivalent NGL fractions). Captures primary product, substitute product, substitution conditions, approval authority, quality adjustment required, and effective date range. Used by supply chain and commercial teams during supply disruptions.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`handling_requirement` (
    `handling_requirement_id` BIGINT COMMENT 'Primary key for handling_requirement',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the petroleum product for which these handling requirements apply. Links to the petroleum_product master data.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Handling requirements require HSE technical author for temperature control, vapor recovery, H2S protocols, and NORM handling procedures. Critical for operational safety, regulatory compliance, and eme',
    `coating_lining_requirement` STRING COMMENT 'Description of internal coating or lining requirements for tanks, vessels, and pipelines to prevent corrosion, contamination, or product degradation. Includes epoxy coatings, phenolic linings, or specialized polymer systems.',
    `container_material_specification` STRING COMMENT 'Specification of acceptable container and piping materials for storage and transportation, such as carbon steel, stainless steel, or specialized alloys. Critical for preventing corrosion and material compatibility issues with sour crude, high-TAN crudes, and corrosive petrochemicals.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this handling requirement record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_date` DATE COMMENT 'Date when this handling requirement becomes effective and must be implemented in operations. Used for managing regulatory changes and operational transitions.',
    `emergency_response_procedure` STRING COMMENT 'Summary of emergency response procedures required for spills, leaks, fires, or exposure incidents involving this product. References detailed emergency response plans and material safety data sheets.',
    `expiration_date` DATE COMMENT 'Date when this handling requirement expires or is superseded by updated requirements. Null for requirements with indefinite validity.',
    `fire_protection_requirement` STRING COMMENT 'Description of fire protection systems and equipment required for storage and handling areas, including foam systems, water deluge, dry chemical systems, and fire detection equipment.',
    `h2s_content_threshold_ppm` DECIMAL(18,2) COMMENT 'Maximum allowable concentration of hydrogen sulfide in parts per million. Products exceeding this threshold require special Health Safety and Environment (HSE) handling protocols including gas detection, respiratory protection, and emergency response procedures.',
    `h2s_safety_protocol` STRING COMMENT 'Detailed description of safety protocols required when handling products with hydrogen sulfide content, including personal protective equipment (PPE), gas monitoring, confined space entry procedures, and emergency response measures.',
    `incompatible_products` STRING COMMENT 'Comma-separated list or description of petroleum products that are chemically incompatible and must never be mixed or stored in adjacent tanks. Used to prevent hazardous reactions, product degradation, or specification violations.',
    `inert_gas_blanketing_required_flag` BOOLEAN COMMENT 'Indicates whether inert gas blanketing (typically nitrogen) is required to prevent oxidation, contamination, or explosive atmosphere formation in storage tanks and vessels.',
    `inert_gas_type` STRING COMMENT 'Type of inert gas required for blanketing operations. Nitrogen is most common, but carbon dioxide or argon may be specified for certain petrochemical applications.. Valid values are `nitrogen|carbon_dioxide|argon|not_applicable`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this handling requirement record was last modified. Used for change tracking and audit trail purposes.',
    `last_review_date` DATE COMMENT 'Date when this handling requirement was last reviewed and validated by subject matter experts or regulatory compliance personnel.',
    `loading_rate_max_m3_per_hour` DECIMAL(18,2) COMMENT 'Maximum allowable loading or transfer rate in cubic meters per hour to prevent static electricity buildup, pressure surges, or product degradation during transfer operations.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of this handling requirement to ensure continued compliance and operational accuracy.',
    `norm_handling_protocol` STRING COMMENT 'Detailed description of NORM handling protocols including radiation monitoring, worker exposure limits, personal protective equipment, waste disposal procedures, and regulatory reporting requirements.',
    `norm_handling_required_flag` BOOLEAN COMMENT 'Indicates whether special Naturally Occurring Radioactive Material (NORM) handling protocols are required. Certain crude oils and produced water contain elevated levels of radioactive isotopes requiring specialized handling, disposal, and worker protection measures.',
    `personal_protective_equipment` STRING COMMENT 'Detailed description of personal protective equipment required for personnel handling this product, including respiratory protection, chemical-resistant gloves, face shields, flame-resistant clothing, and safety footwear.',
    `pressure_control_method` STRING COMMENT 'Description of the method or equipment required to maintain pressure within specified range, such as pressure relief valves, vapor recovery systems, or refrigeration.',
    `pressure_max_kpa` DECIMAL(18,2) COMMENT 'Maximum allowable pressure in kilopascals for safe containment. Exceeding this pressure may compromise vessel integrity and create safety hazards.',
    `pressure_min_kpa` DECIMAL(18,2) COMMENT 'Minimum pressure in kilopascals required for safe storage and transportation. Critical for pressurized products like Liquefied Petroleum Gas (LPG) and Liquefied Natural Gas (LNG).',
    `regulatory_authority` STRING COMMENT 'Name of the primary regulatory authority or governing body that mandates or oversees this handling requirement, such as Environmental Protection Agency (EPA), Occupational Safety and Health Administration (OSHA), Pipeline and Hazardous Materials Safety Administration (PHMSA), or Bureau of Safety and Environmental Enforcement (BSEE).',
    `regulatory_citation` STRING COMMENT 'Specific regulatory citation, code section, or standard reference that mandates this handling requirement, enabling traceability to legal and regulatory obligations.',
    `requirement_category` STRING COMMENT 'High-level classification of the handling requirement type to enable filtering and grouping of similar requirements across the product portfolio. [ENUM-REF-CANDIDATE: temperature_control|pressure_control|inert_gas_blanketing|segregation|hse_safety|compatibility|norm_handling|vapor_control — 8 candidates stripped; promote to reference product]',
    `requirement_code` STRING COMMENT 'Unique business code identifying this specific handling requirement within the product catalog. Used for operational reference and system integration.. Valid values are `^[A-Z0-9]{4,20}$`',
    `requirement_name` STRING COMMENT 'Descriptive name of the handling requirement for business user identification and reporting purposes.',
    `requirement_status` STRING COMMENT 'Current lifecycle status of the handling requirement indicating whether it is currently in force, has been superseded by newer requirements, or is under regulatory review.. Valid values are `active|inactive|superseded|under_review|pending_approval`',
    `requirement_type` STRING COMMENT 'Indicates whether the handling requirement is mandatory for regulatory compliance, recommended as best practice, conditional based on circumstances, or prohibited.. Valid values are `mandatory|recommended|conditional|prohibited`',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory reviews of this handling requirement to ensure continued accuracy, regulatory compliance, and operational relevance.',
    `segregation_requirement` STRING COMMENT 'Detailed description of segregation requirements specifying which products or product families must be kept separate during storage, transportation, and handling to prevent cross-contamination or hazardous reactions. Examples include aviation gasoline (AVGAS) from motor gasoline (MOGAS), or sour crude from sweet crude.',
    `spill_containment_requirement` STRING COMMENT 'Description of spill containment and secondary containment requirements for storage and handling areas, including berm capacity, drainage systems, and spill response equipment specifications.',
    `static_electricity_precautions` STRING COMMENT 'Description of static electricity control measures required during product transfer and handling operations, including bonding and grounding requirements, flow rate limitations, and equipment specifications to prevent ignition hazards.',
    `temperature_control_method` STRING COMMENT 'Description of the method or equipment required to maintain temperature within specified range, such as steam coils, heat tracing, insulation, or refrigeration systems.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature in degrees Celsius allowed for safe storage and handling. Exceeding this temperature may cause product degradation, vapor pressure issues, or safety hazards.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature in degrees Celsius required for safe storage and handling of the petroleum product. Critical for products like heated crude oil and high pour-point fuels.',
    `transportation_mode_restriction` STRING COMMENT 'Description of restrictions or requirements for transportation modes (pipeline, tanker truck, rail car, marine vessel, barge) based on product characteristics, regulatory requirements, or safety considerations.',
    `unloading_rate_max_m3_per_hour` DECIMAL(18,2) COMMENT 'Maximum allowable unloading or discharge rate in cubic meters per hour to ensure safe product transfer and prevent equipment damage or safety hazards.',
    `vapor_control_method` STRING COMMENT 'Description of vapor control or recovery method required, such as vapor recovery units, thermal oxidizers, flares, or closed-loop systems to manage volatile organic compound emissions.',
    `vapor_recovery_required_flag` BOOLEAN COMMENT 'Indicates whether vapor recovery systems are required during loading, unloading, and storage operations to capture volatile organic compounds (VOCs) and prevent atmospheric emissions. Mandatory for many refined products under EPA regulations.',
    CONSTRAINT pk_handling_requirement PRIMARY KEY(`handling_requirement_id`)
) COMMENT 'Captures special handling, storage, and transportation requirements for petroleum products — including temperature maintenance (heated crude, LNG cryogenic), pressure requirements (LPG pressurized), inert gas blanketing, segregation requirements (avgas from MOGAS), NORM handling protocols, H2S safety requirements, and compatibility restrictions. Links to petroleum_product and is used by logistics, terminal operations, and HSE for safe product handling.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`emission_factor` (
    `emission_factor_id` BIGINT COMMENT 'Primary key for emission_factor',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Emission factors require environmental data steward for GHG reporting, carbon intensity calculation, and regulatory citation maintenance. Essential for EPA/BSEE reporting, carbon tax compliance, and s',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the petroleum product for which this emission factor applies. Links to the petroleum product master catalog.',
    `applicable_regulation` STRING COMMENT 'Regulatory framework or program for which this emission factor is applicable. Examples: EPA GHG Reporting Rule (40 CFR Part 98), EU ETS, California LCFS, UK ETS, IPCC National Inventory Guidelines, SEC Climate Disclosure.',
    `approval_authority` STRING COMMENT 'Regulatory body, standards organization, or internal authority that approved or published this emission factor. Examples: EPA, IPCC, EU Commission, California Air Resources Board (CARB), internal HSE department.',
    `approval_date` DATE COMMENT 'Date on which the emission factor was officially approved or published by the approval authority.',
    `control_efficiency_percent` DECIMAL(18,2) COMMENT 'Percentage reduction in emissions achieved by the control technology. Used to calculate net emissions after control. Example: 90% control efficiency means 90% of pollutant is removed.',
    `control_technology` STRING COMMENT 'Emission control or abatement technology assumed in the emission factor. Examples: none, selective catalytic reduction (SCR), flue gas desulfurization (FGD), electrostatic precipitator (ESP), carbon capture and storage (CCS), vapor recovery unit (VRU).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this emission factor record was first created in the data system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_source` STRING COMMENT 'Authoritative source or publication from which the emission factor was obtained. Examples: EPA AP-42, IPCC 2006 Guidelines, GREET Model 2023, API Compendium, DEFRA Conversion Factors, EIA.',
    `data_source_version` STRING COMMENT 'Version or publication year of the data source. Ensures traceability and allows for updates when new emission factor datasets are released.',
    `effective_date` DATE COMMENT 'Date from which this emission factor becomes valid and applicable for emissions calculations and regulatory reporting.',
    `emission_category` STRING COMMENT 'High-level classification of the emission type: greenhouse gas (GHG), criteria pollutant (NOx, SOx), volatile organic compound (VOC), particulate matter, hazardous air pollutant (HAP), or lifecycle assessment.. Valid values are `ghg|criteria_pollutant|voc|particulate_matter|hazardous_air_pollutant|lifecycle`',
    `emission_source_type` STRING COMMENT 'Type of emission source activity: combustion, flaring, venting, fugitive emissions, process emissions, transportation, storage, or full lifecycle assessment. [ENUM-REF-CANDIDATE: combustion|flaring|venting|fugitive|process|transportation|storage|lifecycle — 8 candidates stripped; promote to reference product]',
    `expiration_date` DATE COMMENT 'Date after which this emission factor is no longer valid. Null if the factor remains valid indefinitely or until superseded.',
    `factor_code` STRING COMMENT 'Unique business code identifying the emission factor. Used for external reference and regulatory reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `factor_name` STRING COMMENT 'Descriptive name of the emission factor, including pollutant type and product context.',
    `factor_status` STRING COMMENT 'Current lifecycle status of the emission factor. Active factors are approved for use in regulatory reporting. Superseded factors have been replaced by newer versions. Deprecated factors are no longer valid.. Valid values are `active|superseded|deprecated|draft|under_review`',
    `factor_unit` STRING COMMENT 'Unit of measure for the emission factor value. Common units include kg CO2/bbl, kg CO2/GJ, g CO2e/MJ, kg NOx/tonne, lb SO2/MMBtu.',
    `factor_value` DECIMAL(18,2) COMMENT 'Numeric value of the emission factor. Represents the quantity of pollutant emitted per unit of product activity (e.g., kg CO2 per barrel, g NOx per GJ).',
    `fuel_quality_adjustment` STRING COMMENT 'Fuel quality characteristic that may affect the emission factor. Examples: low sulfur, ultra-low sulfur, high sulfur, sour crude, sweet crude, heavy crude, light crude. Used to differentiate emission factors based on product specifications. [ENUM-REF-CANDIDATE: none|low_sulfur|ultra_low_sulfur|high_sulfur|sour|sweet|heavy|light — 8 candidates stripped; promote to reference product]',
    `geographic_scope` STRING COMMENT 'Geographic region or country for which this emission factor is applicable. Use ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, CAN) or regional codes (e.g., EUR for Europe-wide factors).. Valid values are `^[A-Z]{3}$`',
    `gwp_version` STRING COMMENT 'IPCC Assessment Report version used for GWP calculation when converting non-CO2 greenhouse gases to CO2 equivalents. AR4 (Fourth Assessment Report), AR5 (Fifth Assessment Report), AR6 (Sixth Assessment Report).. Valid values are `ar4|ar5|ar6`',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this emission factor record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this emission factor record was last modified in the data system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_review_date` DATE COMMENT 'Date of the most recent internal review or validation of this emission factor. Used to ensure factors remain current and accurate.',
    `lifecycle_stage` STRING COMMENT 'Stage in the product lifecycle for which this emission factor applies. Used for lifecycle carbon intensity calculations. Includes extraction, production, processing, refining, transportation, distribution, combustion, end-use, well-to-tank (WTT), tank-to-wheel (TTW), or well-to-wheel (WTW). [ENUM-REF-CANDIDATE: extraction|production|processing|refining|transportation|distribution|combustion|end_use|well_to_tank|tank_to_wheel|well_to_wheel — 11 candidates stripped; promote to reference product]',
    `measurement_method` STRING COMMENT 'Method used to derive the emission factor: default (from published source), measured (direct stack testing or monitoring), modeled (simulation), calculated (mass balance), or engineering estimate.. Valid values are `default|measured|modeled|calculated|engineering_estimate`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this emission factor. Ensures factors are updated as new scientific data or regulatory requirements emerge.',
    `oxidation_factor` DECIMAL(18,2) COMMENT 'Fraction of carbon in the fuel that is oxidized during combustion. Typically ranges from 0.95 to 1.00. Used to adjust theoretical CO2 emissions based on incomplete combustion.',
    `pollutant_type` STRING COMMENT 'Specific pollutant or greenhouse gas species: carbon dioxide (CO2), methane (CH4), nitrous oxide (N2O), carbon dioxide equivalent (CO2e), nitrogen oxides (NOx), sulfur oxides (SOx), carbon monoxide (CO), particulate matter (PM10, PM2.5), volatile organic compounds (VOC), benzene, hydrogen sulfide (H2S). [ENUM-REF-CANDIDATE: co2|ch4|n2o|co2e|nox|sox|co|pm10|pm2_5|voc|benzene|h2s — 12 candidates stripped; promote to reference product]',
    `regulatory_citation` STRING COMMENT 'Specific regulatory citation or section reference where this emission factor is defined or required. Example: 40 CFR 98 Subpart C Table C-1.',
    `technology_type` STRING COMMENT 'Specific technology or process configuration to which this emission factor applies. Examples: conventional combustion, fluidized bed combustion, gas turbine, reciprocating engine, flare (enclosed/elevated), carbon capture and storage (CCS).',
    `tier_level` STRING COMMENT 'IPCC tier level indicating the methodological complexity and data quality of the emission factor. Tier 1 uses default factors, Tier 2 uses country-specific factors, Tier 3 uses facility-specific measurements and models.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `time_horizon_years` STRING COMMENT 'Time horizon in years over which the GWP is calculated. Typically 20, 100, or 500 years. Most regulatory frameworks use 100-year GWP.',
    `uncertainty_percentage` DECIMAL(18,2) COMMENT 'Estimated uncertainty or confidence interval of the emission factor value, expressed as a percentage. Used for quality assurance and sensitivity analysis in emissions inventories.',
    `usage_notes` STRING COMMENT 'Additional guidance, limitations, or context for applying this emission factor. May include applicability conditions, calculation examples, or references to related factors.',
    `created_by` STRING COMMENT 'User identifier or system account that created this emission factor record in the data system.',
    CONSTRAINT pk_emission_factor PRIMARY KEY(`emission_factor_id`)
) COMMENT 'Reference data for greenhouse gas (GHG) and criteria pollutant emission factors associated with petroleum products — including CO2 emission factors (kg CO2/GJ or kg CO2/bbl), methane emission factors, NOx/SOx factors for combustion, lifecycle carbon intensity (gCO2e/MJ) for fuel regulatory compliance (EU ETS, California LCFS, UK ETS). Captures product type, emission category, factor value, unit, applicable regulation, and data source (EPA AP-42, IPCC, GREET model).';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`tariff_code` (
    `tariff_code_id` BIGINT COMMENT 'Primary key for tariff_code',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key reference to the petroleum product being classified for tariff purposes.',
    `superseded_by_tariff_code_id` BIGINT COMMENT 'Foreign key reference to the newer product_tariff_code record that replaces this classification. Only populated when tariff_status is superseded.',
    `anti_dumping_duty_flag` BOOLEAN COMMENT 'Indicates whether anti-dumping duties are currently in effect for this product from specific origin countries. True if anti-dumping measures apply; false otherwise.',
    `classification_ruling_number` STRING COMMENT 'Official customs ruling or binding tariff information (BTI) reference number issued by the customs authority confirming the tariff classification for this product.',
    `countervailing_duty_flag` BOOLEAN COMMENT 'Indicates whether countervailing duties (to offset foreign subsidies) are currently in effect for this product. True if countervailing measures apply; false otherwise.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code identifying the jurisdiction where this tariff classification applies.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tariff code mapping record was first created in the system.',
    `customs_valuation_method` STRING COMMENT 'Method used to determine the customs value for duty calculation purposes, as defined by WTO Valuation Agreement (e.g., transaction value, computed value).. Valid values are `transaction_value|computed_value|deductive_value|fallback_method`',
    `duty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the duty rate (e.g., USD, EUR, GBP). Applicable for specific duty rates or when duty is expressed in a specific currency.. Valid values are `^[A-Z]{3}$`',
    `duty_rate_percent` DECIMAL(18,2) COMMENT 'Ad valorem duty rate expressed as a percentage of the customs value (CIF or FOB basis). Null if duty is specific (per-unit) rather than ad valorem.',
    `effective_date` DATE COMMENT 'Date on which this tariff classification and associated duty rates become effective for customs purposes.',
    `excise_duty_rate_percent` DECIMAL(18,2) COMMENT 'Excise tax rate applied to petroleum products as a percentage of value or per unit. Common for refined fuels such as gasoline, diesel, and jet fuel.',
    `excise_duty_specific_rate` DECIMAL(18,2) COMMENT 'Specific excise duty rate per unit of measure (e.g., USD per gallon, EUR per liter). Used for volume-based excise taxation of petroleum products.',
    `excise_duty_uom` STRING COMMENT 'Unit of measure for the excise duty specific rate. Only applicable when excise_duty_specific_rate is populated.. Valid values are `barrel|liter|gallon|metric_ton|kilogram`',
    `expiration_date` DATE COMMENT 'Date on which this tariff classification and associated duty rates cease to be valid. Null for open-ended classifications.',
    `hs_code` STRING COMMENT 'Six-digit or extended Harmonized System tariff classification code for international trade. The first six digits are standardized globally; additional digits may be country-specific extensions.. Valid values are `^[0-9]{6,10}$`',
    `import_export_classification` STRING COMMENT 'Indicates whether this tariff code mapping applies to import transactions, export transactions, or both.. Valid values are `import|export|both`',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this tariff code mapping record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tariff code mapping record was last updated in the system.',
    `license_requirement_flag` BOOLEAN COMMENT 'Indicates whether an import or export license is required for this product in the specified jurisdiction. True if licensing is mandatory; false otherwise.',
    `license_type` STRING COMMENT 'Type or category of import/export license required (e.g., automatic license, non-automatic license, strategic goods license). Only applicable when license_requirement_flag is true.',
    `national_tariff_code` STRING COMMENT 'Country-specific tariff schedule code that extends or replaces the HS code for domestic customs purposes. May include additional digits beyond the HS 6-digit base.',
    `notes` STRING COMMENT 'Additional notes, clarifications, or special instructions related to the tariff classification, duty calculation, or compliance requirements for this product-country combination.',
    `origin_requirement` STRING COMMENT 'Rules of origin criteria that must be satisfied to qualify for preferential tariff treatment under the applicable trade agreement (e.g., minimum local content percentage, substantial transformation).',
    `preferential_duty_rate_percent` DECIMAL(18,2) COMMENT 'Reduced duty rate available under a free trade agreement or preferential trade program. Lower than the standard MFN rate when trade agreement conditions are met.',
    `quota_applicable_flag` BOOLEAN COMMENT 'Indicates whether this product is subject to a tariff rate quota (TRQ) in the specified jurisdiction. True if quota limits apply; false otherwise.',
    `quota_uom` STRING COMMENT 'Unit of measure for the quota volume (e.g., barrels, metric tons). Only applicable when quota_applicable_flag is true.. Valid values are `barrel|metric_ton|liter|kilogram|cubic_meter`',
    `quota_volume` DECIMAL(18,2) COMMENT 'Maximum volume or quantity allowed under the tariff rate quota before higher out-of-quota duty rates apply. Only applicable when quota_applicable_flag is true.',
    `regulatory_authority` STRING COMMENT 'Name of the government agency or customs authority responsible for administering this tariff classification (e.g., U.S. Customs and Border Protection, HM Revenue & Customs).',
    `ruling_date` DATE COMMENT 'Date on which the customs classification ruling was issued by the regulatory authority.',
    `sanctioned_country_flag` BOOLEAN COMMENT 'Indicates whether trade of this product with the specified country is subject to economic sanctions or embargoes. True if sanctions apply; false otherwise.',
    `specific_duty_rate` DECIMAL(18,2) COMMENT 'Specific duty rate applied per unit of measure (e.g., USD per barrel, EUR per metric ton). Used when duty is calculated on quantity rather than value.',
    `specific_duty_uom` STRING COMMENT 'Unit of measure for the specific duty rate (e.g., barrel, metric ton, liter). Only applicable when specific_duty_rate is populated.. Valid values are `barrel|metric_ton|liter|kilogram|gallon|cubic_meter`',
    `strategic_goods_classification` STRING COMMENT 'Export control classification for strategic or dual-use petroleum products (e.g., certain petrochemicals). References export control lists such as the Commerce Control List (CCL) or EU Dual-Use Regulation.',
    `tariff_description` STRING COMMENT 'Official description of the tariff classification as published in the customs tariff schedule, providing detailed product categorization.',
    `tariff_status` STRING COMMENT 'Current lifecycle status of the tariff code mapping. Active indicates the classification is currently in force; superseded indicates it has been replaced by a newer classification.. Valid values are `active|suspended|expired|pending|superseded`',
    `trade_agreement_code` STRING COMMENT 'Code identifying the applicable free trade agreement (FTA) or preferential trade arrangement (e.g., USMCA, EU-FTA, ASEAN). Null if most-favored-nation (MFN) rates apply.',
    `vat_rate_percent` DECIMAL(18,2) COMMENT 'Value Added Tax or Goods and Services Tax (GST) rate applicable to the petroleum product in the specified jurisdiction, expressed as a percentage.',
    `created_by` STRING COMMENT 'User identifier or system account that created this tariff code mapping record.',
    CONSTRAINT pk_tariff_code PRIMARY KEY(`tariff_code_id`)
) COMMENT 'Maps petroleum products to applicable tariff and duty codes for international trade — including HS (Harmonized System) 6-digit codes, country-specific import/export tariff schedules, excise duty categories, VAT classifications, and free trade agreement (FTA) preferential rates. Captures product, country/jurisdiction, tariff code, duty rate, effective date, and applicable trade agreement. Used by supply chain, customs, and finance for trade compliance and cost calculation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` (
    `safety_data_sheet_id` BIGINT COMMENT 'Primary key for safety_data_sheet',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the petroleum product or chemical for which this safety data sheet is issued. Links to the product master catalog.',
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
    `petroleum_product_id` BIGINT COMMENT 'Reference to the petroleum product for which the price is recorded. Links to the product master catalog.',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_benchmark. Business justification: Links historical price records to the pricing benchmark used for that transaction. price_history currently has pricing_index as a STRING field containing benchmark names. Adding FK to product_pricing_',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Product pricing is tracked by profit center for revenue recognition, realized margin calculation, and performance attribution in oil-and-gas trading and marketing operations.',
    `api_gravity` DECIMAL(18,2) COMMENT 'The API gravity of the crude oil or petroleum product at the time of pricing, used for quality-based price adjustments.',
    `benchmark_price` DECIMAL(18,2) COMMENT 'The base reference price from the applicable pricing index before any adjustments or differentials are applied. Expressed in the pricing currency per unit of measure.',
    `contract_reference` STRING COMMENT 'Reference to the sales contract, purchase agreement, or term contract under which this price was established or applied.',
    `counterparty_name` STRING COMMENT 'The name of the buyer or seller counterparty involved in the transaction for which this price applies.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` (
    `compatibility_matrix_id` BIGINT COMMENT 'Primary key for compatibility_matrix',
    `petroleum_product_id` BIGINT COMMENT 'Reference to the first product in the compatibility pair. This is the base product being evaluated for compatibility with the secondary product.',
    `superseded_by_matrix_compatibility_matrix_id` BIGINT COMMENT 'Reference to the compatibility matrix record that supersedes this determination. Used to maintain audit trail when compatibility assessments are updated or revised. Null if this is the current active determination.',
    `additive_required_flag` BOOLEAN COMMENT 'Indicates whether a chemical additive or compatibility agent is required to enable safe mixing or contact of conditionally compatible products. True if additive is mandatory, false if not required.',
    `additive_specification` STRING COMMENT 'Specification of the chemical additive required for conditional compatibility, including additive type, dosage rate, injection point, and supplier reference. Empty if no additive is required.',
    `applicable_jurisdiction` STRING COMMENT 'Geographic jurisdiction or market where this compatibility determination applies. Compatibility rules may vary by region due to product specifications, regulatory requirements, or operational practices. Use ISO 3166-1 alpha-3 country codes or regional identifiers.',
    `applicable_pressure_max_kpa` DECIMAL(18,2) COMMENT 'Maximum pressure in kilopascals at which the compatibility rating is valid. Above this pressure, phase behavior or chemical equilibrium may change affecting compatibility.',
    `applicable_pressure_min_kpa` DECIMAL(18,2) COMMENT 'Minimum pressure in kilopascals at which the compatibility rating is valid. Relevant for gas-liquid systems and high vapor pressure products where phase behavior is pressure-dependent.',
    `applicable_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature in degrees Celsius at which the compatibility rating is valid. Above this temperature, compatibility may change due to thermal degradation, vapor pressure effects, or chemical reactions.',
    `applicable_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature in degrees Celsius at which the compatibility rating is valid. Below this temperature, compatibility may change due to phase behavior, viscosity changes, or wax precipitation.',
    `approval_authority` STRING COMMENT 'Name or role of the technical authority who approved this compatibility determination. Typically a senior blending engineer, pipeline operations manager, or technical services director with subject matter expertise.',
    `approval_date` DATE COMMENT 'Date when this compatibility determination was formally approved for operational use.',
    `compatibility_matrix_status` STRING COMMENT 'Current lifecycle status of this compatibility determination. Active indicates approved for operational use. Superseded indicates replaced by newer determination. Under review indicates revalidation in progress. Withdrawn indicates no longer valid. Draft indicates pending approval.. Valid values are `active|superseded|under_review|withdrawn|draft`',
    `compatibility_rating` STRING COMMENT 'Overall compatibility assessment between the product pair. Compatible indicates safe mixing or contact under normal conditions. Conditionally compatible requires specific operational controls. Incompatible indicates products must not be mixed or in contact. Not tested indicates no compatibility data available. Under review indicates testing or evaluation in progress.. Valid values are `compatible|conditionally_compatible|incompatible|not_tested|under_review`',
    `compatibility_type` STRING COMMENT 'The type of compatibility scenario being evaluated: blending (intentional mixing for product formulation), co-mingling (unintentional mixing during operations), sequential batching (pipeline batch sequencing), storage (shared tank compatibility), transportation (shared pipeline or vessel), or material contact (compatibility with seals, gaskets, coatings).. Valid values are `blending|co-mingling|sequential_batching|storage|transportation|material_contact`',
    `contact_duration_limit_hours` DECIMAL(18,2) COMMENT 'Maximum allowable contact time in hours for conditionally compatible products before quality degradation or safety issues may occur. Relevant for sequential batching and temporary co-mingling scenarios. Null if no time limit applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compatibility matrix record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this compatibility determination becomes effective for operational use. May differ from approval date if implementation requires system updates or operational procedure changes.',
    `expiration_date` DATE COMMENT 'Date when this compatibility determination expires and must be reviewed or revalidated. Null if determination has no expiration and remains valid until superseded.',
    `hse_hazard_description` STRING COMMENT 'Detailed description of health, safety, or environmental hazards created by mixing or contact of incompatible products. May include toxic gas generation (e.g., H2S release), exothermic reactions, fire or explosion risk, corrosion acceleration, or environmental contamination potential. Empty if no HSE hazard exists.',
    `hse_hazard_flag` BOOLEAN COMMENT 'Indicates whether mixing or contact of these products creates a health, safety, or environmental hazard beyond the individual product hazards. True if additional HSE risk is created (e.g., toxic gas generation, exothermic reaction, increased flammability), false if no additional hazard.',
    `incompatibility_mechanism` STRING COMMENT 'Technical description of the chemical or physical mechanism causing incompatibility, such as asphaltene precipitation, phase separation, polymerization, corrosion acceleration, emulsion formation, or material degradation. Empty if products are compatible.',
    `interface_disposition` STRING COMMENT 'Recommended disposition method for the interface or contaminated product created during sequential batching. Reblend primary indicates interface can be blended back into primary product. Reblend secondary indicates blending into secondary product. Downgrade indicates sale as lower-grade product. Recycle indicates reprocessing. Waste indicates disposal required.. Valid values are `reblend_primary|reblend_secondary|downgrade|recycle|waste`',
    `interface_volume_estimate_bbl` DECIMAL(18,2) COMMENT 'Estimated volume in barrels of the interface or contaminated product zone created when these products are batched sequentially in a pipeline. Used for operational planning and product disposition decisions.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this compatibility matrix record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compatibility matrix record was last modified in the system.',
    `material_compatibility_rating` STRING COMMENT 'Compatibility assessment for elastomers, seals, gaskets, coatings, and construction materials in contact with the product pair. Compatible indicates no material degradation. Limited compatibility indicates restricted service life or specific material grades required. Incompatible indicates material failure risk. Not applicable for product-to-product compatibility scenarios.. Valid values are `compatible|limited_compatibility|incompatible|not_applicable`',
    `material_type_restriction` STRING COMMENT 'Specification of acceptable or prohibited construction materials, elastomer grades, or coating types when handling this product combination. Examples include Viton seals required, avoid Buna-N, stainless steel 316L minimum, or epoxy coating compatible.',
    `mixing_ratio_constraint` STRING COMMENT 'Allowable mixing ratio range or constraint for conditionally compatible products, expressed as percentage or volumetric ratio (e.g., 10-30% by volume, max 5% secondary product, any ratio). Empty if not applicable or if products are fully incompatible.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review and revalidation of this compatibility determination.',
    `notes` STRING COMMENT 'Additional notes, observations, or operational guidance related to this compatibility determination. May include historical incident references, field experience, vendor recommendations, or special handling instructions.',
    `operational_controls_required` STRING COMMENT 'Description of specific operational controls, procedures, or safeguards required when handling conditionally compatible products. May include temperature control, mixing sequence, additive injection, monitoring requirements, or interface management protocols.',
    `pipeline_batch_sequence_allowed` BOOLEAN COMMENT 'Indicates whether these products may be batched sequentially in a pipeline without intermediate separation or cleaning. True if sequential batching is permitted, false if products must be separated by batch spacer, cleaning pig, or different routing.',
    `quality_impact_description` STRING COMMENT 'Description of the impact on product quality specifications if these products are mixed or in contact. May include effects on API gravity, sulfur content, octane rating, cetane number, color, stability, or other quality parameters. Empty if no quality impact or products are fully compatible.',
    `regulatory_restriction` STRING COMMENT 'Description of any regulatory prohibitions, restrictions, or requirements governing the mixing, co-mingling, or sequential handling of this product pair. May reference EPA fuel blending rules, pipeline tariff restrictions, or jurisdictional product quality mandates.',
    `review_frequency_months` STRING COMMENT 'Required frequency in months for periodic review and revalidation of this compatibility determination. Critical incompatibilities may require annual review, while stable compatible pairs may have longer review cycles.',
    `risk_level` STRING COMMENT 'Risk severity classification if incompatible products are mixed or in contact. Low risk may result in minor quality degradation. Medium risk may cause operational issues or off-spec product. High risk may cause equipment damage or safety hazards. Critical risk may cause catastrophic failure, fire, explosion, or environmental release.. Valid values are `low|medium|high|critical`',
    `test_date` DATE COMMENT 'Date when the compatibility test was performed or compatibility assessment was completed.',
    `test_laboratory` STRING COMMENT 'Name or identifier of the laboratory or facility that performed the compatibility testing. May be internal company laboratory or third-party testing service.',
    `test_method` STRING COMMENT 'Standard test method or protocol used to determine compatibility, such as ASTM D4740 (cleanliness and compatibility of residual fuels), ASTM D6703 (distillate fuel stability), API RP 45 (water compatibility), or internal laboratory procedure reference.',
    `test_report_reference` STRING COMMENT 'Reference number or document identifier for the detailed compatibility test report or certificate of analysis supporting this compatibility determination.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this compatibility matrix record.',
    CONSTRAINT pk_compatibility_matrix PRIMARY KEY(`compatibility_matrix_id`)
) COMMENT 'Reference matrix defining compatibility and incompatibility between petroleum products for blending, co-mingling, and sequential pipeline batching — including crude compatibility (asphaltene precipitation risk), fuel blending compatibility, additive compatibility, and material compatibility (seals, gaskets, coatings). Captures product pair, compatibility rating, risk level, test method, and applicable conditions. Used by pipeline schedulers, blending engineers, and terminal operators.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` (
    `crude_lifting_nomination_id` BIGINT COMMENT 'Unique identifier for the crude lifting nomination record. Primary key for the association.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to the crude oil grade being nominated for lifting',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the joint venture partner nominating the crude lifting',
    `actual_lifted_volume_bbl` DECIMAL(18,2) COMMENT 'Actual crude oil volume lifted by the partner in barrels. May differ from nominated volume due to operational constraints, measurement adjustments, or quality issues.',
    `bill_of_lading_number` STRING COMMENT 'Unique identifier for the bill of lading document evidencing the crude oil shipment and transfer of custody.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the lifting nomination record was created.',
    `lifting_completion_date` DATE COMMENT 'Date when the physical crude oil lifting was completed and custody transferred to the partner.',
    `lifting_nomination_volume_bbl` DECIMAL(18,2) COMMENT 'Nominated crude oil volume for lifting measured in barrels. Based on partner working interest entitlement and production allocation.',
    `lifting_priority` STRING COMMENT 'Priority sequence for this nomination when multiple partners nominate the same crude grade during overlapping windows. Lower numbers indicate higher priority, typically based on entitlement order or JOA terms.',
    `lifting_window_end_date` DATE COMMENT 'End date of the lifting window during which the partner can take physical delivery of the nominated crude volume.',
    `lifting_window_start_date` DATE COMMENT 'Start date of the lifting window during which the partner can take physical delivery of the nominated crude volume.',
    `nomination_date` DATE COMMENT 'Date when the partner submitted the lifting nomination to the joint venture operator.',
    `nomination_status` STRING COMMENT 'Current lifecycle status of the lifting nomination. Nominated: initial submission. Confirmed: approved by operator. Scheduled: vessel/pipeline scheduled. Lifted: physical delivery completed. Cancelled: nomination withdrawn. Deferred: moved to future period.',
    `preferred_delivery_point` STRING COMMENT 'Partner-specified delivery location for the crude lifting. May differ from the crude grade standard delivery point based on partner logistics and refinery location.',
    `quality_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplicative adjustment factor applied to the lifted volume based on actual crude quality versus specification. Values <1.0 indicate quality discount, >1.0 indicate premium.',
    `transportation_cost_usd` DECIMAL(18,2) COMMENT 'Transportation cost in USD for moving the crude from production point to delivery point, allocated to this partner lifting.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the lifting nomination record was last updated.',
    `vessel_name` STRING COMMENT 'Name of the tanker vessel used for crude oil lifting, if applicable. Null for pipeline deliveries.',
    CONSTRAINT pk_crude_lifting_nomination PRIMARY KEY(`crude_lifting_nomination_id`)
) COMMENT 'This association product represents the lifting nomination event between crude_grade and partner. It captures partner-specific crude offtake nominations from joint venture production based on working interest entitlements. Each record links one crude grade to one partner with nomination volumes, lifting windows, delivery preferences, and priority sequencing that exist only in the context of this nomination relationship.. Existence Justification: In joint venture crude oil operations, multiple partners hold working interest entitlements to production from shared fields, and each partner nominates liftings across multiple crude grades based on their entitlement share and refinery needs. A single crude grade (e.g., Bonny Light from a Nigerian JV field) has multiple partners nominating offtake volumes, and each partner nominates across multiple crude grades from their portfolio of JV interests. The business actively manages these nominations as operational events with volumes, lifting windows, delivery logistics, and priority sequencing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`budget_allocation` (
    `budget_allocation_id` BIGINT COMMENT 'Unique system identifier for the product budget allocation record. Primary key for the association.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to the financial budget record. References the budget master for the fiscal year and business unit.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to the petroleum product being budgeted. References the master product catalog.',
    `allocation_notes` STRING COMMENT 'Free-text notes or justification for this product allocation. Captures assumptions, risks, or business rationale for the volume and price forecasts.',
    `allocation_status` STRING COMMENT 'The lifecycle status of this product budget allocation. Tracks approval workflow: Draft (initial planning), Submitted (under review), Approved (finalized), Revised (updated after approval), Locked (no further changes).',
    `budgeted_price` DECIMAL(18,2) COMMENT 'The assumed price per unit for this petroleum product in this budget planning cycle. Represents the price deck assumption used for revenue forecasting. Currency matches the budget currency.',
    `budgeted_volume` DECIMAL(18,2) COMMENT 'The planned production or sales volume for this petroleum product within this budget. Expressed in the products standard unit of measure (barrels, MCF, tonnes). Used for revenue and cost forecasting.',
    `cost_forecast` DECIMAL(18,2) COMMENT 'The forecasted cost (OPEX, LOE, or production cost) for this product within this budget. Includes lifting costs, processing costs, and allocated overhead. Currency matches the budget currency.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this product budget allocation record was first created in the system. Used for audit trail and change tracking.',
    `differential_assumption` DECIMAL(18,2) COMMENT 'The price differential (premium or discount) assumed for this product relative to the benchmark. Expressed in currency per unit. Positive for premium, negative for discount.',
    `fiscal_period` STRING COMMENT 'The fiscal period within the budget year for which this allocation applies (e.g., Q1, Q2, January, February, FY for full year). Supports period-specific forecasting and variance analysis.',
    `last_modified_by` STRING COMMENT 'The user or system identifier of the person who last modified this allocation record. Supports accountability during budget revisions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this allocation record was last modified. Used for change tracking and version control during budget revision cycles.',
    `price_benchmark_used` STRING COMMENT 'The pricing benchmark or index used for the budgeted price assumption (e.g., WTI, Brent, Henry Hub). Documents the basis for the price deck.',
    `revenue_forecast` DECIMAL(18,2) COMMENT 'The forecasted revenue for this product within this budget, calculated as budgeted_volume × budgeted_price with adjustments for differentials and transportation costs. Currency matches the budget currency.',
    `volume_uom` STRING COMMENT 'The unit of measure for the budgeted volume (e.g., BBL, MCF, MT, GAL). Should align with the petroleum products standard unit of measure.',
    `created_by` STRING COMMENT 'The user or system identifier of the person who created this allocation record. Supports accountability and audit requirements.',
    CONSTRAINT pk_budget_allocation PRIMARY KEY(`budget_allocation_id`)
) COMMENT 'This association product represents the budgetary planning allocation between petroleum products and financial budgets in the oil and gas enterprise. It captures the volume assumptions, price deck forecasts, and revenue/cost projections for each product within each budget planning cycle. Each record links one petroleum product to one budget with period-specific forecasts and assumptions that exist only in the context of this budgetary relationship.. Existence Justification: In oil and gas financial planning, annual budgets allocate revenue and cost targets across multiple petroleum products (crude grades, refined products, NGLs, petrochemicals), and each product appears in multiple budgets across different organizational levels (corporate, business unit, profit center, field-level). The business actively manages these allocations during budget planning cycles, tracking volume assumptions, price deck forecasts, and period-specific revenue/cost projections for each product-budget combination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`entitlement` (
    `entitlement_id` BIGINT COMMENT 'Unique system identifier for the product entitlement record. Primary key.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to the petroleum product being entitled (crude oil, natural gas, condensate, NGL, etc.)',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the joint venture partner receiving entitlement',
    `actual_lifted_volume_boe` DECIMAL(18,2) COMMENT 'Actual volume of petroleum product lifted by the partner during the entitlement period, expressed in BOE. Used to calculate imbalance.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the entitlement record was created.',
    `entitlement_status` STRING COMMENT 'Current lifecycle status of this partners entitlement to the petroleum product. Reflects changes in working interest or JOA status.',
    `imbalance_volume_boe` DECIMAL(18,2) COMMENT 'Difference between partners actual lifted volume and entitled volume for this petroleum product. Positive = overlift, negative = underlift. Drives settlement calculations. Identified in detection phase relationship data.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the entitlement record was last modified.',
    `lifting_date` DATE COMMENT 'Date when the partner lifted or is scheduled to lift their entitled volume of the petroleum product. Critical for tracking actual vs. entitled volumes. Identified in detection phase relationship data.',
    `period_end` DATE COMMENT 'End date of the period for which this entitlement calculation applies. Defines the temporal boundary of the entitlement record.',
    `period_start` DATE COMMENT 'Start date of the period for which this entitlement calculation applies. Typically monthly or quarterly based on JOA terms.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Monetary value of the imbalance settlement for this partner-product entitlement. Calculated from imbalance volume and product pricing.',
    `settlement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the settlement amount.',
    `settlement_status` STRING COMMENT 'Current status of the entitlement settlement process for this partner-product combination. Tracks whether imbalances have been reconciled and settled. Identified in detection phase relationship data.',
    `volume_boe` DECIMAL(18,2) COMMENT 'Partners entitled volume for this petroleum product expressed in Barrels of Oil Equivalent. Calculated from production volume and working interest percentage. Identified in detection phase relationship data.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'Partners working interest percentage in the petroleum product production. Determines entitlement volume calculation. Identified in detection phase relationship data.',
    CONSTRAINT pk_entitlement PRIMARY KEY(`entitlement_id`)
) COMMENT 'This association product represents the entitlement relationship between petroleum products and joint venture partners. It captures partner-specific entitlement volumes, working interest percentages, lifting schedules, imbalances, and settlement status for revenue distribution and partner accounting. Each record links one petroleum product to one partner with attributes that exist only in the context of this entitlement relationship.. Existence Justification: In joint venture operations, multiple partners hold working interest in the same petroleum product streams (crude, gas, condensate, NGL) produced from shared assets, and each partner is entitled to multiple product types based on their interest percentages. The business actively manages product entitlements as operational records with lifting schedules, imbalance tracking, and settlement processes. This is not an analytical correlation but a core operational relationship explicitly mentioned as already modeled via lifting_entitlement.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`differential_benchmark` (
    `differential_benchmark_id` BIGINT COMMENT 'Primary key for differential_benchmark',
    `parent_differential_benchmark_id` BIGINT COMMENT 'Self-referencing FK on differential_benchmark (parent_differential_benchmark_id)',
    `applicable_market` STRING COMMENT 'Broad market segment for the benchmark.',
    `applicable_region` STRING COMMENT 'Geographic region(s) where the benchmark is applicable. Use ISO‑3 country codes. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|NOR|RUS|CHN|SAU|BRA|ZAF — promote to reference product]',
    `benchmark_code` STRING COMMENT 'Business‑oriented code used to reference the benchmark in downstream systems.',
    `benchmark_name` STRING COMMENT 'Human‑readable name of the differential benchmark, e.g., "WTI‑Brent Spread".',
    `benchmark_type` STRING COMMENT 'Category of the benchmark indicating whether it measures price, cost, margin, or spread.',
    `commodity` STRING COMMENT 'Primary commodity to which the benchmark applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the benchmark record was first created in the data lake.',
    `differential_benchmark_description` STRING COMMENT 'Detailed textual description of the benchmark purpose and methodology.',
    `differential_value` DECIMAL(18,2) COMMENT 'Numeric value representing the differential amount (e.g., $2.35 per barrel).',
    `effective_from` DATE COMMENT 'Date when the benchmark becomes effective.',
    `effective_until` DATE COMMENT 'Date when the benchmark expires or is superseded (null if open‑ended).',
    `is_default` BOOLEAN COMMENT 'True if this benchmark is the default for its commodity and type.',
    `is_historical` BOOLEAN COMMENT 'Indicates whether the benchmark represents historical data (true) or forward‑looking data (false).',
    `last_review_date` DATE COMMENT 'Date when the benchmark was last reviewed for relevance or accuracy.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the benchmark.',
    `price_basis` STRING COMMENT 'Pricing basis used for the benchmark.',
    `pricing_curve` STRING COMMENT 'Frequency of the underlying price curve used to calculate the differential.',
    `regulatory_classification` STRING COMMENT 'Regulatory framework governing the benchmark, if any.',
    `source_document` STRING COMMENT 'Reference to the external document or report defining the benchmark (e.g., EIA report ID).',
    `source_system` STRING COMMENT 'Originating system or application that supplied the benchmark data.',
    `differential_benchmark_status` STRING COMMENT 'Current lifecycle status of the benchmark.',
    `unit_of_measure` STRING COMMENT 'Unit in which the differential value is expressed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the benchmark record.',
    `volatility_measure` STRING COMMENT 'Statistical measure used to express benchmark volatility.',
    `volatility_value` DECIMAL(18,2) COMMENT 'Numeric value of the selected volatility measure.',
    CONSTRAINT pk_differential_benchmark PRIMARY KEY(`differential_benchmark_id`)
) COMMENT 'Master reference table for differential_benchmark. Referenced by differential_benchmark_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`product`.`laboratory` (
    `laboratory_id` BIGINT COMMENT 'Primary key for laboratory',
    `parent_laboratory_id` BIGINT COMMENT 'Self-referencing FK on laboratory (parent_laboratory_id)',
    `accreditation_body` STRING COMMENT 'Name of the organization that granted accreditation (e.g., ISO, API).',
    `accreditation_expiry` DATE COMMENT 'Date on which the current accreditation expires.',
    `accreditation_status` STRING COMMENT 'Current accreditation standing of the laboratory according to recognized standards.',
    `address_line1` STRING COMMENT 'Primary street address of the laboratory.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `analysis_methods` STRING COMMENT 'Key analytical techniques available at the laboratory (e.g., GC, HPLC, ASTM D86).',
    `capacity_per_day` DECIMAL(18,2) COMMENT 'Maximum number of samples the laboratory can process per calendar day.',
    `city` STRING COMMENT 'City where the laboratory is located.',
    `closing_date` DATE COMMENT 'Date the laboratory ceased operations, if applicable.',
    `contact_email` STRING COMMENT 'Email address of the primary laboratory contact.',
    `contact_name` STRING COMMENT 'Name of the primary contact person for the laboratory.',
    `contact_phone` STRING COMMENT 'Phone number of the primary laboratory contact.',
    `country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the laboratory location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the laboratory record was first created in the system.',
    `data_retention_policy` STRING COMMENT 'Policy description governing how long laboratory data is retained.',
    `is_certified` BOOLEAN COMMENT 'Indicates whether the laboratory holds current certification for required analyses.',
    `lab_code` STRING COMMENT 'External business code or catalogue number used to reference the laboratory across systems.',
    `lab_name` STRING COMMENT 'Human‑readable name of the laboratory facility.',
    `lab_type` STRING COMMENT 'Category describing the primary function of the laboratory (e.g., analytical testing, certification, research, field sampling).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or internal inspection.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the upcoming inspection.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the laboratory.',
    `opening_date` DATE COMMENT 'Date the laboratory began operations.',
    `operational_status` STRING COMMENT 'Current operational state of the laboratory within the enterprise.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the laboratory address.',
    `quality_certifications` STRING COMMENT 'List of quality management certifications (e.g., ISO 9001, ISO 17025) held by the laboratory.',
    `state_province` STRING COMMENT 'State or province of the laboratory location.',
    `supported_product_types` STRING COMMENT 'Comma‑separated list of petroleum product categories (e.g., crude, gasoline, diesel) that the laboratory is qualified to test.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the laboratory record.',
    CONSTRAINT pk_laboratory PRIMARY KEY(`laboratory_id`)
) COMMENT 'Master reference table for laboratory. Referenced by laboratory_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ADD CONSTRAINT `fk_product_crude_grade_assay_id` FOREIGN KEY (`assay_id`) REFERENCES `oil_gas_ecm`.`product`.`assay`(`assay_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ADD CONSTRAINT `fk_product_crude_grade_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ADD CONSTRAINT `fk_product_quality_spec_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ADD CONSTRAINT `fk_product_refined_product_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ADD CONSTRAINT `fk_product_lng_specification_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ADD CONSTRAINT `fk_product_petrochemical_product_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ADD CONSTRAINT `fk_product_petrochemical_product_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `oil_gas_ecm`.`product`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ADD CONSTRAINT `fk_product_pricing_benchmark_differential_benchmark_id` FOREIGN KEY (`differential_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`differential_benchmark`(`differential_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ADD CONSTRAINT `fk_product_classification_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `oil_gas_ecm`.`product`.`laboratory`(`laboratory_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_original_test_quality_test_result_id` FOREIGN KEY (`original_test_quality_test_result_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_test_result`(`quality_test_result_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ADD CONSTRAINT `fk_product_blend_recipe_additive_id` FOREIGN KEY (`additive_id`) REFERENCES `oil_gas_ecm`.`product`.`additive`(`additive_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ADD CONSTRAINT `fk_product_blend_recipe_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ADD CONSTRAINT `fk_product_blend_recipe_quaternary_blend_component_stream_4_petroleum_product_id` FOREIGN KEY (`quaternary_blend_component_stream_4_petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ADD CONSTRAINT `fk_product_blend_recipe_quinary_blend_component_stream_5_petroleum_product_id` FOREIGN KEY (`quinary_blend_component_stream_5_petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ADD CONSTRAINT `fk_product_blend_recipe_target_product_petroleum_product_id` FOREIGN KEY (`target_product_petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ADD CONSTRAINT `fk_product_blend_recipe_tertiary_blend_component_stream_3_petroleum_product_id` FOREIGN KEY (`tertiary_blend_component_stream_3_petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ADD CONSTRAINT `fk_product_loss_gain_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ADD CONSTRAINT `fk_product_regulatory_approval_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ADD CONSTRAINT `fk_product_lifecycle_status_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ADD CONSTRAINT `fk_product_uom_conversion_inverse_conversion_id` FOREIGN KEY (`inverse_conversion_id`) REFERENCES `oil_gas_ecm`.`product`.`uom_conversion`(`uom_conversion_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ADD CONSTRAINT `fk_product_uom_conversion_superseded_by_conversion_uom_conversion_id` FOREIGN KEY (`superseded_by_conversion_uom_conversion_id`) REFERENCES `oil_gas_ecm`.`product`.`uom_conversion`(`uom_conversion_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ADD CONSTRAINT `fk_product_substitution_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ADD CONSTRAINT `fk_product_substitution_substitution_substitute_product_petroleum_product_id` FOREIGN KEY (`substitution_substitute_product_petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ADD CONSTRAINT `fk_product_handling_requirement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ADD CONSTRAINT `fk_product_emission_factor_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ADD CONSTRAINT `fk_product_tariff_code_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ADD CONSTRAINT `fk_product_tariff_code_superseded_by_tariff_code_id` FOREIGN KEY (`superseded_by_tariff_code_id`) REFERENCES `oil_gas_ecm`.`product`.`tariff_code`(`tariff_code_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ADD CONSTRAINT `fk_product_safety_data_sheet_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ADD CONSTRAINT `fk_product_price_history_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ADD CONSTRAINT `fk_product_price_history_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ADD CONSTRAINT `fk_product_compatibility_matrix_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ADD CONSTRAINT `fk_product_compatibility_matrix_superseded_by_matrix_compatibility_matrix_id` FOREIGN KEY (`superseded_by_matrix_compatibility_matrix_id`) REFERENCES `oil_gas_ecm`.`product`.`compatibility_matrix`(`compatibility_matrix_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ADD CONSTRAINT `fk_product_crude_lifting_nomination_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ADD CONSTRAINT `fk_product_budget_allocation_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ADD CONSTRAINT `fk_product_entitlement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`differential_benchmark` ADD CONSTRAINT `fk_product_differential_benchmark_parent_differential_benchmark_id` FOREIGN KEY (`parent_differential_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`differential_benchmark`(`differential_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`laboratory` ADD CONSTRAINT `fk_product_laboratory_parent_laboratory_id` FOREIGN KEY (`parent_laboratory_id`) REFERENCES `oil_gas_ecm`.`product`.`laboratory`(`laboratory_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `oil_gas_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Steward Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ALTER COLUMN `pricing_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Pricing Benchmark');
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
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `assay_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Assay Reference Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `assay_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{5,30}$');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Owner Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `api_gravity_band` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity Band');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `api_gravity_band` SET TAGS ('dbx_value_regex' = 'light|medium|heavy|extra_heavy');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `assay_date` SET TAGS ('dbx_business_glossary_term' = 'Crude Assay Date');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ALTER COLUMN `benchmark_index` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Pricing Index');
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
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Specification ID');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product ID');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Owner Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`product`.`assay` SET TAGS ('dbx_subdomain' = 'pricing_management');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `assay_id` SET TAGS ('dbx_business_glossary_term' = 'Product Assay Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Analyst Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Identifier (ID)');
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
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ALTER COLUMN `sample_source` SET TAGS ('dbx_business_glossary_term' = 'Sample Source Location');
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
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ALTER COLUMN `specification_standard` SET TAGS ('dbx_business_glossary_term' = 'Specification Standard');
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
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Fractionation Train Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Stream Supervisor Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `pricing_index` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Pricing Index');
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ALTER COLUMN `pricing_index` SET TAGS ('dbx_value_regex' = 'mont_belvieu|conway|edmonton|sarnia|custom');
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
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `lng_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Liquefied Natural Gas (LNG) Specification Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Author Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Approval Date');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Specification Approved By');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `butane_plus_content_mol_pct` SET TAGS ('dbx_business_glossary_term' = 'Butane Plus (C4+) Content Mole Percent');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `carbon_dioxide_content_mol_pct` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Content Mole Percent');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `cargo_type` SET TAGS ('dbx_business_glossary_term' = 'LNG Cargo Type Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `cargo_type` SET TAGS ('dbx_value_regex' = 'spot|term|FOB|DES|CIF');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `ethane_content_mol_pct` SET TAGS ('dbx_business_glossary_term' = 'Ethane (C2H6) Content Mole Percent');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `gross_heating_value_btu_per_scf` SET TAGS ('dbx_business_glossary_term' = 'Gross Heating Value British Thermal Units Per Standard Cubic Foot');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `higher_heating_value_mj_per_nm3` SET TAGS ('dbx_business_glossary_term' = 'Higher Heating Value (HHV) Megajoules Per Normal Cubic Meter');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `hydrogen_sulfide_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content Parts Per Million');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `liquefaction_train_origin` SET TAGS ('dbx_business_glossary_term' = 'Liquefaction Train Origin Facility');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `lower_heating_value_mj_per_nm3` SET TAGS ('dbx_business_glossary_term' = 'Lower Heating Value (LHV) Megajoules Per Normal Cubic Meter');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `mercury_content_ng_per_nm3` SET TAGS ('dbx_business_glossary_term' = 'Mercury (Hg) Content Nanograms Per Normal Cubic Meter');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `methane_content_mol_pct` SET TAGS ('dbx_business_glossary_term' = 'Methane (CH4) Content Mole Percent');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `ngl_extraction_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Extraction Required Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `nitrogen_content_mol_pct` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen (N2) Content Mole Percent');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes and Comments');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `oxygen_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Oxygen (O2) Content Parts Per Million');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `pipeline_injection_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Injection Compatibility Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `pricing_benchmark` SET TAGS ('dbx_business_glossary_term' = 'LNG Pricing Benchmark Index');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `pricing_benchmark` SET TAGS ('dbx_value_regex' = 'JKM|TTF|HH|Brent|JCC|custom');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `pricing_benchmark` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `propane_content_mol_pct` SET TAGS ('dbx_business_glossary_term' = 'Propane (C3H8) Content Mole Percent');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `quality_band` SET TAGS ('dbx_business_glossary_term' = 'LNG Quality Band Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `quality_band` SET TAGS ('dbx_value_regex' = 'lean|standard|rich|premium|custom|spot');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `quality_tolerance_window_pct` SET TAGS ('dbx_business_glossary_term' = 'Quality Tolerance Window Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `regasification_terminal` SET TAGS ('dbx_business_glossary_term' = 'Regasification Terminal Destination');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Product Classification Code');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `relative_density` SET TAGS ('dbx_business_glossary_term' = 'Relative Density (Specific Gravity)');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `spa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Sales and Purchase Agreement (SPA) Reference Number');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `spa_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `spa_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `specification_code` SET TAGS ('dbx_business_glossary_term' = 'LNG Specification Code');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `specification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `specification_name` SET TAGS ('dbx_business_glossary_term' = 'LNG Specification Name');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'LNG Specification Lifecycle Status');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under_review|archived');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `total_sulfur_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Total Sulfur Content Parts Per Million');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Version Number');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `water_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Water (H2O) Content Parts Per Million');
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ALTER COLUMN `wobbe_index_mj_per_nm3` SET TAGS ('dbx_business_glossary_term' = 'Wobbe Index Megajoules Per Normal Cubic Meter');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `petrochemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Product Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Steward Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `epa_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Reporting Required');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Type');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `greenhouse_gas_emissions_factor` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions Factor');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `hts_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `hts_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}.[0-9]{2}.[0-9]{2}.[0-9]{2}$');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|under_development|regulatory_review|phased_out');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `molecular_formula` SET TAGS ('dbx_business_glossary_term' = 'Molecular Formula');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `process_route` SET TAGS ('dbx_business_glossary_term' = 'Process Route');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `product_specification_document` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Document Reference');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `purity_grade` SET TAGS ('dbx_business_glossary_term' = 'Purity Grade');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `purity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Purity Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration, Evaluation, Authorisation and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `safety_data_sheet_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Revision Date');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `standard_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `storage_temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `storage_temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `tsca_status` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Status');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `tsca_status` SET TAGS ('dbx_value_regex' = 'active|inactive|exempt|pmnrequired');
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ALTER COLUMN `voc_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Volatile Organic Compound (VOC) Content Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` SET TAGS ('dbx_subdomain' = 'pricing_management');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`pricing_benchmark` ALTER COLUMN `differential_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Differential Benchmark Identifier (ID)');
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
ALTER TABLE `oil_gas_ecm`.`product`.`classification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `classification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Classification ID');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product ID');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `classification_code` SET TAGS ('dbx_business_glossary_term' = 'Classification Code');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `classification_description` SET TAGS ('dbx_business_glossary_term' = 'Classification Description');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `classification_source` SET TAGS ('dbx_business_glossary_term' = 'Classification Source');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `classification_source` SET TAGS ('dbx_value_regex' = 'regulatory_authority|customs_broker|internal_tax|internal_compliance|third_party_consultant');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_business_glossary_term' = 'Classification Status');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `confidence` SET TAGS ('dbx_business_glossary_term' = 'Classification Confidence');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `confidence` SET TAGS ('dbx_value_regex' = 'confirmed|probable|provisional');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `dangerous_goods_class` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Class');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `duty_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate Unit');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `duty_rate_unit` SET TAGS ('dbx_value_regex' = 'percent|usd_per_bbl|usd_per_gallon|usd_per_ton|usd_per_mmbtu');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `epa_fuel_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Fuel Category');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `ferc_commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Commodity Code');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `fta_program` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Agreement (FTA) Program');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `internal_product_family` SET TAGS ('dbx_business_glossary_term' = 'Internal Product Family');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `internal_product_subfamily` SET TAGS ('dbx_business_glossary_term' = 'Internal Product Subfamily');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Classification Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `preferential_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferential Rate Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `ruling_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Ruling Reference Number');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `scheme` SET TAGS ('dbx_business_glossary_term' = 'Classification Scheme');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `sec_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Reporting Category');
ALTER TABLE `oil_gas_ecm`.`product`.`classification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `quality_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Result ID');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Technician ID');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identification Code');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `original_test_quality_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Original Test ID');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product ID');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Specification ID');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identification Number');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identification Number');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Identification');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `coq_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Quality (CoQ) Reference Number');
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
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ALTER COLUMN `sample_location` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Location');
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
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `certificate_of_quality_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Quality (CoQ) Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `cargo_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Inspector Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Laboratory Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
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
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `discharge_port` SET TAGS ('dbx_business_glossary_term' = 'Discharge Port');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `distillation_fbp_c` SET TAGS ('dbx_business_glossary_term' = 'Distillation Final Boiling Point (FBP) Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `distillation_ibp_c` SET TAGS ('dbx_business_glossary_term' = 'Distillation Initial Boiling Point (IBP) Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `distillation_t50_c` SET TAGS ('dbx_business_glossary_term' = 'Distillation T50 Temperature Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `distillation_t90_c` SET TAGS ('dbx_business_glossary_term' = 'Distillation T90 Temperature Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `inspector_certification` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `laboratory_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `loading_port` SET TAGS ('dbx_business_glossary_term' = 'Loading Port');
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
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `sulfur_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `tan_value` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) Value');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `vessel_imo_number` SET TAGS ('dbx_business_glossary_term' = 'Vessel International Maritime Organization (IMO) Number');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `vessel_imo_number` SET TAGS ('dbx_value_regex' = '^IMO[0-9]{7}$');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `viscosity_cst` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Centistokes (cSt)');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `viscosity_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Measurement Temperature Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ALTER COLUMN `water_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Water Content Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `blend_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Recipe Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `additive_id` SET TAGS ('dbx_business_glossary_term' = 'Additive 1 Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Additive Supplier Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Optimizer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Component Stream 1 Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `quaternary_blend_component_stream_4_petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Component Stream 4 Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `quinary_blend_component_stream_5_petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Component Stream 5 Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `target_product_petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Target Product Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `tertiary_blend_component_stream_3_petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Component Stream 3 Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `actual_blend_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Blend Volume');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `actual_ron` SET TAGS ('dbx_business_glossary_term' = 'Actual Research Octane Number (RON)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `actual_sulfur_content` SET TAGS ('dbx_business_glossary_term' = 'Actual Sulfur Content');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `additive_1_dosage` SET TAGS ('dbx_business_glossary_term' = 'Additive 1 Dosage');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `additive_1_dosage_uom` SET TAGS ('dbx_business_glossary_term' = 'Additive 1 Dosage Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `additive_1_dosage_uom` SET TAGS ('dbx_value_regex' = 'PPM|VOL_PCT|WT_PCT');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `blend_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Blend End Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `blend_optimization_method` SET TAGS ('dbx_business_glossary_term' = 'Blend Optimization Method');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `blend_optimization_method` SET TAGS ('dbx_value_regex' = 'manual|linear_programming|nonlinear_optimization|ai_ml');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `blend_order_number` SET TAGS ('dbx_business_glossary_term' = 'Blend Order Number');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `blend_order_number` SET TAGS ('dbx_value_regex' = '^BLD-[0-9]{8}$');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `blend_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Blend Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `blend_status` SET TAGS ('dbx_business_glossary_term' = 'Blend Status');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `blend_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|on_hold|failed');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `blend_type` SET TAGS ('dbx_business_glossary_term' = 'Blend Type');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `blend_type` SET TAGS ('dbx_value_regex' = 'gasoline|diesel|jet_fuel|fuel_oil|crude|lpg');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `blending_unit` SET TAGS ('dbx_business_glossary_term' = 'Blending Unit');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `component_stream_1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Component Stream 1 Ratio (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `component_stream_2_ratio` SET TAGS ('dbx_business_glossary_term' = 'Component Stream 2 Ratio (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `component_stream_3_ratio` SET TAGS ('dbx_business_glossary_term' = 'Component Stream 3 Ratio (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `component_stream_4_ratio` SET TAGS ('dbx_business_glossary_term' = 'Component Stream 4 Ratio (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `component_stream_5_ratio` SET TAGS ('dbx_business_glossary_term' = 'Component Stream 5 Ratio (Volume Percent)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `planned_blend_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Blend Date');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `quality_test_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Result');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `quality_test_result` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_tested');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `target_api_gravity` SET TAGS ('dbx_business_glossary_term' = 'Target American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `target_blend_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Blend Volume');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `target_cetane_number` SET TAGS ('dbx_business_glossary_term' = 'Target Cetane Number');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `target_flash_point` SET TAGS ('dbx_business_glossary_term' = 'Target Flash Point');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `target_mon` SET TAGS ('dbx_business_glossary_term' = 'Target Motor Octane Number (MON)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `target_product_grade` SET TAGS ('dbx_business_glossary_term' = 'Target Product Grade');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `target_reid_vapor_pressure` SET TAGS ('dbx_business_glossary_term' = 'Target Reid Vapor Pressure (RVP)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `target_ron` SET TAGS ('dbx_business_glossary_term' = 'Target Research Octane Number (RON)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `target_sulfur_content` SET TAGS ('dbx_business_glossary_term' = 'Target Sulfur Content');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `target_viscosity` SET TAGS ('dbx_business_glossary_term' = 'Target Viscosity');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `target_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Target Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `target_volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|M3|GAL|L');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Blend Recipe Version');
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `additive_id` SET TAGS ('dbx_business_glossary_term' = 'Additive Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `active_ingredient` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `additive_status` SET TAGS ('dbx_business_glossary_term' = 'Additive Status');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `additive_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|under_evaluation|restricted');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `application_purpose` SET TAGS ('dbx_business_glossary_term' = 'Application Purpose');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `approved_supplier_list` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `chemical_family` SET TAGS ('dbx_business_glossary_term' = 'Chemical Family Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazard Class');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `epa_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Registration Number');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Degrees Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Hazard Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `maximum_treat_rate_ppm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Treat Rate (Parts Per Million - PPM)');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `maximum_treat_rate_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Treat Rate (Volume Percent - Vol%)');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additive Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'drum|tote|bulk_tank|pail|bottle|other');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Additive Product Code');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `product_stream_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Product Stream Compatibility');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `recommended_treat_rate_ppm` SET TAGS ('dbx_business_glossary_term' = 'Recommended Treat Rate (Parts Per Million - PPM)');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `recommended_treat_rate_vol_pct` SET TAGS ('dbx_business_glossary_term' = 'Recommended Treat Rate (Volume Percent - Vol%)');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|not_required|restricted');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `sds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference Number');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Months)');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Degrees Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Degrees Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Additive Trade Name');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'gallon|liter|kilogram|pound|barrel|other');
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ALTER COLUMN `viscosity_cst` SET TAGS ('dbx_business_glossary_term' = 'Kinematic Viscosity (Centistokes - cSt)');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `loss_gain_id` SET TAGS ('dbx_business_glossary_term' = 'Loss Gain Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product ID');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `actual_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `custody_transfer_point` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Point');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `expected_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Expected Volume Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `financial_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `financial_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `investigation_assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Investigation Assigned To');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|closed|escalated|pending_approval');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `joint_venture_allocation_required` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Allocation Required');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `loss_gain_category` SET TAGS ('dbx_business_glossary_term' = 'Loss Gain Category');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `loss_gain_category` SET TAGS ('dbx_value_regex' = 'physical_loss|measurement_variance|accounting_adjustment|operational_variance|regulatory_adjustment');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `loss_gain_number` SET TAGS ('dbx_business_glossary_term' = 'Loss Gain Number');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `loss_gain_type` SET TAGS ('dbx_business_glossary_term' = 'Loss Gain Type');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Loss Gain Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `percentage_variance` SET TAGS ('dbx_business_glossary_term' = 'Percentage Variance');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `pressure_observed_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Observed Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `regulatory_report_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Number');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `reportable_to_regulatory` SET TAGS ('dbx_business_glossary_term' = 'Reportable to Regulatory');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `temperature_observed_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Observed Fahrenheit (F)');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `volume_variance_bbl` SET TAGS ('dbx_business_glossary_term' = 'Volume Variance Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `volume_variance_mcf` SET TAGS ('dbx_business_glossary_term' = 'Volume Variance Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `volume_variance_mt` SET TAGS ('dbx_business_glossary_term' = 'Volume Variance Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `regulatory_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `applicable_market` SET TAGS ('dbx_business_glossary_term' = 'Applicable Market');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `application_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Application Reference Number');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `approval_conditions` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `approval_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Fee Amount');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `approval_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Approval Fee Currency');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `approval_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `approval_scope` SET TAGS ('dbx_business_glossary_term' = 'Approval Scope');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `approval_type` SET TAGS ('dbx_business_glossary_term' = 'Approval Type');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `contact_person` SET TAGS ('dbx_business_glossary_term' = 'Contact Person');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `contact_person` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `contact_person` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `document_repository_link` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Link');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `product_specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Reference');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `lifecycle_status_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product ID');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Status Approval Date');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `contract_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Contract Impact Assessment');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `downstream_system_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Downstream System Notification Status');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `downstream_system_notification_status` SET TAGS ('dbx_value_regex' = 'pending|notified|acknowledged|failed');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Status End Date');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `hse_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Impact Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `hse_review_reference` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Review Reference');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `inventory_disposition_plan` SET TAGS ('dbx_business_glossary_term' = 'Inventory Disposition Plan');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `lifecycle_status_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `lifecycle_status_status` SET TAGS ('dbx_value_regex' = 'development|pilot|active|phase_out|discontinued|regulatory_withdrawn');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `market_applicability` SET TAGS ('dbx_business_glossary_term' = 'Market Applicability');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `notification_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Notification Lead Time Days');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downstream System Notification Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `production_cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Production Cutoff Date');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference Number');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `sales_cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Cutoff Date');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `status_change_notes` SET TAGS ('dbx_business_glossary_term' = 'Status Change Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `transition_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reason Code');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `transition_reason_code` SET TAGS ('dbx_value_regex' = 'market_demand|regulatory_compliance|technical_obsolescence|strategic_portfolio|cost_optimization|safety_concern');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `transition_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reason Description');
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `uom_conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Conversion Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `inverse_conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Inverse Conversion Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `superseded_by_conversion_uom_conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Conversion Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `api_gravity_max` SET TAGS ('dbx_business_glossary_term' = 'API (American Petroleum Institute) Gravity Maximum');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `api_gravity_min` SET TAGS ('dbx_business_glossary_term' = 'API (American Petroleum Institute) Gravity Minimum');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `applicable_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Geographic Region');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `bidirectional_flag` SET TAGS ('dbx_business_glossary_term' = 'Bidirectional Conversion Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'direct_factor|table_lookup|formula|temperature_corrected|pressure_corrected|density_adjusted');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `conversion_code` SET TAGS ('dbx_business_glossary_term' = 'Conversion Code');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `conversion_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `conversion_factor` SET TAGS ('dbx_business_glossary_term' = 'Conversion Factor');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `conversion_name` SET TAGS ('dbx_business_glossary_term' = 'Conversion Name');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Conversion Status');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `conversion_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|deprecated');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `conversion_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Type');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `conversion_type` SET TAGS ('dbx_value_regex' = 'volume|mass|energy|temperature|pressure|density');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `from_unit` SET TAGS ('dbx_business_glossary_term' = 'From Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `from_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,10}$');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `governing_standard` SET TAGS ('dbx_business_glossary_term' = 'Governing Standard');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `precision_decimal_places` SET TAGS ('dbx_business_glossary_term' = 'Precision Decimal Places');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `reference_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Reference Pressure Kilopascals');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `reference_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Reference Temperature Celsius');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `rounding_method` SET TAGS ('dbx_business_glossary_term' = 'Rounding Method');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `rounding_method` SET TAGS ('dbx_value_regex' = 'round_half_up|round_half_down|round_up|round_down|truncate');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `standard_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Version');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `to_unit` SET TAGS ('dbx_business_glossary_term' = 'To Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `to_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,10}$');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `oil_gas_ecm`.`product`.`uom_conversion` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `substitution_id` SET TAGS ('dbx_business_glossary_term' = 'Substitution Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `substitution_substitute_product_petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Product Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `applicable_market` SET TAGS ('dbx_business_glossary_term' = 'Applicable Market');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `conditions` SET TAGS ('dbx_business_glossary_term' = 'Substitution Conditions');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `customer_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Substitution Frequency');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'unrestricted|occasional|emergency_only|one_time|seasonal');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `hse_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Impact Assessment');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Substitution Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `price_adjustment_method` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Method');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `price_adjustment_method` SET TAGS ('dbx_value_regex' = 'none|fixed_differential|percentage_adjustment|market_index|negotiated');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `price_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Differential Amount');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `price_differential_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Differential Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `pricing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Currency Code');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `pricing_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `quality_adjustment_description` SET TAGS ('dbx_business_glossary_term' = 'Quality Adjustment Description');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `quality_adjustment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Adjustment Required Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `substitution_code` SET TAGS ('dbx_business_glossary_term' = 'Substitution Code');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `substitution_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `substitution_status` SET TAGS ('dbx_business_glossary_term' = 'Substitution Status');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `substitution_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|suspended|expired');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_business_glossary_term' = 'Substitution Type');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_value_regex' = 'full|partial|conditional|emergency|planned');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `supply_disruption_priority` SET TAGS ('dbx_business_glossary_term' = 'Supply Disruption Priority');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `technical_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Review Required Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `use_case_description` SET TAGS ('dbx_business_glossary_term' = 'Use Case Description');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `volume_limit_boe` SET TAGS ('dbx_business_glossary_term' = 'Volume Limit Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `handling_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Requirement Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requirement Author Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `coating_lining_requirement` SET TAGS ('dbx_business_glossary_term' = 'Coating and Lining Requirement');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `container_material_specification` SET TAGS ('dbx_business_glossary_term' = 'Container Material Specification');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `emergency_response_procedure` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Procedure');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `fire_protection_requirement` SET TAGS ('dbx_business_glossary_term' = 'Fire Protection Requirement');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `h2s_content_threshold_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content Threshold (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `h2s_safety_protocol` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Safety Protocol');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `incompatible_products` SET TAGS ('dbx_business_glossary_term' = 'Incompatible Products List');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `inert_gas_blanketing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inert Gas Blanketing Required Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `inert_gas_type` SET TAGS ('dbx_business_glossary_term' = 'Inert Gas Type');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `inert_gas_type` SET TAGS ('dbx_value_regex' = 'nitrogen|carbon_dioxide|argon|not_applicable');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `loading_rate_max_m3_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Maximum Loading Rate (Cubic Meters Per Hour)');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `norm_handling_protocol` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Handling Protocol');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `norm_handling_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Handling Required Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `personal_protective_equipment` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `pressure_control_method` SET TAGS ('dbx_business_glossary_term' = 'Pressure Control Method');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `pressure_max_kpa` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Pressure (Kilopascals)');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `pressure_min_kpa` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Pressure (Kilopascals)');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `requirement_category` SET TAGS ('dbx_business_glossary_term' = 'Handling Requirement Category');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Handling Requirement Code');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_business_glossary_term' = 'Handling Requirement Name');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Handling Requirement Status');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|superseded|under_review|pending_approval');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Handling Requirement Type');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_value_regex' = 'mandatory|recommended|conditional|prohibited');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `segregation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Product Segregation Requirement');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `spill_containment_requirement` SET TAGS ('dbx_business_glossary_term' = 'Spill Containment Requirement');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `static_electricity_precautions` SET TAGS ('dbx_business_glossary_term' = 'Static Electricity Precautions');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `temperature_control_method` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Method');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `transportation_mode_restriction` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode Restriction');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `unloading_rate_max_m3_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Maximum Unloading Rate (Cubic Meters Per Hour)');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `vapor_control_method` SET TAGS ('dbx_business_glossary_term' = 'Vapor Control Method');
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ALTER COLUMN `vapor_recovery_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Vapor Recovery Required Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `emission_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `applicable_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulation');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `control_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Control Efficiency Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `control_technology` SET TAGS ('dbx_business_glossary_term' = 'Emission Control Technology');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Data Source');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `data_source_version` SET TAGS ('dbx_business_glossary_term' = 'Data Source Version');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `emission_category` SET TAGS ('dbx_business_glossary_term' = 'Emission Category');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `emission_category` SET TAGS ('dbx_value_regex' = 'ghg|criteria_pollutant|voc|particulate_matter|hazardous_air_pollutant|lifecycle');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `emission_source_type` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Type');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `factor_code` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Code');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `factor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `factor_name` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Name');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `factor_status` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Status');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `factor_status` SET TAGS ('dbx_value_regex' = 'active|superseded|deprecated|draft|under_review');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `factor_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `factor_value` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Value');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `fuel_quality_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quality Adjustment');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `gwp_version` SET TAGS ('dbx_business_glossary_term' = 'Global Warming Potential (GWP) Version');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `gwp_version` SET TAGS ('dbx_value_regex' = 'ar4|ar5|ar6');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'default|measured|modeled|calculated|engineering_estimate');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `oxidation_factor` SET TAGS ('dbx_business_glossary_term' = 'Carbon Oxidation Factor');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `pollutant_type` SET TAGS ('dbx_business_glossary_term' = 'Pollutant Type');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Tier Level');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `tier_level` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `time_horizon_years` SET TAGS ('dbx_business_glossary_term' = 'Global Warming Potential (GWP) Time Horizon (Years)');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `uncertainty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Uncertainty Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `tariff_code_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Code Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `superseded_by_tariff_code_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Tariff Code Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `anti_dumping_duty_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Dumping Duty Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `classification_ruling_number` SET TAGS ('dbx_business_glossary_term' = 'Classification Ruling Number');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `countervailing_duty_flag` SET TAGS ('dbx_business_glossary_term' = 'Countervailing Duty Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `customs_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Customs Valuation Method');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `customs_valuation_method` SET TAGS ('dbx_value_regex' = 'transaction_value|computed_value|deductive_value|fallback_method');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `duty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Currency Code');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `duty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `duty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `excise_duty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Excise Duty Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `excise_duty_specific_rate` SET TAGS ('dbx_business_glossary_term' = 'Excise Duty Specific Rate');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `excise_duty_uom` SET TAGS ('dbx_business_glossary_term' = 'Excise Duty Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `excise_duty_uom` SET TAGS ('dbx_value_regex' = 'barrel|liter|gallon|metric_ton|kilogram');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `import_export_classification` SET TAGS ('dbx_business_glossary_term' = 'Import/Export Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `import_export_classification` SET TAGS ('dbx_value_regex' = 'import|export|both');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `license_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'License Requirement Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `national_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'National Tariff Code');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `origin_requirement` SET TAGS ('dbx_business_glossary_term' = 'Origin Requirement');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `preferential_duty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Preferential Duty Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `quota_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Quota Applicable Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `quota_uom` SET TAGS ('dbx_business_glossary_term' = 'Quota Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `quota_uom` SET TAGS ('dbx_value_regex' = 'barrel|metric_ton|liter|kilogram|cubic_meter');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `quota_volume` SET TAGS ('dbx_business_glossary_term' = 'Quota Volume');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `ruling_date` SET TAGS ('dbx_business_glossary_term' = 'Ruling Date');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `sanctioned_country_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctioned Country Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `specific_duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Specific Duty Rate');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `specific_duty_uom` SET TAGS ('dbx_business_glossary_term' = 'Specific Duty Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `specific_duty_uom` SET TAGS ('dbx_value_regex' = 'barrel|metric_ton|liter|kilogram|gallon|cubic_meter');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `strategic_goods_classification` SET TAGS ('dbx_business_glossary_term' = 'Strategic Goods Classification');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `tariff_description` SET TAGS ('dbx_business_glossary_term' = 'Tariff Description');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `tariff_status` SET TAGS ('dbx_business_glossary_term' = 'Tariff Status');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `tariff_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|pending|superseded');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `trade_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Code');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `vat_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`tariff_code` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Identifier');
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
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` SET TAGS ('dbx_subdomain' = 'pricing_management');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `price_history_id` SET TAGS ('dbx_business_glossary_term' = 'Price History Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `benchmark_price` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Price');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `compatibility_matrix_id` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Matrix Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Petroleum Product Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `superseded_by_matrix_compatibility_matrix_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Matrix Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `additive_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Additive Required Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `additive_specification` SET TAGS ('dbx_business_glossary_term' = 'Additive Specification');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `applicable_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `applicable_pressure_max_kpa` SET TAGS ('dbx_business_glossary_term' = 'Applicable Maximum Pressure (Kilopascals)');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `applicable_pressure_min_kpa` SET TAGS ('dbx_business_glossary_term' = 'Applicable Minimum Pressure (Kilopascals)');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `applicable_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Applicable Maximum Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `applicable_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Applicable Minimum Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `compatibility_matrix_status` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Matrix Status');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `compatibility_matrix_status` SET TAGS ('dbx_value_regex' = 'active|superseded|under_review|withdrawn|draft');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `compatibility_rating` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Rating');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `compatibility_rating` SET TAGS ('dbx_value_regex' = 'compatible|conditionally_compatible|incompatible|not_tested|under_review');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `compatibility_type` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Type');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `compatibility_type` SET TAGS ('dbx_value_regex' = 'blending|co-mingling|sequential_batching|storage|transportation|material_contact');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `contact_duration_limit_hours` SET TAGS ('dbx_business_glossary_term' = 'Contact Duration Limit (Hours)');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `hse_hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Hazard Description');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `hse_hazard_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Hazard Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `incompatibility_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Incompatibility Mechanism');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `interface_disposition` SET TAGS ('dbx_business_glossary_term' = 'Interface Disposition');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `interface_disposition` SET TAGS ('dbx_value_regex' = 'reblend_primary|reblend_secondary|downgrade|recycle|waste');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `interface_volume_estimate_bbl` SET TAGS ('dbx_business_glossary_term' = 'Interface Volume Estimate (Barrels)');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `material_compatibility_rating` SET TAGS ('dbx_business_glossary_term' = 'Material Compatibility Rating');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `material_compatibility_rating` SET TAGS ('dbx_value_regex' = 'compatible|limited_compatibility|incompatible|not_applicable');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `material_type_restriction` SET TAGS ('dbx_business_glossary_term' = 'Material Type Restriction');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `mixing_ratio_constraint` SET TAGS ('dbx_business_glossary_term' = 'Mixing Ratio Constraint');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `operational_controls_required` SET TAGS ('dbx_business_glossary_term' = 'Operational Controls Required');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `pipeline_batch_sequence_allowed` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Batch Sequence Allowed Flag');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `quality_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Quality Impact Description');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `regulatory_restriction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Restriction');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `test_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Test Laboratory');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `test_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Report Reference');
ALTER TABLE `oil_gas_ecm`.`product`.`compatibility_matrix` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` SET TAGS ('dbx_subdomain' = 'pricing_management');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` SET TAGS ('dbx_association_edges' = 'product.crude_grade,venture.partner');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `crude_lifting_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Lifting Nomination ID');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Lifting Nomination - Crude Grade Id');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Lifting Nomination - Venture Partner Id');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `actual_lifted_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Actual Lifted Volume');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `lifting_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Lifting Completion Date');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `lifting_nomination_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Lifting Nomination Volume');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `lifting_priority` SET TAGS ('dbx_business_glossary_term' = 'Lifting Priority');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `lifting_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lifting Window End Date');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `lifting_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lifting Window Start Date');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `nomination_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Date');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `nomination_status` SET TAGS ('dbx_business_glossary_term' = 'Nomination Status');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `preferred_delivery_point` SET TAGS ('dbx_business_glossary_term' = 'Preferred Delivery Point');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `quality_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Quality Adjustment Factor');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `transportation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Transportation Cost');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` SET TAGS ('dbx_subdomain' = 'pricing_management');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` SET TAGS ('dbx_association_edges' = 'product.petroleum_product,finance.budget');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `budget_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Product Budget Allocation ID');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Product Budget Allocation - Budget Id');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Budget Allocation - Petroleum Product Id');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `budgeted_price` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Price');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `budgeted_volume` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Volume');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `cost_forecast` SET TAGS ('dbx_business_glossary_term' = 'Cost Forecast');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `differential_assumption` SET TAGS ('dbx_business_glossary_term' = 'Differential Assumption');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `price_benchmark_used` SET TAGS ('dbx_business_glossary_term' = 'Price Benchmark Used');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `revenue_forecast` SET TAGS ('dbx_business_glossary_term' = 'Revenue Forecast');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` SET TAGS ('dbx_subdomain' = 'pricing_management');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` SET TAGS ('dbx_association_edges' = 'product.petroleum_product,venture.partner');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Product Entitlement Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Entitlement - Petroleum Product Id');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Product Entitlement - Venture Partner Id');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `actual_lifted_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Actual Lifted Volume');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `imbalance_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Imbalance Volume');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `lifting_date` SET TAGS ('dbx_business_glossary_term' = 'Lifting Date');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Period End');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Period Start');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Volume');
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`product`.`differential_benchmark` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`differential_benchmark` SET TAGS ('dbx_subdomain' = 'pricing_management');
ALTER TABLE `oil_gas_ecm`.`product`.`differential_benchmark` ALTER COLUMN `differential_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Differential Benchmark Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`differential_benchmark` ALTER COLUMN `parent_differential_benchmark_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`laboratory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`product`.`laboratory` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `oil_gas_ecm`.`product`.`laboratory` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `oil_gas_ecm`.`product`.`laboratory` ALTER COLUMN `parent_laboratory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`laboratory` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`laboratory` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`laboratory` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`laboratory` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`laboratory` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`product`.`laboratory` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
