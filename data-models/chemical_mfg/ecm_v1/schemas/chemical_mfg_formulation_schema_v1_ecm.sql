-- Schema for Domain: formulation | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`formulation` COMMENT 'Manages chemical formulation recipes, BOMs, blend ratios, active ingredient specifications, and version-controlled formula records. Supports Product Formulation and Blending processes including scale-up from R&D to commercial production. Owns formulation change control through MOC processes, API content tracking, compatibility matrices, intellectual property for proprietary blends, and integration with MES and Aspen HYSYS.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`formula` (
    `formula_id` BIGINT COMMENT 'Unique system-generated identifier for the master formula record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory audit requires the employee who approved the formula to be recorded for compliance and traceability.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: Safety and regulatory submissions need the full CAS registry record for each formula; linking provides hazard classification and compliance data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost Allocation Report requires each formula to be charged to a cost center for accurate COGS reporting.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Required for Sourcing Strategy Report: each formula designates a primary vendor for key raw material, enabling procurement planning and regulatory compliance.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability dashboards require each formula to be linked to a profit center for margin analysis.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Needed for Product Development Lifecycle Report linking final formula to originating R&D project for traceability.',
    `safety_data_sheet_id` BIGINT COMMENT 'Reference to the associated Safety Data Sheet record.',
    `active_ingredient_content_percent` DECIMAL(18,2) COMMENT 'Percentage of the primary active ingredient in the formulation.',
    `blend_ratio_description` STRING COMMENT 'Textual description of component blend ratios.',
    `cas_number` STRING COMMENT 'Chemical Abstracts Service registry number identifying the primary substance.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the formula.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the formula record was first created.',
    `default_process_parameter` STRING COMMENT 'Key process parameter (e.g., temperature, pH) that is standard for this formula.',
    `effective_date` DATE COMMENT 'Date on which the formula becomes effective for production.',
    `expiry_date` DATE COMMENT 'Date after which the formula is no longer valid (nullable).',
    `formula_code` STRING COMMENT 'External code or identifier used across systems to reference the formulation.',
    `formula_name` STRING COMMENT 'Human‑readable name of the chemical formulation.',
    `formula_status` STRING COMMENT 'Current lifecycle state of the formula.. Valid values are `active|discontinued|archived|pending|draft`',
    `formulation_category` STRING COMMENT 'Category describing the manufacturing approach of the formula.. Valid values are `batch|continuous|custom|standard`',
    `ghs_classification` STRING COMMENT 'Globally Harmonized System hazard classification for the formulation.',
    `hazard_statement` STRING COMMENT 'Standardized hazard statement(s) associated with the formulation.',
    `ip_ownership_flag` BOOLEAN COMMENT 'True if the formulation is proprietary and protected by IP.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the formula was last reviewed for compliance or performance.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the formula.',
    `precautionary_statement` STRING COMMENT 'Standardized precautionary statement(s) for safe handling.',
    `product_family` STRING COMMENT 'Higher‑level product family or line to which the formula belongs.',
    `regulatory_classification` STRING COMMENT 'Regulatory regime governing the formulation (e.g., GHS, REACH).. Valid values are `GHS|REACH|TSCA|EPA|ISO`',
    `standard_batch_size_kg` DECIMAL(18,2) COMMENT 'Typical batch size for which the formula is defined, expressed in kilograms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the formula record.',
    `version_control_method` STRING COMMENT 'Method used to control formula version changes.. Valid values are `MOC|Manual|Automated`',
    `version_count` STRING COMMENT 'Total number of version records associated with this master formula.',
    CONSTRAINT pk_formula PRIMARY KEY(`formula_id`)
) COMMENT 'Master record for a chemical formulation or blend recipe. Represents the authoritative, version-independent identity of a chemical products composition including formula code, product family, regulatory classification, IP ownership flag, and lifecycle state (active, discontinued, archived). This is the SSOT for all formulation identities within the enterprise. Child formula_version records carry version-specific composition details, process parameters, and specifications.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` (
    `formula_version_id` BIGINT COMMENT 'Unique surrogate key for each formula version record.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Vendor Assignment in Version Control: a formula version records the vendor responsible for supplying the versioned product, used in change management and cost tracking.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the chemical product that this formula version produces.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Version‑specific budgeting and variance analysis need a cost center link for each formula version.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Version control logs require the employee who created each formula version for regulatory change‑management.',
    `management_of_change_id` BIGINT COMMENT 'Identifier of the linked Management of Change record governing this revision.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Version‑level profit tracking supports detailed product line profitability reporting.',
    `approval_authority` STRING COMMENT 'Name or role of the individual/committee that approved the formula version.',
    `approval_date` DATE COMMENT 'Date on which the formula version received formal approval.',
    `bom_type` STRING COMMENT 'Classification of the bill of materials associated with the formula version.. Valid values are `r&d|pilot|commercial`',
    `cas_number` STRING COMMENT 'Unique Chemical Abstracts Service registry number for the primary chemical(s) in the formula.. Valid values are `^d{2,7}-d{2}-d$`',
    `change_rationale` STRING COMMENT 'Reason or business justification for the formula revision.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost to produce a batch using this formula version.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the formula version record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost estimate.. Valid values are `USD|EUR|GBP|JPY|CNY`',
    `department` STRING COMMENT 'Department responsible for the formulation (e.g., R&D, Production).',
    `effective_date` DATE COMMENT 'Date on which this formula version becomes effective for production.',
    `expiry_date` DATE COMMENT 'Date after which the formula version is no longer valid for use.',
    `formula_code` STRING COMMENT 'External business identifier for the formula (e.g., internal catalog or recipe code).',
    `formula_name` STRING COMMENT 'Human‑readable name of the chemical formulation.',
    `formulation_owner` STRING COMMENT 'Business owner or responsible department for the formula.',
    `hazard_classification` STRING COMMENT 'GHS hazard class assigned to the formulation.. Valid values are `explosive|flammable|corrosive|toxic|environmental|non_hazardous`',
    `is_current` BOOLEAN COMMENT 'Flag indicating whether this version is the active version for the formula.',
    `regulatory_status` STRING COMMENT 'Current compliance status of the formula with applicable regulations (e.g., REACH, TSCA).. Valid values are `compliant|non_compliant|pending`',
    `target_batch_size` DECIMAL(18,2) COMMENT 'Planned batch size for which the formula version is intended, expressed in the selected unit of measure.',
    `unit_of_measure` STRING COMMENT 'Measurement unit used for the target batch size (e.g., kilograms, liters).. Valid values are `kg|l|g|ml|ton`',
    `updated_by` STRING COMMENT 'User identifier who performed the latest modification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the formula version record.',
    `version_description` STRING COMMENT 'Free‑form description of changes, special notes, or usage guidance for this version.',
    `version_number` STRING COMMENT 'Sequential version number of the formula revision.',
    `version_status` STRING COMMENT 'Current lifecycle status of the formula version.. Valid values are `draft|approved|obsolete|pending`',
    CONSTRAINT pk_formula_version PRIMARY KEY(`formula_version_id`)
) COMMENT 'Version-controlled record of a specific formula revision including its Bill of Materials header data. Tracks version number, effective date, expiry date, version status (draft, approved, obsolete), change rationale, approval authority, MOC linkage, target batch size, BOM type (R&D, pilot, commercial), and unit of measure basis. Serves as the grouping entity for recipe_line_items (BOM components) and recipe_steps (process instructions). Enables full audit trail of formula evolution from initial R&D through commercial scale-up and subsequent reformulations.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` (
    `formula_bom_id` BIGINT COMMENT 'Unique system-generated identifier for the formula BOM record.',
    `employee_id` BIGINT COMMENT 'System identifier of the user who created the BOM record.',
    `safety_data_sheet_id` BIGINT COMMENT 'Reference to the SDS document governing the components safe handling.',
    `vendor_id` BIGINT COMMENT 'Identifier of the preferred supplier for the component.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the BOM was formally approved.',
    `batch_number` STRING COMMENT 'Manufacturing batch number associated with the component.',
    `bom_code` STRING COMMENT 'Business code or identifier assigned to the formula BOM.',
    `bom_name` STRING COMMENT 'Human‑readable name of the formula BOM.',
    `change_control_number` STRING COMMENT 'Identifier of the Management of Change (MOC) record governing this BOM version.',
    `classification` STRING COMMENT 'Category indicating the type of formula (e.g., final product, intermediate, raw material).. Valid values are `product|intermediate|raw_material|custom`',
    `component_cas_number` STRING COMMENT 'Chemical Abstracts Service registry number uniquely identifying the component substance.',
    `component_name` STRING COMMENT 'Descriptive name of the component material.',
    `component_quantity` DECIMAL(18,2) COMMENT 'Nominal quantity of the component required for the BOM.',
    `component_sequence` STRING COMMENT 'Line order of the component within the BOM.',
    `component_uom` STRING COMMENT 'Unit of measure for the component quantity (e.g., kg, L, mol).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the BOM record was first created in the system.',
    `critical_ingredient` BOOLEAN COMMENT 'True if the component is designated as critical for product performance or regulatory compliance.',
    `effective_date` DATE COMMENT 'Date on which the BOM becomes effective for production.',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Numeric score representing the environmental impact of the BOM (e.g., based on VOC, HAP content).',
    `expiration_date` DATE COMMENT 'Date after which the BOM is no longer valid (nullable for open‑ended BOMs).',
    `formula_bom_status` STRING COMMENT 'Current lifecycle status of the BOM.. Valid values are `active|inactive|draft|deprecated`',
    `ghs_classification` STRING COMMENT 'Globally Harmonized System hazard classification for the component.',
    `hazardous_ingredient_flag` BOOLEAN COMMENT 'True if the component is classified as hazardous under EPA regulations.',
    `lot_number` STRING COMMENT 'Lot identifier for traceability of the component batch.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions for the BOM.',
    `process_stage` STRING COMMENT 'Lifecycle stage of the formula (research, scale‑up, or commercial production).. Valid values are `R&D|Scale-up|Production`',
    `regulatory_status` STRING COMMENT 'Current compliance status of the component under applicable regulations.. Valid values are `compliant|non_compliant|pending`',
    `release_date` DATE COMMENT 'Date the BOM was released for production use.',
    `revision_date` DATE COMMENT 'Date of the most recent revision of the BOM.',
    `substitution_allowed` BOOLEAN COMMENT 'Indicates whether the component may be substituted with an approved alternative.',
    `tolerance_max` DECIMAL(18,2) COMMENT 'Maximum acceptable quantity for the component (upper bound).',
    `tolerance_min` DECIMAL(18,2) COMMENT 'Minimum acceptable quantity for the component (lower bound).',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Aggregate nominal weight of all components in the BOM, expressed in kilograms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the BOM record.',
    `version_number` STRING COMMENT 'Version identifier for the BOM, supporting change control and revision tracking.',
    CONSTRAINT pk_formula_bom PRIMARY KEY(`formula_bom_id`)
) COMMENT 'Bill of Materials for a chemical formulation, listing all raw material inputs, intermediates, and additives required to produce a specified batch quantity. Captures BOM item sequence, component CAS number, nominal quantity, unit of measure, tolerance range (min/max), substitution flag, and critical ingredient designation. Supports both R&D and commercial production BOMs.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` (
    `recipe_line_item_id` BIGINT COMMENT 'Primary key for recipe_line_item',
    `compound_registry_id` BIGINT COMMENT 'Foreign key linking to research.compound_registry. Business justification: Component Traceability Report links each BOM component to master compound registry for safety, compliance, and regulatory reporting.',
    `formula_version_id` BIGINT COMMENT 'Identifier of the parent formula version (recipe header).',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the component supplier.',
    `reach_dossier_id` BIGINT COMMENT 'Reference to the REACH registration dossier for the component.',
    `safety_data_sheet_id` BIGINT COMMENT 'Reference to the Safety Data Sheet for the component.',
    `active_ingredient_flag` BOOLEAN COMMENT 'Indicates whether the component is an active ingredient in the final product.',
    `addition_sequence` STRING COMMENT 'Order in which the component is added during the manufacturing process.',
    `analytical_method` STRING COMMENT 'Laboratory method used to verify component concentration (e.g., HPLC, GC).',
    `batch_number` STRING COMMENT 'Batch identifier associated with the component supply.',
    `blend_ratio_percent` DECIMAL(18,2) COMMENT 'Proportion of the component expressed as a percentage of the total blend.',
    `change_control_number` STRING COMMENT 'Management of Change (MOC) reference number for any modification to the component specification.',
    `component_type` STRING COMMENT 'Classification of the component within the formulation.. Valid values are `raw_material|intermediate|solvent|catalyst|additive|other`',
    `concentration_unit` STRING COMMENT 'Unit for the target concentration (weight/weight, volume/volume, parts per million).. Valid values are `% w/w|% v/v|ppm`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line item record was created.',
    `critical_ingredient_flag` BOOLEAN COMMENT 'Marks components whose deviation could impact product safety or performance.',
    `effective_from` DATE COMMENT 'Date from which the component specification is valid.',
    `effective_until` DATE COMMENT 'Date after which the component specification is no longer valid (nullable).',
    `ghs_classification` STRING COMMENT 'GHS hazard classification codes for the component.',
    `is_default` BOOLEAN COMMENT 'Indicates if this component is the default entry for the formula version.',
    `is_deleted` BOOLEAN COMMENT 'Logical deletion flag for soft‑deleting the line item without physical removal.',
    `lifecycle_status` STRING COMMENT 'Lifecycle stage of the line item (e.g., draft, released).. Valid values are `draft|approved|released|obsolete`',
    `line_sequence` STRING COMMENT 'Sequential order of the component within the formula.',
    `lot_number` STRING COMMENT 'Manufacturing lot identifier for traceability.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the component concentration or ratio.',
    `measurement_basis` STRING COMMENT 'Basis on which analytical measurements are performed.. Valid values are `weight|volume|molar`',
    `mixing_order` STRING COMMENT 'Timing of component addition relative to mixing steps.. Valid values are `pre_mix|post_mix|simultaneous`',
    `nominal_quantity` DECIMAL(18,2) COMMENT 'Base amount of the component specified for the formula.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the component.',
    `ratio_basis` STRING COMMENT 'Basis used for the blend ratio (weight, volume, or molar).. Valid values are `weight|volume|molar`',
    `recipe_line_item_status` STRING COMMENT 'Current operational status of the component within the formula.. Valid values are `active|inactive|deprecated`',
    `regulatory_status` STRING COMMENT 'Regulatory compliance status of the component.. Valid values are `approved|restricted|banned`',
    `substitution_eligible_flag` BOOLEAN COMMENT 'Indicates if the component can be substituted with an approved alternative.',
    `target_concentration` DECIMAL(18,2) COMMENT 'Desired concentration of the component in the final product.',
    `unit_of_measure` STRING COMMENT 'Measurement unit used for the nominal quantity.. Valid values are `kg|g|L|mL|mol|%`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line item.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the component concentration or ratio.',
    `version_number` STRING COMMENT 'Version number of the line item for change tracking.',
    CONSTRAINT pk_recipe_line_item PRIMARY KEY(`recipe_line_item_id`)
) COMMENT 'Line-item component within a formula versions Bill of Materials. Represents a single raw material, intermediate, solvent, catalyst, or additive with its blend ratio, concentration targets, and SPC control limits. Stores component identifier (CAS number), nominal quantity, unit of measure, blend ratio (% w/w, % v/v, mol%), upper/lower control limits, target concentration, measurement basis (weight, volume, molar), analytical verification method, addition sequence, mixing order, active ingredient flag, substitution eligibility, and critical ingredient designation. SSOT for what goes into a formula, in what proportion, and within what tolerance — consolidating all ratio, concentration, and component-level specification data.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` (
    `blend_ratio_id` BIGINT COMMENT 'Unique system-generated identifier for each blend ratio record.',
    `material_master_id` BIGINT COMMENT 'Identifier of the chemical component used in the blend.',
    `analytical_method` STRING COMMENT 'Laboratory method used to verify the component concentration.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the blend ratio was approved.',
    `approved_by` STRING COMMENT 'User identifier who approved the blend ratio.',
    `batch_number` STRING COMMENT 'Batch identifier when the blend ratio is applied to a production batch.',
    `blend_code` STRING COMMENT 'Business identifier or code used to reference the blend across systems.',
    `blend_name` STRING COMMENT 'Human‑readable name of the blend formulation.',
    `blend_ratio_status` STRING COMMENT 'Current lifecycle status of the blend ratio record.. Valid values are `active|inactive|retired|draft`',
    `blend_type` STRING COMMENT 'Classification of the blend (e.g., pilot, commercial, experimental, research).. Valid values are `pilot|commercial|experimental|research`',
    `change_reason` STRING COMMENT 'Narrative explaining why the blend ratio was changed.',
    `component_cas_number` STRING COMMENT 'Standard CAS registry number for the component.. Valid values are `^d{2,7}-d{2}-d$`',
    `concentration_unit` STRING COMMENT 'Unit of measure for the concentration values.. Valid values are `percent_w_w|percent_v_v|ppm|mol_percent|mg_per_kg`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the blend ratio record was created.',
    `data_source_system` STRING COMMENT 'System of record that supplied the blend ratio data (e.g., SAP, Aspen HYSYS).',
    `effective_from` DATE COMMENT 'Date from which the blend ratio becomes valid.',
    `effective_until` DATE COMMENT 'Date until which the blend ratio remains valid (null for open‑ended).',
    `ehs_review_status` STRING COMMENT 'Environmental Health & Safety review outcome for the blend.. Valid values are `approved|pending|rejected`',
    `ghs_classification_code` STRING COMMENT 'GHS hazard classification code for the blend.',
    `ip_protection_status` STRING COMMENT 'IP status of the blend (patented, trade secret, or none).. Valid values are `patented|trade_secret|none`',
    `is_proprietary` BOOLEAN COMMENT 'True if the blend formulation is proprietary.',
    `last_quality_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the last quality control verification.',
    `lot_number` STRING COMMENT 'Lot identifier associated with the blend application.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Statistical lower control limit for the component concentration.',
    `measurement_basis` STRING COMMENT 'Basis on which the concentration is measured (weight, volume, or molar).. Valid values are `weight|volume|molar`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was recorded.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Uncertainty (±%) associated with the analytical measurement.',
    `nominal_concentration` DECIMAL(18,2) COMMENT 'Target nominal concentration of the component in the blend.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the blend ratio.',
    `quality_control_status` STRING COMMENT 'Result of the most recent quality control check.. Valid values are `passed|failed|under_review`',
    `regulatory_compliance_flag` STRING COMMENT 'Indicates whether the blend meets applicable regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `retention_period_days` STRING COMMENT 'Number of days the blend ratio record must be retained per policy.',
    `safety_data_sheet_ref` STRING COMMENT 'Reference or link to the SDS associated with the blend.',
    `scale_up_factor` DECIMAL(18,2) COMMENT 'Factor used to scale the laboratory blend ratio to commercial production.',
    `target_concentration` DECIMAL(18,2) COMMENT 'Desired concentration value used for SPC target tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Statistical upper control limit for the component concentration.',
    `version_number` STRING COMMENT 'Version of the blend ratio record for change control.',
    `created_by` STRING COMMENT 'User identifier who created the record.',
    CONSTRAINT pk_blend_ratio PRIMARY KEY(`blend_ratio_id`)
) COMMENT 'Defines the precise blend ratios and concentration targets for each component in a formulation. Captures nominal ratio, lower control limit, upper control limit, target concentration (PPM, % w/w, % v/v, mol%), measurement basis (weight, volume, molar), and the analytical method used to verify the ratio. Supports SPC (Statistical Process Control) tolerance management and scale-up ratio adjustments.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` (
    `active_ingredient_spec_id` BIGINT COMMENT 'System-generated unique identifier for the active ingredient specification record.',
    `vendor_id` BIGINT COMMENT 'System identifier for the supplier entity.',
    `active_ingredient_spec_code` STRING COMMENT 'Internal catalog code used to reference the specification within ERP/MES systems.',
    `active_ingredient_spec_name` STRING COMMENT 'Human‑readable name of the active ingredient (e.g., Acetaminophen).',
    `active_ingredient_spec_status` STRING COMMENT 'Current lifecycle state of the specification.. Valid values are `active|inactive|draft|retired`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the specification was approved.',
    `approved_by` STRING COMMENT 'Name of the person who approved the specification.',
    `assay_unit` STRING COMMENT 'Unit for assay values and content percentages.. Valid values are `percent|ppm|mg_per_kg`',
    `batch_lot_number` STRING COMMENT 'Lot or batch number associated with the specification version.. Valid values are `^[A-Z0-9]{8,12}$`',
    `cas_number` STRING COMMENT 'Chemical Abstracts Service identifier for the ingredient.. Valid values are `^d{2,7}-d{2}-d$`',
    `change_reason` STRING COMMENT 'Reason for the most recent change to the specification.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the specification record was created.',
    `documentation_url` STRING COMMENT 'Link to the detailed specification document or data sheet.. Valid values are `^https?://.+$`',
    `echa_registration_number` STRING COMMENT 'European Chemicals Agency registration number.. Valid values are `^d{4}-d{2}-d{2}$`',
    `effective_date` DATE COMMENT 'Date from which the specification becomes valid.',
    `expiration_date` DATE COMMENT 'Date after which the specification is no longer valid (nullable).',
    `ghs_classification` STRING COMMENT 'Globally Harmonized System hazard class for the ingredient.. Valid values are `flammable|corrosive|toxic|environmental_hazard|none`',
    `ghs_pictogram_codes` STRING COMMENT 'Pipe‑separated list of GHS pictogram codes applicable to the ingredient. [ENUM-REF-CANDIDATE: GHS01|GHS02|GHS03|GHS04|GHS05|GHS06|GHS07|GHS08|GHS09 — promote to reference product]',
    `handling_instructions` STRING COMMENT 'Special handling or safety instructions for the ingredient.',
    `hazard_statement` STRING COMMENT 'Standard GHS hazard statement for the ingredient.',
    `ingredient_type` STRING COMMENT 'Category of the ingredient indicating its role in formulations.. Valid values are `api|excipient|intermediate|solvent`',
    `max_content` DECIMAL(18,2) COMMENT 'Maximum allowed percentage of the active ingredient in the final product.',
    `min_content` DECIMAL(18,2) COMMENT 'Minimum allowed percentage of the active ingredient in the final product.',
    `particle_size_max` DECIMAL(18,2) COMMENT 'Maximum particle size specification.',
    `particle_size_min` DECIMAL(18,2) COMMENT 'Minimum particle size specification.',
    `particle_size_unit` STRING COMMENT 'Unit for particle size measurements.. Valid values are `micron|nm|mm`',
    `precautionary_statement` STRING COMMENT 'Standard GHS precautionary statement for the ingredient.',
    `purity_grade` STRING COMMENT 'Required purity level for the ingredient.. Valid values are `pharma|industrial|research|custom`',
    `reache_dossier_number` STRING COMMENT 'Identifier for the REACH dossier associated with the ingredient.. Valid values are `^[A-Z0-9-]+$`',
    `regulatory_threshold_unit` STRING COMMENT 'Unit for the regulatory threshold value.. Valid values are `percent|ppm|mg_per_kg`',
    `regulatory_threshold_value` DECIMAL(18,2) COMMENT 'Maximum permissible level of the ingredient under regulatory limits (e.g., REACH).',
    `restricted_use_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is subject to restricted‑use regulations.',
    `storage_temperature_max` DECIMAL(18,2) COMMENT 'Maximum recommended storage temperature.',
    `storage_temperature_min` DECIMAL(18,2) COMMENT 'Minimum recommended storage temperature.',
    `storage_temperature_unit` STRING COMMENT 'Unit for storage temperature values.. Valid values are `C|F`',
    `target_assay` DECIMAL(18,2) COMMENT 'Desired assay value for the active ingredient.',
    `test_method_code` STRING COMMENT 'LIMS method code used for analytical testing of the ingredient.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the specification.',
    `version_number` STRING COMMENT 'Incremental version of the specification.',
    CONSTRAINT pk_active_ingredient_spec PRIMARY KEY(`active_ingredient_spec_id`)
) COMMENT 'Specification record for active ingredients (API or active chemical component) within a formulation. Defines minimum and maximum active content, target assay value, analytical test method (LIMS method code), regulatory threshold limits (e.g., REACH, EPA, FIFRA), GHS hazard classification, purity grade requirements, and particle size distribution where applicable. Serves as the authoritative active content tracking record for regulatory compliance and QC release.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` (
    `recipe_step_id` BIGINT COMMENT 'Primary key for recipe_step',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Process step approvals are recorded against the responsible employee for GMP compliance and deviation tracking.',
    `equipment_id` BIGINT COMMENT 'Unique identifier of the specific equipment unit used.',
    `formula_id` BIGINT COMMENT 'Identifier of the parent formulation process that this step belongs to.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material/ingredient used in the step.',
    `safety_data_sheet_id` BIGINT COMMENT 'Reference to the SDS applicable to materials used in this step.',
    `actual_agitation_rpm` STRING COMMENT 'Measured agitation speed during execution.',
    `actual_duration_minutes` DECIMAL(18,2) COMMENT 'Measured duration the step actually took.',
    `actual_pressure_bar` DECIMAL(18,2) COMMENT 'Measured pressure achieved during execution.',
    `actual_temperature_c` DECIMAL(18,2) COMMENT 'Measured temperature achieved during execution.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the step was approved.',
    `batch_lot_number` STRING COMMENT 'Lot number of the batch associated with this step.',
    `ccp_flag` BOOLEAN COMMENT 'Indicates whether the step is a critical control point for quality/safety.',
    `control_parameter` STRING COMMENT 'Key process parameter that is monitored or controlled in this step.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the step record was created.',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether the step deviated from target parameters.',
    `deviation_reason` STRING COMMENT 'Explanation for any deviation from target parameters.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Planned duration for the step.',
    `equipment_type` STRING COMMENT 'Category of equipment required to execute the step.. Valid values are `reactor|mixer|heat_exchanger|filter|blender|pump`',
    `ingredient_quantity` DECIMAL(18,2) COMMENT 'Quantity of the ingredient required for the step.',
    `ingredient_uom` STRING COMMENT 'Unit of measure for the ingredient quantity.. Valid values are `kg|g|lb|L|ml|mol`',
    `is_automated` BOOLEAN COMMENT 'Flag indicating if the step is performed automatically by control systems.',
    `notes` STRING COMMENT 'Free-text notes or instructions for the step.',
    `operation_type` STRING COMMENT 'Type of operation performed in this step (e.g., charge, mix, heat, react, filter, blend).. Valid values are `charge|mix|heat|react|filter|blend`',
    `parameter_tolerance_percent` DECIMAL(18,2) COMMENT 'Allowed tolerance percentage for the control parameter.',
    `step_number` STRING COMMENT 'Sequential order of the step within the formulation process.',
    `step_status` STRING COMMENT 'Current execution status of the step.. Valid values are `pending|in_progress|completed|skipped|failed`',
    `target_agitation_rpm` STRING COMMENT 'Desired agitation speed in revolutions per minute.',
    `target_pressure_bar` DECIMAL(18,2) COMMENT 'Desired pressure to achieve during the step.',
    `target_temperature_c` DECIMAL(18,2) COMMENT 'Desired temperature to achieve during the step.',
    `updated_by` STRING COMMENT 'User identifier who last updated the step record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the step record.',
    `version_number` STRING COMMENT 'Version of the step definition for change control.',
    `created_by` STRING COMMENT 'User identifier who created the step record.',
    CONSTRAINT pk_recipe_step PRIMARY KEY(`recipe_step_id`)
) COMMENT 'Ordered sequence of process steps required to manufacture a formulation. Each step captures step number, operation type (charge, mix, heat, cool, react, filter, blend, pH adjust), target process parameters (temperature, pressure, agitation speed, duration), equipment type required, and critical control point (CCP) flag. Supports MES integration and process simulation alignment for batch execution planning.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` (
    `formula_spec_id` BIGINT COMMENT 'System-generated unique identifier for the formula specification record.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Formula specifications belong to a specific formula version; linking provides versioned spec data and removes duplicated versioning fields.',
    `active_ingredient` STRING COMMENT 'Name of the primary active chemical component.',
    `appearance` STRING COMMENT 'Descriptive text of the formulas visual appearance (e.g., clear, opaque).',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the latest revision was approved.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the latest revision.',
    `assay_target_percent` DECIMAL(18,2) COMMENT 'Target assay percentage for the active ingredient.',
    `boiling_point_c` DECIMAL(18,2) COMMENT 'Temperature at which the formulation boils under standard pressure.',
    `color` STRING COMMENT 'Color description of the finished product.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the formula specification record was first created.',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT 'Mass per unit volume of the formulation.',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Lowest temperature at which vapors ignite.',
    `formula_spec_status` STRING COMMENT 'Current lifecycle status of the formula specification.. Valid values are `draft|active|retired|pending|archived`',
    `formula_type` STRING COMMENT 'Classification of the formula based on production method or purpose.. Valid values are `batch|continuous|r&d|custom`',
    `ghs_classification` STRING COMMENT 'Globally Harmonized System hazard classification codes.',
    `hazard_statements` STRING COMMENT 'Standardized hazard statements associated with the formula.',
    `is_compliant` BOOLEAN COMMENT 'True if the formula meets all applicable regulatory requirements.',
    `lot_number_pattern` STRING COMMENT 'Pattern or format used to generate lot numbers for this formula.',
    `max_hap_ppm` DECIMAL(18,2) COMMENT 'Regulatory limit for hazardous air pollutants in the product.',
    `max_tri_release_kg_per_year` DECIMAL(18,2) COMMENT 'Maximum allowed release to the Toxics Release Inventory per year.',
    `max_voc_ppm` DECIMAL(18,2) COMMENT 'Regulatory limit for volatile organic compounds in the product.',
    `melting_point_c` DECIMAL(18,2) COMMENT 'Temperature at which the formulation solidifies.',
    `moc_required` BOOLEAN COMMENT 'Indicates whether a formal MOC is required for changes to this formula.',
    `moisture_content_ppm` DECIMAL(18,2) COMMENT 'Moisture level in parts per million.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the formula specification.',
    `packaging_type` STRING COMMENT 'Primary packaging configuration for the product.',
    `ph` DECIMAL(18,2) COMMENT 'Acidity/alkalinity measurement of the formulation.',
    `purity_grade` STRING COMMENT 'Regulatory purity standard applicable to the active ingredient.. Valid values are `USP|EP|JP|PhEur|Custom`',
    `refractive_index` DECIMAL(18,2) COMMENT 'Optical property indicating light bending capability.',
    `regulatory_region` STRING COMMENT 'Geographic region whose regulatory regime applies to the formula.. Valid values are `US|EU|APAC|LATAM|MEA`',
    `revision_date` DATE COMMENT 'Date when the latest revision was approved.',
    `revision_number` STRING COMMENT 'Sequential revision identifier for change control.',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Ratio of the formulations density to that of water.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the formula specification.',
    `viscosity_cp` DECIMAL(18,2) COMMENT 'Viscosity of the formulation measured in centipoise.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_formula_spec PRIMARY KEY(`formula_spec_id`)
) COMMENT 'Quality specification record for a formula version, defining all physical, chemical, performance, and active ingredient properties the formulation must meet. Covers appearance, viscosity, density, pH, flash point, active content (assay targets, purity grades), regulatory threshold limits, and customer-specific acceptance criteria. Linked to COA generation, QC release decisions, and LIMS analytical methods. SSOT for what does good look like for a given formula version.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` (
    `compatibility_matrix_id` BIGINT COMMENT 'Unique identifier for the compatibility matrix record.',
    `active_ingredient_spec_id` BIGINT COMMENT 'Foreign key linking to formulation.active_ingredient_spec. Business justification: Compatibility matrix entries reference active ingredient specifications; new FK follows naming rule and replaces legacy column.',
    `material_master_id` BIGINT COMMENT 'Identifier of the second component in the compatibility pair.',
    `compatibility_matrix_status` STRING COMMENT 'Current lifecycle status of the compatibility record.. Valid values are `active|inactive|deprecated`',
    `compatibility_rating` STRING COMMENT 'Overall compatibility assessment for the component pair.. Valid values are `compatible|conditionally_compatible|incompatible`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was initially created.',
    `effective_from` DATE COMMENT 'Date from which this compatibility record is effective.',
    `effective_until` DATE COMMENT 'Date until which this compatibility record remains effective (null if indefinite).',
    `notes` STRING COMMENT 'Free-text notes providing additional context or observations.',
    `pressure_max_bar` DECIMAL(18,2) COMMENT 'Maximum pressure (bar) for which the compatibility assessment is valid.',
    `pressure_min_bar` DECIMAL(18,2) COMMENT 'Minimum pressure (bar) for which the compatibility assessment is valid.',
    `risk_type` STRING COMMENT 'Primary safety risk associated with the interaction.. Valid values are `exothermic|corrosive|toxic_gas|none`',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature (°C) at which the compatibility assessment is valid.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature (°C) at which the compatibility assessment is valid.',
    `test_basis` STRING COMMENT 'Source of evidence used to determine compatibility.. Valid values are `experimental|literature|computational`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `version_number` STRING COMMENT 'Version number of the compatibility assessment, incremented on each change.',
    CONSTRAINT pk_compatibility_matrix PRIMARY KEY(`compatibility_matrix_id`)
) COMMENT 'Chemical compatibility assessment matrix recording known interactions between formulation components, raw materials, packaging materials, and storage conditions. Captures component pair identifiers, compatibility rating (compatible, incompatible, conditionally compatible), reaction risk type (exothermic, corrosive, toxic gas generation), test basis (experimental, literature, computational), and applicable temperature/pressure range. Critical for PSM (Process Safety Management) and HAZOP compliance.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` (
    `formula_change_request_id` BIGINT COMMENT 'System-generated unique identifier for the formula change request.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: CUSTOMER‑INITIATED CHANGE REQUEST: Records the originating customer account for formula change requests, needed for traceability and SLA reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Change‑request cost impact is tracked against a cost center for financial approval and budgeting.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or stakeholder who originated the change request.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Formulation change requests often mandate equipment modifications; linking to equipment supports MOC tracking and compliance reporting.',
    `management_of_change_id` BIGINT COMMENT 'FK to ehs.management_of_change.management_of_change_id — Formula change requests must link to the master MOC record in EHS for PSM/OSHA compliance. Without this FK, cannot trace formulation changes back to the formal MOC lifecycle.',
    `material_master_id` BIGINT COMMENT 'Identifier of the component being replaced in the formulation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Change‑request financial impact is evaluated against the responsible profit center for decision making.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Change Request Origin Tracking ties each formula change request to the R&D project that initiated it, supporting governance and audit.',
    `additional_comments` STRING COMMENT 'Free‑form field for any extra information or notes related to the change request.',
    `approval_decision` STRING COMMENT 'Outcome of the most recent approval action.. Valid values are `approved|rejected|needs_more_info`',
    `approval_stage` STRING COMMENT 'Current stage in the multi‑step approval workflow.. Valid values are `initial_review|technical_review|regulatory_review|final_approval`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the latest approval decision was recorded.',
    `approver_role` STRING COMMENT 'Organizational role of the individual performing the current approval step (e.g., Process Engineer, Quality Manager, Regulatory Officer).',
    `business_justification` STRING COMMENT 'Narrative explaining the business need or benefit driving the change.',
    `change_type` STRING COMMENT 'Category of formulation change being requested.. Valid values are `ingredient_substitution|ratio_adjustment|process_parameter_change|supplier_change`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the record was first created in the data lake.',
    `digital_signature` STRING COMMENT 'Cryptographic signature of the approver confirming authenticity of the decision.',
    `effective_implementation_date` DATE COMMENT 'Date on which the approved change becomes operational in production.',
    `equivalency_assessment` STRING COMMENT 'Technical evaluation confirming functional equivalence between original and substitute components.',
    `formula_change_request_status` STRING COMMENT 'Current lifecycle status of the change request.. Valid values are `draft|submitted|approved|rejected|implemented|closed`',
    `impacted_formula_versions` STRING COMMENT 'Comma‑separated list of formula version identifiers that would be affected by the change.',
    `regulatory_reregistration_required` BOOLEAN COMMENT 'Flag indicating whether the change triggers a regulatory re‑submission or re‑registration.',
    `request_number` STRING COMMENT 'Human‑readable business identifier for the change request, used in communications and tracking.',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the change request was initially submitted.',
    `risk_assessment_summary` STRING COMMENT 'High‑level summary of identified risks and mitigations associated with the change.',
    `substitution_approval_status` STRING COMMENT 'Overall approval status of the component substitution.. Valid values are `pending|approved|rejected`',
    `test_data_reference` STRING COMMENT 'Link or identifier to laboratory test results supporting the substitution.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the record.',
    CONSTRAINT pk_formula_change_request PRIMARY KEY(`formula_change_request_id`)
) COMMENT 'Management of Change (MOC) request, approval workflow, and substitution record for formulation changes. Captures change request number, change type (ingredient substitution, ratio adjustment, process parameter change, supplier change), business justification, risk assessment summary, impacted formula versions, regulatory re-registration requirement flag, approval workflow stages (approver role, decision, timestamp, digital signature), substitution details (original/substitute component, equivalency assessment, test data, approval status), and effective implementation date. SSOT for formulation change control governance including full approval audit trail and ingredient substitution management.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` (
    `moc_approval_id` BIGINT COMMENT 'System-generated unique identifier for the MOC approval record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who performed the approval.',
    `management_of_change_id` BIGINT COMMENT 'Identifier of the MOC request to which this approval belongs.',
    `approval_deadline` DATE COMMENT 'Date by which the approval must be completed to keep the MOC schedule on track.',
    `approval_sequence` STRING COMMENT 'Ordinal position of this approval step within the overall MOC workflow.',
    `approver_role` STRING COMMENT 'Functional role of the approver within the organization.. Valid values are `R&D|QA|EHS|Regulatory|Operations`',
    `comments` STRING COMMENT 'Free‑text comments provided by the approver.',
    `condition_notes` STRING COMMENT 'Additional conditions or actions required when the decision is conditionally_approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the approval record was first created in the system.',
    `decision` STRING COMMENT 'Outcome of the approval step.. Valid values are `approved|rejected|conditionally_approved`',
    `decision_timestamp` TIMESTAMP COMMENT 'Date and time when the approval decision was recorded.',
    `digital_signature_reference` STRING COMMENT 'Reference to the stored digital signature for this approval.',
    `is_final_approval` BOOLEAN COMMENT 'True if this step represents the final approval required for the MOC request.',
    `moc_approval_status` STRING COMMENT 'Current lifecycle status of this approval record.. Valid values are `pending|in_progress|completed|closed`',
    `reason_for_rejection` STRING COMMENT 'Explanation provided when the decision is rejected.',
    `related_document_reference` BIGINT COMMENT 'Identifier of supporting documentation attached to the approval (e.g., risk assessment, test report).',
    `signature_timestamp` TIMESTAMP COMMENT 'Date and time when the digital signature was captured.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the approval record.',
    CONSTRAINT pk_moc_approval PRIMARY KEY(`moc_approval_id`)
) COMMENT 'Approval workflow record for a MOC (Management of Change) request. Tracks each approval stage, approver role (R&D, QA, EHS, Regulatory, Operations), approval decision (approved, rejected, conditionally approved), approval timestamp, comments, and digital signature reference. Provides full audit trail for regulatory compliance and GMP documentation requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` (
    `scale_up_record_id` BIGINT COMMENT 'System‑generated unique identifier for the scale‑up record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: CUSTOMER‑DRIVEN SCALE‑UP: Captures which customer commissioned a scale‑up, supporting project costing and invoicing.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Scale‑up studies require an employee sign‑off to validate data before pilot production, per internal SOPs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Scale‑up projects are capital‑budgeted; costs must be allocated to a cost center for CAPEX planning.',
    `formula_id` BIGINT COMMENT 'Reference to the master formulation that is being scaled up.',
    `formulation_process_simulation_id` BIGINT COMMENT 'Reference to the Aspen HYSYS or other simulation model used for the scale‑up.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Capital project profit center requires scale‑up cost linkage for ROI calculation.',
    `trial_batch_id` BIGINT COMMENT 'Foreign key linking to research.trial_batch. Business justification: Scale‑up Planning uses data from R&D trial batch; linking enables comparison of pilot results with scale‑up performance.',
    `approval_status` STRING COMMENT 'Result of the formal scale‑up approval workflow.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the scale‑up record received approval.',
    `batch_size_kg` DECIMAL(18,2) COMMENT 'Target batch mass for the scale‑up run expressed in kilograms.',
    `comments` STRING COMMENT 'Additional free‑form remarks related to the scale‑up.',
    `created_by_user` STRING COMMENT 'User identifier who initially created the scale‑up record.',
    `deviation_notes` STRING COMMENT 'Free‑text description of any deviations observed during scale‑up.',
    `energy_balance_mj` DECIMAL(18,2) COMMENT 'Total energy consumption or balance for the simulated scale‑up run, expressed in megajoules.',
    `last_modified_by_user` STRING COMMENT 'User identifier who last updated the scale‑up record.',
    `phase_equilibrium_status` STRING COMMENT 'Result of phase‑equilibrium analysis for the scale‑up (stable, unstable, or not applicable).. Valid values are `stable|unstable|not_applicable`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scale‑up record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the scale‑up record.',
    `scale_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to the laboratory batch size to reach the target scale.',
    `scale_up_number` STRING COMMENT 'Business‑visible identifier assigned to the scale‑up event.',
    `scale_up_record_status` STRING COMMENT 'Current lifecycle status of the scale‑up record.. Valid values are `pending|approved|rejected|in_review`',
    `scale_up_timestamp` TIMESTAMP COMMENT 'Date and time when the scale‑up transition was executed.',
    `simulation_conversion_rate_percent` DECIMAL(18,2) COMMENT 'Predicted conversion rate from reactants to product in the simulation.',
    `simulation_type` STRING COMMENT 'Classification of the simulation (steady‑state or dynamic).. Valid values are `steady_state|dynamic`',
    `simulation_yield_prediction_percent` DECIMAL(18,2) COMMENT 'Yield percentage predicted by the simulation model.',
    `source_formula_version` STRING COMMENT 'Version label of the original laboratory‑scale formula.',
    `target_scale` STRING COMMENT 'Intended production scale for the formulation (lab, pilot, or commercial).. Valid values are `lab|pilot|commercial`',
    `validated_against_actual` BOOLEAN COMMENT 'Indicates whether the simulation results have been validated with real production data.',
    `validation_date` DATE COMMENT 'Date on which the simulation was compared to actual production results.',
    `validation_notes` STRING COMMENT 'Comments on the outcome of the validation exercise.',
    `yield_percent` DECIMAL(18,2) COMMENT 'Actual product yield achieved at the target scale, expressed as a percent of theoretical maximum.',
    CONSTRAINT pk_scale_up_record PRIMARY KEY(`scale_up_record_id`)
) COMMENT 'Documents the scale-up transition of a formulation from R&D laboratory scale to pilot scale and commercial production scale, including associated process simulation data. Captures source formula version, target scale (lab/pilot/commercial), scale factor, batch size at each scale, process parameter adjustments, yield at each scale, observed deviations, scale-up approval status, simulation model references, simulation type (steady-state, dynamic), key simulation outputs (yield prediction, conversion rate, energy balance, phase equilibrium), and validated-against-actual flag. Bridges computational chemistry, physical formulation development, and production scale-up for process optimization confidence.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` (
    `validation_batch_id` BIGINT COMMENT 'System-generated unique identifier for the validation batch record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: R&D validation batch expenses are charged to a cost center for spend tracking and variance reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator who executed the batch.',
    `equipment_id` BIGINT COMMENT 'Identifier of the equipment or production line used for the batch.',
    `formula_change_request_id` BIGINT COMMENT 'Identifier of the change control record associated with this batch.',
    `formula_version_id` BIGINT COMMENT 'Identifier of the specific formula version being validated.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Validation batches are inspected; linking to the inspection lot enables traceability of validation outcomes.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: R&D profit center reporting needs validation batch linkage for revenue attribution.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: BATCH VALIDATION AT CUSTOMER SITE: Required for regulatory audit trails showing where validation batches were executed for a client.',
    `actual_pressure_bar` DECIMAL(18,2) COMMENT 'Measured average pressure during processing in bar.',
    `actual_temperature_c` DECIMAL(18,2) COMMENT 'Measured average temperature during processing in degrees Celsius.',
    `actual_yield_percent` DECIMAL(18,2) COMMENT 'Actual yield achieved expressed as a percentage of theoretical maximum.',
    `batch_number` STRING COMMENT 'Unique alphanumeric identifier assigned to the validation batch.',
    `batch_size_kg` DECIMAL(18,2) COMMENT 'Planned size of the validation batch expressed in kilograms.',
    `batch_type` STRING COMMENT 'Classification of the batch (e.g., pilot, scale‑up, full production, lab).. Valid values are `pilot|scale_up|full_production|lab`',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the batch.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the validation batch record was first created.',
    `data_capture_system` STRING COMMENT 'System that captured the process data for the batch.. Valid values are `PI|LIMS|MES|HISTORIAN`',
    `data_capture_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch data was ingested into the lakehouse.',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether any deviation from the approved formula occurred during execution.',
    `impurity_ppm` DECIMAL(18,2) COMMENT 'Measured impurity concentration expressed in parts per million.',
    `lot_number` STRING COMMENT 'Lot number assigned to the batch for traceability.',
    `material_batch_number` STRING COMMENT 'Lot number of the primary raw material batch used in the validation.',
    `material_source` STRING COMMENT 'Source identifier of the primary raw material used (e.g., vendor code).',
    `notes` STRING COMMENT 'Free‑text notes captured by the operator or quality engineer.',
    `ph_value` DECIMAL(18,2) COMMENT 'Measured pH of the batch.',
    `pressure_setpoint_bar` DECIMAL(18,2) COMMENT 'Target pressure setpoint for the process in bar.',
    `process_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch processing completed.',
    `process_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch processing started.',
    `quality_issue_description` STRING COMMENT 'Description of any quality issue observed during the batch.',
    `quality_issue_flag` BOOLEAN COMMENT 'Indicates if any quality issue was recorded for the batch.',
    `regulatory_review_status` STRING COMMENT 'Current status of the regulatory review for the batch.. Valid values are `approved|rejected|under_review`',
    `safety_incident_flag` BOOLEAN COMMENT 'Flag indicating whether any safety incident occurred during the batch.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target yield percentage defined in the formula.',
    `temperature_setpoint_c` DECIMAL(18,2) COMMENT 'Target temperature setpoint for the process in degrees Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the validation batch record.',
    `validation_batch_status` STRING COMMENT 'Current lifecycle status of the validation batch.. Valid values are `draft|in_progress|completed|closed|cancelled`',
    `validation_outcome` STRING COMMENT 'Result of the validation batch indicating pass, fail, or conditional status.. Valid values are `pass|fail|conditional`',
    CONSTRAINT pk_validation_batch PRIMARY KEY(`validation_batch_id`)
) COMMENT 'Record of a trial, pilot, or experimental batch produced to validate a new or modified formulation. Captures trial batch number, formula version under test, batch size, equipment used, actual process parameters, yield, trial outcome (pass/fail/conditional), and any deviations from the approved formula observed during execution. Supports R&D-to-production handoff, formula validation, and deviation tracking prior to commercial release.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` (
    `formula_deviation_id` BIGINT COMMENT 'Unique surrogate key for each formula deviation record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Deviation records must capture the approving employee to close the loop on corrective actions and regulatory reporting.',
    `batch_record_id` BIGINT COMMENT 'Identifier of the production or trial batch where the deviation occurred.',
    `capa_id` BIGINT COMMENT 'Link to the corrective and preventive action record associated with this deviation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality deviation handling costs are charged to a cost center for quality cost tracking.',
    `formula_id` BIGINT COMMENT 'Reference to the approved formulation that the batch is based on.',
    `material_master_id` BIGINT COMMENT 'Identifier of the specific ingredient that is affected by the deviation.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the QA approval was recorded.',
    `corrective_action_plan` STRING COMMENT 'Planned steps to correct the immediate deviation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the deviation record was first created in the system.',
    `deviation_amount` DECIMAL(18,2) COMMENT 'Numeric difference between observed and expected values.',
    `deviation_category` STRING COMMENT 'Domain area impacted by the deviation.. Valid values are `chemical|process|quality|safety`',
    `deviation_number` STRING COMMENT 'Business identifier assigned to the deviation event for tracking and reference.',
    `deviation_type` STRING COMMENT 'High‑level classification of why the formula deviated.. Valid values are `ingredient_substitution|ratio_out_of_spec|process_parameter_exceedance|equipment_malfunction|raw_material_variation`',
    `deviation_unit` STRING COMMENT 'Unit of measure for the deviation amount (e.g., kg, %, ppm).',
    `disposition` STRING COMMENT 'Final decision on how the affected batch will be handled.. Valid values are `use_as_is|rework|reject|scrap|hold`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the deviation was observed on the shop floor or in the lab.',
    `expected_value` DECIMAL(18,2) COMMENT 'The value specified in the approved formula (e.g., weight, percent).',
    `formula_deviation_status` STRING COMMENT 'Current lifecycle status of the deviation record.. Valid values are `open|investigating|closed|rejected|approved`',
    `impact_assessment` STRING COMMENT 'Narrative assessment of the deviations impact on product quality, safety, and compliance.',
    `magnitude_percent` DECIMAL(18,2) COMMENT 'Percentage representation of the deviation relative to the expected value.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations related to the deviation.',
    `observed_value` DECIMAL(18,2) COMMENT 'The actual measured value recorded during production.',
    `preventive_action_plan` STRING COMMENT 'Planned steps to prevent recurrence of similar deviations.',
    `qa_approval_flag` BOOLEAN COMMENT 'Indicates whether Quality Assurance has approved the deviation handling.',
    `root_cause_classification` STRING COMMENT 'Broad category describing the underlying cause of the deviation.. Valid values are `human_error|equipment_failure|material_issue|method_issue|environmental|unknown`',
    `root_cause_detail` STRING COMMENT 'Free‑text description of the specific root cause identified.',
    `severity_level` STRING COMMENT 'Risk rating assigned to the deviation based on impact and likelihood.. Valid values are `critical|high|medium|low|informational`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the deviation record.',
    CONSTRAINT pk_formula_deviation PRIMARY KEY(`formula_deviation_id`)
) COMMENT 'Records deviations from the approved formula specification during manufacturing or trial batches. Captures deviation type (ingredient substitution, ratio out-of-spec, process parameter exceedance), affected batch or trial reference, deviation magnitude, root cause classification, CAPA (Corrective and Preventive Action) linkage, disposition decision (use-as-is, rework, reject), and QA approval. Supports OOS (Out of Specification) and OOT (Out of Trend) management.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` (
    `ip_record_id` BIGINT COMMENT 'Unique identifier for the IP record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: IP LICENSING OWNERSHIP: Links IP records to the customer account that holds the license, enabling royalty calculations and compliance tracking.',
    `formula_id` BIGINT COMMENT 'Identifier of the base formulation associated with the IP.',
    `formula_version_id` BIGINT COMMENT 'Identifier of the formula version covered by the IP.',
    `sds_id` BIGINT COMMENT 'Identifier of the Safety Data Sheet linked to the IP.',
    `confidentiality_classification` STRING COMMENT 'Data classification level for the IP record.. Valid values are `confidential|restricted|internal|public`',
    `effective_from` DATE COMMENT 'Date when IP protection becomes effective.',
    `effective_until` DATE COMMENT 'Date when IP protection expires or ends.',
    `ip_approval_authority` STRING COMMENT 'Name or role of the authority that approved the IP record.',
    `ip_approval_date` DATE COMMENT 'Date when the IP record received formal approval.',
    `ip_cas_number` STRING COMMENT 'Standard CAS registry number for the chemical component covered by the IP.. Valid values are `^d{2,7}-d{2}-d$`',
    `ip_change_rationale` STRING COMMENT 'Reason for any changes made to the IP record.',
    `ip_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated monetary value or cost associated with the IP.',
    `ip_creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the IP record was first created.',
    `ip_currency_code` STRING COMMENT 'ISO 4217 currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `ip_ghs_classification` STRING COMMENT 'Globally Harmonized System classification applicable to the IP.',
    `ip_last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the IP record.',
    `ip_number` STRING COMMENT 'Business identifier for the IP record, such as patent number or trade secret code.. Valid values are `^[A-Z0-9-]+$`',
    `ip_owner_party_code` BIGINT COMMENT 'Identifier of the party that owns the IP.',
    `ip_owner_type` STRING COMMENT 'Classification of the IP owner (internal, external, joint).. Valid values are `internal|external|joint`',
    `ip_record_status` STRING COMMENT 'Current lifecycle status of the IP.. Valid values are `draft|pending|active|expired|revoked`',
    `ip_regulatory_classification` STRING COMMENT 'Regulatory framework applicable to the IP.. Valid values are `GHS|REACH|TSCA|EPA`',
    `ip_regulatory_status` STRING COMMENT 'Regulatory compliance status of the IP.. Valid values are `compliant|non_compliant|pending_review`',
    `ip_royalty_amount` DECIMAL(18,2) COMMENT 'Royalty amount per payment period.',
    `ip_royalty_payment_frequency` STRING COMMENT 'Frequency at which royalty payments are made.. Valid values are `monthly|quarterly|annually`',
    `ip_royalty_rate_percent` DECIMAL(18,2) COMMENT 'Royalty rate expressed as a percentage of revenue.',
    `ip_royalty_status` STRING COMMENT 'Current status of royalty payments for the IP.. Valid values are `active|inactive|suspended`',
    `ip_type` STRING COMMENT 'Category of IP protection.. Valid values are `patent|trade_secret|know_how|design_right`',
    `ip_version_number` STRING COMMENT 'Sequential version number of the IP record.',
    `ip_version_status` STRING COMMENT 'Status of this IP version.. Valid values are `current|archived|superseded`',
    `jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction for IP protection.. Valid values are `^[A-Z]{3}$`',
    `license_end_date` DATE COMMENT 'Date when the license expires or terminates.',
    `license_start_date` DATE COMMENT 'Date when the license becomes effective.',
    `licensee_name` STRING COMMENT 'Name of the entity receiving a license for the IP.',
    `licensing_restriction` STRING COMMENT 'Type of licensing restriction applied to the IP.. Valid values are `exclusive|non_exclusive|none`',
    `patent_application_number` STRING COMMENT 'Official patent application number assigned by the patent office.. Valid values are `^[A-Z]{2}[0-9]{6,}$`',
    `patent_expiry_date` DATE COMMENT 'Date the patent expires.',
    `patent_filing_date` DATE COMMENT 'Date the patent application was filed.',
    `patent_grant_date` DATE COMMENT 'Date the patent was granted.',
    `patent_status` STRING COMMENT 'Current status of the patent.. Valid values are `pending|granted|rejected|expired|withdrawn`',
    `trade_secret_description` STRING COMMENT 'Narrative description of the trade secret content.',
    CONSTRAINT pk_ip_record PRIMARY KEY(`ip_record_id`)
) COMMENT 'Intellectual property record for proprietary chemical formulations and blends. Tracks IP type (trade secret, patent, know-how), patent application number, filing date, grant date, expiry date, jurisdiction, confidentiality classification, licensing restrictions, and the formula versions covered by the IP protection. Ensures proprietary blend data is governed and access-controlled appropriately.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` (
    `formulation_regulatory_submission_id` BIGINT COMMENT 'System-generated unique identifier for each regulatory submission record.',
    `formula_id` BIGINT COMMENT 'Identifier of the formulation to which this regulatory submission applies.',
    `active_ingredient_content_percent` DECIMAL(18,2) COMMENT 'Percentage by weight of the primary active ingredient in the formulation.',
    `approval_date` DATE COMMENT 'Date the regulatory authority granted approval or issued a decision.',
    `batch_number` STRING COMMENT 'Identifier of the production batch linked to the regulatory submission, if applicable.',
    `cas_number` STRING COMMENT 'Chemical Abstracts Service registry number uniquely identifying the primary chemical substance.. Valid values are `^d{2,7}-d{2}-d$`',
    `change_reason` STRING COMMENT 'Narrative explaining why the submission was modified or resubmitted.',
    `classification_or_type` STRING COMMENT 'High‑level classification of the submission (e.g., registration, notification, amendment).. Valid values are `registration|notification|classification|amendment|renewal|other`',
    `comments` STRING COMMENT 'Free‑form notes captured by regulatory affairs staff.',
    `compliance_status` STRING COMMENT 'Current compliance outcome of the submission relative to regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `document_reference` STRING COMMENT 'Link or identifier to the electronic dossier or supporting documents stored externally.',
    `effective_from` DATE COMMENT 'Date the approved submission becomes effective for commercial use.',
    `effective_until` DATE COMMENT 'Expiration date of the approval, if applicable; null for open‑ended authorizations.',
    `ghs_classification` STRING COMMENT 'Full GHS classification string, including hazard statements and pictograms.',
    `hazard_classification` STRING COMMENT 'GHS hazard class assigned to the formulation (e.g., Flammable, Toxic).',
    `lifecycle_status` STRING COMMENT 'Current processing state of the submission within the regulatory workflow.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `product_name` STRING COMMENT 'Descriptive name of the chemical product associated with the formulation.',
    `re_submission_required` BOOLEAN COMMENT 'Indicates whether a follow‑up submission is mandated due to changes or regulatory feedback.',
    `re_submission_trigger` STRING COMMENT 'Condition or event that triggers a required resubmission (e.g., formulation change, new hazard data).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    `regulatory_body` STRING COMMENT 'Regulatory authority receiving the submission, such as ECHA, EPA, FDA, or OSHA.. Valid values are `echa|epa|fda|osha|other`',
    `regulatory_classification_code` STRING COMMENT 'Internal code linking the submission to a regulatory classification scheme used by the enterprise.',
    `submission_category` STRING COMMENT 'Broad category of the submission within the regulatory lifecycle.. Valid values are `registration|amendment|renewal|withdrawal|other`',
    `submission_date` DATE COMMENT 'Date the submission was formally sent to the regulatory authority.',
    `submission_number` STRING COMMENT 'Unique dossier or reference number assigned by the regulatory body for tracking.',
    `submission_type` STRING COMMENT 'Category of regulatory submission, e.g., REACH registration, TSCA notification, EPA PMN, SDS filing, GHS classification.. Valid values are `reach|tsca|epa_pmn|sds|ghs|other`',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the active ingredient content percentage or batch size.. Valid values are `kg|g|lb|ton`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the submission record.',
    `version_number` STRING COMMENT 'Incremental version of the submission record reflecting changes or resubmissions.',
    `created_by` STRING COMMENT 'User identifier of the person who created the submission record.',
    CONSTRAINT pk_formulation_regulatory_submission PRIMARY KEY(`formulation_regulatory_submission_id`)
) COMMENT 'Tracks regulatory submissions required for a formulation, including REACH registration, TSCA notification, EPA pre-manufacture notice (PMN), SDS/MSDS filing, and GHS classification submissions. Captures submission type, regulatory body (ECHA, EPA, FDA), submission date, dossier reference number, submission status, approval date, and re-submission trigger conditions. Ensures formulations meet all applicable chemical regulations before commercial release.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` (
    `formulation_process_simulation_id` BIGINT COMMENT 'Primary key for process_simulation',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Simulation resource usage is budgeted to a cost center for R&D expense reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or engineer responsible for the simulation.',
    `formula_version_id` BIGINT COMMENT 'Identifier of the formulation version that the simulation supports.',
    `actual_yield_percent` DECIMAL(18,2) COMMENT 'Yield observed after validation against real production data.',
    `approval_status` STRING COMMENT 'Current approval state of the simulation results.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the simulation was approved or rejected.',
    `avg_pressure_bar` DECIMAL(18,2) COMMENT 'Average pressure across the simulation, in bar.',
    `avg_temperature_c` DECIMAL(18,2) COMMENT 'Average temperature across the simulation, in degrees Celsius.',
    `batch_size_kg` DECIMAL(18,2) COMMENT 'Target batch size for which the simulation was performed, in kilograms.',
    `conversion_rate_percent` DECIMAL(18,2) COMMENT 'Predicted conversion rate of reactants to products, expressed as a percentage.',
    `cpu_usage_percent` DECIMAL(18,2) COMMENT 'Average CPU utilization during the simulation run.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the simulation record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Overall quality rating of the simulation input and output data (0‑1 scale).',
    `end_timestamp` TIMESTAMP COMMENT 'Date‑time when the simulation execution finished.',
    `energy_balance_mwh` DECIMAL(18,2) COMMENT 'Net energy consumption or generation for the simulated process, in megawatt‑hours.',
    `formulation_process_simulation_status` STRING COMMENT 'Current lifecycle status of the simulation.. Valid values are `draft|running|completed|failed|validated`',
    `ghs_classification` STRING COMMENT 'Globally Harmonized System hazard classification relevant to the simulated formulation.',
    `input_data_set_reference` BIGINT COMMENT 'Identifier of the input data set used for the simulation.',
    `is_sensitivity_analysis` BOOLEAN COMMENT 'Indicates whether the simulation includes a sensitivity analysis.',
    `memory_usage_gb` DECIMAL(18,2) COMMENT 'Peak memory consumption of the simulation, in gigabytes.',
    `model_reference` STRING COMMENT 'Identifier of the underlying process model used in the simulation.',
    `notes` STRING COMMENT 'Free‑form notes captured by the analyst about the simulation run.',
    `output_data_set_reference` BIGINT COMMENT 'Identifier of the data set generated by the simulation.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the simulation adheres to applicable regulatory constraints (e.g., EPA, OSHA).',
    `runtime_minutes` DECIMAL(18,2) COMMENT 'Total wall‑clock time the simulation consumed, in minutes.',
    `sensitivity_parameters` STRING COMMENT 'JSON‑encoded list of parameters varied in the sensitivity analysis.',
    `simulation_category` STRING COMMENT 'Category of simulation such as pilot, full‑scale, or R&D.',
    `simulation_code` STRING COMMENT 'External code or number assigned to the simulation run.',
    `simulation_software` STRING COMMENT 'Software platform used to execute the simulation.. Valid values are `Aspen_HYSYS|Aspen_Pro|Other`',
    `simulation_type` STRING COMMENT 'Category of simulation: steady‑state, dynamic, or scale‑up.. Valid values are `steady_state|dynamic|scale_up`',
    `start_timestamp` TIMESTAMP COMMENT 'Date‑time when the simulation execution began.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Desired product yield set for the simulation, expressed as a percentage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the simulation record.',
    `validated_against_actual` BOOLEAN COMMENT 'Indicates whether the simulation results have been validated against real production data.',
    `validation_notes` STRING COMMENT 'Comments from the validation team regarding discrepancies or confirmations.',
    `version_number` STRING COMMENT 'Version number of the simulation definition.',
    `yield_prediction_percent` DECIMAL(18,2) COMMENT 'Predicted product yield expressed as a percentage.',
    CONSTRAINT pk_formulation_process_simulation PRIMARY KEY(`formulation_process_simulation_id`)
) COMMENT 'Record of a process simulation run associated with a formulation version. Captures simulation model reference, simulation software platform, simulation type (steady-state, dynamic, scale-up), key outputs (yield prediction, conversion rate, energy balance, phase equilibrium), simulation status, validated-against-actual flag, and the formula version the simulation supports. Bridges computational chemistry and physical formulation development for scale-up confidence and process optimization.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` (
    `formula_stability_test_id` BIGINT COMMENT 'Unique identifier for the stability testing study record.',
    `formula_id` BIGINT COMMENT 'Identifier of the formulation that is being tested for stability.',
    `stability_study_id` BIGINT COMMENT 'FK to quality.stability_study.stability_study_id — Formula stability tests must reference the master stability study in quality domain for unified stability program management and ICH compliance reporting.',
    `approval_date` DATE COMMENT 'Date when the study results were formally approved.',
    `approved_by` STRING COMMENT 'Identifier of the person or role that approved the study results.',
    `conclusion_summary` STRING COMMENT 'Narrative summary of the stability study conclusion and any recommendations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the stability study record was created in the system.',
    `effective_date` DATE COMMENT 'Date when the stability study became effective for reporting purposes.',
    `expiry_date` DATE COMMENT 'Date after which the stability study is considered expired or superseded.',
    `formula_stability_test_status` STRING COMMENT 'Current lifecycle status of the stability study.. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `light_exposure` STRING COMMENT 'Light exposure condition applied during storage (dark, ambient, or UV).. Valid values are `dark|ambient|uv`',
    `measurement_appearance` STRING COMMENT 'Qualitative observation of appearance (e.g., clear, hazy, precipitate) at the test interval.',
    `measurement_assay_percent` DECIMAL(18,2) COMMENT 'Assay result expressed as percent of active ingredient at the test interval.',
    `measurement_ph` DECIMAL(18,2) COMMENT 'Measured pH of the formulation at the test interval.',
    `measurement_viscosity_cp` DECIMAL(18,2) COMMENT 'Measured viscosity of the formulation at the test interval, expressed in centipoise.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `protocol_description` STRING COMMENT 'Detailed description of the test protocol, including sample preparation and analytical methods.',
    `result_status` STRING COMMENT 'Overall status of the test result for the interval.. Valid values are `pass|fail|out_of_spec`',
    `result_timestamp` TIMESTAMP COMMENT 'Date‑time when the analytical result was recorded.',
    `shelf_life_months` STRING COMMENT 'Calculated shelf‑life in months based on the stability data.',
    `storage_humidity_percent` DECIMAL(18,2) COMMENT 'Target relative humidity percentage for the storage environment.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Target storage temperature in degrees Celsius for the stability study.',
    `study_code` STRING COMMENT 'Business code assigned to the stability study for tracking and reference.',
    `study_name` STRING COMMENT 'Human‑readable name of the stability testing study.',
    `test_interval_days` STRING COMMENT 'Number of days after start of storage when the sample is tested.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the stability study record.',
    `version_number` STRING COMMENT 'Version number of the stability study record, incremented on each change.',
    CONSTRAINT pk_formula_stability_test PRIMARY KEY(`formula_stability_test_id`)
) COMMENT 'Stability testing study record for a formulation, tracking how the formulations physical and chemical properties change over time under defined storage conditions (temperature, humidity, light exposure). Captures study protocol, storage conditions, test intervals, test parameters (viscosity, pH, assay, appearance), results at each time point, shelf life determination, and study conclusion. Supports product shelf life claims and regulatory submissions.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` (
    `formula_substitution_id` BIGINT COMMENT 'Unique system-generated identifier for the formula substitution record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Substitution approvals are tied to a qualified employee to ensure safety, compliance, and cost‑impact analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Substitution cost‑savings and impact are allocated to a cost center for financial analysis.',
    `recipe_line_item_id` BIGINT COMMENT 'Identifier of the component being replaced.',
    `affected_formula_version_ids` STRING COMMENT 'Comma‑separated list of formula version identifiers impacted by this substitution.',
    `approval_date` DATE COMMENT 'Date when the substitution was formally approved.',
    `change_control_number` STRING COMMENT 'Reference number linking the substitution to a Management of Change (MOC) record.',
    `cost_savings_estimate` DECIMAL(18,2) COMMENT 'Estimated monetary savings per batch resulting from the substitution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the substitution record was created in the system.',
    `effective_date` DATE COMMENT 'Date from which the substitution may be applied in production.',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Score (0‑100) indicating the environmental benefit or risk of the substitution.',
    `equivalency_assessment` STRING COMMENT 'Summary of the technical assessment confirming equivalence.',
    `equivalency_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the technical equivalence of the substitute component.',
    `expiry_date` DATE COMMENT 'Date after which the substitution is no longer valid.',
    `formula_substitution_status` STRING COMMENT 'Current lifecycle status of the substitution record.. Valid values are `pending|approved|rejected|revoked`',
    `hazard_classification_change` STRING COMMENT 'Indicates if the substitution changes the overall hazard classification.. Valid values are `none|increase|decrease`',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the substitution.',
    `rationale` STRING COMMENT 'Business reason for performing the substitution (e.g., supply shortage, cost reduction).',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether the substitution triggers regulatory review.',
    `substitution_category` STRING COMMENT 'Classification of the substitution driver.. Valid values are `cost_reduction|supply_shortage|regulatory|performance|other`',
    `substitution_code` STRING COMMENT 'Business code used to reference the substitution in processes and documentation.',
    `substitution_name` STRING COMMENT 'Human‑readable name describing the substitution.',
    `test_report_reference` BIGINT COMMENT 'Reference to the laboratory test report supporting the substitution.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the substitution record.',
    `validation_test_date` DATE COMMENT 'Date when the validation test was performed.',
    `validation_test_result` STRING COMMENT 'Result of the validation testing performed on the substituted formulation.. Valid values are `pass|fail|conditional`',
    CONSTRAINT pk_formula_substitution PRIMARY KEY(`formula_substitution_id`)
) COMMENT 'Records approved ingredient substitutions within a formulation, capturing the original component, the substitute component, substitution rationale (supply shortage, cost reduction, regulatory restriction), equivalency assessment outcome, test data supporting substitution, approval status, and the formula versions affected. Supports supply chain resilience and raw material sourcing flexibility without compromising product quality.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` (
    `mes_recipe_id` BIGINT COMMENT 'Unique identifier for the MES recipe record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: MES recipe changes must be authorized by a responsible employee to meet GMP and change‑control procedures.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: MES recipe execution costs are charged to a cost center for production cost accounting.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: MES recipe assignment to a specific reactor/equipment is required for production scheduling, traceability, and regulatory batch records.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Mes recipe is derived from an approved formula version; linking enables traceability from production recipe to its source version.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the recipe received regulatory or MOC approval.',
    `batch_number_prefix` STRING COMMENT 'Prefix used when generating batch numbers for runs of this recipe.',
    `change_control_number` STRING COMMENT 'Identifier linking the recipe to its change control request.',
    `control_strategy` STRING COMMENT 'Control algorithm or strategy applied during recipe execution.. Valid values are `PID|MPC|ON_OFF|Fuzzy|RuleBased`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recipe record was first created.',
    `effective_end_date` DATE COMMENT 'Date after which the recipe is no longer valid (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which the recipe becomes valid for execution.',
    `equipment_unit` STRING COMMENT 'Type of equipment or unit where the recipe is executed.. Valid values are `reactor|mixer|distillation_column|heat_exchanger|storage_tank`',
    `ghs_classification` STRING COMMENT 'Globally Harmonized System classification for the recipes hazardous aspects.. Valid values are `explosive|flammable|corrosive|toxic|environmental_hazard|oxidizer`',
    `hazardous_ingredient_flag` BOOLEAN COMMENT 'Indicates whether the recipe contains any hazardous ingredients.',
    `hold_time_minutes` STRING COMMENT 'Duration to hold a setpoint before proceeding to the next step, in minutes.',
    `ingredient_material_code` STRING COMMENT 'Material code of the ingredient used in the recipe.',
    `ingredient_sequence` STRING COMMENT 'Order in which ingredients are charged into the equipment.',
    `is_current` BOOLEAN COMMENT 'Flag indicating whether this version is the current active recipe.',
    `is_valid` BOOLEAN COMMENT 'Flag indicating whether the recipe passes all validation checks for execution.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful sync with MES/DCS.',
    `lot_number_prefix` STRING COMMENT 'Prefix used when generating lot numbers for material produced with this recipe.',
    `mes_recipe_status` STRING COMMENT 'Current lifecycle status of the recipe.. Valid values are `active|inactive|draft|deprecated|retired`',
    `notes` STRING COMMENT 'Free‑form notes or comments about the recipe.',
    `ph_setpoint` DECIMAL(18,2) COMMENT 'Target pH value for the process.',
    `ramp_rate_c_per_min` DECIMAL(18,2) COMMENT 'Rate at which temperature is increased or decreased, expressed in °C per minute.',
    `recipe_code` STRING COMMENT 'Business identifier code for the recipe used in production planning.',
    `recipe_name` STRING COMMENT 'Human‑readable name of the recipe.',
    `recipe_source` STRING COMMENT 'Reference to the originating formula or version from which this recipe was derived.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory approval for the recipe.. Valid values are `approved|pending|rejected|under_review`',
    `setpoint_pressure_bar` DECIMAL(18,2) COMMENT 'Target pressure setpoint for the process, in bar.',
    `setpoint_temperature_c` DECIMAL(18,2) COMMENT 'Target temperature setpoint for the process, in degrees Celsius.',
    `sync_status` STRING COMMENT 'Current synchronization state between the recipe record and shop‑floor control systems.. Valid values are `synced|pending|error|out_of_sync`',
    `target_batch_size_kg` DECIMAL(18,2) COMMENT 'Planned batch size for which the recipe is designed, expressed in kilograms.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Expected product yield expressed as a percentage of the target batch size.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the recipe record.',
    `version_number` STRING COMMENT 'Sequential version number of the recipe.',
    CONSTRAINT pk_mes_recipe PRIMARY KEY(`mes_recipe_id`)
) COMMENT 'Production-ready recipe record derived from an approved formula version for execution on manufacturing execution systems (MES), distributed control systems (DCS), or programmable logic controllers (PLC). Captures recipe code, target equipment unit, control recipe parameters, phase instructions, setpoints, material charge sequences, and synchronization status with plant automation. Bridges formulation master data and real-time batch execution on the shop floor per ISA-88 batch control standards.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`formula_contract` (
    `formula_contract_id` BIGINT COMMENT 'Primary key for the FormulaContract association',
    `account_id` BIGINT COMMENT 'Foreign key linking to the customer account',
    `formula_id` BIGINT COMMENT 'Foreign key linking to the chemical formulation',
    `contract_end_date` DATE COMMENT 'Date when the contract expires or is terminated',
    `contract_start_date` DATE COMMENT 'Date when the contract becomes effective',
    `contract_status` STRING COMMENT 'Current status of the contract (e.g., Active, Suspended, Terminated)',
    `pricing_tier` STRING COMMENT 'Pricing tier agreed for this account‑formula contract',
    CONSTRAINT pk_formula_contract PRIMARY KEY(`formula_contract_id`)
) COMMENT 'Represents a contractual agreement between a customer account and a chemical formulation. Each record captures the specific terms of the agreement, including effective dates, pricing tier, and contract status, linking one account to one formula.. Existence Justification: Customers (accounts) can hold contracts for multiple chemical formulas, and each formula can be sold to many customers under separate contracts. The contract itself carries attributes such as start/end dates, pricing tier, and status, which are managed by business users. Therefore the relationship is a true many‑to‑many operational entity.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`formula_waste` (
    `formula_waste_id` BIGINT COMMENT 'Primary key for the formula_waste association',
    `formula_id` BIGINT COMMENT 'Foreign key linking to the formulation',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to the waste stream',
    `disposal_method` STRING COMMENT 'Disposal method applied to this waste when generated by the specific formula',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of waste generated for the formula in the unit defined by the waste stream',
    `waste_origin_process` STRING COMMENT 'Name of the production process step that creates the waste for this formula',
    CONSTRAINT pk_formula_waste PRIMARY KEY(`formula_waste_id`)
) COMMENT 'Represents the association between a chemical formulation and a waste stream. Each record captures the quantity of waste generated, the process that creates it, and the disposal method specific to that formula‑waste pairing.. Existence Justification: In chemical manufacturing, a single formulation can generate several distinct waste streams, and each waste‑stream type can be produced by many different formulations. Engineers actively record each formula‑waste pairing with quantities, the originating process, and disposal method, and the records are created, updated, and deleted as production changes.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`formulation`.`pricing_assignment` (
    `pricing_assignment_id` BIGINT COMMENT 'Primary key for the pricing_assignment association',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to the formula version',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to the pricing strategy',
    `effective_from` DATE COMMENT 'Date the pricing strategy becomes active for the formula version',
    `effective_until` DATE COMMENT 'Date the pricing strategy expires for the formula version',
    `rationale` STRING COMMENT 'Business justification for assigning this pricing strategy to the formula version',
    CONSTRAINT pk_pricing_assignment PRIMARY KEY(`pricing_assignment_id`)
) COMMENT 'This association captures the assignment of a pricing strategy to a specific formula version. Each record links one formula_version to one pricing_strategy and stores the effective period and rationale for that assignment.. Existence Justification: The pricing team actively assigns pricing strategies to individual formula versions. A single formula version can have multiple pricing strategies over its lifecycle, and a pricing strategy can be applied to many different formula versions. The assignment is tracked with effective dates and a rationale, making the relationship a managed business entity.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ADD CONSTRAINT `fk_formulation_recipe_line_item_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ADD CONSTRAINT `fk_formulation_recipe_step_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ADD CONSTRAINT `fk_formulation_formula_spec_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ADD CONSTRAINT `fk_formulation_compatibility_matrix_active_ingredient_spec_id` FOREIGN KEY (`active_ingredient_spec_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec`(`active_ingredient_spec_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ADD CONSTRAINT `fk_formulation_scale_up_record_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ADD CONSTRAINT `fk_formulation_scale_up_record_formulation_process_simulation_id` FOREIGN KEY (`formulation_process_simulation_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation`(`formulation_process_simulation_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ADD CONSTRAINT `fk_formulation_validation_batch_formula_change_request_id` FOREIGN KEY (`formula_change_request_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_change_request`(`formula_change_request_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ADD CONSTRAINT `fk_formulation_validation_batch_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ADD CONSTRAINT `fk_formulation_formula_deviation_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ADD CONSTRAINT `fk_formulation_ip_record_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ADD CONSTRAINT `fk_formulation_ip_record_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ADD CONSTRAINT `fk_formulation_formulation_regulatory_submission_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ADD CONSTRAINT `fk_formulation_formulation_process_simulation_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ADD CONSTRAINT `fk_formulation_formula_stability_test_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ADD CONSTRAINT `fk_formulation_formula_substitution_recipe_line_item_id` FOREIGN KEY (`recipe_line_item_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`recipe_line_item`(`recipe_line_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ADD CONSTRAINT `fk_formulation_mes_recipe_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_contract` ADD CONSTRAINT `fk_formulation_formula_contract_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_waste` ADD CONSTRAINT `fk_formulation_formula_waste_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula`(`formula_id`);
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`pricing_assignment` ADD CONSTRAINT `fk_formulation_pricing_assignment_formula_version_id` FOREIGN KEY (`formula_version_id`) REFERENCES `chemical_mfg_ecm`.`formulation`.`formula_version`(`formula_version_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`formulation` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `chemical_mfg_ecm`.`formulation` SET TAGS ('dbx_domain' = 'formulation');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` SET TAGS ('dbx_subdomain' = 'formulation_design');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `active_ingredient_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Content (%)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `blend_ratio_description` SET TAGS ('dbx_business_glossary_term' = 'Blend Ratio Description');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `default_process_parameter` SET TAGS ('dbx_business_glossary_term' = 'Default Process Parameter');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `formula_code` SET TAGS ('dbx_business_glossary_term' = 'Formula Code');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `formula_name` SET TAGS ('dbx_business_glossary_term' = 'Formula Name');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `formula_status` SET TAGS ('dbx_business_glossary_term' = 'Formula Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `formula_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|archived|pending|draft');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `formulation_category` SET TAGS ('dbx_business_glossary_term' = 'Formulation Category');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `formulation_category` SET TAGS ('dbx_value_regex' = 'batch|continuous|custom|standard');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'GHS Classification');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `hazard_statement` SET TAGS ('dbx_business_glossary_term' = 'Hazard Statement');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `ip_ownership_flag` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Ownership Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `precautionary_statement` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Statement');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'GHS|REACH|TSCA|EPA|ISO');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `standard_batch_size_kg` SET TAGS ('dbx_business_glossary_term' = 'Standard Batch Size (kg)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `version_control_method` SET TAGS ('dbx_business_glossary_term' = 'Version Control Method');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `version_control_method` SET TAGS ('dbx_value_regex' = 'MOC|Manual|Automated');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula` ALTER COLUMN `version_count` SET TAGS ('dbx_business_glossary_term' = 'Version Count');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` SET TAGS ('dbx_subdomain' = 'formulation_design');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `management_of_change_id` SET TAGS ('dbx_business_glossary_term' = 'MOC ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'BOM Type');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'r&d|pilot|commercial');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `change_rationale` SET TAGS ('dbx_business_glossary_term' = 'Change Rationale');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `formula_code` SET TAGS ('dbx_business_glossary_term' = 'Formula Code');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `formula_name` SET TAGS ('dbx_business_glossary_term' = 'Formula Name');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `formulation_owner` SET TAGS ('dbx_business_glossary_term' = 'Formulation Owner');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'explosive|flammable|corrosive|toxic|environmental|non_hazardous');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `target_batch_size` SET TAGS ('dbx_business_glossary_term' = 'Target Batch Size');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|l|g|ml|ton');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `version_description` SET TAGS ('dbx_business_glossary_term' = 'Version Description');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|approved|obsolete|pending');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` SET TAGS ('dbx_subdomain' = 'formulation_design');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `formula_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Bill of Materials ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `bom_code` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials Code');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `bom_name` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials Name');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials Classification');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'product|intermediate|raw_material|custom');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `component_cas_number` SET TAGS ('dbx_business_glossary_term' = 'Component CAS Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `component_name` SET TAGS ('dbx_business_glossary_term' = 'Component Name');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `component_quantity` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `component_sequence` SET TAGS ('dbx_business_glossary_term' = 'Component Sequence');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `component_uom` SET TAGS ('dbx_business_glossary_term' = 'Component Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `critical_ingredient` SET TAGS ('dbx_business_glossary_term' = 'Critical Ingredient Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `environmental_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Score');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `formula_bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `formula_bom_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'GHS Classification');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `hazardous_ingredient_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Ingredient Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `process_stage` SET TAGS ('dbx_business_glossary_term' = 'Process Stage');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `process_stage` SET TAGS ('dbx_value_regex' = 'R&D|Scale-up|Production');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `substitution_allowed` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `tolerance_max` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Maximum');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `tolerance_min` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Minimum');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_bom` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` SET TAGS ('dbx_subdomain' = 'formulation_design');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `recipe_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Line Item Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version ID (FORMULA_VERSION_ID)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (SUPPLIER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `reach_dossier_id` SET TAGS ('dbx_business_glossary_term' = 'REACH Dossier Identifier (REACH_DOSSIER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Identifier (SDS_ID)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `active_ingredient_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Flag (ACTIVE_ING_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `addition_sequence` SET TAGS ('dbx_business_glossary_term' = 'Addition Sequence Number (ADD_SEQ)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Verification Method (ANALYTICAL_METHOD)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `blend_ratio_percent` SET TAGS ('dbx_business_glossary_term' = 'Blend Ratio Percentage (BLEND_RATIO_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control (MOC) Number (CHANGE_CONTROL_NO)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type (e.g., Raw Material, Solvent) (COMPONENT_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'raw_material|intermediate|solvent|catalyst|additive|other');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit (CONC_UNIT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_value_regex' = '% w/w|% v/v|ppm');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `critical_ingredient_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Ingredient Flag (CRITICAL_ING_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFFECTIVE_FROM)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFFECTIVE_UNTIL)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification (GHS_CLASS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Component Flag (IS_DEFAULT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Soft Delete Flag (IS_DELETED)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|approved|released|obsolete');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number (LINE_SEQ)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `measurement_basis` SET TAGS ('dbx_business_glossary_term' = 'Measurement Basis (MEASUREMENT_BASIS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `measurement_basis` SET TAGS ('dbx_value_regex' = 'weight|volume|molar');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `mixing_order` SET TAGS ('dbx_business_glossary_term' = 'Mixing Order (MIXING_ORDER)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `mixing_order` SET TAGS ('dbx_value_regex' = 'pre_mix|post_mix|simultaneous');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `nominal_quantity` SET TAGS ('dbx_business_glossary_term' = 'Nominal Quantity (NOMINAL_QTY)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `ratio_basis` SET TAGS ('dbx_business_glossary_term' = 'Ratio Basis (WEIGHT/ VOLUME/ MOLAR) (RATIO_BASIS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `ratio_basis` SET TAGS ('dbx_value_regex' = 'weight|volume|molar');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `recipe_line_item_status` SET TAGS ('dbx_business_glossary_term' = 'Component Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `recipe_line_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status (REGULATORY_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'approved|restricted|banned');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `substitution_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Eligibility Flag (SUBSTITUTION_ELIGIBLE_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `target_concentration` SET TAGS ('dbx_business_glossary_term' = 'Target Concentration (TARGET_CONC)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|L|mL|mol|%');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_line_item` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Version Number (LINE_VERSION_NO)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` SET TAGS ('dbx_subdomain' = 'formulation_design');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `blend_ratio_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Ratio Identifier (BLEND_RATIO_ID)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Component Identifier (COMPONENT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method (ANALYTICAL_METHOD)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User (APPROVED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH_NO)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `blend_code` SET TAGS ('dbx_business_glossary_term' = 'Blend Code (BLEND_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `blend_name` SET TAGS ('dbx_business_glossary_term' = 'Blend Name (BLEND_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `blend_ratio_status` SET TAGS ('dbx_business_glossary_term' = 'Blend Lifecycle Status (BLEND_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `blend_ratio_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `blend_type` SET TAGS ('dbx_business_glossary_term' = 'Blend Type (BLEND_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `blend_type` SET TAGS ('dbx_value_regex' = 'pilot|commercial|experimental|research');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Description (CHANGE_REASON)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `component_cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number (CAS_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `component_cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit (CONC_UNIT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_value_regex' = 'percent_w_w|percent_v_v|ppm|mol_percent|mg_per_kg');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System for Blend Ratio Data (DATA_SOURCE_SYSTEM)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `ehs_review_status` SET TAGS ('dbx_business_glossary_term' = 'EHS Review Status (EHS_REVIEW_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `ehs_review_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `ghs_classification_code` SET TAGS ('dbx_business_glossary_term' = 'GHS Classification Code (GHS_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `ip_protection_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Protection Status (IP_PROTECTION_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `ip_protection_status` SET TAGS ('dbx_value_regex' = 'patented|trade_secret|none');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `is_proprietary` SET TAGS ('dbx_business_glossary_term' = 'Proprietary Blend Indicator (IS_PROPRIETARY)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `last_quality_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Quality Check Timestamp (LAST_QC_TS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NO)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `measurement_basis` SET TAGS ('dbx_business_glossary_term' = 'Measurement Basis (MEAS_BASIS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `measurement_basis` SET TAGS ('dbx_value_regex' = 'weight|volume|molar');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp (MEAS_TS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty (MEAS_UNCERTAINTY)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `nominal_concentration` SET TAGS ('dbx_business_glossary_term' = 'Nominal Concentration (NOMINAL_CONC)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Status (QC_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'passed|failed|under_review');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (REG_COMPL_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days) (RETENTION_DAYS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `safety_data_sheet_ref` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Reference (SDS_REF)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `scale_up_factor` SET TAGS ('dbx_business_glossary_term' = 'Scale-Up Factor (SCALE_UP_FACTOR)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `target_concentration` SET TAGS ('dbx_business_glossary_term' = 'Target Concentration (TARGET_CONC)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NO)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`blend_ratio` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CREATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` SET TAGS ('dbx_subdomain' = 'formulation_design');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `active_ingredient_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Specification ID (AISI)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID (SID)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `active_ingredient_spec_code` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Specification Code (AISC)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `active_ingredient_spec_name` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Name (AIN)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `active_ingredient_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status (SS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `active_ingredient_spec_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (AT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (AB)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `assay_unit` SET TAGS ('dbx_business_glossary_term' = 'Assay Unit (AU)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `assay_unit` SET TAGS ('dbx_value_regex' = 'percent|ppm|mg_per_kg');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `batch_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Batch/Lot Number (BLN)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `batch_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Registry Number (CAS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason (CR)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (DU)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `documentation_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `echa_registration_number` SET TAGS ('dbx_business_glossary_term' = 'ECHA Registration Number (ERN)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `echa_registration_number` SET TAGS ('dbx_value_regex' = '^d{4}-d{2}-d{2}$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (ED)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXD)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'GHS Classification (GHS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_value_regex' = 'flammable|corrosive|toxic|environmental_hazard|none');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `ghs_pictogram_codes` SET TAGS ('dbx_business_glossary_term' = 'GHS Pictogram Codes (GPC)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Handling Instructions (HI)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `hazard_statement` SET TAGS ('dbx_business_glossary_term' = 'Hazard Statement (HS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `ingredient_type` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Type (IT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `ingredient_type` SET TAGS ('dbx_value_regex' = 'api|excipient|intermediate|solvent');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `max_content` SET TAGS ('dbx_business_glossary_term' = 'Maximum Content Percentage (XCP)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `min_content` SET TAGS ('dbx_business_glossary_term' = 'Minimum Content Percentage (MCP)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `particle_size_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Particle Size (XPS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `particle_size_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Particle Size (MPS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `particle_size_unit` SET TAGS ('dbx_business_glossary_term' = 'Particle Size Unit (PSU)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `particle_size_unit` SET TAGS ('dbx_value_regex' = 'micron|nm|mm');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `precautionary_statement` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Statement (PS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `purity_grade` SET TAGS ('dbx_business_glossary_term' = 'Purity Grade (PG)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `purity_grade` SET TAGS ('dbx_value_regex' = 'pharma|industrial|research|custom');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `reache_dossier_number` SET TAGS ('dbx_business_glossary_term' = 'REACH Dossier Number (RDN)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `reache_dossier_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `regulatory_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Unit (RTU)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `regulatory_threshold_unit` SET TAGS ('dbx_value_regex' = 'percent|ppm|mg_per_kg');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `regulatory_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Value (RTV)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `restricted_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Use Flag (RUF)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `storage_temperature_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (XST)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `storage_temperature_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (MST)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `storage_temperature_unit` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Unit (STU)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `storage_temperature_unit` SET TAGS ('dbx_value_regex' = 'C|F');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `target_assay` SET TAGS ('dbx_business_glossary_term' = 'Target Assay Value (TAV)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `test_method_code` SET TAGS ('dbx_business_glossary_term' = 'Test Method Code (TMC)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`active_ingredient_spec` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VN)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` SET TAGS ('dbx_subdomain' = 'formulation_design');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `recipe_step_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Step Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Process ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Material ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `actual_agitation_rpm` SET TAGS ('dbx_business_glossary_term' = 'Actual Agitation Speed (RPM)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (minutes)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `actual_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Actual Pressure (bar)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `actual_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Actual Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `batch_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `ccp_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `control_parameter` SET TAGS ('dbx_business_glossary_term' = 'Control Parameter');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `deviation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deviation Reason');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target Duration (minutes)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `equipment_type` SET TAGS ('dbx_value_regex' = 'reactor|mixer|heat_exchanger|filter|blender|pump');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `ingredient_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Quantity');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `ingredient_uom` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `ingredient_uom` SET TAGS ('dbx_value_regex' = 'kg|g|lb|L|ml|mol');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Step Notes');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `operation_type` SET TAGS ('dbx_value_regex' = 'charge|mix|heat|react|filter|blend');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `parameter_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Parameter Tolerance (%)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `step_number` SET TAGS ('dbx_business_glossary_term' = 'Step Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `step_status` SET TAGS ('dbx_business_glossary_term' = 'Step Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `step_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|skipped|failed');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `target_agitation_rpm` SET TAGS ('dbx_business_glossary_term' = 'Target Agitation Speed (RPM)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `target_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Target Pressure (bar)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `target_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`recipe_step` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` SET TAGS ('dbx_subdomain' = 'formulation_design');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `formula_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Specification Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `active_ingredient` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `appearance` SET TAGS ('dbx_business_glossary_term' = 'Physical Appearance');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `assay_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Assay Target (%)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `boiling_point_c` SET TAGS ('dbx_business_glossary_term' = 'Boiling Point (°C)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `color` SET TAGS ('dbx_business_glossary_term' = 'Color');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `density_kg_per_m3` SET TAGS ('dbx_business_glossary_term' = 'Density (kg/m³)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (°C)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `formula_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Formula Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `formula_spec_status` SET TAGS ('dbx_value_regex' = 'draft|active|retired|pending|archived');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `formula_type` SET TAGS ('dbx_business_glossary_term' = 'Formula Type');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `formula_type` SET TAGS ('dbx_value_regex' = 'batch|continuous|r&d|custom');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'GHS Classification');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `hazard_statements` SET TAGS ('dbx_business_glossary_term' = 'Hazard Statements');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `is_compliant` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `lot_number_pattern` SET TAGS ('dbx_business_glossary_term' = 'Lot Number Pattern');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `max_hap_ppm` SET TAGS ('dbx_business_glossary_term' = 'Maximum HAP (ppm)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `max_tri_release_kg_per_year` SET TAGS ('dbx_business_glossary_term' = 'Maximum TRI Release (kg/yr)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `max_voc_ppm` SET TAGS ('dbx_business_glossary_term' = 'Maximum VOC (ppm)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `melting_point_c` SET TAGS ('dbx_business_glossary_term' = 'Melting Point (°C)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `moc_required` SET TAGS ('dbx_business_glossary_term' = 'Management of Change Required');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `moisture_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content (ppm)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `ph` SET TAGS ('dbx_business_glossary_term' = 'pH (Potential of Hydrogen)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `purity_grade` SET TAGS ('dbx_business_glossary_term' = 'Purity Grade');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `purity_grade` SET TAGS ('dbx_value_regex' = 'USP|EP|JP|PhEur|Custom');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `refractive_index` SET TAGS ('dbx_business_glossary_term' = 'Refractive Index');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_value_regex' = 'US|EU|APAC|LATAM|MEA');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `viscosity_cp` SET TAGS ('dbx_business_glossary_term' = 'Viscosity (cP)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_spec` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` SET TAGS ('dbx_subdomain' = 'formulation_design');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `compatibility_matrix_id` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Matrix ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `active_ingredient_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Component A Active Ingredient Spec Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Component B Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `compatibility_matrix_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `compatibility_matrix_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `compatibility_rating` SET TAGS ('dbx_business_glossary_term' = 'Compatibility Rating');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `compatibility_rating` SET TAGS ('dbx_value_regex' = 'compatible|conditionally_compatible|incompatible');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `pressure_max_bar` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pressure (bar)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `pressure_min_bar` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pressure (bar)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `risk_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Type');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `risk_type` SET TAGS ('dbx_value_regex' = 'exothermic|corrosive|toxic_gas|none');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `test_basis` SET TAGS ('dbx_business_glossary_term' = 'Test Basis');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `test_basis` SET TAGS ('dbx_value_regex' = 'experimental|literature|computational');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`compatibility_matrix` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` SET TAGS ('dbx_subdomain' = 'change_management');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `formula_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Change Request Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Original Component Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `additional_comments` SET TAGS ('dbx_business_glossary_term' = 'Additional Comments');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `approval_decision` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `approval_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|needs_more_info');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `approval_stage` SET TAGS ('dbx_business_glossary_term' = 'Approval Stage');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `approval_stage` SET TAGS ('dbx_value_regex' = 'initial_review|technical_review|regulatory_review|final_approval');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'ingredient_substitution|ratio_adjustment|process_parameter_change|supplier_change');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `digital_signature` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `effective_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Implementation Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `equivalency_assessment` SET TAGS ('dbx_business_glossary_term' = 'Equivalency Assessment');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `formula_change_request_status` SET TAGS ('dbx_business_glossary_term' = 'Change Request Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `formula_change_request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|implemented|closed');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `impacted_formula_versions` SET TAGS ('dbx_business_glossary_term' = 'Impacted Formula Versions');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `regulatory_reregistration_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Re‑registration Required');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Formula Change Request Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `substitution_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Substitution Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `substitution_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `test_data_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Data Reference');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_change_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` SET TAGS ('dbx_subdomain' = 'change_management');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `moc_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Management of Change Approval ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `management_of_change_id` SET TAGS ('dbx_business_glossary_term' = 'Management of Change Request ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `approval_deadline` SET TAGS ('dbx_business_glossary_term' = 'Approval Deadline Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `approval_sequence` SET TAGS ('dbx_business_glossary_term' = 'Approval Sequence Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `approver_role` SET TAGS ('dbx_value_regex' = 'R&D|QA|EHS|Regulatory|Operations');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `condition_notes` SET TAGS ('dbx_business_glossary_term' = 'Conditional Approval Notes');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditionally_approved');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `is_final_approval` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Indicator');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `moc_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Record Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `moc_approval_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `reason_for_rejection` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `related_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Document ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`moc_approval` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` SET TAGS ('dbx_subdomain' = 'change_management');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `scale_up_record_id` SET TAGS ('dbx_business_glossary_term' = 'Scale‑Up Record Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `formulation_process_simulation_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `trial_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Research Trial Batch Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Scale‑Up Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `batch_size_kg` SET TAGS ('dbx_business_glossary_term' = 'Batch Size (kg)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'General Comments');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `deviation_notes` SET TAGS ('dbx_business_glossary_term' = 'Scale‑Up Deviation Notes');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `energy_balance_mj` SET TAGS ('dbx_business_glossary_term' = 'Energy Balance (MJ)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `phase_equilibrium_status` SET TAGS ('dbx_business_glossary_term' = 'Phase Equilibrium Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `phase_equilibrium_status` SET TAGS ('dbx_value_regex' = 'stable|unstable|not_applicable');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `scale_factor` SET TAGS ('dbx_business_glossary_term' = 'Scale Factor');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `scale_up_number` SET TAGS ('dbx_business_glossary_term' = 'Scale‑Up Record Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `scale_up_record_status` SET TAGS ('dbx_business_glossary_term' = 'Scale‑Up Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `scale_up_record_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|in_review');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `scale_up_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scale‑Up Event Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `simulation_conversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Simulated Conversion Rate (%)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `simulation_type` SET TAGS ('dbx_business_glossary_term' = 'Simulation Type');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `simulation_type` SET TAGS ('dbx_value_regex' = 'steady_state|dynamic');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `simulation_yield_prediction_percent` SET TAGS ('dbx_business_glossary_term' = 'Simulated Yield Prediction (%)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `source_formula_version` SET TAGS ('dbx_business_glossary_term' = 'Source Formula Version');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `target_scale` SET TAGS ('dbx_business_glossary_term' = 'Target Scale Level');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `target_scale` SET TAGS ('dbx_value_regex' = 'lab|pilot|commercial');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `validated_against_actual` SET TAGS ('dbx_business_glossary_term' = 'Validated Against Actual Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`scale_up_record` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Observed Yield Percentage');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` SET TAGS ('dbx_subdomain' = 'change_management');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `validation_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Batch Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `formula_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `actual_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Actual Pressure (bar)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `actual_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Actual Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield (%)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BN)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `batch_size_kg` SET TAGS ('dbx_business_glossary_term' = 'Batch Size (kg)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_value_regex' = 'pilot|scale_up|full_production|lab');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `data_capture_system` SET TAGS ('dbx_business_glossary_term' = 'Data Capture System');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `data_capture_system` SET TAGS ('dbx_value_regex' = 'PI|LIMS|MES|HISTORIAN');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `data_capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Capture Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `impurity_ppm` SET TAGS ('dbx_business_glossary_term' = 'Impurity Level (ppm)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `material_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Material Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `material_source` SET TAGS ('dbx_business_glossary_term' = 'Material Source');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Batch Notes');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `pressure_setpoint_bar` SET TAGS ('dbx_business_glossary_term' = 'Pressure Setpoint (bar)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `process_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Process End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `process_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Process Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `quality_issue_description` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Description');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `quality_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|under_review');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield (%)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `temperature_setpoint_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint (°C)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `validation_batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `validation_batch_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Validation Outcome');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`validation_batch` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` SET TAGS ('dbx_subdomain' = 'change_management');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `formula_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Deviation ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `deviation_amount` SET TAGS ('dbx_business_glossary_term' = 'Deviation Amount');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_business_glossary_term' = 'Deviation Category');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_value_regex' = 'chemical|process|quality|safety');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `deviation_number` SET TAGS ('dbx_business_glossary_term' = 'Deviation Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `deviation_type` SET TAGS ('dbx_business_glossary_term' = 'Deviation Type');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `deviation_type` SET TAGS ('dbx_value_regex' = 'ingredient_substitution|ratio_out_of_spec|process_parameter_exceedance|equipment_malfunction|raw_material_variation');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `deviation_unit` SET TAGS ('dbx_business_glossary_term' = 'Deviation Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'use_as_is|rework|reject|scrap|hold');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deviation Event Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `expected_value` SET TAGS ('dbx_business_glossary_term' = 'Expected Value');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `formula_deviation_status` SET TAGS ('dbx_business_glossary_term' = 'Deviation Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `formula_deviation_status` SET TAGS ('dbx_value_regex' = 'open|investigating|closed|rejected|approved');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `magnitude_percent` SET TAGS ('dbx_business_glossary_term' = 'Deviation Magnitude Percent');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `observed_value` SET TAGS ('dbx_business_glossary_term' = 'Observed Value');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `preventive_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Plan');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `qa_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'QA Approval Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Classification');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_value_regex' = 'human_error|equipment_failure|material_issue|method_issue|environmental|unknown');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `root_cause_detail` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Detail');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_deviation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_record_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Record ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet ID (SDS ID)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification (Confidentiality Classification)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'confidential|restricted|internal|public');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (IP Effective From)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (IP Effective Until)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'IP Approval Authority (IP Approval Authority)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_approval_date` SET TAGS ('dbx_business_glossary_term' = 'IP Approval Date (IP Approval Date)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number (Chemical Abstracts Service Number)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_change_rationale` SET TAGS ('dbx_business_glossary_term' = 'IP Change Rationale (IP Change Rationale)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'IP Cost Estimate (IP Cost Estimate)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'IP Creation Timestamp (IP Creation Timestamp)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (Currency Code)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'GHS Classification (GHS Classification)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'IP Last Updated Timestamp (IP Last Updated Timestamp)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_number` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Number (IP Number)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_owner_party_code` SET TAGS ('dbx_business_glossary_term' = 'IP Owner Party ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_owner_type` SET TAGS ('dbx_business_glossary_term' = 'IP Owner Type (IP Owner Type)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_owner_type` SET TAGS ('dbx_value_regex' = 'internal|external|joint');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_record_status` SET TAGS ('dbx_business_glossary_term' = 'IP Lifecycle Status (IP Status)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_record_status` SET TAGS ('dbx_value_regex' = 'draft|pending|active|expired|revoked');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'IP Regulatory Classification (IP Regulatory Classification)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_regulatory_classification` SET TAGS ('dbx_value_regex' = 'GHS|REACH|TSCA|EPA');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'IP Regulatory Status (IP Regulatory Status)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Amount (Royalty Amount)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_royalty_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Frequency (Royalty Payment Frequency)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_royalty_payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent (Royalty Rate Percent)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_royalty_status` SET TAGS ('dbx_business_glossary_term' = 'Royalty Status (Royalty Status)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_royalty_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_type` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property Type (IP Type)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_type` SET TAGS ('dbx_value_regex' = 'patent|trade_secret|know_how|design_right');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_version_number` SET TAGS ('dbx_business_glossary_term' = 'IP Version Number (IP Version Number)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_version_status` SET TAGS ('dbx_business_glossary_term' = 'IP Version Status (IP Version Status)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `ip_version_status` SET TAGS ('dbx_value_regex' = 'current|archived|superseded');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (Country Code)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `license_end_date` SET TAGS ('dbx_business_glossary_term' = 'License End Date (License End Date)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date (License Start Date)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `licensee_name` SET TAGS ('dbx_business_glossary_term' = 'Licensee Name (Licensee Name)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `licensing_restriction` SET TAGS ('dbx_business_glossary_term' = 'Licensing Restriction (Licensing Restriction)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `licensing_restriction` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|none');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `patent_application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Number (PATENT_APP_NO)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `patent_application_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{6,}$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `patent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Expiry Date (PATENT_EXPIRY_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `patent_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Date (PATENT_FILING_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `patent_grant_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Grant Date (PATENT_GRANT_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `patent_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Status (PATENT_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `patent_status` SET TAGS ('dbx_value_regex' = 'pending|granted|rejected|expired|withdrawn');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`ip_record` ALTER COLUMN `trade_secret_description` SET TAGS ('dbx_business_glossary_term' = 'Trade Secret Description (Trade Secret Description)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `formulation_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Regulatory Submission ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `active_ingredient_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Content Percent');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_business_glossary_term' = 'Classification Or Type');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_value_regex' = 'registration|notification|classification|amendment|renewal|other');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'GHS Classification');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `re_submission_required` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `re_submission_trigger` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Trigger');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'echa|epa|fda|osha|other');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `regulatory_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification Code');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `submission_category` SET TAGS ('dbx_business_glossary_term' = 'Submission Category');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `submission_category` SET TAGS ('dbx_value_regex' = 'registration|amendment|renewal|withdrawal|other');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'reach|tsca|epa_pmn|sds|ghs|other');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|lb|ton');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_regulatory_submission` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `formulation_process_simulation_id` SET TAGS ('dbx_business_glossary_term' = 'Process Simulation Identifier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Owner ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield (Percent)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Simulation Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Simulation Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `avg_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Average Pressure (Bar)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `avg_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Average Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `batch_size_kg` SET TAGS ('dbx_business_glossary_term' = 'Batch Size (kg)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `conversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate (Percent)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `cpu_usage_percent` SET TAGS ('dbx_business_glossary_term' = 'CPU Usage (Percent)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Simulation End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `energy_balance_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Balance (MWh)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `formulation_process_simulation_status` SET TAGS ('dbx_business_glossary_term' = 'Simulation Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `formulation_process_simulation_status` SET TAGS ('dbx_value_regex' = 'draft|running|completed|failed|validated');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'GHS Classification');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `input_data_set_reference` SET TAGS ('dbx_business_glossary_term' = 'Input Data Set ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `is_sensitivity_analysis` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Analysis Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `memory_usage_gb` SET TAGS ('dbx_business_glossary_term' = 'Memory Usage (GB)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `model_reference` SET TAGS ('dbx_business_glossary_term' = 'Model Reference');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Simulation Notes');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `output_data_set_reference` SET TAGS ('dbx_business_glossary_term' = 'Output Data Set ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Runtime (Minutes)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `sensitivity_parameters` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Parameters');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `simulation_category` SET TAGS ('dbx_business_glossary_term' = 'Simulation Category');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `simulation_code` SET TAGS ('dbx_business_glossary_term' = 'Simulation Code');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `simulation_software` SET TAGS ('dbx_business_glossary_term' = 'Simulation Software Platform');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `simulation_software` SET TAGS ('dbx_value_regex' = 'Aspen_HYSYS|Aspen_Pro|Other');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `simulation_type` SET TAGS ('dbx_business_glossary_term' = 'Simulation Type');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `simulation_type` SET TAGS ('dbx_value_regex' = 'steady_state|dynamic|scale_up');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Simulation Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield (Percent)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `validated_against_actual` SET TAGS ('dbx_business_glossary_term' = 'Validated Against Actual Flag');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Simulation Version Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formulation_process_simulation` ALTER COLUMN `yield_prediction_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Prediction (Percent)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `formula_stability_test_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Stability Test ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `conclusion_summary` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Conclusion');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `formula_stability_test_status` SET TAGS ('dbx_business_glossary_term' = 'Study Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `formula_stability_test_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `light_exposure` SET TAGS ('dbx_business_glossary_term' = 'Light Exposure Condition');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `light_exposure` SET TAGS ('dbx_value_regex' = 'dark|ambient|uv');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `measurement_appearance` SET TAGS ('dbx_business_glossary_term' = 'Appearance Observation');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `measurement_assay_percent` SET TAGS ('dbx_business_glossary_term' = 'Assay Percentage');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `measurement_ph` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `measurement_viscosity_cp` SET TAGS ('dbx_business_glossary_term' = 'Viscosity (cP)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `protocol_description` SET TAGS ('dbx_business_glossary_term' = 'Study Protocol Description');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'pass|fail|out_of_spec');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `result_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Months)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `storage_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Relative Humidity (%)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Code');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Name');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `test_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Test Interval (Days)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_stability_test` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` SET TAGS ('dbx_subdomain' = 'change_management');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `formula_substitution_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Substitution Identifier (FSI)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `recipe_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Original Component Identifier (OCI)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `affected_formula_version_ids` SET TAGS ('dbx_business_glossary_term' = 'Affected Formula Version IDs (AFVI)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (AD)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number (CCN)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `cost_savings_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Savings Estimate (CSE)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (ED)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `environmental_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Score (EIS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `equivalency_assessment` SET TAGS ('dbx_business_glossary_term' = 'Equivalency Assessment Summary (EAS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `equivalency_score` SET TAGS ('dbx_business_glossary_term' = 'Equivalency Score (ES)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (EXD)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `formula_substitution_status` SET TAGS ('dbx_business_glossary_term' = 'Substitution Status (SS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `formula_substitution_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revoked');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `hazard_classification_change` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification Change (HCC)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `hazard_classification_change` SET TAGS ('dbx_value_regex' = 'none|increase|decrease');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Substitution Rationale (SR)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag (RIF)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `substitution_category` SET TAGS ('dbx_business_glossary_term' = 'Substitution Category (SCAT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `substitution_category` SET TAGS ('dbx_value_regex' = 'cost_reduction|supply_shortage|regulatory|performance|other');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `substitution_code` SET TAGS ('dbx_business_glossary_term' = 'Substitution Code (SC)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `substitution_name` SET TAGS ('dbx_business_glossary_term' = 'Substitution Name (SN)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `test_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Report Identifier (TRI)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `validation_test_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Test Date (VTD)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `validation_test_result` SET TAGS ('dbx_business_glossary_term' = 'Validation Test Result (VTR)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_substitution` ALTER COLUMN `validation_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `mes_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'MES Recipe ID');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `batch_number_prefix` SET TAGS ('dbx_business_glossary_term' = 'Batch Number Prefix (BATCH_NUM_PREFIX)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number (CC_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `control_strategy` SET TAGS ('dbx_business_glossary_term' = 'Control Strategy (CTRL_STRATEGY)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `control_strategy` SET TAGS ('dbx_value_regex' = 'PID|MPC|ON_OFF|Fuzzy|RuleBased');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `equipment_unit` SET TAGS ('dbx_business_glossary_term' = 'Equipment Unit (EQ_UNIT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `equipment_unit` SET TAGS ('dbx_value_regex' = 'reactor|mixer|distillation_column|heat_exchanger|storage_tank');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'GHS Classification (GHS_CLASS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_value_regex' = 'explosive|flammable|corrosive|toxic|environmental_hazard|oxidizer');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `hazardous_ingredient_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Ingredient Flag (HAZ_ING_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `hold_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Hold Time (Minutes) (HOLD_TIME_MIN)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `ingredient_material_code` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Material Code (ING_MAT_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `ingredient_sequence` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Charge Sequence (ING_SEQ)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Current Version Indicator (IS_CURRENT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `is_valid` SET TAGS ('dbx_business_glossary_term' = 'Validity Indicator (IS_VALID)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Synchronization Timestamp (LAST_SYNC_TS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `lot_number_prefix` SET TAGS ('dbx_business_glossary_term' = 'Lot Number Prefix (LOT_NUM_PREFIX)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `mes_recipe_status` SET TAGS ('dbx_business_glossary_term' = 'Recipe Lifecycle Status (R_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `mes_recipe_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated|retired');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `ph_setpoint` SET TAGS ('dbx_business_glossary_term' = 'pH Setpoint (PH_SETPOINT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `ramp_rate_c_per_min` SET TAGS ('dbx_business_glossary_term' = 'Temperature Ramp Rate (°C per minute) (RAMP_RATE_C_PER_MIN)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `recipe_code` SET TAGS ('dbx_business_glossary_term' = 'Recipe Code (RCODE)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Name (RNAME)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `recipe_source` SET TAGS ('dbx_business_glossary_term' = 'Recipe Source Reference (RECIPE_SOURCE)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (REG_APPROVAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|under_review');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `setpoint_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Pressure (Bar) (SETPOINT_PRESS_BAR)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `setpoint_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Temperature (°C) (SETPOINT_TEMP_C)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `sync_status` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Status (SYNC_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `sync_status` SET TAGS ('dbx_value_regex' = 'synced|pending|error|out_of_sync');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `target_batch_size_kg` SET TAGS ('dbx_business_glossary_term' = 'Target Batch Size Kilograms (TARGET_BATCH_SIZE_KG)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage (TARGET_YIELD_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`mes_recipe` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VER_NUM)');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_contract` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_contract` SET TAGS ('dbx_association_edges' = 'customer.account,formulation.formula');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_contract` ALTER COLUMN `formula_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Formulacontract - Contract Id');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Formulacontract - Account Id');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_contract` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formulacontract - Formula Id');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_contract` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_contract` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_waste` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_waste` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_waste` SET TAGS ('dbx_association_edges' = 'formulation.formula,ehs.waste_stream');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_waste` ALTER COLUMN `formula_waste_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Waste - Formula Waste Id');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_waste` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Waste - Formula Id');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_waste` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Waste - Waste Stream Id');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_waste` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Formula‑Specific Disposal Method');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_waste` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Generated Waste Quantity');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`formula_waste` ALTER COLUMN `waste_origin_process` SET TAGS ('dbx_business_glossary_term' = 'Originating Process');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`pricing_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`pricing_assignment` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`pricing_assignment` SET TAGS ('dbx_association_edges' = 'formulation.formula_version,pricing.pricing_strategy');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`pricing_assignment` ALTER COLUMN `pricing_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Assignment - Pricing Assignment Id');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`pricing_assignment` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Assignment - Formula Version Id');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`pricing_assignment` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Assignment - Pricing Strategy Id');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`pricing_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`pricing_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `chemical_mfg_ecm`.`formulation`.`pricing_assignment` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Assignment Rationale');
