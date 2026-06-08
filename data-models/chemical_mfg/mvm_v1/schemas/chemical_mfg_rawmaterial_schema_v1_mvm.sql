-- Schema for Domain: rawmaterial | Business: Chemical Mfg | Version: v1_mvm
-- Generated on: 2026-05-06 14:37:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`rawmaterial` COMMENT 'Single source of truth for all raw material master data, chemical feedstocks, intermediates, and input substances used in chemical synthesis and production. Manages CAS number registry, SDS/MSDS records, supplier-material relationships, incoming material specifications, material hazard classifications under GHS and TSCA, and material qualification. Supports Raw Material Procurement and Sourcing processes within SAP MM and production planning with material availability and quality attributes.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` (
    `material_master_id` BIGINT COMMENT 'System-generated unique identifier for each material master record.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: Material master records belong to a single CAS entry; linking to cas_registry centralizes chemical identifiers and removes duplicate CAS fields.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Material Cost Allocation Report requires linking each material to a cost center for budgeting and variance analysis; finance allocates material purchase costs by cost center.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Purchasing posts material purchase invoices to a GL expense account; linking material_master to gl_account enables drill‑down from material to GL for audit and reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis per material line item uses profit_center_id to attribute revenue and cost to the appropriate profit center in financial statements.',
    `batch_number_required` BOOLEAN COMMENT 'Indicates whether a batch number must be assigned for traceability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the material master record was created.',
    `effective_date` DATE COMMENT 'Date from which the material record is considered active.',
    `expiration_date` DATE COMMENT 'Date after which the material record is no longer valid.',
    `hazard_class_ghs` STRING COMMENT 'Globally Harmonized System hazard classification (e.g., H220, H315).',
    `humidity_requirement_percent` DECIMAL(18,2) COMMENT 'Maximum relative humidity allowed for storage.',
    `incompatibility_flag` BOOLEAN COMMENT 'True if the material is known to be chemically incompatible with certain other substances.',
    `is_controlled_substance` BOOLEAN COMMENT 'True if the material is subject to controlled substance regulations (e.g., DEA).',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous under GHS/OSHA.',
    `is_restricted_substance` BOOLEAN COMMENT 'True if the material is restricted under REACH, TSCA, or other jurisdictional lists.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the material within the enterprise.. Valid values are `new|active|phase_out|obsolete`',
    `light_sensitivity_flag` BOOLEAN COMMENT 'Indicates whether the material degrades when exposed to light.',
    `material_class` STRING COMMENT 'Broad functional classification of the material within manufacturing processes.. Valid values are `feedstock|intermediate|solvent|catalyst|additive|excipient`',
    `material_group` STRING COMMENT 'SAP‑defined grouping used for procurement and inventory planning.',
    `material_master_name` STRING COMMENT 'Human‑readable primary name of the material (e.g., common trade name).',
    `min_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from a supplier.',
    `molecular_formula` STRING COMMENT 'Symbolic representation of the materials elemental composition (e.g., C6H12O6).',
    `molecular_weight` DECIMAL(18,2) COMMENT 'Molar mass of the material expressed in grams per mole.',
    `physical_state` STRING COMMENT 'State of the material under standard temperature and pressure conditions.. Valid values are `solid|liquid|gas`',
    `procurement_lead_time_days` STRING COMMENT 'Average lead time from purchase order to receipt.',
    `quality_control_required` BOOLEAN COMMENT 'True if the material must undergo QC testing before use.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the material meets all applicable regulatory requirements.',
    `retest_interval_days` STRING COMMENT 'Number of days after which the material must be re‑qualified or tested.',
    `sap_material_number` STRING COMMENT 'Material number as defined in SAP S/4HANA Materials Management module.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the material can be stored before expiration.',
    `storage_location_code` STRING COMMENT 'Code identifying the primary warehouse or storage area for the material.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Highest permissible storage temperature for the material.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Lowest permissible storage temperature for the material.',
    `trade_name` STRING COMMENT 'Manufacturer or vendor‑assigned commercial name for the material.',
    `tsca_regulation_status` STRING COMMENT 'U.S. TSCA compliance status of the material.. Valid values are `registered|exempt|pending`',
    `unit_of_measure` STRING COMMENT 'Standard unit used for ordering, inventory, and consumption (e.g., kg, L, mol).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the material master record.',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Single source of truth for all raw material master records in the chemical manufacturing enterprise. Captures the full identity of each raw material, chemical feedstock, intermediate, or input substance including CAS number reference, IUPAC name, common trade name, molecular formula, molecular weight, physical state at STP, material class (feedstock, intermediate, solvent, catalyst, additive, excipient), SAP material number, material group, unit of measure, shelf life, storage temperature range, humidity requirements, light sensitivity, retest interval, material lifecycle status (new, active, phase-out, obsolete), material category classification, and incompatibility flags. Serves as the authoritative registry for all raw material identities referenced by procurement, production planning, formulation, quality, and EHS domains. Each material has exactly one material_master record regardless of how many suppliers provide it.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` (
    `cas_registry_id` BIGINT COMMENT 'System-generated unique identifier for each CAS registry entry.',
    `autoignition_temp_c` DECIMAL(18,2) COMMENT 'Temperature at which the substance ignites without an external flame.',
    `boiling_point_c` DECIMAL(18,2) COMMENT 'Standard boiling point at atmospheric pressure.',
    `cas_number` STRING COMMENT 'Unique Chemical Abstracts Service registry number identifying the substance.',
    `chemical_family` STRING COMMENT 'Broad chemical family or class (e.g., alkanes, aromatics).',
    `common_name` STRING COMMENT 'Widely used trade or common name for the chemical substance.',
    `epa_regulation_status` STRING COMMENT 'Current EPA regulatory classification (e.g., hazardous waste, non‑hazardous).',
    `expiration_date` DATE COMMENT 'Date after which the regulatory status is considered expired.',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Lowest temperature at which vapors ignite in air.',
    `ghs_pictograms` STRING COMMENT 'Pipe‑delimited list of GHS pictogram codes applicable to the substance. [ENUM-REF-CANDIDATE: GHS01|GHS02|GHS03|GHS04|GHS05|GHS06|GHS07|GHS08|GHS09 — promote to reference product]',
    `hazard_classification` STRING COMMENT 'Primary GHS hazard class for the substance.. Valid values are `explosive|flammable|oxidizer|corrosive|toxic|environmental_hazard`',
    `health_hazard_statement` STRING COMMENT 'Standardized health hazard statement (e.g., H300).',
    `inchi_key` STRING COMMENT 'Standardized hashed representation of the International Chemical Identifier.',
    `is_controlled_substance` BOOLEAN COMMENT 'Indicates if the substance is subject to controlled substance regulations.',
    `is_hazardous` BOOLEAN COMMENT 'Flag indicating whether the substance is considered hazardous.',
    `is_prohibited` BOOLEAN COMMENT 'True if the substance is prohibited for manufacture, sale, or use.',
    `is_restricted_use` BOOLEAN COMMENT 'True if the substance may be used only under special permits or conditions.',
    `iupac_name` STRING COMMENT 'Standardized chemical name according to IUPAC nomenclature.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the CAS record.. Valid values are `active|inactive|retired|pending`',
    `melting_point_c` DECIMAL(18,2) COMMENT 'Standard melting point at atmospheric pressure.',
    `molecular_formula` STRING COMMENT 'Empirical formula representing the composition of the molecule.',
    `molecular_weight` DECIMAL(18,2) COMMENT 'Exact molecular weight of the substance expressed in g/mol.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the substance.',
    `odor_description` STRING COMMENT 'Textual description of the substances odor.',
    `physical_state` STRING COMMENT 'Standard state of the substance at ambient conditions.. Valid values are `solid|liquid|gas`',
    `precautionary_statement` STRING COMMENT 'Standardized precautionary statement (e.g., P210).',
    `purity_percent` DECIMAL(18,2) COMMENT 'Typical purity of the material expressed as a percentage.',
    `reach_status` STRING COMMENT 'Regulatory status of the substance under the European REACH regulation.. Valid values are `registered|exempt|restricted|banned`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAS registry record was first created.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the CAS registry record.',
    `regulatory_review_date` DATE COMMENT 'Date of the most recent regulatory compliance review.',
    `smiles` STRING COMMENT 'Simplified Molecular Input Line Entry System string describing the structure.',
    `source_system` STRING COMMENT 'Originating operational system (e.g., SAP MM, LIMS).',
    `storage_pressure_bar` DECIMAL(18,2) COMMENT 'Recommended storage pressure in bar.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Recommended storage temperature in degrees Celsius.',
    `substance_type` STRING COMMENT 'Classification of the substance as pure, mixture, polymer, or UVCB.. Valid values are `pure|mixture|polymer|uvcb`',
    `synonyms` STRING COMMENT 'Pipe‑delimited list of alternative names and synonyms for the substance.',
    `tsca_status` STRING COMMENT 'Regulatory status of the substance under the U.S. Toxic Substances Control Act.. Valid values are `registered|exempt|restricted|banned`',
    `vapor_pressure_mmhg` DECIMAL(18,2) COMMENT 'Equilibrium vapor pressure at 25 °C expressed in mm Hg.',
    CONSTRAINT pk_cas_registry PRIMARY KEY(`cas_registry_id`)
) COMMENT 'Authoritative CAS (Chemical Abstracts Service) number registry for all chemical substances managed within the enterprise. Each record links a unique CAS number to its canonical chemical identity including IUPAC name, synonyms, molecular formula, InChI key, SMILES notation, chemical family, substance type (pure substance, mixture, polymer, UVCB), regulatory status under TSCA, REACH, and other jurisdictions, and cross-references to internal material master records. Supports regulatory compliance, SDS authoring, REACH registration, and TSCA inventory reporting.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` (
    `sds_record_id` BIGINT COMMENT 'Primary key for sds_record',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: Safety Data Sheets (SDS) are prepared for specific chemical substances identified by CAS number. The sds_record currently has cas_number as a STRING field, which is a denormalized reference. Adding ca',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the raw material master record.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: SDS documents in chemical manufacturing are supplier-provided and must be maintained per vendor. Replacing denormalized supplier_name and supplier_contact text fields with a proper vendor FK enables S',
    `author_contact` STRING COMMENT 'Contact details for the SDS author (phone or email).',
    `author_name` STRING COMMENT 'Name of the person or entity that authored the SDS.',
    `composition_ingredients` STRING COMMENT 'Structured description of chemical constituents and their concentrations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SDS record was first created in the system.',
    `disposal_considerations` STRING COMMENT 'Guidance on safe disposal methods and waste handling.',
    `document_checksum` STRING COMMENT 'SHA‑256 hash of the SDS file for integrity verification.. Valid values are `^[A-Fa-f0-9]{64}$`',
    `document_file_size_bytes` BIGINT COMMENT 'Size of the SDS file in bytes.',
    `document_url` STRING COMMENT 'Link to the electronic SDS file stored in the document repository.',
    `ecological_information` STRING COMMENT 'Environmental impact data, including biodegradability and aquatic toxicity.',
    `effective_date` DATE COMMENT 'Date on which the SDS becomes effective.',
    `expiry_date` DATE COMMENT 'Date after which the SDS is no longer valid.',
    `ghs_pictograms` STRING COMMENT 'Pipe‑separated list of GHS pictogram identifiers displayed on the SDS.',
    `hazard_classifications` STRING COMMENT 'Pipe‑separated list of GHS hazard classes applicable to the material (e.g., flammable|corrosive).',
    `hazard_statements` STRING COMMENT 'Full text of GHS hazard statements (H‑phrases) for the material.',
    `is_current_version` BOOLEAN COMMENT 'Indicates whether this SDS entry is the latest active version.',
    `jurisdiction` STRING COMMENT 'Three‑letter ISO country code indicating the regulatory region the SDS complies with.. Valid values are `^[A-Z]{3}$`',
    `language` STRING COMMENT 'ISO language code of the SDS content.. Valid values are `en|es|fr|de|zh`',
    `physical_chemical_properties` STRING COMMENT 'Key physical and chemical data (e.g., boiling point, pH, flash point).',
    `precautionary_statements` STRING COMMENT 'Full text of GHS precautionary statements (P‑phrases) for the material.',
    `regulatory_information` STRING COMMENT 'Applicable regulations (e.g., REACH, TSCA, OSHA) and compliance notes.',
    `revision_number` STRING COMMENT 'Sequential revision number for the SDS document.',
    `sds_record_status` STRING COMMENT 'Current lifecycle status of the SDS record.. Valid values are `active|inactive|archived|draft`',
    `sds_version` STRING COMMENT 'Version identifier of the SDS document (e.g., 1.0, 2.1).',
    `signal_word` STRING COMMENT 'GHS signal word (Danger or Warning) for the material.. Valid values are `danger|warning`',
    `stability_reactivity` STRING COMMENT 'Information on chemical stability, incompatibilities, and hazardous reactions.',
    `toxicological_information` STRING COMMENT 'Data on acute, chronic, and other toxicological effects.',
    `transport_information` STRING COMMENT 'Regulatory transport classification, UN number, packing group, and handling instructions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SDS record.',
    CONSTRAINT pk_sds_record PRIMARY KEY(`sds_record_id`)
) COMMENT 'Safety Data Sheet (SDS/MSDS) master records for each raw material, maintained in compliance with GHS (Globally Harmonized System) and OSHA HazCom standards. Each record captures the 16-section GHS SDS structure including supplier identity, hazard identification, composition/ingredient information, first-aid measures, fire-fighting measures, accidental release measures, handling and storage, exposure controls/PPE, physical and chemical properties, stability and reactivity, toxicological information, ecological information, disposal considerations, transport information, regulatory information, and other information. Tracks SDS version number, effective date, expiry date, issuing supplier, language, and regulatory jurisdiction. Linked to material master and GHS classification records. Supports EHS compliance, worker safety training, and emergency response.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` (
    `rawmaterial_ghs_classification_id` BIGINT COMMENT 'System‑generated unique identifier for each GHS classification entry.',
    `material_master_id` BIGINT COMMENT 'Unique identifier of the raw material to which this classification applies.',
    `sds_record_id` BIGINT COMMENT 'Identifier of the associated Safety Data Sheet.',
    `supplier_material_id` BIGINT COMMENT 'Identifier of the supplier providing the raw material.',
    `classification_authority` STRING COMMENT 'Organization or agency that approved the classification.',
    `classification_basis` STRING COMMENT 'Method used to derive the GHS classification.. Valid values are `Test data|Read‑across|Expert judgment|Calculation`',
    `classification_date` DATE COMMENT 'Calendar date the classification was determined.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the classification record was first created.',
    `effective_from` DATE COMMENT 'Start date the classification is valid.',
    `effective_until` DATE COMMENT 'Expiration date of the classification; null if indefinite.',
    `hazard_category` STRING COMMENT 'Category level within the hazard class (1 = most severe).. Valid values are `1|2|3|4|5`',
    `hazard_class` STRING COMMENT 'Primary GHS hazard class (e.g., Flammable Liquid, Acute Toxicity).',
    `hazard_statement_codes` STRING COMMENT 'Comma‑separated list of H‑codes describing the hazards.',
    `hazard_statement_text` STRING COMMENT 'Narrative description of each hazard statement (H‑code).',
    `is_hazardous` BOOLEAN COMMENT 'True if the material carries any GHS hazard classification.',
    `material_cas_number` STRING COMMENT 'Standardized CAS registry number identifying the chemical substance.. Valid values are `^d{2,7}-d{2}-d$`',
    `material_supplier_code` STRING COMMENT 'Identifier assigned by the supplier for this raw material.',
    `notes` STRING COMMENT 'Additional remarks or observations about the classification.',
    `pictogram_codes` STRING COMMENT 'Comma‑separated list of pictogram identifiers required on the label.',
    `pictogram_description` STRING COMMENT 'Human‑readable description of each pictogram required.',
    `precautionary_statement_codes` STRING COMMENT 'Comma‑separated list of P‑codes providing safety measures.',
    `precautionary_statement_text` STRING COMMENT 'Narrative description of each precautionary statement (P‑code).',
    `rawmaterial_ghs_classification_status` STRING COMMENT 'Operational status of the classification entry.. Valid values are `active|inactive|pending|retired`',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory regime governing the classification.. Valid values are `GHS Rev 9|EU CLP|OSHA HazCom 2012|Canada WHMIS`',
    `signal_word` STRING COMMENT 'Signal word required on the label (Danger or Warning).. Valid values are `Danger|Warning`',
    `source_system` STRING COMMENT 'Originating system that supplied the classification information.. Valid values are `SAP MM|LIMS|EHS`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the record.',
    `version_number` STRING COMMENT 'Sequential version of the classification record for audit purposes.',
    CONSTRAINT pk_rawmaterial_ghs_classification PRIMARY KEY(`rawmaterial_ghs_classification_id`)
) COMMENT 'GHS (Globally Harmonized System) and CLP (Classification, Labelling and Packaging) hazard classification records for each raw material substance. This product is the exclusive SSOT for GHS-framework hazard data: hazard class (flammable liquid, acute toxicity, skin corrosion, respiratory sensitizer, carcinogen, environmental hazard, etc.), hazard category (Category 1, 2, 3, etc.), signal word (Danger/Warning), hazard statements (H-codes), precautionary statements (P-codes), pictogram codes (GHS01-GHS09), classification basis (test data, read-across, expert judgment, calculation method for mixtures), classification date, regulatory jurisdiction (GHS Rev 9, EU CLP, OSHA HazCom 2012), and classification authority. Non-GHS hazard frameworks (NFPA, DOT, EPA, OSHA PEL) are owned by material_hazard_profile. Supports SDS Section 2 authoring, label generation, transport classification, and REACH/CLP compliance reporting.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` (
    `material_specification_id` BIGINT COMMENT 'System-generated unique identifier for each material specification record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Specification development and maintenance (QC lab, R&D, regulatory affairs) are charged to cost centers in chemical manufacturing. Required for QC/regulatory budget variance reporting and overhead all',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: New material specification development in chemical manufacturing is funded via R&D or regulatory internal orders. Links specification creation cost to the authorizing project order for spend tracking ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Material specifications describe a specific material; linking to material_master eliminates duplicate CAS number and enables direct access to material attributes.',
    `sds_record_id` BIGINT COMMENT 'Identifier linking to the associated Safety Data Sheet.',
    `analytical_method` STRING COMMENT 'Primary analytical technique used to verify the specification.. Valid values are `GC|HPLC|ICP-MS|FTIR|NMR`',
    `approval_authority` STRING COMMENT 'Name of the person or department that approved the specification.',
    `approval_date` DATE COMMENT 'Date on which the specification was approved.',
    `assay_max_percent` DECIMAL(18,2) COMMENT 'Maximum acceptable assay/purity percentage for the material.',
    `assay_min_percent` DECIMAL(18,2) COMMENT 'Minimum acceptable assay/purity percentage for the material.',
    `color_aph` STRING COMMENT 'Color measurement according to the APHA (American Public Health Association) scale.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification record was first created.',
    `density_max_g_per_cm3` DECIMAL(18,2) COMMENT 'Maximum acceptable density.',
    `density_min_g_per_cm3` DECIMAL(18,2) COMMENT 'Minimum acceptable density.',
    `effective_date` DATE COMMENT 'Date on which the specification becomes active for incoming material acceptance.',
    `expiration_date` DATE COMMENT 'Date after which the specification is no longer valid (nullable for open‑ended specifications).',
    `hazard_classification` STRING COMMENT 'GHS hazard class applicable to the material.. Valid values are `explosive|flammable|corrosive|toxic|environmental_hazard|none`',
    `heavy_metals_ppm_limit` DECIMAL(18,2) COMMENT 'Maximum permissible concentration of heavy metals expressed in parts per million.',
    `material_specification_status` STRING COMMENT 'Current lifecycle status of the specification.. Valid values are `draft|active|approved|superseded|retired`',
    `microbiological_limit` STRING COMMENT 'Acceptable microbiological criteria (e.g., total viable count, specific pathogens).',
    `moisture_max_percent` DECIMAL(18,2) COMMENT 'Maximum allowable moisture content.',
    `moisture_min_percent` DECIMAL(18,2) COMMENT 'Minimum allowable moisture content.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the specification.',
    `particle_size_max_microns` DECIMAL(18,2) COMMENT 'Maximum acceptable particle size.',
    `particle_size_min_microns` DECIMAL(18,2) COMMENT 'Minimum acceptable particle size.',
    `ph_max` DECIMAL(18,2) COMMENT 'Maximum acceptable pH value for the material.',
    `ph_min` DECIMAL(18,2) COMMENT 'Minimum acceptable pH value for the material.',
    `regulatory_status` STRING COMMENT 'Current compliance status of the material with applicable regulations.. Valid values are `compliant|non_compliant|pending|exempt`',
    `residual_solvent_limit_ppm` DECIMAL(18,2) COMMENT 'Maximum allowable residual solvent concentration.',
    `specification_name` STRING COMMENT 'Human‑readable name of the material specification.',
    `specification_version` STRING COMMENT 'Version label of the specification (e.g., v1.0, v2.1).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the specification record.',
    `viscosity_max_cp` DECIMAL(18,2) COMMENT 'Maximum acceptable viscosity in centipoise.',
    `viscosity_min_cp` DECIMAL(18,2) COMMENT 'Minimum acceptable viscosity in centipoise.',
    CONSTRAINT pk_material_specification PRIMARY KEY(`material_specification_id`)
) COMMENT 'Incoming raw material quality specifications defining the acceptance criteria for each material purchased and received. Each specification record captures the material, specification version, effective date, specification owner, and a full set of quality parameters including assay/purity limits (min/max), moisture content limits, heavy metals limits (PPM), pH range, color (APHA/Gardner), viscosity range, density range, particle size distribution, residual solvent limits, microbiological limits, and any material-specific analytical parameters. Includes specification status (draft, approved, superseded), approval authority, and links to the associated test methods. Serves as the acceptance standard for incoming QC testing and COA review.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` (
    `supplier_material_id` BIGINT COMMENT 'System-generated unique identifier for each supplier-material qualification record.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to supply.contract. Business justification: In chemical manufacturing procurement, each approved supplier material is governed by a specific supply contract defining price, quality, and delivery terms. Linking supplier_material to contract enab',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Supplier invoices are charged to the responsible cost center; finance needs supplier_material.cost_center_id for accurate cost‑of‑goods‑sold and budgeting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Supplier material procurement postings reference specific GL accounts (raw material inventory, MRO, hazardous material accounts). Chemical manufacturers assign GL accounts at supplier-material level f',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Supplier material procurement for specific projects (new product development, plant trials, regulatory testing) is charged to internal orders. Chemical manufacturers use internal orders to track proje',
    `material_master_id` BIGINT COMMENT 'Unique identifier of the raw material offered by the supplier.',
    `sds_record_id` BIGINT COMMENT 'Identifier of the Safety Data Sheet document stored in the EHS system.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the supplier providing the material.',
    `vendor_site_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_site. Business justification: In chemical manufacturing, a supplier material is produced at a specific vendor manufacturing site, not just by the vendor entity. Site-level traceability is required for supply risk assessment, site-',
    `approved_manufacturer` STRING COMMENT 'Manufacturer that has been approved to produce the material for this supplier.',
    `compliance_expiry_date` DATE COMMENT 'Date when the current compliance certification expires.',
    `compliance_status` STRING COMMENT 'Overall regulatory compliance status of the material from this supplier.. Valid values are `compliant|non‑compliant|pending|exempt`',
    `country_of_origin` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the country where the material originates.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the price.',
    `effective_from` DATE COMMENT 'Date when this supplier‑material record becomes effective.',
    `effective_until` DATE COMMENT 'Date when this supplier‑material record expires (null if open‑ended).',
    `epa_regulation_code` STRING COMMENT 'EPA code applicable to the material (e.g., for emissions reporting).',
    `ghs_classification` STRING COMMENT 'Globally Harmonized System hazard class codes for the material.',
    `hazardous_material_flag` BOOLEAN COMMENT 'True if the material is classified as hazardous under GHS.',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit related to this material.',
    `lead_time_days` STRING COMMENT 'Standard number of calendar days from order placement to receipt.',
    `lot_control_flag` BOOLEAN COMMENT 'Indicates whether the material is tracked by lot numbers.',
    `material_grade` STRING COMMENT 'Grade or quality level of the material supplied.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that can be ordered from the supplier for this material.',
    `notes` STRING COMMENT 'Additional remarks or comments about the supplier‑material relationship.',
    `packaging_type` STRING COMMENT 'Standard packaging format used for the material.. Valid values are `drum|bag|bulk|pallet|cylinder|bottle`',
    `preferred_supplier` BOOLEAN COMMENT 'Indicates whether the supplier is marked as preferred for this material.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Agreed price for one unit of the material (excluding taxes and freight).',
    `purity_percent` DECIMAL(18,2) COMMENT 'Purity of the material expressed as a percentage.',
    `qualification_date` DATE COMMENT 'Date when the supplier was last qualified for the material.',
    `qualification_status` STRING COMMENT 'Current qualification state of the supplier for this material.. Valid values are `approved|conditional|probationary|disqualified`',
    `reach_registration_number` STRING COMMENT 'European Chemicals Agency registration identifier for the material.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `sds_version` STRING COMMENT 'Version number of the SDS document.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the material can be stored before expiration.',
    `storage_condition` STRING COMMENT 'Recommended storage condition (e.g., temperature, humidity).',
    `supplier_part_number` STRING COMMENT 'Supplier-assigned part number for the material.',
    `supplier_trade_name` STRING COMMENT 'Commercial name under which the supplier conducts business.',
    `supply_risk_tier` STRING COMMENT 'Risk classification of the supplier’s ability to deliver the material.. Valid values are `low|medium|high|critical`',
    `tsca_status` STRING COMMENT 'Regulatory status of the material under the U.S. Toxic Substances Control Act.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for ordering and inventory tracking of the material.. Valid values are `kg|lb|g|l|ml|ton`',
    CONSTRAINT pk_supplier_material PRIMARY KEY(`supplier_material_id`)
) COMMENT 'Approved Supplier List (ASL) records capturing qualified supplier-to-material relationships for raw material procurement. Each record represents a specific suppliers offering of a raw material including supplier trade name, part number, approved manufacturer, country of origin, lead time, MOQ, qualification status (approved, conditional, probationary, disqualified), qualification date, last audit date, preferred supplier flag, and supply risk tier. Manages the source list for each raw material and supports SAP MM source list and info record management. Enables procurement to identify qualified sources and supports supply chain risk management.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` (
    `material_qualification_id` BIGINT COMMENT 'System generated unique identifier for each material qualification record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Material qualification trials (lab evaluation, pilot, production trials) generate costs charged to cost centers. Chemical manufacturers track qualification spend for procurement budget control and mak',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: Qualification trial costs are classified by cost elements (external lab fees, internal testing labor, pilot plant costs) in chemical manufacturing cost accounting. Enables qualification cost analysis ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Material qualification projects are funded via internal orders (R&D or procurement project orders) in chemical manufacturing. Links qualification trials to authorized project spend for cost control an',
    `material_master_id` BIGINT COMMENT 'Identifier of the raw material being qualified.',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Material qualification validates a supplier-material combination against defined quality specifications. Linking material_qualification to material_specification establishes which specification versio',
    `supplier_material_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.supplier_material. Business justification: Material qualification formally qualifies a specific supplier-material combination (ASL record). The supplier_material table IS the Approved Supplier List entry capturing the supplier-to-material rela',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier providing the material.',
    `vendor_qualification_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_qualification. Business justification: In chemical manufacturing GMP, material qualification decisions are directly informed by vendor qualification assessments. Linking material_qualification to vendor_qualification enables traceability b',
    `decision_effective_date` DATE COMMENT 'Date on which the qualification decision becomes effective for production use.',
    `lab_evaluation_result` STRING COMMENT 'Outcome of the lab‑scale evaluation: passed, failed, or conditional.. Valid values are `passed|failed|conditional`',
    `material_qualification_status` STRING COMMENT 'Current lifecycle status of the qualification record.. Valid values are `draft|in_review|approved|rejected|closed`',
    `pilot_trial_result` STRING COMMENT 'Result of the pilot‑scale trial used to assess material performance before full production.. Valid values are `passed|failed|conditional`',
    `production_trial_result` STRING COMMENT 'Result of the production‑scale trial confirming material suitability for routine manufacturing.. Valid values are `passed|failed|conditional`',
    `qualification_decision` STRING COMMENT 'Final qualification decision after all reviews: approved, rejected, or conditional.. Valid values are `approved|rejected|conditional`',
    `qualification_number` STRING COMMENT 'Business identifier assigned to the qualification request, used for tracking and reference.',
    `qualification_protocol_ref` STRING COMMENT 'Reference code or document identifier for the qualification protocol used.',
    `qualification_request_date` TIMESTAMP COMMENT 'Timestamp when the qualification request was submitted.',
    `qualification_scope` STRING COMMENT 'Narrative description of the scope of the qualification (e.g., specific product lines, process steps).',
    `qualification_type` STRING COMMENT 'Type of qualification being performed: new material, new supplier, change qualification, or requalification.. Valid values are `new_material|new_supplier|change|requalification`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the qualification record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the qualification record.',
    `regulatory_review_outcome` STRING COMMENT 'Outcome of the regulatory compliance review (e.g., EPA, REACH).. Valid values are `approved|rejected|conditional`',
    `requalification_interval_days` STRING COMMENT 'Number of days after which the material must be re‑qualified.',
    `technical_review_outcome` STRING COMMENT 'Decision of the technical review after evaluating trial data.. Valid values are `approved|rejected|conditional`',
    CONSTRAINT pk_material_qualification PRIMARY KEY(`material_qualification_id`)
) COMMENT 'Tracks the formal qualification lifecycle of raw materials and supplier-material combinations through the approved supplier qualification process. Each record captures the qualification request date, qualification type (new material, new supplier, change qualification, requalification), qualification scope, qualification protocol reference, lab-scale evaluation results, pilot-scale trial results, production-scale trial results, technical review outcome, regulatory review outcome, qualification decision (approved, rejected, conditional), qualification effective date, requalification interval, and responsible quality engineer. Supports the MOC (Management of Change) process for raw material changes and ensures only qualified materials enter production.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` (
    `incoming_inspection_id` BIGINT COMMENT 'Surrogate primary key for the incoming inspection record.',
    `coa_document_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.coa_document. Business justification: Incoming quality inspection uses the suppliers Certificate of Analysis (COA) as a reference document for comparison against specifications. Linking incoming_inspection to coa_document enables direct ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: QC incoming inspection activities (lab testing, sampling, analyst time) are charged to cost centers. Chemical manufacturers track inspection costs per cost center for QC overhead allocation and budget',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: Incoming inspection costs are classified by cost elements (lab testing, external analysis, sampling labor) in chemical manufacturing cost accounting. Enables QC cost analysis by cost type for overhead',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Incoming quality inspection in chemical manufacturing is directly triggered by and associated with a goods receipt event. This link is fundamental for QC-to-receiving traceability, enabling inspection',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Special inspection campaigns (new supplier qualification, regulatory-triggered re-inspections, method validation) are funded via internal orders in SAP-based chemical manufacturing. Enables project-le',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Incoming inspection events are performed on a specific received lot. The lot_record is the parent entity (created at receipt), and incoming_inspection is the child event performed against that lot. Ad',
    `material_master_id` BIGINT COMMENT 'Identifier of the raw material inspected.',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Incoming inspection validates received material against the applicable material specification (acceptance criteria). Linking incoming_inspection to material_specification identifies which specificatio',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supply.po_line. Business justification: Incoming inspection in chemical manufacturing is performed at PO line item granularity — each line may contain different materials with different inspection requirements. Linking inspection to po_line',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order associated with the delivery.',
    `supplier_material_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.supplier_material. Business justification: Incoming inspection is performed on material received from a specific approved supplier. Linking to supplier_material (the ASL record) allows direct traceability from inspection results to the specifi',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier providing the material.',
    `appearance` STRING COMMENT 'Observed appearance description (e.g., clear, cloudy).',
    `assay_percent` DECIMAL(18,2) COMMENT 'Assay result expressed as percentage.',
    `batch_number` STRING COMMENT 'Associated production batch number if material allocated to batch.',
    `capap_triggered` BOOLEAN COMMENT 'Indicates if a CAPA workflow was triggered due to rejection.',
    `cas_number` STRING COMMENT 'Unique CAS registry number for the material.',
    `color` STRING COMMENT 'Color description of the material.',
    `comments` STRING COMMENT 'Free‑text comments entered by inspector.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was created in the system.',
    `delivery_note_number` STRING COMMENT 'Delivery note (ASN) number from supplier.',
    `density_kg_m3` DECIMAL(18,2) COMMENT 'Density in kilograms per cubic meter.',
    `disposition_instructions` STRING COMMENT 'Instructions for material disposition based on decision.',
    `hold_reason` STRING COMMENT 'Reason for placing material on hold, if applicable.',
    `inspection_date` DATE COMMENT 'Date when the inspection was performed.',
    `inspection_number` STRING COMMENT 'Unique inspection lot number assigned by SAP QM.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection record.. Valid values are `draft|in_progress|completed|closed`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Timestamp of inspection completion.',
    `inspection_type` STRING COMMENT 'Type of inspection performed as per ANSI/ASQ Z1.4.. Valid values are `identity_test|full_coa_review|skip_lot|reduced|tightened`',
    `lot_number` STRING COMMENT 'Lot or batch number of the received material.',
    `moisture_percent` DECIMAL(18,2) COMMENT 'Moisture content percentage.',
    `oos_flag` BOOLEAN COMMENT 'Indicates if any test result was out of specification.',
    `oot_flag` BOOLEAN COMMENT 'Indicates if any trend deviation was observed.',
    `overall_decision` STRING COMMENT 'Overall inspection decision.. Valid values are `accept|reject|hold|conditional_release`',
    `particle_size_um` DECIMAL(18,2) COMMENT 'Average particle size in micrometers.',
    `ph_value` DECIMAL(18,2) COMMENT 'Measured pH value of the material.',
    `quality_flag` STRING COMMENT 'Simplified quality flag derived from decision.. Valid values are `pass|fail|conditional`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity of material received in base unit.',
    `release_date` DATE COMMENT 'Date when material was released from hold.',
    `sample_plan` STRING COMMENT 'Sampling plan used for the inspection (e.g., AQL level).',
    `sample_size` STRING COMMENT 'Number of units sampled from the lot.',
    `storage_location` STRING COMMENT 'Warehouse or tank farm location where material is stored.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for received quantity (e.g., kg, L).. Valid values are `kg|L|g|mL|ton`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection record.',
    `viscosity_cp` DECIMAL(18,2) COMMENT 'Viscosity measured in centipoise.',
    CONSTRAINT pk_incoming_inspection PRIMARY KEY(`incoming_inspection_id`)
) COMMENT 'Records of incoming quality inspection events performed on received raw material lots at the plant gate, warehouse, or tank farm. Each inspection record captures the inspection lot number (SAP QM), material, supplier, purchase order reference, delivery note number, received quantity, sample plan and sample size, inspection date, inspection type (identity test, full COA review, skip lot, reduced, tightened per ANSI/ASQ Z1.4), individual test results against specification parameters (assay, pH, moisture, appearance, color, viscosity, density, particle size, etc.), overall inspection decision (accept, reject, hold, conditional release), disposition instructions, inspector ID, inspection completion timestamp, and any OOS (Out of Specification) or OOT (Out of Trend) findings. Triggers CAPA workflows on rejection. Serves as the quality gate controlling raw material entry into unrestricted inventory and is the SSOT for the accept/reject decision at the rawmaterial domain boundary — downstream quality investigations and CAPAs are owned by the quality domain.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` (
    `lot_record_id` BIGINT COMMENT 'System generated unique identifier for each lot record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Required for customer‑specific lot traceability in recall and regulatory reporting; each lot is allocated to a single customer order.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production lot costing allocates material and overhead to a cost center; finance uses lot_record.cost_center_id for lot‑level cost variance reports.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Every raw material lot in chemical manufacturing originates from a specific goods receipt event. This link is fundamental for lot traceability, recall management, and GMP compliance — a domain expert ',
    `lot_id` BIGINT COMMENT 'Identifier of the lot in the originating source system.',
    `material_master_id` BIGINT COMMENT 'Unique identifier of the raw material (links to material master).',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supply.po_line. Business justification: Raw material lots in chemical manufacturing are received against specific PO line items, enabling line-level cost allocation, quantity reconciliation, and lot-to-order traceability. This granular link',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: GMP lot traceability requires linking every received raw material lot to its originating purchase order. Supports recall management, cost allocation, and regulatory audit trails. Chemical manufacturin',
    `supplier_material_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.supplier_material. Business justification: Each received lot of raw material originates from a specific approved supplier-material combination (ASL record). Linking lot_record to supplier_material enables direct traceability from lot receipt b',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the supplier providing the lot.',
    `batch_type` STRING COMMENT 'Classification of the lot as raw material, intermediate, or additive.. Valid values are `raw_material|intermediate|additive`',
    `cas_number` STRING COMMENT 'Unique CAS registry number identifying the chemical substance.',
    `chain_of_custody_notes` STRING COMMENT 'Free‑text notes documenting handling, transfers, or observations for the lot.',
    `coa_reference` STRING COMMENT 'Reference number or link to the Certificate of Analysis for the lot.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Acquisition cost per unit of the material in the lot.',
    `country_of_origin` STRING COMMENT 'Three‑letter ISO code of the country where the material originated.. Valid values are `[A-Z]{3}`',
    `expiry_date` DATE COMMENT 'Date after which the material must not be used.',
    `hazard_classification` STRING COMMENT 'GHS hazard class code(s) applicable to the material in the lot.',
    `is_recalled` BOOLEAN COMMENT 'Indicates whether the lot has been placed under a product recall.',
    `lot_creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the lot record was first created in the system.',
    `lot_last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lot record.',
    `lot_owner_department` STRING COMMENT 'Internal department responsible for the lot.',
    `lot_source_system` STRING COMMENT 'Name of the source system that supplied the lot record (e.g., SAP S/4HANA, ERP).',
    `lot_status` STRING COMMENT 'Current status of the lot for inventory and quality control.. Valid values are `unrestricted|quality_hold|blocked|expired|quarantine`',
    `manufacturing_date` DATE COMMENT 'Date the material was originally manufactured by the supplier.',
    `quality_inspection_date` DATE COMMENT 'Date on which the quality inspection was performed.',
    `quality_inspection_result` STRING COMMENT 'Result of the quality inspection (e.g., pass, fail, conditional).',
    `quality_inspection_status` STRING COMMENT 'Current status of the quality inspection for the lot.. Valid values are `pending|passed|failed`',
    `receipt_date` DATE COMMENT 'Date the lot was received into inventory.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity of material received in the lot.',
    `retest_date` DATE COMMENT 'Scheduled date for mandatory retesting of the lot.',
    `sds_version` STRING COMMENT 'Version identifier of the Safety Data Sheet attached at receipt.',
    `storage_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity condition of the storage environment for the lot.',
    `storage_location` STRING COMMENT 'Identifier of the warehouse or storage bin where the lot is kept.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Temperature condition of the storage environment for the lot.',
    `supplier_lot_number` STRING COMMENT 'Lot or batch number assigned by the supplier.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total acquisition cost for the lot (quantity × cost per unit).',
    `uom` STRING COMMENT 'Unit of measure for the received quantity (e.g., kg, L).',
    CONSTRAINT pk_lot_record PRIMARY KEY(`lot_record_id`)
) COMMENT 'Lot-level traceability records for each received batch or lot of raw material. Each lot record captures the internal lot number, supplier lot/batch number, material, supplier, receipt date, manufacturing date, expiry date, retest date, received quantity, unit of measure, storage location, storage conditions (temperature, humidity), lot status (unrestricted, quality hold, blocked, expired, quarantine), COA reference, SDS version at receipt, country of origin, and chain of custody notes. Supports FIFO/FEFO inventory management, lot traceability for production batch records, and regulatory recall management. Serves as the foundational traceability record linking procurement to production.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` (
    `coa_document_id` BIGINT COMMENT 'System-generated unique identifier for the COA document.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: CoA documents are physically received with goods receipts in chemical manufacturing. Linking CoA to goods receipt enables GR-level quality documentation retrieval required for batch release decisions ',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: A Certificate of Analysis (COA) is issued by the supplier for a specific received lot shipment. The COA is the child document belonging to a lot_record (parent). Adding lot_record_id to coa_document e',
    `material_master_id` BIGINT COMMENT 'Unique identifier of the material in the enterprise master data.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Certificate of Analysis documents in chemical manufacturing are received per purchase order shipment. Linking CoA to PO enables PO-level quality documentation retrieval, supplier quality audits, and r',
    `supplier_material_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.supplier_material. Business justification: A COA document is received from a specific supplier for a specific material, corresponding to an approved supplier-material (ASL) record. Adding supplier_material_id to coa_document enables direct lin',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the supplier in the enterprise master data.',
    `analytical_method` STRING COMMENT 'Name or code of the analytical technique used for testing (e.g., HPLC, GC-MS).',
    `assay_pass` BOOLEAN COMMENT 'Indicates whether the assay result meets the specification limit.',
    `assay_percent` DECIMAL(18,2) COMMENT 'Measured assay value expressed as a percentage of the active ingredient.',
    `assay_spec_limit_percent` DECIMAL(18,2) COMMENT 'Maximum allowable deviation for assay percentage as defined in the specification.',
    `cas_number` STRING COMMENT 'Unique numeric identifier assigned to the chemical substance.. Valid values are `^d{2,7}-d{2}-d$`',
    `coa_document_status` STRING COMMENT 'Current lifecycle status of the COA document.. Valid values are `draft|issued|archived|retracted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the COA record was first entered into the system.',
    `document_file_hash` STRING COMMENT 'SHA‑256 hash of the COA file for integrity verification.',
    `document_file_path` STRING COMMENT 'File system or object‑store path where the COA PDF is stored.',
    `document_number` STRING COMMENT 'Business-assigned identifier printed on the COA.',
    `document_title` STRING COMMENT 'Descriptive title of the COA document, often includes material and lot information.',
    `expiry_date` DATE COMMENT 'Date after which the material is no longer considered usable.',
    `heavy_metals_ppm` DECIMAL(18,2) COMMENT 'Total concentration of regulated heavy metals expressed in parts per million.',
    `heavy_metals_spec_limit_ppm` DECIMAL(18,2) COMMENT 'Maximum allowable concentration of heavy metals.',
    `issue_date` DATE COMMENT 'Date the COA was issued by the suppliers laboratory.',
    `lab_location` STRING COMMENT 'Physical location (city, country) of the testing laboratory.',
    `lab_name` STRING COMMENT 'Name of the laboratory that performed the analysis.',
    `manufacturing_date` DATE COMMENT 'Date the material batch was manufactured by the supplier.',
    `material_name` STRING COMMENT 'Common name of the raw material covered by the COA.',
    `moisture_percent` DECIMAL(18,2) COMMENT 'Measured moisture content expressed as a percentage.',
    `moisture_spec_limit_percent` DECIMAL(18,2) COMMENT 'Maximum allowable moisture percentage.',
    `overall_pass_fail` BOOLEAN COMMENT 'Boolean flag indicating whether the material meets all specified criteria.',
    `overall_result` STRING COMMENT 'High‑level pass/fail/conditional conclusion for the COA.. Valid values are `pass|fail|conditional`',
    `ph_pass` BOOLEAN COMMENT 'Indicates whether the pH measurement falls within the specified range.',
    `ph_spec_max` DECIMAL(18,2) COMMENT 'Maximum acceptable pH value as per specification.',
    `ph_spec_min` DECIMAL(18,2) COMMENT 'Minimum acceptable pH value as per specification.',
    `ph_value` DECIMAL(18,2) COMMENT 'Measured pH of the material or solution.',
    `purity_pass` BOOLEAN COMMENT 'Indicates whether the purity result meets the specification limit.',
    `purity_percent` DECIMAL(18,2) COMMENT 'Measured purity of the material expressed as a percentage.',
    `purity_spec_limit_percent` DECIMAL(18,2) COMMENT 'Maximum allowable deviation for purity percentage.',
    `residual_solvents_ppm` DECIMAL(18,2) COMMENT 'Measured concentration of residual solvents in parts per million.',
    `residual_solvents_spec_limit_ppm` DECIMAL(18,2) COMMENT 'Maximum permissible level of residual solvents.',
    `signatory_title` STRING COMMENT 'Job title or role of the authorized signatory.',
    `supplier_name` STRING COMMENT 'Legal name of the supplier that issued the COA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the COA record.',
    CONSTRAINT pk_coa_document PRIMARY KEY(`coa_document_id`)
) COMMENT 'Certificate of Analysis (COA) documents received from suppliers for each raw material lot shipment. Each COA record captures the supplier name, supplier lot number, material name, CAS number, manufacturing date, expiry date, test parameters and results as reported by the supplier (assay, purity, moisture, pH, heavy metals, residual solvents, appearance, etc.), analytical methods used, specification limits, pass/fail status per parameter, overall COA conclusion, issuing laboratory, authorized signatory, COA issue date, and document file reference. Supports incoming inspection, lot release decisions, and regulatory traceability. Enables COA-to-specification comparison for incoming QC.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` (
    `reach_registration_id` BIGINT COMMENT 'Unique surrogate key for each REACH registration record.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: REACH registration dossiers are filed for specific chemical substances identified by CAS number. The reach_registration table currently has cas_number as a STRING field. Adding cas_registry_id as a pr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: REACH registration activities (ECHA fees, dossier preparation, testing) are charged to regulatory affairs cost centers. Chemical manufacturers must track REACH compliance spend per cost center for reg',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: REACH registration projects are managed as internal orders in chemical manufacturing (project-based spend for ECHA submission costs, testing, legal fees). Enables per-substance registration cost track',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: REACH registrations are held by a specific legal entity. Chemical manufacturers with multiple EU entities must track which legal entity holds each registration for compliance liability, regulatory rep',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: REACH registration dossiers are maintained for specific chemical substances managed as raw materials in the enterprise. Linking reach_registration to material_master establishes the critical connectio',
    `vendor_id` BIGINT COMMENT 'Surrogate key referencing the party that holds the registration.',
    `vendor_qualification_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_qualification. Business justification: REACH compliance verification is a mandatory component of vendor qualification in chemical manufacturing. Linking reach_registration to vendor_qualification enables tracking which qualification assess',
    `approval_date` DATE COMMENT 'Date the registration was approved by ECHA.',
    `authorisation_status` STRING COMMENT 'Authorisation outcome for substances listed under Annex XIV (SVHC).. Valid values are `authorised|not_authorised|pending`',
    `co_registrant_flag` BOOLEAN COMMENT 'True if the entity participates as a co‑registrant in the dossier.',
    `compliance_deadline` DATE COMMENT 'Regulatory deadline for meeting compliance obligations related to the registration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the registration record was first created in the data lake.',
    `data_source_system` STRING COMMENT 'System of record that supplied the registration data.. Valid values are `SAP_MM|ECHA|Other`',
    `dossier_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the REACH dossier.',
    `downstream_use_notification` STRING COMMENT 'Free‑text description of notified downstream uses of the substance.',
    `ec_number` STRING COMMENT 'European Community (EC) number assigned to the substance.. Valid values are `^d{1,7}$`',
    `echa_registration_number` STRING COMMENT 'Identifier assigned by the European Chemicals Agency for the REACH registration dossier.',
    `effective_from` DATE COMMENT 'Date when the registration becomes legally effective.',
    `effective_until` DATE COMMENT 'Date when the registration expires or is no longer effective (nullable for open‑ended).',
    `evaluation_status` STRING COMMENT 'Outcome of the ECHA Committee for Risk Assessment (CoRAP) evaluation.. Valid values are `CoRAP|non-CoRAP|pending`',
    `expiry_date` DATE COMMENT 'Date the registration expires and must be renewed.',
    `joint_submission_reference` STRING COMMENT 'Reference identifier for a joint registration submission with other registrants.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the last compliance review of the registration.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the registration record.. Valid values are `active|inactive|closed|suspended`',
    `registration_identifier` STRING COMMENT 'Business identifier used internally to reference the REACH registration dossier.',
    `registration_notes` STRING COMMENT 'Free‑form notes captured by compliance staff regarding the registration.',
    `registration_status` STRING COMMENT 'Current processing status of the REACH registration within ECHA.. Valid values are `pending|submitted|approved|rejected|withdrawn`',
    `registration_type` STRING COMMENT 'Indicates whether the entity is the lead registrant, a member registrant, or a co‑registrant.. Valid values are `lead|member|co-registrant`',
    `registration_version` STRING COMMENT 'Version number of the registration dossier, incremented on each amendment.',
    `restriction_status` STRING COMMENT 'Status of any restriction under Annex XVII.. Valid values are `restricted|not_restricted|pending`',
    `submission_date` DATE COMMENT 'Date the registration dossier was submitted to ECHA.',
    `substance_classification` STRING COMMENT 'Classification of the substance (e.g., hazardous, non‑hazardous) according to GHS/TSCA.',
    `substance_name` STRING COMMENT 'Common or trade name of the chemical substance covered by the REACH registration.',
    `svhc_candidate_date` DATE COMMENT 'Date the substance was added to the SVHC candidate list.',
    `svhc_candidate_flag` BOOLEAN COMMENT 'Indicates whether the substance is currently a SVHC candidate.',
    `tonnage_band` STRING COMMENT 'Annual tonnage range for which the substance is registered.. Valid values are `0-1t|1-10t|10-100t|100-1000t|>1000t`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the registration record.',
    CONSTRAINT pk_reach_registration PRIMARY KEY(`reach_registration_id`)
) COMMENT 'REACH (Registration, Evaluation, Authorisation and Restriction of Chemicals) registration dossier and compliance records for chemical substances manufactured or imported into the EU/EEA. Each record captures the substance identity (CAS, EC number), ECHA registration number, registration dossier reference, tonnage band, registration holder (lead/member), co-registrant status, joint submission reference, substance evaluation status (CoRAP), authorisation status (if SVHC/Annex XIV), restriction status (Annex XVII), SVHC (Substance of Very High Concern) candidate list date, dossier update date, downstream use notifications, and compliance deadline dates. This product is the SSOT for EU REACH dossier-specific detail — the consolidated cross-jurisdictional compliance view is owned by material_regulatory_status. Supports ECHA regulatory reporting, supply chain communication obligations (Article 33), and import/export compliance for EU/EEA markets.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` (
    `material_composition_id` BIGINT COMMENT 'Unique surrogate key for each material composition record.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: Each component in a material composition record is identified by a CAS number (component_cas_number STRING exists on material_composition). The cas_registry table is the authoritative CAS number regis',
    `material_master_id` BIGINT COMMENT 'Reference to the raw material master record that this composition describes.',
    `cbi_flag` BOOLEAN COMMENT 'Indicates whether the component is a trade‑secret ingredient.',
    `component_function` STRING COMMENT 'Role of the component within the mixture. [ENUM-REF-CANDIDATE: active_ingredient|solvent|stabilizer|impurity|contaminant|carrier|other — 7 candidates stripped; promote to reference product]',
    `component_iupac_name` STRING COMMENT 'Standard IUPAC chemical name of the component.',
    `component_percentage_of_total` DECIMAL(18,2) COMMENT 'Calculated percentage of this component relative to the total composition weight.',
    `composition_code` STRING COMMENT 'Unique business code assigned to the composition version for tracking and regulatory reporting.',
    `composition_description` STRING COMMENT 'Human‑readable description of the composition, e.g., "Standard epoxy resin blend".',
    `composition_type` STRING COMMENT 'Category of the material composition based on its physical/chemical nature.. Valid values are `mixture|solution|alloy|compound|custom`',
    `concentration_max` DECIMAL(18,2) COMMENT 'Maximum allowable concentration for safety and regulatory limits.',
    `concentration_min` DECIMAL(18,2) COMMENT 'Minimum allowable concentration for compliance and quality.',
    `concentration_nominal` DECIMAL(18,2) COMMENT 'Typical concentration of the component in the composition.',
    `concentration_unit` STRING COMMENT 'Unit of measure for the concentration values.. Valid values are `%w/w|%v/v|ppm|ppb`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the composition record was first created.',
    `effective_date` DATE COMMENT 'Date when this composition version becomes effective for production and compliance.',
    `expiration_date` DATE COMMENT 'Date after which the composition must no longer be used unless re‑approved.',
    `ghs_classification` STRING COMMENT 'Globally Harmonized System hazard classification for the component.',
    `hazard_statement` STRING COMMENT 'Standard GHS hazard statement associated with the component.',
    `material_composition_status` STRING COMMENT 'Current lifecycle state of the composition record.. Valid values are `active|inactive|deprecated|pending`',
    `precautionary_statement` STRING COMMENT 'Standard GHS precautionary statement for safe handling.',
    `reachexempt_flag` BOOLEAN COMMENT 'True if the component is exempt from REACH registration.',
    `record_status` STRING COMMENT 'Indicates if the row reflects the current active composition or a historical version.. Valid values are `current|historical|archived`',
    `regulatory_review_status` STRING COMMENT 'Outcome of the internal regulatory compliance review for this composition.. Valid values are `pending|approved|rejected`',
    `source_system` STRING COMMENT 'System of record that supplied the composition data.. Valid values are `SAP MM|LIMS|EHS|Custom`',
    `total_components` STRING COMMENT 'Count of distinct component substances defined for this composition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the record.',
    `version_number` STRING COMMENT 'Sequential version identifier for changes to the composition.',
    CONSTRAINT pk_material_composition PRIMARY KEY(`material_composition_id`)
) COMMENT 'Detailed chemical composition records for raw materials that are mixtures, blends, or multi-component substances. Each record captures the parent material, component substance (CAS number, IUPAC name), component concentration (nominal, minimum, maximum), concentration unit (% w/w, % v/v, PPM), component function (active ingredient, solvent, stabilizer, impurity, contaminant), confidential business information (CBI) flag for trade secret components, and the composition version and effective date. Supports SDS Section 3 (Composition/Information on Ingredients), REACH mixture classification, formulation compatibility assessment, and regulatory disclosure obligations.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` (
    `material_regulatory_status_id` BIGINT COMMENT 'Surrogate primary key for the material regulatory status record.',
    `material_master_id` BIGINT COMMENT 'Reference to the raw material master record.',
    `compliance_deadline` DATE COMMENT 'Date by which compliance actions must be completed.',
    `compliance_effective_date` DATE COMMENT 'Date when the current compliance status became effective.',
    `compliance_last_review_date` DATE COMMENT 'Date of the most recent compliance review for this material.',
    `compliance_notes` STRING COMMENT 'Free‑text notes regarding compliance considerations, exemptions, or special conditions.',
    `compliance_status` STRING COMMENT 'Overall compliance determination for the material in the jurisdiction.. Valid values are `compliant|non_compliant|pending|exempt|restricted|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `ghs_pictograms` STRING COMMENT 'Comma‑separated list of GHS pictogram codes applicable to the material.',
    `hazard_classification` STRING COMMENT 'GHS hazard class assigned to the material.',
    `jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `record_status` STRING COMMENT 'Current lifecycle status of the regulatory status record.. Valid values are `active|inactive|archived`',
    `registration_status` STRING COMMENT 'Current registration or listing status of the material within the regulatory framework.. Valid values are `registered|listed|not_registered|pending|exempt|withdrawn`',
    `regulatory_framework` STRING COMMENT 'Regulatory regime or framework governing the material. [ENUM-REF-CANDIDATE: REACH|TSCA|CLP|OSHA|EPA_TRI|DOT|IECSC|CSCL|K_REACH|OTHER — 10 candidates stripped; promote to reference product]',
    `restriction_applicability` STRING COMMENT 'Indicates whether any usage restrictions apply to the material.. Valid values are `applicable|not_applicable|partial`',
    `restriction_level` STRING COMMENT 'Level of regulatory restriction (e.g., high, medium, low) for the material.',
    CONSTRAINT pk_material_regulatory_status PRIMARY KEY(`material_regulatory_status_id`)
) COMMENT 'Consolidated cross-jurisdictional regulatory compliance summary for each raw material, providing a single-pane view of a materials global regulatory standing across ALL applicable frameworks (REACH, TSCA, CLP, OSHA, EPA TRI, DOT, China IECSC, Japan CSCL, Korea K-REACH, and others). Each record captures substance identity, regulatory framework, jurisdiction, registration/listing status, compliance status (compliant, non-compliant, pending, exempt), restriction applicability, compliance deadlines, and responsible regulatory affairs manager. This product is the SSOT for the consolidated regulatory compliance decision (can we use this material in jurisdiction X?) — it aggregates status from jurisdiction-specific detail products (reach_registration for EU REACH dossier data, tsca_inventory for US EPA TSCA data) but adds coverage for jurisdictions without dedicated detail products and provides the single authoritative compliance summary used by procurement, import/export, and market access teams.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ADD CONSTRAINT `fk_rawmaterial_material_master_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ADD CONSTRAINT `fk_rawmaterial_sds_record_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ADD CONSTRAINT `fk_rawmaterial_sds_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ADD CONSTRAINT `fk_rawmaterial_rawmaterial_ghs_classification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ADD CONSTRAINT `fk_rawmaterial_rawmaterial_ghs_classification_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ADD CONSTRAINT `fk_rawmaterial_rawmaterial_ghs_classification_supplier_material_id` FOREIGN KEY (`supplier_material_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`supplier_material`(`supplier_material_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ADD CONSTRAINT `fk_rawmaterial_material_specification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ADD CONSTRAINT `fk_rawmaterial_material_specification_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ADD CONSTRAINT `fk_rawmaterial_supplier_material_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ADD CONSTRAINT `fk_rawmaterial_supplier_material_sds_record_id` FOREIGN KEY (`sds_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`sds_record`(`sds_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ADD CONSTRAINT `fk_rawmaterial_material_qualification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ADD CONSTRAINT `fk_rawmaterial_material_qualification_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ADD CONSTRAINT `fk_rawmaterial_material_qualification_supplier_material_id` FOREIGN KEY (`supplier_material_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`supplier_material`(`supplier_material_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_coa_document_id` FOREIGN KEY (`coa_document_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`coa_document`(`coa_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_specification`(`material_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ADD CONSTRAINT `fk_rawmaterial_incoming_inspection_supplier_material_id` FOREIGN KEY (`supplier_material_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`supplier_material`(`supplier_material_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ADD CONSTRAINT `fk_rawmaterial_lot_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ADD CONSTRAINT `fk_rawmaterial_lot_record_supplier_material_id` FOREIGN KEY (`supplier_material_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`supplier_material`(`supplier_material_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ADD CONSTRAINT `fk_rawmaterial_coa_document_lot_record_id` FOREIGN KEY (`lot_record_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`lot_record`(`lot_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ADD CONSTRAINT `fk_rawmaterial_coa_document_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ADD CONSTRAINT `fk_rawmaterial_coa_document_supplier_material_id` FOREIGN KEY (`supplier_material_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`supplier_material`(`supplier_material_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ADD CONSTRAINT `fk_rawmaterial_reach_registration_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ADD CONSTRAINT `fk_rawmaterial_reach_registration_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ADD CONSTRAINT `fk_rawmaterial_material_composition_cas_registry_id` FOREIGN KEY (`cas_registry_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`cas_registry`(`cas_registry_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ADD CONSTRAINT `fk_rawmaterial_material_composition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ADD CONSTRAINT `fk_rawmaterial_material_regulatory_status_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `chemical_mfg_ecm`.`rawmaterial`.`material_master`(`material_master_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`rawmaterial` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `chemical_mfg_ecm`.`rawmaterial` SET TAGS ('dbx_domain' = 'rawmaterial');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` SET TAGS ('dbx_subdomain' = 'material_identity');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `batch_number_required` SET TAGS ('dbx_business_glossary_term' = 'Batch Number Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `hazard_class_ghs` SET TAGS ('dbx_business_glossary_term' = 'GHS Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `humidity_requirement_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Requirement (%)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `incompatibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Incompatibility Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `is_controlled_substance` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `is_restricted_substance` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'new|active|phase_out|obsolete');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `light_sensitivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Light Sensitivity Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `material_class` SET TAGS ('dbx_business_glossary_term' = 'Material Class');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `material_class` SET TAGS ('dbx_value_regex' = 'feedstock|intermediate|solvent|catalyst|additive|excipient');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `material_master_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `molecular_formula` SET TAGS ('dbx_business_glossary_term' = 'Molecular Formula');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `molecular_weight` SET TAGS ('dbx_business_glossary_term' = 'Molecular Weight (g/mol)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State at Standard Temperature and Pressure');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `quality_control_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `retest_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Retest Interval (Days)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `sap_material_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Material Number');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name (Commercial Name)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `tsca_regulation_status` SET TAGS ('dbx_business_glossary_term' = 'TSCA Regulation Status');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `tsca_regulation_status` SET TAGS ('dbx_value_regex' = 'registered|exempt|pending');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_master` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` SET TAGS ('dbx_subdomain' = 'material_identity');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'CAS Registry Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `autoignition_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Autoignition Temperature (°C) (AIT)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `boiling_point_c` SET TAGS ('dbx_business_glossary_term' = 'Boiling Point (°C) (BP)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number (CAS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `chemical_family` SET TAGS ('dbx_business_glossary_term' = 'Chemical Family (CF)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `common_name` SET TAGS ('dbx_business_glossary_term' = 'Common Name (CN)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `epa_regulation_status` SET TAGS ('dbx_business_glossary_term' = 'EPA Regulation Status (ERS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (ED)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (°C) (FP)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `ghs_pictograms` SET TAGS ('dbx_business_glossary_term' = 'GHS Pictograms (GP)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification (HC)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'explosive|flammable|oxidizer|corrosive|toxic|environmental_hazard');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `health_hazard_statement` SET TAGS ('dbx_business_glossary_term' = 'Health Hazard Statement (HHS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `health_hazard_statement` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `health_hazard_statement` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `inchi_key` SET TAGS ('dbx_business_glossary_term' = 'InChI Key (InChI)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `is_controlled_substance` SET TAGS ('dbx_business_glossary_term' = 'Is Controlled Substance (ICS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous (IH)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `is_prohibited` SET TAGS ('dbx_business_glossary_term' = 'Is Prohibited (IP)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `is_restricted_use` SET TAGS ('dbx_business_glossary_term' = 'Is Restricted Use (IRU)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `iupac_name` SET TAGS ('dbx_business_glossary_term' = 'IUPAC Name (IUPAC)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `melting_point_c` SET TAGS ('dbx_business_glossary_term' = 'Melting Point (°C) (MP)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `molecular_formula` SET TAGS ('dbx_business_glossary_term' = 'Molecular Formula (MF)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `molecular_weight` SET TAGS ('dbx_business_glossary_term' = 'Molecular Weight (MW)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `odor_description` SET TAGS ('dbx_business_glossary_term' = 'Odor Description (OD)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State (PS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `precautionary_statement` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Statement (PS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `purity_percent` SET TAGS ('dbx_business_glossary_term' = 'Purity Percent (PP)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `reach_status` SET TAGS ('dbx_business_glossary_term' = 'REACH Status (RS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `reach_status` SET TAGS ('dbx_value_regex' = 'registered|exempt|restricted|banned');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `regulatory_review_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Date (RRD)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `smiles` SET TAGS ('dbx_business_glossary_term' = 'SMILES Notation (SMILES)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `storage_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Storage Pressure (bar) (SP)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C) (ST)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `substance_type` SET TAGS ('dbx_business_glossary_term' = 'Substance Type (ST)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `substance_type` SET TAGS ('dbx_value_regex' = 'pure|mixture|polymer|uvcb');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `synonyms` SET TAGS ('dbx_business_glossary_term' = 'Synonyms (SY)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `tsca_status` SET TAGS ('dbx_business_glossary_term' = 'TSCA Status (TS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `tsca_status` SET TAGS ('dbx_value_regex' = 'registered|exempt|restricted|banned');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`cas_registry` ALTER COLUMN `vapor_pressure_mmhg` SET TAGS ('dbx_business_glossary_term' = 'Vapor Pressure (mmHg) (VP)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `sds_record_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Record Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `author_contact` SET TAGS ('dbx_business_glossary_term' = 'Author Contact Information');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `composition_ingredients` SET TAGS ('dbx_business_glossary_term' = 'Composition and Ingredients');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `disposal_considerations` SET TAGS ('dbx_business_glossary_term' = 'Disposal Considerations');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `document_checksum` SET TAGS ('dbx_business_glossary_term' = 'Document SHA‑256 Checksum');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `document_checksum` SET TAGS ('dbx_value_regex' = '^[A-Fa-f0-9]{64}$');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `document_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Document File Size (Bytes)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `ecological_information` SET TAGS ('dbx_business_glossary_term' = 'Ecological Information');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `ghs_pictograms` SET TAGS ('dbx_business_glossary_term' = 'GHS Pictograms');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `hazard_classifications` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classifications');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `hazard_statements` SET TAGS ('dbx_business_glossary_term' = 'Hazard Statements');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Current Version Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `physical_chemical_properties` SET TAGS ('dbx_business_glossary_term' = 'Physical and Chemical Properties');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `precautionary_statements` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Statements');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `regulatory_information` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Information');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `sds_record_status` SET TAGS ('dbx_business_glossary_term' = 'SDS Status');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `sds_record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|draft');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `sds_version` SET TAGS ('dbx_business_glossary_term' = 'SDS Version');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `signal_word` SET TAGS ('dbx_business_glossary_term' = 'Signal Word');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `signal_word` SET TAGS ('dbx_value_regex' = 'danger|warning');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `stability_reactivity` SET TAGS ('dbx_business_glossary_term' = 'Stability and Reactivity');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `toxicological_information` SET TAGS ('dbx_business_glossary_term' = 'Toxicological Information');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `transport_information` SET TAGS ('dbx_business_glossary_term' = 'Transport Information');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`sds_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `rawmaterial_ghs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'GHS Classification Record Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `sds_record_id` SET TAGS ('dbx_business_glossary_term' = 'SDS Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `supplier_material_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `classification_authority` SET TAGS ('dbx_business_glossary_term' = 'Classification Authority');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `classification_basis` SET TAGS ('dbx_business_glossary_term' = 'Classification Basis');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `classification_basis` SET TAGS ('dbx_value_regex' = 'Test data|Read‑across|Expert judgment|Calculation');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `classification_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'GHS Hazard Category');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `hazard_category` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'GHS Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `hazard_statement_codes` SET TAGS ('dbx_business_glossary_term' = 'GHS Hazard Statement Codes');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `hazard_statement_text` SET TAGS ('dbx_business_glossary_term' = 'Hazard Statement Text');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `material_cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `material_cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `material_supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Code');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Classification Notes');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `pictogram_codes` SET TAGS ('dbx_business_glossary_term' = 'GHS Pictogram Codes');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `pictogram_description` SET TAGS ('dbx_business_glossary_term' = 'Pictogram Description');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `precautionary_statement_codes` SET TAGS ('dbx_business_glossary_term' = 'GHS Precautionary Statement Codes');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `precautionary_statement_text` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Statement Text');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `rawmaterial_ghs_classification_status` SET TAGS ('dbx_business_glossary_term' = 'Classification Status');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `rawmaterial_ghs_classification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = 'GHS Rev 9|EU CLP|OSHA HazCom 2012|Canada WHMIS');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `signal_word` SET TAGS ('dbx_business_glossary_term' = 'GHS Signal Word');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `signal_word` SET TAGS ('dbx_value_regex' = 'Danger|Warning');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP MM|LIMS|EHS');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`rawmaterial_ghs_classification` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` SET TAGS ('dbx_subdomain' = 'material_identity');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `sds_record_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Document ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `analytical_method` SET TAGS ('dbx_value_regex' = 'GC|HPLC|ICP-MS|FTIR|NMR');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `assay_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Assay Maximum Percentage');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `assay_min_percent` SET TAGS ('dbx_business_glossary_term' = 'Assay Minimum Percentage');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `color_aph` SET TAGS ('dbx_business_glossary_term' = 'Color (APHA)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `density_max_g_per_cm3` SET TAGS ('dbx_business_glossary_term' = 'Density Maximum (g/cm³)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `density_min_g_per_cm3` SET TAGS ('dbx_business_glossary_term' = 'Density Minimum (g/cm³)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification (GHS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'explosive|flammable|corrosive|toxic|environmental_hazard|none');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `heavy_metals_ppm_limit` SET TAGS ('dbx_business_glossary_term' = 'Heavy Metals Limit (PPM)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `material_specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `material_specification_status` SET TAGS ('dbx_value_regex' = 'draft|active|approved|superseded|retired');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `microbiological_limit` SET TAGS ('dbx_business_glossary_term' = 'Microbiological Limit');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `moisture_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Maximum Percentage');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `moisture_min_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Minimum Percentage');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `particle_size_max_microns` SET TAGS ('dbx_business_glossary_term' = 'Particle Size Maximum (µm)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `particle_size_min_microns` SET TAGS ('dbx_business_glossary_term' = 'Particle Size Minimum (µm)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `ph_max` SET TAGS ('dbx_business_glossary_term' = 'pH Maximum');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `ph_min` SET TAGS ('dbx_business_glossary_term' = 'pH Minimum');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `residual_solvent_limit_ppm` SET TAGS ('dbx_business_glossary_term' = 'Residual Solvent Limit (PPM)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `specification_name` SET TAGS ('dbx_business_glossary_term' = 'Specification Name');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `viscosity_max_cp` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Maximum (cP)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_specification` ALTER COLUMN `viscosity_min_cp` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Minimum (cP)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` SET TAGS ('dbx_subdomain' = 'supplier_qualification');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `supplier_material_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Record ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `sds_record_id` SET TAGS ('dbx_business_glossary_term' = 'SDS Document ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `approved_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Approved Manufacturer');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `compliance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non‑compliant|pending|exempt');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `epa_regulation_code` SET TAGS ('dbx_business_glossary_term' = 'EPA Regulation Code');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'GHS Classification');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `lot_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Lot Control Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `material_grade` SET TAGS ('dbx_business_glossary_term' = 'Material Grade');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'drum|bag|bulk|pallet|cylinder|bottle');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `preferred_supplier` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `purity_percent` SET TAGS ('dbx_business_glossary_term' = 'Purity Percentage');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|probationary|disqualified');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'REACH Registration Number');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `sds_version` SET TAGS ('dbx_business_glossary_term' = 'SDS Version');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `supplier_part_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Number');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `supplier_trade_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Trade Name');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `supply_risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Tier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `supply_risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `tsca_status` SET TAGS ('dbx_business_glossary_term' = 'TSCA Status');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`supplier_material` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|g|l|ml|ton');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` SET TAGS ('dbx_subdomain' = 'supplier_qualification');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `material_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Qualification ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID (MAT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `supplier_material_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID (SUPPLIER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `decision_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `lab_evaluation_result` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Evaluation Result (LAB_RESULT)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `lab_evaluation_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `material_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `material_qualification_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|closed');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `pilot_trial_result` SET TAGS ('dbx_business_glossary_term' = 'Pilot Trial Result (PILOT_RESULT)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `pilot_trial_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `production_trial_result` SET TAGS ('dbx_business_glossary_term' = 'Production Trial Result (PROD_RESULT)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `production_trial_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `qualification_decision` SET TAGS ('dbx_business_glossary_term' = 'Qualification Decision (QUAL_DECISION)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `qualification_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number (QUAL_NUM)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `qualification_protocol_ref` SET TAGS ('dbx_business_glossary_term' = 'Qualification Protocol Reference (PROTOCOL_REF)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `qualification_request_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Request Timestamp (REQUEST_TS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `qualification_scope` SET TAGS ('dbx_business_glossary_term' = 'Qualification Scope (QUAL_SCOPE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type (QUAL_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'new_material|new_supplier|change|requalification');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `regulatory_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Outcome (REG_OUTCOME)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `regulatory_review_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `requalification_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Requalification Interval (REQUAL_INTERVAL_DAYS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `technical_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Technical Review Outcome (TECH_OUTCOME)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_qualification` ALTER COLUMN `technical_review_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` SET TAGS ('dbx_subdomain' = 'quality_verification');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `incoming_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Incoming Inspection ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `coa_document_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Document Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `supplier_material_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `appearance` SET TAGS ('dbx_business_glossary_term' = 'Appearance Description');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `assay_percent` SET TAGS ('dbx_business_glossary_term' = 'Assay Percentage');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `capap_triggered` SET TAGS ('dbx_business_glossary_term' = 'CAPA Triggered Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Color Description');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Inspector Comments');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `density_kg_m3` SET TAGS ('dbx_business_glossary_term' = 'Density (kg/m³)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `disposition_instructions` SET TAGS ('dbx_business_glossary_term' = 'Disposition Instructions');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number (Inspection Lot Number)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|closed');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'identity_test|full_coa_review|skip_lot|reduced|tightened');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `moisture_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Percentage');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Specification Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `oot_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Trend Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `overall_decision` SET TAGS ('dbx_business_glossary_term' = 'Overall Inspection Decision');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `overall_decision` SET TAGS ('dbx_value_regex' = 'accept|reject|hold|conditional_release');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `particle_size_um` SET TAGS ('dbx_business_glossary_term' = 'Particle Size (µm)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `quality_flag` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `sample_plan` SET TAGS ('dbx_business_glossary_term' = 'Sample Plan');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|L|g|mL|ton');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`incoming_inspection` ALTER COLUMN `viscosity_cp` SET TAGS ('dbx_business_glossary_term' = 'Viscosity (cP)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` SET TAGS ('dbx_subdomain' = 'material_identity');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `supplier_material_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `batch_type` SET TAGS ('dbx_value_regex' = 'raw_material|intermediate|additive');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number (Chemical Abstracts Service)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `chain_of_custody_notes` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Notes');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `coa_reference` SET TAGS ('dbx_business_glossary_term' = 'COA Reference');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO 3166-1)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification (GHS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `is_recalled` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `lot_creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `lot_last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `lot_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Lot Owner Department');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `lot_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_hold|blocked|expired|quarantine');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `quality_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `sds_version` SET TAGS ('dbx_business_glossary_term' = 'SDS Version');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `storage_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity (%)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `supplier_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Lot Cost');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`lot_record` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` SET TAGS ('dbx_subdomain' = 'quality_verification');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `coa_document_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Document ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `supplier_material_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `assay_pass` SET TAGS ('dbx_business_glossary_term' = 'Assay Pass Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `assay_percent` SET TAGS ('dbx_business_glossary_term' = 'Assay Percentage');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `assay_spec_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Assay Specification Limit (%)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `coa_document_status` SET TAGS ('dbx_business_glossary_term' = 'COA Status');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `coa_document_status` SET TAGS ('dbx_value_regex' = 'draft|issued|archived|retracted');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `document_file_hash` SET TAGS ('dbx_business_glossary_term' = 'COA File Hash');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `document_file_path` SET TAGS ('dbx_business_glossary_term' = 'COA File Path');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'COA Document Number');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'COA Document Title');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `heavy_metals_ppm` SET TAGS ('dbx_business_glossary_term' = 'Heavy Metals Concentration (ppm)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `heavy_metals_spec_limit_ppm` SET TAGS ('dbx_business_glossary_term' = 'Heavy Metals Specification Limit (ppm)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'COA Issue Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `lab_location` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Location');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `lab_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `material_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `moisture_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Percentage');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `moisture_spec_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Specification Limit (%)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `overall_pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Overall Pass/Fail Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall COA Result');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `ph_pass` SET TAGS ('dbx_business_glossary_term' = 'pH Pass Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `ph_spec_max` SET TAGS ('dbx_business_glossary_term' = 'pH Specification Maximum');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `ph_spec_min` SET TAGS ('dbx_business_glossary_term' = 'pH Specification Minimum');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `purity_pass` SET TAGS ('dbx_business_glossary_term' = 'Purity Pass Flag');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `purity_percent` SET TAGS ('dbx_business_glossary_term' = 'Purity Percentage');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `purity_spec_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Purity Specification Limit (%)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `residual_solvents_ppm` SET TAGS ('dbx_business_glossary_term' = 'Residual Solvents Concentration (ppm)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `residual_solvents_spec_limit_ppm` SET TAGS ('dbx_business_glossary_term' = 'Residual Solvents Specification Limit (ppm)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`coa_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `reach_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Reach Registration ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Holder ID (REG_HOLDER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `authorisation_status` SET TAGS ('dbx_business_glossary_term' = 'Authorisation Status (AUTH_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `authorisation_status` SET TAGS ('dbx_value_regex' = 'authorised|not_authorised|pending');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `co_registrant_flag` SET TAGS ('dbx_business_glossary_term' = 'Co‑Registrant Flag (CO_REG_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline (COMPLIANCE_DEADLINE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System (DATA_SOURCE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP_MM|ECHA|Other');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `dossier_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dossier Update Timestamp (DOSSIER_UPDATE_TS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `downstream_use_notification` SET TAGS ('dbx_business_glossary_term' = 'Downstream Use Notification (DOWNSTREAM_USE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `ec_number` SET TAGS ('dbx_business_glossary_term' = 'EC Number (EC_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `ec_number` SET TAGS ('dbx_value_regex' = '^d{1,7}$');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `echa_registration_number` SET TAGS ('dbx_business_glossary_term' = 'ECHA Registration Number (ECHA_REG_NO)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status (EVAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'CoRAP|non-CoRAP|pending');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (EXPIRY_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `joint_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Joint Submission Reference (JOINT_SUB_REF)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (LAST_REVIEW_TS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `registration_identifier` SET TAGS ('dbx_business_glossary_term' = 'Registration Dossier Identifier (REG_DOSSIER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `registration_notes` SET TAGS ('dbx_business_glossary_term' = 'Registration Notes (REG_NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status (REG_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|approved|rejected|withdrawn');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type (REG_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'lead|member|co-registrant');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `registration_version` SET TAGS ('dbx_business_glossary_term' = 'Registration Version (REG_VERSION)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `restriction_status` SET TAGS ('dbx_business_glossary_term' = 'Restriction Status (RESTRICTION_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `restriction_status` SET TAGS ('dbx_value_regex' = 'restricted|not_restricted|pending');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date (SUBMIT_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `substance_classification` SET TAGS ('dbx_business_glossary_term' = 'Substance Classification (SUBSTANCE_CLASS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `substance_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name (SUBSTANCE_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `svhc_candidate_date` SET TAGS ('dbx_business_glossary_term' = 'SVHC Candidate Date (SVHC_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `svhc_candidate_flag` SET TAGS ('dbx_business_glossary_term' = 'SVHC Candidate Flag (SVHC_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `tonnage_band` SET TAGS ('dbx_business_glossary_term' = 'Tonnage Band (TONNAGE_BAND)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `tonnage_band` SET TAGS ('dbx_value_regex' = '0-1t|1-10t|10-100t|100-1000t|>1000t');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`reach_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` SET TAGS ('dbx_subdomain' = 'material_identity');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `material_composition_id` SET TAGS ('dbx_business_glossary_term' = 'Material Composition Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Component Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `cbi_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Business Information Flag (CBI_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `cbi_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `component_function` SET TAGS ('dbx_business_glossary_term' = 'Component Function (COMP_FUNC)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `component_iupac_name` SET TAGS ('dbx_business_glossary_term' = 'Component IUPAC Name (IUPAC)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `component_percentage_of_total` SET TAGS ('dbx_business_glossary_term' = 'Component Percentage of Total (COMP_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `composition_code` SET TAGS ('dbx_business_glossary_term' = 'Composition Code (COMP_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `composition_description` SET TAGS ('dbx_business_glossary_term' = 'Composition Description (COMP_DESC)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `composition_type` SET TAGS ('dbx_business_glossary_term' = 'Composition Type (COMP_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `composition_type` SET TAGS ('dbx_value_regex' = 'mixture|solution|alloy|compound|custom');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `concentration_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concentration (CONC_MAX)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `concentration_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Concentration (CONC_MIN)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `concentration_nominal` SET TAGS ('dbx_business_glossary_term' = 'Nominal Concentration (CONC_NOM)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit (CONC_UNIT)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_value_regex' = '%w/w|%v/v|ppm|ppb');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'GHS Classification (GHS_CLASS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `hazard_statement` SET TAGS ('dbx_business_glossary_term' = 'Hazard Statement (HAZARD_STMT)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `material_composition_status` SET TAGS ('dbx_business_glossary_term' = 'Composition Status (COMP_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `material_composition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `precautionary_statement` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Statement (PRECAUT_STMT)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `reachexempt_flag` SET TAGS ('dbx_business_glossary_term' = 'REACH Exemption Flag (REACH_EXEMPT)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (REC_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'current|historical|archived');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Status (REG_REVIEW)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP MM|LIMS|EHS|Custom');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `total_components` SET TAGS ('dbx_business_glossary_term' = 'Total Number of Components (TOTAL_COMP)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_composition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Composition Version Number (COMP_VER)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `material_regulatory_status_id` SET TAGS ('dbx_business_glossary_term' = 'Material Regulatory Status ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline (CD)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `compliance_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Effective Date (CED)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `compliance_last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Last Review Date (CLRD)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes (CN)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt|restricted|not_applicable');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `ghs_pictograms` SET TAGS ('dbx_business_glossary_term' = 'GHS Pictograms (GP)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification (HC)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (Country Code)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp (LUT)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (RS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status (RS)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'registered|listed|not_registered|pending|exempt|withdrawn');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework (RF)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `restriction_applicability` SET TAGS ('dbx_business_glossary_term' = 'Restriction Applicability (RA)');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `restriction_applicability` SET TAGS ('dbx_value_regex' = 'applicable|not_applicable|partial');
ALTER TABLE `chemical_mfg_ecm`.`rawmaterial`.`material_regulatory_status` ALTER COLUMN `restriction_level` SET TAGS ('dbx_business_glossary_term' = 'Restriction Level (RL)');
