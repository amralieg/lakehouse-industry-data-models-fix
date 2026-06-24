-- Schema for Domain: packaging | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-24 01:59:37

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`packaging` COMMENT 'Die packaging and assembly operations covering all package types including WLCSP, InFO, CoWoS, TSV-based 3D-IC, flip-chip, wire bonding, and traditional leadframe/BGA formats. Manages OSAT partnerships, assembly process flows, substrate BOMs, package qualification, and assembly yield data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` (
    `assembly_order_id` BIGINT COMMENT 'Primary key for assembly_order',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who requested the assembly order.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: Assembly orders are created to fulfill customer bookings in semiconductor ops. Production planners and customer service teams trace booking commitments to OSAT assembly execution for on-time delivery ',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Needed for Assembly Order Cost Allocation and Regulatory Traceability linking the order to the die bank supplying the dies.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Assembly Order is created for a specific IC design project; linking enables traceability, cost allocation, and schedule alignment in the packaging execution process.',
    `material_lot_id` BIGINT COMMENT 'Identifier of the substrate lot used in the packaging process.',
    `osat_vendor_id` BIGINT COMMENT 'Identifier of the outsourced assembly partner responsible for execution.',
    `package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Every assembly order specifies a package type. This FK is essential for filtering orders by package format, capacity planning, and routing to qualified OSAT sites.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: REQUIRED: Assembly order fulfillment depends on a purchase order; linking supports order‑PO status reconciliation and financial reporting.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Assembly orders specify where OSAT-finished goods ship — customer warehouse, distribution center, or consignment hub. Linking assembly_order to customer.address via ship_to_address_id enables logistic',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Packaging must reference the tapeout record to ensure the correct mask set and timing closure status are used for assembly.',
    `actual_yield_percent` DECIMAL(18,2) COMMENT 'Yield percentage achieved after assembly completion.',
    `assembly_order_status` STRING COMMENT 'Current lifecycle state of the assembly order.. Valid values are `released|in_process|completed|on_hold|cancelled`',
    `assembly_osat_vendor_fk` BIGINT COMMENT 'FK to packaging.osat_vendor.osat_vendor_id — Assembly orders are issued to a specific OSAT vendor or internal site. This FK is essential for OSAT capacity planning, scorecard reporting, and order routing.',
    `assembly_site` STRING COMMENT 'Code of the facility where the assembly is performed.',
    `completion_date` DATE COMMENT 'Date when the assembly work was completed.',
    `cost_adjustment_amount` DECIMAL(18,2) COMMENT 'Any cost adjustments (e.g., discounts, fees) applied to the gross amount.',
    `cost_gross_amount` DECIMAL(18,2) COMMENT 'Estimated total cost before any adjustments.',
    `cost_net_amount` DECIMAL(18,2) COMMENT 'Final cost after adjustments, representing the amount to be billed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assembly order record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost amounts.. Valid values are `USD|EUR|JPY|CNY|GBP|CAD`',
    `defect_count` STRING COMMENT 'Number of defects recorded during assembly.',
    `expected_yield_percent` DECIMAL(18,2) COMMENT 'Target yield percentage expected for the assembly run.',
    `hold_flag` BOOLEAN COMMENT 'Indicates whether the order is currently on hold.',
    `inspection_status` STRING COMMENT 'Result of the final inspection for the assembled package.. Valid values are `pending|passed|failed`',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status transition.',
    `notes` STRING COMMENT 'Free‑form comments or remarks related to the order.',
    `order_number` STRING COMMENT 'Business-visible alphanumeric identifier assigned to the assembly order.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'Timestamp when the assembly order was initially placed.',
    `order_source` STRING COMMENT 'Origin of the order request.. Valid values are `internal|osat|external`',
    `priority` STRING COMMENT 'Business priority assigned to the assembly order.. Valid values are `low|medium|high|critical`',
    `quantity_ordered` STRING COMMENT 'Number of die units requested for assembly.',
    `release_date` DATE COMMENT 'Date when the order was released for execution.',
    `special_handling_instructions` STRING COMMENT 'Any additional instructions required for the assembly (e.g., cleanroom level, moisture sensitivity).',
    `target_ship_date` DATE COMMENT 'Planned date for shipment of the completed assembly.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the assembly order record.',
    CONSTRAINT pk_assembly_order PRIMARY KEY(`assembly_order_id`)
) COMMENT 'Primary transactional record for die packaging and assembly work orders issued to OSAT partners or internal assembly lines. Captures assembly order number, package type (WLCSP, InFO, CoWoS, flip-chip, wire bond, BGA, leadframe), die lot reference, substrate lot, quantity ordered, target ship date, assembly site, process flow revision, and order status lifecycle (released, in-process, completed, on-hold). SSOT for all assembly execution events in the packaging domain. Shipment logistics and delivery tracking are owned by the order domain; cost accounting is owned by the finance domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` (
    `package_type_id` BIGINT COMMENT 'Primary key for package_type',
    `ball_count_max` STRING COMMENT 'Maximum number of solder balls for BGA‑type packages.',
    `ball_count_min` STRING COMMENT 'Minimum number of solder balls for BGA‑type packages.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the package type record was first created in the system.',
    `package_type_description` STRING COMMENT 'Free‑form description of the package’s mechanical and electrical characteristics.',
    `effective_from` DATE COMMENT 'Date on which the package type becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the package type is no longer valid (null if indefinite).',
    `is_3d_ic` BOOLEAN COMMENT 'True if the package incorporates through‑silicon vias or other 3‑D stacking.',
    `is_advanced_package` BOOLEAN COMMENT 'True for cutting‑edge or specialty package formats.',
    `is_ball_grid_array` BOOLEAN COMMENT 'True if the package is a ball‑grid array type.',
    `is_flip_chip` BOOLEAN COMMENT 'True if the package utilizes flip‑chip interconnect technology.',
    `is_heterogeneous_integration` BOOLEAN COMMENT 'Indicates whether the package supports heterogeneous integration (e.g., chip‑on‑wafer).',
    `is_itar_controlled` BOOLEAN COMMENT 'True if the package is subject to International Traffic in Arms Regulations.',
    `is_leadframe` BOOLEAN COMMENT 'True if the package uses a traditional leadframe.',
    `is_osat_supported` BOOLEAN COMMENT 'True if the package type is commonly offered by outsourced assembly providers.',
    `is_reach_compliant` BOOLEAN COMMENT 'True if the package complies with REACH chemical safety regulations.',
    `is_rohs_compliant` BOOLEAN COMMENT 'True if the package meets RoHS restriction requirements.',
    `is_wire_bond` BOOLEAN COMMENT 'True if the package uses wire‑bond interconnects.',
    `jedec_outline_code` STRING COMMENT 'Official JEDEC outline identifier for the package (e.g., 5x5‑1mm).',
    `max_current_a` DECIMAL(18,2) COMMENT 'Maximum continuous current rating for the package.',
    `max_die_pitch_um` DECIMAL(18,2) COMMENT 'Maximum center‑to‑center spacing between dies for multi‑die packages.',
    `max_operating_temperature_c` DECIMAL(18,2) COMMENT 'Highest temperature at which the package can reliably operate.',
    `max_power_dissipation_w` DECIMAL(18,2) COMMENT 'Maximum power the package can dissipate safely.',
    `max_voltage_v` DECIMAL(18,2) COMMENT 'Maximum voltage rating the package can withstand.',
    `min_die_pitch_um` DECIMAL(18,2) COMMENT 'Minimum center‑to‑center spacing between dies for multi‑die packages.',
    `min_operating_temperature_c` DECIMAL(18,2) COMMENT 'Lowest temperature at which the package can reliably operate.',
    `moisture_sensitivity_level` STRING COMMENT 'JEDEC‑defined moisture sensitivity classification.. Valid values are `MSL1|MSL2|MSL3|MSL4|MSL5|MSL6`',
    `package_category` STRING COMMENT 'Primary category of the package format; limited to six most common values.. Valid values are `wlcsp|info|cowos|tsv_3d|flip_chip|wire_bond`',
    `package_dimensions_height_um` DECIMAL(18,2) COMMENT 'External height (thickness) dimension of the package.',
    `package_dimensions_length_um` DECIMAL(18,2) COMMENT 'External length dimension of the package.',
    `package_dimensions_width_um` DECIMAL(18,2) COMMENT 'External width dimension of the package.',
    `package_family` STRING COMMENT 'Higher‑level family grouping (e.g., Wafer‑Level, Flip‑Chip, 3D‑IC).',
    `package_material` STRING COMMENT 'Primary material used for the package substrate.. Valid values are `organic|ceramic|metal|plastic`',
    `package_name` STRING COMMENT 'Human‑readable name of the package format (e.g., WLCSP, CoWoS).',
    `package_type_status` STRING COMMENT 'Current lifecycle status of the package type.. Valid values are `active|inactive|deprecated`',
    `pin_count_max` STRING COMMENT 'Maximum number of electrical pins/balls the package can support.',
    `pin_count_min` STRING COMMENT 'Minimum number of electrical pins/balls the package can support.',
    `qualification_status` STRING COMMENT 'Current qualification state of the package format.. Valid values are `qualified|pending|rejected`',
    `reference_document` STRING COMMENT 'Identifier or URL of the primary specification document for the package type.',
    `thermal_resistance_c_per_w` DECIMAL(18,2) COMMENT 'Thermal resistance from die to ambient, expressed in degrees Celsius per Watt.',
    `typical_thickness_um` DECIMAL(18,2) COMMENT 'Nominal vertical thickness of the finished package.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the package type record.',
    CONSTRAINT pk_package_type PRIMARY KEY(`package_type_id`)
) COMMENT 'Reference master for all semiconductor package formats supported by Semiconductors, including WLCSP, InFO, CoWoS, TSV-based 3D-IC, flip-chip BGA, wire-bond QFN, leadframe DIP/QFP, and advanced heterogeneous integration formats. Stores package family, body dimensions, pin/ball count range, thermal resistance specs, moisture sensitivity level (MSL), JEDEC outline code, and qualification status. SSOT for package format classification used across assembly, product catalog, and qualification domains.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` (
    `osat_vendor_id` BIGINT COMMENT 'Unique surrogate key for OSAT vendor record.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: REQUIRED: OSAT vendor is a supplier; linking enables unified supplier performance, audit, and regulatory reporting.',
    `aec_q100_certified` BOOLEAN COMMENT 'Indicates if the vendor holds AEC-Q100 qualification.',
    `audit_score` DECIMAL(18,2) COMMENT 'Score from the latest audit (0-100).',
    `capacity_tier` STRING COMMENT 'Capacity tier classification for the vendors assembly lines.. Valid values are `Low|Medium|High|VeryHigh`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was first created.',
    `dppm_rate` DECIMAL(18,2) COMMENT 'Historical DPPM rate of the vendors assembly processes.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the vendor.',
    `export_control_classification` STRING COMMENT 'Export control regime applicable to the vendor.. Valid values are `EAR|ITAR|None`',
    `iatf_16949_certified` BOOLEAN COMMENT 'Indicates if the vendor holds IATF 16949 certification.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates if the vendor holds ISO 9001 certification.',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality audit performed on the vendor.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the vendor record.. Valid values are `Active|Inactive|Onboarding|Offboarded`',
    `nda_ip_protection` BOOLEAN COMMENT 'Indicates whether a non-disclosure agreement and IP protection are in place.',
    `notes` STRING COMMENT 'Free-form notes regarding the vendor.',
    `package_capabilities` STRING COMMENT 'Comma-separated list of package types the vendor is qualified to assemble (e.g., WLCSP, InFO, CoWoS, TSV, flip-chip, BGA).',
    `partnership_status` STRING COMMENT 'Current qualification status of the vendor within the OSAT program.. Valid values are `Approved|Preferred|Probation|Suspended|Terminated`',
    `preferred_package_types` STRING COMMENT 'Comma-separated list of package types the vendor is preferred for.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person at the vendor.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact.',
    `quality_certifications` STRING COMMENT 'Semicolon-separated list of quality certifications held by the vendor (e.g., IATF 16949, ISO 9001, AEC-Q100).',
    `standard_lead_time_days` STRING COMMENT 'Typical lead time in days for standard package orders.',
    `tax_identifier` STRING COMMENT 'Government tax identifier for the vendor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vendor record.',
    `vendor_address` STRING COMMENT 'Physical address of the vendors primary site.',
    `vendor_code` STRING COMMENT 'Unique vendor code used in ERP and PLM systems.',
    `vendor_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the vendors headquarters. [ENUM-REF-CANDIDATE: USA|CHN|KOR|JPN|TWN|DEU|... — promote to reference product]',
    `vendor_name` STRING COMMENT 'Legal name of the OSAT vendor as registered.',
    `vendor_short_name` STRING COMMENT 'Commonly used short name or abbreviation for the vendor.',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on ownership and relationship.. Valid values are `OSAT|Internal|ThirdParty|JointVenture`',
    CONSTRAINT pk_osat_vendor PRIMARY KEY(`osat_vendor_id`)
) COMMENT 'Master record for Outsourced Semiconductor Assembly and Test (OSAT) partners and internal assembly sites used by Semiconductors. Captures vendor legal name, site locations, approved package type capabilities, quality certifications (IATF 16949, ISO 9001, AEC-Q100), historical DPPM performance, capacity tiers, standard lead times, NDA/IP protection status, export control classification (EAR/ITAR), and approved/preferred/probation status. SSOT for OSAT partner identity and qualification status within the packaging domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` (
    `assembly_process_flow_id` BIGINT COMMENT 'Unique system-generated identifier for each assembly process flow definition.',
    `package_type_id` BIGINT COMMENT 'FK to packaging.packaging_package_type.packaging_package_type_id — Process flows are defined per package type. A package type may have multiple flow revisions but each flow targets a specific package format.',
    `control_plan_id` BIGINT COMMENT 'Foreign key linking to quality.control_plan. Business justification: An assembly process flow defines packaging steps; a control plan governs quality checkpoints within that flow. In IATF 16949 semiconductor manufacturing, control plans are directly associated with pro',
    `primary_assembly_package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Process flows are defined per package type. Required for routing and DFM constraint validation.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Process Flow Definition uses a specific process node; required for Process Flow Specification report.',
    `assembly_process_flow_status` STRING COMMENT 'Current lifecycle status of the flow definition.. Valid values are `active|inactive|draft|deprecated|retired`',
    `bond_type` STRING COMMENT 'Primary interconnect technology employed in the flow.. Valid values are `wire_bond|flip_chip|bump|csp|none|other`',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard that this flow must satisfy.. Valid values are `SEMI|JEDEC|ISO9001|ISO14001|ITAR|EAR`',
    `created_timestamp` TIMESTAMP COMMENT '',
    `assembly_process_flow_description` STRING COMMENT 'Detailed free‑text description of the flow, its purpose, and scope.',
    `dfm_constraints` STRING COMMENT 'Free‑text list of DFM rules or constraints that must be obeyed for this flow.',
    `die_attach_method` STRING COMMENT 'Method used to attach the die to the substrate.. Valid values are `epoxy|solder|flip_chip|thermo_compression|csp|none`',
    `effective_from` DATE COMMENT 'Date on which the flow becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the flow is no longer valid (null if open‑ended).',
    `equipment_class` STRING COMMENT 'High‑level classification of equipment required for the flow (e.g., "Flip‑Chip Bonder", "Mold Press").',
    `final_inspection_type` STRING COMMENT 'Primary inspection technique performed after assembly completion.. Valid values are `visual|automated|xray|acoustic|none|custom`',
    `flow_name` STRING COMMENT 'Human‑readable name describing the assembly process flow (e.g., "Advanced 3D‑IC Flip‑Chip Flow").',
    `flow_status` STRING COMMENT '',
    `is_default_flow` BOOLEAN COMMENT 'Flag indicating whether this flow is the default for its package type.',
    `marking_method` STRING COMMENT 'Method used to apply identification marks to the finished package.. Valid values are `laser|ink|dot_peen|none|silk_screen|etch`',
    `molding_material` STRING COMMENT 'Encapsulation material applied during the molding step.. Valid values are `epoxy|plastic|ceramic|none|custom|silicone`',
    `process_time_target` DECIMAL(18,2) COMMENT 'Target total processing time for the flow, expressed in minutes.',
    `process_yield_target` DECIMAL(18,2) COMMENT 'Target yield percentage for the flow (e.g., 98.75).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the flow record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the flow record.',
    `revision_number` STRING COMMENT 'Sequential revision number of the flow definition.',
    `safety_classification` STRING COMMENT 'Safety level assigned to the flow (e.g., "Class A – Low Hazard").',
    `singulation_method` STRING COMMENT 'Technique used to separate individual packages from the wafer or panel.. Valid values are `laser|saw|plasma|mechanical|waterjet|none`',
    `step_count` STRING COMMENT 'Total count of discrete steps defined in the flow.',
    `underfill_material` STRING COMMENT 'Material used to fill the gap between die and substrate after bonding.. Valid values are `epoxy|silicone|none|custom|organic|inorganic`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the flow record.',
    CONSTRAINT pk_assembly_process_flow PRIMARY KEY(`assembly_process_flow_id`)
) COMMENT 'Master definition of the step-by-step assembly process flow for each package type and product combination. Captures flow revision, process steps (die attach, wire bond/flip-chip bump, underfill, molding, singulation, marking, final inspection), equipment class per step, material specifications, and DFM constraints. Linked to package type and product SKU. Enables traceability from assembly order to process specification.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` (
    `substrate_bom_id` BIGINT COMMENT 'Unique surrogate key for each substrate BOM record.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Substrate BOMs drive material master creation in supply. Linking enables procurement teams to source substrates defined in the BOM and validates compliance (RoHS, REACH) against the material master. p',
    `package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Substrate BOMs are specific to a package type. Required for procurement and assembly material planning.',
    `substrate_package_type_id` BIGINT COMMENT 'FK to packaging.packaging_package_type.packaging_package_type_id — Substrate BOMs are defined for specific package types (CoWoS interposer, flip-chip BGA substrate, etc.).',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier providing the substrate.',
    `avl_status` STRING COMMENT 'AVL qualification status of the substrate supplier.. Valid values are `approved|pending|rejected`',
    `bom_number` STRING COMMENT '',
    `bump_pitch_um` DECIMAL(18,2) COMMENT 'Center‑to‑center distance between bumps on the substrate, expressed in micrometers.',
    `classification` STRING COMMENT 'Classification indicating performance tier or special characteristics.. Valid values are `standard|high_performance|low_k`',
    `compliance_status` STRING COMMENT 'Overall regulatory compliance status of the substrate.. Valid values are `compliant|non_compliant|pending`',
    `core_material` STRING COMMENT 'Primary material of the substrate core (e.g., ABF, BT resin, silicon, glass).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the BOM record was first created.',
    `currency` STRING COMMENT 'Currency code for the unit cost.. Valid values are `USD|EUR|JPY|CNY`',
    `density_g_per_cm3` DECIMAL(18,2) COMMENT 'Material density of the substrate.',
    `dielectric_constant` DECIMAL(18,2) COMMENT 'Relative permittivity of the substrate material.',
    `effective_from` DATE COMMENT 'Date from which this BOM revision is valid for procurement.',
    `effective_until` DATE COMMENT 'Date until which this BOM revision remains valid (null if open‑ended).',
    `is_obsolete` BOOLEAN COMMENT 'Indicates whether the substrate is marked as obsolete.',
    `last_eco_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent engineering change order affecting this BOM.',
    `layer_count` STRING COMMENT 'Number of material layers in the substrate stack.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle phase of the substrate product.. Valid values are `in_design|in_production|end_of_life`',
    `material_grade` STRING COMMENT 'Grade or quality level of the substrate material.',
    `max_operating_temp_c` DECIMAL(18,2) COMMENT 'Maximum temperature at which the substrate can reliably operate.',
    `min_operating_temp_c` DECIMAL(18,2) COMMENT 'Minimum temperature for reliable substrate operation.',
    `substrate_bom_name` STRING COMMENT 'Human‑readable name or description of the substrate.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the substrate BOM.',
    `pad_finish` STRING COMMENT 'Surface finish applied to substrate pads (e.g., ENIG, OSP, immersion tin, gold).. Valid values are `ENIG|OSP|immersion_tin|gold`',
    `rdl_spec` STRING COMMENT 'Specification details of the redistribution layer (RDL) used on the substrate.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the substrate complies with REACH chemical safety requirements.',
    `revision` STRING COMMENT '',
    `revision_date` DATE COMMENT 'Date when the current revision was released.',
    `revision_number` STRING COMMENT 'Revision identifier for the BOM version.',
    `rohs_compliant` BOOLEAN COMMENT 'Indicates whether the substrate complies with RoHS restrictions.',
    `substrate_bom_status` STRING COMMENT 'Current lifecycle status of the BOM record.. Valid values are `active|inactive|obsolete|draft`',
    `substrate_type` STRING COMMENT 'Category of substrate used in packaging (e.g., interposer, die, panel, wafer).. Valid values are `interposer|die|panel|wafer`',
    `thermal_conductivity_w_per_mk` DECIMAL(18,2) COMMENT 'Thermal conductivity of the substrate material.',
    `thickness_um` DECIMAL(18,2) COMMENT 'Physical thickness of the substrate in micrometers.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Reference cost per unit of substrate (excluding taxes and freight).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the BOM record.',
    CONSTRAINT pk_substrate_bom PRIMARY KEY(`substrate_bom_id`)
) COMMENT 'Bill of Materials for packaging substrates and interposers used in advanced semiconductor packages. Captures substrate part number, layer count, core material (ABF, BT resin, silicon interposer, glass core), redistribution layer (RDL) specs, bump pitch, pad finish (ENIG, OSP, immersion tin), supplier, AVL status, unit cost reference, RoHS/REACH compliance flag, and revision history with ECO traceability. SSOT for substrate material specifications enabling procurement and assembly execution.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` (
    `assembly_lot_id` BIGINT COMMENT 'Unique system-generated identifier for the assembly lot record.',
    `assembly_order_id` BIGINT COMMENT 'FK to packaging.pkg_assembly_order.pkg_assembly_order_id — Assembly lots are created against assembly orders. This is the fundamental WIP-to-order traceability link.',
    `package_type_id` BIGINT COMMENT 'FK to packaging.packaging_package_type.packaging_package_type_id — Each assembly lot is for a specific package type. Required for WIP reporting and routing.',
    `assembly_packaging_package_type_id` BIGINT COMMENT 'FK to packaging.package_type',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: An assembly lot draws dies from a specific die bank. This FK enables die consumption tracking, die bank depletion reporting, and KGD traceability — essential for inventory accuracy and customer-facing',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Lot tracking reports require the originating design project to correlate yield and defect data with design intent.',
    `osat_vendor_id` BIGINT COMMENT 'FK to packaging.osat_vendor.osat_vendor_id — Each lot is processed at a specific OSAT site. Required for site-level yield analysis and capacity tracking.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Logistics and Inventory Valuation require storing the location of each assembled package for warehouse management.',
    `supplier_id` BIGINT COMMENT 'FK to supply.supplier',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Semiconductor manufacturing requires direct lot-to-tapeout traceability for failure analysis, customer returns (RMA), and yield correlation by mask revision. assembly_lot has ic_design_project_id but ',
    `wafer_map_id` BIGINT COMMENT 'Foreign key linking to quality.wafer_map. Business justification: Assembly operations consume the wafer map to identify KGD-certified die eligible for packaging. The wafer_map provides the die-level pass/fail bitmap that directly drives die selection for each assemb',
    `actual_completion_date` DATE COMMENT 'Date when the lot was actually completed; may be null if not yet finished.',
    `assembly_site` STRING COMMENT 'Name of the OSAT vendor or internal fab where the lot is assembled.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated monetary cost of assembling the lot, expressed in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the assembly lot record was first created in the system.',
    `cumulative_yield_percent` DECIMAL(18,2) COMMENT 'Overall percentage of good dies produced from the lot after each process step.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values associated with the lot.. Valid values are `USD|EUR|JPY|CNY|GBP|KRW`',
    `current_process_step` STRING COMMENT 'The most recent manufacturing step the lot has completed or is currently executing.',
    `defect_density` DECIMAL(18,2) COMMENT 'Number of defects per unit area (e.g., defects per cm²) observed on the lot.',
    `die_count` STRING COMMENT 'Total number of individual dies contained in the assembly lot.',
    `hold_flag` BOOLEAN COMMENT 'Indicates whether the lot is currently on hold for any reason.',
    `hold_reason` STRING COMMENT 'Free‑text description of why the lot was placed on hold.',
    `inspection_fail_count` STRING COMMENT 'Number of inspection points that failed during the latest quality check.',
    `inspection_pass_count` STRING COMMENT 'Number of inspection points that passed during the latest quality check.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the assembly lot record.',
    `lot_name` STRING COMMENT 'Human‑readable name or label for the assembly lot, often used in reports and dashboards.',
    `lot_number` STRING COMMENT 'External business identifier assigned to the assembly lot, used for tracking across systems.',
    `lot_status` STRING COMMENT 'Overall lifecycle state of the lot, indicating whether it is active, completed, or terminated.. Valid values are `open|closed|scrapped`',
    `package_version` STRING COMMENT 'Version or revision identifier of the package design used for this lot.',
    `quality_status` STRING COMMENT 'Result of the most recent quality inspection for the lot.. Valid values are `passed|failed|pending`',
    `quantity` STRING COMMENT '',
    `start_date` DATE COMMENT 'Planned or actual date when assembly of the lot began.',
    `target_completion_date` DATE COMMENT 'Planned date by which the lot should be fully assembled.',
    `wip_status` STRING COMMENT 'Operational status of the lot within the assembly workflow.. Valid values are `queued|in_process|hold|complete`',
    CONSTRAINT pk_assembly_lot PRIMARY KEY(`assembly_lot_id`)
) COMMENT 'Master tracking entity for an assembly lot progressing through OSAT or internal packaging operations. Captures lot number, parent wafer lot reference, die count, package type, assembly site (OSAT vendor), current process step, WIP status (queued, in-process, hold, complete), start/target/actual completion dates, cumulative yield, and hold flags. Central WIP identity that all step records, yield results, inspections, and defects reference. SSOT for assembly lot identity and real-time WIP status within the packaging domain. Equipment asset records are owned by the equipment domain; SPC charting is owned by the quality domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` (
    `assembly_yield_id` BIGINT COMMENT 'Primary key for assembly_yield',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the equipment (e.g., die attach machine, wire bonder) used for this step.',
    `assembly_lot_id` BIGINT COMMENT 'Identifier of the parent assembly run or batch to which this yield step belongs.',
    `assembly_yield_status` STRING COMMENT 'Current lifecycle status of the step record.. Valid values are `in_progress|completed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the yield record was first created in the system.',
    `cumulative_yield_percent` DECIMAL(18,2) COMMENT 'Running cumulative yield from the start of the assembly run to this step.',
    `dppm` DECIMAL(18,2) COMMENT 'Defective parts per million metric for the step.',
    `fallout_rate` DECIMAL(18,2) COMMENT 'Assembly fallout rate as a decimal ratio',
    `first_pass_yield` STRING COMMENT 'First pass yield percentage',
    `good_unit_count` STRING COMMENT '',
    `process_step` STRING COMMENT 'Name of the specific packaging process step for which the yield data is recorded.. Valid values are `die_attach|wire_bond|bga_assembly|testing|final_inspection`',
    `recorded_timestamp` TIMESTAMP COMMENT '',
    `scrap_reason_code` STRING COMMENT 'Standardized code describing why units were scrapped.. Valid values are `contamination|misalignment|defect|damage|other`',
    `step_end_timestamp` TIMESTAMP COMMENT 'Date and time when the process step completed.',
    `step_sequence` STRING COMMENT 'Ordinal position of the step within the overall assembly run.',
    `step_start_timestamp` TIMESTAMP COMMENT 'Date and time when the process step began.',
    `units_in` STRING COMMENT 'Number of dies or packages entering the process step.',
    `units_out` STRING COMMENT 'Number of good dies or packages exiting the process step.',
    `units_scrapped` STRING COMMENT 'Number of dies or packages discarded during the step.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the yield record.',
    `yield_percent` DECIMAL(18,2) COMMENT 'Yield for the step expressed as a percentage of units_out to units_in.',
    `yield_rate` DECIMAL(18,2) COMMENT 'Assembly yield rate as a decimal ratio',
    CONSTRAINT pk_assembly_yield PRIMARY KEY(`assembly_yield_id`)
) COMMENT 'Transactional record capturing assembly yield data at each major process step and at final assembly completion for each lot. Stores lot ID, process step, units in, units out, units scrapped, scrap reason codes, yield percentage, cumulative assembly yield, and DPPM. Also serves as the authoritative record for scrap quantities and loss reasons within the packaging domain. Feeds assembly yield trending, OSAT scorecard, cost of poor quality (COPQ) analysis, and product cost calculations. Distinct from wafer probe yield (owned by test domain).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` (
    `package_qualification_id` BIGINT COMMENT 'Primary key for package_qualification',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Customer design wins frequently trigger new package qualifications — the customers application requirements mandate a specific qualification test. Linking package_qualification to customer_design_win',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Package qualification must be tied to the design project to verify that the chosen package meets the designs electrical and mechanical requirements.',
    `osat_vendor_id` BIGINT COMMENT 'FK to packaging.osat_vendor.osat_vendor_id — Qualifications are site-specific — a package type must be qualified at each OSAT site independently.',
    `package_type_id` BIGINT COMMENT 'FK to packaging.package_type',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Package qualification requires a specific test program; linking provides traceability of which test program validated the package, required for qualification audit.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Package qualification is executed against a quality specification defining pass/fail criteria, test types, and compliance standards. This link enables qualification engineers to enforce spec-driven qu',
    `reliability_test_id` BIGINT COMMENT 'Foreign key linking to quality.reliability_test. Business justification: Package qualification (AEC-Q100, JEDEC JESD47) is directly validated by reliability test results. Qualification engineers must link the qualification record to the specific reliability test that demon',
    `sku_id` BIGINT COMMENT 'FK to product.sku',
    `supplier_qualification_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_qualification. Business justification: IATF 16949 and PPAP require that OSAT vendors performing package qualification are also qualified suppliers. Linking package_qualification to supplier_qualification enables compliance reporting: confi',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Qualification results are linked to the specific tapeout to ensure the mask set used matches the qualified package specifications.',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Package qualification (JEDEC, AEC-Q100) is performed against a specific fabrication technology node. Qualification records must reference the node to ensure the package is certified for that process g',
    `tertiary_package_type_id` BIGINT COMMENT 'FK to packaging.package_type.package_type_id — Qualifications certify specific package types for production. Essential for determining which package types are production-released.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: AEC-Q100 and JEDEC package qualification records must reference the specific fab tool used during qualification testing. test_equipment_code is a denormalized string representation of this tool. A pro',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: Package qualification validity depends on the equipment qualification status of the tools used. Semiconductor quality systems (IATF 16949, AEC-Q100) require that package qualification records referenc',
    `approval_date` DATE COMMENT 'Date the qualification was formally approved for production release.',
    `compliance_flag` BOOLEAN COMMENT 'Indicator of any special compliance considerations (e.g., automotive, aerospace).',
    `cost_currency` STRING COMMENT 'Currency code for the qualification cost.. Valid values are `USD|EUR|JPY|CNY|GBP|CAD`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was first created in the system.',
    `defect_rate_ppm` STRING COMMENT 'Defective parts per million observed in the qualification samples.',
    `effective_from` DATE COMMENT 'Date the qualification becomes effective for manufacturing.',
    `effective_until` DATE COMMENT 'Expiration date of the qualification, if applicable.',
    `external_audit_date` DATE COMMENT 'Scheduled date for the external audit, if required.',
    `external_audit_required` BOOLEAN COMMENT 'Indicates whether an external audit is mandated for this qualification.',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the qualification team.',
    `pass_fail_criteria` STRING COMMENT 'Defined criteria that determine pass or fail outcomes for each test.',
    `qualification_cost_usd` DECIMAL(18,2) COMMENT 'Total cost incurred for the qualification program, expressed in US dollars.',
    `qualification_document_number` STRING COMMENT 'Reference to the document that contains the full qualification report.',
    `qualification_method` STRING COMMENT 'Approach used for qualification testing.. Valid values are `accelerated|full_life|simulation`',
    `qualification_owner` STRING COMMENT 'Name of the person responsible for managing the qualification program.',
    `qualification_result` STRING COMMENT 'Overall outcome of the qualification after evaluating all test criteria.. Valid values are `pass|fail|conditional`',
    `qualification_standard` STRING COMMENT 'Standard or specification against which the package is qualified.. Valid values are `JEDEC_JESD47|AEC_Q100|AEC_Q101|MIL_STD_883|CUSTOM`',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification program.. Valid values are `pending|in_progress|approved|rejected|withdrawn`',
    `qualification_type` STRING COMMENT 'Category of qualification: new package, package‑product combo, or OSAT site certification.. Valid values are `new_package|package_product_combination|osat_site`',
    `regulatory_compliance` STRING COMMENT 'Regulatory framework(s) the qualification adheres to.. Valid values are `JEDEC|AEC|MIL|CUSTOM`',
    `revision_number` STRING COMMENT 'Sequential revision number of the qualification record.',
    `risk_level` STRING COMMENT 'Assessed risk category of the qualification based on test outcomes.. Valid values are `low|medium|high|critical`',
    `sample_quantity` STRING COMMENT 'Number of sample units tested during qualification.',
    `stress_test_matrix` STRING COMMENT 'Set of stress tests applied during qualification (e.g., High Temperature Operating Life, Temperature Cycling).. Valid values are `HTOL|TC|HAST|ESD|Latch_Up|Thermal_Cycling`',
    `test_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the qualification test cycle in hours.',
    `test_location` STRING COMMENT 'Physical location or facility where the qualification testing was conducted.',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Maximum temperature (in Celsius) applied during stress testing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the qualification record.',
    `version` STRING COMMENT 'Version label for the qualification plan (e.g., v1.0, v2.1).',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of good dies per wafer after qualification testing.',
    CONSTRAINT pk_package_qualification PRIMARY KEY(`package_qualification_id`)
) COMMENT 'Master record for package qualification programs executed to certify a new package type, package-product combination, or OSAT site for production release. Captures qualification plan ID, package type, product SKU, qualification standard (JEDEC JESD47, AEC-Q100/Q101, MIL-STD-883), stress test matrix (HTOL, TC, HAST, ESD, latch-up), pass/fail criteria, qualification status, and approval date. SSOT for package qualification certification.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` (
    `material_lot_id` BIGINT COMMENT 'Primary key for material_lot',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Each material lot corresponds to a material master record defining procurement specs, RoHS/REACH compliance, and storage conditions. Linking enables compliance validation and procurement planning. par',
    `osat_vendor_id` BIGINT COMMENT '',
    `substrate_bom_id` BIGINT COMMENT 'FK to packaging.substrate_bom.substrate_bom_id — Material lots received are matched to substrate BOM line items for consumption tracking.',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: Material Traceability and Compliance reports need to link each packaging material lot to its raw material inventory record.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the external supplier providing the material lot.',
    `certificate_of_conformance_ref` STRING COMMENT 'Reference identifier to the Certificate of Conformance document associated with the lot.',
    `compliance_document_ref` STRING COMMENT 'Reference to any additional compliance documentation attached to the lot.',
    `compliance_itar_status` STRING COMMENT 'ITAR export‑control status of the material lot.. Valid values are `approved|restricted|denied`',
    `compliance_reach_status` STRING COMMENT 'REACH compliance status of the material lot.. Valid values are `compliant|non_compliant|exempt`',
    `compliance_rohs_status` STRING COMMENT 'RoHS compliance status of the material lot.. Valid values are `compliant|non_compliant|exempt`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost assigned to a single unit of the material.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost_per_unit.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `humidity_storage_percent` DECIMAL(18,2) COMMENT 'Recorded relative humidity percentage for the lots storage environment.',
    `incoming_inspection_status` STRING COMMENT 'Result of the initial quality inspection performed on receipt of the lot.. Valid values are `passed|failed|pending`',
    `inspection_failure_reason` STRING COMMENT 'Textual reason for inspection failure, if applicable.',
    `inspection_passed` BOOLEAN COMMENT 'True if the lot passed all required inspections.',
    `lot_number` STRING COMMENT 'Human‑readable identifier assigned to the material lot by the receiving facility.',
    `material_description` STRING COMMENT 'Free‑text description of the material, including any special characteristics.',
    `material_lot_status` STRING COMMENT 'Current lifecycle status of the material lot within the packaging operation.. Valid values are `received|inspected|released|quarantined|consumed|expired`',
    `material_type` STRING COMMENT 'Category of the packaging material (e.g., substrate, lead frame, mold compound). [ENUM-REF-CANDIDATE: substrate|lead_frame|mold_compound|bond_wire|solder_paste|underfill|marking_ink — 7 candidates stripped; promote to reference product]',
    `quality_score` DECIMAL(18,2) COMMENT 'Numerical quality rating assigned after inspection (0‑100).',
    `quantity_received` DECIMAL(18,2) COMMENT 'Total amount of material received in the lot, expressed in the unit defined by unit_of_measure.',
    `quarantine_flag` BOOLEAN COMMENT 'Indicates whether the lot is currently placed in quarantine pending further review.',
    `received_date` DATE COMMENT '',
    `received_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the material lot was logged into the system.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the material lot record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the material lot record.',
    `release_date` DATE COMMENT 'Date the lot was released from quarantine and made available for production.',
    `shelf_life_expiry_date` DATE COMMENT 'Date after which the material lot is considered out‑of‑spec for use.',
    `storage_condition` STRING COMMENT 'Required storage environment (e.g., temperature‑controlled, humidity‑controlled).',
    `supplier_lot_number` STRING COMMENT 'Lot number provided by the external supplier for traceability.',
    `temperature_storage_c` DECIMAL(18,2) COMMENT 'Recorded storage temperature in degrees Celsius for the lot.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for quantity_received (e.g., pieces, kilograms).. Valid values are `pieces|kg|g|ml`',
    CONSTRAINT pk_material_lot PRIMARY KEY(`material_lot_id`)
) COMMENT 'Master record for incoming packaging material lots received at the assembly site, including substrates, lead frames, mold compounds, bond wires, solder paste, underfill, and marking inks. Captures material part number, supplier lot number, quantity received, incoming inspection status, Certificate of Conformance (CoC) reference, shelf life expiry, storage conditions, and quarantine/release status. SSOT for packaging-specific material lot identity and incoming quality status. General inventory management is owned by the inventory domain; supplier master data is owned by the supply domain; RoHS/REACH compliance declarations are owned by the compliance domain.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_material_lot_id` FOREIGN KEY (`material_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`material_lot`(`material_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ADD CONSTRAINT `fk_packaging_assembly_order_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ADD CONSTRAINT `fk_packaging_assembly_process_flow_primary_assembly_package_type_id` FOREIGN KEY (`primary_assembly_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ADD CONSTRAINT `fk_packaging_substrate_bom_substrate_package_type_id` FOREIGN KEY (`substrate_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_assembly_order_id` FOREIGN KEY (`assembly_order_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_order`(`assembly_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_assembly_packaging_package_type_id` FOREIGN KEY (`assembly_packaging_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ADD CONSTRAINT `fk_packaging_assembly_lot_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ADD CONSTRAINT `fk_packaging_assembly_yield_assembly_lot_id` FOREIGN KEY (`assembly_lot_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`assembly_lot`(`assembly_lot_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_package_type_id` FOREIGN KEY (`package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ADD CONSTRAINT `fk_packaging_package_qualification_tertiary_package_type_id` FOREIGN KEY (`tertiary_package_type_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`package_type`(`package_type_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ADD CONSTRAINT `fk_packaging_material_lot_osat_vendor_id` FOREIGN KEY (`osat_vendor_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`osat_vendor`(`osat_vendor_id`);
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ADD CONSTRAINT `fk_packaging_material_lot_substrate_bom_id` FOREIGN KEY (`substrate_bom_id`) REFERENCES `vibe_semiconductors_v1`.`packaging`.`substrate_bom`(`substrate_bom_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`packaging` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`packaging` SET TAGS ('dbx_domain' = 'packaging');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` SET TAGS ('dbx_subdomain' = 'assembly_operations');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `assembly_order_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Order Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `material_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Substrate Lot Identifier (SLI)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'OSAT Partner Identifier (OPID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percentage (AYP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `assembly_order_status` SET TAGS ('dbx_business_glossary_term' = 'Assembly Order Status (AOS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `assembly_order_status` SET TAGS ('dbx_value_regex' = 'released|in_process|completed|on_hold|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `assembly_osat_vendor_fk` SET TAGS ('dbx_business_glossary_term' = 'Assembly Osat Vendor Fk');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `assembly_site` SET TAGS ('dbx_business_glossary_term' = 'Assembly Site Code (ASC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date (CD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `cost_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Adjustment Amount (CAA)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `cost_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `cost_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Cost Amount (GCA)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `cost_gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `cost_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Cost Amount (NCA)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `cost_net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CCY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CAD');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count (DC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `expected_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Yield Percentage (EYP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag (HF)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status (INS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp (LSCT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Assembly Order Number (AON)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placement Timestamp (OPT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source (OSRC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'internal|osat|external');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority (OPR)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered (QO)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date (RD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions (SHI)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `target_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Target Ship Date (TSD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` SET TAGS ('dbx_subdomain' = 'package_materials');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `ball_count_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Ball Count (BALL_MAX)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `ball_count_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Ball Count (BALL_MIN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_type_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description (PKG_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_3d_ic` SET TAGS ('dbx_business_glossary_term' = '3D‑IC Package Flag (IS_3D_IC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_advanced_package` SET TAGS ('dbx_business_glossary_term' = 'Advanced Package Flag (IS_ADV)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_ball_grid_array` SET TAGS ('dbx_business_glossary_term' = 'Ball‑Grid Array Flag (IS_BGA)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_flip_chip` SET TAGS ('dbx_business_glossary_term' = 'Flip‑Chip Package Flag (IS_FLIP_CHIP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_heterogeneous_integration` SET TAGS ('dbx_business_glossary_term' = 'Heterogeneous Integration Flag (IS_HET_INTEGR)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled Flag (ITAR_CTRL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_leadframe` SET TAGS ('dbx_business_glossary_term' = 'Leadframe Package Flag (IS_LEADFRAME)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_osat_supported` SET TAGS ('dbx_business_glossary_term' = 'OSAT Support Flag (IS_OSAT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliance Flag (REACH_COMP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Flag (ROHS_COMP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `is_wire_bond` SET TAGS ('dbx_business_glossary_term' = 'Wire‑Bond Package Flag (IS_WIRE_BOND)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `jedec_outline_code` SET TAGS ('dbx_business_glossary_term' = 'JEDEC Outline Code (JEDEC_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `max_current_a` SET TAGS ('dbx_business_glossary_term' = 'Maximum Current (A) (MAX_CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `max_die_pitch_um` SET TAGS ('dbx_business_glossary_term' = 'Maximum Die Pitch (µm)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `max_operating_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `max_power_dissipation_w` SET TAGS ('dbx_business_glossary_term' = 'Maximum Power Dissipation (W) (MAX_PWR)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `max_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Maximum Voltage (V) (MAX_VOLT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `min_die_pitch_um` SET TAGS ('dbx_business_glossary_term' = 'Minimum Die Pitch (µm)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `min_operating_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitivity Level (MSL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `moisture_sensitivity_level` SET TAGS ('dbx_value_regex' = 'MSL1|MSL2|MSL3|MSL4|MSL5|MSL6');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_category` SET TAGS ('dbx_business_glossary_term' = 'Package Category (PKG_CAT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_category` SET TAGS ('dbx_value_regex' = 'wlcsp|info|cowos|tsv_3d|flip_chip|wire_bond');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_dimensions_height_um` SET TAGS ('dbx_business_glossary_term' = 'Package Height (µm) (PKG_HT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_dimensions_length_um` SET TAGS ('dbx_business_glossary_term' = 'Package Length (µm) (PKG_LEN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_dimensions_width_um` SET TAGS ('dbx_business_glossary_term' = 'Package Width (µm) (PKG_WID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_family` SET TAGS ('dbx_business_glossary_term' = 'Package Family (PKG_FAMILY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_material` SET TAGS ('dbx_business_glossary_term' = 'Package Material (PKG_MAT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_material` SET TAGS ('dbx_value_regex' = 'organic|ceramic|metal|plastic');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name (PKG_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_name` SET TAGS ('dbx_pii_class' = 'person_name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_type_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status (PKG_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `package_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `pin_count_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pin Count (PIN_MAX)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `pin_count_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pin Count (PIN_MIN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QUAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Identifier (REF_DOC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `thermal_resistance_c_per_w` SET TAGS ('dbx_business_glossary_term' = 'Thermal Resistance (°C/W)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `typical_thickness_um` SET TAGS ('dbx_business_glossary_term' = 'Typical Package Thickness (µm)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` SET TAGS ('dbx_subdomain' = 'package_materials');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'OSAT Vendor ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `aec_q100_certified` SET TAGS ('dbx_business_glossary_term' = 'AEC-Q100 Certification (AEC_Q100_CERTIFIED)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score (AUDIT_SCORE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `capacity_tier` SET TAGS ('dbx_business_glossary_term' = 'Capacity Tier (CAPACITY_TIER)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `capacity_tier` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|VeryHigh');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `dppm_rate` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM_RATE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number (DUNS_NUMBER)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification (EXPORT_CONTROL_CLASS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR|ITAR|None');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `iatf_16949_certified` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Certification (IATF_16949_CERTIFIED)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certification (ISO_9001_CERTIFIED)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date (LAST_AUDIT_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Onboarding|Offboarded');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `nda_ip_protection` SET TAGS ('dbx_business_glossary_term' = 'NDA/IP Protection Status (NDA_IP_PROTECTION)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `package_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Package Capabilities (PACKAGE_CAPABILITIES)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `partnership_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Status (PARTNERSHIP_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `partnership_status` SET TAGS ('dbx_value_regex' = 'Approved|Preferred|Probation|Suspended|Terminated');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `preferred_package_types` SET TAGS ('dbx_business_glossary_term' = 'Preferred Package Types (PREFERRED_PACKAGE_TYPES)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email (PRIMARY_CONTACT_EMAIL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name (PRIMARY_CONTACT_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_class' = 'person_name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone (PRIMARY_CONTACT_PHONE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `quality_certifications` SET TAGS ('dbx_business_glossary_term' = 'Quality Certifications (QUALITY_CERTIFICATIONS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (LEAD_TIME_DAYS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TAX_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_address` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address (VENDOR_ADDRESS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code (VENDOR_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_country` SET TAGS ('dbx_business_glossary_term' = 'Vendor Country (VENDOR_COUNTRY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name (VENDOR_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_class' = 'person_name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_short_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Short Name (VENDOR_SHORT_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_short_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_short_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_short_name` SET TAGS ('dbx_pii_class' = 'person_name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type (VENDOR_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`osat_vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'OSAT|Internal|ThirdParty|JointVenture');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` SET TAGS ('dbx_subdomain' = 'assembly_operations');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `assembly_process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Flow ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Flow To Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `primary_assembly_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `assembly_process_flow_status` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `assembly_process_flow_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated|retired');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `bond_type` SET TAGS ('dbx_business_glossary_term' = 'Bond Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `bond_type` SET TAGS ('dbx_value_regex' = 'wire_bond|flip_chip|bump|csp|none|other');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'SEMI|JEDEC|ISO9001|ISO14001|ITAR|EAR');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `assembly_process_flow_description` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Description');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `dfm_constraints` SET TAGS ('dbx_business_glossary_term' = 'DFM Constraints');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `die_attach_method` SET TAGS ('dbx_business_glossary_term' = 'Die Attach Method');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `die_attach_method` SET TAGS ('dbx_value_regex' = 'epoxy|solder|flip_chip|thermo_compression|csp|none');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `equipment_class` SET TAGS ('dbx_business_glossary_term' = 'Equipment Class');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `final_inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Final Inspection Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `final_inspection_type` SET TAGS ('dbx_value_regex' = 'visual|automated|xray|acoustic|none|custom');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `flow_name` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Flow Name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `flow_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `flow_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `flow_name` SET TAGS ('dbx_pii_class' = 'person_name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `is_default_flow` SET TAGS ('dbx_business_glossary_term' = 'Is Default Flow');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `marking_method` SET TAGS ('dbx_business_glossary_term' = 'Marking Method');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `marking_method` SET TAGS ('dbx_value_regex' = 'laser|ink|dot_peen|none|silk_screen|etch');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `molding_material` SET TAGS ('dbx_business_glossary_term' = 'Molding Material');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `molding_material` SET TAGS ('dbx_value_regex' = 'epoxy|plastic|ceramic|none|custom|silicone');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `process_time_target` SET TAGS ('dbx_business_glossary_term' = 'Process Time Target (minutes)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `process_yield_target` SET TAGS ('dbx_business_glossary_term' = 'Process Yield Target (%)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `singulation_method` SET TAGS ('dbx_business_glossary_term' = 'Singulation Method');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `singulation_method` SET TAGS ('dbx_value_regex' = 'laser|saw|plasma|mechanical|waterjet|none');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `step_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Process Steps');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `underfill_material` SET TAGS ('dbx_business_glossary_term' = 'Underfill Material');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `underfill_material` SET TAGS ('dbx_value_regex' = 'epoxy|silicone|none|custom|organic|inorganic');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_process_flow` ALTER COLUMN `updated_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` SET TAGS ('dbx_subdomain' = 'package_materials');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Substrate Bill of Materials ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Substrate Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Substrate To Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `avl_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `avl_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `bump_pitch_um` SET TAGS ('dbx_business_glossary_term' = 'Bump Pitch (µm)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Substrate Classification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'standard|high_performance|low_k');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `core_material` SET TAGS ('dbx_business_glossary_term' = 'Core Material');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `density_g_per_cm3` SET TAGS ('dbx_business_glossary_term' = 'Density (g/cm³)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `dielectric_constant` SET TAGS ('dbx_business_glossary_term' = 'Dielectric Constant');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `is_obsolete` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Flag');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `last_eco_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last ECO Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `layer_count` SET TAGS ('dbx_business_glossary_term' = 'Layer Count');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_design|in_production|end_of_life');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `material_grade` SET TAGS ('dbx_business_glossary_term' = 'Material Grade');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `max_operating_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `min_operating_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_bom_name` SET TAGS ('dbx_business_glossary_term' = 'Substrate Name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_bom_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_bom_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_bom_name` SET TAGS ('dbx_pii_class' = 'person_name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `pad_finish` SET TAGS ('dbx_business_glossary_term' = 'Pad Finish');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `pad_finish` SET TAGS ('dbx_value_regex' = 'ENIG|OSP|immersion_tin|gold');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `rdl_spec` SET TAGS ('dbx_business_glossary_term' = 'Redistribution Layer Specification');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliant Flag');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_bom_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Status');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_bom_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|draft');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `substrate_type` SET TAGS ('dbx_value_regex' = 'interposer|die|panel|wafer');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `thermal_conductivity_w_per_mk` SET TAGS ('dbx_business_glossary_term' = 'Thermal Conductivity (W/m·K)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `thickness_um` SET TAGS ('dbx_business_glossary_term' = 'Substrate Thickness (µm)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`substrate_bom` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` SET TAGS ('dbx_subdomain' = 'assembly_operations');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `assembly_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lot To Order');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Package Type');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `assembly_packaging_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `assembly_packaging_package_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `wafer_map_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Map Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date (ACTUAL_COMP_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `assembly_site` SET TAGS ('dbx_business_glossary_term' = 'Assembly Site (SITE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD) (COST_EST)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `cumulative_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Yield Percentage (YIELD_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|KRW');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `current_process_step` SET TAGS ('dbx_business_glossary_term' = 'Current Process Step (PROC_STEP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `defect_density` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (DEFECT_DENSITY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `die_count` SET TAGS ('dbx_business_glossary_term' = 'Die Count (DIE_CNT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag (HOLD_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason (HOLD_RSN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `inspection_fail_count` SET TAGS ('dbx_business_glossary_term' = 'Inspection Fail Count (FAIL_CNT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `inspection_pass_count` SET TAGS ('dbx_business_glossary_term' = 'Inspection Pass Count (PASS_CNT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_name` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Name (LOT_NAME)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_name` SET TAGS ('dbx_pii_class' = 'person_name');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Assembly Lot Number (LOT_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Lifecycle Status (LOT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'open|closed|scrapped');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `package_version` SET TAGS ('dbx_business_glossary_term' = 'Package Version (PKG_VER)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status (QUAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Lot Start Date (START_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date (TARGET_COMP_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `wip_status` SET TAGS ('dbx_business_glossary_term' = 'Work‑In‑Process Status (WIP_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_lot` ALTER COLUMN `wip_status` SET TAGS ('dbx_value_regex' = 'queued|in_process|hold|complete');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` SET TAGS ('dbx_subdomain' = 'assembly_operations');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `assembly_yield_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Yield Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (EQID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `assembly_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Run Identifier (ARI)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `assembly_yield_status` SET TAGS ('dbx_business_glossary_term' = 'Step Status (SS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `assembly_yield_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|failed');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `cumulative_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Yield Percentage (CYP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `dppm` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Assembly Process Step (APS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `process_step` SET TAGS ('dbx_value_regex' = 'die_attach|wire_bond|bga_assembly|testing|final_inspection');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Scrap Reason Code (SRC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_value_regex' = 'contamination|misalignment|defect|damage|other');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `step_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Step End Timestamp (SET)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Number (SSN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `step_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Step Start Timestamp (SST)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `units_in` SET TAGS ('dbx_business_glossary_term' = 'Units Input Count (UIC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `units_out` SET TAGS ('dbx_business_glossary_term' = 'Units Output Count (UOC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `units_scrapped` SET TAGS ('dbx_business_glossary_term' = 'Units Scrapped Count (USC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`assembly_yield` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Step Yield Percentage (SYP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` SET TAGS ('dbx_subdomain' = 'package_materials');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `package_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Package Qualification Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `osat_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Osat Vendor Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Packaging Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `package_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `reliability_test_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `sku_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `supplier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `tertiary_package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Package Type Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Fab Tool Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (COMPLIANCE_FLG)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency (CURRENCY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CAD');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `defect_rate_ppm` SET TAGS ('dbx_business_glossary_term' = 'Defect Rate (PPM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `external_audit_date` SET TAGS ('dbx_business_glossary_term' = 'External Audit Date (EXT_AUDIT_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `external_audit_required` SET TAGS ('dbx_business_glossary_term' = 'External Audit Required (EXT_AUDIT_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `pass_fail_criteria` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Criteria (PASS_FAIL_CRIT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Qualification Cost (USD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_document_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Document Identifier (DOC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_method` SET TAGS ('dbx_business_glossary_term' = 'Qualification Method (QUAL_METHOD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_method` SET TAGS ('dbx_value_regex' = 'accelerated|full_life|simulation');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_owner` SET TAGS ('dbx_business_glossary_term' = 'Qualification Owner (OWNER)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_result` SET TAGS ('dbx_business_glossary_term' = 'Qualification Result (RESULT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_standard` SET TAGS ('dbx_business_glossary_term' = 'Qualification Standard (QUAL_STD)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_standard` SET TAGS ('dbx_value_regex' = 'JEDEC_JESD47|AEC_Q100|AEC_Q101|MIL_STD_883|CUSTOM');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QUAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|approved|rejected|withdrawn');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type (QUAL_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'new_package|package_product_combination|osat_site');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `regulatory_compliance` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance (REG_COMP)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `regulatory_compliance` SET TAGS ('dbx_value_regex' = 'JEDEC|AEC|MIL|CUSTOM');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number (REV_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK_LVL)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `sample_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity (SAMPLE_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `stress_test_matrix` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Matrix (STRESS_MATRIX)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `stress_test_matrix` SET TAGS ('dbx_value_regex' = 'HTOL|TC|HAST|ESD|Latch_Up|Thermal_Cycling');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `test_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Hours)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location (TEST_LOC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Qualification Version (VERSION)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`package_qualification` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage (YIELD_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` SET TAGS ('dbx_subdomain' = 'package_materials');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `material_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Material Lot Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `substrate_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Material Substrate Bom Id');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (SUPP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `certificate_of_conformance_ref` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Conformance Reference (COC_REF)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Reference (COMP_DOC_REF)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_itar_status` SET TAGS ('dbx_business_glossary_term' = 'ITAR Compliance Status (ITAR_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_itar_status` SET TAGS ('dbx_value_regex' = 'approved|restricted|denied');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_reach_status` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliance Status (REACH_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_reach_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_rohs_status` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Status (ROHS_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `compliance_rohs_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit (CPU)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `humidity_storage_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity (HUMID_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `incoming_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Incoming Inspection Status (INSP_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `incoming_inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `inspection_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Inspection Failure Reason (INSP_FAIL_RSN)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `inspection_passed` SET TAGS ('dbx_business_glossary_term' = 'Inspection Passed Flag (INSP_PASS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description (MAT_DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `material_lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status (LOT_STS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `material_lot_status` SET TAGS ('dbx_value_regex' = 'received|inspected|released|quarantined|consumed|expired');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type (MAT_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score (QUAL_SCR)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received (QTY_RCV)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag (QUAR_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp (RCV_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date (REL_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `shelf_life_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiry Date (EXP_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition (STOR_COND)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `supplier_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Number (SUPP_LOT_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `temperature_storage_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (TEMP_C)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`packaging`.`material_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'pieces|kg|g|ml');
