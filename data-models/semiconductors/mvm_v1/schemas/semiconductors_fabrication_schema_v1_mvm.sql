-- Schema for Domain: fabrication | Business: Semiconductors | Version: v1_mvm
-- Generated on: 2026-05-06 20:34:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `semiconductors_ecm`.`fabrication` COMMENT 'Core wafer fabrication and processing domain governing all FAB operations including FEOL, MOL, and BEOL process steps. Owns wafer lot tracking, WIP management, process recipe execution, and fab line scheduling across CVD, PVD, ALD, CMP, ion implantation, and EUV/DUV lithography operations. Authoritative source for wafer genealogy and lot disposition via MES integration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` (
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Unique identifier for the wafer lot tracked through the FAB from wafer start to lot disposition. Primary key for all WIP lot tracking across FEOL, MOL, and BEOL operations.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Required for lot‑level billing and customer account reporting; each wafer lot is charged to a specific customer account.',
    `customer_design_registration_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_registration. Business justification: Prototype and qualification wafer lots are initiated from customer design registrations. Direct FK supports qualification lot traceability, NRE project cost tracking, and production ramp planning from',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Export control screening: every wafer lot destined for export must carry an ECCN classification to determine license requirements. Semiconductor export compliance teams require lot-level ECCN linkage ',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: fabrication_wafer_lot tracks which fab facility is processing the lot via a denormalized string code (fab_facility_code). Adding a proper FK to fab_facility normalizes this relationship, enabling refe',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Lot-level yield and process qualification reporting requires knowing which engineering process flow the lot ran against. Fab lots run against a fabrication_process_flow instance, but the engineering p',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Fabless/fab-lite semiconductor companies outsource wafer fabrication to foundry suppliers (TSMC, Samsung, GlobalFoundries). Tracking which foundry supplier produced each wafer lot is essential for sup',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Required for Production Planning Report linking each wafer lot to the specific IC catalog item being manufactured.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Required for lot‑level cost and yield reporting per design project, enabling profitability analysis and project KPI dashboards.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Semiconductor fabs charge NRE, qualification, and engineering wafer lots to SAP internal orders for cost segregation from production. This is a standard fab cost accounting practice enabling lot-level',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Each wafer lot fulfills a specific order line (quantity, SKU, delivery date). Fab planning and order fulfillment teams use this link for line-level delivery commitment tracking, on-time delivery repor',
    `mpw_order_id` BIGINT COMMENT 'Foreign key linking to order.mpw_order. Business justification: An MPW wafer lot is produced to fulfill an mpw_order. Linking enables MPW order fulfillment tracking — fab teams report lot status against the mpw_order for customer delivery updates, die quantity con',
    `mpw_shuttle_id` BIGINT COMMENT 'Foreign key linking to design.mpw_shuttle. Business justification: A wafer lot may be part of an MPW shuttle run. Direct lot-to-shuttle traceability is needed for shuttle cost allocation across participants, die release scheduling, and customer delivery management. w',
    `parent_lot_fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the parent lot from which this lot was split or derived. Null for original lots. Enables wafer genealogy tracking and traceability.',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: A wafer lot is fabricated from a specific physical layout (GDS) version. Lot-level traceability to the exact layout revision is required for silicon debug, ECO impact analysis, and yield-to-layout cor',
    `process_flow_id` BIGINT COMMENT 'Unique identifier for the process route (recipe sequence) assigned to this lot. Defines the complete sequence of operations from wafer start to completion.',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: Lot-level process node traceability for yield analysis and customer reporting requires the engineering process_technology_node reference. fabrication_technology_node is the fab execution node; process',
    `product_qualification_program_id` BIGINT COMMENT 'Foreign key linking to product.product_qualification_program. Business justification: Qualification lots in the fab are tracked against a product qualification program for AEC-Q, JEDEC, or customer-specific qualification. Fab yield and lot disposition data feed directly into qualificat',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Required for Material Traceability Report linking each wafer lot to the purchase order of raw silicon, enabling cost accounting and regulatory compliance.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: A wafer lot is produced against a specific tapeout authorization. Foundry yield reporting to customers, tapeout-to-silicon cycle time metrics, and customer delivery commitments all require direct wafe',
    `wafer_start_authorization_id` BIGINT COMMENT 'Foreign key linking to order.wafer_start_authorization. Business justification: Fab execution traceability: each wafer lot is produced under a formal wafer start authorization (WSA). Fab operations and order management teams track lot-to-WSA linkage for production authorization c',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Customer-specific and program wafer lots are tracked against WBS elements for project cost accounting and program P&L reporting. Semiconductor fabs require lot-to-WBS traceability for customer billing',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the lot completed all FAB processing operations and was dispositioned. Null for lots still in WIP.',
    `current_operation_name` STRING COMMENT 'Descriptive name of the current process operation (e.g., CVD_OXIDE_DEP, EUV_LITHO, CMP_POLISH). Provides human-readable context for lot location.',
    `current_operation_number` STRING COMMENT 'Sequential operation step number in the process route where the lot is currently located. Used for tracking lot position in the manufacturing flow.. Valid values are `^[0-9]{4,6}$`',
    `current_process_area` STRING COMMENT 'High-level FAB area classification where the lot is currently located: FEOL (front-end-of-line transistor formation), MOL (middle-of-line contacts), BEOL (back-end-of-line interconnect), metrology (inspection), or test (electrical probe).. Valid values are `feol|mol|beol|metrology|test`',
    `cycle_time_days` DECIMAL(18,2) COMMENT 'Total elapsed time in days from wafer start to lot completion. Key performance metric for manufacturing efficiency and customer responsiveness.',
    `due_date` DATE COMMENT 'Target completion date for the lot to meet customer delivery commitments. Used for scheduling and on-time-delivery tracking.',
    `hold_flag` BOOLEAN COMMENT 'Indicates whether the lot is currently on hold and prevented from processing. True when lot is held for quality, engineering, or disposition review.',
    `hold_reason_code` STRING COMMENT 'Standardized code indicating the reason for lot hold (e.g., QUAL_FAIL, ENG_REVIEW, EQUIP_DOWN, MATL_ISSUE). Null when hold_flag is false.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `hold_timestamp` TIMESTAMP COMMENT 'Date and time when the lot was placed on hold. Used to calculate hold duration and impact on cycle time. Null when lot is not on hold.',
    `initial_wafer_count` STRING COMMENT 'Original number of wafers when the lot was started. Used to calculate yield loss and scrap rate during processing.',
    `is_hot_lot` BOOLEAN COMMENT 'Indicates whether this lot is designated as a hot lot requiring expedited processing and priority resource allocation. True for urgent customer orders.',
    `lot_created_timestamp` TIMESTAMP COMMENT 'Date and time when the lot record was first created in the MES system. May precede wafer start for planning purposes.',
    `lot_disposition` STRING COMMENT 'Final disposition decision for the completed lot: pass (released to next stage), fail (rejected), partial (some wafers pass), rework (reprocess), scrap (discard), or engineering_hold (pending review).. Valid values are `pass|fail|partial|rework|scrap|engineering_hold`',
    `lot_notes` STRING COMMENT 'Free-text field for operators and engineers to record important observations, special handling instructions, or process deviations for this lot.',
    `lot_number` STRING COMMENT 'Externally-known unique business identifier for the wafer lot assigned by MES at wafer start. Used for tracking and traceability across all FAB operations and external communications.. Valid values are `^[A-Z0-9]{8,16}$`',
    `lot_on_node` BIGINT COMMENT 'FK to fabrication.technology_node.technology_node_id — Every lot is manufactured on a specific technology node. This is fundamental for WIP classification and routing.',
    `lot_type` STRING COMMENT 'Classification of the wafer lot purpose: production (revenue-generating), engineering (process development), qualification (product validation), MPW (multi-project wafer shuttle), pilot (pre-production), or rework (reprocessed lot).. Valid values are `production|engineering|qualification|mpw|pilot|rework`',
    `lot_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the lot record was last modified in the MES system. Tracks most recent status or attribute change.',
    `mes_system_source` STRING COMMENT 'Identifies the source MES system that created and manages this lot record: Camstar MES, Applied Materials SmartFactory MES, or other. Used for data lineage and system integration.. Valid values are `camstar|smartfactory|other`',
    `planned_completion_date` DATE COMMENT 'Forecasted completion date based on current WIP position, remaining operations, and standard cycle times. Updated dynamically as lot progresses.',
    `priority_class` STRING COMMENT 'Scheduling priority assigned to the lot for FAB resource allocation. Hot and expedite lots receive preferential processing to meet urgent customer commitments.. Valid values are `hot|expedite|normal|engineering|low`',
    `process_node_nm` STRING COMMENT 'Technology node of the semiconductor process measured in nanometers (e.g., 7nm, 5nm, 3nm). Defines the minimum feature size and process complexity.',
    `process_time_hours` DECIMAL(18,2) COMMENT 'Cumulative time in hours the lot has spent in active processing on equipment. Excludes queue and hold time. Used for capacity planning.',
    `queue_time_hours` DECIMAL(18,2) COMMENT 'Cumulative time in hours the lot has spent waiting in queue between operations. Excludes active processing time. Used to identify bottlenecks.',
    `rework_count` STRING COMMENT 'Number of times the lot has been reworked or reprocessed through specific operations. Tracks process stability and quality issues.',
    `route_version` STRING COMMENT 'Version number of the process route. Tracks recipe changes and process improvements over time for traceability and yield analysis.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `sampling_plan_code` STRING COMMENT 'Code identifying the quality sampling and inspection plan applied to this lot. Defines which wafers are sampled and at which operations for metrology and defect inspection.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `scrap_wafer_count` STRING COMMENT 'Total number of wafers scrapped during processing due to defects, breakage, or sampling. Used to calculate yield loss and process capability.',
    `split_sequence_number` STRING COMMENT 'Sequential number assigned when a lot is split into multiple child lots. Used with parent_lot_id to track lot genealogy and wafer provenance.',
    `wafer_count` STRING COMMENT 'Current number of wafers in the lot. May decrease due to scraps, breakage, or sampling during processing. Initial count typically 25 wafers per lot for standard production.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the silicon wafers in the lot measured in millimeters. Standard sizes include 200mm (8-inch) and 300mm (12-inch).',
    `wafer_start_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer lot was officially started in the FAB and entered WIP tracking. Represents the beginning of the lots manufacturing lifecycle.',
    `wip_status` STRING COMMENT 'Current lifecycle status of the wafer lot in the FAB workflow. Tracks lot progression from queue through processing to final disposition.. Valid values are `queued|in_process|on_hold|completed|scrapped|shipped`',
    CONSTRAINT pk_fabrication_wafer_lot PRIMARY KEY(`fabrication_wafer_lot_id`)
) COMMENT 'Core master entity representing a wafer lot (batch of wafers) tracked through the FAB from wafer start to lot disposition. Authoritative source for lot identity, wafer count, lot type (production, engineering, qualification, MPW), process node, technology node, product code, priority class, WIP status, hold flags, and genealogy linkage. Sourced from Camstar MES and Applied Materials SmartFactory MES. SSOT for all WIP lot tracking across FEOL, MOL, and BEOL operations. Quality and metrology data for this lot is owned by the quality domain and referenced via cross-domain FK.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`wafer` (
    `wafer_id` BIGINT COMMENT 'Unique identifier for the individual silicon wafer within the fabrication facility. Primary key for wafer tracking across all FAB (Fabrication Facility) process steps.',
    `account_id` BIGINT COMMENT 'Reference to the customer who ordered this wafer fabrication. Relevant for foundry operations and MPW (Multi-Project Wafer) services.',
    `fab_facility_id` BIGINT COMMENT 'Reference to the fabrication facility where this wafer is being processed. Supports multi-site operations and capacity planning.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the parent wafer lot that this wafer belongs to. Wafers are processed in lots through the FAB (Fabrication Facility).',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Needed for Yield Analysis linking each wafer to its IC product for defect tracking.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the IC (Integrated Circuit) design project that this wafer is fabricating. Links to design specifications, GDS (Graphic Data System) files, and tapeout records.',
    `mask_set_id` BIGINT COMMENT 'Reference to the photomask set used for lithography steps on this wafer. Each mask set corresponds to a specific design and technology node.',
    `process_flow_id` BIGINT COMMENT 'Reference to the process route or recipe that defines the sequence of fabrication steps for this wafer. Routes vary by product technology node and design.',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: Wafer-level process node traceability for defect analysis and yield reporting requires the engineering process_technology_node reference. Semiconductor yield engineers correlate wafer defect data to t',
    `belongs_to_lot` BIGINT COMMENT 'FK to fabrication.fabrication_wafer_lot.fabrication_wafer_lot_id — Every wafer must reference its parent lot. This is the most fundamental relationship in FAB WIP tracking - wafers are always tracked within the context of their lot.',
    `completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the wafer completed all FAB (Fabrication Facility) process steps and is ready for wafer probing or shipment to OSAT (Outsourced Semiconductor Assembly and Test). Null for in-process wafers.',
    `critical_defect_count` STRING COMMENT 'Number of critical defects that are likely to cause die failure. Subset of total defect count, used for yield prediction and SPC (Statistical Process Control).',
    `crystal_orientation` STRING COMMENT 'Crystallographic orientation of the silicon wafer surface, specified using Miller indices. <100> is most common for CMOS (Complementary Metal-Oxide-Semiconductor) fabrication.. Valid values are `100|110|111`',
    `current_operation_number` STRING COMMENT 'Sequential operation number in the process route that the wafer is currently at. Used for tracking progress through the hundreds of steps in IC (Integrated Circuit) fabrication.',
    `current_process_step` STRING COMMENT 'Name or code of the current fabrication process step the wafer is at or has completed. Examples: lithography, CVD (Chemical Vapor Deposition), CMP (Chemical Mechanical Planarization), ion implantation.',
    `defect_count` STRING COMMENT 'Total number of defects detected on the wafer surface through inspection systems. Tracked across process steps to monitor yield and process control.',
    `diameter_mm` STRING COMMENT 'Diameter of the wafer in millimeters. Standard sizes include 150mm (6 inch), 200mm (8 inch), and 300mm (12 inch). Larger diameters enable more dies per wafer.',
    `disposition_status` STRING COMMENT 'Current disposition status of the wafer in the FAB (Fabrication Facility) workflow. Tracks lifecycle state from WIP (Work in Process) through completion or scrap.. Valid values are `in_process|completed|scrapped|quarantined|on_hold|awaiting_inspection`',
    `doping_type` STRING COMMENT 'Electrical doping type of the substrate. P-type (boron-doped) or N-type (phosphorus/arsenic-doped) determines the majority carrier type. Intrinsic wafers are undoped.. Valid values are `p_type|n_type|intrinsic`',
    `epitaxial_layer_flag` BOOLEAN COMMENT 'Indicates whether the wafer has an epitaxial layer grown on the substrate. Epitaxial wafers have a thin crystalline layer with controlled properties for advanced device fabrication.',
    `epitaxial_resistivity_ohm_cm` DECIMAL(18,2) COMMENT 'Electrical resistivity of the epitaxial layer in ohm-centimeters, if present. Null for non-epitaxial wafers. Often differs from substrate resistivity.',
    `epitaxial_thickness_um` DECIMAL(18,2) COMMENT 'Thickness of the epitaxial layer in micrometers, if present. Null for non-epitaxial wafers. Typical range: 1-20 micrometers.',
    `expected_die_count` STRING COMMENT 'Expected number of dies (individual chips) on this wafer based on die size and wafer diameter. Used for yield calculation and planning.',
    `genealogy_path` STRING COMMENT 'Hierarchical path tracking the wafer lineage from ingot to lot to wafer. Enables traceability for quality investigations and compliance. Format varies by MES (Manufacturing Execution System).',
    `good_die_count` STRING COMMENT 'Actual number of dies that passed electrical testing and quality inspection. Populated after wafer probing and testing. Used to calculate wafer yield.',
    `hold_reason_code` STRING COMMENT 'Code indicating the reason for wafer hold or quarantine, if applicable. Examples: out-of-spec measurement, equipment issue, quality investigation. Null for non-held wafers.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent defect inspection or metrology measurement performed on this wafer. Null if no inspection has been performed yet.',
    `last_process_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent process step or operation performed on this wafer. Used for WIP (Work in Process) tracking and cycle time analysis.',
    `notch_orientation_degrees` STRING COMMENT 'Angular position of the wafer notch in degrees, used for wafer alignment and orientation during automated processing. Standard is 0 degrees for <110> direction.',
    `priority_level` STRING COMMENT 'Processing priority level for this wafer. Critical and high priority wafers receive expedited processing to meet customer commitments or TTM (Time to Market) requirements.. Valid values are `critical|high|normal|low`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this wafer record was first created in the data system. Audit field for data lineage and compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this wafer record was last updated in the data system. Audit field for data lineage and change tracking.',
    `resistivity_ohm_cm` DECIMAL(18,2) COMMENT 'Electrical resistivity of the wafer substrate in ohm-centimeters. Indicates doping concentration and electrical properties. Typical range: 0.001 to 100+ ohm-cm.',
    `rework_count` STRING COMMENT 'Number of times this wafer has been reworked or reprocessed due to process excursions or quality issues. Tracked for yield analysis and process improvement.',
    `scrap_reason_code` STRING COMMENT 'Code indicating the reason for wafer scrap, if applicable. Examples: excessive defects, process excursion, handling damage, contamination. Null for non-scrapped wafers.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `slot_position` STRING COMMENT 'Physical slot position of the wafer within the carrier or cassette during processing. Used for tracking and automation.',
    `source_system` STRING COMMENT 'Identifier of the source MES (Manufacturing Execution System) or tracking system that created this wafer record. Typically Camstar MES for wafer tracking.. Valid values are `^[A-Z0-9_]{1,30}$`',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the wafer entered the FAB (Fabrication Facility) and began processing. Marks the beginning of the wafer lifecycle for cycle time tracking.',
    `substrate_type` STRING COMMENT 'Material composition of the wafer substrate. Silicon is most common, but compound semiconductors like GaAs (Gallium Arsenide), SiC (Silicon Carbide), and GaN (Gallium Nitride) are used for specialized applications.. Valid values are `silicon|gallium_arsenide|silicon_carbide|gallium_nitride|sapphire|germanium`',
    `thickness_um` DECIMAL(18,2) COMMENT 'Thickness of the wafer in micrometers. Typical range is 500-800 micrometers depending on diameter and application. Critical for mechanical stability and process control.',
    `wafer_number` STRING COMMENT 'Business identifier for the wafer within its lot. Typically a sequential number or alphanumeric code assigned during lot creation.. Valid values are `^[A-Z0-9]{1,20}$`',
    CONSTRAINT pk_wafer PRIMARY KEY(`wafer_id`)
) COMMENT 'Individual silicon wafer entity within a lot, tracking wafer number, substrate type, diameter, orientation, resistivity, epitaxial layer specs, and current disposition. Enables per-wafer genealogy and yield tracking across all FAB process steps. Sourced from Camstar MES wafer tracking module.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` (
    `fabrication_process_recipe_id` BIGINT COMMENT 'Unique identifier for the fabrication process recipe. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Process recipes are owned by specific fab modules (etch, CVD, litho) that map to cost centers. Recipe qualification and maintenance costs are charged to the owning cost center. Required for process en',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Advanced-node process recipes are themselves EAR/ITAR-controlled technology. The recipe has itar_controlled_flag confirming export control relevance. ECCN classification governs recipe sharing, foreig',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Recipe qualification and change‑control require explicit reference to the PDK version the recipe supports, ensuring process compatibility.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Process recipes are qualified per technology node — process engineers query which recipes are qualified for this node? for yield improvement and equipment qualification. product.process_node is the ',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: Recipe qualification and requalification tracking require the engineering process technology node reference. Semiconductor process engineers use this link to identify all recipes requiring requalifica',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Process recipe qualification and change control require traceability to the governing quality spec. The recipes defect_density_target_per_cm2 and yield_target_percent are governed by quality_spec acc',
    `rule_set_id` BIGINT COMMENT 'Foreign key linking to design.rule_set. Business justification: Process recipe qualification and change control require compliance with the foundry DRC/LVS rule set for the target technology node. Recipe approval workflows reference the specific rule set version. ',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: Recipe qualification and change control require tracing which engineering process step the fabrication recipe implements. Semiconductor process engineers use this link for recipe-to-step qualification',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Process recipes specify target materials (process gases, chemicals, slurries, films) that must be procured and stocked. Linking recipe to material_master enables MRP-driven procurement planning based ',
    `test_plan_id` BIGINT COMMENT 'Foreign key linking to quality.test_plan. Business justification: Recipe qualification requires an associated test plan to validate the recipe meets process targets before production release. In semiconductor fabs, recipe qualification programs explicitly reference ',
    `approval_date` DATE COMMENT 'Date when the recipe was formally approved for production use.',
    `approval_status` STRING COMMENT 'Engineering approval status indicating whether the recipe has been reviewed and authorized for use by process engineering and quality teams.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the process engineer or quality manager who approved this recipe for production use.',
    `chamber_configuration` STRING COMMENT 'Specific chamber or module configuration within the equipment where the recipe is executed, enabling multi-chamber tool recipe management.',
    `change_control_reference` STRING COMMENT 'Reference to the Engineering Change Order (ECO) or Product Change Notification (PCN) that authorized the creation or modification of this recipe.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipe record was first created in the MES system.',
    `defect_density_target_per_cm2` DECIMAL(18,2) COMMENT 'Target defect density in defects per square centimeter for wafers processed with this recipe, critical for yield management.',
    `effective_end_date` DATE COMMENT 'Date when this recipe version is superseded or retired. Null indicates the recipe is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this recipe version becomes effective and available for production use.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this recipe complies with environmental regulations including RoHS, REACH, and TSCA for chemical usage and emissions.',
    `equipment_type` STRING COMMENT 'Type or model of fabrication equipment (tool) for which this recipe is designed, such as Applied Materials Centura, Lam Research Flex, or ASML NXT scanner.',
    `fmea_reference` STRING COMMENT 'Reference to the Failure Mode and Effects Analysis (FMEA) document that identifies potential failure modes and mitigation strategies for this recipe.',
    `gas_flow_parameters` STRING COMMENT 'Detailed gas flow settings including gas types, flow rates (sccm), and ratios for CVD, PVD, ALD, and etch processes. Stored as structured text or JSON.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this recipe is subject to International Traffic in Arms Regulations (ITAR) export control restrictions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipe record was last modified, supporting change tracking and audit requirements.',
    `power_settings_watts` DECIMAL(18,2) COMMENT 'RF or DC power settings in watts for plasma-based processes such as PVD, etch, and plasma-enhanced CVD.',
    `process_duration_seconds` STRING COMMENT 'Total duration in seconds for the recipe execution from start to completion.',
    `process_layer_type` STRING COMMENT 'Fabrication layer classification: Front End of Line (FEOL) for transistor formation, Middle of Line (MOL) for contacts, or Back End of Line (BEOL) for interconnects.. Valid values are `FEOL|MOL|BEOL`',
    `process_operation_type` STRING COMMENT 'Type of FAB operation this recipe defines: Chemical Vapor Deposition (CVD), Physical Vapor Deposition (PVD), Atomic Layer Deposition (ALD), Chemical Mechanical Planarization (CMP), etch, lithography (EUV/DUV), ion implantation, diffusion, oxidation, annealing, or cleaning. [ENUM-REF-CANDIDATE: CVD|PVD|ALD|CMP|etch|lithography|ion_implantation|diffusion|oxidation|annealing|cleaning — 11 candidates stripped; promote to reference product]',
    `process_pressure_torr` DECIMAL(18,2) COMMENT 'Target chamber pressure in Torr for the recipe execution, critical for CVD, PVD, and ALD processes.',
    `process_temperature_celsius` DECIMAL(18,2) COMMENT 'Target process temperature in degrees Celsius for the recipe execution.',
    `product_family` STRING COMMENT 'Product family or IC design family for which this recipe is optimized (e.g., mobile processors, automotive chips, AI accelerators).',
    `qualification_date` DATE COMMENT 'Date when the recipe successfully completed qualification testing and was certified for production.',
    `qualification_status` STRING COMMENT 'Qualification state indicating whether the recipe has passed validation testing and is certified for production use.. Valid values are `not_qualified|in_qualification|qualified|requalification_required`',
    `recipe_code` STRING COMMENT 'Unique alphanumeric code assigned to the recipe for system identification and traceability across MES and ERP systems.',
    `recipe_description` STRING COMMENT 'Detailed textual description of the recipes purpose, process objectives, and special considerations for operators and engineers.',
    `recipe_name` STRING COMMENT 'Human-readable name of the process recipe used for identification and reference by FAB operators and process engineers.',
    `recipe_status` STRING COMMENT 'Current lifecycle status of the recipe: draft (under development), under_review (pending approval), approved (validated but not yet active), active (in production use), suspended (temporarily disabled), or obsolete (retired).. Valid values are `draft|under_review|approved|active|suspended|obsolete`',
    `recipe_version` STRING COMMENT 'Version identifier for the recipe enabling change control and traceability of recipe evolution over time.',
    `requalification_due_date` DATE COMMENT 'Date by which the recipe must be requalified to remain in active production status, per quality management requirements.',
    `safety_classification` STRING COMMENT 'Safety classification indicating special handling requirements: standard, hazardous_material, high_temperature, high_pressure, or toxic_gas.. Valid values are `standard|hazardous_material|high_temperature|high_pressure|toxic_gas`',
    `source_system` STRING COMMENT 'Source system from which this recipe was ingested, typically Applied Materials SmartFactory MES or Camstar MES.',
    `spc_control_plan_reference` STRING COMMENT 'Reference to the Statistical Process Control (SPC) plan that monitors this recipes performance and detects process drift.',
    `step_sequence_definition` STRING COMMENT 'Ordered sequence of process steps within the recipe, including step names, durations, and parameter transitions. Stored as structured text or JSON.',
    `target_thickness_nm` DECIMAL(18,2) COMMENT 'Target thickness in nanometers for deposition or remaining thickness after etch/CMP operations.',
    `uniformity_target_percent` DECIMAL(18,2) COMMENT 'Target uniformity percentage for thickness, composition, or other critical parameters across the wafer surface.',
    `yield_target_percent` DECIMAL(18,2) COMMENT 'Target yield percentage for wafers processed using this recipe, used for performance monitoring and continuous improvement.',
    CONSTRAINT pk_fabrication_process_recipe PRIMARY KEY(`fabrication_process_recipe_id`)
) COMMENT 'Master record for a validated process recipe defining the exact sequence of process parameters, tool settings, gas flows, temperatures, pressures, and timing for a specific FAB operation (CVD, PVD, ALD, CMP, implant, etch, lithography). Includes recipe version history, approval status, change control reference, qualification status, and effective date range. Versioning managed within this entity via version number and effective dates. Sourced from Applied Materials SmartFactory MES recipe management and integrated with engineering change order workflow.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`process_step` (
    `process_step_id` BIGINT COMMENT 'Unique identifier for the process step within the FAB routing. Primary key for the process step entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each process step has a step_cost_per_wafer and belongs to a cost center for standard cost roll-up. The existing plain cost_center attribute is a denormalization of the cost_center entity. Required fo',
    `fabrication_process_recipe_id` BIGINT COMMENT 'Reference to the target process recipe that defines the detailed parameters, settings, and control logic for executing this step on the equipment.',
    `process_flow_id` BIGINT COMMENT 'Reference to the parent process flow routing that contains this step. Links the step to its overall manufacturing route.',
    `process_rework_target_step_id` BIGINT COMMENT 'Reference to the target process step to which lots are routed when rework is triggered from this step. Null if no rework loop exists.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: Step-level change control and SPC setup require knowing which engineering process step a fabrication step implements. Semiconductor process engineers use this link to propagate engineering step change',
    `test_plan_id` BIGINT COMMENT 'Foreign key linking to quality.test_plan. Business justification: Each process step has an associated test plan for in-line quality monitoring and inspection. The inspection_required_flag and sampling_rate_percent on fabrication_process_step are governed by the test',
    `tool_qualification_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_qualification. Business justification: Each process step requires certified qualified tools before production dispatch. MES dispatching rules, IATF 16949 compliance audits, and new tool introduction (NTI) protocols all depend on knowing wh',
    `approval_date` DATE COMMENT 'Date when the process step was approved for production use. Used for change control and audit trails.',
    `approval_status` STRING COMMENT 'Approval workflow status for the process step definition. Tracks engineering change control and qualification approval.. Valid values are `draft|submitted|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the engineer or manager who approved this process step for production use. Used for traceability and accountability.',
    `batch_size` STRING COMMENT 'Number of wafers or lots that can be processed together in a single batch at this step. Null for single-wafer processing steps.',
    `change_control_number` STRING COMMENT 'Engineering change order or change control number associated with the creation or modification of this process step. Links to formal change management process.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process step record was first created in the system. Used for audit trails and data lineage.',
    `critical_step_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this step is critical to product quality or yield. Critical steps require enhanced monitoring, control, and approval workflows.',
    `effective_end_date` DATE COMMENT 'Date when this process step definition is retired or superseded. Null for currently active steps. Supports historical tracking and version control.',
    `effective_start_date` DATE COMMENT 'Date when this process step definition becomes effective and can be used in production routing. Supports time-based version control.',
    `equipment_class` STRING COMMENT 'Constraint specifying the class or type of equipment required to execute this process step. Used by MES for equipment qualification and dispatching.',
    `inspection_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether inline inspection or metrology is required after this step. True if inspection is mandatory before proceeding to the next step.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this process step record. Used for accountability and audit trails.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this process step record was last modified. Used for change tracking and audit trails.',
    `max_queue_time_minutes` DECIMAL(18,2) COMMENT 'Maximum allowable queue time in minutes before the step must be processed or the lot is flagged for hold. Critical for time-sensitive processes.',
    `min_batch_size` STRING COMMENT 'Minimum number of wafers or lots required to start processing at this step. Used for batch tool optimization and scheduling.',
    `operation_type` STRING COMMENT 'High-level classification of the process step into Front End of Line (FEOL), Middle of Line (MOL), or Back End of Line (BEOL) manufacturing phases.. Valid values are `FEOL|MOL|BEOL`',
    `process_category` STRING COMMENT 'Detailed classification of the process step by operation category such as lithography, etch, deposition (CVD/PVD/ALD), Chemical Mechanical Planarization (CMP), ion implant, thermal anneal, clean, wet clean, inspection, or metrology. [ENUM-REF-CANDIDATE: lithography|etch|deposition|CMP|implant|anneal|clean|wet_clean|inspection|metrology — 10 candidates stripped; promote to reference product]',
    `process_subcategory` STRING COMMENT 'Granular subcategory within the process category, such as EUV lithography, DUV lithography, plasma etch, reactive ion etch, CVD, PVD, ALD, etc. Provides detailed process technology classification.',
    `rework_loop_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this step is part of a rework loop. True if the step can route back to an earlier step for defect correction or reprocessing.',
    `sampling_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of lots or wafers that must be sampled for inspection or metrology at this step. Used for statistical quality control.',
    `skip_allowed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this step can be skipped under certain conditions (e.g., engineering wafers, test lots). True if skip is permitted.',
    `standard_queue_time_minutes` DECIMAL(18,2) COMMENT 'Expected queue time in minutes before the step begins processing. Used for scheduling and WIP prediction.',
    `step_cost_per_wafer` DECIMAL(18,2) COMMENT 'Standard cost per wafer for executing this process step. Used for product costing, yield analysis, and financial planning. Business-confidential financial data.',
    `step_description` STRING COMMENT 'Detailed textual description of the process step, including purpose, key parameters, and special handling instructions for operators and engineers.',
    `step_sequence_number` STRING COMMENT 'Sequential ordering of this step within the process flow routing. Determines the execution order of operations in the FAB.',
    `step_status` STRING COMMENT 'Current lifecycle status of the process step definition. Active steps are in production use; inactive or obsolete steps are retired; engineering steps are under development; pending approval steps await qualification.. Valid values are `active|inactive|engineering|obsolete|pending_approval`',
    `target_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Step-level target cycle time in minutes. Used for capacity planning, scheduling, and WIP flow optimization.',
    `version_number` STRING COMMENT 'Version identifier for the process step definition. Incremented with each engineering change. Supports change control and traceability.',
    CONSTRAINT pk_process_step PRIMARY KEY(`process_step_id`)
) COMMENT 'Individual process step definition within a process flow routing, specifying step sequence number, operation type (FEOL/MOL/BEOL), process category (lithography, etch, deposition, CMP, implant, anneal, clean, wet clean), target recipe reference, equipment class constraint, SPC control plan linkage, rework loop indicators, and step-level cycle time targets. Forms the authoritative step catalog for all FAB routing and is the granular unit of WIP tracking. Aligned with SEMI E40 process management standard for step-level definition.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`process_flow` (
    `process_flow_id` BIGINT COMMENT 'Unique identifier for the process flow. Primary key for the process flow entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: fabrication_process_flow has an is_customer_specific flag, indicating some flows are customer-owned IP. Direct account FK identifies the owning customer for IP protection, NDA compliance enforcement, ',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: fabrication_process_flow has a fab_facility_code STRING column indicating which facility this process flow is qualified for. Normalizing to a proper FK to fab_facility establishes referential integrit',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: The fabrication process flow implements a specific engineering process flow. This link is fundamental for process change management — when process.process_flow is revised, all fabrication_process_flow',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: A fabrication process flow is defined for a specific technology node — NPI planning, capacity allocation, and yield benchmarking all require linking flows to the canonical product.process_node. techno',
    `rule_set_id` BIGINT COMMENT 'Reference to the design rule set (DRC/LVS rules) that physical layouts must comply with for this process flow.',
    `approval_date` DATE COMMENT 'Date when this process flow received formal approval for use in FAB operations.',
    `approved_by` STRING COMMENT 'Name or identifier of the process engineer or manager who approved this process flow for production use.',
    `beol_step_count` STRING COMMENT 'Number of process steps in the Back End Of Line (BEOL) phase covering metal interconnect layers and passivation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process flow record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this process flow is no longer valid for new wafer lot starts. Nullable for flows with indefinite validity.',
    `effective_start_date` DATE COMMENT 'Date when this process flow becomes valid and available for wafer lot routing and WIP scheduling.',
    `environmental_classification` STRING COMMENT 'Environmental and chemical safety classification for materials and processes used in this flow (e.g., RoHS compliant, REACH registered).',
    `estimated_cycle_time_days` DECIMAL(18,2) COMMENT 'Estimated total manufacturing cycle time in days for a wafer lot to complete this entire process flow under normal conditions.',
    `export_control_classification` STRING COMMENT 'Export control classification number (ECCN) or ITAR designation governing international transfer and use of this process technology.',
    `fabrication_process_flow_description` STRING COMMENT 'Detailed textual description of the process flow including its purpose, key characteristics, and intended applications.',
    `feol_step_count` STRING COMMENT 'Number of process steps in the Front End Of Line (FEOL) phase covering transistor formation and active device fabrication.',
    `flow_revision` STRING COMMENT 'Revision identifier tracking version changes to the process flow definition.',
    `flow_status` STRING COMMENT 'Current lifecycle status of the process flow indicating its approval and usage state in FAB operations.. Valid values are `draft|under_review|approved|active|frozen|obsolete`',
    `flow_type` STRING COMMENT 'Classification of the process flow indicating its purpose: standard production, Multi-Project Wafer (MPW), engineering evaluation, qualification, or research and development (R&D).. Valid values are `standard|mpw|engineering|qualification|rnd`',
    `is_customer_specific` BOOLEAN COMMENT 'Boolean flag indicating whether this process flow is customized for a specific customer or represents a standard foundry offering.',
    `last_modified_by` STRING COMMENT 'Name or identifier of the user who last modified this process flow record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this process flow record was last updated or modified.',
    `lithography_technology` STRING COMMENT 'Primary lithography technology used in critical patterning steps: EUV (Extreme Ultraviolet), DUV (Deep Ultraviolet), immersion, or dry lithography.. Valid values are `euv|duv|immersion|dry`',
    `metal_layer_count` STRING COMMENT 'Total number of metal interconnect layers defined in the BEOL portion of this process flow.',
    `mol_step_count` STRING COMMENT 'Number of process steps in the Middle Of Line (MOL) phase covering contact formation and local interconnect.',
    `qualification_completion_date` DATE COMMENT 'Date when the process flow successfully completed qualification testing and was certified for production use.',
    `qualification_status` STRING COMMENT 'Status of the process flow qualification indicating whether it has passed reliability and performance validation testing.. Valid values are `not_started|in_progress|qualified|requalification_required`',
    `requires_nre` BOOLEAN COMMENT 'Boolean flag indicating whether this process flow requires Non-Recurring Engineering (NRE) investment for setup and qualification.',
    `substrate_type` STRING COMMENT 'Type of substrate material used in this process flow (e.g., silicon, silicon-on-insulator, gallium arsenide, silicon carbide).',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target yield percentage (good dies per wafer) expected for wafer lots processed through this flow. Business-sensitive manufacturing performance metric.',
    `total_process_steps` STRING COMMENT 'Total number of discrete process steps defined in this flow spanning FEOL, MOL, and BEOL operations.',
    `transistor_architecture` STRING COMMENT 'Transistor device architecture employed in this process flow: planar MOSFET, FinFET (Fin Field-Effect Transistor), GAA (Gate All Around), or nanosheet.. Valid values are `planar|finfet|gaa|nanosheet`',
    `wafer_size_mm` STRING COMMENT 'Wafer diameter in millimeters that this process flow is designed for (e.g., 200mm, 300mm, 450mm).',
    CONSTRAINT pk_process_flow PRIMARY KEY(`process_flow_id`)
) COMMENT 'Ordered sequence of process steps defining the complete manufacturing route for a product on a given technology node. Captures flow revision, node generation (e.g., 5nm, 7nm, 28nm), flow type (standard, MPW, engineering), effective dates, and approval status. SSOT for FAB routing and WIP scheduling. Aligned with SEMI E40 process management standard for flow-level routing definition.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`lot_move` (
    `lot_move_id` BIGINT COMMENT 'Unique identifier for the lot move transaction. Primary key for this WIP (Work in Process) lot movement event through a FAB (Fabrication Facility) process step.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_step. Business justification: lot_move has an at_step BIGINT column that semantically represents the fabrication process step at which the lot move occurred. This is a clear in-domain FK to fabrication_process_step. The existing',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Internal cost tracking of lot movements charges labor and handling to the appropriate cost center.',
    `equipment_run_id` BIGINT COMMENT 'FK to fabrication.equipment_run.equipment_run_id — Each lot move through a process step is executed via an equipment run. Links WIP tracking to process execution for traceability.',
    `fab_tool_id` BIGINT COMMENT 'Identifier for the FAB (Fabrication Facility) equipment or tool used to process this lot move (e.g., ATE (Automatic Test Equipment), lithography stepper, etcher, deposition chamber). Links to equipment master data.',
    `ic_catalog_id` BIGINT COMMENT 'Identifier for the IC (Integrated Circuit) product or device being manufactured in this lot. Links to product master data (e.g., SoC (System on Chip), ASIC (Application-Specific Integrated Circuit), FPGA (Field-Programmable Gate Array)).',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: When a lot move occurs at an inspection or metrology step, it creates or references an inspection_lot in the QMS. This is a core MES-to-QMS integration point in semiconductor fabs — the lot_move event',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: MES traceability links lot moves to process run records for complete lot history and yield analysis. Semiconductor MES systems record a lot_process_run for each lot_move through a process step; this l',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Lot move corresponds to a specific process step; linking supports operation tracking and step‑level performance reporting.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Unique identifier for the WIP (Work in Process) lot being moved. References the wafer lot entity tracked through the FAB (Fabrication Facility).',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: Lot move records need engineering node reference for SPC chart selection and process capability reporting. Semiconductor SPC systems use the process_technology_node to select the correct control chart',
    `recipe_id` BIGINT COMMENT 'Identifier for the process recipe executed during this lot move. Defines the specific parameter set, process conditions, and control settings used for this operation.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier for the specific process chamber or module within the equipment used for this lot move. Relevant for multi-chamber tools (e.g., CVD (Chemical Vapor Deposition), PVD (Physical Vapor Deposition), ALD (Atomic Layer Deposition) systems).',
    `order_id` BIGINT COMMENT 'Identifier for the manufacturing work order or production order associated with this lot move. Links to ERP (Enterprise Resource Planning) or MES (Manufacturing Execution System) work order master data.',
    `actual_flow_rate_sccm` DECIMAL(18,2) COMMENT 'Actual gas flow rate in SCCM (Standard Cubic Centimeters per Minute) for process gases during this lot move. Critical parameter for deposition and etch processes.',
    `actual_power_watts` DECIMAL(18,2) COMMENT 'Actual RF (Radio Frequency) or DC power in watts applied during this lot move. Critical parameter for plasma processes (etch, PVD (Physical Vapor Deposition), PECVD (Plasma-Enhanced Chemical Vapor Deposition)).',
    `actual_pressure_torr` DECIMAL(18,2) COMMENT 'Actual process chamber pressure in Torr recorded during this lot move. Critical parameter for vacuum processes (PVD (Physical Vapor Deposition), CVD (Chemical Vapor Deposition), etch, implant).',
    `actual_temperature_c` DECIMAL(18,2) COMMENT 'Actual process temperature in degrees Celsius recorded during this lot move. Critical parameter for thermal processes (CVD (Chemical Vapor Deposition), diffusion, anneal, oxidation).',
    `comments` STRING COMMENT 'Free-text comments or notes entered by the operator or engineer regarding this lot move. Captures contextual information, issues, or special handling instructions.',
    `control_job_code` STRING COMMENT 'Identifier for the MES (Manufacturing Execution System) control job that orchestrated this lot move. Links to the higher-level job or batch execution context in Camstar MES or SmartFactory MES.. Valid values are `^[A-Z0-9_-]{4,30}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lot move record was first created in the source system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for data lineage and audit trail.',
    `defect_count` STRING COMMENT 'Number of defects detected during or after this lot move, as reported by inline inspection or metrology systems. Used for yield analysis and SPC (Statistical Process Control).',
    `disposition` STRING COMMENT 'Quality disposition or pass/fail outcome of the lot move. Determines whether the lot proceeds to the next step, requires rework, is scrapped, or is placed on hold for further inspection.. Valid values are `pass|fail|rework|scrap|hold|conditional_pass`',
    `hold_reason_code` STRING COMMENT 'Code indicating the reason for a lot hold, if applicable (e.g., quality issue, equipment failure, engineering review, customer request). Empty if lot is not on hold.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lot move record was last updated in the source system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and data synchronization.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the measurement_value field (e.g., nm (nanometers), um (micrometers), angstrom, ohm-cm (resistivity), percent, ppm (parts per million)).. Valid values are `nm|um|angstrom|ohm_cm|percent|ppm`',
    `measurement_value` DECIMAL(18,2) COMMENT 'Primary metrology measurement value captured during this lot move (e.g., film thickness, CD (Critical Dimension), overlay, resistivity). Unit of measure is context-dependent on the operation type.',
    `move_in_timestamp` TIMESTAMP COMMENT 'Timestamp when the lot was moved into the process step or equipment. Marks the start of processing for this operation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `move_out_timestamp` TIMESTAMP COMMENT 'Timestamp when the lot was moved out of the process step or equipment. Marks the completion of processing for this operation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `move_status` STRING COMMENT 'Current lifecycle status of the lot move transaction. Indicates whether the move completed successfully, is still in progress, was aborted, held for review, or skipped.. Valid values are `completed|in_progress|aborted|held|skipped`',
    `priority_code` STRING COMMENT 'Scheduling priority level for this lot move. Hot and expedite lots receive preferential processing to meet urgent customer commitments or TTM (Time to Market) targets.. Valid values are `hot|expedite|normal|low`',
    `process_layer` STRING COMMENT 'Manufacturing layer classification for this process step. FEOL (Front End of Line) covers transistor formation, MOL (Middle of Line) covers contacts, BEOL (Back End of Line) covers interconnects and metallization.. Valid values are `FEOL|MOL|BEOL`',
    `process_module` STRING COMMENT 'High-level process module category for this operation (e.g., lithography, etch, deposition, ion implantation, CMP (Chemical Mechanical Planarization), diffusion, metrology, inspection, test). [ENUM-REF-CANDIDATE: lithography|etch|deposition|implant|CMP|diffusion|metrology|inspection|test — 9 candidates stripped; promote to reference product]',
    `process_time_seconds` STRING COMMENT 'Actual processing time in seconds for this lot move, calculated as the duration between move-in and move-out timestamps. Used for cycle time analysis and equipment utilization tracking.',
    `quantity_in` STRING COMMENT 'Number of wafers or units in the lot at move-in. Represents the starting quantity before processing.',
    `quantity_out` STRING COMMENT 'Number of wafers or units in the lot at move-out. Represents the ending quantity after processing. May differ from quantity_in due to scrap, breakage, or sampling.',
    `queue_time_seconds` STRING COMMENT 'Time in seconds the lot spent waiting in queue before move-in. Measures WIP (Work in Process) wait time and identifies bottlenecks in the FAB (Fabrication Facility) flow.',
    `recipe_version` STRING COMMENT 'Version number of the process recipe executed. Tracks recipe revisions and enables traceability for process changes and yield analysis.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    `rework_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this lot move is a rework operation (True) or a first-pass operation (False). Rework lots are reprocessed due to defects or out-of-spec conditions.',
    `sampling_flag` BOOLEAN COMMENT 'Boolean flag indicating whether wafers were sampled from this lot during this move (True) for destructive testing, metrology, or inspection. False if no sampling occurred.',
    `scrap_quantity` STRING COMMENT 'Number of wafers or units scrapped during this lot move due to breakage, defects, or process failures. Used for yield loss tracking and DPPM (Defective Parts Per Million) calculation.',
    `source_system` STRING COMMENT 'Identifier for the source MES (Manufacturing Execution System) or ERP (Enterprise Resource Planning) system that generated this lot move transaction (e.g., Camstar MES, SmartFactory MES, SAP PP (Production Planning)).. Valid values are `Camstar_MES|SmartFactory_MES|SAP_PP`',
    `tracks_lot` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Every lot move transaction must reference the lot being moved. Core MES transaction integrity — cannot track WIP without this FK.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the wafers in this lot in millimeters (e.g., 200mm, 300mm, 450mm). Standard wafer size for the FAB (Fabrication Facility).',
    CONSTRAINT pk_lot_move PRIMARY KEY(`lot_move_id`)
) COMMENT 'Transactional record of each WIP lot movement through a process step in the FAB, capturing move-in timestamp, move-out timestamp, operator ID, equipment used, recipe executed, actual process parameters, pass/fail disposition, and quantity in/out. Core MES transaction sourced from Camstar MES and SmartFactory MES. Enables cycle time analysis and WIP genealogy.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` (
    `wafer_start_id` BIGINT COMMENT 'Unique identifier for the wafer start transaction. Primary key for the wafer start record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Wafer starts are customer-authorized production events. Customer production reporting, capacity allocation by account, and customer-specific priority scheduling require direct account linkage on wafer',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Wafer start authorizations are issued from specific production lines mapped to cost centers. Required for fab cost accounting at the start authorization level, enabling budget vs. actual wafer start c',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: wafer_start is the authorization record that initiates a new wafer lot into the FAB line. It has two BIGINT columns creates_lot and start_creates_lot that both semantically reference the fabricati',
    `customer_design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Wafer starts are production authorizations driven by customer design wins. NRE billing, revenue recognition, and production planning all require direct traceability from wafer_start to the originating',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Wafer start authorization for ITAR/EAR-controlled products requires a valid export license on file before production begins. The wafer_start has itar_controlled_flag and ear_classification confirming ',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: wafer_start has a fab_facility_code STRING column indicating which fab facility the wafer start is authorized for. Normalizing to a proper FK to fab_facility establishes referential integrity. fab_fac',
    `photomask_id` BIGINT COMMENT 'Identifier for the photomask set (reticle set) used for lithography steps in this wafer lot. Links to the physical layout and GDS data.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Wafer starts are authorized against a specific engineering process flow for qualification and capacity planning. Process qualification status on the engineering flow determines whether a wafer start c',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Wafer starts at outsourced foundries must reference the foundry as a supplier for capacity allocation, NRE cost tracking, and supplier performance management. Fabless semiconductor companies authorize',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Supports Wafer Start Scheduling report tying start orders to the IC catalog entry.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: A wafer start is initiated for a specific IC design project. Production planning, NRE-to-production transition tracking, and customer order fulfillment all require knowing which design project a wafer',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Engineering and qualification wafer starts are charged to internal orders. The existing nre_project_code plain attribute is a denormalization of the internal_order entity. Required for NRE cost tracki',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: wafer_start already has sales_order_id but not order_line_id. A wafer start is initiated to fulfill a specific order line item. Fab planning uses this for line-level capacity commitment and delivery d',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Needed for Wafer Start Material Certification process, tying each wafer start to the supplied material master record for quality and compliance tracking.',
    `mpw_order_id` BIGINT COMMENT 'Foreign key linking to order.mpw_order. Business justification: An MPW wafer start is commissioned by an mpw_order specifying shuttle, reticle slot, and die quantities. Fab operations need this link to confirm MPW lot execution against the commercial order, track ',
    `mpw_shuttle_id` BIGINT COMMENT 'Identifier for the MPW shuttle run if this wafer start combines multiple customer designs on shared wafers. Null for dedicated production lots.',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: A wafer start is initiated with a specific GDS/physical layout version. Production release authorization and first-article inspection require layout version traceability at wafer start. Foundry produc',
    `process_flow_id` BIGINT COMMENT 'Identifier for the manufacturing process flow (recipe sequence) that this wafer lot will follow. Defines the FEOL, MOL, and BEOL steps.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Wafer start authorizations explicitly specify the process node for capacity planning and fab scheduling. technology_node is a denormalized plain-text column. Linking to product.process_node enables no',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: Wafer start authorization and capacity planning require the engineering process technology node reference. Semiconductor fab planners use this link for node-level capacity reporting and NPI (new produ',
    `product_qualification_program_id` BIGINT COMMENT 'Foreign key linking to product.product_qualification_program. Business justification: Qualification wafer starts are authorized under a specific product qualification program (HTOL, AEC-Q100). Linking wafer_start to product_qualification_program enables qualification lot tracking, samp',
    `product_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_spec. Business justification: NPI and qualification wafer starts are explicitly authorized against a product spec revision being validated (first silicon, AEC-Q qualification lots). Semiconductor process engineers require this lin',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Required for Wafer Start Planning report linking each wafer start to its originating sales order, enabling traceability from order to production schedule.',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_contract. Business justification: Foundry capacity contracts govern wafer start authorizations, specifying committed volumes, pricing tiers, and technology access rights. Linking wafer_start to the governing sourcing_contract enables ',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: A wafer start is authorized by a tapeout approval — the tapeout record is the formal design-to-fab handoff document. Foundry production scheduling, first-article inspection, and NRE-to-production tran',
    `test_plan_id` BIGINT COMMENT 'Foreign key linking to quality.test_plan. Business justification: Wafer starts specify the test plan governing in-line inspection and sampling. The sampling_plan_code on wafer_start is a denormalization of test_plan data. A proper FK to test_plan provides traceabili',
    `wafer_start_authorization_id` BIGINT COMMENT 'Foreign key linking to order.wafer_start_authorization. Business justification: wafer_start is the fab-side execution record; wafer_start_authorization is the order-side commercial approval. Fab planning teams require this link to confirm every wafer start has a valid commercial ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Wafer starts for customer-specific programs are tracked against WBS elements for project cost accounting. Enables program-level cost roll-up from wafer start authorization through completion, required',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer start was formally authorized in the MES system. Precedes the actual release to the FAB line.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this wafer start record was first created in the MES database. Used for audit trail and data lineage.',
    `crystal_orientation` STRING COMMENT 'Crystallographic orientation of the silicon wafer, expressed in Miller indices (e.g., <100>, <111>). Affects electrical properties and process compatibility.. Valid values are `^<[0-9]{3}>$`',
    `doping_type` STRING COMMENT 'Electrical doping type of the starting wafer substrate: p-type (boron-doped), n-type (phosphorus or arsenic-doped), or intrinsic (undoped).. Valid values are `p_type|n_type|intrinsic`',
    `ear_classification` STRING COMMENT 'Export Control Classification Number (ECCN) under EAR for this product. Format: 5-character code (e.g., 3A001). Null if not export-controlled.. Valid values are `^[0-9][A-Z][0-9]{3}$`',
    `estimated_cycle_time_days` DECIMAL(18,2) COMMENT 'Planned total cycle time from wafer start to completion, measured in days. Based on standard process flow duration and current FAB loading.',
    `hold_reason_code` STRING COMMENT 'Code indicating the reason for placing this wafer start on hold, if applicable. Examples: quality issue, material shortage, engineering review, customer request.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `itar_controlled_flag` BOOLEAN COMMENT 'Boolean indicator of whether this wafer lot contains ITAR-controlled technology requiring export compliance controls. True if ITAR applies; False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this wafer start record was last updated. Tracks the most recent change to any field in the record.',
    `lot_number` STRING COMMENT 'Manufacturing lot identifier assigned to the wafer batch at start. This is the primary tracking identifier throughout FAB operations.. Valid values are `^[A-Z0-9]{8,16}$`',
    `parent_lot_number` STRING COMMENT 'Lot number of the parent lot if this wafer start is a split or rework from an existing lot. Null for original starts. Enables wafer genealogy tracking.. Valid values are `^[A-Z0-9]{8,16}$`',
    `planned_completion_date` DATE COMMENT 'Target date for completing all FAB processing steps and releasing the lot to wafer test. Based on standard cycle time for the process flow.',
    `priority_class` STRING COMMENT 'Scheduling priority for this wafer lot in the FAB line. Hot lots receive expedited processing; engineering lots may have flexible timing; standard and low follow normal queue discipline.. Valid values are `hot|standard|engineering|low`',
    `production_line` STRING COMMENT 'Specific production line or bay within the FAB facility assigned to this wafer start. Determines equipment set and process capability.. Valid values are `^LINE[A-Z0-9]{2,6}$`',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer lot was physically released into the FAB line and began processing. Marks the start of cycle time measurement.',
    `requested_delivery_date` DATE COMMENT 'Customer-requested delivery date for finished wafers or packaged units. Drives priority and scheduling decisions.',
    `resistivity_ohm_cm` DECIMAL(18,2) COMMENT 'Electrical resistivity of the starting wafer substrate, measured in ohm-centimeters. Indicates doping concentration and electrical characteristics.',
    `special_instructions` STRING COMMENT 'Free-text field for any special handling instructions, process deviations, or notes that operators and engineers should be aware of for this wafer lot.',
    `split_reason` STRING COMMENT 'Free-text explanation of why this lot was split from a parent lot, if applicable. Examples: process experiment, capacity balancing, quality segregation.',
    `substrate_type` STRING COMMENT 'Type of semiconductor substrate material used for this wafer lot. Silicon is standard; SOI (Silicon on Insulator), GaAs (Gallium Arsenide), GaN (Gallium Nitride), and SiC (Silicon Carbide) are specialty materials.. Valid values are `silicon|soi|gaas|gan|sic`',
    `wafer_quantity` STRING COMMENT 'Number of wafers authorized and started in this lot. Represents the initial wafer count at FAB entry before any processing losses.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the silicon wafer in millimeters. Standard values are 200mm or 300mm. Determines compatible equipment and process chambers.',
    `wafer_start_date` DATE COMMENT 'Calendar date when the wafer lot was authorized and initiated into the FAB line. Principal business event timestamp for capacity planning and WIP tracking.',
    `wafer_start_number` STRING COMMENT 'Business identifier for the wafer start transaction, externally visible and used for tracking and reporting. Format: WS followed by 10 digits.. Valid values are `^WS[0-9]{10}$`',
    `wafer_start_status` STRING COMMENT 'Current lifecycle status of the wafer start transaction. Authorized: approved but not yet released; Released: entered FAB line; In Process: active WIP; Completed: all steps finished; Cancelled: terminated before completion; On Hold: temporarily suspended.. Valid values are `authorized|released|in_process|completed|cancelled|on_hold`',
    `wafer_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the wafer lot was released into the FAB line, including time zone. Used for detailed cycle time analysis and shift-level tracking.',
    `wafer_start_type` STRING COMMENT 'Classification of the wafer start purpose: production (customer orders), engineering (process development), qualification (product validation), MPW (multi-project wafer), pilot (pre-production), or rework (reprocessing).. Valid values are `production|engineering|qualification|mpw|pilot|rework`',
    `work_center` STRING COMMENT 'SAP work center code representing the initial processing area for this wafer start. Used for capacity planning and cost allocation.. Valid values are `^WC[0-9]{4}$`',
    CONSTRAINT pk_wafer_start PRIMARY KEY(`wafer_start_id`)
) COMMENT 'Transactional record authorizing and recording the initiation of a new wafer lot into the FAB line, capturing wafer start date, authorized quantity, product code, technology node, priority class, customer order reference, and wafer start type (production, engineering, qualification, MPW). SSOT for FAB capacity consumption and WIP entry.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` (
    `fabrication_lot_hold_id` BIGINT COMMENT 'Unique identifier for the fabrication lot hold event record.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom the lot is being fabricated, relevant for customer-initiated holds or customer notification.',
    `capa_record_id` BIGINT COMMENT 'Reference to the corrective action record initiated as a result of this hold event.',
    `excursion_id` BIGINT COMMENT 'Foreign key linking to process.excursion. Business justification: OCAP workflow requires linking lot holds to the triggering process excursion for root cause investigation and CAPA tracking. Semiconductor quality engineers expect holds to reference the excursion tha',
    `fab_facility_id` BIGINT COMMENT 'Reference to the fabrication facility where the hold event occurred.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the equipment unit associated with the hold event, if applicable (e.g., tool that triggered the excursion).',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: A fab lot hold puts the associated order line delivery at risk. Customer service and order management teams need this link to identify at-risk order lines, update confirmed delivery dates, and trigger',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Lot holds triggered by incoming material quality failures (contaminated substrates, off-spec chemicals) must reference the responsible supplier to initiate supplier corrective actions (SCARs) and upda',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: Lot holds are frequently initiated by NCRs in semiconductor MES/QMS integration. The ncr_number plain attribute on fabrication_lot_hold is a direct denormalization of nonconformance_report. A proper F',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot that is placed on hold.',
    `process_step_id` BIGINT COMMENT 'Reference to the specific process step (FEOL, MOL, BEOL operation) where the lot was held.',
    `sku_id` BIGINT COMMENT 'Reference to the product (IC design, SoC, ASIC) being fabricated in the lot under hold.',
    `spc_control_chart_id` BIGINT COMMENT 'Foreign key linking to process.spc_control_chart. Business justification: OCAP workflow requires linking lot holds to the specific SPC control chart whose rule was violated. fabrication_lot_hold has spc_rule_violation boolean; the spc_control_chart_id identifies which chart',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: When a lot hold is caused by suspect incoming material, the specific goods receipt of that material must be referenced for quarantine, SCAR initiation, and lot genealogy traceability. Semiconductor qu',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Lot holds are frequently triggered by probe yield excursions falling below threshold. The MES workflow requires the hold record to reference the triggering probe run for root cause investigation and C',
    `yield_loss_event_id` BIGINT COMMENT 'Foreign key linking to process.yield_loss_event. Business justification: Quality investigation workflow links lot holds to yield loss events for CAPA tracking. When a yield loss event triggers a lot hold, the hold record must reference the yield_loss_event for complete inv',
    `approval_required` BOOLEAN COMMENT 'Indicator whether management or engineering approval is required before the hold can be released.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the hold release was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hold record was first created in the data system.',
    `customer_notification_required` BOOLEAN COMMENT 'Indicator whether the customer must be notified of this hold event per contractual or quality agreement terms.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the customer was notified of the hold event.',
    `defect_density_threshold_exceeded` BOOLEAN COMMENT 'Indicator whether the hold was triggered by defect density exceeding acceptable limits.',
    `disposition_action` STRING COMMENT 'Action taken upon hold release or closure (resume normal processing, rework, scrap, quarantine, return to customer, engineering review).. Valid values are `resume|rework|scrap|quarantine|return_to_customer|engineering_review`',
    `disposition_notes` STRING COMMENT 'Free-text notes documenting the disposition decision, corrective actions taken, or investigation findings.',
    `escalation_flag` BOOLEAN COMMENT 'Indicator whether the hold has been escalated to senior engineering or management for resolution.',
    `hold_cycle_time_hours` DECIMAL(18,2) COMMENT 'Duration in hours between hold placement and release, used for cycle time tracking and excursion management KPIs.',
    `hold_expiration_timestamp` TIMESTAMP COMMENT 'Date and time when the hold automatically expires if not explicitly released or extended, used for time-bound holds.',
    `hold_placement_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was placed on the lot, representing the principal business event timestamp.',
    `hold_reason_code` STRING COMMENT 'Standardized code indicating the reason for placing the lot on hold (e.g., process excursion, quality issue, engineering investigation, customer request).',
    `hold_reason_description` STRING COMMENT 'Detailed textual description of the reason for the hold, providing additional context beyond the reason code.',
    `hold_release_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was released and the lot was cleared to resume processing. Null if hold is still active.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold event (active, released, cancelled, expired).. Valid values are `active|released|cancelled|expired`',
    `hold_type` STRING COMMENT 'Classification of the hold event by functional area or trigger source (engineering, quality, process excursion, customer, equipment, material, safety). [ENUM-REF-CANDIDATE: engineering|quality|process_excursion|customer|equipment|material|safety — 7 candidates stripped; promote to reference product]',
    `initiating_system` STRING COMMENT 'Name or identifier of the system that triggered the hold event (e.g., MES, SPC, ATE, manual entry).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hold record was last updated in the data system.',
    `lot_number` STRING COMMENT 'Business identifier for the wafer lot under hold, typically assigned by MES system.',
    `mes_transaction_code` STRING COMMENT 'Unique transaction identifier from the MES system that recorded this hold event.',
    `priority_level` STRING COMMENT 'Urgency classification for resolving the hold (critical, high, medium, low), used for escalation and resource allocation.. Valid values are `critical|high|medium|low`',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the root cause determined during investigation (e.g., equipment malfunction, operator error, material defect).',
    `spc_rule_violation` STRING COMMENT 'Specific SPC rule that was violated and triggered the hold (e.g., Western Electric Rule 1, 2, 3, 4).',
    `wafer_count` STRING COMMENT 'Number of wafers in the lot at the time the hold was placed.',
    CONSTRAINT pk_fabrication_lot_hold PRIMARY KEY(`fabrication_lot_hold_id`)
) COMMENT 'Transactional record capturing all hold events placed on a wafer lot, including hold reason code, hold type (engineering, quality, process excursion, customer), initiating system or operator, hold placement timestamp, release timestamp, and disposition action taken. Enables hold cycle time tracking and excursion management.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` (
    `lot_disposition_id` BIGINT COMMENT 'Unique identifier for the lot disposition record. Primary key for the lot disposition entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: lot_disposition has customer_notification_required and customer_approval_received columns, proving customer involvement in disposition decisions. Direct account FK supports the customer notification a',
    `capa_record_id` BIGINT COMMENT 'Identifier of the associated corrective action record if corrective action is required. Links to the corrective action entity for CAPA tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial reporting of lot disposition costs requires linking each disposition to the responsible cost center for expense allocation.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the fabrication equipment associated with the disposition event. Links to the equipment entity for equipment-related root causes.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot subject to this disposition decision. Links to the wafer lot entity in the fabrication domain.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Lot dispositions involving scrap or rework generate significant financial charges in semiconductor fabs. Scrap costs must be charged to internal orders for variance analysis beyond cost center level. ',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Lot disposition outcomes (scrap, rework, accept) directly affect order line fulfillable quantity. Order management and quality teams need this link to update delivery commitments, trigger replacement ',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: MES disposition workflow requires tracing the specific process run that led to the disposition decision. Semiconductor MRB engineers need to review the actual process parameters from the lot_process_r',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: Lot disposition decisions in semiconductor MRB workflows are directly driven by NCRs. The disposition_number and waiver_number on lot_disposition are outcomes of the NCR/MRB process. A direct FK to no',
    `process_flow_id` BIGINT COMMENT 'Identifier of the rework process route assigned to the lot if disposition type is rework. Defines the sequence of process steps for lot recovery.',
    `process_step_id` BIGINT COMMENT 'Identifier of the fabrication process step where the issue triggering disposition was detected. Links to the process step entity.',
    `sku_id` BIGINT COMMENT 'Identifier of the target product specification if disposition type is downgrade. Represents the lower-grade product to which the lot is reassigned.',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Lot disposition decisions (scrap, rework, use-as-is) in the fab are directly driven by wafer probe yield results. Disposition engineers reference the probe run data when making disposition calls. This',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or production area where the disposition event occurred. Links to the work center entity for area-level tracking.',
    `affected_wafer_count` STRING COMMENT 'Number of wafers in the lot subject to this disposition decision. Represents the quantity of wafers impacted by the disposition action.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposition decision was approved. Represents the moment of final authorization.',
    `corrective_action_required` BOOLEAN COMMENT 'Flag indicating whether a formal corrective action is required to prevent recurrence. Triggers Corrective and Preventive Action (CAPA) workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposition record was first created in the system. Audit field for record creation tracking.',
    `customer_approval_received` BOOLEAN COMMENT 'Flag indicating whether customer approval has been received for ship-as-is or downgrade dispositions. Applicable when customer notification is required.',
    `customer_notification_required` BOOLEAN COMMENT 'Flag indicating whether customer notification is required for this disposition decision. True if Product Change Notification (PCN) or customer approval is needed.',
    `defect_code` STRING COMMENT 'Standardized defect classification code from the fab defect taxonomy. Links to the defect type reference table for detailed defect characteristics.',
    `defect_die_count` STRING COMMENT 'Total number of defective or failing die across all wafers in the lot at the time of disposition. Used for yield loss analysis.',
    `disposition_authority` STRING COMMENT 'Name or identifier of the person, role, or system that authorized the disposition decision. Typically a quality engineer, production supervisor, or automated MES rule.',
    `disposition_authority_role` STRING COMMENT 'Organizational role of the disposition authority. Defines the level of authorization for the disposition decision.. Valid values are `quality_engineer|production_supervisor|process_engineer|fab_manager|automated_system`',
    `disposition_date` DATE COMMENT 'Date when the disposition decision was made. Business event date for the disposition action.',
    `disposition_notes` STRING COMMENT 'Free-text notes and comments related to the disposition decision. Captures additional context, special instructions, or engineering judgment.',
    `disposition_number` STRING COMMENT 'Externally-known business identifier for the disposition decision. Format: DISP-YYYYMMDD-XXXXXX where YYYYMMDD is date and XXXXXX is sequence.. Valid values are `^DISP-[0-9]{8}-[A-Z0-9]{6}$`',
    `disposition_of_lot` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Disposition decisions reference the lot being dispositioned. Required for lot closure and yield accounting.',
    `disposition_status` STRING COMMENT 'Current lifecycle status of the disposition decision. Pending: awaiting approval. Approved: authorized for execution. Rejected: disposition denied. Executed: disposition action completed. Cancelled: disposition voided.. Valid values are `pending|approved|rejected|executed|cancelled`',
    `disposition_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the disposition decision was recorded in the Manufacturing Execution System (MES). Captures exact moment of disposition event.',
    `disposition_type` STRING COMMENT 'Type of disposition decision applied to the lot. Accept: lot meets specifications and proceeds. Scrap: lot is discarded. Rework: lot requires reprocessing. Downgrade: lot is reassigned to lower grade. Hold: lot is quarantined pending review. Ship-as-is: lot ships with known deviations under waiver.. Valid values are `accept|scrap|rework|downgrade|hold|ship_as_is`',
    `executed_by` STRING COMMENT 'Name or identifier of the person or system that executed the disposition action. Captures who performed the physical disposition.',
    `executed_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposition action was physically executed. Represents the moment when the lot was scrapped, moved to rework, or released.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the disposition decision in USD. Includes scrap cost, rework cost, or revenue loss from downgrade. Used for cost accounting and yield loss reporting.',
    `good_die_count` STRING COMMENT 'Total number of Known Good Die (KGD) across all wafers in the lot at the time of disposition. Used for yield accounting and financial valuation.',
    `hold_reason_code` STRING COMMENT 'Standardized reason code for hold disposition. Links to the hold reason reference table for detailed hold classification and tracking.',
    `lot_yield_percent` DECIMAL(18,2) COMMENT 'Calculated yield percentage for the lot at disposition time. Represents the ratio of good die to total die, expressed as a percentage.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposition record was last modified. Audit field for change tracking and data lineage.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause that triggered the disposition decision. Used for Failure Mode and Effects Analysis (FMEA) and continuous improvement.. Valid values are `equipment_failure|process_deviation|material_defect|operator_error|design_issue|contamination`',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause analysis findings. Captures the specific failure mode, contributing factors, and technical details.',
    `scrap_reason_code` STRING COMMENT 'Standardized reason code for scrap disposition. Links to the scrap reason reference table for detailed scrap classification and reporting.',
    `waiver_number` STRING COMMENT 'Engineering waiver authorization number if disposition type is ship-as-is. Format: WVR-YYYYMMDD-XXXX. Authorizes shipment of lot with known deviations.. Valid values are `^WVR-[0-9]{8}-[A-Z0-9]{4}$`',
    CONSTRAINT pk_lot_disposition PRIMARY KEY(`lot_disposition_id`)
) COMMENT 'Transactional record of final or interim lot disposition decisions including scrap, rework, accept, downgrade, or ship-as-is. Captures disposition type, disposition authority, disposition date, affected wafer count, yield impact, and root cause classification. Authoritative record for lot closure and yield accounting.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` (
    `fab_run_card_id` BIGINT COMMENT 'Unique identifier for the fabrication run card. Primary key for the fab run card entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom this lot is being fabricated. Enables tracking of customer-specific requirements and instructions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Run card execution costs are charged to a cost center for budgeting and variance analysis.',
    `customer_design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Run cards authorize production of customer-specific lots and must be traceable to the originating design win for NRE billing, revenue recognition, and customer IP traceability. Semiconductor foundry o',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export Control compliance requires each fab run card to reference the export license authorizing production of the controlled technology, used in Export License Management reports.',
    `fab_facility_id` BIGINT COMMENT 'Reference to the fabrication facility where this run card is executed. Supports multi-site manufacturing operations.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot that this run card governs. Links the run card to the specific lot being processed through the fabrication line.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: A fab run card specifies the engineering process flow it implements. Process change management and run card approval workflows require tracing which process.process_flow the run card executes. Semicon',
    `ic_catalog_id` BIGINT COMMENT 'Reference to the product being manufactured. Links the run card to the specific Integrated Circuit (IC), System on Chip (SoC), or Application-Specific Integrated Circuit (ASIC) design.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the specific IC design project or tapeout that this run card supports. Links to the Register Transfer Level (RTL), Graphic Data System II (GDSII), and Process Design Kit (PDK) used.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Run cards for NRE, engineering, and qualification lots are charged to internal orders. Completes the SAP cost object triangle (cost_center + profit_center already exist on fab_run_card). Required for ',
    `nre_order_id` BIGINT COMMENT 'Foreign key linking to order.nre_order. Business justification: For NRE engagements (process development, mask qualification), a fab run card is issued to execute the NRE work scope. Linking run card to nre_order enables NRE milestone completion tracking, billing ',
    `process_flow_id` BIGINT COMMENT 'Reference to the approved process flow that defines the sequence of fabrication steps (Front End of Line (FEOL), Middle of Line (MOL), Back End of Line (BEOL)) for this wafer lot.',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: Run card compliance and export control (ITAR/EAR) require the engineering process technology node reference. Semiconductor compliance teams use this link to determine export classification of run card',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center performance reporting includes fab run card production output and associated revenue.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Links Run Card to the purchase order of consumables, enabling run cost allocation and audit of material usage per lot.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: A run card governs fabrication of a specific tapeouts wafer lot. Run card approval, deviation tracking, and customer notification requirements are tied to the tapeout authorization. Foundry operation',
    `wafer_start_authorization_id` BIGINT COMMENT 'Foreign key linking to order.wafer_start_authorization. Business justification: A fab run card is the shop-floor traveler issued against a wafer start authorization. Linking run card to WSA enables fab operations to verify authorization before processing and supports ITAR/EAR com',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Run cards for customer-specific programs are tracked against WBS elements for program cost accounting. Enables program-level cost roll-up from run card through completion, required for customer progra',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this run card was formally approved for manufacturing execution. Marks the transition from draft to approved status.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer lot completed all process steps defined in this run card. Marks the end of the fabrication cycle. Null if lot is still in process.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this run card record was first created in the Manufacturing Execution System (MES). Audit trail for record creation.',
    `cycle_time_days` DECIMAL(18,2) COMMENT 'Actual or planned cycle time for this run card from start to completion, measured in days. Key metric for manufacturing efficiency and Time to Market (TTM).',
    `deviation_description` STRING COMMENT 'Detailed description of any engineering deviations, process exceptions, or non-standard procedures authorized for this run card. Null if no deviations exist.',
    `deviation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this run card contains any approved engineering deviations from the standard process flow. True indicates deviations are present.',
    `ear_classification` STRING COMMENT 'Export Administration Regulations (EAR) classification code for this run card, if applicable. Governs export control compliance for semiconductor technology.',
    `eco_number` STRING COMMENT 'Reference number of the Engineering Change Order (ECO) associated with this run card, if applicable. Links to formal change management documentation.',
    `hold_flag` BOOLEAN COMMENT 'Boolean indicator of whether this run card is currently under a manufacturing hold. True indicates the lot cannot proceed until the hold is released.',
    `hold_reason` STRING COMMENT 'Explanation of why the run card is on hold, if applicable. May reference quality issues, engineering review, or customer requests. Null if no hold exists.',
    `itar_controlled` BOOLEAN COMMENT 'Boolean indicator of whether this run card is subject to International Traffic in Arms Regulations (ITAR) export control restrictions. True indicates ITAR-controlled technology.',
    `lot_disposition` STRING COMMENT 'Final disposition status of the wafer lot upon run card completion: pass (meets all specifications), fail (rejected), conditional (partial acceptance), quarantine (under review), or scrap (discarded).. Valid values are `pass|fail|conditional|quarantine|scrap`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this run card record was last modified. Audit trail for tracking changes to the run card throughout its lifecycle.',
    `notes` STRING COMMENT 'General notes, comments, or observations recorded during the execution of this run card. Captures operator feedback, process anomalies, or engineering observations.',
    `pcn_number` STRING COMMENT 'Product Change Notification (PCN) number if this run card implements a customer-notified product change. Ensures traceability to customer communications.',
    `priority_level` STRING COMMENT 'Manufacturing priority assigned to this run card. Determines scheduling precedence on the fabrication line. Critical lots receive expedited processing.. Valid values are `critical|high|normal|low`',
    `quality_grade` STRING COMMENT 'Quality and reliability grade for this run card: automotive (IATF 16949 compliant), industrial (extended temperature/reliability), commercial (standard), or consumer (cost-optimized).. Valid values are `automotive|industrial|commercial|consumer`',
    `reach_compliant` BOOLEAN COMMENT 'Boolean indicator of whether the process materials comply with Registration Evaluation Authorization and Restriction of Chemicals (REACH) regulation requirements.',
    `rohs_compliant` BOOLEAN COMMENT 'Boolean indicator of whether the process materials and chemicals used in this run card comply with Restriction of Hazardous Substances (RoHS) directive requirements.',
    `run_card_follows_flow` BIGINT COMMENT 'FK to fabrication.process_flow.process_flow_id — Run cards define the approved process flow for a lot run.',
    `run_card_for_lot` BIGINT COMMENT 'FK to fabrication.fabrication_wafer_lot.fabrication_wafer_lot_id — Run cards (travelers) are associated with specific lots as their manufacturing instructions.',
    `run_card_number` STRING COMMENT 'The externally-known business identifier for this run card. Human-readable traveler document number used by operators and engineers to reference this specific run card.',
    `run_card_specifies_flow` BIGINT COMMENT 'FK to fabrication.process_flow.process_flow_id — Run card defines the approved process flow for the lot. Required for routing compliance verification.',
    `run_card_status` STRING COMMENT 'Current lifecycle status of the run card: draft (being prepared), approved (ready for use), active (lot in process), on_hold (temporarily suspended), completed (lot finished), or cancelled (run card voided).. Valid values are `draft|approved|active|on_hold|completed|cancelled`',
    `run_card_type` STRING COMMENT 'Classification of the run card based on its purpose: production (standard manufacturing), engineering (experimental or test lots), qualification (product validation), rework (reprocessing), pilot (pre-production), or development (process development).. Valid values are `production|engineering|qualification|rework|pilot|development`',
    `run_card_version` STRING COMMENT 'Version number of the run card document. Tracks revisions and updates to the process flow or instructions for this lot.',
    `special_instructions` STRING COMMENT 'Free-text field containing operator instructions, handling requirements, or process notes specific to this run card. May include customer-specific requirements or engineering guidance.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer lot began processing under this run card. Marks the beginning of the fabrication cycle for this lot.',
    `target_completion_date` DATE COMMENT 'Planned or committed completion date for this run card. Used for scheduling, capacity planning, and customer delivery commitments.',
    `wafer_quantity` STRING COMMENT 'Number of wafers in the lot governed by this run card. Tracks lot size for capacity planning and yield calculations.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the silicon wafers in this lot, measured in millimeters (e.g., 200mm, 300mm, 450mm). Determines compatible equipment and handling procedures.',
    CONSTRAINT pk_fab_run_card PRIMARY KEY(`fab_run_card_id`)
) COMMENT 'Master traveler document associated with a wafer lot defining the approved process flow, special instructions, engineering deviations, customer-specific requirements, and step-level notes for a given lot run. Captures run card version, approval status, deviation flags, and associated engineering change orders. Sourced from Camstar MES and Oracle Agile PLM.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` (
    `equipment_run_id` BIGINT COMMENT 'Unique identifier for the equipment run. Primary key for this transactional record of a specific tool chamber run executed on a wafer lot or wafer set.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Equipment run cost accounting allocates depreciation and overhead to the cost center responsible for the run.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the fabrication equipment tool that executed this run. Links to the equipment master record.',
    `photomask_id` BIGINT COMMENT 'Identifier of the photomask reticle used in lithography exposure. Links to the photomask asset inventory. Applicable only when process_type is lithography.',
    `fabrication_process_recipe_id` BIGINT COMMENT 'FK to fabrication.fabrication_process_recipe.fabrication_process_recipe_id — Equipment runs execute a specific recipe version. Links actual processing to recipe management.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot processed in this equipment run. Links to the wafer lot master record for WIP tracking and genealogy.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: An equipment run at an inspection or metrology step generates an inspection_lot in the QMS. This is a direct MES-QMS integration point — the equipment_run is the physical execution event that produces',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Equipment runs for qualification, engineering, and R&D purposes are charged to internal orders to separate from production costs. Standard semiconductor fab practice for equipment qualification cost t',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: MES traceability requires linking equipment-level run data to lot-level process run records for yield and defect correlation. Semiconductor process engineers use this link to correlate tool-level para',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Supports Equipment Run Material Consumption Log, associating chemicals/materials used in each run with their master record for SPC and safety compliance.',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: When an equipment run produces out-of-spec results (e.g., overlay error, deposition thickness excursion), an NCR is raised. The abort_reason and alarm_count on equipment_run signal quality excursions ',
    `process_step_id` BIGINT COMMENT 'Identifier of the process step within the overall fabrication flow. Links this run to the routing and process flow definition.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Equipment run must reference the exact process recipe applied; essential for audit, yield analysis, and SPC control.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: Equipment run data must be correlated to the engineering process step for SPC and capability analysis. equipment_run links to fabrication.fabrication_process_step (execution instance) but not to proce',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific process chamber within the equipment tool where this run was executed. Multi-chamber tools may have multiple concurrent runs.',
    `abort_reason` STRING COMMENT 'Reason code or description if the run was aborted or failed. Used for root cause analysis and yield improvement.',
    `actual_pressure_torr` DECIMAL(18,2) COMMENT 'Actual measured chamber pressure in Torr during the run. Used for process control and deviation analysis.',
    `actual_temperature_celsius` DECIMAL(18,2) COMMENT 'Actual measured process temperature in degrees Celsius during the run. Used for process control and deviation analysis.',
    `alarm_count` STRING COMMENT 'Number of equipment alarms triggered during this run. Indicator of process stability and equipment health.',
    `cmp_removal_rate_angstrom_per_min` DECIMAL(18,2) COMMENT 'Material removal rate during CMP in Angstroms per minute. Critical parameter for planarization control and endpoint detection.',
    `cmp_slurry_type` STRING COMMENT 'Type of slurry used in CMP process (e.g., oxide slurry, tungsten slurry, copper slurry). Applicable only when process_type is CMP.',
    `cmp_wiwnu_percent` DECIMAL(18,2) COMMENT 'Within-wafer non-uniformity percentage for CMP process. Measures variation in material removal across the wafer surface. Lower values indicate better planarization quality.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment run record was first created in the data platform. Audit trail for data lineage.',
    `deposition_film_material` STRING COMMENT 'Material deposited during CVD, PVD, or ALD runs (e.g., SiO2, Si3N4, TiN, Tungsten, Copper). Applicable for deposition process types.',
    `deposition_rate_angstrom_per_min` DECIMAL(18,2) COMMENT 'Film deposition rate in Angstroms per minute. Used for process control and cycle time optimization.',
    `deposition_thickness_angstrom` DECIMAL(18,2) COMMENT 'Target or measured film thickness in Angstroms deposited during the run. Critical parameter for film uniformity and device performance.',
    `deposition_uniformity_percent` DECIMAL(18,2) COMMENT 'Film thickness uniformity across the wafer expressed as a percentage. Lower values indicate better uniformity. Critical quality metric for deposition processes.',
    `implant_dose_atoms_per_cm2` DECIMAL(18,2) COMMENT 'Total ion dose implanted in atoms per square centimeter. Critical parameter for doping concentration control in ion implantation processes.',
    `implant_energy_kev` DECIMAL(18,2) COMMENT 'Ion beam energy in kiloelectron volts (keV) for ion implantation. Determines the depth of ion penetration into the wafer substrate.',
    `implant_species` STRING COMMENT 'Ion species implanted during ion implantation runs (e.g., Boron, Phosphorus, Arsenic, BF2). Applicable only when process_type is implant.',
    `implant_tilt_angle_degrees` DECIMAL(18,2) COMMENT 'Wafer tilt angle in degrees during ion implantation. Used to control channeling effects and implant profile.',
    `implant_twist_angle_degrees` DECIMAL(18,2) COMMENT 'Wafer twist (rotation) angle in degrees during ion implantation. Used in conjunction with tilt to control channeling effects.',
    `lithography_cd_measurement_nm` DECIMAL(18,2) COMMENT 'Measured critical dimension (CD) in nanometers after lithography exposure and development. Key quality metric for pattern fidelity.',
    `lithography_exposure_dose_mj_per_cm2` DECIMAL(18,2) COMMENT 'Exposure energy dose in millijoules per square centimeter for lithography. Critical parameter for pattern transfer and critical dimension (CD) control.',
    `lithography_focus_offset_nm` DECIMAL(18,2) COMMENT 'Focus offset in nanometers applied during lithography exposure. Used for depth-of-focus optimization and process window control.',
    `lithography_overlay_x_nm` DECIMAL(18,2) COMMENT 'Measured overlay error in the X-axis direction in nanometers. Indicates alignment accuracy between successive lithography layers.',
    `lithography_overlay_y_nm` DECIMAL(18,2) COMMENT 'Measured overlay error in the Y-axis direction in nanometers. Indicates alignment accuracy between successive lithography layers.',
    `mes_transaction_code` STRING COMMENT 'Transaction identifier from the Manufacturing Execution System (MES) that recorded this equipment run. Provides traceability to the source system.',
    `process_type` STRING COMMENT 'Discriminator identifying the category of fabrication process executed in this run. Determines which process-specific parameters are relevant. CVD=Chemical Vapor Deposition, PVD=Physical Vapor Deposition, ALD=Atomic Layer Deposition, CMP=Chemical Mechanical Planarization. [ENUM-REF-CANDIDATE: CVD|PVD|ALD|CMP|implant|etch|lithography|anneal|clean|wet_clean|diffusion|oxidation|metrology — 13 candidates stripped; promote to reference product]',
    `processes_lot` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Equipment run must reference the lot/wafers being processed. Core traceability requirement for process parameter linkage to product.',
    `run_duration_seconds` DECIMAL(18,2) COMMENT 'Total duration of the equipment run in seconds, calculated from start to end timestamp. Used for cycle time analysis and equipment utilization metrics.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment run completed processing. Marks the end of the process execution cycle.',
    `run_number` STRING COMMENT 'Business identifier for this equipment run, typically assigned by the Manufacturing Execution System (MES). Used for operational tracking and traceability.',
    `run_processes_lot` BIGINT COMMENT 'FK to fabrication.fabrication_wafer_lot.fabrication_wafer_lot_id — Equipment runs are executed on wafer lots. This is the core tool-to-WIP linkage.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment run started processing. Marks the beginning of the process execution cycle.',
    `run_status` STRING COMMENT 'Current lifecycle status of the equipment run. Indicates whether the run completed successfully, was aborted, failed due to error, is currently in progress, or was paused.. Valid values are `completed|aborted|failed|in_progress|paused`',
    `run_uses_recipe` BIGINT COMMENT 'FK to fabrication.process_recipe.process_recipe_id — Every equipment run executes a specific process recipe. Critical for recipe traceability, excursion investigation, and process control.',
    `target_pressure_torr` DECIMAL(18,2) COMMENT 'Target chamber pressure in Torr as specified by the recipe. Critical control parameter for vacuum and deposition processes.',
    `target_temperature_celsius` DECIMAL(18,2) COMMENT 'Target process temperature in degrees Celsius as specified by the recipe. Critical control parameter for thermal processes.',
    `uses_recipe` BIGINT COMMENT 'FK to fabrication.process_recipe.process_recipe_id — Every equipment run executes a specific recipe. Required for recipe-to-outcome traceability and process capability analysis.',
    `wafer_count` STRING COMMENT 'Number of wafers processed in this equipment run. Batch size for the run.',
    `wafer_slot_map` STRING COMMENT 'Mapping of wafer identifiers to slot positions within the carrier or chamber. Structured representation of wafer placement during processing.',
    CONSTRAINT pk_equipment_run PRIMARY KEY(`equipment_run_id`)
) COMMENT 'Transactional record of a specific equipment tool run (chamber run, process run) executed on a wafer lot or wafer set. Captures tool ID, chamber ID, run start/end timestamps, recipe name and version, process type discriminator (CVD, PVD, ALD, CMP, implant, etch, lithography, anneal, clean, wet clean), actual vs. target parameter deviations, run status, and wafers processed. Process-type-specific parameters stored as structured attributes: implant (species, dose, energy, tilt, twist, beam current), deposition (film material, thickness, rate, precursor flows, uniformity), CMP (slurry type, removal rate, WIWNU, endpoint detection), lithography (reticle ID, exposure dose, focus offset, overlay, CD measurement). Unified model aligned with SEMI E10/E142 equipment event patterns. SSOT for all FAB process execution records.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`photomask` (
    `photomask_id` BIGINT COMMENT 'Primary key for photomask',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: photomask has a technology_node STRING column capturing which technology node the mask is designed for. fabrication_technology_node is the authoritative reference master for technology nodes in this d',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Photomasks at advanced nodes ($500K-$2M+ each) are capitalized as fixed assets. Required for mask depreciation/amortization accounting, asset register maintenance, and financial reporting of mask set ',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key reference to the IC design project for which this mask was created. Links mask to product design lineage and tapeout records.',
    `mask_set_id` BIGINT COMMENT 'Business identifier for the complete mask set to which this photomask belongs. A mask set comprises all reticles required for a complete wafer fabrication process flow.',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: A photomask is generated from a specific physical layout (GDS) version. Mask generation, qualification, and reuse decisions require traceability to the exact layout revision. Mask engineers verify GDS',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: Photomask usage tracking and retirement decisions require knowing which engineering process step the mask is used at. Semiconductor lithography engineers track cumulative exposure counts per process s',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Ensures Photomask Supplier Traceability required by mask qualification and export control audits linking each mask to its supplier record.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost paid to acquire this photomask including mask fabrication, OPC, inspection, and shipping. Denominated in USD. Used for asset valuation and depreciation.',
    `cd_uniformity_specification` DECIMAL(18,2) COMMENT 'Maximum allowed CD variation across the mask field in nanometers (3-sigma). Tighter specifications required for advanced nodes. Typical range 1-5nm.',
    `cleaning_cycle_count` STRING COMMENT 'Number of times this mask has undergone wet or dry cleaning to remove particles and contamination. Excessive cleaning can damage mask patterns.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this photomask record was first created in the system. Audit trail for data governance and compliance.',
    `critical_defect_count` STRING COMMENT 'Number of critical (killer) defects that will print on wafer and cause yield loss. Subset of total defect count. Mask must be retired or repaired when this exceeds threshold.',
    `critical_dimension_target_nm` DECIMAL(18,2) COMMENT 'Target critical dimension (minimum feature size) for this mask layer in nanometers. Used to verify mask pattern fidelity and wafer print quality.',
    `cumulative_exposure_hours` DECIMAL(18,2) COMMENT 'Total hours this mask has been exposed to lithography light source (EUV or DUV). Tracks photochemical degradation and pellicle aging.',
    `cumulative_usage_count` STRING COMMENT 'Total number of wafer exposures performed with this mask since first use. Primary metric for mask wear tracking and lifecycle management.',
    `defect_retirement_threshold` STRING COMMENT 'Maximum critical defect count allowed before mask must be retired or sent for repair. Typically 1-5 defects depending on technology node and layer criticality.',
    `gds_file_checksum` STRING COMMENT 'MD5 or SHA-256 checksum of the GDSII file used to generate this mask. Ensures mask-to-design traceability and detects unauthorized pattern changes.. Valid values are `^[A-F0-9]{32,64}$`',
    `last_cleaning_date` DATE COMMENT 'Date when the mask was last cleaned. Used to schedule preventive cleaning and correlate defect growth with cleaning intervals.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this photomask record was last updated. Tracks data currency and supports change auditing.',
    `layer_name` STRING COMMENT 'Process layer designation for which this photomask is used (e.g., POLY, METAL1, VIA2, CONTACT). Corresponds to the GDS layer in the design database.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `lithography_wavelength` STRING COMMENT 'Exposure wavelength for which this mask is optimized: EUV (13.5nm), DUV ArF (193nm), DUV KrF (248nm), or i-line (365nm).. Valid values are `euv_13.5nm|duv_193nm|duv_248nm|i_line_365nm`',
    `mask_generation` STRING COMMENT 'Generation number of this mask within the mask set. Incremented when a mask is replaced due to defects, pattern revisions, or wear-out. Generation 1 is the original mask.',
    `mask_serial_number` STRING COMMENT 'Unique serial number assigned by the mask shop vendor for traceability and warranty purposes. Engraved on the reticle substrate.. Valid values are `^[A-Z0-9-]{10,25}$`',
    `mask_status` STRING COMMENT 'Current lifecycle status of the photomask: qualified (ready for production), in production (actively used), in inspection, in cleaning, in repair, quarantined (defect investigation), retired (end of life), or scrapped (disposed). [ENUM-REF-CANDIDATE: qualified|in_production|in_inspection|in_cleaning|in_repair|quarantined|retired|scrapped — 8 candidates stripped; promote to reference product]',
    `mask_type` STRING COMMENT 'Classification of photomask technology: binary (chrome on glass), attenuated phase shift mask (PSM), alternating PSM, EUV with pellicle, EUV without pellicle, or OPC-enhanced mask.. Valid values are `binary|attenuated_psm|alternating_psm|euv_pellicle|euv_non_pellicle|optical_proximity_correction`',
    `meef_value` DECIMAL(18,2) COMMENT 'Mask Error Enhancement Factor quantifying how mask pattern errors are amplified on the wafer. Higher MEEF indicates greater sensitivity to mask defects. Typical range 1.0 to 8.0.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory mask inspection. Calculated based on usage count, exposure hours, or calendar interval per mask management policy.',
    `notes` STRING COMMENT 'Free-text field for recording mask-specific observations, special handling instructions, repair history, or other contextual information not captured in structured fields.',
    `opc_version` STRING COMMENT 'Version identifier of the OPC software and recipe used to generate the mask pattern. Critical for mask-to-mask consistency and reticle enhancement technology tracking.. Valid values are `^[A-Z0-9._]{3,20}$`',
    `pellicle_installation_date` DATE COMMENT 'Date when the current pellicle was installed on the mask. Used to track pellicle aging and replacement cycles.',
    `pellicle_status` STRING COMMENT 'Current status of the protective pellicle membrane: installed (protecting mask surface), removed (for inspection or repair), damaged (requires replacement), or not applicable (EUV masks without pellicle).. Valid values are `installed|removed|damaged|not_applicable`',
    `purchase_order_number` STRING COMMENT 'Purchase order number under which this mask was procured. Links mask asset to procurement and financial records.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `qualification_date` DATE COMMENT 'Date when the mask passed final qualification inspection and was approved for production use. Marks the start of the masks production lifecycle.',
    `received_date` DATE COMMENT 'Date when the mask was received from the vendor and logged into the FAB inventory system. Marks the start of the masks asset lifecycle.',
    `registration_error_specification_nm` DECIMAL(18,2) COMMENT 'Maximum allowed pattern placement error relative to alignment marks in nanometers. Critical for layer-to-layer overlay accuracy. Typical range 2-10nm.',
    `retirement_date` DATE COMMENT 'Date when the mask was retired from production due to reaching usage threshold, excessive defects, or process obsolescence. Null if mask is still active.',
    `retirement_reason` STRING COMMENT 'Primary reason for mask retirement: usage limit reached, defect limit exceeded, pattern revision required, process obsolescence, physical damage, or lost/missing.. Valid values are `usage_limit|defect_limit|pattern_revision|process_obsolescence|physical_damage|lost`',
    `storage_location_code` STRING COMMENT 'Code identifying the physical storage location (reticle pod, SMIF pod, or automated reticle storage system slot) where the mask is currently stored when not in use.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `usage_retirement_threshold` STRING COMMENT 'Maximum cumulative usage count allowed before mask must be retired from production. Defined per technology node and mask type to ensure yield protection.',
    `warranty_expiration_date` DATE COMMENT 'Date when the vendor warranty for this mask expires. After this date, repair or replacement costs are borne by the FAB.',
    CONSTRAINT pk_photomask PRIMARY KEY(`photomask_id`)
) COMMENT 'Master record for photomasks (reticles) used in EUV and DUV lithography operations, capturing mask set ID, layer name, technology node, mask type (binary, PSM, EUV pellicle), OPC version, MEEF value, mask generation, pellicle status, inspection history summary, usage count, cleaning cycle count, and retirement threshold. SSOT for mask inventory, lithography step qualification, and reticle lifecycle management within the FAB.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` (
    `fabrication_technology_node_id` BIGINT COMMENT 'Unique identifier for the semiconductor technology node record. Primary key.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Technology nodes require formal certifications (ISO9001, IATF16949 for automotive, AEC-Q100) to qualify for production. The node has iatf16949_certified_flag and iso9001_certified_flag confirming cert',
    `fab_facility_id` BIGINT COMMENT 'Identifier of the primary fabrication facility where this technology node is manufactured. Links to the fab facility master data.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Technology nodes (e.g., 5nm, 7nm, 28nm) are foundry-specific offerings. Fabless companies must track which foundry supplier offers and qualifies each technology node for sourcing decisions, technology',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: The fabs internal technology node must be reconciled with the product catalogs process_node for product qualification sign-off, customer commitments, and yield reporting. A semiconductor domain expe',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this technology node record is currently active and available for use in manufacturing and design operations. False indicates archived or deprecated nodes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology node record was first created in the system. Audit trail for data lineage and compliance.',
    `design_rule_complexity` STRING COMMENT 'Complexity level of Design for Manufacturability (DFM) rules required for this node. Higher complexity nodes require more sophisticated Optical Proximity Correction (OPC) and restricted design rules.. Valid values are `low|medium|high|extreme`',
    `dfm_enabled_flag` BOOLEAN COMMENT 'Indicates whether Design for Manufacturability (DFM) checks and optimizations are mandatory for designs targeting this node. True for advanced nodes requiring OPC, dummy fill, and restricted design rules.',
    `dft_enabled_flag` BOOLEAN COMMENT 'Indicates whether Design for Testability (DFT) structures (scan chains, BIST, ATPG patterns) are required for designs on this node. Ensures adequate test coverage for quality assurance.',
    `ear_classification` STRING COMMENT 'Export Control Classification Number (ECCN) under US Export Administration Regulations (EAR) for this technology node. Determines export licensing requirements to restricted countries.',
    `eol_announcement_date` DATE COMMENT 'Date when the technology node was officially announced for end-of-life phase-out. Triggers Product Change Notification (PCN) and Last Time Buy (LTB) processes for customers.',
    `iatf16949_certified_flag` BOOLEAN COMMENT 'Indicates whether this technology node is certified under IATF 16949 Automotive Quality Management standards, required for automotive-grade semiconductor production.',
    `iso9001_certified_flag` BOOLEAN COMMENT 'Indicates whether the manufacturing process for this technology node is certified under ISO 9001 Quality Management System standards.',
    `itar_controlled_flag` BOOLEAN COMMENT 'Indicates whether this technology node is subject to ITAR (International Traffic in Arms Regulations) export controls due to defense or aerospace applications. Restricts international technology transfer.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology node record was last updated. Tracks data currency and change history for audit and compliance purposes.',
    `lithography_technology` STRING COMMENT 'Primary lithography technology used for patterning in this node. DUV (Deep Ultraviolet) for mature nodes, EUV (Extreme Ultraviolet) for advanced nodes below 7nm.. Valid values are `duv|euv|immersion|dry`',
    `mask_set_cost_usd` DECIMAL(18,2) COMMENT 'Cost of a full photomask set for this technology node in US dollars. Significant cost driver for advanced nodes using EUV lithography. Business-confidential pricing data.',
    `metal_layer_count` STRING COMMENT 'Total number of metal interconnect layers available in the Back End of Line (BEOL) stack for this technology node. Typically ranges from 6 to 15+ layers depending on node complexity.',
    `minimum_feature_size_nm` DECIMAL(18,2) COMMENT 'The smallest feature dimension that can be reliably manufactured in this technology node, measured in nanometers. Critical dimension for lithography and patterning capability.',
    `modified_by_user` STRING COMMENT 'Identifier of the user or system process that last modified this technology node record. Supports audit trail and accountability requirements.',
    `node_code` STRING COMMENT 'Internal alphanumeric code used to uniquely identify the technology node in manufacturing execution systems and product lifecycle management systems.',
    `node_generation` STRING COMMENT 'Generation classification of the node (e.g., Leading Edge, Mature, Legacy). Indicates the relative maturity and market positioning of the process technology.',
    `node_name` STRING COMMENT 'Human-readable name of the technology node (e.g., 5nm, 7nm, 14nm, 28nm, 65nm, 90nm). Industry-standard designation for the process generation.',
    `nre_cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated Non-Recurring Engineering (NRE) cost in US dollars for a typical design tapeout on this technology node. Includes mask set costs, design services, and qualification expenses. Business-confidential pricing data.',
    `power_performance_area_rating` STRING COMMENT 'Qualitative or quantitative assessment of the nodes Power, Performance, and Area (PPA) characteristics relative to prior generations. Critical metric for competitive positioning.',
    `process_flow_version` STRING COMMENT 'Version identifier of the manufacturing process flow (sequence of FEOL, MOL, BEOL steps) defined for this technology node. Tracks process recipe evolution and engineering changes.',
    `production_readiness_date` DATE COMMENT 'Date when the technology node was certified as production-ready and available for high-volume manufacturing (HVM). Null if still in development or qualification.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the technology node. Development: R&D phase. Qualification: undergoing reliability and yield validation. Qualified: approved for production. Production: active manufacturing. Mature: stable high-volume. EOL (End of Life): phase-out planned.. Valid values are `development|qualification|qualified|production|mature|eol`',
    `reach_compliant_flag` BOOLEAN COMMENT 'Indicates whether the chemicals and materials used in this technology node comply with EU REACH Regulation for chemical safety and substance registration.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates whether the manufacturing process for this technology node complies with EU RoHS Directive restrictions on hazardous substances (lead, mercury, cadmium, etc.).',
    `supported_application_types` STRING COMMENT 'Comma-separated list of target application domains optimized for this node (e.g., Mobile, Automotive, AI/ML, IoT, High-Performance Computing, Networking). Guides product design-in decisions.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target percentage of good dies per wafer for this technology node at maturity. Key performance indicator for manufacturing efficiency and cost competitiveness.',
    `transistor_architecture` STRING COMMENT 'Type of transistor structure used in this technology node. Planar for older nodes, FinFET (Fin Field-Effect Transistor) for 22nm-7nm, GAA (Gate All Around) for 3nm and below.. Valid values are `planar|finfet|gaa|nanosheet|nanowire`',
    `wafer_size_mm` STRING COMMENT 'Standard wafer diameter supported by this technology node, typically 200mm (8-inch) or 300mm (12-inch). Determines fab equipment compatibility and die yield economics.',
    CONSTRAINT pk_fabrication_technology_node PRIMARY KEY(`fabrication_technology_node_id`)
) COMMENT 'Reference master for semiconductor technology nodes supported in the FAB, capturing node name (e.g., 5nm, 7nm, 28nm, 65nm), node generation, transistor architecture (planar, FinFET, GAA), minimum feature size, metal layer count, PDK version reference, qualification status, and production readiness date. SSOT for node-level process and product classification.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` (
    `fab_yield_record_id` BIGINT COMMENT 'Unique identifier for the FAB yield record. Primary key for this transactional yield capture event.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customers receive yield reports as part of quality SLAs and foundry agreements. Direct account FK on fab_yield_record supports customer-facing yield reporting, SLA compliance tracking, and yield guara',
    `bin_definition_id` BIGINT COMMENT 'Foreign key linking to test.bin_definition. Business justification: Fab yield records track bin_1_die_count, bin_2_die_count, bin_3_die_count which correspond directly to test bin definitions. Linking to bin_definition enables yield management systems to interpret bin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Yield loss financial impact is allocated to the cost center overseeing the wafer lot.',
    `fab_facility_id` BIGINT COMMENT 'Reference to the FAB facility where this yield measurement was captured. Enables multi-site yield comparison and benchmarking.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the inspection or metrology equipment used to capture this yield measurement (e.g., KLA ICOS system). Enables equipment-specific yield correlation.',
    `photomask_id` BIGINT COMMENT 'Reference to the photomask set used for lithography on this wafer. Enables correlation of yield to mask quality and OPC effectiveness.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot to which this yield record belongs. Enables lot-level yield aggregation and genealogy tracking.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Yield-by-process-flow reporting for engineering improvement decisions requires linking yield records to the engineering process flow. Process engineers use this to identify which flow revisions correl',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Enables Yield Dashboard to aggregate yields per IC catalog product.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Yield analysis reports are aggregated per design project; direct FK enables automated project‑level yield dashboards and root‑cause tracking.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Fab yield records are generated at inspection checkpoints. The checkpoint_code on fab_yield_record is a denormalization signal pointing to an inspection event. A FK to inspection_lot enables traceabil',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Yield records determine good die count available to fulfill an order line. Allocation planning and customer delivery confirmation in semiconductor operations require yield-to-order-line traceability t',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: Yield-to-process-run correlation is fundamental for yield improvement engineering. Semiconductor yield engineers link fab_yield_record to lot_process_run to correlate yield outcomes with specific proc',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: DFM yield improvement loops correlate yield loss patterns against the physical layout version (routing density, metal fill, cell placement). Systematic yield excursion analysis requires linking yield ',
    `wafer_id` BIGINT COMMENT 'Reference to the specific wafer for which yield is being recorded. Links to the wafer master record in the fabrication domain.',
    `process_flow_id` BIGINT COMMENT 'Reference to the process route or recipe used for this wafer. Links yield outcomes to specific process flows.',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: Yield benchmarking across process technology nodes for engineering roadmap decisions requires the engineering node reference. fab_yield_record already links to fabrication_technology_node; the process',
    `yield_record_id` BIGINT COMMENT 'Foreign key linking to quality.yield_record. Business justification: fab_yield_record (MES) and yield_record (QMS) represent the same business concept from different system perspectives. A direct FK enables yield reconciliation between MES and QMS systems — a standard ',
    `revision_id` BIGINT COMMENT 'Foreign key linking to design.design_revision. Business justification: Yield records must be traceable to the specific design revision fabricated, enabling yield comparison across ECO revisions. ECO yield impact analysis — determining whether a design change improved or ',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Yield records are tracked per tapeout to measure first-silicon yield against expected yield targets specified at tapeout sign-off. Foundry-customer yield reporting, NRE milestone payments, and tapeout',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber-to-chamber yield variation is a critical semiconductor manufacturing concern. Yield records must be linked to the specific chamber (not just the tool) to support chamber matching analysis, SPC',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Fab yield records are populated from wafer probe run results in YMS workflows. Linking the yield record to the probe run that generated the die count and yield data enables direct audit traceability a',
    `bin_1_die_count` STRING COMMENT 'Number of die classified into bin 1 (typically highest quality/performance bin). Part of bin-level yield breakdown.',
    `bin_2_die_count` STRING COMMENT 'Number of die classified into bin 2 (typically second-tier quality/performance bin). Part of bin-level yield breakdown.',
    `bin_3_die_count` STRING COMMENT 'Number of die classified into bin 3 (typically third-tier quality/performance bin). Part of bin-level yield breakdown.',
    `checkpoint_code` STRING COMMENT 'The FAB inline checkpoint at which this yield measurement was captured. Distinguishes FEOL, MOL, BEOL, and pre-probe stages. [ENUM-REF-CANDIDATE: POST_FEOL|POST_MOL|POST_BEOL|PRE_PROBE|POST_CMP|POST_LITHO|POST_ETCH|POST_IMPLANT|INLINE_INSPECTION — 9 candidates stripped; promote to reference product]',
    `comments` STRING COMMENT 'Free-text comments or notes about this yield measurement, including observations, anomalies, or contextual information for root cause analysis.',
    `control_limit_lower` DECIMAL(18,2) COMMENT 'Lower control limit for yield percentage at this checkpoint. Part of Statistical Process Control (SPC) monitoring.',
    `control_limit_upper` DECIMAL(18,2) COMMENT 'Upper control limit for yield percentage at this checkpoint. Part of Statistical Process Control (SPC) monitoring.',
    `design_loss_die_count` STRING COMMENT 'Number of die lost due to design-related issues (DFM violations, timing failures, functional failures). Part of yield loss pareto analysis.',
    `disposition_status` STRING COMMENT 'The disposition decision for the wafer or lot based on this yield measurement. Determines next processing step or lot hold.. Valid values are `PASS|FAIL|HOLD|REWORK|SCRAP`',
    `excursion_severity_level` STRING COMMENT 'Severity classification of the yield excursion event. Determines escalation path and response urgency.. Valid values are `CRITICAL|MAJOR|MINOR|NONE`',
    `good_die_count` STRING COMMENT 'Number of die that passed yield criteria at this checkpoint. Represents the actual usable die count after defect screening and binning.',
    `gross_die_count` STRING COMMENT 'Total number of die on the wafer before yield screening. Represents the theoretical maximum die count based on wafer size and die layout.',
    `hold_reason_code` STRING COMMENT 'The reason code if the wafer or lot was placed on hold due to yield excursion. Links to hold reason reference data.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The date and time when the yield measurement was captured at the inline checkpoint. Represents the business event time of the yield observation.',
    `process_loss_die_count` STRING COMMENT 'Number of die lost due to process-related defects (CVD, PVD, ALD, CMP, etch, implant issues). Part of yield loss pareto analysis.',
    `random_defect_die_count` STRING COMMENT 'Number of die lost due to random defects (particles, contamination, handling damage). Part of yield loss pareto analysis.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this yield record was first created in the data platform. Audit trail for data lineage and compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this yield record was last updated in the data platform. Audit trail for data lineage and compliance.',
    `reject_bin_die_count` STRING COMMENT 'Number of die classified into reject bins (failed die that do not meet minimum specifications). Part of bin-level yield breakdown.',
    `rework_flag` BOOLEAN COMMENT 'Boolean indicator that this wafer is eligible for rework based on yield results. Drives rework routing decisions.',
    `scrap_flag` BOOLEAN COMMENT 'Boolean indicator that this wafer should be scrapped based on yield results. Triggers scrap disposition and cost accounting.',
    `source_system` STRING COMMENT 'The Manufacturing Execution System (MES) or inspection system that generated this yield record (e.g., Applied Materials SmartFactory, Camstar, KLA ICOS).',
    `specification_limit_lower` DECIMAL(18,2) COMMENT 'Lower specification limit for yield percentage at this checkpoint. Represents minimum acceptable yield threshold.',
    `systematic_defect_die_count` STRING COMMENT 'Number of die lost due to systematic defects (OPC errors, MEEF issues, lithography hotspots). Part of yield loss pareto analysis.',
    `yield_excursion_flag` BOOLEAN COMMENT 'Boolean indicator that this yield record represents an excursion event (yield below control limits or specification). Triggers root cause analysis and corrective action.',
    `yield_for_lot` BIGINT COMMENT 'FK to fabrication.fabrication_wafer_lot.fabrication_wafer_lot_id — Yield records are captured at lot level at key FAB checkpoints.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Calculated yield percentage at this checkpoint (good_die_count / gross_die_count * 100). Primary yield metric for FAB inline performance tracking.',
    `yield_record_for_lot` BIGINT COMMENT 'FK to fabrication.wafer_lot.wafer_lot_id — Yield records reference the lot measured. Required for lot-level yield tracking and excursion detection.',
    CONSTRAINT pk_fab_yield_record PRIMARY KEY(`fab_yield_record_id`)
) COMMENT 'Transactional record capturing wafer-level and lot-level yield outcomes at key FAB inline checkpoints (post-FEOL, post-MOL, post-BEOL, pre-probe), recording gross die count, good die count, yield percentage, yield loss pareto by category (process, design, random defect, systematic), bin-level yield breakdown, and yield excursion flags. SSOT for FAB inline yield data distinct from final test yield (owned by test domain) and distinct from SPC/metrology analysis (owned by quality domain).';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`mask_set` (
    `mask_set_id` BIGINT COMMENT 'Primary key for mask_set',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Mask set procurement and amortization costs (mask sets cost $1M-$15M+ at advanced nodes) are tracked to specific cost centers. Required for mask amortization accounting, cost-per-wafer calculations, a',
    `derived_from_mask_set_id` BIGINT COMMENT 'Self-referencing FK on mask_set (derived_from_mask_set_id)',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: mask_set is a master reference for collections of photomasks used in lithography. A mask_set is designed for a specific technology node (e.g., 5nm EUV, 28nm DUV). fabrication_technology_node is the au',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Mask sets ($1M-$15M+ at advanced nodes) are capitalized as fixed assets and amortized over wafer starts. Required for mask set amortization accounting, asset register maintenance, and technology node ',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Mask set qualification and reuse decisions require knowing which engineering process flow the mask set supports. Semiconductor mask engineers track mask set-to-process-flow assignments for NRE cost al',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Mask sets are procured and retired per IC product — mask cost allocation, product lifecycle management (EOL triggers mask retirement), and NPI tracking all require linking a mask set to its IC catalog',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: A mask set is procured and qualified for a specific IC design project. Mask NRE cost allocation, mask reuse eligibility analysis, and customer billing for mask costs all require direct mask-set-to-des',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Mask sets are procured from specialized photomask suppliers (Toppan, DNP, Photronics). Tracking supplier at the mask set level supports procurement contracts, supplier qualification for mask making, P',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: A mask set is manufactured to the layer stack and OPC rules of a specific PDK version. Mask reuse qualification and compatibility checks require knowing which PDK version generated the mask set. Fab m',
    `quality_qualification_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_qualification_program. Business justification: Mask sets must be formally qualified before use in production, especially for new technology nodes. Semiconductor fabs maintain mask set qualification programs for IATF 16949 compliance. The complianc',
    `application_area` STRING COMMENT 'Primary product domain where the mask set is applied.',
    `compliance_status` STRING COMMENT 'Regulatory or internal compliance status of the mask set.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the mask set record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date after which the mask set is no longer valid (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which the mask set is considered valid for production.',
    `exposure_tool` STRING COMMENT 'Name or identifier of the lithography tool that uses this mask set.',
    `inspection_date` DATE COMMENT 'Date of the most recent quality inspection of the mask set.',
    `inspection_result` STRING COMMENT 'Outcome of the latest inspection.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the mask set record.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date and time the mask set was most recently used in production.',
    `lithography_technology` STRING COMMENT 'Lithography technology for which the mask set is designed.',
    `mask_cost_usd` DECIMAL(18,2) COMMENT 'Acquisition cost of the mask set in US dollars.',
    `mask_layer_count` STRING COMMENT 'Number of patterned layers contained in the mask set.',
    `mask_material` STRING COMMENT 'Material composition of the mask (e.g., quartz, glass, silicon).',
    `mask_set_category` STRING COMMENT 'Category indicating whether the mask set is a standard, custom, or prototype design.',
    `mask_set_code` STRING COMMENT 'External catalogue or part number assigned to the mask set by the fab.',
    `mask_set_description` STRING COMMENT 'Free‑form description of the mask sets purpose and characteristics.',
    `mask_set_name` STRING COMMENT 'Human‑readable name of the mask set used by engineers and planners.',
    `mask_set_status` STRING COMMENT 'Current lifecycle state of the mask set.',
    `mask_thickness_nm` DECIMAL(18,2) COMMENT 'Physical thickness of the mask substrate in nanometres.',
    `mask_type` STRING COMMENT 'Category of mask based on its physical principle.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the mask set.',
    `owner_department` STRING COMMENT 'Organizational department responsible for the mask set.',
    `priority` STRING COMMENT 'Priority level for scheduling mask set usage in fab planning.',
    `quality_grade` STRING COMMENT 'Quality grade assigned after inspection (A‑highest, D‑lowest).',
    `revision_date` DATE COMMENT 'Date when the current revision of the mask set was released.',
    `revision_number` STRING COMMENT 'Sequential revision number for engineering changes to the mask set.',
    `safety_classification` STRING COMMENT 'Safety handling class for the mask set according to fab safety standards.',
    `storage_location` STRING COMMENT 'Physical storage location or vault identifier for the mask set.',
    `usage_count` BIGINT COMMENT 'Total number of wafer lots processed with this mask set.',
    `version` STRING COMMENT 'Alphanumeric version label for the mask set (e.g., V1.2).',
    `wafer_size_mm` DECIMAL(18,2) COMMENT 'Diameter of wafers that the mask set is intended for, expressed in millimetres.',
    `wavelength_nm` DECIMAL(18,2) COMMENT 'Design wavelength of the lithography exposure system in nanometres.',
    CONSTRAINT pk_mask_set PRIMARY KEY(`mask_set_id`)
) COMMENT 'Master reference table for mask_set. Referenced by mask_set_id.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` (
    `fab_facility_id` BIGINT COMMENT 'Primary key for fab_facility',
    `chips_act_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.chips_act_obligation. Business justification: CHIPS Act funding is awarded to specific fab facilities with binding domestic production commitments and guardrail restrictions. The fab_facility must reference its governing CHIPS Act obligation for ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Each fab facility operates under a specific legal entity for statutory reporting, transfer pricing, and CHIPS Act compliance (e.g., TSMC Arizona vs. TSMC Taiwan are separate legal entities). Fundament',
    `parent_fab_facility_id` BIGINT COMMENT 'Self-referencing FK on fab_facility (parent_fab_facility_id)',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: Fab qualification and customer allocation decisions require knowing which engineering process technology nodes a facility supports. Semiconductor sales and operations planning uses this link for custo',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Fab facilities are mapped to profit centers for management P&L reporting and capacity cost allocation. Standard semiconductor finance practice — each fab is a profit center enabling facility-level pro',
    `capacity_wafer_per_month` BIGINT COMMENT 'Maximum number of wafers the facility can process in a calendar month.',
    `carbon_footprint_kgco2e` DECIMAL(18,2) COMMENT 'Monthly greenhouse‑gas emissions expressed in kilograms CO₂ equivalent.',
    `city` STRING COMMENT 'City where the facility is located.',
    `cleanroom_class` STRING COMMENT 'ISO cleanroom classification of the facilitys most stringent environment.',
    `compliance_status` STRING COMMENT 'Current compliance standing with regulatory and industry standards.',
    `contact_email` STRING COMMENT 'Primary email address for facility communications.',
    `contact_phone` STRING COMMENT 'Primary telephone number for facility communications.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the facility location.',
    `end_date` DATE COMMENT 'Date when the facility ceased operations (null if still active).',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Average monthly energy consumption measured in megawatt‑hours.',
    `environmental_certifications` STRING COMMENT 'Comma‑separated list of environmental certifications (e.g., ISO 14001).',
    `equipment_summary` STRING COMMENT 'Free‑text summary of key equipment types and models present.',
    `fab_area_sqft` DECIMAL(18,2) COMMENT 'Total usable floor area of the fab in square feet.',
    `fab_facility_description` STRING COMMENT 'Free‑form description of the facilitys capabilities and role.',
    `facility_code` STRING COMMENT 'External business code or identifier used to reference the facility in enterprise systems.',
    `facility_name` STRING COMMENT 'Human‑readable name of the fabrication facility.',
    `facility_type` STRING COMMENT 'Category of the facility based on its primary function.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the facility (decimal degrees).',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the facility.',
    `lithography_type` STRING COMMENT 'Primary lithography technology employed at the fab.',
    `location_address_line1` STRING COMMENT 'Primary street address of the facility.',
    `location_address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the facility (decimal degrees).',
    `maintenance_window` STRING COMMENT 'Typical time window (e.g., weekly, monthly) allocated for planned maintenance.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for overall facility management.',
    `next_audit_due` DATE COMMENT 'Scheduled date for the next compliance audit.',
    `notes` STRING COMMENT 'Any supplemental information or remarks about the facility.',
    `number_of_cleanrooms` STRING COMMENT 'Count of cleanroom spaces within the facility.',
    `number_of_equipment_units` STRING COMMENT 'Total number of major equipment units (e.g., lithography, etch, deposition) installed.',
    `operational_status` STRING COMMENT 'Current operational condition of the facility.',
    `restricted_access` BOOLEAN COMMENT 'Indicates whether the facility requires restricted (security‑cleared) access.',
    `safety_certifications` STRING COMMENT 'Comma‑separated list of safety certifications held (e.g., ISO 45001).',
    `shift_schedule` STRING COMMENT 'Number of production shifts operated per day.',
    `start_date` DATE COMMENT 'Date when the facility began operations.',
    `state_province` STRING COMMENT 'State or province of the facility location.',
    `waste_generated_tons` DECIMAL(18,2) COMMENT 'Total waste generated per month measured in metric tons.',
    `water_usage_m3` DECIMAL(18,2) COMMENT 'Average monthly water usage in cubic meters.',
    CONSTRAINT pk_fab_facility PRIMARY KEY(`fab_facility_id`)
) COMMENT 'Master reference table for fab_facility. Referenced by fab_facility_id.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`work_center` (
    `work_center_id` BIGINT COMMENT 'Primary key for work_center',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Work centers in semiconductor fabs are directly mapped to cost centers for labor and overhead allocation — a fundamental SAP/MES integration point. Required for work-center-level cost reporting, capac',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: work_center represents a physical area within a fab facility (cleanroom bay, process module area). Every work center belongs to exactly one fab facility. This is a fundamental organizational hierarchy',
    `parent_work_center_id` BIGINT COMMENT 'Self-referencing FK on work_center (parent_work_center_id)',
    `area_sq_m` DECIMAL(18,2) COMMENT 'Floor area of the work center in square meters.',
    `capacity_wafers_per_hour` STRING COMMENT 'Maximum number of wafers the work center can process in one hour.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the work center.',
    `control_system_version` STRING COMMENT 'Software version of the work centers control system.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work center record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level applied to data generated by this work center.',
    `effective_from` DATE COMMENT 'Date when the work center became operationally active.',
    `effective_until` DATE COMMENT 'Date when the work center is scheduled to be retired or decommissioned (nullable).',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Average energy usage of the work center measured in kilowatt‑hours per day.',
    `equipment_count` STRING COMMENT 'Number of major pieces of equipment installed in the work center.',
    `fab_line` STRING COMMENT 'Identifier of the fab line to which the work center belongs.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Average relative humidity within the work center.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the work center operates with automated equipment (true) or manual processes (false).',
    `last_calibration_date` DATE COMMENT 'Date when the work centers critical equipment was last calibrated.',
    `location` STRING COMMENT 'Physical location identifier (building, floor, or area) where the work center resides.',
    `maintenance_window_end` TIMESTAMP COMMENT 'Timestamp when the scheduled maintenance period ends.',
    `maintenance_window_start` TIMESTAMP COMMENT 'Timestamp when the scheduled maintenance period begins.',
    `manager_contact` STRING COMMENT 'Primary phone number for the work center manager.',
    `manager_name` STRING COMMENT 'Name of the person responsible for the work centers operations.',
    `next_calibration_due` DATE COMMENT 'Planned date for the next calibration of the work centers equipment.',
    `notes` STRING COMMENT 'Additional free‑form remarks or operational notes.',
    `operational_status` STRING COMMENT 'Real‑time operational condition of the work center.',
    `safety_rating` STRING COMMENT 'Safety classification of the work center based on internal risk assessments.',
    `shift_schedule` STRING COMMENT 'Standard shift pattern assigned to the work center.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Typical ambient temperature inside the work center.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the work center record.',
    `work_center_code` STRING COMMENT 'External or legacy code that uniquely identifies the work center within manufacturing systems.',
    `work_center_description` STRING COMMENT 'Free‑form description providing additional context about the work center.',
    `work_center_name` STRING COMMENT 'Human‑readable name of the work center used in reports and dashboards.',
    `work_center_status` STRING COMMENT 'Current operational state of the work center.',
    `work_center_type` STRING COMMENT 'Category of the work center based on the manufacturing process it supports.',
    CONSTRAINT pk_work_center PRIMARY KEY(`work_center_id`)
) COMMENT 'Master reference table for work_center. Referenced by work_center_id.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` (
    `wafer_run_record_id` BIGINT COMMENT 'Unique identifier for this wafer run record. Primary key for the association.',
    `equipment_run_id` BIGINT COMMENT 'Foreign key linking to the equipment run that processed this wafer. Each wafer_run_record belongs to exactly one equipment run execution.',
    `wafer_id` BIGINT COMMENT 'Foreign key linking to the individual wafer that was processed in this equipment run. Each wafer_run_record tracks one wafers participation in one equipment run.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this wafer_run_record was created in the data platform. Standard audit field.',
    `per_wafer_measurement_result` STRING COMMENT 'Wafer-specific measurement or metrology result captured during or immediately after this equipment run. May contain structured JSON or delimited values for multiple measurement points. Enables wafer-level process control and yield correlation. Explicitly identified in detection reasoning.',
    `process_end_timestamp` TIMESTAMP COMMENT 'Timestamp when processing completed for this specific wafer within the equipment run. Used to calculate per-wafer cycle time and identify processing anomalies.',
    `process_start_timestamp` TIMESTAMP COMMENT 'Timestamp when processing began for this specific wafer within the equipment run. May differ from equipment_run start time in sequential or batch processing scenarios.',
    `slot_position` STRING COMMENT 'Physical slot or chamber position where this wafer was loaded during the equipment run. Critical for identifying position-dependent process variations and chamber uniformity analysis. Explicitly identified in detection reasoning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this wafer_run_record was last updated. Standard audit field.',
    `wafer_disposition_in_run` STRING COMMENT 'Disposition decision for this wafer based on the results of this specific equipment run. Determines whether the wafer proceeds to the next process step, is held for review, scrapped, or sent for rework. Explicitly identified in detection reasoning.',
    `wafer_run_status` STRING COMMENT 'Per-wafer processing status for this equipment run. Captures whether this specific wafer completed successfully, was aborted, skipped, or failed during the run. Allows individual wafer failures within a batch run. Explicitly identified in detection reasoning.',
    CONSTRAINT pk_wafer_run_record PRIMARY KEY(`wafer_run_record_id`)
) COMMENT 'This association product represents the operational record of an individual wafer processed during a specific equipment run. In semiconductor FAB operations, equipment runs process multiple wafers simultaneously (batch processing), and each wafer undergoes multiple equipment runs throughout its fabrication lifecycle. This junction entity captures per-wafer process execution data including slot position in the equipment chamber, wafer-specific measurement results, per-wafer run status, and disposition outcomes. Essential for wafer-level yield correlation analysis, process genealogy tracking, and root cause analysis of defects. Replaces the anti-pattern denormalized wafer_slot_map string attribute on equipment_run. Aligned with SEMI E10/E142 MES data model patterns for wafer-level process tracking.. Existence Justification: In semiconductor FAB operations, equipment runs process multiple wafers in batch mode (one equipment run processes 25-50 wafers simultaneously in a chamber), and each wafer undergoes hundreds of equipment runs throughout its fabrication lifecycle (CVD, etch, lithography, implant, CMP, etc.). The wafer_run_record is a recognized MES operational entity that captures per-wafer process execution data including slot position, per-wafer measurements, and disposition outcomes. This is essential for wafer-level yield analysis and process genealogy tracking.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` (
    `process_step_work_center_qualification_id` BIGINT COMMENT 'Unique identifier for this process step to work center qualification record. Primary key.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to the process step that requires qualification for execution at specific work centers.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to the work center that is qualified to execute the process step.',
    `capacity_wafers_per_hour` STRING COMMENT 'Maximum number of wafers per hour that this work center can process for this specific process step. May differ from the work centers general capacity due to step-specific constraints (recipe complexity, batch size, cycle time). Used by APS for capacity planning and dispatching logic. Sourced from detection phase relationship_data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system. Used for audit trail.',
    `effective_end_date` DATE COMMENT 'Date when this qualification expires or is retired. Null for currently active qualifications. Used for historical tracking and planned equipment retirements. Sourced from detection phase relationship_data.',
    `effective_start_date` DATE COMMENT 'Date when this qualification becomes active and the work center can begin processing lots at this step. Supports time-based qualification management and change control. Sourced from detection phase relationship_data.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this qualification record. Used for accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last modified. Used for change tracking.',
    `last_qualification_review_date` DATE COMMENT 'Date when this qualification was last reviewed or revalidated. Used for periodic qualification maintenance and compliance.',
    `preferred_flag` BOOLEAN COMMENT 'Boolean indicator of whether this work center is the preferred or primary choice for executing this process step. Dispatching systems prioritize preferred work centers when multiple qualified options exist. Sourced from detection phase relationship_data.',
    `qualification_notes` STRING COMMENT 'Free-form text capturing special conditions, restrictions, or context for this qualification (e.g., Use only for rework lots, Requires engineering approval, Limited to product family X).',
    `qualification_status` STRING COMMENT 'Current status of the qualification indicating whether the work center is authorized to process this step. Values: QUALIFIED (active and approved), PENDING (under evaluation), SUSPENDED (temporarily disabled), EXPIRED (past effective date), REVOKED (permanently removed). Sourced from detection phase relationship_data.',
    `qualified_by` STRING COMMENT 'Name or identifier of the engineer or manager who approved this qualification. Used for accountability and audit trail.',
    `qualified_date` DATE COMMENT 'Date when the work center was officially qualified to execute this process step. Used for audit trail and compliance tracking. Sourced from detection phase relationship_data.',
    CONSTRAINT pk_process_step_work_center_qualification PRIMARY KEY(`process_step_work_center_qualification_id`)
) COMMENT 'This association product represents the qualification matrix between fabrication process steps and work centers in semiconductor FAB operations. It captures which work centers are qualified and authorized to execute specific process steps, enabling FAB dispatching systems to route WIP lots to appropriate equipment. Each record links one process step to one qualified work center with qualification status, capacity constraints, preference indicators, and effective date ranges that exist only in the context of this qualification relationship. This is the authoritative source for step-to-tool routing decisions in manufacturing execution systems (MES) and advanced planning systems (APS).. Existence Justification: In semiconductor FAB operations, the process step to work center qualification matrix is a foundational operational concept managed by manufacturing engineering and used continuously by MES dispatching systems. A single process step (e.g., Litho EUV Layer 5) can be qualified to execute on multiple work centers (e.g., ASML Tool 1, ASML Tool 2, ASML Tool 3), and a single work center can be qualified to execute multiple process steps across different product families and layers. The business actively manages these qualifications with approval workflows, effective dates, capacity constraints, and preference flags—this is not a derived correlation but an operational master data set that determines which lots can be routed to which equipment.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_parent_lot_fabrication_wafer_lot_id` FOREIGN KEY (`parent_lot_fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ADD CONSTRAINT `fk_fabrication_fabrication_wafer_lot_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_mask_set_id` FOREIGN KEY (`mask_set_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`mask_set`(`mask_set_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ADD CONSTRAINT `fk_fabrication_wafer_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ADD CONSTRAINT `fk_fabrication_process_step_fabrication_process_recipe_id` FOREIGN KEY (`fabrication_process_recipe_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe`(`fabrication_process_recipe_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ADD CONSTRAINT `fk_fabrication_process_step_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ADD CONSTRAINT `fk_fabrication_process_flow_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_equipment_run_id` FOREIGN KEY (`equipment_run_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`equipment_run`(`equipment_run_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ADD CONSTRAINT `fk_fabrication_lot_move_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ADD CONSTRAINT `fk_fabrication_wafer_start_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ADD CONSTRAINT `fk_fabrication_fabrication_lot_hold_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ADD CONSTRAINT `fk_fabrication_lot_disposition_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`work_center`(`work_center_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ADD CONSTRAINT `fk_fabrication_fab_run_card_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_fabrication_process_recipe_id` FOREIGN KEY (`fabrication_process_recipe_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe`(`fabrication_process_recipe_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ADD CONSTRAINT `fk_fabrication_equipment_run_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ADD CONSTRAINT `fk_fabrication_photomask_mask_set_id` FOREIGN KEY (`mask_set_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`mask_set`(`mask_set_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ADD CONSTRAINT `fk_fabrication_fabrication_technology_node_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_photomask_id` FOREIGN KEY (`photomask_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`photomask`(`photomask_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_fabrication_wafer_lot_id` FOREIGN KEY (`fabrication_wafer_lot_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`(`fabrication_wafer_lot_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ADD CONSTRAINT `fk_fabrication_fab_yield_record_process_flow_id` FOREIGN KEY (`process_flow_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_flow`(`process_flow_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ADD CONSTRAINT `fk_fabrication_mask_set_derived_from_mask_set_id` FOREIGN KEY (`derived_from_mask_set_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`mask_set`(`mask_set_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ADD CONSTRAINT `fk_fabrication_mask_set_fabrication_technology_node_id` FOREIGN KEY (`fabrication_technology_node_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fabrication_technology_node`(`fabrication_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ADD CONSTRAINT `fk_fabrication_fab_facility_parent_fab_facility_id` FOREIGN KEY (`parent_fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`work_center` ADD CONSTRAINT `fk_fabrication_work_center_fab_facility_id` FOREIGN KEY (`fab_facility_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`fab_facility`(`fab_facility_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`work_center` ADD CONSTRAINT `fk_fabrication_work_center_parent_work_center_id` FOREIGN KEY (`parent_work_center_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`work_center`(`work_center_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` ADD CONSTRAINT `fk_fabrication_wafer_run_record_equipment_run_id` FOREIGN KEY (`equipment_run_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`equipment_run`(`equipment_run_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` ADD CONSTRAINT `fk_fabrication_wafer_run_record_wafer_id` FOREIGN KEY (`wafer_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`wafer`(`wafer_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ADD CONSTRAINT `fk_fabrication_process_step_work_center_qualification_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`process_step`(`process_step_id`);
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ADD CONSTRAINT `fk_fabrication_process_step_work_center_qualification_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `semiconductors_ecm`.`fabrication`.`work_center`(`work_center_id`);

-- ========= TAGS =========
ALTER SCHEMA `semiconductors_ecm`.`fabrication` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `semiconductors_ecm`.`fabrication` SET TAGS ('dbx_domain' = 'fabrication');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `customer_design_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Registration Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Foundry Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `mpw_order_id` SET TAGS ('dbx_business_glossary_term' = 'Mpw Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Mpw Shuttle Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `parent_lot_fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Lot Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `product_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Qualification Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `wafer_start_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_operation_name` SET TAGS ('dbx_business_glossary_term' = 'Current Operation Name');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_operation_number` SET TAGS ('dbx_business_glossary_term' = 'Current Operation Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_operation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,6}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_process_area` SET TAGS ('dbx_business_glossary_term' = 'Current Process Area');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `current_process_area` SET TAGS ('dbx_value_regex' = 'feol|mol|beol|metrology|test');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Days)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `hold_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `initial_wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Initial Wafer Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `is_hot_lot` SET TAGS ('dbx_business_glossary_term' = 'Is Hot Lot');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lot Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_business_glossary_term' = 'Lot Disposition');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_value_regex' = 'pass|fail|partial|rework|scrap|engineering_hold');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_notes` SET TAGS ('dbx_business_glossary_term' = 'Lot Notes');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'production|engineering|qualification|mpw|pilot|rework');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `lot_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lot Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `mes_system_source` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) System Source');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `mes_system_source` SET TAGS ('dbx_value_regex' = 'camstar|smartfactory|other');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `priority_class` SET TAGS ('dbx_business_glossary_term' = 'Priority Class');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `priority_class` SET TAGS ('dbx_value_regex' = 'hot|expedite|normal|engineering|low');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `process_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Node (Nanometers)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `process_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Process Time (Hours)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `queue_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Queue Time (Hours)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `rework_count` SET TAGS ('dbx_business_glossary_term' = 'Rework Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `route_version` SET TAGS ('dbx_business_glossary_term' = 'Route Version');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `route_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `sampling_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `sampling_plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `scrap_wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Scrap Wafer Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `split_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Split Sequence Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `wafer_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `wip_status` SET TAGS ('dbx_business_glossary_term' = 'Work In Process (WIP) Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot` ALTER COLUMN `wip_status` SET TAGS ('dbx_value_regex' = 'queued|in_process|on_hold|completed|scrapped|shipped');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'FAB (Fabrication Facility) Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `mask_set_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Route Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wafer Completion Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `crystal_orientation` SET TAGS ('dbx_business_glossary_term' = 'Crystal Orientation');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `crystal_orientation` SET TAGS ('dbx_value_regex' = '100|110|111');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `current_operation_number` SET TAGS ('dbx_business_glossary_term' = 'Current Operation Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `current_process_step` SET TAGS ('dbx_business_glossary_term' = 'Current Process Step');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Diameter (Millimeters)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Wafer Disposition Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'in_process|completed|scrapped|quarantined|on_hold|awaiting_inspection');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `doping_type` SET TAGS ('dbx_business_glossary_term' = 'Doping Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `doping_type` SET TAGS ('dbx_value_regex' = 'p_type|n_type|intrinsic');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `epitaxial_layer_flag` SET TAGS ('dbx_business_glossary_term' = 'Epitaxial Layer Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `epitaxial_resistivity_ohm_cm` SET TAGS ('dbx_business_glossary_term' = 'Epitaxial Layer Resistivity (Ohm-Centimeters)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `epitaxial_thickness_um` SET TAGS ('dbx_business_glossary_term' = 'Epitaxial Layer Thickness (Micrometers)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `expected_die_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `genealogy_path` SET TAGS ('dbx_business_glossary_term' = 'Wafer Genealogy Path');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `good_die_count` SET TAGS ('dbx_business_glossary_term' = 'Good Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `last_process_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Process Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `notch_orientation_degrees` SET TAGS ('dbx_business_glossary_term' = 'Notch Orientation (Degrees)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `resistivity_ohm_cm` SET TAGS ('dbx_business_glossary_term' = 'Resistivity (Ohm-Centimeters)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `rework_count` SET TAGS ('dbx_business_glossary_term' = 'Rework Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Scrap Reason Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `slot_position` SET TAGS ('dbx_business_glossary_term' = 'Slot Position');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,30}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `substrate_type` SET TAGS ('dbx_value_regex' = 'silicon|gallium_arsenide|silicon_carbide|gallium_nitride|sapphire|germanium');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `thickness_um` SET TAGS ('dbx_business_glossary_term' = 'Wafer Thickness (Micrometers)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `wafer_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer` ALTER COLUMN `wafer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Target Material Master Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `test_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Test Plan Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `chamber_configuration` SET TAGS ('dbx_business_glossary_term' = 'Chamber Configuration');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `change_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Control Reference');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `defect_density_target_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density Target (Per Square Centimeter)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `fmea_reference` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode and Effects Analysis (FMEA) Reference');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `gas_flow_parameters` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Parameters');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `power_settings_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Settings (Watts)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Process Duration (Seconds)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_layer_type` SET TAGS ('dbx_business_glossary_term' = 'Process Layer Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_layer_type` SET TAGS ('dbx_value_regex' = 'FEOL|MOL|BEOL');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_operation_type` SET TAGS ('dbx_business_glossary_term' = 'Process Operation Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Process Pressure (Torr)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `process_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Process Temperature (Celsius)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_qualified|in_qualification|qualified|requalification_required');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `recipe_code` SET TAGS ('dbx_business_glossary_term' = 'Recipe Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `recipe_description` SET TAGS ('dbx_business_glossary_term' = 'Recipe Description');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Name');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `recipe_status` SET TAGS ('dbx_business_glossary_term' = 'Recipe Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `recipe_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|suspended|obsolete');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Requalification Due Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'standard|hazardous_material|high_temperature|high_pressure|toxic_gas');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `spc_control_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Control Plan Reference');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `step_sequence_definition` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Definition');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `target_thickness_nm` SET TAGS ('dbx_business_glossary_term' = 'Target Thickness (Nanometers)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `uniformity_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Uniformity Target (Percent)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_process_recipe` ALTER COLUMN `yield_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Target (Percent)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `process_rework_target_step_id` SET TAGS ('dbx_business_glossary_term' = 'Rework Target Step Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `test_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Test Plan Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `tool_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Qualification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `critical_step_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Step Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `equipment_class` SET TAGS ('dbx_business_glossary_term' = 'Equipment Class');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `max_queue_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Queue Time (Minutes)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `min_batch_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Batch Size');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type (Front End of Line / Middle of Line / Back End of Line)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `operation_type` SET TAGS ('dbx_value_regex' = 'FEOL|MOL|BEOL');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `process_category` SET TAGS ('dbx_business_glossary_term' = 'Process Category');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `process_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Process Subcategory');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `rework_loop_indicator` SET TAGS ('dbx_business_glossary_term' = 'Rework Loop Indicator');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `sampling_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Sampling Rate (Percent)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `skip_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Skip Allowed Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `standard_queue_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Queue Time (Minutes)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `step_cost_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Step Cost Per Wafer');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `step_cost_per_wafer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `step_description` SET TAGS ('dbx_business_glossary_term' = 'Process Step Description');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `step_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Step Sequence Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `step_status` SET TAGS ('dbx_business_glossary_term' = 'Process Step Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `step_status` SET TAGS ('dbx_value_regex' = 'active|inactive|engineering|obsolete|pending_approval');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `target_cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target Cycle Time (Minutes)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Set Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `beol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Back End Of Line (BEOL) Step Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Classification');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `estimated_cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cycle Time (Days)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `fabrication_process_flow_description` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Description');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `feol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Front End Of Line (FEOL) Step Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `flow_revision` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Revision');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `flow_status` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `flow_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|frozen|obsolete');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `flow_type` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `flow_type` SET TAGS ('dbx_value_regex' = 'standard|mpw|engineering|qualification|rnd');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `is_customer_specific` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Specific Flow Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_business_glossary_term' = 'Lithography Technology');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_value_regex' = 'euv|duv|immersion|dry');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `mol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Middle Of Line (MOL) Step Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `qualification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|qualified|requalification_required');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `requires_nre` SET TAGS ('dbx_business_glossary_term' = 'Requires Non-Recurring Engineering (NRE) Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `total_process_steps` SET TAGS ('dbx_business_glossary_term' = 'Total Process Steps Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_value_regex' = 'planar|finfet|gaa|nanosheet');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_flow` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `lot_move_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Move ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'At Fabrication Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Operation Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `actual_flow_rate_sccm` SET TAGS ('dbx_business_glossary_term' = 'Actual Flow Rate (SCCM)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `actual_power_watts` SET TAGS ('dbx_business_glossary_term' = 'Actual Power (Watts)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `actual_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Actual Pressure (Torr)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `actual_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Actual Temperature (Celsius)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `control_job_code` SET TAGS ('dbx_business_glossary_term' = 'Control Job ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `control_job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,30}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'pass|fail|rework|scrap|hold|conditional_pass');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'nm|um|angstrom|ohm_cm|percent|ppm');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `move_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Move-In Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `move_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Move-Out Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `move_status` SET TAGS ('dbx_business_glossary_term' = 'Move Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `move_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|aborted|held|skipped');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'hot|expedite|normal|low');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `process_layer` SET TAGS ('dbx_business_glossary_term' = 'Process Layer');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `process_layer` SET TAGS ('dbx_value_regex' = 'FEOL|MOL|BEOL');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `process_module` SET TAGS ('dbx_business_glossary_term' = 'Process Module');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `process_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Process Time (Seconds)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `quantity_in` SET TAGS ('dbx_business_glossary_term' = 'Quantity In');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `quantity_out` SET TAGS ('dbx_business_glossary_term' = 'Quantity Out');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `queue_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Queue Time (Seconds)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `recipe_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `rework_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `sampling_flag` SET TAGS ('dbx_business_glossary_term' = 'Sampling Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Camstar_MES|SmartFactory_MES|SAP_PP');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_move` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Creates Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `customer_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Foundry Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `mpw_order_id` SET TAGS ('dbx_business_glossary_term' = 'Mpw Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `mpw_shuttle_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Project Wafer (MPW) Shuttle Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `product_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Qualification Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `product_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `test_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Test Plan Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `crystal_orientation` SET TAGS ('dbx_business_glossary_term' = 'Crystal Orientation');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `crystal_orientation` SET TAGS ('dbx_value_regex' = '^<[0-9]{3}>$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `doping_type` SET TAGS ('dbx_business_glossary_term' = 'Doping Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `doping_type` SET TAGS ('dbx_value_regex' = 'p_type|n_type|intrinsic');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `ear_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Classification');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `ear_classification` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `estimated_cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cycle Time (Days)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `parent_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Parent Lot Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `parent_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `priority_class` SET TAGS ('dbx_business_glossary_term' = 'Priority Class');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `priority_class` SET TAGS ('dbx_value_regex' = 'hot|standard|engineering|low');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `production_line` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `production_line` SET TAGS ('dbx_value_regex' = '^LINE[A-Z0-9]{2,6}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `resistivity_ohm_cm` SET TAGS ('dbx_business_glossary_term' = 'Resistivity (Ohm-Centimeter)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `split_reason` SET TAGS ('dbx_business_glossary_term' = 'Split Reason');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `substrate_type` SET TAGS ('dbx_business_glossary_term' = 'Substrate Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `substrate_type` SET TAGS ('dbx_value_regex' = 'silicon|soi|gaas|gan|sic');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Wafer Quantity');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_date` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_number` SET TAGS ('dbx_value_regex' = '^WS[0-9]{10}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_status` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_status` SET TAGS ('dbx_value_regex' = 'authorized|released|in_process|completed|cancelled|on_hold');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_type` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `wafer_start_type` SET TAGS ('dbx_value_regex' = 'production|engineering|qualification|mpw|pilot|rework');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `work_center` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_start` ALTER COLUMN `work_center` SET TAGS ('dbx_value_regex' = '^WC[0-9]{4}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `fabrication_lot_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Lot Hold ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `excursion_id` SET TAGS ('dbx_business_glossary_term' = 'Excursion Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Material Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Chart Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Goods Receipt Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `yield_loss_event_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Event Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `defect_density_threshold_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Defect Density Threshold Exceeded Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'resume|rework|scrap|quarantine|return_to_customer|engineering_review');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_cycle_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Hold Cycle Time (Hours)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_placement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placement Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|cancelled|expired');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `initiating_system` SET TAGS ('dbx_business_glossary_term' = 'Initiating System');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `mes_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `spc_rule_violation` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Rule Violation');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_lot_hold` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` SET TAGS ('dbx_subdomain' = 'lot_management');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `lot_disposition_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Disposition ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Rework Route ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Product ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `affected_wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Wafer Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `customer_approval_received` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Received');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `defect_die_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_authority` SET TAGS ('dbx_business_glossary_term' = 'Disposition Authority');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_authority_role` SET TAGS ('dbx_business_glossary_term' = 'Disposition Authority Role');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_authority_role` SET TAGS ('dbx_value_regex' = 'quality_engineer|production_supervisor|process_engineer|fab_manager|automated_system');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_number` SET TAGS ('dbx_business_glossary_term' = 'Disposition Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_number` SET TAGS ('dbx_value_regex' = '^DISP-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Disposition Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|executed|cancelled');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_type` SET TAGS ('dbx_business_glossary_term' = 'Disposition Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `disposition_type` SET TAGS ('dbx_value_regex' = 'accept|scrap|rework|downgrade|hold|ship_as_is');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `executed_by` SET TAGS ('dbx_business_glossary_term' = 'Executed By');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Executed Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `good_die_count` SET TAGS ('dbx_business_glossary_term' = 'Good Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `lot_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Lot Yield Percent');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment_failure|process_deviation|material_defect|operator_error|design_issue|contamination');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Scrap Reason Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `waiver_number` SET TAGS ('dbx_business_glossary_term' = 'Waiver Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`lot_disposition` ALTER COLUMN `waiver_number` SET TAGS ('dbx_value_regex' = '^WVR-[0-9]{8}-[A-Z0-9]{4}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `fab_run_card_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Run Card Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `customer_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `nre_order_id` SET TAGS ('dbx_business_glossary_term' = 'Nre Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `wafer_start_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Days)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `ear_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Classification');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `eco_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Order (ECO) Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_business_glossary_term' = 'Lot Disposition');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|quarantine|scrap');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification (PCN) Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'automotive|industrial|commercial|consumer');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_number` SET TAGS ('dbx_business_glossary_term' = 'Run Card Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_status` SET TAGS ('dbx_business_glossary_term' = 'Run Card Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|on_hold|completed|cancelled');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_type` SET TAGS ('dbx_business_glossary_term' = 'Run Card Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_type` SET TAGS ('dbx_value_regex' = 'production|engineering|qualification|rework|pilot|development');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `run_card_version` SET TAGS ('dbx_business_glossary_term' = 'Run Card Version');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `wafer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Wafer Quantity');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_run_card` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `equipment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Run ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Lithography Reticle ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `abort_reason` SET TAGS ('dbx_business_glossary_term' = 'Abort Reason');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `actual_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Actual Pressure Torr');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `actual_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Actual Temperature Celsius');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `alarm_count` SET TAGS ('dbx_business_glossary_term' = 'Alarm Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `cmp_removal_rate_angstrom_per_min` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Removal Rate Angstrom Per Minute');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `cmp_slurry_type` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Slurry Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `cmp_wiwnu_percent` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Within-Wafer Non-Uniformity (WIWNU) Percent');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `deposition_film_material` SET TAGS ('dbx_business_glossary_term' = 'Deposition Film Material');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `deposition_rate_angstrom_per_min` SET TAGS ('dbx_business_glossary_term' = 'Deposition Rate Angstrom Per Minute');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `deposition_thickness_angstrom` SET TAGS ('dbx_business_glossary_term' = 'Deposition Thickness Angstrom');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `deposition_uniformity_percent` SET TAGS ('dbx_business_glossary_term' = 'Deposition Uniformity Percent');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `implant_dose_atoms_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Implant Dose Atoms Per Square Centimeter');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `implant_energy_kev` SET TAGS ('dbx_business_glossary_term' = 'Implant Energy Kiloelectron Volts (keV)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `implant_species` SET TAGS ('dbx_business_glossary_term' = 'Implant Species');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `implant_tilt_angle_degrees` SET TAGS ('dbx_business_glossary_term' = 'Implant Tilt Angle Degrees');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `implant_twist_angle_degrees` SET TAGS ('dbx_business_glossary_term' = 'Implant Twist Angle Degrees');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `lithography_cd_measurement_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Critical Dimension (CD) Measurement Nanometers');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `lithography_exposure_dose_mj_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Lithography Exposure Dose Millijoules Per Square Centimeter');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `lithography_focus_offset_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Focus Offset Nanometers');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `lithography_overlay_x_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Overlay X-Axis Nanometers');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `lithography_overlay_y_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Overlay Y-Axis Nanometers');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `mes_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `process_type` SET TAGS ('dbx_business_glossary_term' = 'Process Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `run_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Run Duration Seconds');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'completed|aborted|failed|in_progress|paused');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `target_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Target Pressure Torr');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `target_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Celsius');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`equipment_run` ALTER COLUMN `wafer_slot_map` SET TAGS ('dbx_business_glossary_term' = 'Wafer Slot Map');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Photomask Identifier');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Project Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `mask_set_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `cd_uniformity_specification` SET TAGS ('dbx_business_glossary_term' = 'Critical Dimension (CD) Uniformity Specification');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `cleaning_cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Cycle Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `critical_dimension_target_nm` SET TAGS ('dbx_business_glossary_term' = 'Critical Dimension (CD) Target Nanometers (nm)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `cumulative_exposure_hours` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Exposure Hours');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `cumulative_usage_count` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Usage Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `defect_retirement_threshold` SET TAGS ('dbx_business_glossary_term' = 'Defect Retirement Threshold');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `gds_file_checksum` SET TAGS ('dbx_business_glossary_term' = 'Graphic Data System (GDS) File Checksum');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `gds_file_checksum` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{32,64}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `last_cleaning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cleaning Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `layer_name` SET TAGS ('dbx_business_glossary_term' = 'Layer Name');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `layer_name` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `lithography_wavelength` SET TAGS ('dbx_business_glossary_term' = 'Lithography Wavelength');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `lithography_wavelength` SET TAGS ('dbx_value_regex' = 'euv_13.5nm|duv_193nm|duv_248nm|i_line_365nm');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `mask_generation` SET TAGS ('dbx_business_glossary_term' = 'Mask Generation');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `mask_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Mask Serial Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `mask_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,25}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `mask_status` SET TAGS ('dbx_business_glossary_term' = 'Mask Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `mask_type` SET TAGS ('dbx_business_glossary_term' = 'Mask Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `mask_type` SET TAGS ('dbx_value_regex' = 'binary|attenuated_psm|alternating_psm|euv_pellicle|euv_non_pellicle|optical_proximity_correction');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `meef_value` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Value');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `opc_version` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Version');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `opc_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._]{3,20}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `pellicle_installation_date` SET TAGS ('dbx_business_glossary_term' = 'Pellicle Installation Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `pellicle_status` SET TAGS ('dbx_business_glossary_term' = 'Pellicle Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `pellicle_status` SET TAGS ('dbx_value_regex' = 'installed|removed|damaged|not_applicable');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `registration_error_specification_nm` SET TAGS ('dbx_business_glossary_term' = 'Registration Error Specification Nanometers (nm)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_value_regex' = 'usage_limit|defect_limit|pattern_revision|process_obsolescence|physical_damage|lost');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `usage_retirement_threshold` SET TAGS ('dbx_business_glossary_term' = 'Usage Retirement Threshold');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`photomask` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Foundry Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `design_rule_complexity` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Complexity Level');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `design_rule_complexity` SET TAGS ('dbx_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `dfm_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Enabled Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `dft_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Design for Testability (DFT) Enabled Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `ear_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Administration Regulations (EAR) Classification');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `eol_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Announcement Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `iatf16949_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'International Automotive Task Force (IATF) 16949 Certified Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `iso9001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_business_glossary_term' = 'Lithography Technology Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `lithography_technology` SET TAGS ('dbx_value_regex' = 'duv|euv|immersion|dry');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `mask_set_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Cost (USD)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `mask_set_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `minimum_feature_size_nm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Feature Size (Nanometers)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `node_generation` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Generation');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Name');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `nre_cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Cost Estimate (USD)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `nre_cost_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `power_performance_area_rating` SET TAGS ('dbx_business_glossary_term' = 'Power Performance Area (PPA) Rating');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `process_flow_version` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Version');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `production_readiness_date` SET TAGS ('dbx_business_glossary_term' = 'Production Readiness Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Qualification Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'development|qualification|qualified|production|mature|eol');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `rohs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Restriction of Hazardous Substances (RoHS) Compliant Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `supported_application_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Application Types');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_business_glossary_term' = 'Transistor Architecture Type');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `transistor_architecture` SET TAGS ('dbx_value_regex' = 'planar|finfet|gaa|nanosheet|nanowire');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fabrication_technology_node` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (Millimeters)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `fab_yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Yield Record Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Facility Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Equipment Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `photomask_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Route Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Yield Record Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Design Revision Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `bin_1_die_count` SET TAGS ('dbx_business_glossary_term' = 'Bin 1 Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `bin_2_die_count` SET TAGS ('dbx_business_glossary_term' = 'Bin 2 Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `bin_3_die_count` SET TAGS ('dbx_business_glossary_term' = 'Bin 3 Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `checkpoint_code` SET TAGS ('dbx_business_glossary_term' = 'Yield Checkpoint Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Yield Record Comments');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `control_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Lower');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `control_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Upper');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `design_loss_die_count` SET TAGS ('dbx_business_glossary_term' = 'Design Loss Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Disposition Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'PASS|FAIL|HOLD|REWORK|SCRAP');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `excursion_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Excursion Severity Level');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `excursion_severity_level` SET TAGS ('dbx_value_regex' = 'CRITICAL|MAJOR|MINOR|NONE');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `good_die_count` SET TAGS ('dbx_business_glossary_term' = 'Good Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `gross_die_count` SET TAGS ('dbx_business_glossary_term' = 'Gross Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Yield Measurement Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `process_loss_die_count` SET TAGS ('dbx_business_glossary_term' = 'Process Loss Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `random_defect_die_count` SET TAGS ('dbx_business_glossary_term' = 'Random Defect Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `reject_bin_die_count` SET TAGS ('dbx_business_glossary_term' = 'Reject Bin Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `rework_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `scrap_flag` SET TAGS ('dbx_business_glossary_term' = 'Scrap Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `specification_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Specification Limit Lower');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `systematic_defect_die_count` SET TAGS ('dbx_business_glossary_term' = 'Systematic Defect Die Count');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `yield_excursion_flag` SET TAGS ('dbx_business_glossary_term' = 'Yield Excursion Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_yield_record` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ALTER COLUMN `mask_set_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Identifier');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ALTER COLUMN `derived_from_mask_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Mask Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`mask_set` ALTER COLUMN `quality_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Qualification Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Identifier');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `parent_fab_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `location_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `location_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `location_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `location_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`fab_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`work_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`work_center` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`work_center` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`work_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`work_center` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`work_center` ALTER COLUMN `parent_work_center_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`work_center` ALTER COLUMN `manager_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`work_center` ALTER COLUMN `manager_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` SET TAGS ('dbx_association_edges' = 'fabrication.equipment_run,fabrication.wafer');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` ALTER COLUMN `wafer_run_record_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Run Record ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` ALTER COLUMN `equipment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Run Record - Equipment Run Id');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Run Record - Wafer Id');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` ALTER COLUMN `per_wafer_measurement_result` SET TAGS ('dbx_business_glossary_term' = 'Per-Wafer Measurement Result');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` ALTER COLUMN `process_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Process End Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` ALTER COLUMN `process_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Process Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` ALTER COLUMN `slot_position` SET TAGS ('dbx_business_glossary_term' = 'Slot Position');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` ALTER COLUMN `wafer_disposition_in_run` SET TAGS ('dbx_business_glossary_term' = 'Wafer Disposition in Run');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`wafer_run_record` ALTER COLUMN `wafer_run_status` SET TAGS ('dbx_business_glossary_term' = 'Wafer Run Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` SET TAGS ('dbx_association_edges' = 'fabrication.fabrication_process_step,fabrication.work_center');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `process_step_work_center_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification ID');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Work Center Qualification - Fabrication Process Step Id');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Work Center Qualification - Work Center Id');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `capacity_wafers_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Step-Specific Capacity');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Effective End Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `last_qualification_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `preferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Work Center Flag');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `qualification_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `qualified_by` SET TAGS ('dbx_business_glossary_term' = 'Qualified By');
ALTER TABLE `semiconductors_ecm`.`fabrication`.`process_step_work_center_qualification` ALTER COLUMN `qualified_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
