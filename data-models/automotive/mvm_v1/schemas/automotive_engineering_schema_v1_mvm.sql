-- Schema for Domain: engineering | Business: Automotive | Version: v1_mvm
-- Generated on: 2026-05-07 02:20:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `automotive_ecm`.`engineering` COMMENT 'Manages the full product design and development lifecycle including CAD (Computer-Aided Design), CAE (Computer-Aided Engineering), PLM (Product Lifecycle Management), and digital twin modeling. Owns engineering BOM, design specifications, CFD (Computational Fluid Dynamics), FEA (Finite Element Analysis), NVH (Noise Vibration Harshness) testing, prototype validation, and engineering change orders (ECO/ECN). Integrates with Siemens Teamcenter, CATIA, and ENOVIA for collaborative engineering.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`vehicle_program` (
    `vehicle_program_id` BIGINT COMMENT 'Primary key for vehicle_program',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Program budgeting uses a Cost Center; finance cost center reports expenses per vehicle program.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Program profitability analysis assigns each vehicle program to a Profit Center for revenue and margin reporting.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Vehicle programs in automotive OEMs are directly managed as finance projects for program P&L, ROI reporting, and capital allocation. Program controllers and finance teams require this join for program',
    `bom_version` STRING COMMENT 'Version identifier of the engineering Bill of Materials.',
    `budget_allocation` DECIMAL(18,2) COMMENT 'Total budget allocated to the program (currency defined by currency_code).',
    `cad_release_version` STRING COMMENT 'Version of the CAD data set released for the program.',
    `cae_release_version` STRING COMMENT 'Version of the CAE simulation package released for the program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vehicle program record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `digital_twin_enabled` BOOLEAN COMMENT 'Indicates whether a digital twin is maintained for the vehicle program.',
    `drivetrain` STRING COMMENT 'Drive configuration of the vehicle.. Valid values are `FWD|RWD|AWD|4WD`',
    `emission_standard` STRING COMMENT 'Regulatory emissions standard the vehicle must meet.. Valid values are `EPA|Euro6|Euro5|CARB|UN/ECE`',
    `end_date` DATE COMMENT 'Target date for End of Production (EOP) of the program.',
    `engineering_change_order_count` STRING COMMENT 'Total number of ECOs/ECNs issued for the program.',
    `launch_date` DATE COMMENT 'Planned calendar date for market launch of the vehicle.',
    `model_year_end` STRING COMMENT 'Last model year covered by the program.',
    `model_year_start` STRING COMMENT 'First model year covered by the program.',
    `notes` STRING COMMENT 'Additional remarks, observations, or comments captured by engineering.',
    `ota_update_capability` BOOLEAN COMMENT 'Indicates whether the vehicle will support Over‑The‑Air software updates.',
    `platform_architecture` STRING COMMENT 'Technical platform on which the vehicle is built (e.g., "Modular Electric Architecture").',
    `powertrain_type` STRING COMMENT 'Primary propulsion technology of the vehicle.. Valid values are `ICE|EV|HEV|PHEV|FCEV`',
    `program_code` STRING COMMENT 'Business identifier used across systems to reference the program (e.g., "P1234").',
    `program_name` STRING COMMENT 'Human‑readable name of the vehicle program (e.g., "All‑New X5").',
    `program_type` STRING COMMENT 'Classification of the program as a nameplate, platform, or concept.. Valid values are `nameplate|platform|concept`',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory approvals for the program.. Valid values are `pending|approved|rejected|under_review`',
    `segment` STRING COMMENT 'Market segment the vehicle belongs to (e.g., SUV, sedan).. Valid values are `sedan|suv|truck|crossover|van|coupe`',
    `start_date` DATE COMMENT 'Target date for Start of Production (SOP) of the program.',
    `target_cost_per_vehicle` DECIMAL(18,2) COMMENT 'Target average manufacturing cost per vehicle (currency defined by currency_code).',
    `target_emissions_g_per_km` DECIMAL(18,2) COMMENT 'Target CO₂ emissions in grams per kilometer.',
    `target_fuel_efficiency_mpg` DECIMAL(18,2) COMMENT 'Target fuel economy in miles per gallon for ICE/HEV variants.',
    `target_market` STRING COMMENT 'Primary geographic market(s) for the vehicle (e.g., "North America").',
    `target_production_volume` STRING COMMENT 'Planned total number of vehicles to be produced for the program.',
    `target_range_km` STRING COMMENT 'Target all‑electric driving range in kilometers for EV variants.',
    `target_weight_kg` DECIMAL(18,2) COMMENT 'Target curb weight of the vehicle in kilograms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vehicle program record.',
    `vehicle_class` STRING COMMENT 'Regulatory vehicle class (e.g., "Passenger", "Light Commercial").',
    `vehicle_program_description` STRING COMMENT 'Free‑form textual description of the program objectives and scope.',
    `vehicle_program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `concept|development|validation|launch|completed|cancelled`',
    CONSTRAINT pk_vehicle_program PRIMARY KEY(`vehicle_program_id`)
) COMMENT 'Master record for a vehicle development program (nameplate/platform program), capturing program code, program name, vehicle segment, platform architecture, SOP (Start of Production) target date, EOP (End of Production) date, MY (Model Year) scope, program phase (concept, development, validation, launch), program director, budget allocation, and program status. Serves as the top-level anchor for all engineering activities within a development cycle. Owned by Siemens Teamcenter PLM.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`bom` (
    `bom_id` BIGINT COMMENT 'Unique surrogate key for the engineering bill of materials record.',
    `apqp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.apqp_plan. Business justification: APQP plans govern product quality planning for specific BOM configurations. Launch readiness assessments, PPAP submissions, and quality gates are BOM-specific. Core APQP-to-product structure linkage.',
    `change_id` BIGINT COMMENT 'Identifier of the engineering change order linked to this BOM revision.',
    `bom_engineering_change_order_change_id` BIGINT COMMENT 'Identifier of the engineering change order linked to this BOM revision.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: BOM cost allocation is performed via a Cost Center; replace plain cost_center attribute with FK for accurate finance reporting.',
    `inbound_part_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_part. Business justification: BOMs specify parts that must be sourced from suppliers. Procurement teams link engineering BOMs to supplier-specific inbound parts for make-vs-buy decisions, sourcing strategies, and cost rollups. Cri',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Needed for BOM‑to‑inventory allocation process, enabling the production scheduling system to reserve SKUs for each BOM.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: An engineering BOM belongs to a specific vehicle program. The bom table currently stores program_name as a denormalized STRING. Adding vehicle_program_id FK normalizes this relationship and allows joi',
    `approval_date` DATE COMMENT 'Date on which the BOM revision was approved.',
    `approved_by` STRING COMMENT 'Name of the person who approved the BOM revision.',
    `bom_code` STRING COMMENT 'Business identifier that uniquely identifies the BOM within a program.',
    `bom_description` STRING COMMENT 'Free‑text description of the BOM purpose and scope.',
    `bom_name` STRING COMMENT 'Human‑readable name of the engineering BOM.',
    `bom_type` STRING COMMENT 'Classification of the BOM: engineering (eBOM), manufacturing (mBOM), or service (sBOM).. Valid values are `eBOM|mBOM|sBOM`',
    `change_reason` STRING COMMENT 'Reason documented for the latest BOM revision.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard to which the BOM complies.. Valid values are `ISO26262|IATF16949|SAEJ3061`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the BOM record was first created.',
    `effective_end_date` DATE COMMENT 'Date when the BOM expires or is superseded (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the BOM becomes effective for production.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the BOM is locked for further changes.',
    `last_review_date` DATE COMMENT 'Date of the most recent engineering review of the BOM.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle status of the BOM record.. Valid values are `active|inactive|pending|retired`',
    `model_year` STRING COMMENT 'Model year of the vehicle for which the BOM is defined.',
    `owner_department` STRING COMMENT 'Engineering department responsible for the BOM.',
    `plant_location` STRING COMMENT 'Identifier of the manufacturing plant where the BOM will be used.',
    `release_status` STRING COMMENT 'Current release state of the BOM.. Valid values are `draft|released|archived|obsolete`',
    `revision_number` STRING COMMENT 'Revision identifier of the BOM (e.g., A, B, C).',
    `source_system` STRING COMMENT 'PLM system where the BOM originates.. Valid values are `Teamcenter|ENOVIA|CATIA`',
    `total_parts_count` STRING COMMENT 'Number of distinct part numbers referenced in the BOM.',
    `total_quantity` STRING COMMENT 'Sum of all component quantities across the BOM.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the BOM record.',
    `vehicle_variant` STRING COMMENT 'Identifier for the specific vehicle variant (e.g., Sport, Luxury).',
    `version_number` STRING COMMENT 'Internal version counter for the BOM record.',
    CONSTRAINT pk_bom PRIMARY KEY(`bom_id`)
) COMMENT 'Engineering Bill of Materials (eBOM) header record representing the complete structured parts list for a vehicle program or variant at a specific revision level. Captures BOM type (eBOM, mBOM, sBOM), program reference, model year, configuration context, effectivity dates, release status, BOM owner, and PLM system source. The eBOM is the authoritative design-intent parts structure managed in Siemens Teamcenter and ENOVIA before handoff to manufacturing BOM.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`bom_line` (
    `bom_line_id` BIGINT COMMENT 'Unique identifier for the engineering_bom_line data product (auto-inserted pre-linking).',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_bom. Business justification: A line item belongs to a single engineering BOM; adding engineering_bom_id creates the required parent link.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Parent assembly reference is a part_master; replace with descriptive FK to part_master.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Each BOM line item maps to a specific procurable SKU for MRP explosion and procurement planning. Automotive MRP runs require line-level SKU references to generate purchase requisitions and stock requi',
    CONSTRAINT pk_bom_line PRIMARY KEY(`bom_line_id`)
) COMMENT 'Individual line item within an engineering BOM, representing a single part-to-parent relationship in the BOM hierarchy. Captures parent assembly reference, child part number, find number, quantity, unit of measure, effectivity start/end dates, variant applicability, substitution flags, BOM level, and engineering change reference. Supports multi-level BOM explosion and where-used analysis. Sourced from Siemens Teamcenter BOM Management.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`part_master` (
    `part_master_id` BIGINT COMMENT 'Primary key for part_master',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Part cost accounting charges material cost to a Cost Center; finance tracks part expenses per cost center.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Parts must be linked to applicable regulatory requirements for compliance tracking during part engineering.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Supplier Management Process: engineering part master must be linked to the external supplier record for PPAP, cost, and lead‑time tracking.',
    `cad_model_reference` STRING COMMENT 'Path or identifier of the CAD 3D model stored in the PLM system.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Standard cost of the part in US dollars as defined in the ERP system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the part master record was first created in the system.',
    `criticality` STRING COMMENT 'Criticality of the part to vehicle safety or performance.. Valid values are `low|medium|high|critical`',
    `drawing_number` STRING COMMENT 'Reference to the engineering drawing document for the part.',
    `effective_date` DATE COMMENT 'Date when the current part version became effective.',
    `eol_reason` STRING COMMENT 'Reason for part end‑of‑life (e.g., technology superseded, supplier discontinued).',
    `expiration_date` DATE COMMENT 'Date when the part is scheduled to be retired or become obsolete, if applicable.',
    `height_mm` DECIMAL(18,2) COMMENT 'Physical height of the part in millimetres.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.. Valid values are `passed|failed|rework|pending`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the part is currently active for use in new designs.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent quality inspection of the part.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the part master record.',
    `lead_time_days` STRING COMMENT 'Average supplier lead time in days for this part.',
    `length_mm` DECIMAL(18,2) COMMENT 'Physical length of the part in millimetres.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the part within PLM.. Valid values are `in_work|released|obsoleted|pending_release|discontinued`',
    `material` STRING COMMENT 'Primary material composition of the part (e.g., steel, aluminum, plastic).',
    `obsolescence_notice` BOOLEAN COMMENT 'True if an official obsolescence notice has been issued for the part.',
    `part_classification` STRING COMMENT 'High‑level functional classification of the part.. Valid values are `mechanical|electrical|hydraulic|software|electronic|structural`',
    `part_description` STRING COMMENT 'Detailed description of the parts function, features, and application.',
    `part_family` STRING COMMENT 'Logical grouping of related parts sharing common characteristics.',
    `part_number` STRING COMMENT 'Unique part number assigned by the organization, used to identify the part across systems.',
    `part_type` STRING COMMENT 'Classification of the part by its role in the product structure.. Valid values are `raw|processed|assembly|subassembly|component`',
    `quality_rating` STRING COMMENT 'Quality rating based on internal quality metrics (e.g., PPAP status).. Valid values are `A|B|C|D|E|F`',
    `reach_compliance` BOOLEAN COMMENT 'Indicates whether the part complies with REACH chemical regulations (True=Compliant).',
    `revision_level` STRING COMMENT 'Current revision identifier of the part. [ENUM-REF-CANDIDATE: A|B|C|D|E|F|G|H|I|J — 10 candidates stripped; promote to reference product]',
    `rohs_compliance` BOOLEAN COMMENT 'Indicates whether the part complies with RoHS restrictions (True=Compliant).',
    `supplier_part_number` STRING COMMENT 'Part number used by the supplier for this component.',
    `version_number` STRING COMMENT 'Numeric version of the part master record for internal version control.',
    `volume_cm3` DECIMAL(18,2) COMMENT 'Calculated volume of the part in cubic centimetres.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the part in kilograms.',
    `width_mm` DECIMAL(18,2) COMMENT 'Physical width of the part in millimetres.',
    CONSTRAINT pk_part_master PRIMARY KEY(`part_master_id`)
) COMMENT 'Engineering part master record representing a unique part or component managed within the PLM system. Captures part number, part name, part classification, material type, weight, dimensions, drawing number, CAD model reference, lifecycle state (in-work, released, obsolete), revision level, owning engineer, supplier part number, REACH/RoHS compliance flag, and part family. Authoritative source for engineering part identity in Siemens Teamcenter / PTC Windchill.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`design_specification` (
    `design_specification_id` BIGINT COMMENT 'System-generated unique identifier for the design specification record.',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Design specifications are created or revised in response to engineering change orders (ECO/ECN). The design_specification table has `change_order_number` STRING — a denormalized reference to the chang',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.material_specification. Business justification: Design specifications reference approved material specifications for the components they define. The design_specification table has `material_specification` as a STRING field — a denormalized referenc',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Design specifications define technical requirements for specific parts or components. The design_specification table has `component_name` as a denormalized STRING. Adding part_master_id FK links the s',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory Requirement Mapping required for design approval; each design spec must reference the regulatory requirement it satisfies.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Design specifications are authored for a specific vehicle program. The design_specification table has a `program` STRING field that is a denormalized reference to the vehicle program. Adding vehicle_p',
    `approval_date` DATE COMMENT 'Date the specification was approved.',
    `approval_status` STRING COMMENT 'Current approval state of the specification.. Valid values are `approved|rejected|pending`',
    `approver` STRING COMMENT 'Name of the person who approved the specification.',
    `author` STRING COMMENT 'Name of the engineer or team that authored the specification.',
    `change_order_date` DATE COMMENT 'Date the change order was issued.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the specification.. Valid values are `compliant|non_compliant|pending`',
    `confidentiality_level` STRING COMMENT 'Internal classification indicating data sensitivity.. Valid values are `internal|confidential|restricted`',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated cost to implement the specification, in US dollars.',
    `design_phase` STRING COMMENT 'Current phase of the design lifecycle.. Valid values are `concept|development|validation|production`',
    `design_specification_description` STRING COMMENT 'Detailed narrative describing the design intent and scope.',
    `dimensions_mm` STRING COMMENT 'Physical dimensions expressed as LxWxH in millimetres.',
    `document_status` STRING COMMENT 'Current lifecycle state of the specification document.. Valid values are `draft|in_review|approved|released|archived`',
    `effective_date` DATE COMMENT 'Date the specification becomes effective for design work.',
    `engineering_department` STRING COMMENT 'Department responsible for the specification (e.g., Powertrain, Chassis).',
    `expiration_date` DATE COMMENT 'Date after which the specification is no longer valid.',
    `interface_name` STRING COMMENT 'Interface name when the spec defines an interaction point between components.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the specification is currently active.',
    `lifecycle_stage` STRING COMMENT 'Stage of the product lifecycle where the spec is applied.. Valid values are `prototype|pre_production|production|post_production`',
    `obsolescence_date` DATE COMMENT 'Planned date when the specification will be retired.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `regulatory_reference` STRING COMMENT 'Regulatory standards referenced (e.g., FMVSS 123, UNECE R123).',
    `release_date` DATE COMMENT 'Date the specification was released for use.',
    `revision_date` DATE COMMENT 'Date the current revision was released.',
    `revision_number` STRING COMMENT 'Alphanumeric revision identifier (e.g., A, B, C).',
    `spec_number` STRING COMMENT 'Business identifier assigned to the specification, e.g., DS-2023-001.',
    `spec_type` STRING COMMENT 'Classification of the specification scope.. Valid values are `system|subsystem|component|interface`',
    `subsystem_name` STRING COMMENT 'Name of the subsystem within the system, if applicable.',
    `system_name` STRING COMMENT 'Name of the vehicle system covered (e.g., Powertrain, Chassis).',
    `target_performance_units` STRING COMMENT 'Units for the target performance value (e.g., Nm, kW).',
    `target_performance_value` DECIMAL(18,2) COMMENT 'Numeric target performance metric (e.g., torque, efficiency).',
    `test_method` STRING COMMENT 'Primary analysis or test method used to validate the spec.. Valid values are `CFD|FEA|NVH|Simulation|Physical_Test`',
    `test_result_summary` STRING COMMENT 'High‑level summary of test outcomes.',
    `title` STRING COMMENT 'Human‑readable title describing the purpose of the specification.',
    `updated_by` STRING COMMENT 'User identifier who last updated the record.',
    `version_number` STRING COMMENT 'Version string for the specification (e.g., 1.0, 2.1).',
    `weight_kg` DECIMAL(18,2) COMMENT 'Target weight of the component or system in kilograms.',
    `created_by` STRING COMMENT 'User identifier who created the record.',
    CONSTRAINT pk_design_specification PRIMARY KEY(`design_specification_id`)
) COMMENT 'Engineering design specification document record capturing the technical requirements and design intent for a vehicle system, subsystem, or component. Includes specification number, title, specification type (system, subsystem, component, interface), applicable program, revision history, author, approval status, linked requirements, target performance values, and regulatory references (FMVSS, UNECE, NCAP). Managed in Teamcenter or ENOVIA document management.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`change` (
    `change_id` BIGINT COMMENT 'System-generated unique identifier for the engineering change record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Engineering changes affecting emission or safety-relevant parts must be assessed against specific regulations. The change product has compliance_flag confirming regulatory relevance. Change impact ana',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Engineering change orders (ECO/ECN) are raised within the context of a vehicle program. The change table has `affected_programs` as a STRING (potentially multi-value), but a primary vehicle_program_id',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Engineering Change Orders (ECOs) in automotive manufacturing are charged to WBS elements for R&D and capital project cost tracking. change.cost_estimate_gross and cost_net must be posted against a WBS',
    `affected_parts` STRING COMMENT 'Comma‑separated list of part numbers (e.g., VIN, SKU) impacted by the change.',
    `affected_programs` STRING COMMENT 'Comma‑separated list of vehicle programs impacted by the change.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the change was formally approved.',
    `change_description` STRING COMMENT 'Detailed narrative explaining the purpose and scope of the change.',
    `change_number` STRING COMMENT 'Business identifier assigned to the change request (e.g., EC2023001234).',
    `change_scope` STRING COMMENT 'Scope of the change affecting a part, assembly, specification, or process.. Valid values are `part|assembly|specification|process`',
    `change_status` STRING COMMENT 'Current lifecycle status of the engineering change.. Valid values are `draft|under_review|approved|implemented|rejected`',
    `change_type` STRING COMMENT 'Classification of the change request: Engineering Change Request (ECR), Engineering Change Order (ECO), or Engineering Change Notice (ECN).. Valid values are `ECR|ECO|ECN`',
    `closure_date` DATE COMMENT 'Date when the change record was closed after implementation verification.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the change is driven by regulatory or standards compliance.',
    `cost_adjustments` DECIMAL(18,2) COMMENT 'Estimated cost adjustments (e.g., tooling, re‑work) associated with the change.',
    `cost_estimate_gross` DECIMAL(18,2) COMMENT 'Initial estimated total cost of the change before any adjustments.',
    `cost_net` DECIMAL(18,2) COMMENT 'Final net cost after applying adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the engineering change record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost estimates.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `effective_date` DATE COMMENT 'Date on which the change becomes effective in production or documentation.',
    `impact_analysis` STRING COMMENT 'Summary of technical and cost impact analysis performed for the change.',
    `implementation_date` DATE COMMENT 'Target calendar date for implementing the approved change on the product.',
    `origin` STRING COMMENT 'Source of the change request: internal, supplier, or customer.. Valid values are `internal|supplier|customer`',
    `priority` STRING COMMENT 'Business priority assigned to the change (high, medium, low).. Valid values are `high|medium|low`',
    `reason_category` STRING COMMENT 'High‑level category describing why the change is initiated.. Valid values are `cost_reduction|quality|regulatory|customer_request|other`',
    `reason_detail` STRING COMMENT 'Free‑form text providing additional context for the change reason.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the change request was initially submitted.',
    `revision_number` STRING COMMENT 'Revision identifier for the engineering change document.',
    `risk_assessment` STRING COMMENT 'Detailed risk assessment narrative for the change.',
    `risk_level` STRING COMMENT 'Assessed risk level of the change to product quality, schedule, or cost.. Valid values are `low|medium|high|critical`',
    `title` STRING COMMENT 'Short descriptive title of the engineering change.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the engineering change record.',
    `version` STRING COMMENT 'Version number of the change record, incremented on each revision.',
    CONSTRAINT pk_change PRIMARY KEY(`change_id`)
) COMMENT 'Engineering Change Order/Notice (ECO/ECN) record capturing a formal request to modify a part, assembly, design specification, or BOM. Includes change number, change type (ECR/ECO/ECN), title, reason for change (cost reduction, quality, regulatory, customer request), affected parts list, affected programs, initiator, approver chain, priority, implementation date, cost impact estimate, and change status (draft, under review, approved, implemented, rejected). Managed in Siemens Teamcenter Change Management.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`validation_test` (
    `validation_test_id` BIGINT COMMENT 'Unique identifier for the validation test record.',
    `control_plan_id` BIGINT COMMENT 'Foreign key linking to quality.control_plan. Business justification: Control plans specify inspection methods and acceptance criteria that validation tests execute. Test protocols implement control plan requirements for production readiness verification per APQP Phase ',
    `dvp_plan_id` BIGINT COMMENT 'Foreign key linking to engineering.dvp_plan. Business justification: Validation tests are executed as part of a Design Verification Plan (DVP). The DVP plan defines what tests must be run; validation_test captures the actual test execution event. This parent-child rela',
    `fmea_id` BIGINT COMMENT 'Foreign key linking to quality.fmea. Business justification: Validation tests verify FMEA-identified failure modes and risks. Test results validate FMEA severity/occurrence ratings and drive corrective actions. Critical DVP-FMEA linkage in automotive quality pr',
    `fmea_record_id` BIGINT COMMENT 'Foreign key linking to engineering.fmea_record. Business justification: Validation tests are often designed to verify that failure modes identified in FMEA records are adequately controlled. Linking validation_test to fmea_record creates traceability between risk analysis',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Validation tests are executed as evidence to fulfill compliance obligations. The obligation defines the certification target; the validation test provides the evidence submitted to regulatory bodies. ',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Validation tests are performed on specific parts, assemblies, or prototypes. Linking validation_test to part_master identifies which part is under test, enabling part-level test history and traceabili',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Validation tests are designed to demonstrate compliance with specific regulations (FMVSS, UNECE, EPA). DVP traceability requires linking each test to the regulation it validates. Domain experts expect',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Validation tests in automotive are performed on production-representative parts tracked as specific SKUs with lot/batch numbers. Linking validation_test to sku_master provides lot traceability for PPA',
    `supplier_part_approval_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_part_approval. Business justification: Validation tests verify supplier-provided parts meet engineering specifications. PPAP (Production Part Approval Process) requires linking test results to supplier approvals for quality gate decisions ',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Validation tests are performed as part of a vehicle programs development and verification activities. Linking validation_test to vehicle_program enables program-level test coverage reporting and trac',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Individual validation tests incur lab fees, equipment costs, and engineer time charged to WBS elements in automotive R&D accounting. Finance controllers require this link to reconcile actual test spen',
    `approval_date` DATE COMMENT 'Date when the test was formally approved.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the test.',
    `comments` STRING COMMENT 'Free‑form comments or observations recorded by the test engineer.',
    `compliance_standard` STRING COMMENT 'Specific regulatory standard evaluated by the test.. Valid values are `FMVSS|EPA|NCAP|WLTP`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test record was created in the system.',
    `data_source_system` STRING COMMENT 'Originating system that captured the test data (e.g., Teamcenter, MES).',
    `disposition` STRING COMMENT 'Disposition decision based on test result.. Valid values are `accept|rework|reject`',
    `emission_co2_g_per_km` DECIMAL(18,2) COMMENT 'Measured carbon dioxide emission per kilometer.',
    `equipment_used` STRING COMMENT 'List of major equipment or rigs employed during the test.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the test is classified as critical for safety or compliance.',
    `noise_db` DECIMAL(18,2) COMMENT 'Measured acoustic noise level in decibels.',
    `regulatory_compliance_flag` STRING COMMENT 'Overall compliance status of the test against applicable regulations.. Valid values are `compliant|non_compliant|exempt`',
    `target_emission_co2` DECIMAL(18,2) COMMENT 'Regulatory or design target for CO2 emission.',
    `target_noise_db` DECIMAL(18,2) COMMENT 'Target acoustic noise level for compliance.',
    `target_torque_nm` DECIMAL(18,2) COMMENT 'Target torque specification for the test.',
    `test_approval_status` STRING COMMENT 'Approval state after review of test results.. Valid values are `approved|rejected|pending`',
    `test_batch_number` STRING COMMENT 'Batch identifier linking the test to a production or prototype batch.',
    `test_category` STRING COMMENT 'High‑level engineering domain of the test.. Valid values are `structural|powertrain|electronics|software`',
    `test_document_reference` STRING COMMENT 'Reference to supporting documentation (e.g., test plan PDF).',
    `test_duration_minutes` STRING COMMENT 'Total elapsed time of the test execution in minutes.',
    `test_engineer` STRING COMMENT 'Name of the engineer responsible for conducting the test.',
    `test_facility` STRING COMMENT 'Name of the facility or lab where the test was performed.',
    `test_location` STRING COMMENT 'Code identifying the physical location or plant where the test took place.',
    `test_name` STRING COMMENT 'Descriptive name of the validation test.',
    `test_phase` STRING COMMENT 'Development phase during which the test was performed.. Valid values are `prototype|pre_production|production`',
    `test_report_url` STRING COMMENT 'Web address or path to the stored test report.',
    `test_result` STRING COMMENT 'Outcome of the test execution.. Valid values are `pass|fail|conditional`',
    `test_result_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result was entered into the system.',
    `test_revision_number` STRING COMMENT 'Revision number of the test procedure or setup.',
    `test_standard_reference` STRING COMMENT 'Reference code or document identifier for the standard governing the test.',
    `test_status` STRING COMMENT 'Current lifecycle status of the test.. Valid values are `planned|in_progress|completed|cancelled`',
    `test_timestamp` TIMESTAMP COMMENT 'Date and time when the test was executed.',
    `test_type` STRING COMMENT 'Category of the validation test according to engineering verification plans.. Valid values are `DVP|PVP|PPAP|Durability|Emissions|NCAP`',
    `test_version` STRING COMMENT 'Version identifier for the test procedure.',
    `torque_nm` DECIMAL(18,2) COMMENT 'Measured torque value in newton‑meters.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test record.',
    `variance_percent` DECIMAL(18,2) COMMENT 'Percentage variance between measured and target values.',
    CONSTRAINT pk_validation_test PRIMARY KEY(`validation_test_id`)
) COMMENT 'Engineering validation test record capturing a physical or virtual test event performed on a prototype or production-intent part/vehicle. Includes test ID, test type (DVP — Design Verification Plan, PVP — Process Validation Plan, PPAP, durability, emissions, NCAP/WLTP, FMVSS), test name, test standard reference, test facility, test date, test engineer, test result (pass/fail/conditional), measured values vs. targets, and disposition. Supports DVP&R (Design Verification Plan and Report) tracking.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`engineering_test_result` (
    `engineering_test_result_id` BIGINT COMMENT 'Unique identifier for the engineering_test_result data product (auto-inserted pre-linking).',
    `validation_test_id` BIGINT COMMENT 'Foreign key linking to engineering.validation_test. Business justification: Test results belong to a validation test; linking enables traceability.',
    CONSTRAINT pk_engineering_test_result PRIMARY KEY(`engineering_test_result_id`)
) COMMENT 'Detailed test result record capturing individual measurement data points from a validation test event. Includes result ID, parent test reference, measurement parameter name, unit of measure, measured value, target value, tolerance band (min/max), pass/fail status, test condition description, channel or sensor ID, timestamp of measurement, and data file reference. Enables granular traceability of test outcomes against engineering targets and regulatory thresholds.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Unique identifier for the engineering milestone record.',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Engineering program milestones (gate reviews) are often triggered by or associated with engineering change orders. A milestone may be created to review and approve a significant change, or a change ma',
    `dvp_plan_id` BIGINT COMMENT 'Foreign key linking to engineering.dvp_plan. Business justification: Engineering milestones (gate reviews such as DV, PV, SOP) are directly tied to DVP plan completion status. A milestone gate review evaluates whether the DVP plan has been sufficiently completed. Linki',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Program milestones (regulatory submission gate, SOP, homologation approval gate) are directly tied to compliance obligations with deadlines. Program managers track milestone completion against obligat',
    `vehicle_program_id` BIGINT COMMENT 'Identifier of the engineering program to which this milestone belongs.',
    `actual_date` DATE COMMENT 'Actual calendar date when the milestone was achieved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone was approved during gate review.',
    `change_reason` STRING COMMENT 'Reason provided for any change to milestone dates or status.',
    `compliance_standard` STRING COMMENT 'Applicable compliance standard(s) for the milestone (e.g., ISO 26262, IATF 16949).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was created.',
    `gate_review_outcome` STRING COMMENT 'Result of the gate review for the milestone.. Valid values are `approved|conditional|deferred|rejected`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the milestone is deemed critical for program success.',
    `milestone_code` STRING COMMENT 'Short code representing the milestone phase.. Valid values are `P0|P1|P2|P3|SOP`',
    `milestone_description` STRING COMMENT 'Detailed description of the milestone purpose, scope, and deliverables.',
    `milestone_name` STRING COMMENT 'Descriptive name of the milestone (e.g., P0 Concept Freeze, P1 Design Freeze).',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone.. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `milestone_type` STRING COMMENT 'Category of the milestone within the product development process.. Valid values are `gate|review|release|prototype|pilot`',
    `open_action_items_count` STRING COMMENT 'Number of unresolved action items after the gate review.',
    `planned_date` DATE COMMENT 'Planned calendar date for milestone completion.',
    `plant_location` STRING COMMENT 'Manufacturing plant or site associated with the milestone.',
    `risk_level` STRING COMMENT 'Risk classification assigned to the milestone.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the milestone record.',
    `version_number` STRING COMMENT 'Version number of the milestone record for change tracking.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Engineering program milestone record capturing key gate reviews and decision points in the vehicle development process. Includes milestone ID, milestone name (P0 concept freeze, P1 design freeze, P2 prototype release, P3 pilot build, SOP), program reference, planned date, actual date, milestone owner, gate review outcome (approved, conditional, deferred), open action items count, and sign-off authority. Supports APQP (Advanced Product Quality Planning) phase gate management.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`fmea_record` (
    `fmea_record_id` BIGINT COMMENT 'System-generated unique identifier for the FMEA record.',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: FMEA records analyze the risks associated with specific design specifications. Linking fmea_record to design_specification creates traceability between the design intent (spec) and the risk analysis (',
    `dvp_plan_id` BIGINT COMMENT 'Foreign key linking to engineering.dvp_plan. Business justification: FMEA records feed directly into DVP plans — identified failure modes and recommended actions drive the test cases in the DVP. Linking fmea_record to dvp_plan enables traceability from risk identificat',
    `part_master_id` BIGINT COMMENT 'Reference to the part (or component) that the FMEA analyzes.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: FMEA records for safety-critical parts reference regulatory requirements defining acceptable risk thresholds (FMVSS, ISO 26262 ASIL). Regulatory bodies require FMEA evidence during homologation. Domai',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: FMEA records are conducted for specific vehicle programs. Linking fmea_record to vehicle_program enables program-level risk reporting and ensures FMEA coverage can be tracked per program. This is a st',
    `actual_completion_date` DATE COMMENT 'Date when the recommended action was actually completed.',
    `analysis_team` STRING COMMENT 'Name or identifier of the cross‑functional team that performed the FMEA.',
    `approval_date` DATE COMMENT 'Date when the FMEA record received formal approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the FMEA record was first created in the system.',
    `current_controls` STRING COMMENT 'Existing controls or safeguards that address the failure mode.',
    `detection_rating` STRING COMMENT 'Detection score (1‑10) representing the ability of current controls to detect the failure before it reaches the customer.',
    `document_url` STRING COMMENT 'Link to the detailed FMEA PDF or digital twin document stored in the repository.',
    `effective_end_date` DATE COMMENT 'Date when the FMEA analysis is retired or superseded (nullable).',
    `effective_start_date` DATE COMMENT 'Date from which the FMEA analysis is considered active.',
    `failure_effect` STRING COMMENT 'Potential effect on the vehicle or process if the failure mode occurs.',
    `failure_mode` STRING COMMENT 'Textual description of the way the part or process could fail.',
    `fmea_number` STRING COMMENT 'Business identifier assigned to the FMEA record, often used in reports and traceability.',
    `fmea_record_status` STRING COMMENT 'Current lifecycle status of the FMEA record.. Valid values are `open|in_progress|closed|rejected`',
    `fmea_type` STRING COMMENT 'Indicates whether the analysis is a Design FMEA (DFMEA) or Process FMEA (PFMEA).. Valid values are `DFMEA|PFMEA`',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the FMEA.',
    `occurrence_rating` STRING COMMENT 'Occurrence score (1‑10) indicating how likely the failure mode is to happen.',
    `process_code` BIGINT COMMENT 'Reference to the manufacturing process step when the FMEA is a PFMEA.',
    `recommended_action` STRING COMMENT 'Proposed corrective or preventive action to reduce risk.',
    `revision_number` STRING COMMENT 'Sequential revision number of the FMEA record.',
    `risk_category` STRING COMMENT 'High‑level risk classification derived from the RPN.. Valid values are `high|medium|low`',
    `rpn` STRING COMMENT 'Calculated risk priority number (S × O × D) used to prioritize mitigation actions.',
    `severity_rating` STRING COMMENT 'Severity score (1‑10) reflecting the seriousness of the failure effect.',
    `source_system` STRING COMMENT 'Name of the source application (e.g., Teamcenter, ENOVIA) that originated the record.',
    `target_completion_date` DATE COMMENT 'Planned date by which the recommended action should be completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the FMEA record.',
    `version` STRING COMMENT 'Alphanumeric version label (e.g., v1.0, v2.1) for the FMEA record.',
    CONSTRAINT pk_fmea_record PRIMARY KEY(`fmea_record_id`)
) COMMENT 'FMEA (Failure Mode and Effects Analysis) record capturing the systematic risk analysis of a design or process. Includes FMEA ID, FMEA type (DFMEA — Design FMEA, PFMEA — Process FMEA), associated part or process, failure mode description, potential effect of failure, severity rating, potential cause, occurrence rating, current controls, detection rating, RPN (Risk Priority Number), recommended actions, responsible engineer, and completion date. Managed per IATF 16949 and AIAG-VDA FMEA methodology.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`dvp_plan` (
    `dvp_plan_id` BIGINT COMMENT 'System-generated unique identifier for the Design Verification Plan.',
    `change_id` BIGINT COMMENT 'Identifier of the engineering change order that triggered the plan.',
    `control_plan_id` BIGINT COMMENT 'Foreign key linking to quality.control_plan. Business justification: DVP plans validate control plan effectiveness before production launch. Control plan verification is a DVP deliverable per APQP Phase 3. Test plans prove process capability defined in control plans.',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: A Design Verification Plan (DVP) is created to validate that a design specifications requirements are met. Linking dvp_plan to design_specification establishes the traceability from test plan to the ',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: DVP plans are created to fulfill compliance obligations — the obligation defines what must be certified; the DVP plan defines how it will be tested. Homologation program management requires tracing DV',
    `part_master_id` BIGINT COMMENT 'Identifier of the part or component covered by the DVP.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: DVP plans are structured around regulatory requirements — each test phase maps to specific regulations (FMVSS, WLTP, UNECE). The dvp_plan has regulatory_approval_required confirming this dependency. R',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: DVP (Design Verification Plan) execution requires procurement of specific test parts from inventory. Linking dvp_plan to sku_master enables test readiness planning — program managers verify that requi',
    `vehicle_program_id` BIGINT COMMENT 'Identifier of the vehicle program to which the plan belongs.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: DVP (Design Verification Plan) test programs are funded through WBS elements under R&D projects in automotive OEMs. dvp_plan.cost_estimate_usd must be tracked against a WBS element for program cost co',
    `actual_completion_date` DATE COMMENT 'Date when the last test in the plan was completed.',
    `approval_date` DATE COMMENT 'Date on which the plan received final approval.',
    `approval_status` STRING COMMENT 'Current approval state of the verification plan.. Valid values are `draft|pending|approved|rejected|withdrawn`',
    `completed_test_count` STRING COMMENT 'Number of test cases that have been completed.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of tests completed (0‑100).',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated cost to execute the verification plan, expressed in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan record was created.',
    `document_url` STRING COMMENT 'Web link or repository path to the full DVP document.',
    `dvp_plan_status` STRING COMMENT 'Current operational status of the verification plan.. Valid values are `active|inactive|archived|cancelled`',
    `effective_end_date` DATE COMMENT 'Date when the plan is retired or superseded (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the plan becomes active for execution.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the test procedures are automated.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the plan is locked from further edits.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the plan.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent change to the plan status.',
    `model_year` STRING COMMENT 'Model year of the vehicle variant the plan applies to.',
    `notes` STRING COMMENT 'Additional remarks or comments about the verification plan.',
    `plan_code` STRING COMMENT 'Business-visible alphanumeric code used to reference the DVP plan.',
    `plan_description` STRING COMMENT 'Detailed narrative describing the scope and objectives of the plan.',
    `plan_title` STRING COMMENT 'Descriptive title of the verification plan.',
    `plan_type` STRING COMMENT 'Category of the plan indicating the level of the product it validates.. Valid values are `system|component|subsystem|vehicle|process`',
    `planned_completion_date` DATE COMMENT 'Target date for completing all tests in the plan.',
    `priority` STRING COMMENT 'Business priority assigned to the plan.. Valid values are `low|medium|high|critical`',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether regulatory sign‑off is required for the plan.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory approval for the plan.. Valid values are `not_required|pending|approved|rejected`',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the verification plan.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Originating system that created the record (e.g., Siemens Teamcenter PLM).',
    `system_code` BIGINT COMMENT 'Identifier of the vehicle system (e.g., powertrain, ADAS) the plan validates.',
    `test_environment` STRING COMMENT 'Physical or virtual environment where testing occurs.. Valid values are `lab|test_track|simulation|field`',
    `test_phase` STRING COMMENT 'Lifecycle phase during which the tests are performed.. Valid values are `development|prototype|pre-production|production|post-production`',
    `test_type` STRING COMMENT 'Primary classification of the tests in the plan.. Valid values are `functional|performance|durability|safety|regulatory|environmental`',
    `total_test_count` STRING COMMENT 'Total number of test cases defined in the plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plan record.',
    `vehicle_variant` STRING COMMENT 'Specific vehicle variant or trim level associated with the plan.',
    `version_number` STRING COMMENT 'Semantic version identifier for the plan (e.g., 1.0, 2.1).',
    CONSTRAINT pk_dvp_plan PRIMARY KEY(`dvp_plan_id`)
) COMMENT 'Design Verification Plan (DVP) record defining the complete test plan for validating a vehicle system or component against its design specifications. Captures DVP ID, plan title, associated part or system, program reference, total test count, completion percentage, responsible engineer, approval status, linked specification, and planned vs. actual completion dates. Acts as the master test planning document that governs all validation_test records for a given scope.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`homologation_requirement` (
    `homologation_requirement_id` BIGINT COMMENT 'Unique surrogate key for the homologation requirement record.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to quality.audit. Business justification: Regulatory audits verify compliance with homologation requirements for vehicle certification. Audit scope and findings directly tied to regulatory mandates for market approval and type approval proces',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Homologation requirements drive specific design specifications — regulatory standards mandate design constraints that must be captured in design specs. Linking homologation_requirement to design_speci',
    `homologation_record_id` BIGINT COMMENT 'Foreign key linking to compliance.homologation_record. Business justification: Homologation requirement must reference the homologation record that documents market approval for that requirement.',
    `vehicle_program_id` BIGINT COMMENT 'Identifier of the vehicle program to which this requirement belongs.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Homologation requirements reference specific regulations. The homologation_requirement has regulation_name and regulation_number as denormalized plain-text fields that should be replaced by a proper F',
    `supplier_part_approval_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_part_approval. Business justification: Homologation (type approval) requires tracking which supplier parts meet regulatory standards. Certification audits and market-specific compliance reporting need to verify that approved supplier parts',
    `compliance_method` STRING COMMENT 'How compliance is demonstrated: test, calculation, or declaration.. Valid values are `test|calculation|declaration`',
    `compliance_status` STRING COMMENT 'Current status of the requirements compliance lifecycle.. Valid values are `pending|in_progress|compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the homologation requirement record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the requirement becomes legally effective.',
    `expiration_date` DATE COMMENT 'Date when the requirement is no longer applicable, if applicable.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the requirement is mandatory (true) or optional (false).',
    `last_review_date` DATE COMMENT 'Date when the requirement was last reviewed for relevance or changes.',
    `market_region` STRING COMMENT 'Three‑letter ISO country/region code where the requirement applies. [ENUM-REF-CANDIDATE: USA|CAN|MEX|DEU|JPN|CHN|AUS|GBR — 8 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free‑form comments or observations about the requirement.',
    `priority_level` STRING COMMENT 'Business priority assigned to the requirement for planning purposes.. Valid values are `high|medium|low`',
    `requirement_code` STRING COMMENT 'Business identifier assigned to the requirement by the engineering organization.',
    `requirement_description` STRING COMMENT 'Full textual description of what the regulation mandates.',
    `source_system` STRING COMMENT 'Originating system of record (e.g., SAP, Teamcenter, ENOVIA).',
    `submission_deadline` DATE COMMENT 'Latest date by which evidence of compliance must be submitted.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the requirement record.',
    `vehicle_model_year` STRING COMMENT 'Model year of the vehicle to which the requirement is tied.',
    `vehicle_variant` STRING COMMENT 'Specific variant or trim level of the vehicle (e.g., sport, hybrid).',
    CONSTRAINT pk_homologation_requirement PRIMARY KEY(`homologation_requirement_id`)
) COMMENT 'Homologation and regulatory requirement record capturing the specific regulatory standards and type-approval requirements that a vehicle or component must satisfy for a target market. Includes requirement ID, regulation name (FMVSS, ECE-R, CARB, Euro NCAP, WLTP, EPA), regulation number, market/region applicability, requirement description, compliance method (test, calculation, declaration), linked validation tests, compliance status, and submission deadline. Supports regulatory compliance and homologation engineering activities.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`ecu_specification` (
    `ecu_specification_id` BIGINT COMMENT 'Primary key for ecu_specification',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: ECU specifications are a specialized form of design specification for electronic control units. Linking ecu_specification to design_specification creates traceability between the ECU-specific technica',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: ECU specifications require specialized inspection plans for software validation, hardware testing, and functional safety verification. Critical safety components demand defined inspection protocols pe',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: An ECU specification defines the hardware and software for a specific ECU, which is a physical part managed in the PLM system. Linking ecu_specification to part_master connects the spec to the physica',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: ECU specs must comply with functional safety (ISO 26262), cybersecurity (UN R155), and emission regulations. The ecu_specification has regulatory_approval_status and compliance_standard confirming reg',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Each ECU specification corresponds to a procurable inventory SKU. Linking ecu_specification to sku_master enables inventory planners to manage ECU stock levels aligned with engineering specs and suppo',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: ECU sourcing workflow requires each ECU spec to reference the approved supplier for compliance and warranty management.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: ECU specifications are developed for specific vehicle programs. The ecu_specification table has `vehicle_platform` STRING and `applicable_vehicle_variants` STRING as denormalized references, but vehic',
    `applicable_model_years` STRING COMMENT 'Model year range for which the ECU specification is valid (e.g., 2023‑2025).',
    `applicable_vehicle_variants` STRING COMMENT 'Vehicle variants or trims that use this ECU.',
    `asw_release_date` DATE COMMENT 'Date of the ASW release.',
    `asw_release_number` STRING COMMENT 'Identifier for the automotive software (ASW) release.',
    `calibration_dataset_reference` STRING COMMENT 'Reference identifier for the calibration data set used by the ECU.',
    `communication_protocol` STRING COMMENT 'Primary vehicle network protocol used by the ECU.. Valid values are `CAN|LIN|Ethernet|FlexRay|MOST|CANFD`',
    `compliance_standard` STRING COMMENT 'Regulatory or quality standard applicable to the ECU.. Valid values are `ISO_26262|IATF_16949|ISO_9001`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ECU specification record was created.',
    `diagnostic_trouble_code_support` STRING COMMENT 'List or description of DTCs supported by the ECU.',
    `dimensions_mm` STRING COMMENT 'Physical dimensions (L×W×H) in millimetres.',
    `ecu_family` STRING COMMENT 'Higher‑level family grouping for related ECUs.',
    `ecu_specification_description` STRING COMMENT 'Free‑form description of the ECU functionality and purpose.',
    `ecu_specification_name` STRING COMMENT 'Human‑readable name of the electronic control unit.',
    `ecu_specification_status` STRING COMMENT 'Current lifecycle state of the ECU specification.. Valid values are `active|inactive|deprecated|retired|development|released`',
    `ecu_type` STRING COMMENT 'Classification of the ECU function (e.g., engine control, ADAS).. Valid values are `engine_control|transmission|adas|body_control|battery_management|infotainment`',
    `effective_end_date` DATE COMMENT 'Date when the ECU specification is retired or superseded.',
    `effective_start_date` DATE COMMENT 'Date when the ECU specification becomes effective.',
    `eol_date` DATE COMMENT 'Planned date when the ECU will be discontinued.',
    `functional_safety_asil` STRING COMMENT 'Automotive Safety Integrity Level per ISO 26262.. Valid values are `ASIL_A|ASIL_B|ASIL_C|ASIL_D`',
    `hardware_revision` STRING COMMENT 'Revision identifier for the ECU hardware.',
    `hardware_version` STRING COMMENT 'Version identifier of the ECU hardware revision.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the ECU is safety‑critical.',
    `max_operating_temperature_c` STRING COMMENT 'Maximum ambient temperature at which the ECU can operate safely.',
    `memory_size_mb` STRING COMMENT 'On‑board memory capacity in megabytes.',
    `min_operating_temperature_c` STRING COMMENT 'Minimum ambient temperature at which the ECU can operate safely.',
    `power_consumption_w` DECIMAL(18,2) COMMENT 'Typical power consumption in watts.',
    `processing_speed_mhz` STRING COMMENT 'CPU processing speed in megahertz.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval for the ECU (e.g., NHTSA, EPA).. Valid values are `approved|pending|rejected`',
    `release_status` STRING COMMENT 'Current release state of the ECU specification.. Valid values are `draft|released|archived|obsolete`',
    `software_release_notes` STRING COMMENT 'Free‑form notes describing changes in the software release.',
    `software_version` STRING COMMENT 'Version identifier of the ECU software (e.g., v1.2.3).',
    `supported_features` STRING COMMENT 'Comma‑separated list of functional features provided by the ECU.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ECU specification.',
    `vehicle_platform` STRING COMMENT 'Vehicle platform or architecture that the ECU supports (e.g., MQB, e‑CM).',
    `voltage_range_v` STRING COMMENT 'Operating voltage range expressed as min‑max volts.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Physical weight of the ECU unit.',
    CONSTRAINT pk_ecu_specification PRIMARY KEY(`ecu_specification_id`)
) COMMENT 'ECU (Electronic Control Unit) software and hardware specification record capturing the technical definition of an automotive electronic control module. Includes ECU ID, ECU name, ECU type (engine control, transmission, ADAS, body control, battery management), hardware part number, software version, calibration dataset reference, communication protocol (CAN, LIN, Ethernet, FlexRay), functional safety level (ASIL rating per ISO 26262), supplier reference, and release status. Critical for EV, HEV, and ADAS program engineering.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`powertrain_spec` (
    `powertrain_spec_id` BIGINT COMMENT 'Unique surrogate identifier for the powertrain specification record.',
    `apqp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.apqp_plan. Business justification: Powertrain development follows APQP methodology with specific quality gates for emissions, performance, and durability. Launch readiness tied to powertrain validation milestones and PPAP approval.',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Powertrain specifications are a specialized form of design specification for ICE, HEV, PHEV, or BEV powertrains. Linking powertrain_spec to design_specification creates traceability between the powert',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: A powertrain specification defines the technical characteristics of a powertrain assembly, which is a physical part/assembly managed in the PLM system. Linking powertrain_spec to part_master connects ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Powertrain specs are directly constrained by emission regulations (EPA, CARB, Euro 6/7). The powertrain_spec has emissions_standard and compliance_status confirming regulatory dependency. Engineers mu',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Powertrain specifications are defined per vehicle program; linking enables program-level aggregation and reporting.',
    `approval_date` DATE COMMENT 'Date when the specification received formal approval.',
    `approved_by` STRING COMMENT 'Name of the authority who approved the specification.',
    `architecture_type` STRING COMMENT 'Physical layout of the engine (inline, V, boxer, etc.).',
    `aspiration_type` STRING COMMENT 'Method of air induction for the engine.. Valid values are `naturally_aspirated|turbocharged|supercharged`',
    `battery_capacity_kwh` DECIMAL(18,2) COMMENT 'Energy storage capacity for electrified powertrains; null for ICE/HEV.',
    `compliance_status` STRING COMMENT 'Overall regulatory compliance state of the specification.. Valid values are `compliant|non_compliant|pending`',
    `cost_currency` STRING COMMENT 'Currency code for the cost estimate.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated manufacturing cost for the powertrain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification record was created.',
    `cylinder_count` STRING COMMENT 'Number of cylinders for internal combustion engines.',
    `dimensions_mm` STRING COMMENT 'Physical envelope of the powertrain expressed as LxWxH in millimetres.',
    `displacement_cc` STRING COMMENT 'Engine cylinder displacement for internal combustion variants.',
    `effective_end_date` DATE COMMENT 'Date after which the specification is no longer effective.',
    `effective_start_date` DATE COMMENT 'Date from which the specification is considered effective.',
    `emission_control_technology` STRING COMMENT 'Technology used to reduce exhaust emissions (e.g., catalytic converter, DPF, SCR).',
    `emissions_standard` STRING COMMENT 'Regulatory emissions standard the powertrain meets.. Valid values are `Euro6|EPA_Tier3|CARB_LEVIII|WLTP`',
    `end_of_production_date` DATE COMMENT 'Date when the powertrain ceased production.',
    `epa_range_miles` STRING COMMENT 'Estimated driving range under EPA test cycle.',
    `fuel_type` STRING COMMENT 'Primary fuel or energy source for the powertrain.. Valid values are `gasoline|diesel|electric|hydrogen|hybrid`',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the specification is locked from further edits.',
    `last_review_date` DATE COMMENT 'Date of the most recent engineering review.',
    `model_year` STRING COMMENT 'Model year the specification applies to.',
    `notes` STRING COMMENT 'Free‑form comments or engineering notes.',
    `power_output_kw` DECIMAL(18,2) COMMENT 'Peak power rating of the powertrain.',
    `powertrain_spec_status` STRING COMMENT 'Current lifecycle status of the specification.. Valid values are `draft|active|retired|obsolete`',
    `powertrain_type` STRING COMMENT 'Classification of the powertrain technology.. Valid values are `ICE|HEV|PHEV|BEV|FCEV`',
    `source_system` STRING COMMENT 'Originating system of record (e.g., Teamcenter, CATIA).',
    `spec_code` STRING COMMENT 'Business identifier code used to reference the specification across systems.',
    `spec_name` STRING COMMENT 'Human‑readable name of the powertrain specification.',
    `start_of_production_date` DATE COMMENT 'Date when the powertrain entered series production.',
    `target_program_code` STRING COMMENT 'Program identifier for which this specification is intended.',
    `thermal_management` STRING COMMENT 'Cooling/heating strategy used for the powertrain.. Valid values are `air|liquid|phase_change|heat_pump`',
    `torque_nm` DECIMAL(18,2) COMMENT 'Peak torque rating of the powertrain.',
    `transmission_type` STRING COMMENT 'Transmission architecture used with the powertrain.. Valid values are `manual|automatic|dual_clutch|CVT|e-gear`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the specification.',
    `vehicle_variant` STRING COMMENT 'Specific vehicle variant (e.g., trim level) the spec supports.',
    `version_number` STRING COMMENT 'Version identifier for the specification revision.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Mass of the powertrain assembly.',
    `wltp_range_km` STRING COMMENT 'Estimated driving range under WLTP test cycle.',
    CONSTRAINT pk_powertrain_spec PRIMARY KEY(`powertrain_spec_id`)
) COMMENT 'Powertrain engineering specification record capturing the technical definition of an ICE, HEV, PHEV, or EV powertrain system. Includes spec ID, powertrain type (ICE, HEV, PHEV, BEV, FCEV), engine or motor displacement/power rating, torque output, transmission type, battery capacity (kWh) for electrified variants, fuel type, emissions standard compliance (Euro 6, EPA Tier 3, CARB LEV III), WLTP/EPA range rating, thermal management approach, and target program applicability. Supports R&D and powertrain engineering teams.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`material_specification` (
    `material_specification_id` BIGINT COMMENT 'Unique surrogate key for the material specification record.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Material specifications describe a part; linking to part_master removes redundant part identifiers.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Material specs must comply with REACH, RoHS, and ELV regulations. The material_specification has compliance_reach and compliance_rohs attributes confirming regulatory dependency. Substance compliance ',
    `applicable_standard` STRING COMMENT 'Reference to external standards governing the material (e.g., SAE, ASTM, DIN).',
    `application_restriction` STRING COMMENT 'Business rules limiting where the material may be used (e.g., high‑temperature zones).',
    `approved_supplier` STRING COMMENT 'Comma‑separated list of suppliers approved to provide this material.',
    `compliance_reach` STRING COMMENT 'Regulatory status of the material under EU REACH.. Valid values are `compliant|non_compliant|pending`',
    `compliance_rohs` STRING COMMENT 'Regulatory status of the material under RoHS directives.. Valid values are `compliant|non_compliant|pending`',
    `cost_per_kg_usd` DECIMAL(18,2) COMMENT 'Current purchase cost of the material per kilogram in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification record was first created.',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT 'Mass per unit volume of the material.',
    `effective_end_date` DATE COMMENT 'Date after which the specification is no longer valid (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which the specification is valid.',
    `elongation_percent` DECIMAL(18,2) COMMENT 'Percent increase in length at fracture, indicating ductility.',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Numeric score representing the materials environmental footprint.',
    `grade_or_alloy` STRING COMMENT 'Specific grade or alloy designation (e.g., 6061‑T6, 304L).',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the material is critical for safety or performance.',
    `last_review_date` DATE COMMENT 'Date when the specification was last reviewed for relevance or compliance.',
    `lead_time_days` STRING COMMENT 'Typical supplier lead time for the material, in calendar days.',
    `lifecycle_status` STRING COMMENT 'Lifecycle phase of the material specification.. Valid values are `in_design|approved|in_use|retired|archived`',
    `material_class` STRING COMMENT 'High‑level classification of the material type.. Valid values are `steel|aluminum|polymer|composite|glass`',
    `material_specification_name` STRING COMMENT 'Human‑readable name of the material specification.',
    `material_specification_status` STRING COMMENT 'Current operational status of the specification.. Valid values are `active|inactive|deprecated|pending`',
    `material_specification_type` STRING COMMENT 'Primary functional category of the material.. Valid values are `structural|electrical|thermal|decorative`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the material specification.',
    `safety_rating` STRING COMMENT 'Safety classification of the material according to internal or regulatory criteria.. Valid values are `A|B|C|D|E`',
    `specific_heat_j_per_kgk` DECIMAL(18,2) COMMENT 'Energy required to raise the temperature of 1 kg of material by 1 K.',
    `surface_treatment` STRING COMMENT 'Required surface finishing process for the material.. Valid values are `none|coating|plating|anodizing|galvanizing`',
    `tensile_strength_mpa` DECIMAL(18,2) COMMENT 'Maximum stress the material can withstand while being stretched before breaking.',
    `thermal_conductivity_w_per_mk` DECIMAL(18,2) COMMENT 'Rate at which heat passes through the material.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the specification.',
    `version_number` STRING COMMENT 'Incremental version of the specification for change tracking.',
    `warranty_period_months` STRING COMMENT 'Manufacturer warranty period applicable to the material.',
    `yield_strength_mpa` DECIMAL(18,2) COMMENT 'Stress at which material begins to deform plastically.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_material_specification PRIMARY KEY(`material_specification_id`)
) COMMENT 'Engineering material specification record defining the approved materials for use in vehicle components. Captures spec ID, material name, material class (steel, aluminum, polymer, composite, glass), grade or alloy designation, mechanical properties (tensile strength, yield strength, elongation), thermal properties, density, surface treatment requirements, applicable standards (SAE, ASTM, DIN), REACH/RoHS compliance status, approved supplier list, and application restrictions. Supports part design and supplier qualification.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`document` (
    `document_id` BIGINT COMMENT 'Unique surrogate key for the engineering document record.',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Engineering documents are created, revised, or released in response to engineering change orders. Linking engineering_document to change creates document-to-change traceability, enabling change impact',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Engineering documents serve as the metadata catalog for controlled engineering documents, including design specifications. Linking engineering_document to design_specification connects the document ma',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Engineering documents (drawings, CAD files, test reports) are associated with specific parts in the PLM system. Linking engineering_document to part_master connects controlled documents to the parts t',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Engineering documents are associated with a vehicle program; linking provides program context.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the document was approved.',
    `approved_by` STRING COMMENT 'Name of the person who approved the document for release.',
    `author` STRING COMMENT 'Name of the engineer or author who created the document.',
    `compliance_standard` STRING COMMENT 'Applicable compliance standard(s) the document satisfies (e.g., ISO 26262, IATF 16949).',
    `confidentiality_level` STRING COMMENT 'Classification of the documents sensitivity.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the document record was first created in the system.',
    `document_number` STRING COMMENT 'Business identifier assigned to the document (e.g., drawing number, specification code).',
    `document_type` STRING COMMENT 'Category of the engineering document. [ENUM-REF-CANDIDATE: drawing|specification|test_report|analysis_report|fmea|dvp|meeting_minutes — promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date after which the document content is no longer valid (if applicable).',
    `effective_start_date` DATE COMMENT 'Date from which the document content is considered valid.',
    `engineering_document_status` STRING COMMENT 'Current lifecycle state of the document.. Valid values are `draft|released|archived|obsolete`',
    `file_path` STRING COMMENT 'Logical path or URI to the document file in the repository.',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes.',
    `format` STRING COMMENT 'File format of the stored document.. Valid values are `pdf|dwg|docx|xlsx|xml`',
    `is_digital_twin_ready` BOOLEAN COMMENT 'Indicates whether the document is linked to a digital twin model.',
    `release_date` DATE COMMENT 'Effective date when the document became officially released.',
    `retention_policy` STRING COMMENT 'Policy governing how long the document must be retained.. Valid values are `keep_5_years|keep_10_years|permanent`',
    `revision` STRING COMMENT 'Revision identifier indicating the version of the document (e.g., A, B, C, 1.0, 2.1).',
    `title` STRING COMMENT 'Human‑readable title of the engineering document.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the document record.',
    CONSTRAINT pk_document PRIMARY KEY(`document_id`)
) COMMENT 'Engineering document record serving as the metadata catalog for all controlled engineering documents managed in the PLM system. Includes document ID, document number, title, document type (drawing, specification, test report, analysis report, FMEA, DVP, meeting minutes), revision level, author, approval status, release date, associated program and part references, document format, storage location reference, and retention policy. Supports document control per IATF 16949 and ISO 9001 requirements.';

CREATE OR REPLACE TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` (
    `test_requirement_compliance_id` BIGINT COMMENT 'Primary key for the test_requirement_compliance association',
    `homologation_requirement_id` BIGINT COMMENT 'Foreign key linking to the homologation requirement being satisfied',
    `validation_test_id` BIGINT COMMENT 'Foreign key linking to the validation test that provides compliance evidence',
    `approval_date` DATE COMMENT 'Date when the regulatory authority approved this compliance evidence',
    `approved_by_authority` STRING COMMENT 'Name of the regulatory authority or certification body that approved this compliance mapping (e.g., TÜV SÜD, NHTSA, CARB)',
    `compliance_notes` STRING COMMENT 'Free-form notes documenting how the test satisfies the requirement, any deviations, or conditional approval terms',
    `compliance_status` STRING COMMENT 'Current compliance status of this test-requirement mapping in the approval lifecycle',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance mapping record was created in the system',
    `evidence_document_url` STRING COMMENT 'Link to the formal compliance evidence document or test report submitted to authorities',
    `mapped_by_engineer` STRING COMMENT 'Name of the homologation or validation engineer who created this compliance mapping',
    `mapping_date` DATE COMMENT 'Date when this test-to-requirement mapping was formally established',
    `submission_date` DATE COMMENT 'Date when this compliance evidence was submitted to the regulatory authority',
    `submission_reference` STRING COMMENT 'Reference number or identifier for the regulatory submission package containing this compliance evidence',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compliance mapping record',
    CONSTRAINT pk_test_requirement_compliance PRIMARY KEY(`test_requirement_compliance_id`)
) COMMENT 'This association product represents the compliance evidence mapping between validation tests and homologation requirements in the type-approval process. It captures the formal traceability required by regulatory authorities (TÜV, NHTSA, JAMA) documenting which test results satisfy which regulatory requirements. Each record links one validation test execution to one homologation requirement with compliance status, submission tracking, and regulatory approval metadata that exist only in the context of this compliance relationship.. Existence Justification: In automotive homologation, validation tests and regulatory requirements have a genuine many-to-many operational relationship. A single validation test (e.g., a crash test) can provide compliance evidence for multiple regulatory requirements across different markets (FMVSS 208, Euro NCAP frontal impact, China C-NCAP). Conversely, a single regulatory requirement (e.g., CO2 emissions limit) must be satisfied by multiple test protocols (WLTP, EPA FTP-75, CARB LEV III). Type approval authorities require explicit documentation of these mappings with submission tracking and approval status.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_bom_engineering_change_order_change_id` FOREIGN KEY (`bom_engineering_change_order_change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`bom_line` ADD CONSTRAINT `fk_engineering_bom_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `automotive_ecm`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`bom_line` ADD CONSTRAINT `fk_engineering_bom_line_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ADD CONSTRAINT `fk_engineering_design_specification_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ADD CONSTRAINT `fk_engineering_design_specification_material_specification_id` FOREIGN KEY (`material_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`material_specification`(`material_specification_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ADD CONSTRAINT `fk_engineering_design_specification_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ADD CONSTRAINT `fk_engineering_design_specification_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`change` ADD CONSTRAINT `fk_engineering_change_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_dvp_plan_id` FOREIGN KEY (`dvp_plan_id`) REFERENCES `automotive_ecm`.`engineering`.`dvp_plan`(`dvp_plan_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `automotive_ecm`.`engineering`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`engineering_test_result` ADD CONSTRAINT `fk_engineering_engineering_test_result_validation_test_id` FOREIGN KEY (`validation_test_id`) REFERENCES `automotive_ecm`.`engineering`.`validation_test`(`validation_test_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ADD CONSTRAINT `fk_engineering_milestone_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ADD CONSTRAINT `fk_engineering_milestone_dvp_plan_id` FOREIGN KEY (`dvp_plan_id`) REFERENCES `automotive_ecm`.`engineering`.`dvp_plan`(`dvp_plan_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ADD CONSTRAINT `fk_engineering_milestone_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_dvp_plan_id` FOREIGN KEY (`dvp_plan_id`) REFERENCES `automotive_ecm`.`engineering`.`dvp_plan`(`dvp_plan_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ADD CONSTRAINT `fk_engineering_dvp_plan_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ADD CONSTRAINT `fk_engineering_dvp_plan_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ADD CONSTRAINT `fk_engineering_dvp_plan_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ADD CONSTRAINT `fk_engineering_dvp_plan_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ADD CONSTRAINT `fk_engineering_homologation_requirement_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ADD CONSTRAINT `fk_engineering_homologation_requirement_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ADD CONSTRAINT `fk_engineering_ecu_specification_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ADD CONSTRAINT `fk_engineering_ecu_specification_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ADD CONSTRAINT `fk_engineering_ecu_specification_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ADD CONSTRAINT `fk_engineering_powertrain_spec_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ADD CONSTRAINT `fk_engineering_powertrain_spec_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ADD CONSTRAINT `fk_engineering_powertrain_spec_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ADD CONSTRAINT `fk_engineering_material_specification_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`document` ADD CONSTRAINT `fk_engineering_document_change_id` FOREIGN KEY (`change_id`) REFERENCES `automotive_ecm`.`engineering`.`change`(`change_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`document` ADD CONSTRAINT `fk_engineering_document_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `automotive_ecm`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`document` ADD CONSTRAINT `fk_engineering_document_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `automotive_ecm`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`document` ADD CONSTRAINT `fk_engineering_document_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `automotive_ecm`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ADD CONSTRAINT `fk_engineering_test_requirement_compliance_homologation_requirement_id` FOREIGN KEY (`homologation_requirement_id`) REFERENCES `automotive_ecm`.`engineering`.`homologation_requirement`(`homologation_requirement_id`);
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ADD CONSTRAINT `fk_engineering_test_requirement_compliance_validation_test_id` FOREIGN KEY (`validation_test_id`) REFERENCES `automotive_ecm`.`engineering`.`validation_test`(`validation_test_id`);

-- ========= TAGS =========
ALTER SCHEMA `automotive_ecm`.`engineering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `automotive_ecm`.`engineering` SET TAGS ('dbx_domain' = 'engineering');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` SET TAGS ('dbx_subdomain' = 'product_development');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Identifier');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `bom_version` SET TAGS ('dbx_business_glossary_term' = 'BOM Version');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Allocation');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `cad_release_version` SET TAGS ('dbx_business_glossary_term' = 'CAD Release Version');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `cae_release_version` SET TAGS ('dbx_business_glossary_term' = 'CAE Release Version');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `digital_twin_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Twin Enabled Flag');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `drivetrain` SET TAGS ('dbx_business_glossary_term' = 'Drivetrain Configuration');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `drivetrain` SET TAGS ('dbx_value_regex' = 'FWD|RWD|AWD|4WD');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `emission_standard` SET TAGS ('dbx_business_glossary_term' = 'Emission Standard');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `emission_standard` SET TAGS ('dbx_value_regex' = 'EPA|Euro6|Euro5|CARB|UN/ECE');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End of Production Target Date');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `engineering_change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order Count');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Program Launch Date');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `model_year_end` SET TAGS ('dbx_business_glossary_term' = 'Model Year End');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `model_year_start` SET TAGS ('dbx_business_glossary_term' = 'Model Year Start');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `ota_update_capability` SET TAGS ('dbx_business_glossary_term' = 'OTA Update Capability Flag');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `platform_architecture` SET TAGS ('dbx_business_glossary_term' = 'Platform Architecture');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Type');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_value_regex' = 'ICE|EV|HEV|PHEV|FCEV');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Code');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Name');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Type');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'nameplate|platform|concept');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Segment');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'sedan|suv|truck|crossover|van|coupe');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start of Production Target Date');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `target_cost_per_vehicle` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Vehicle');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `target_cost_per_vehicle` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `target_emissions_g_per_km` SET TAGS ('dbx_business_glossary_term' = 'Target Emissions (g/km)');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `target_fuel_efficiency_mpg` SET TAGS ('dbx_business_glossary_term' = 'Target Fuel Efficiency (MPG)');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market Region');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `target_production_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Production Volume');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `target_range_km` SET TAGS ('dbx_business_glossary_term' = 'Target Electric Range (km)');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `target_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Target Vehicle Weight (kg)');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `vehicle_class` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `vehicle_program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `vehicle_program_status` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Status');
ALTER TABLE `automotive_ecm`.`engineering`.`vehicle_program` ALTER COLUMN `vehicle_program_status` SET TAGS ('dbx_value_regex' = 'concept|development|validation|launch|completed|cancelled');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` SET TAGS ('dbx_subdomain' = 'product_development');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering BOM ID');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Apqp Plan Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order ID');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `bom_engineering_change_order_change_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order ID');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `inbound_part_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Part Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `bom_code` SET TAGS ('dbx_business_glossary_term' = 'Engineering BOM Code');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `bom_description` SET TAGS ('dbx_business_glossary_term' = 'BOM Description');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `bom_name` SET TAGS ('dbx_business_glossary_term' = 'Engineering BOM Name');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'BOM Type');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'eBOM|mBOM|sBOM');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'ISO26262|IATF16949|SAEJ3061');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Is Locked');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `plant_location` SET TAGS ('dbx_business_glossary_term' = 'Plant Location');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'draft|released|archived|obsolete');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Teamcenter|ENOVIA|CATIA');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `total_parts_count` SET TAGS ('dbx_business_glossary_term' = 'Total Parts Count');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `vehicle_variant` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Variant Identifier');
ALTER TABLE `automotive_ecm`.`engineering`.`bom` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `automotive_ecm`.`engineering`.`bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`engineering`.`bom_line` SET TAGS ('dbx_subdomain' = 'product_development');
ALTER TABLE `automotive_ecm`.`engineering`.`bom_line` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for engineering_bom_line');
ALTER TABLE `automotive_ecm`.`engineering`.`bom_line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Bom Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`bom_line` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Assembly Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`bom_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` SET TAGS ('dbx_subdomain' = 'product_development');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Identifier');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `cad_model_reference` SET TAGS ('dbx_business_glossary_term' = 'CAD Model Reference');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost (USD)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `criticality` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `criticality` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Drawing Number (DRW)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `eol_reason` SET TAGS ('dbx_business_glossary_term' = 'End‑of‑Life Reason');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `height_mm` SET TAGS ('dbx_business_glossary_term' = 'Height (mm)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|rework|pending');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `length_mm` SET TAGS ('dbx_business_glossary_term' = 'Length (mm)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LCS)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_work|released|obsoleted|pending_release|discontinued');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `material` SET TAGS ('dbx_business_glossary_term' = 'Material (MAT)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `obsolescence_notice` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Notice Flag');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `part_classification` SET TAGS ('dbx_business_glossary_term' = 'Part Classification');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `part_classification` SET TAGS ('dbx_value_regex' = 'mechanical|electrical|hydraulic|software|electronic|structural');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `part_description` SET TAGS ('dbx_business_glossary_term' = 'Part Description');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `part_family` SET TAGS ('dbx_business_glossary_term' = 'Part Family');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number (PN)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `part_type` SET TAGS ('dbx_business_glossary_term' = 'Part Type (PT)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `part_type` SET TAGS ('dbx_value_regex' = 'raw|processed|assembly|subassembly|component');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `quality_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `reach_compliance` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliance Flag');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'Revision Level (REV)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `rohs_compliance` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Flag');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `supplier_part_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Number');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `volume_cm3` SET TAGS ('dbx_business_glossary_term' = 'Volume (cm³)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `automotive_ecm`.`engineering`.`part_master` ALTER COLUMN `width_mm` SET TAGS ('dbx_business_glossary_term' = 'Width (mm)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` SET TAGS ('dbx_subdomain' = 'product_development');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Identifier (DSID)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (Approval Date)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (Approval Status)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `approver` SET TAGS ('dbx_business_glossary_term' = 'Approver Name (Approver)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `author` SET TAGS ('dbx_business_glossary_term' = 'Author Name (Author)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `change_order_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Date (CO Date)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Compliance)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (Conf Level)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'internal|confidential|restricted');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD) (Cost Est)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `design_phase` SET TAGS ('dbx_business_glossary_term' = 'Design Phase (Phase)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `design_phase` SET TAGS ('dbx_value_regex' = 'concept|development|validation|production');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `design_specification_description` SET TAGS ('dbx_business_glossary_term' = 'Specification Description (Description)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `dimensions_mm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions (mm) (Dimensions)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Lifecycle Status (Doc Status)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|released|archived');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (Effective Date)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `engineering_department` SET TAGS ('dbx_business_glossary_term' = 'Engineering Department (Dept)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (Expiration Date)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `interface_name` SET TAGS ('dbx_business_glossary_term' = 'Interface Name (Interface)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag (Active)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage (Lifecycle)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'prototype|pre_production|production|post_production');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `obsolescence_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Date (Obsolescence Date)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created At)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Updated At)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Codes (Reg Ref)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date (Release Date)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date (Rev Date)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number (Rev No.)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `spec_number` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Number (DSN)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `spec_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type (Spec Type)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `spec_type` SET TAGS ('dbx_value_regex' = 'system|subsystem|component|interface');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `subsystem_name` SET TAGS ('dbx_business_glossary_term' = 'Subsystem Name (Subsystem)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'System Name (System)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `target_performance_units` SET TAGS ('dbx_business_glossary_term' = 'Target Performance Units (Units)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `target_performance_value` SET TAGS ('dbx_business_glossary_term' = 'Target Performance Value (Target Perf)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method (Test Method)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `test_method` SET TAGS ('dbx_value_regex' = 'CFD|FEA|NVH|Simulation|Physical_Test');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `test_result_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Result Summary (Test Summary)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Specification Title (Title)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (Updated By)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (Version)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg) (Weight)');
ALTER TABLE `automotive_ecm`.`engineering`.`design_specification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (Created By)');
ALTER TABLE `automotive_ecm`.`engineering`.`change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`engineering`.`change` SET TAGS ('dbx_subdomain' = 'product_development');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change ID');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `affected_parts` SET TAGS ('dbx_business_glossary_term' = 'Affected Parts');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `affected_programs` SET TAGS ('dbx_business_glossary_term' = 'Affected Programs');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `change_scope` SET TAGS ('dbx_business_glossary_term' = 'Change Scope');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `change_scope` SET TAGS ('dbx_value_regex' = 'part|assembly|specification|process');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Status');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `change_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|implemented|rejected');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Type');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'ECR|ECO|ECN');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Change Closure Date');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `cost_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Cost Adjustments');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `cost_adjustments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `cost_adjustments` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `cost_estimate_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Cost Estimate');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `cost_estimate_gross` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `cost_estimate_gross` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `cost_net` SET TAGS ('dbx_business_glossary_term' = 'Net Cost Estimate');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `cost_net` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `cost_net` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `impact_analysis` SET TAGS ('dbx_business_glossary_term' = 'Impact Analysis');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Implementation Date');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Change Origin');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `origin` SET TAGS ('dbx_value_regex' = 'internal|supplier|customer');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Priority');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `reason_category` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Category');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `reason_category` SET TAGS ('dbx_value_regex' = 'cost_reduction|quality|regulatory|customer_request|other');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `reason_detail` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Detail');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Change Request Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Change Revision Number');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Change Title');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`change` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Change Version');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` SET TAGS ('dbx_subdomain' = 'quality_validation');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `validation_test_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Test ID');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `dvp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Dvp Plan Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `fmea_id` SET TAGS ('dbx_business_glossary_term' = 'Fmea Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fmea Record Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `supplier_part_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Approval Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (AD)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (AB)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `approved_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Test Comments (TC)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard (CS)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'FMVSS|EPA|NCAP|WLTP');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System for Test Data (SS)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Test Disposition (TD)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'accept|rework|reject');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `emission_co2_g_per_km` SET TAGS ('dbx_business_glossary_term' = 'Measured CO2 Emission (g/km) (MCO2)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `equipment_used` SET TAGS ('dbx_business_glossary_term' = 'Equipment Used (EU)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Test Flag (CTF)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `noise_db` SET TAGS ('dbx_business_glossary_term' = 'Measured Noise Level (dB) (MNL)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (RCF)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `target_emission_co2` SET TAGS ('dbx_business_glossary_term' = 'Target CO2 Emission (g/km) (TCO2)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `target_noise_db` SET TAGS ('dbx_business_glossary_term' = 'Target Noise Level (dB) (TNL)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `target_torque_nm` SET TAGS ('dbx_business_glossary_term' = 'Target Torque (Nm) (TTQ)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Test Approval Status (TAS)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Test Batch Number (TBN)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Test Category (TCAT)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_category` SET TAGS ('dbx_value_regex' = 'structural|powertrain|electronics|software');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Document Reference (TDR)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Minutes) (TDUR)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_engineer` SET TAGS ('dbx_business_glossary_term' = 'Test Engineer (TE)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_engineer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_engineer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_facility` SET TAGS ('dbx_business_glossary_term' = 'Test Facility (TF)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location Code (TLC)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Validation Test Name (VTN)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_phase` SET TAGS ('dbx_business_glossary_term' = 'Test Phase (TPH)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_phase` SET TAGS ('dbx_value_regex' = 'prototype|pre_production|production');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_report_url` SET TAGS ('dbx_business_glossary_term' = 'Test Report URL (TRURL)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result (TR)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_result_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Recording Timestamp (RRT)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_revision_number` SET TAGS ('dbx_business_glossary_term' = 'Test Revision Number (TRN)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Standard Reference (TSR)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status (TS)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Timestamp (TET)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Validation Test Type (VTT)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'DVP|PVP|PPAP|Durability|Emissions|NCAP');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `test_version` SET TAGS ('dbx_business_glossary_term' = 'Test Version (TV)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `torque_nm` SET TAGS ('dbx_business_glossary_term' = 'Measured Torque (Nm) (MTQ)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `automotive_ecm`.`engineering`.`validation_test` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Result Variance Percentage (RV%) (VVAR)');
ALTER TABLE `automotive_ecm`.`engineering`.`engineering_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`engineering`.`engineering_test_result` SET TAGS ('dbx_subdomain' = 'quality_validation');
ALTER TABLE `automotive_ecm`.`engineering`.`engineering_test_result` ALTER COLUMN `engineering_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for engineering_test_result');
ALTER TABLE `automotive_ecm`.`engineering`.`engineering_test_result` ALTER COLUMN `validation_test_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Test Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` SET TAGS ('dbx_subdomain' = 'product_development');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Milestone ID');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `dvp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Dvp Plan Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `gate_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Outcome');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `gate_review_outcome` SET TAGS ('dbx_value_regex' = 'approved|conditional|deferred|rejected');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Milestone Flag');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_value_regex' = 'P0|P1|P2|P3|SOP');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'gate|review|release|prototype|pilot');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `open_action_items_count` SET TAGS ('dbx_business_glossary_term' = 'Open Action Items Count');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `plant_location` SET TAGS ('dbx_business_glossary_term' = 'Plant Location');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Milestone Risk Level');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`milestone` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` SET TAGS ('dbx_subdomain' = 'quality_validation');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'FMEA Record Identifier');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `dvp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Dvp Plan Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Identifier (Part_ID)');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `analysis_team` SET TAGS ('dbx_business_glossary_term' = 'Analysis Team');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `current_controls` SET TAGS ('dbx_business_glossary_term' = 'Current Controls Description');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `detection_rating` SET TAGS ('dbx_business_glossary_term' = 'Detection Rating (D)');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `failure_effect` SET TAGS ('dbx_business_glossary_term' = 'Failure Effect Description');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Description');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `fmea_number` SET TAGS ('dbx_business_glossary_term' = 'FMEA Number (FMEA_ID)');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `fmea_record_status` SET TAGS ('dbx_business_glossary_term' = 'FMEA Record Status');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `fmea_record_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|rejected');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `fmea_type` SET TAGS ('dbx_business_glossary_term' = 'FMEA Type (Design or Process)');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `fmea_type` SET TAGS ('dbx_value_regex' = 'DFMEA|PFMEA');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `occurrence_rating` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Rating (O)');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `process_code` SET TAGS ('dbx_business_glossary_term' = 'Process Identifier (Process_ID)');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `rpn` SET TAGS ('dbx_business_glossary_term' = 'Risk Priority Number (RPN)');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Severity Rating (S)');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`fmea_record` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version Identifier');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` SET TAGS ('dbx_subdomain' = 'quality_validation');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `dvp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Plan ID');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order ID');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part ID');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program ID');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|withdrawn');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `completed_test_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Test Count');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD)');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `dvp_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `dvp_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|cancelled');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Is Locked');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Plan Code');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Plan Description');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `plan_title` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Plan Title');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Design Verification Plan Type');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'system|component|subsystem|vehicle|process');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Plan Priority');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `system_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle System ID');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `test_environment` SET TAGS ('dbx_value_regex' = 'lab|test_track|simulation|field');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `test_phase` SET TAGS ('dbx_business_glossary_term' = 'Test Phase');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `test_phase` SET TAGS ('dbx_value_regex' = 'development|prototype|pre-production|production|post-production');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'functional|performance|durability|safety|regulatory|environmental');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `total_test_count` SET TAGS ('dbx_business_glossary_term' = 'Total Test Count');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `vehicle_variant` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Variant');
ALTER TABLE `automotive_ecm`.`engineering`.`dvp_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` SET TAGS ('dbx_subdomain' = 'quality_validation');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `homologation_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Requirement ID');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `homologation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Record Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Vehicle Program ID (Vehicle_Program_ID)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `supplier_part_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Approval Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `compliance_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Method (Method)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `compliance_method` SET TAGS ('dbx_value_regex' = 'test|calculation|declaration');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Status)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|compliant|non_compliant|exempt');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created_Timestamp)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (Effective_Date)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (Expiration_Date)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Flag (Mandatory_Flag)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (Last_Review_Date)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region Code (Region)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (Notes)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (Priority)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Homologation Requirement Code (HRC)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Requirement Description (Desc)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (Source_System)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline (Deadline)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (Updated_Timestamp)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `vehicle_model_year` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model Year (MY)');
ALTER TABLE `automotive_ecm`.`engineering`.`homologation_requirement` ALTER COLUMN `vehicle_variant` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Variant Identifier (Variant)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` SET TAGS ('dbx_subdomain' = 'technical_specifications');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `ecu_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Ecu Specification Identifier');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `applicable_model_years` SET TAGS ('dbx_business_glossary_term' = 'Applicable Model Years');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `applicable_vehicle_variants` SET TAGS ('dbx_business_glossary_term' = 'Applicable Vehicle Variants');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `asw_release_date` SET TAGS ('dbx_business_glossary_term' = 'ASW Release Date');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `asw_release_number` SET TAGS ('dbx_business_glossary_term' = 'ASW Release Number');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `calibration_dataset_reference` SET TAGS ('dbx_business_glossary_term' = 'Calibration Dataset Reference');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'CAN|LIN|Ethernet|FlexRay|MOST|CANFD');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'ISO_26262|IATF_16949|ISO_9001');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `diagnostic_trouble_code_support` SET TAGS ('dbx_business_glossary_term' = 'Diagnostic Trouble Code Support');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `dimensions_mm` SET TAGS ('dbx_business_glossary_term' = 'ECU Dimensions (mm)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `ecu_family` SET TAGS ('dbx_business_glossary_term' = 'ECU Family');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `ecu_specification_description` SET TAGS ('dbx_business_glossary_term' = 'ECU Description');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `ecu_specification_name` SET TAGS ('dbx_business_glossary_term' = 'ECU Name');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `ecu_specification_status` SET TAGS ('dbx_business_glossary_term' = 'ECU Lifecycle Status');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `ecu_specification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|retired|development|released');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `ecu_type` SET TAGS ('dbx_business_glossary_term' = 'ECU Type');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `ecu_type` SET TAGS ('dbx_value_regex' = 'engine_control|transmission|adas|body_control|battery_management|infotainment');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `eol_date` SET TAGS ('dbx_business_glossary_term' = 'End‑of‑Life Date');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `functional_safety_asil` SET TAGS ('dbx_business_glossary_term' = 'Functional Safety ASIL Rating');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `functional_safety_asil` SET TAGS ('dbx_value_regex' = 'ASIL_A|ASIL_B|ASIL_C|ASIL_D');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `hardware_revision` SET TAGS ('dbx_business_glossary_term' = 'Hardware Revision');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `hardware_version` SET TAGS ('dbx_business_glossary_term' = 'Hardware Version');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical ECU Flag');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `max_operating_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Temperature (°C)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `memory_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Memory Size (MB)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `min_operating_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Temperature (°C)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `power_consumption_w` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption (W)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `processing_speed_mhz` SET TAGS ('dbx_business_glossary_term' = 'Processing Speed (MHz)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'draft|released|archived|obsolete');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `software_release_notes` SET TAGS ('dbx_business_glossary_term' = 'Software Release Notes');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `supported_features` SET TAGS ('dbx_business_glossary_term' = 'Supported Features');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `vehicle_platform` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Platform');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `voltage_range_v` SET TAGS ('dbx_business_glossary_term' = 'Voltage Range (V)');
ALTER TABLE `automotive_ecm`.`engineering`.`ecu_specification` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'ECU Weight (kg)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` SET TAGS ('dbx_subdomain' = 'technical_specifications');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `powertrain_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Specification ID');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Apqp Plan Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `architecture_type` SET TAGS ('dbx_business_glossary_term' = 'Engine Architecture Type');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `aspiration_type` SET TAGS ('dbx_business_glossary_term' = 'Aspiration Type');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `aspiration_type` SET TAGS ('dbx_value_regex' = 'naturally_aspirated|turbocharged|supercharged');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `battery_capacity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Battery Capacity (kWh)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency (ISO 4217)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `cylinder_count` SET TAGS ('dbx_business_glossary_term' = 'Cylinder Count');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `dimensions_mm` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Dimensions (mm)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `displacement_cc` SET TAGS ('dbx_business_glossary_term' = 'Engine Displacement (cubic centimeters)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `emission_control_technology` SET TAGS ('dbx_business_glossary_term' = 'Emission Control Technology');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `emissions_standard` SET TAGS ('dbx_business_glossary_term' = 'Emissions Standard Compliance');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `emissions_standard` SET TAGS ('dbx_value_regex' = 'Euro6|EPA_Tier3|CARB_LEVIII|WLTP');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `end_of_production_date` SET TAGS ('dbx_business_glossary_term' = 'End of Production Date');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `epa_range_miles` SET TAGS ('dbx_business_glossary_term' = 'EPA Range (miles)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'gasoline|diesel|electric|hydrogen|hybrid');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Specification Lock Flag');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `power_output_kw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Power Output (kW)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `powertrain_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Specification Status');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `powertrain_spec_status` SET TAGS ('dbx_value_regex' = 'draft|active|retired|obsolete');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Type (ICE|HEV|PHEV|BEV|FCEV)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_value_regex' = 'ICE|HEV|PHEV|BEV|FCEV');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `spec_code` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Specification Code');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `spec_name` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Specification Name');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `start_of_production_date` SET TAGS ('dbx_business_glossary_term' = 'Start of Production Date');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `target_program_code` SET TAGS ('dbx_business_glossary_term' = 'Target Vehicle Program Code');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `thermal_management` SET TAGS ('dbx_business_glossary_term' = 'Thermal Management Approach');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `thermal_management` SET TAGS ('dbx_value_regex' = 'air|liquid|phase_change|heat_pump');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `torque_nm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Torque (Nm)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `transmission_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Type');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `transmission_type` SET TAGS ('dbx_value_regex' = 'manual|automatic|dual_clutch|CVT|e-gear');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `vehicle_variant` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Variant');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Version Number');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Weight (kg)');
ALTER TABLE `automotive_ecm`.`engineering`.`powertrain_spec` ALTER COLUMN `wltp_range_km` SET TAGS ('dbx_business_glossary_term' = 'WLTP Range (km)');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` SET TAGS ('dbx_subdomain' = 'technical_specifications');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification ID');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `application_restriction` SET TAGS ('dbx_business_glossary_term' = 'Application Restriction');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `approved_supplier` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier(s)');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `compliance_reach` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliance Status');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `compliance_reach` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `compliance_rohs` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Status');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `compliance_rohs` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `cost_per_kg_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost per Kilogram (USD)');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `density_kg_per_m3` SET TAGS ('dbx_business_glossary_term' = 'Density (kg/m³)');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `elongation_percent` SET TAGS ('dbx_business_glossary_term' = 'Elongation Percentage');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `environmental_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Score');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `grade_or_alloy` SET TAGS ('dbx_business_glossary_term' = 'Grade or Alloy Designation');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Material Flag');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_design|approved|in_use|retired|archived');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `material_class` SET TAGS ('dbx_business_glossary_term' = 'Material Class');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `material_class` SET TAGS ('dbx_value_regex' = 'steel|aluminum|polymer|composite|glass');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `material_specification_name` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Name');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `material_specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `material_specification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `material_specification_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `material_specification_type` SET TAGS ('dbx_value_regex' = 'structural|electrical|thermal|decorative');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `specific_heat_j_per_kgk` SET TAGS ('dbx_business_glossary_term' = 'Specific Heat Capacity (J/kg·K)');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `surface_treatment` SET TAGS ('dbx_business_glossary_term' = 'Surface Treatment');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `surface_treatment` SET TAGS ('dbx_value_regex' = 'none|coating|plating|anodizing|galvanizing');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `tensile_strength_mpa` SET TAGS ('dbx_business_glossary_term' = 'Tensile Strength (MPa)');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `thermal_conductivity_w_per_mk` SET TAGS ('dbx_business_glossary_term' = 'Thermal Conductivity (W/m·K)');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `yield_strength_mpa` SET TAGS ('dbx_business_glossary_term' = 'Yield Strength (MPa)');
ALTER TABLE `automotive_ecm`.`engineering`.`material_specification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `automotive_ecm`.`engineering`.`document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`engineering`.`document` SET TAGS ('dbx_subdomain' = 'product_development');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Document ID');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `author` SET TAGS ('dbx_business_glossary_term' = 'Document Author');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `engineering_document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Lifecycle Status');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `engineering_document_status` SET TAGS ('dbx_value_regex' = 'draft|released|archived|obsolete');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'Storage File Path');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Document File Format');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'pdf|dwg|docx|xlsx|xml');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `is_digital_twin_ready` SET TAGS ('dbx_business_glossary_term' = 'Digital Twin Ready Flag');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Document Retention Policy');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `retention_policy` SET TAGS ('dbx_value_regex' = 'keep_5_years|keep_10_years|permanent');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Revision Level');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `automotive_ecm`.`engineering`.`document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` SET TAGS ('dbx_subdomain' = 'quality_validation');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` SET TAGS ('dbx_association_edges' = 'engineering.validation_test,engineering.homologation_requirement');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `test_requirement_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Test Requirement Compliance - Test Requirement Compliance Id');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `homologation_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Test Requirement Compliance - Homologation Requirement Id');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `validation_test_id` SET TAGS ('dbx_business_glossary_term' = 'Test Requirement Compliance - Validation Test Id');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `approved_by_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `evidence_document_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document URL');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `mapped_by_engineer` SET TAGS ('dbx_business_glossary_term' = 'Mapped By Engineer');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `mapping_date` SET TAGS ('dbx_business_glossary_term' = 'Mapping Date');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference');
ALTER TABLE `automotive_ecm`.`engineering`.`test_requirement_compliance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
