-- Schema for Domain: quality | Business: Semiconductors | Version: v1_mvm
-- Generated on: 2026-05-06 20:34:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `semiconductors_ecm`.`quality` COMMENT 'Quality assurance, reliability testing, defect inspection, metrology, DPPM tracking, FMEA, and qualification programs. Manages KGD certification, yield analysis, customer quality notifications, and compliance with ISO 9001, IATF 16949, and JEDEC reliability standards. Integrates with KLA ICOS inspection systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT 'Unique identifier for the inspection lot record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Required for the Inspection Lot Customer Assignment report, tying each lot’s inspection results to the purchasing customer for traceability, billing, and compliance.',
    `approved_vendor_id` BIGINT COMMENT 'Foreign key linking to supply.approved_vendor. Business justification: Incoming inspection lots must validate material against the approved vendor list (AVL) for compliance. Semiconductor QA requires AVL traceability distinct from raw supplier_id for audit and certificat',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection lot cost allocation required for budgeting and internal accounting; finance cost_center tracks these expenses.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export compliance verification requires each inspected lot to be linked to the export license authorizing its shipment.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: Inspection lot records are tied to a specific wafer lot for lot‑level quality inspection; linking enables lot‑level inspection reports and traceability.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Inspection lots tracked at product family level for yield trending, family-level quality metrics, and portfolio quality management. Supports business unit quality reporting.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Inspection lot reports are generated per IC part; linking to ic_catalog enables traceability for compliance and lot‑by‑lot quality reports.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Inspection Lot Report requires linking each lot to the Fab Tool used for inspection to ensure traceability and compliance.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Inspection lot is generated per order line; linking enables traceability for warranty and inspection reporting.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Opportunity‑to‑Lot traceability report ties production lot quality outcomes back to the originating sales opportunity for revenue impact analysis.',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: Inspection defect patterns are correlated with physical layout (GDS) to identify systematic DFM issues. Semiconductor DFM engineers require this link to map wafer inspection results back to specific l',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Inspection lots track process node for yield analysis, defect density correlation, and process capability monitoring. Essential for fab yield management and process qualification.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_step. Business justification: Inspection lots are created at specific fabrication process steps (in-line metrology, visual inspection). The existing process_step_id on inspection_lot points to process.process_step (cross-domain); ',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Inspection lots processed through specific chambers require chamber traceability for lot disposition decisions. Chamber hold/release decisions based on inspection results are standard semiconductor qu',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Inspection lots are performed within specific profit centers for P&L tracking, yield accountability by business unit, and fab line performance measurement in semiconductor operations.',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Inspection lots execute against specific test programs for parametric and functional validation. Test program defines the measurement suite applied to the lot. Critical for traceability and test cover',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Inspection Lot‑PO traceability required for Supplier Performance Review reports linking inspection results to the originating purchase order.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Inspection lots are evaluated against quality specifications. The inspection_lot has acceptance_criteria: INT and rejection_criteria: INT which are scalar representations of what should be defined in ',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Inspection lot tracking ties each lot to the specific process step being inspected, required for lot‑by‑step quality dashboards.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Inspection lots are physically staged at storage locations during quality hold/release gates. Fab operations require tracking where quarantined or released lots reside for material flow control and co',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier providing the material.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Inspection lots on fabricated wafers must trace to the originating tapeout submission for yield-by-tapeout reporting and DFM feedback loops. Semiconductor fabs require this link to correlate inspectio',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection lot record was created.',
    `defect_count` STRING COMMENT 'Total number of defects detected in the lot.',
    `defect_density` DECIMAL(18,2) COMMENT 'Defects per unit area metric for the lot.',
    `disposition` STRING COMMENT 'Final disposition assigned to the lot after inspection.. Valid values are `accept|reject|hold|rework`',
    `disposition_reason` STRING COMMENT 'Explanation for the chosen disposition.',
    `external_lot_code` STRING COMMENT 'External reference code used by suppliers or customers.',
    `iatf_16949_compliant` BOOLEAN COMMENT 'Indicates compliance with IATF 16949 automotive quality standards.',
    `inspection_lot_status` STRING COMMENT 'Current lifecycle status of the inspection lot.. Valid values are `open|in_progress|completed|closed|cancelled`',
    `inspection_result` STRING COMMENT 'Overall outcome of the inspection.. Valid values are `pass|fail|conditional`',
    `inspection_stage` STRING COMMENT 'Process stage at which the inspection occurs.. Valid values are `iqc|feol|beol|packaging|final`',
    `inspection_type` STRING COMMENT 'Category of inspection performed on the lot.. Valid values are `visual|metrology|electrical|functional|chemical`',
    `iso_9001_compliant` BOOLEAN COMMENT 'Indicates compliance with ISO 9001 quality management.',
    `jedec_reliability_compliant` BOOLEAN COMMENT 'Indicates compliance with JEDEC reliability specifications.',
    `kgd_certification_date` DATE COMMENT 'Date when KGD certification was granted.',
    `kgd_certified` BOOLEAN COMMENT 'Flag indicating whether the lot contains KGD‑certified dies.',
    `last_modified_by` STRING COMMENT 'User name of the person who last modified the record.',
    `lot_size` BIGINT COMMENT 'Total number of units (wafers, dies, or packaged parts) in the lot.',
    `lot_type` STRING COMMENT 'Classification of the lot based on its position in the workflow.. Valid values are `incoming|in_process|final|rework|hold`',
    `material_type` STRING COMMENT 'Type of material the lot consists of.. Valid values are `wafer|mask|chemical|gas|assembly`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary measurement taken during inspection.',
    `measurement_unit` STRING COMMENT 'Unit of the measured value.. Valid values are `nm|um|mm|percent|count`',
    `measurement_value` DECIMAL(18,2) COMMENT 'Numeric value of the key measurement (e.g., critical dimension).',
    `notes` STRING COMMENT 'Free‑form notes or comments about the inspection lot.',
    `quality_engineer` STRING COMMENT 'Name of the quality engineer responsible for the lot.',
    `sample_size` STRING COMMENT 'Number of units sampled from the lot.',
    `sampling_plan_aql` STRING COMMENT 'AQL value defined for the sampling plan.',
    `unit_of_measure` STRING COMMENT 'Unit used to quantify the lot size.. Valid values are `wafer|die|unit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `wafer_size_mm` DECIMAL(18,2) COMMENT 'Diameter of wafers in the lot, expressed in millimetres.',
    `yield_percent` DECIMAL(18,2) COMMENT 'Percentage of good units produced from the lot.',
    CONSTRAINT pk_inspection_lot PRIMARY KEY(`inspection_lot_id`)
) COMMENT 'Master record for a quality inspection lot representing a batch of wafers, dies, or packaged units submitted for quality inspection at any stage. Covers all inspection types: incoming material (IQC for raw wafers, chemicals, photomasks, gases, OSAT subassemblies with supplier and PO reference), in-process (FEOL, BEOL, packaging), and final outgoing. Captures lot origin, supplier ID (for IQC), inspection type, inspection stage, lot size, sampling plan parameters (AQL, sample size, acceptance/rejection numbers), inspection results, measured parameters, and disposition decision (accept, reject, hold, rework). Integrates with SAP QM and Camstar MES for lot status management and goods receipt inspection. SSOT for all quality inspection activities across the fab-to-finish flow including incoming quality control.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`defect_record` (
    `defect_record_id` BIGINT COMMENT 'Unique identifier for the defect record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Enables the Defect Ownership Tracking process, linking each defect to the responsible customer account for warranty claims and customer notifications.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Defect handling expenses are charged to a cost center for financial tracking of quality loss costs.',
    `design_ip_core_id` BIGINT COMMENT 'Foreign key linking to design.ip_core. Business justification: Needed for Defect Attribution Report to associate each defect with the specific IP core block used in the design, enabling targeted remediation.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Defect Analysis Report ties each defect to the detecting Fab Tool for root‑cause analysis and corrective action planning.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Defects found at final test must link to the test run that detected them. Critical for test escape analysis, DPPM calculation, and final test program effectiveness evaluation.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Defects originate from specific chambers, not just tools. Chamber-level defect pareto analysis drives targeted maintenance and chamber matching. Essential for yield excursion response and chamber qual',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Defects detected during wafer probe must link to the specific probe run that identified them. Essential for yield analysis, test escape tracking, and probe card qualification.',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Defects are tracked at die level in die banks for KGD certification. Inline inspection and final test defect data must link to die bank inventory for bin assignment, yield analysis, and customer quali',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Defect records must link to IC products for root cause analysis, product-specific yield learning, and quality trending. Critical for product engineering and reliability analysis.',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — Every defect is detected within an inspection lot. This is the fundamental parent-child relationship for defect tracking. Without this FK, defects cannot be traced to their inspection context.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Defect Tracking & Recall Management uses the inventory lot ID to locate and quarantine affected stock across the supply chain.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Defect records must be tied to the originating order line for root‑cause analysis, warranty claims, and corrective actions.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Defects in incoming materials (substrates, chemicals, photoresists) require linkage to material master for root cause analysis, supplier feedback (SCAR), and material qualification tracking. Standard ',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: Individual defect records are traced to physical layout to identify layout patterns (antenna violations, density issues) causing systematic defects. DFM analysis and post-silicon debug in semiconducto',
    `wafer_map_id` BIGINT COMMENT 'FK to quality.wafer_map.wafer_map_id — Defects with X/Y coordinates must link to the wafer map for spatial analysis. This is critical for systematic defect pattern detection.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Defect records correlate to process node for yield learning, defect density tracking, and process improvement. Critical for fab yield management and technology maturity assessment.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Defect analysis reports need the recipe used during the step to correlate process parameters with defect types.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_step. Business justification: Defects are detected at specific fabrication process steps. The existing process_step_id on defect_record points to process.process_step; a direct FK to fabrication_process_step enables fab-domain tra',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Defect records directly impact profit center yield metrics and cost-of-quality reporting. Semiconductor fabs track defect density and yield loss by business unit for P&L accountability.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Defect Record linked to purchase order for Supplier Defect Rate reports used in corrective action planning.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Defect records identify deviations from quality specifications. Linking defect_record to quality_spec identifies which specification was violated by the detected defect, enabling specification-level d',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Root cause analysis requires linking each defect record to the exact process step where the defect originated, used in RCA reports.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Defect records must reference the tapeout that produced the wafer for post-silicon debug and design-quality traceability. Semiconductor quality engineers use tapeout-level defect aggregation to drive ',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer on which the defect was observed.',
    `bin_assignment` STRING COMMENT 'Pass/fail bin code assigned to the die (e.g., P, F1, F2).',
    `comments` STRING COMMENT 'Additional free‑form notes from the inspector or analyst.',
    `corrective_action` STRING COMMENT 'Planned or executed action to remediate the defect.',
    `defect_area_um2` DOUBLE COMMENT 'Calculated area of the defect in square micrometers.',
    `defect_classification` STRING COMMENT 'High‑level classification of the defect (e.g., particle, patterning, etch).',
    `defect_code` STRING COMMENT 'Standardized code representing the defect type (e.g., D001, D002).',
    `defect_density_per_zone` DOUBLE COMMENT 'Number of defects per unit area within the zone.',
    `defect_layer` STRING COMMENT 'Process layer where the defect was found.. Valid values are `feol|mol|beol|passivation|metal`',
    `defect_severity` STRING COMMENT 'Severity rating indicating impact on yield.. Valid values are `critical|major|minor|warning|info`',
    `defect_size_nm` DOUBLE COMMENT 'Measured size of the defect in nanometers.',
    `defect_status` STRING COMMENT 'Current workflow status of the defect record.. Valid values are `open|investigating|resolved|closed|rejected`',
    `detection_method` STRING COMMENT 'Technique used to detect the defect.. Valid values are `optical|ebeam|sem|afm`',
    `die_x` STRING COMMENT 'Column index of the die containing the defect on the wafer grid.',
    `die_y` STRING COMMENT 'Row index of the die containing the defect on the wafer grid.',
    `disposition` STRING COMMENT 'Final handling decision for the defect.. Valid values are `scrap|rework|accept|hold`',
    `edge_exclusion_zone_flag` BOOLEAN COMMENT 'Indicates whether the defect lies within the defined edge exclusion area.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the defect was detected during inspection.',
    `flat_notch_orientation` STRING COMMENT 'Orientation of wafer flat or notch relative to the defect.. Valid values are `flat|notch`',
    `inspection_recipe` STRING COMMENT 'Name of the inspection recipe or parameter set used.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the defect record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the defect record.',
    `repeatability_flag` BOOLEAN COMMENT 'True if the defect pattern repeats across multiple wafers.',
    `root_cause` STRING COMMENT 'Narrative description of the identified root cause.',
    `x_coordinate` DOUBLE COMMENT 'Horizontal position of the defect on the wafer map (millimeters).',
    `y_coordinate` DOUBLE COMMENT 'Vertical position of the defect on the wafer map (millimeters).',
    CONSTRAINT pk_defect_record PRIMARY KEY(`defect_record_id`)
) COMMENT 'Transactional record capturing individual defect events, wafer-level defect maps, and spatial bin distributions detected during wafer inspection, die sort, or final test. At the defect event level: stores defect classification code, defect coordinates (X/Y on wafer map), defect size, defect layer (FEOL/MOL/BEOL), detection method (KLA ICOS optical, e-beam, SEM), severity rating, and disposition (scrap, rework, accept). At the wafer map level: captures per-wafer die grid coordinates, per-die pass/fail bin assignment, defect density per zone, edge exclusion zone, flat/notch orientation, and map generation timestamp. Enables yield spatial analysis, systematic defect pattern detection (repeater analysis, cluster detection), and wafer-level bin map visualization. Integrates directly with KLA ICOS inspection system output and ATE wafer probing systems. SSOT for all defect events, spatial defect analysis, and wafer-level quality maps.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`wafer_map` (
    `wafer_map_id` BIGINT COMMENT 'Primary key for wafer_map',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the inspection tool that produced the map.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Final test generates updated wafer maps with bin assignments. Links wafer maps to final test runs for die-level traceability and yield correlation analysis.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Wafer maps represent die-level yield for specific IC products. Essential for product qualification, yield analysis, and known-good-die certification programs.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Wafer maps showing die pass/fail patterns must link to ic_design_project for design-level yield pattern analysis. Semiconductor yield engineers correlate wafer map failure clusters with design blocks ',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A wafer map is generated as part of an inspection lot — each wafer map captures the spatial defect/bin distribution for a wafer within a specific inspection lot batch. This parent-child relationship i',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Wafer Map Archive ties each map to the inventory wafer lot for yield analysis and historical compliance audits.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Wafer maps track yield patterns by process node for systematic defect analysis and process capability monitoring. Essential for technology yield ramp and process optimization.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Wafer maps capture spatial defect patterns tied to specific chambers. Chamber-level bin distribution analysis drives process optimization and chamber matching. Essential for chamber qualification and ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Wafer maps drive profit center yield metrics (die_yield_percentage), die cost calculations, and fab line performance tracking for P&L reporting in semiconductor manufacturing.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Wafer maps are produced from wafers fabricated from a specific tapeout run; tapeout-level wafer map aggregation is required for tapeout yield reporting and design-to-silicon correlation analysis in se',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer associated with this map.',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: REQUIRED: Test execution (wafer_probe_run) creates the wafer map; traceability report links map to its probe run for root‑cause analysis.',
    `bin_count_total` STRING COMMENT 'Total number of distinct bins used in the map.',
    `compliance_iatf16949` BOOLEAN COMMENT 'Flag indicating compliance with IATF 16949 for this wafer map.',
    `compliance_iso9001` BOOLEAN COMMENT 'Flag indicating compliance with ISO 9001 for this wafer map.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp in the data lake.',
    `defect_density_per_sqmm` DECIMAL(18,2) COMMENT 'Average defect density across the wafer measured in defects per square millimeter.',
    `defect_type` STRING COMMENT 'Primary defect type identified on the wafer.. Valid values are `particle|scratch|void|contamination|other`',
    `defect_zone` STRING COMMENT 'Region of the wafer where defects are concentrated.. Valid values are `center|edge|corner|random`',
    `die_grid_columns` STRING COMMENT 'Number of die columns in the wafer grid.',
    `die_grid_rows` STRING COMMENT 'Number of die rows in the wafer grid.',
    `die_yield_percentage` DECIMAL(18,2) COMMENT 'Yield percentage calculated from passing dies over total dies.',
    `edge_exclusion_zone_mm` DECIMAL(18,2) COMMENT 'Width of the edge exclusion zone in millimeters where dies are not counted.',
    `fail_bin_code` STRING COMMENT 'Bin code representing failing (defective) dies.. Valid values are `FAIL`',
    `failing_die_count` STRING COMMENT 'Number of dies classified as failing.',
    `flat_orientation` STRING COMMENT 'Orientation of the wafer flat/notch relative to the map coordinate system.. Valid values are `north|south|east|west`',
    `is_kgd_certified` BOOLEAN COMMENT 'Indicates whether the wafer passed Known Good Die certification.',
    `kgd_certification_timestamp` TIMESTAMP COMMENT 'Timestamp when KGD certification was applied.',
    `map_checksum` STRING COMMENT 'Checksum (e.g., SHA-256) of the map file for integrity verification.',
    `map_file_path` STRING COMMENT 'File system path or URI where the wafer map image/file is stored.',
    `map_generation_timestamp` TIMESTAMP COMMENT 'Date and time when the wafer map was generated.',
    `map_status` STRING COMMENT 'Current processing status of the wafer map.. Valid values are `generated|validated|rejected|archived`',
    `map_version` STRING COMMENT 'Version identifier of the map generation algorithm or software.',
    `pass_bin_code` STRING COMMENT 'Bin code representing passing (good) dies.. Valid values are `PASS`',
    `passing_die_count` STRING COMMENT 'Number of dies classified as passing.',
    `remarks` STRING COMMENT 'Free-text comments or notes about the wafer map.',
    `total_die_count` STRING COMMENT 'Total number of dies evaluated on the wafer.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    CONSTRAINT pk_wafer_map PRIMARY KEY(`wafer_map_id`)
) COMMENT 'Spatial defect and bin distribution map for an individual wafer within an inspection lot. Captures wafer ID, lot ID, die grid coordinates, per-die pass/fail bin assignment, defect density per zone, edge exclusion zone, flat/notch orientation, and map generation timestamp. Sourced from KLA ICOS and ATE wafer probing systems. Enables yield spatial analysis and systematic defect pattern detection.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`yield_record` (
    `yield_record_id` BIGINT COMMENT 'System-generated unique identifier for the yield record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Yield records are generated by cost center operations and tracked for process efficiency, cost-per-die calculations, and manufacturing cost center performance measurement.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the equipment that performed the measurement.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: REQUIRED: Yield records reference the final test run that produced pass/fail counts; needed for yield vs. test performance dashboards.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Yield records track production yield by IC product for cost analysis, manufacturing efficiency monitoring, and product profitability assessment. Core operational metric.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Yield records must link to ic_design_project for yield-by-project NRE ROI analysis and design feedback. Yield records can exist for MPW shuttle runs without a direct tapeout record; direct project lin',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — Yield measurements are taken at quality gates associated with inspection lots. This link enables yield-to-defect correlation analysis.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Yield Reporting aggregates yield percentages per inventory lot for financial reporting and customer yield guarantees.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Yield records are reported per order line; FK supports performance metrics and customer yield reports.',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: Each yield record captures yield data from a specific lot process run. yield_record already has process_step_id and recipe_id but lacks a direct link to the specific run instance. This enables yield t',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Yield records must reference PDK version for yield-by-PDK-version analysis, critical for process qualification and PDK release decisions. process_node is a denormalized PDK attribute; the FK replaces ',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Yield loss analysis requires chamber-level granularity. Multiple chambers per tool can have different yield signatures. Chamber-specific yield improvement initiatives and chamber matching programs dep',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Yield performance is reported per profit center to assess profitability of product lines.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Yield analysis per purchase order supports Yield Loss Category reports and supplier yield KPI tracking.',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe applied to the wafer.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Yield records are produced per SKU for production performance dashboards; FK to sku replaces denormalized product_sku column.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Yield records are aggregated per process step; linking provides step‑level yield analysis for continuous improvement.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Supports Yield Analysis Dashboard linking yield data to the corresponding tapeout, essential for performance tracking and cost forecasting.',
    `wafer_id` BIGINT COMMENT 'Unique identifier for the individual wafer.',
    `wafer_map_id` BIGINT COMMENT 'Foreign key linking to quality.wafer_map. Business justification: Yield records at the wafer probe stage are directly correlated with wafer maps — the spatial bin distribution on the wafer map is the source data for yield calculations. Linking yield_record to wafer_',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Yield calculated from wafer probe results. Links yield metrics to probe runs for yield analysis and probe program optimization. Critical for fab yield management.',
    `batch_number` STRING COMMENT 'Identifier of the data acquisition batch.',
    `bin_distribution_summary` STRING COMMENT 'Compact representation (e.g., JSON) of die bin counts across test bins.',
    `calibration_status` STRING COMMENT 'Indicates whether the measurement equipment was calibrated.. Valid values are `calibrated|uncalibrated`',
    `comments` STRING COMMENT 'Free-text notes or observations related to the measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the yield record was first created in the system.',
    `defect_count` BIGINT COMMENT 'Number of defects detected for the specified defect type.',
    `defect_density_per_cm2` DECIMAL(18,2) COMMENT 'Number of defects per square centimeter of wafer area.',
    `defect_type` STRING COMMENT 'Classification of the dominant defect observed.. Valid values are `critical|major|minor|none`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the yield measurement was captured.',
    `fab_line` STRING COMMENT 'Production line identifier within the fab.',
    `good_die_count` BIGINT COMMENT 'Number of dies that passed all quality tests.',
    `inspection_result` STRING COMMENT 'Overall pass/fail outcome of the inspection.. Valid values are `pass|fail|rework`',
    `inspection_system` STRING COMMENT 'Name of the inspection/metrology system used (e.g., KLA ICOS).',
    `lot_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity of the fab environment during measurement.',
    `lot_origin` STRING COMMENT 'Fab location code where the wafer lot originated.',
    `lot_status` STRING COMMENT 'Current processing status of the wafer lot.. Valid values are `in_process|completed|held`',
    `lot_temperature_c` DECIMAL(18,2) COMMENT 'Average temperature of the wafer lot during measurement.',
    `measurement_accuracy_percent` DECIMAL(18,2) COMMENT 'Stated accuracy of the measurement as a percentage.',
    `measurement_method` STRING COMMENT 'Physical method used to obtain the yield measurement.. Valid values are `optical|electrical|thermal`',
    `measurement_stage` STRING COMMENT 'Quality gate at which the yield was measured.. Valid values are `wafer_probe|final_test|packaged`',
    `measurement_unit` STRING COMMENT 'Unit of the primary measurement (e.g., percent, count).',
    `measurement_variance_percent` DECIMAL(18,2) COMMENT 'Statistical variance observed across repeated measurements.',
    `quality_gate` STRING COMMENT 'Specific quality gate where the measurement was recorded.. Valid values are `wafer_sort|final_test|package_test`',
    `shift` STRING COMMENT 'Work shift during which the measurement was taken.. Valid values are `day|swing|night`',
    `source_file_name` STRING COMMENT 'Name of the source file or data feed that supplied the measurement.',
    `test_time_seconds` DECIMAL(18,2) COMMENT 'Total time taken to perform the yield test.',
    `tool_serial_number` STRING COMMENT 'Serial number of the measurement tool.',
    `total_die_count` BIGINT COMMENT 'Total number of dies on the wafer lot.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the yield record.',
    `yield_gap_percent` DECIMAL(18,2) COMMENT 'Difference between actual yield and target yield.',
    `yield_loss_category` STRING COMMENT 'Root cause classification for yield loss.. Valid values are `random_defect|systematic|parametric|test_escape|other`',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Yield expressed as a percentage of good dies over total dies.',
    `yield_record_status` STRING COMMENT 'Current validation status of the yield record.. Valid values are `valid|invalid|pending_review`',
    `yield_target_percent` DECIMAL(18,2) COMMENT 'Target yield percentage defined for the product/process.',
    CONSTRAINT pk_yield_record PRIMARY KEY(`yield_record_id`)
) COMMENT 'Transactional record capturing yield measurement outcomes at each quality gate: wafer probe (die sort yield), final test yield, and packaged unit yield. Stores wafer lot ID, process node, product SKU, total die count, good die count, yield percentage, bin distribution summary, yield loss category (random defect, systematic, parametric, test escape), and measurement timestamp. SSOT for yield tracking across the fab-to-finish flow.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`spc_chart` (
    `spc_chart_id` BIGINT COMMENT 'Unique identifier for the SPC chart record. _canonical_skip_reason: Entity does not fit standard role categories and is modeled as a custom data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SPC monitoring is a cost center activity with dedicated metrology resources, measurement equipment time, and process control engineering tracked for quality budgets.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: SPC charts monitor process parameters for specific IC products to ensure parametric compliance and detect process drift. Required for ISO9001 and IATF16949 compliance.',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — SPC measurements are taken during inspection activities. Out-of-control SPC signals trigger inspection lot holds. This is the process control to inspection feedback loop.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: SPC Dashboard monitors process control metrics linked to the specific inventory lot to trigger corrective actions.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: SPC charts monitoring incoming material parameters (resistivity, thickness, particle count) must link to material master for material lot acceptance, supplier process capability (Cpk) tracking, and in',
    `opc_rule_set_id` BIGINT COMMENT 'Foreign key linking to process.opc_rule_set. Business justification: OPC rule set defines target CD for the step; SPC chart must reference it for model‑based control limits per JEDEC standards.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: SPC charts monitor process parameters against PDK-defined design rule limits and process corners. Linking SPC data to PDK version enables correlation of process drift with design rule compliance, requ',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: SPC charts monitor test program stability and process capability. Links parametric measurements to the test program generating them. Required for test program qualification and continuous monitoring p',
    `quality_spec_id` BIGINT COMMENT 'FK to quality.spec.spec_id — SPC control limits are derived from product/process specifications. The spec product defines the acceptance criteria that SPC monitors against. This link is essential for automated OOC detection.',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: SPC charts monitor raw material parameter stability (resistivity, purity, thickness). Incoming quality control processes require linking SPC data to raw material lots for supplier qualification, proce',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: SPC charts are generated per process step; linking enables automated retrieval of step metadata for control‑limit calculations.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: SPC Dashboard links each chart to the Fab Tool that generated the data, enabling tool‑level performance monitoring.',
    `wafer_id` BIGINT COMMENT 'Identifier of the specific wafer within the lot.',
    `assignable_cause_code` STRING COMMENT 'Code representing the identified root cause for an out‑of‑control signal.',
    `chart_type` STRING COMMENT 'Statistical chart type used for the measurement series.. Valid values are `xbar_r|c_chart|p_chart|np_chart|cusum|ewma`',
    `comments` STRING COMMENT 'Additional notes or observations related to the measurement.',
    `control_limit_center` DECIMAL(18,2) COMMENT 'Center line value (process mean) for the chart.',
    `control_limit_lower` DECIMAL(18,2) COMMENT 'Calculated lower control limit for the chart.',
    `control_limit_upper` DECIMAL(18,2) COMMENT 'Calculated upper control limit for the chart.',
    `corrective_action_reference` STRING COMMENT 'Identifier of the corrective action taken to address the assignable cause.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the SPC chart record was created in the system.',
    `data_source_system` STRING COMMENT 'Originating system that supplied the measurement data.. Valid values are `KLA_ICOS|Camstar|SmartFactory`',
    `die_position` STRING COMMENT 'Identifier of the individual die (chip) measured.',
    `effective_end_date` DATE COMMENT 'Date when this SPC chart configuration was retired or superseded.',
    `effective_start_date` DATE COMMENT 'Date when this SPC chart configuration became effective.',
    `is_baseline` BOOLEAN COMMENT 'True if this chart serves as the baseline for comparative analysis.',
    `measurement_method` STRING COMMENT 'Technique by which the measurement was obtained.. Valid values are `inline|offline|automated`',
    `measurement_subgroup` STRING COMMENT 'Logical grouping identifier for the sample (e.g., lot number, wafer ID).',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was recorded.',
    `measurement_tool` STRING COMMENT 'Equipment or system that performed the measurement.. Valid values are `KLA|ASML|custom`',
    `measurement_value` DECIMAL(18,2) COMMENT 'Observed value of the monitored parameter for the sample.',
    `out_of_control_flag` BOOLEAN COMMENT 'True when the measurement falls outside control limits.',
    `parameter_name` STRING COMMENT 'Name of the process parameter being monitored (e.g., CD, Thickness, Resistivity).',
    `parameter_unit` STRING COMMENT 'Unit of measure for the monitored parameter (e.g., nm, µm, %).',
    `sample_size` STRING COMMENT 'Number of units in each sample subgroup.',
    `sampling_frequency` STRING COMMENT 'How often samples are taken for this SPC chart.. Valid values are `hourly|daily|per_lot|per_shift|per_batch|per_run`',
    `shift` STRING COMMENT 'Work shift during which the measurement was taken.. Valid values are `A|B|C|D`',
    `spc_chart_status` STRING COMMENT 'Operational status of the SPC chart record.. Valid values are `active|inactive|archived|pending`',
    `spc_to_metrology` BIGINT COMMENT 'FK to quality.metrology_measurement.metrology_measurement_id — SPC charts are populated by metrology measurements. This is the fundamental data flow from measurement to statistical control.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the SPC chart record.',
    `version_number` STRING COMMENT 'Version number of the control plan applied to this chart.',
    CONSTRAINT pk_spc_chart PRIMARY KEY(`spc_chart_id`)
) COMMENT 'Statistical Process Control record encompassing both the control plan definition and ongoing chart measurements for a specific process step and tool combination. Captures control plan parameters (monitored parameters, chart type, sampling frequency, sample size, reaction plan), control chart data (X-bar/R, CUSUM, EWMA values), UCL/LCL/CL values, out-of-control signal flags, assignable cause codes, and corrective action references. Supports IATF 16949 and ISO 9001 SPC requirements for process stability monitoring. SSOT for SPC configuration and measurement tracking.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`fmea_record` (
    `fmea_record_id` BIGINT COMMENT 'Unique system-generated identifier for each Failure Mode and Effects Analysis (FMEA) record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: FMEA activities are cost center engineering work with labor hours and tool time tracked for process improvement budgets and quality engineering resource allocation.',
    `design_ip_core_id` BIGINT COMMENT 'Foreign key linking to design.design_ip_core. Business justification: FMEA records are scoped to specific IP cores (memory, PHY, SerDes) for IP-level failure mode analysis. Semiconductor IP qualification programs require IP-core-level FMEA traceability for reuse risk as',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: FMEA identifies failure modes that test programs must detect. Links detection methods to test programs, enabling detection rating validation and test coverage gap analysis per IATF 16949.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: FMEA records document failure modes for process steps executed on specific tools. Tool-specific risk assessment drives preventive maintenance planning and equipment qualification requirements in semic',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber-level failure modes (gas flow instability, temperature uniformity) require chamber-specific FMEA. Chamber-level risk prioritization drives chamber PM optimization and chamber matching programs',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: FMEA records analyze failure modes at IC product level for design robustness and process risk assessment. Required for automotive qualification (IATF16949) and product safety.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Design FMEA (DFMEA) is performed per design project for IATF 16949 and ISO 26262 compliance. Linking fmea_record to ic_design_project enables design-level failure mode traceability required by automot',
    `obligation_register_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation_register. Business justification: FMEA (Failure Mode and Effects Analysis) is mandated by automotive (IATF 16949, AIAG FMEA-4) and aerospace regulatory obligations. Real process: obligation register defines which product lines require',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_flow. Business justification: FMEA is conducted at both process step level (already linked) and process flow level for system-level risk analysis. Semiconductor process FMEAs cover entire process flows to identify cross-step failu',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: FMEA analyzes process node failure modes, lithography risks, and process integration challenges. Essential for process risk assessment and technology development.',
    `process_step_id` BIGINT COMMENT 'Foreign key hint to the manufacturing process step entity.',
    `quality_qualification_program_id` BIGINT COMMENT 'FK to quality.qualification_program.qualification_program_id — FMEAs feed into qualification programs. IATF 16949 requires FMEA linkage to qualification activities.',
    `sales_design_win_id` BIGINT COMMENT 'Foreign key linking to sales.sales_design_win. Business justification: Design‑win risk management requires associating the FMEA with the winning design to monitor failure modes for the sold product.',
    `sku_id` BIGINT COMMENT 'Foreign key hint to the product master record associated with this FMEA.',
    `action_owner` STRING COMMENT 'Name or identifier of the person accountable for implementing the recommended action.',
    `approval_date` DATE COMMENT 'Date on which the FMEA was formally approved by quality management.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who granted final approval.',
    `cause_of_failure` STRING COMMENT 'Identified underlying cause(s) that could lead to the failure mode.',
    `comments` STRING COMMENT 'Open text field for any supplemental information or notes.',
    `compliance_standards` STRING COMMENT 'Enumerated list of quality or industry standards governing the FMEA.. Valid values are `IATF16949|ISO9001|JEDEC`',
    `control_plan_reference` STRING COMMENT 'Identifier linking the FMEA to the relevant control plan document.',
    `created_by_user` STRING COMMENT 'Identifier of the system user who entered the FMEA record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the FMEA record was initially entered into the system.',
    `detection_method` STRING COMMENT 'Technique or inspection method employed to discover the failure during manufacturing or testing.',
    `detection_rating` STRING COMMENT 'Numerical rating (1‑10) indicating how likely the failure will be detected before it reaches the customer.',
    `detection_technique` STRING COMMENT 'Specific detection approach (e.g., visual inspection, automated metrology).. Valid values are `visual|automated|test|simulation`',
    `effective_date` DATE COMMENT 'Date from which the FMEA record is considered active for risk management.',
    `failure_mode_description` STRING COMMENT 'Narrative describing how the failure can occur within the product or process.',
    `fmea_code` STRING COMMENT 'Business‑level code used to reference the FMEA in reports and change management systems.',
    `fmea_name` STRING COMMENT 'Human‑readable name that identifies the FMEA, often reflecting the product or process it evaluates.',
    `fmea_record_status` STRING COMMENT 'Lifecycle status of the FMEA record, tracking its progression from creation to retirement.. Valid values are `draft|review|approved|released|retired`',
    `fmea_scope` STRING COMMENT 'Narrative defining the boundaries (product, process, geography) covered by the analysis.',
    `fmea_type` STRING COMMENT 'Indicates whether the record is a Design FMEA (DFMEA) or Process FMEA (PFMEA).. Valid values are `DFMEA|PFMEA`',
    `is_critical` BOOLEAN COMMENT 'True if the failure mode is deemed critical to product safety or performance.',
    `last_modified_by_user` STRING COMMENT 'Identifier of the system user who performed the most recent update.',
    `occurrence_rating` STRING COMMENT 'Numerical rating (1‑10) representing the probability that the failure mode will occur.',
    `post_action_rpn` STRING COMMENT 'Re‑calculated risk priority number after corrective actions have been applied.',
    `potential_effect` STRING COMMENT 'Explanation of the impact on the customer if the failure mode materializes.',
    `recommended_action` STRING COMMENT 'Text describing the action(s) proposed to mitigate the identified failure mode.',
    `revision_number` STRING COMMENT 'Sequential version identifier tracking changes to the FMEA over time.',
    `risk_category` STRING COMMENT 'High‑level classification of the failure mode origin.. Valid values are `design|process|system`',
    `risk_priority_number` STRING COMMENT 'Calculated risk priority number derived from severity, occurrence, and detection ratings.',
    `severity_rating` STRING COMMENT 'Numerical rating (1‑10) of the seriousness of the failure effect on the end customer.',
    `target_completion_date` DATE COMMENT 'Planned date by which the recommended action should be finished.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the latest modification to the FMEA record.',
    CONSTRAINT pk_fmea_record PRIMARY KEY(`fmea_record_id`)
) COMMENT 'Failure Mode and Effects Analysis record documenting potential failure modes for a product design or manufacturing process step. Captures failure mode description, potential effect on end customer, severity rating (S), occurrence probability (O), detection rating (D), RPN (Risk Priority Number = S×O×D), recommended actions, responsible owner, target completion date, and post-action revised RPN. Supports IATF 16949 DFMEA and PFMEA requirements.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`reliability_test` (
    `reliability_test_id` BIGINT COMMENT 'Unique identifier for the reliability test record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer associated with the qualification.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Reliability test results are required evidence for product certification; linking ties each test to its certification record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reliability test costs are allocated to a cost center for cost‑of‑quality accounting.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment used (e.g., KLA ICOS system).',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot from which samples were taken.',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Reliability tests (HTOL, HAST, TC) qualify finished goods for customer release. Qualification reports and certificates of conformance require linking test results to finished good part numbers for aut',
    `fmea_record_id` BIGINT COMMENT 'FK to quality.fmea_record.fmea_record_id — Reliability test failures validate or invalidate FMEA failure mode predictions. FMEA recommended actions often include reliability testing. qualification_program description states Links to reliabili',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Reliability test results are tied to a specific IC part; required for qualification compliance and customer reliability reports.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Reliability tests (HTOL, ELFR, ESD) are conducted on devices from specific design projects for AEC-Q100/JEDEC qualification. Linking enables design-project-level reliability qualification tracking req',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Reliability tests (HTOL, TC, HAST) qualify incoming materials (mold compounds, die attach, bond wire). Must link to material master for material qualification status, PCN impact assessment, and JEDEC ',
    `obligation_register_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation_register. Business justification: Reliability testing (HTOL, HAST, temperature cycling) is mandated by regulatory obligations (JEDEC standards, automotive IATF 16949, AEC-Q100). Real process: obligation register defines which reliabil',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Reliability test conditions (voltage stress, temperature) are PDK-node-specific. Linking reliability_test to PDK enables node-level reliability qualification tracking required for PDK release certific',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_flow. Business justification: Reliability tests are conducted on devices fabricated using specific process flows. Semiconductor reliability engineers require process flow traceability on reliability test records for qualification ',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Reliability tests validate process node robustness, TDDB, electromigration, and hot carrier injection. Critical for technology qualification and process reliability assessment.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Reliability testing programs are profit center expenses with direct P&L impact. Test programs are budgeted and tracked by business unit for automotive, aerospace, and high-reliability product lines.',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Reliability tests execute specific test programs for stress testing. Links reliability qualification to test implementation. Required for JEDEC qualification and reliability program management.',
    `quality_qualification_program_id` BIGINT COMMENT 'FK to quality.qualification_program.qualification_program_id — Reliability tests are executed as part of qualification programs. This link is essential for tracking qualification completeness.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Reliability tests verify compliance against quality specifications (JEDEC standards, AEC-Q100 requirements). The reliability_test has applicable_standard and pass_fail_criteria fields that reference q',
    `reliability_test_run_id` BIGINT COMMENT 'Foreign key linking to test.reliability_test_run. Business justification: REQUIRED: Reliability test plan must be associated with each execution run to satisfy JEDEC reliability compliance and generate post‑run reports.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Reliability tests qualify specific SKUs (package/speed/voltage variants) for customer release. Essential for JEDEC qualification and automotive-grade certification at orderable-part level.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Reliability test samples are fabricated from specific tapeout runs; linking enables tapeout-level reliability qualification tracking. Semiconductor qualification engineers must identify which tapeout ',
    `maintenance_plan_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_plan. Business justification: Reliability test equipment requires specific maintenance plans to ensure test validity. Test equipment maintenance plan compliance is a regulatory requirement for JEDEC reliability testing and custome',
    `test_plan_id` BIGINT COMMENT 'Foreign key linking to quality.test_plan. Business justification: Reliability tests are executed according to test plans that define the test methodology, pass/fail criteria, and test conditions. The reliability_test has pass_fail_criteria, test_type, and test_durat',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Reliability stress tests (HTOL, thermal cycling) run in specific chambers with controlled environments. Test validity and repeatability require chamber traceability. Chamber qualification status is ma',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Large reliability programs (automotive qualification, aerospace certification) are managed as projects with WBS tracking for milestone billing, customer invoicing, and R&D capitalization.',
    `analysis_method` STRING COMMENT 'Technique used to analyze the failed device.. Valid values are `SEM|FIB|EMMI|curve_trace|other`',
    `applicable_standard` STRING COMMENT 'Industry standard governing the qualification (e.g., AEC‑Q100, JEDEC JESD47).. Valid values are `AEC_Q100|AEC_Q101|JESD47|ISO_9001`',
    `approval_authority` STRING COMMENT 'Name or role of the person/committee approving the qualification.',
    `compliance_iatf_16949` BOOLEAN COMMENT 'True if the test complies with automotive quality standard IATF 16949.',
    `compliance_iso_9001` BOOLEAN COMMENT 'True if the test complies with ISO 9001 quality management requirements.',
    `compliance_jedec` BOOLEAN COMMENT 'True if the test follows applicable JEDEC reliability standards.',
    `data_source_system` STRING COMMENT 'Source system that supplied the reliability test data (e.g., KLA ICOS).',
    `device_type` STRING COMMENT 'Identifier for the device family or SKU under test.',
    `failure_mechanism` STRING COMMENT 'Physical mechanism responsible for the failure.. Valid values are `electromigration|TDDB|HCI|NBTI|stress_rupture|other`',
    `failure_mode` STRING COMMENT 'Observed mode of failure for the device.. Valid values are `open_circuit|short_circuit|param_shift|timing_error|other`',
    `failure_serial_number` STRING COMMENT 'Serial number of the device that failed during testing.',
    `failure_time_hours` DECIMAL(18,2) COMMENT 'Time elapsed until failure, measured in hours.',
    `fit_rate` DECIMAL(18,2) COMMENT 'Calculated failure rate expressed in FIT (10⁹ hours).',
    `fit_rate_confidence` DECIMAL(18,2) COMMENT 'Statistical confidence level for the reported FIT rate.',
    `is_kgd_certified` BOOLEAN COMMENT 'Indicates whether the device is Known Good Die (KGD) certified.',
    `milestone_schedule` STRING COMMENT 'Key milestones and dates for the qualification program.',
    `operator_name` STRING COMMENT 'Name of the technician who ran the test.',
    `overall_status` STRING COMMENT 'Current lifecycle status of the qualification program.. Valid values are `pending|in_progress|completed|failed|cancelled`',
    `pass_fail_criteria` STRING COMMENT 'Business rule defining pass or fail for the test (e.g., max failure rate).',
    `qualification_plan_version` STRING COMMENT 'Version identifier of the qualification plan document.',
    `qualification_type` STRING COMMENT 'Type of qualification driving the reliability test.. Valid values are `new_product|process_change|osat_qualification|pcn_driven`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reliability test record was created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reliability test record.',
    `reliability_grade` STRING COMMENT 'Qualitative reliability grade assigned to the device.. Valid values are `A|B|C|D`',
    `root_cause_classification` STRING COMMENT 'High‑level classification of the root cause.. Valid values are `design|process|material|handling|unknown`',
    `sample_size` STRING COMMENT 'Number of devices subjected to the test.',
    `test_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the stress test, in hours.',
    `test_execution_timestamp` TIMESTAMP COMMENT 'Date and time when the test was executed.',
    `test_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity level during the test, expressed as a percentage.',
    `test_location` STRING COMMENT 'Facility or fab where the test was performed.',
    `test_result` STRING COMMENT 'Overall pass/fail outcome of the test.. Valid values are `pass|fail`',
    `test_status` STRING COMMENT 'Current execution status of the test.. Valid values are `scheduled|running|completed|aborted`',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Temperature set point for the stress test, in degrees Celsius.',
    `test_type` STRING COMMENT 'Stress test methodology applied.. Valid values are `HTOL|HAST|TC|ESD|JEDEC_stress`',
    `test_voltage_v` DECIMAL(18,2) COMMENT 'Voltage applied during the stress test, in volts.',
    `weibull_scale_parameter` DECIMAL(18,2) COMMENT 'Scale parameter of the Weibull reliability model.',
    `weibull_shape_parameter` DECIMAL(18,2) COMMENT 'Shape parameter of the Weibull reliability model.',
    CONSTRAINT pk_reliability_test PRIMARY KEY(`reliability_test_id`)
) COMMENT 'Master record for reliability qualification programs and individual test execution, encompassing program definition, test planning, stress test execution, and failure event tracking. At the program level: captures qualification type (new product, process change, OSAT qualification, PCN-driven), applicable standards (AEC-Q100, JEDEC JESD47, ISO 9001), qualification plan version, milestone schedule, overall qualification status, and approval authority. At the test level: captures test type (HTOL, HAST, TC, ESD, JEDEC stress tests), test conditions (temperature, voltage, humidity, duration), sample size, device type, pass/fail criteria, and individual failure details including failed unit serial number, failure time (hours), failure mode, failure analysis method (SEM, FIB, EMMI, curve trace), root cause classification, and failure mechanism (electromigration, TDDB, HCI, NBTI). SSOT for JEDEC JESD47 and AEC-Q100/Q101 qualification lifecycle from program initiation through test execution to final disposition, FIT rate calculations, and Weibull reliability modeling.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` (
    `quality_qualification_program_id` BIGINT COMMENT 'Unique surrogate key for the qualification program record.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Qualification programs (IATF 16949, ISO 9001, JEDEC reliability) are executed to achieve and maintain certifications. Real process: quality programs define the work required to earn certification; cer',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Qualification programs are major cost center initiatives with dedicated budgets for test execution, equipment time, engineering resources, and certification activities tracked for cost control.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Qualification programs scope to product families for platform qualification, shared design elements, and family-level reliability validation. Optimizes qualification investment across product portfoli',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Qualification programs validate process nodes for manufacturing readiness, yield capability, and reliability. Critical for technology node qualification and production release decisions.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Qualification programs are profit center investments tracked for ROI, customer qualification milestones, and product line P&L. Program budgets (program_budget_usd) are allocated to profit centers.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Qualification programs include equipment qualification milestones. Equipment readiness gating for product qualification is standard practice. Equipment certification status is a critical qualification',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber qualification is a critical milestone in product qualification programs. Chamber certification as qualification gate is mandatory for new product introduction and technology node transitions i',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Qualification programs are governed by quality specifications — the program defines which quality specs must be met for qualification. Linking quality_qualification_program to quality_spec identifies ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Large qualification programs (automotive IATF 16949, aerospace) are managed as projects with WBS structures for milestone tracking, budget control, and R&D capitalization decisions.',
    `actual_yield_percent` DECIMAL(18,2) COMMENT 'Measured wafer yield achieved during qualification.',
    `applicable_standards` STRING COMMENT 'Comma‑separated list of standards governing the program (e.g., AEC‑Q100, JEDEC JESD47, ISO 9001).',
    `approval_authority` STRING COMMENT 'Name or role of the individual/committee that approves the program.',
    `approval_date` DATE COMMENT 'Date on which the qualification program was formally approved.',
    `change_request_number` STRING COMMENT 'Identifier of the change request that triggered the qualification (if PCN‑driven).',
    `compliance_status` STRING COMMENT 'Current compliance posture against applicable standards.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification program record was first created.',
    `customer_notification_required` BOOLEAN COMMENT 'Indicates whether customers must be notified of qualification outcomes.',
    `documentation_link` STRING COMMENT 'URL or path to the primary qualification program documentation.',
    `dppm_actual` DECIMAL(18,2) COMMENT 'Measured DPPM observed during qualification.',
    `dppm_target` DECIMAL(18,2) COMMENT 'Maximum acceptable DPPM for the qualification program.',
    `effective_from` DATE COMMENT 'Date on which the qualification program becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the qualification program expires or is superseded (nullable for open‑ended).',
    `final_disposition` STRING COMMENT 'Outcome after program completion indicating product release eligibility.. Valid values are `qualified|rejected|conditional|withdrawn`',
    `kgd_certification_required` BOOLEAN COMMENT 'Flag indicating if Known Good Die certification is mandatory for the program.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the qualification program.',
    `last_reviewed_by` STRING COMMENT 'User identifier of the person who performed the last review.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the qualification program.. Valid values are `draft|planned|in_progress|completed|closed|cancelled`',
    `milestone_schedule` STRING COMMENT 'Serialized representation (e.g., JSON) of key milestones and target dates.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the qualification program.',
    `overall_status` STRING COMMENT 'Aggregated result of the qualification program.. Valid values are `pass|fail|pending|deferred`',
    `program_budget_usd` DECIMAL(18,2) COMMENT 'Allocated budget for the qualification effort expressed in US dollars.',
    `program_category` STRING COMMENT 'High‑level classification of the program for reporting and governance.. Valid values are `internal|customer|regulatory|partner`',
    `program_code` STRING COMMENT 'Business identifier or code used to reference the program in ERP/PLM systems.',
    `program_manager` STRING COMMENT 'Person responsible for day‑to‑day management of the qualification program.',
    `program_name` STRING COMMENT 'Human‑readable name of the qualification program.',
    `qualification_plan_version` STRING COMMENT 'Version identifier for the detailed qualification plan document.',
    `qualification_type` STRING COMMENT 'Category of qualification: new product, process change, OSAT qualification, or PCN‑driven.. Valid values are `new_product|process_change|osat|pcn_driven`',
    `regulatory_approval_status` STRING COMMENT 'Status of any required regulatory clearances.. Valid values are `approved|pending|rejected`',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the qualification program.. Valid values are `low|medium|high|critical`',
    `statistical_process_control_included` BOOLEAN COMMENT 'True if SPC data collection is part of the qualification activities.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Desired wafer yield expressed as a percent.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `version_number` STRING COMMENT 'Version identifier for the qualification plan, e.g., V1.0, V2.1.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_quality_qualification_program PRIMARY KEY(`quality_qualification_program_id`)
) COMMENT 'Master record for a product or process qualification program governing the full set of qualification activities required before production release. Captures qualification type (new product, process change, OSAT qualification, PCN-driven), applicable standards (AEC-Q100, JEDEC JESD47, ISO 9001), qualification plan version, milestone schedule, overall qualification status, approval authority, and final disposition. Links to reliability tests, FMEA records, and PCN events.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`kgd_certification` (
    `kgd_certification_id` BIGINT COMMENT 'System-generated unique identifier for the KGD certification record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Supports the Customer‑Specific KGD Certification Management workflow, replacing free‑text customer_name with a reference to the customer account for accurate certification tracking.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: KGD (Known Good Die) certification is a specific quality certification type that must link to the broader certification framework. Real process: KGD certificates are issued under the scope of parent I',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: KGD certification requires chamber-level traceability for burn-in and parametric screening. Regulatory requirement: chamber qualification status must be documented in certification records for JEDEC c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: KGD certification activities consume cost center resources for 100% testing, burn-in, parametric screening, and certification documentation tracked for high-reliability product budgets.',
    `die_bank_id` BIGINT COMMENT 'Identifier of the die lot that was certified.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: KGD certification criteria and test coverage requirements are specific to the fabrication technology node. Semiconductor KGD programs define node-specific burn-in conditions, parametric screens, and r',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: KGD (Known Good Die) certification is issued for specific wafer lots after comprehensive testing. Semiconductor customers require lot-level KGD certification traceability for die banking and assembly ',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: KGD certification requires final test data for comprehensive quality verification. Links certification to final test runs. Critical for KGD traceability and customer quality requirements.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: KGD certification applies to specific IC products for known-good-die programs, multi-chip modules, and high-reliability applications. Essential for die-level product sales.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: KGD certification is performed on known-good-die from specific design projects for advanced packaging customers. Linking enables design-project-level KGD certification tracking required for chiplet an',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: KGD (Known Good Die) certification attests that a specific die lot passed all required electrical tests. The certification is issued based on the results of an inspection lot. inspection_lot has kgd_c',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: KGD certification enables premium pricing and is tracked by profit center for high-reliability product lines (aerospace, automotive, medical) with distinct P&L accountability.',
    `quality_qualification_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_qualification_program. Business justification: KGD certification is governed by a qualification program — the certification standards, test coverage requirements, and approval criteria are defined within the qualification program. This link enable',
    `reliability_test_id` BIGINT COMMENT 'Foreign key linking to quality.reliability_test. Business justification: KGD certification requires reliability testing (burn-in, HTOL, etc.) as a prerequisite. The quality_kgd_certification record has burn_in_status and reliability_grade fields that are populated from rel',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: KGD certification for die banks often involves OSAT supplier qualification. Must link to supplier for supplier capability assessment, KGD program audit trail, and customer-required supplier traceabili',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: KGD certified die come from specific tapeout runs; tapeout-level KGD certification tracking is required for chiplet supply chain traceability. Advanced packaging customers require tapeout-specific KGD',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: KGD Certification records must reference the Fab Tool used for testing to satisfy JEDEC reliability audit requirements.',
    `wafer_map_id` BIGINT COMMENT 'Foreign key linking to quality.wafer_map. Business justification: KGD certification is die-level and requires the wafer map to identify which specific dies are certified as known-good. The wafer map provides the spatial bin distribution and pass/fail status for each',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: KGD certification requires wafer probe data for die-level quality verification. Links certification to probe runs. Essential for known-good-die traceability and certification audit trail.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification was formally approved.',
    `burn_in_status` STRING COMMENT 'Indicates whether burn‑in testing was performed and its outcome.. Valid values are `completed|not_required|pending`',
    `certification_batch` STRING COMMENT 'Batch identifier grouping multiple certifications performed together.',
    `certification_date` DATE COMMENT 'Date the certification was issued.',
    `certification_location` STRING COMMENT 'Physical location where the certification was performed.',
    `certification_standard` STRING COMMENT 'Standard or specification against which the die lot was certified.. Valid values are `JEDEC_JESD49|JEDEC_JESD20|CUSTOM`',
    `compliance_iatf16949` BOOLEAN COMMENT 'True if the certification complies with automotive quality standards.',
    `compliance_iso9001` BOOLEAN COMMENT 'True if the certification complies with ISO 9001 quality standards.',
    `compliance_jedec` BOOLEAN COMMENT 'True if the certification meets JEDEC requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was created.',
    `customer_requirements` STRING COMMENT 'Any customer‑specific KGD criteria or notes.',
    `expiration_reason` STRING COMMENT 'Reason why the certification expired or was terminated.. Valid values are `end_of_life|customer_request|quality_issue|other`',
    `expiry_date` DATE COMMENT 'Date the certification becomes invalid.',
    `kgd_version` STRING COMMENT 'Version of the KGD certification schema applied.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the certification.',
    `parametric_screen_result` STRING COMMENT 'Result of the parametric screening step.. Valid values are `pass|fail|conditional`',
    `part_number` STRING COMMENT 'Manufacturer part number of the product associated with the die lot.',
    `quality_kgd_certification_status` STRING COMMENT 'Current lifecycle state of the certification.. Valid values are `active|expired|revoked`',
    `reliability_grade` STRING COMMENT 'Overall reliability classification assigned to the die lot.. Valid values are `A|B|C|D|E`',
    `revision_number` STRING COMMENT 'Revision count of the certification record.',
    `test_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of required tests that were successfully completed.',
    `test_duration_hours` DECIMAL(18,2) COMMENT 'Length of time the test was run.',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the test was conducted.',
    `test_type` STRING COMMENT 'Category of test performed for the certification.. Valid values are `electrical|parametric|reliability`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    CONSTRAINT pk_kgd_certification PRIMARY KEY(`kgd_certification_id`)
) COMMENT 'Known Good Die certification record attesting that a specific die lot has passed all required electrical, parametric, and reliability screens for bare-die shipment to customers. Captures die lot ID, product part number, certification standard (JEDEC JESD49), test coverage percentage, burn-in status, parametric screen results, certification date, expiry date, certifying engineer, and customer-specific KGD requirements. Critical for advanced packaging and MCM customers.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`dppm_record` (
    `dppm_record_id` BIGINT COMMENT 'System-generated unique identifier for the DPPM record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who received the shipment and reported the defect.',
    `capa_record_id` BIGINT COMMENT 'FK to quality.capa_record.capa_record_id — Customer quality issues (DPPM events, 8D reports) trigger CAPA records. This link is required for customer complaint resolution tracking per IATF 16949.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: DPPM records track defective parts per million from shipped lots, requiring traceability back to the originating fabrication wafer lot for root cause analysis and customer quality reporting. Semicondu',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: DPPM calculated from final test yield data. Links defect rates to test runs for test effectiveness analysis. Required for automotive quality reporting per IATF 16949.',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: DPPM (Defects Per Million) tracks field failure rates for shipped finished goods. Customer quality scorecards and warranty analysis require linking DPPM records to specific finished good SKUs for root',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: DPPM records track defective units per part number; linking to ic_catalog enables part‑level defect analytics.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: DPPM records track defective parts per million from shipped lots. Linking to the originating inspection lot enables root cause analysis by tracing customer-reported defects back to the specific inspec',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: DPPM records track customer quality performance and often originate from or trigger nonconformance reports. When a customer reports defective parts, an NCR is raised to document the nonconformance. Li',
    `obligation_register_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation_register. Business justification: DPPM (Defective Parts Per Million) tracking is a regulatory obligation for automotive (IATF 16949) and aerospace customers. Real process: obligation register defines DPPM reporting thresholds, frequen',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_step. Business justification: DPPM records trace field failures back to the specific fabrication process step that caused the defect. This is essential for semiconductor process improvement — identifying which process step contrib',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: DPPM metrics are tracked by profit center for customer quality scorecards, cost-of-quality reporting, and business unit performance measurement in semiconductor operations.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: DPPM tracking at SKU level for customer-specific quality metrics, shipment quality monitoring, and automotive quality reporting. Required for customer scorecards and quality agreements.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: DPPM tracking by equipment enables equipment-related quality trending. Equipment performance scorecarding for supplier management and equipment qualification decisions depend on equipment-level DPPM t',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber-level DPPM tracking enables chamber matching and qualification decisions. Chamber-specific quality performance monitoring is essential for chamber utilization optimization and chamber certific',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: DPPM records for supplier-delivered materials must link directly to supplier for supplier scorecard calculation, AVL status review, and supplier business review (SBR) reporting. Core semiconductor sup',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: DPPM field failure records must identify which tapeout produced the defective parts for design-level corrective action. Semiconductor quality teams use tapeout-level DPPM analysis to determine if fail',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DPPM record was first created in the system.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the DPPM record.',
    `closure_status` STRING COMMENT 'Current closure state of the quality notification.. Valid values are `open|closed|in_progress|deferred`',
    `compliance_iso9001` STRING COMMENT 'Compliance status of the record with ISO 9001 quality management requirements.',
    `containment_action` STRING COMMENT 'Immediate actions taken to contain the defect and prevent further impact.',
    `corrective_action` STRING COMMENT 'Corrective steps implemented to eliminate the root cause.',
    `defective_units` BIGINT COMMENT 'Number of units returned by the customer that were identified as defective.',
    `dppm_value` DECIMAL(18,2) COMMENT 'Calculated DPPM value for the shipment period (defective_units / total_units_shipped * 1,000,000).',
    `eight_d_report_reference` STRING COMMENT 'Identifier of the associated 8‑D problem‑solving report.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary quality event (e.g., notification creation).',
    `failure_description` STRING COMMENT 'Narrative description of the observed failure mode or defect.',
    `is_kgd_certified` BOOLEAN COMMENT 'Indicates whether the returned die was a Known Good Die (KGD) certified part.',
    `kgd_certification_date` DATE COMMENT 'Date on which the KGD certification was granted.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the DPPM record.. Valid values are `draft|submitted|approved|closed`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `notification_type` STRING COMMENT 'Classification of the quality notification associated with the record.. Valid values are `8D|SCAR|Customer_Complaint|Field_Return|Other`',
    `part_number` STRING COMMENT 'Manufacturer part number (MPN) of the semiconductor product associated with the DPPM record.',
    `preventive_action` STRING COMMENT 'Preventive measures introduced to avoid recurrence of similar defects.',
    `record_number` STRING COMMENT 'Business identifier assigned to the DPPM record, used for external reference and tracking.',
    `response_due_date` DATE COMMENT 'Date by which the customer or supplier must respond to the notification.',
    `root_cause` STRING COMMENT 'Root cause analysis result identifying the underlying reason for the defect.',
    `shipment_end_date` DATE COMMENT 'Last calendar date of the shipment period covered by this DPPM record.',
    `shipment_start_date` DATE COMMENT 'First calendar date of the shipment period covered by this DPPM record.',
    `source_system` STRING COMMENT 'Originating source system for the record (e.g., SAP QM, KLA ICOS).',
    `total_units_shipped` BIGINT COMMENT 'Total number of units shipped to the customer during the shipment period.',
    CONSTRAINT pk_dppm_record PRIMARY KEY(`dppm_record_id`)
) COMMENT 'Customer quality performance and communication record encompassing DPPM tracking, formal quality notifications (8D, SCAR, customer complaints), field return management, and customer-facing quality communications. Captures product part number, customer account, shipment period, total units shipped, defective units returned, DPPM value, notification type, failure description, containment actions, root cause, corrective/preventive actions, 8D report reference, response due date, and closure status. SSOT for all customer-facing quality metrics, notifications, and communications per IATF 16949 customer satisfaction monitoring. Integrates with Salesforce CRM for customer communication tracking.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`capa_record` (
    `capa_record_id` BIGINT COMMENT 'System-generated unique identifier for the CAPA record.',
    `audit_id` BIGINT COMMENT 'FK to quality.audit.audit_id — Audit findings (now merged into audit) trigger CAPAs. audit_finding description states linked CAPA record. This is a mandatory operational link for ISO 9001 clause 10.2.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAPA implementation costs are allocated to a cost center to monitor corrective action spending.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: CAPA records for equipment-related issues require tool traceability. Equipment improvement action tracking and closure verification are mandatory for ISO9001 and IATF16949 compliance in semiconductor ',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber-specific corrective actions (chamber PM optimization, chamber matching) require chamber linkage. Chamber-level CAPA effectiveness verification is essential for process capability improvement a',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer or lot linked to the issue.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Corrective actions often target IC product families for systemic quality issues, design improvements, and process optimization. Essential for product quality management and continuous improvement.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: CAPAs triggered by design-related failures (systematic yield loss, reliability failures traced to design) must reference the originating design project. IATF 16949 CAPA management requires design-proj',
    `nonconformance_report_id` BIGINT COMMENT 'FK to quality.nonconformance_report.nonconformance_report_id — CAPAs are triggered by nonconformances. This is a critical traceability link for ISO 9001 clause 10.2 compliance.',
    `obligation_register_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation_register. Business justification: CAPA (Corrective and Preventive Action) records are generated in response to regulatory obligation violations and audit findings. Real process: obligation register entries trigger CAPA when compliance',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_step. Business justification: CAPAs address root causes at specific fabrication process steps. Semiconductor quality engineers require direct traceability from CAPA records to the process step being corrected for effectiveness ver',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: CAPA records have financial impact (cost_actual, cost_estimate) tracked by profit center for cost-of-quality metrics, operational efficiency KPIs, and continuous improvement ROI.',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: CAPAs often require test program updates as corrective actions. Links quality improvements to test program changes. Essential for CAPA effectiveness verification and change control.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: CAPA records address quality issues that typically involve violations of quality specifications. Linking capa_record to quality_spec identifies which specification was violated, enabling targeted corr',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: CAPA records address raw material quality issues (contamination, out-of-spec). Supplier corrective actions and incoming inspection process improvements require linking CAPAs to specific raw material c',
    `sku_id` BIGINT COMMENT 'Identifier of the product or design associated with the CAPA.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: CAPAs originating from supplier quality issues (material defects, delivery failures) must link to supplier for 8D report tracking, supplier corrective action requests (SCAR), and supplier scorecard im',
    `actual_completion_date` DATE COMMENT 'Date when the action was actually completed.',
    `attachment_reference` STRING COMMENT 'Reference (e.g., URL or file ID) to supporting documents or images.',
    `capa_number` STRING COMMENT 'Business identifier or code assigned to the CAPA for tracking and reference.',
    `capa_record_status` STRING COMMENT 'Current lifecycle status of the CAPA record.. Valid values are `open|in_progress|closed|rejected`',
    `capa_type` STRING COMMENT 'Indicates whether the action is corrective or preventive.. Valid values are `corrective|preventive`',
    `closure_approval_status` STRING COMMENT 'Approval status of the CAPA closure after verification.. Valid values are `approved|rejected|pending`',
    `closure_date` DATE COMMENT 'Date when the CAPA was formally closed.',
    `compliance_reference` STRING COMMENT 'Reference to the specific compliance clause or standard (e.g., ISO 9001, IATF 16949) governing the CAPA.',
    `corrective_action_description` STRING COMMENT 'Specific actions planned or taken to eliminate the identified root cause.',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual financial cost incurred after implementation.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the corrective or preventive action.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPA record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost fields.. Valid values are `USD|EUR|JPY|CNY|GBP|Other`',
    `department` STRING COMMENT 'Business department owning the CAPA (e.g., Quality, Engineering).',
    `detection_date` DATE COMMENT 'Date when the problem was first detected.',
    `detection_phase` STRING COMMENT 'Phase of the product lifecycle where the issue was detected.. Valid values are `design|fabrication|testing|field`',
    `detection_source` STRING COMMENT 'Source of detection (e.g., inspection, customer, audit).',
    `effectiveness_verification_criteria` STRING COMMENT 'Criteria and metrics used to verify that the CAPA was effective.',
    `impact` STRING COMMENT 'Description of the business or technical impact of the non‑conformance.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the CAPA.',
    `preventive_action_description` STRING COMMENT 'Actions designed to prevent recurrence of similar issues in the future.',
    `priority` STRING COMMENT 'Priority ranking to schedule the CAPA work.. Valid values are `1|2|3|4|5`',
    `problem_statement` STRING COMMENT 'Clear description of the problem or non‑conformance that triggered the CAPA.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit timestamp for when the record was first captured in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit timestamp for the most recent modification of the record.',
    `risk_level` STRING COMMENT 'Risk assessment of the issue before mitigation.. Valid values are `high|medium|low`',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the identified root cause.',
    `root_cause_method` STRING COMMENT 'Methodology used to determine the root cause (e.g., 5‑Why, Ishikawa, FTA, Pareto).. Valid values are `5_why|ishikawa|fta|pareto`',
    `severity` STRING COMMENT 'Severity level of the issue addressed by the CAPA.. Valid values are `critical|high|medium|low`',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective or preventive action should be completed.',
    `verification_date` DATE COMMENT 'Date when the effectiveness of the CAPA was verified.',
    `verification_result` STRING COMMENT 'Outcome of the effectiveness verification.. Valid values are `pass|fail|partial`',
    `created_by` STRING COMMENT 'User identifier of the person who created the CAPA record.',
    CONSTRAINT pk_capa_record PRIMARY KEY(`capa_record_id`)
) COMMENT 'Corrective and Preventive Action record managing the full lifecycle of a quality improvement action triggered by a defect, customer complaint, audit finding, or reliability failure. Captures problem statement, root cause analysis method (5-Why, Ishikawa, FTA), root cause description, corrective action plan, preventive action plan, implementation owner, target and actual completion dates, effectiveness verification criteria, and closure approval. Supports ISO 9001 clause 10.2 and IATF 16949 CAPA requirements.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` (
    `nonconformance_report_id` BIGINT COMMENT 'System-generated unique identifier for the non‑conformance report.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Feeds the Customer Impact Reporting procedure, associating each NCR with the affected customer account to trigger notifications and compliance reporting.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to quality.audit. Business justification: Nonconformance reports are frequently generated as findings from quality audits. An audit finding that identifies a nonconformance results in an NCR being raised. Linking nonconformance_report to the ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Nonconformance handling expenses are tracked against a cost center for financial impact analysis.',
    `defect_record_id` BIGINT COMMENT 'Foreign key linking to quality.defect_record. Business justification: Nonconformance reports are triggered by specific defect events. The NCR documents the product or process deviation that was detected, which originates from a defect record. Linking nonconformance_repo',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Nonconformance reports at die level trigger die bank holds and disposition decisions. MRB (Material Review Board) processes require direct linkage to die bank inventory for scrap/rework/use-as-is deci',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: NCRs often cite specific equipment as root cause. Equipment hold decisions and CAPA initiation depend on NCR-equipment linkage. Standard practice in ISO9001 and IATF16949 compliant semiconductor opera',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber-specific nonconformances (chamber drift, contamination) require chamber traceability for corrective action. Chamber-level NCR disposition and chamber requalification decisions depend on this l',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Nonconformances affecting export‑controlled items must be reported against the specific export license for regulatory tracking.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: NCRs often originate from final test failures. Links nonconformances to the test run that detected them. Essential for test escape analysis and corrective action tracking per ISO 9001.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: NCRs for incoming material defects must reference the specific goods receipt that triggered the quality hold. Enables traceability for MRB disposition, supplier charge-back, and receiving inspection a',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: NCMRs are issued for a specific IC part; linking to ic_catalog supports root‑cause analysis and customer notifications.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: NCRs raised for design-related nonconformances (DRC waivers causing failures, IP integration errors) require design project traceability for root cause analysis and design corrective action. IATF 1694',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — NCRs are typically discovered during inspection. This link provides traceability from the non-conformance back to the inspection event where it was detected.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: NCR handling requires linking the report to the inventory lot to enforce holds, quarantine, and corrective action tracking.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_step. Business justification: NCRs identify the specific fabrication process step where nonconformance occurred. Semiconductor QMS systems require process step traceability on NCRs for root cause analysis, SPC rule violation track',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: NCRs impact profit center yield, scrap costs (impact_amount), and customer quality metrics tracked for P&L accountability and cost-of-quality reporting by business unit.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: NCR‑PO linkage needed for root‑cause analysis and supplier accountability in Nonconformance Reporting.',
    `restricted_party_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.restricted_party_screening. Business justification: Nonconformance reports for shipments may trigger restricted party screening when customer or destination is flagged during quality hold review. Real process: quality holds escalate to trade compliance',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: NCRs track defects at SKU level for customer shipments, material review board decisions, and disposition actions. Critical for shipment quality control and customer notification.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: NCRs reference the process step where non‑conformance was detected, essential for corrective‑action workflow.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: NCRs scoped to specific tapeout submissions (e.g., GDS submission errors, mask data nonconformances) require direct tapeout traceability. Semiconductor foundry NCR management tracks nonconformances at',
    `wafer_id` BIGINT COMMENT 'Unique identifier of the wafer where the issue was detected.',
    `attached_document_ids` STRING COMMENT 'Comma‑separated list of document identifiers attached to the report.',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes capturing audit trail details.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard applicable to the report.. Valid values are `ISO 9001|IATF 16949|JEDEC`',
    `corrective_action_due_date` DATE COMMENT 'Target date for completion of corrective actions.',
    `corrective_action_plan` STRING COMMENT 'Planned corrective actions to prevent recurrence.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action implementation.. Valid values are `pending|completed|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `customer_notification_required` BOOLEAN COMMENT 'Flag indicating if the customer must be notified.',
    `customer_notification_sent_timestamp` TIMESTAMP COMMENT 'Date‑time when the customer notification was sent.',
    `detection_point` STRING COMMENT 'Process step or system where the non‑conformance was first detected.',
    `die_range` STRING COMMENT 'Range of die numbers on the wafer affected (e.g., "100-200").',
    `disposition_action_required` STRING COMMENT 'Specific actions required to implement the chosen disposition.',
    `disposition_decision` STRING COMMENT 'Final decision on how the non‑conforming material will be treated.. Valid values are `use_as_is|rework|scrap|return_to_supplier`',
    `hold_initiated_timestamp` TIMESTAMP COMMENT 'Date‑time when the quality hold was placed.',
    `hold_reason` STRING COMMENT 'Reason why the lot was placed on hold.',
    `hold_release_condition` STRING COMMENT 'Condition(s) that must be satisfied to release the hold.',
    `hold_released_timestamp` TIMESTAMP COMMENT 'Date‑time when the quality hold was lifted (null if still active).',
    `hold_type` STRING COMMENT 'Category of quality hold applied to the lot.. Valid values are `process_excursion|spc_out_of_control|customer_complaint|reliability_failure`',
    `impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary impact of the non‑conformance.',
    `impact_currency_code` STRING COMMENT 'Three‑letter ISO currency code for the financial impact.. Valid values are `USD|EUR|JPY|CNY|GBP`',
    `is_customer_impact` BOOLEAN COMMENT 'Indicates whether the non‑conformance impacts a customer.',
    `mrb_decision` STRING COMMENT 'Decision made by the MRB regarding the non‑conformance.. Valid values are `approve|reject|defer`',
    `nonconformance_description` STRING COMMENT 'Narrative description of the deviation from specification.',
    `nonconformance_report_status` STRING COMMENT 'Current lifecycle status of the report.. Valid values are `open|under_review|closed|cancelled`',
    `priority` STRING COMMENT 'Priority assigned for handling the report.. Valid values are `high|medium|low`',
    `report_number` STRING COMMENT 'Business‑visible identifier (NCR number) assigned to the report.',
    `report_timestamp` TIMESTAMP COMMENT 'Date‑time when the non‑conformance was initially recorded.',
    `root_cause_analysis` STRING COMMENT 'Analysis identifying the underlying cause of the non‑conformance.',
    `severity_level` STRING COMMENT 'Severity classification of the non‑conformance.. Valid values are `critical|high|medium|low`',
    `source_system` STRING COMMENT 'Originating system that generated the report (e.g., Camstar MES, KLA ICOS).',
    `specification_violated` STRING COMMENT 'Name or code of the specification that was not met.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    CONSTRAINT pk_nonconformance_report PRIMARY KEY(`nonconformance_report_id`)
) COMMENT 'Non-Conformance Report (NCR) and quality hold management record documenting product or process deviations from specification, managing lot hold/release lifecycle, and tracking material review board dispositions. Captures NCR number, affected lot/wafer/unit range, non-conformance description, specification violated, detection point, hold type (process excursion, SPC out-of-control, customer complaint, reliability failure), hold initiation and release timestamps, hold reason, hold release conditions with approver, disposition decision (use-as-is, rework, scrap, return to supplier), material review board (MRB) decision, responsible quality engineer, required disposition actions, and financial impact assessment. SSOT for all in-process quality escapes, quality holds, MRB dispositions, and lot release management. Integrates with Camstar MES and SAP QM for lot status management.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`audit` (
    `audit_id` BIGINT COMMENT 'Primary key for audit',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Quality audits (ISO9001, IATF16949) include equipment qualification status verification. Audit finding closure tied to specific equipment is standard practice. Equipment certification status is a comm',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber qualification audits require chamber-level traceability. Chamber certification status verification during audits is mandatory for process qualification and customer audits in semiconductor man',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Quality audits (internal, surveillance, recertification) are performed to maintain certifications (ISO 9001, IATF 16949, AS9100). Real process: audit schedule and scope are defined by certification re',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality audits are cost center activities with dedicated budgets for audit execution, travel, external auditor fees, and ISO/IATF/JEDEC certification maintenance.',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Quality audits (ISO 9001, IATF 16949) are conducted at specific fab facilities. A direct FK from audit to fab_facility enables facility-level audit history tracking, which is required for certificatio',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Audits are performed at legal entity level for ISO 9001, IATF 16949, JEDEC certification, regulatory compliance, and customer audit requirements. Certificates are issued to legal entities.',
    `quality_qualification_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_qualification_program. Business justification: Quality audits are often conducted as part of qualification programs to verify compliance with qualification requirements. Linking audit to quality_qualification_program enables traceability from audi',
    `actual_end_date` DATE COMMENT 'Calendar date when the audit was completed.',
    `actual_start_date` DATE COMMENT 'Calendar date when the audit actually started.',
    `applicable_standard` STRING COMMENT 'Regulatory or industry standard against which the audit is performed.. Valid values are `ISO 9001|IATF 16949|JEDEC|ISO 14001|ISO 45001`',
    `audit_number` STRING COMMENT 'Business identifier or code assigned to the audit (e.g., QA-2024-001).',
    `audit_scope` STRING COMMENT 'Textual description of the functional or product scope covered by the audit.',
    `audit_status` STRING COMMENT 'Current lifecycle state of the audit record.. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `audit_type` STRING COMMENT 'Classification of the audit: internal, customer‑conducted, third‑party certification, or other.. Valid values are `internal|customer|third_party|certification`',
    `certificate_reference` STRING COMMENT 'Identifier of the certification issued (if any) as a result of the audit.',
    `corrective_action_due_date` DATE COMMENT 'Latest date by which all corrective actions must be closed.',
    `findings_total` STRING COMMENT 'Aggregate number of findings recorded for the audit.',
    `major_nonconformances` STRING COMMENT 'Count of major non‑conformances identified.',
    `minor_nonconformances` STRING COMMENT 'Count of minor non‑conformances identified.',
    `observations` STRING COMMENT 'Number of observations (non‑conformance but not a defect).',
    `opportunities_for_improvement` STRING COMMENT 'Count of OFI (Opportunity for Improvement) findings.',
    `overall_result` STRING COMMENT 'Final outcome of the audit after evaluation of all findings.. Valid values are `passed|failed|conditional|pending`',
    `plan_document` STRING COMMENT 'Reference (e.g., file name or URL) to the detailed audit plan.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit record.',
    `scheduled_date` DATE COMMENT 'Planned calendar date for the audit to commence.',
    `team` STRING COMMENT 'Comma‑separated list of auditor identifiers or names participating in the audit.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Master record for quality management system audit events and their findings, covering internal, customer-conducted, and third-party certification body audits. At the audit level: captures audit program reference, audit type (system, process, product), audit scope, applicable standard (ISO 9001, IATF 16949, JEDEC), lead auditor, audit team, scheduled and actual dates, audit plan document reference, overall audit result, and certificate reference. At the finding level: captures individual observations, non-conformances, and opportunities for improvement with finding classification (major NC, minor NC, observation, OFI), finding description, applicable standard clause, corrective action linkage, responsible owner, due date, and closure status. SSOT for all quality audit planning, execution, and finding management per ISO 19011 and IATF 16949 clause 9.2.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`quality_spec` (
    `quality_spec_id` BIGINT COMMENT 'Unique identifier for the quality specification record.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Quality specifications for semiconductor products require ECCN classification for export control. Export documentation preparation process requires both quality certification data and export control c',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Specs often depend on the technology node; linking allows node‑specific parameter validation.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Quality specs define acceptance criteria, parametric limits, and test requirements for IC products. Essential for product definition, test program development, and quality control.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Quality specifications must comply with legal entity-specific regulatory requirements (ISO 9001, IATF 16949, JEDEC) and are owned by specific legal entities for certification liability and customer co',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Specification Measurement Traceability links each spec to the Fab Tool that performs the measurement, required for ISO 9001 compliance.',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Quality specs (measurement limits, inspection criteria) are defined per PDK version since process parameters vary by technology node. process_node is a denormalized PDK attribute. PDK-versioned qualit',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Quality specs define parametric limits enforced by test programs. Links specification requirements to test implementation. Critical for test program validation and spec compliance verification.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Quality specs often specify chamber-level requirements (e.g., chamber uniformity specs, chamber matching criteria). Chamber qualification against specs is essential for process capability and chamber ',
    `acceptance_criteria` STRING COMMENT 'Free‑text description of the acceptance criteria.',
    `applicability_scope` STRING COMMENT 'Level of the product hierarchy the spec applies to.. Valid values are `wafer|die|package|assembly`',
    `approval_date` DATE COMMENT 'Date when the specification was approved.',
    `approval_status` STRING COMMENT 'Current approval state of the specification.. Valid values are `approved|rejected|pending`',
    `approved_by` STRING COMMENT 'Name of the person who approved the specification.',
    `audit_trail` STRING COMMENT 'Chronological log of changes made to the specification.',
    `change_reason` STRING COMMENT 'Reason for the most recent change to the specification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification record was created.',
    `document_url` STRING COMMENT 'Link to the detailed specification document.',
    `effective_from` DATE COMMENT 'Date when the specification becomes effective.',
    `effective_until` DATE COMMENT 'Date when the specification expires (null if open‑ended).',
    `iatf_16949_compliant` BOOLEAN COMMENT 'Indicates compliance with automotive quality standard IATF 16949.',
    `inspection_method` STRING COMMENT 'Technique used to inspect or measure the parameter.. Valid values are `optical|electron|acoustic|other`',
    `iso_9001_compliant` BOOLEAN COMMENT 'Indicates whether the specification complies with ISO 9001 quality standards.',
    `jedec_reliability_compliant` BOOLEAN COMMENT 'Indicates compliance with JEDEC reliability specifications.',
    `last_validated_date` DATE COMMENT 'Date of the most recent validation activity.',
    `lower_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the parameter.',
    `measurement_accuracy_percent` DECIMAL(18,2) COMMENT 'Stated accuracy of the measurement equipment as a percentage.',
    `measurement_variance_percent` DECIMAL(18,2) COMMENT 'Observed variance of repeated measurements expressed as a percentage.',
    `nominal_value` DECIMAL(18,2) COMMENT 'Target nominal value for the parameter.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the specification.',
    `parameter_name` STRING COMMENT 'Name of the measured parameter (e.g., Vth, line width).',
    `product_family` STRING COMMENT 'Family or series to which the product belongs.',
    `quality_spec_status` STRING COMMENT 'Current lifecycle state of the specification.. Valid values are `active|inactive|draft|retired|pending`',
    `review_cycle` STRING COMMENT 'Frequency at which the specification is reviewed.. Valid values are `annual|quarterly|ad_hoc`',
    `revision_number` STRING COMMENT 'Sequential revision number of the specification.',
    `source_system` STRING COMMENT 'Originating system that created the specification record.',
    `spec_code` STRING COMMENT 'Unique business code assigned to the specification.',
    `spec_name` STRING COMMENT 'Human‑readable name of the quality specification.',
    `spec_type` STRING COMMENT 'Category of the specification such as electrical, dimensional, visual, or reliability.. Valid values are `electrical|dimensional|visual|reliability|other`',
    `test_type` STRING COMMENT 'Category of test associated with the specification.. Valid values are `functional|stress|environmental|reliability|visual`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the parameter (e.g., mV, nm).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the specification record.',
    `upper_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the parameter.',
    `validated_flag` BOOLEAN COMMENT 'Indicates whether the specification has been validated against actual parts.',
    `version` STRING COMMENT 'Version identifier for the specification.',
    CONSTRAINT pk_quality_spec PRIMARY KEY(`quality_spec_id`)
) COMMENT 'Master record defining the quality specification for a product SKU or process step, including all acceptance criteria, parametric limits, visual inspection standards, and test coverage requirements. Captures spec version, applicable product family, process node, specification type (electrical, dimensional, visual, reliability), parameter name, nominal value, upper and lower spec limits, measurement units, and approval status. SSOT for quality acceptance criteria referenced by inspection lots and test programs.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` (
    `failure_analysis_report_id` BIGINT COMMENT 'Unique identifier for the failure analysis report.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: FA reports document equipment-related failure mechanisms. Equipment improvement recommendations from FA findings drive equipment modification and preventive maintenance optimization in semiconductor m',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber-level failure analysis (chamber-induced defects) requires chamber traceability. Chamber-specific failure mechanism documentation drives chamber PM optimization and chamber matching programs.',
    `capa_record_id` BIGINT COMMENT 'FK to quality.capa_record.capa_record_id — Failure analysis conclusions drive corrective actions. This is a critical link in the closed-loop quality system.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Failure analysis activities consume significant cost center resources including lab time, SEM/TEM equipment, FIB, and engineering hours tracked for quality engineering budgets.',
    `defect_record_id` BIGINT COMMENT 'Foreign key linking to quality.defect_record. Business justification: Failure analysis reports investigate specific defects identified in defect records. The failure_analysis_report has defect_code and failure_site_location fields that correspond to defect_record attrib',
    `fabrication_process_recipe_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_recipe. Business justification: Failure analysis identifies the specific process recipe that caused the failure mode. Semiconductor FA reports must reference the recipe version in effect at the time of failure for recipe change cont',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: FA reports analyze failures of specific IC products for root cause determination, design improvements, and reliability assessment. Critical for product engineering and customer failure analysis.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Failure analysis reports on silicon failures must reference the design project to enable design-level root cause analysis and ECO initiation. Semiconductor FA engineers require this link to determine ',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Failure analysis reports investigate failed devices or wafers. The failed sample typically originates from a specific inspection lot. Linking failure_analysis_report to inspection_lot provides traceab',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: FA reports identifying material-related failure mechanisms (e.g., contamination, wrong spec) must reference material master for PCN impact assessment, material requalification decisions, and supplier ',
    `nonconformance_report_id` BIGINT COMMENT 'FK to quality.nonconformance_report.nonconformance_report_id — FA reports are triggered by non-conformances. FA description explicitly states Links to... nonconformance_report. This is a critical investigation-to-disposition link.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_step. Business justification: Failure analysis identifies the specific fabrication process step that caused the failure. This is a core root cause traceability requirement in semiconductor FA workflows — engineers must link FA fin',
    `reliability_test_id` BIGINT COMMENT 'FK to quality.reliability_test.reliability_test_id — Failure analysis reports investigate failures detected during reliability testing. FA report description states Links to reliability_failure which is now merged into reliability_test.',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Failure analysis traces probe-detected failures to specific probe runs. Links FA to test data for root cause analysis and test program improvement. Essential for yield learning.',
    `analysis_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the failure analysis investigation was completed.',
    `analysis_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the failure analysis investigation began.',
    `analysis_technique` STRING COMMENT 'Primary analytical method(s) employed during the failure investigation.. Valid values are `SEM|FIB|EMMI|TEM|EDX|Other`',
    `approval_status` STRING COMMENT 'Result of the final review of the report.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the report was formally approved or rejected.',
    `comments` STRING COMMENT 'Free‑form notes or observations added by the analyst.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the report record was first created.',
    `defect_code` STRING COMMENT 'Standard defect code identifying the defect class (e.g., D1234).. Valid values are `^Dd{4}$`',
    `failure_analysis_report_status` STRING COMMENT 'Current lifecycle status of the report.. Valid values are `draft|under_review|approved|rejected|closed`',
    `failure_mechanism` STRING COMMENT 'Descriptive classification of the underlying failure mechanism (e.g., electromigration, latch‑up, oxide breakdown).',
    `failure_severity` STRING COMMENT 'Severity rating assigned to the failure based on impact and recurrence risk.. Valid values are `critical|major|minor|warning`',
    `failure_site_location` STRING COMMENT 'Physical location on the die/wafer where the failure was observed (e.g., metal layer 3, die X12Y7).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the report record.',
    `report_number` STRING COMMENT 'Business identifier assigned to the report (e.g., FA‑2023‑0012).',
    `report_title` STRING COMMENT 'Human‑readable title of the failure analysis report.',
    `report_type` STRING COMMENT 'Category indicating the origin of the failure analysis request.. Valid values are `reliability_test|customer_return|in_process|design_review`',
    `root_cause` STRING COMMENT 'Narrative of the root cause conclusion derived from the analysis.',
    `sample_description` STRING COMMENT 'Brief description of the physical sample(s) examined (e.g., wafer lot, die coordinates, package type).',
    `supporting_evidence_refs` STRING COMMENT 'Comma‑separated list of file paths or identifiers for images, data files, and test logs that support the analysis.',
    CONSTRAINT pk_failure_analysis_report PRIMARY KEY(`failure_analysis_report_id`)
) COMMENT 'Formal failure analysis report documenting the investigation of a failed device, wafer, or component. Captures FA request source (reliability test, customer return, in-process failure), sample description, analysis techniques used (SEM, FIB cross-section, EMMI, TEM, EDX), failure site location, identified failure mechanism, root cause conclusion, supporting evidence references, analyst name, and report approval status. Links to reliability_failure, nonconformance_report, and capa_record.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`qualification_report` (
    `qualification_report_id` BIGINT COMMENT 'Primary key for qualification_report',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer.',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Qualification reports certify specific die bank lots for Known Good Die (KGD) status. OSAT partners and customers require traceability from qualification data to die bank inventory for high-reliabilit',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Qualification reports document the qualification of specific technology nodes. Semiconductor customers require technology node traceability on qualification reports for design win approval and supply ',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Manufacturing lot identifier associated with the qualification.',
    `ic_catalog_id` BIGINT COMMENT 'Identifier of the product that the qualification report pertains to.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Qualification reports document device qualification results (AEC-Q100, JEDEC) tied to specific design projects. Semiconductor qualification engineers require design-project-level qualification report ',
    `kgd_certification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_kgd_certification. Business justification: Qualification reports for KGD products include the KGD certification results. A qualification report may reference the specific KGD certification that was achieved as part of the qualification program',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Qualification reports are legal entity documents for customer contracts, product liability, warranty terms, and regulatory compliance. Reports are issued by specific legal entities.',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_flow. Business justification: A qualification report documents the qualification of a specific process flow. Semiconductor fabs require direct traceability from qualification reports to the process flow being qualified for custome',
    `program_id` BIGINT COMMENT 'Identifier of the test program used for the qualification.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Qualification reports document equipment qualification status. Equipment certification as product qualification evidence is mandatory for customer qualification packages and regulatory submissions in ',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber qualification reports are required for product qualification. Chamber certification documentation in qualification packages is mandatory for customer audits and regulatory compliance in semico',
    `quality_qualification_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_qualification_program. Business justification: Each qualification report documents the outcome of a qualification program; linking the report to its program provides proper hierarchy and prevents the report table from being isolated.',
    `reliability_test_id` BIGINT COMMENT 'Foreign key linking to quality.reliability_test. Business justification: Qualification reports summarize the results of qualification activities including reliability tests. A qualification report references the specific reliability test(s) that were conducted as part of t',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Qualification reports certify specific SKUs for customer release, documenting test results and compliance. Essential for automotive qualification, customer approvals, and product release documentation',
    `superseded_qualification_report_id` BIGINT COMMENT 'Self-referencing FK on qualification_report (superseded_qualification_report_id)',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Qualification report test vehicles come from specific tapeout runs; tapeout-level qualification traceability is required for qualification package submission to customers and certification bodies (AEC',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the report was approved.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the qualification report.',
    `comments` STRING COMMENT 'Free‑form comments or notes added by the author.',
    `compliance_standards` STRING COMMENT 'Comma‑separated list of standards the qualification adheres to. [ENUM-REF-CANDIDATE: ISO 9001|JEDEC|IATF 16949|ASTM|MIL‑STD|CUSTOM — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the qualification report record was first created in the system.',
    `customer_name` STRING COMMENT 'Name of the customer requesting or receiving the qualification.',
    `data_source` STRING COMMENT 'Originating system or tool that supplied the qualification data.',
    `dppm` DECIMAL(18,2) COMMENT 'Defect density measured as defects per million units.',
    `effective_date` DATE COMMENT 'Date from which the qualification results are considered effective.',
    `engineer_name` STRING COMMENT 'Name of the engineer responsible for the qualification.',
    `expiration_date` DATE COMMENT 'Date after which the qualification report is no longer valid (nullable).',
    `measurement_unit` STRING COMMENT 'Unit of measure for quantitative results in the report.',
    `qualification_report_status` STRING COMMENT 'Current lifecycle status of the report.',
    `qualification_result` STRING COMMENT 'Overall outcome of the qualification (pass, fail, or conditional).',
    `report_date` DATE COMMENT 'The calendar date on which the qualification report was issued.',
    `report_name` STRING COMMENT 'Human‑readable name or title of the qualification report.',
    `report_number` STRING COMMENT 'Business identifier assigned to the qualification report, used for tracking and reference.',
    `report_type` STRING COMMENT 'Category of the qualification report indicating the subject of qualification.',
    `report_version` STRING COMMENT 'Version label of the qualification report (e.g., v1.0, v2.1).',
    `revision_number` STRING COMMENT 'Sequential revision number of the qualification report.',
    `test_end_timestamp` TIMESTAMP COMMENT 'Date and time when the qualification testing completed.',
    `test_start_timestamp` TIMESTAMP COMMENT 'Date and time when the qualification testing began.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the qualification report record.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of units meeting qualification criteria.',
    CONSTRAINT pk_qualification_report PRIMARY KEY(`qualification_report_id`)
) COMMENT 'Master reference table for qualification_report. Referenced by qualification_report_id.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`customer_complaint` (
    `customer_complaint_id` BIGINT COMMENT 'Primary key for customer_complaint',
    `account_id` BIGINT COMMENT 'Identifier of the customer who submitted the complaint.',
    `capa_record_id` BIGINT COMMENT 'Foreign key linking to quality.capa_record. Business justification: Customer complaints drive corrective and preventive actions. The customer_complaint has corrective_action_plan and corrective_action_status fields that are managed through the CAPA process. Linking to',
    `dppm_record_id` BIGINT COMMENT 'Foreign key linking to quality.dppm_record. Business justification: Customer complaints are a primary source of DPPM data. The customer_complaint has dppm_impact: DECIMAL field confirming the DPPM relationship. Linking customer_complaint to dppm_record enables trackin',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Customer complaints often trace to specific equipment issues. Equipment-related complaint root cause analysis and 8D reporting require tool traceability. Standard practice in automotive and high-relia',
    `failure_analysis_report_id` BIGINT COMMENT 'Foreign key linking to quality.failure_analysis_report. Business justification: Customer complaints often require failure analysis to determine root cause. The customer_complaint has root_cause and root_cause_code fields that are populated from failure analysis findings. Linking ',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Customer complaints traced to specific test escapes. Links field failures to final test runs for test coverage gap analysis and test program improvement. Critical for DPPM reduction.',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Customer complaints reference specific finished goods shipped. RMA (Return Material Authorization) and 8D processes require tracing complaints to finished good lot codes for containment, root cause an',
    `ic_catalog_id` BIGINT COMMENT 'Identifier of the product or component the complaint concerns.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Customer complaints about device failures must trace to the originating design project for design-level root cause analysis and ECO initiation. Semiconductor customer quality engineers require this li',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Customer complaints reference specific product lots. Linking to the inspection_lot enables traceability from the customer complaint back to the quality inspection results for the affected lot, support',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: Customer complaints typically trigger the creation of nonconformance reports to formally document the product or process deviation. Linking customer_complaint to nonconformance_report enables traceabi',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_step. Business justification: Customer complaints are traced to specific fabrication process steps during root cause analysis. Semiconductor quality engineers require process step traceability on customer complaints for 8D reports',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Customer complaints have direct P&L impact on profit centers through warranty costs, scrap, rework, customer credits (cost_amount, cost_net), and DPPM penalties tracked for quality metrics.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Complaints reference specific SKUs shipped to customers for traceability, root cause analysis, and corrective action. Critical for customer quality management and warranty tracking.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Customer complaints traced to material defects (e.g., mold compound delamination, wire bond failures) must link to material supplier for supplier corrective action request (SCAR) issuance and supplier',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Chamber-specific issues (chamber contamination, chamber drift) can cause customer complaints. Chamber-level complaint root cause traceability is essential for effective corrective action and customer ',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer on which the defect was observed.',
    `batch_number` STRING COMMENT 'Batch identifier for the production run.',
    `closure_date` DATE COMMENT 'Date when the complaint record was formally closed.',
    `complaint_number` STRING COMMENT 'Business-visible identifier assigned to the complaint for tracking and reference.',
    `complaint_timestamp` TIMESTAMP COMMENT 'Date and time when the complaint was initially recorded.',
    `complaint_type` STRING COMMENT 'Categorization of the complaint based on its root cause domain.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the complaint triggers a compliance investigation.',
    `corrective_action_completion_date` DATE COMMENT 'Date when the corrective action was completed.',
    `corrective_action_due_date` DATE COMMENT 'Target date for completing the corrective action.',
    `corrective_action_plan` STRING COMMENT 'Planned actions to address the root cause.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action.',
    `cost_adjustments` DECIMAL(18,2) COMMENT 'Adjustments (e.g., discounts, rebates) applied to the gross cost.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total estimated cost associated with the complaint before adjustments.',
    `cost_net` DECIMAL(18,2) COMMENT 'Net cost after adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the complaint record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `customer_complaint_description` STRING COMMENT 'Detailed narrative provided by the customer describing the issue.',
    `customer_complaint_status` STRING COMMENT 'Current lifecycle status of the complaint.',
    `dppm_impact` DECIMAL(18,2) COMMENT 'Measured impact of the complaint expressed in DPPM.',
    `escalation_flag` BOOLEAN COMMENT 'True if the complaint has been escalated to higher management.',
    `escalation_level` STRING COMMENT 'Level of escalation applied to the complaint.',
    `inspection_result` STRING COMMENT 'Result of the quality inspection related to the complaint.',
    `lot_number` STRING COMMENT 'Manufacturing lot identifier associated with the affected product.',
    `manufacturing_site_code` STRING COMMENT 'Code representing the plant or fab where the product was produced.',
    `notes` STRING COMMENT 'Free‑form notes captured by quality engineers.',
    `priority` STRING COMMENT 'Business priority assigned to the complaint for handling urgency.',
    `regulatory_report_flag` BOOLEAN COMMENT 'True if the complaint must be reported to a regulatory body.',
    `regulatory_report_number` STRING COMMENT 'Identifier of the regulatory report filed for this complaint.',
    `resolution_date` DATE COMMENT 'Date on which the complaint was resolved.',
    `resolution_status` STRING COMMENT 'Current status of the corrective or remedial action.',
    `root_cause` STRING COMMENT 'Identified underlying cause of the defect or failure.',
    `root_cause_code` STRING COMMENT 'Standardized code representing the root cause category.',
    `severity` STRING COMMENT 'Severity rating indicating the impact of the complaint on product performance or safety.',
    `source_channel` STRING COMMENT 'Channel through which the complaint was received.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the complaint record.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether the complaint resulted in a warranty claim.',
    `warranty_claim_number` STRING COMMENT 'Reference number for the associated warranty claim.',
    CONSTRAINT pk_customer_complaint PRIMARY KEY(`customer_complaint_id`)
) COMMENT 'Master reference table for customer_complaint. Referenced by related_customer_complaint_id.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`quality`.`test_plan` (
    `test_plan_id` BIGINT COMMENT 'Primary key for test_plan',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Test plans define cost center resource consumption including equipment time, labor hours, materials, and test program development tracked for quality testing budgets.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment or platform used for this plan.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Test plans are defined per technology node — different nodes require different test methodologies, coverage requirements, and pass/fail criteria. Semiconductor fabs maintain node-specific test plans f',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Test plans define test strategy, coverage, and acceptance criteria for IC products. Essential for test program development, qualification planning, and production test execution.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Quality test plans are developed for specific design projects (device-specific test coverage, parametric limits). Semiconductor quality engineers require design-project-level test plan traceability fo',
    `process_flow_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_flow. Business justification: Test plans govern process flow qualification and in-line monitoring. A test plan is associated with a specific process flow to define the inspection and measurement strategy for that flow. Required fo',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Test plans specify chamber-level qualification requirements. Chamber qualification protocol execution and chamber certification tracking depend on this linkage. Essential for test plan execution and c',
    `quality_qualification_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_qualification_program. Business justification: Test plans are created as part of qualification programs — each qualification program defines the set of test plans that must be executed. Linking test_plan to quality_qualification_program enables tr',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Test plans are designed to verify compliance against quality specifications. The test_plan has pass_fail_criteria, defect_threshold, and compliance_standard fields that are derived from quality specs.',
    `approval_date` DATE COMMENT 'Date on which the test plan received formal approval.',
    `approver` STRING COMMENT 'Name of the person who approved the test plan for release.',
    `author` STRING COMMENT 'Name of the person who originally authored the test plan.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard that the test plan adheres to (e.g., JEDEC, ISO 9001).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the test plan record was first created in the system.',
    `defect_threshold` STRING COMMENT 'Maximum allowable number of defects per million parts (DPPM) for the plan.',
    `effective_end_date` DATE COMMENT 'Date on which the test plan expires or is superseded; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the test plan becomes operationally effective.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Date and time when the test plan was most recently run.',
    `last_result` STRING COMMENT 'Outcome of the most recent execution of the test plan.',
    `measurement_units` STRING COMMENT 'Units of measurement for key test parameters (e.g., V, A, Ohm).',
    `notes` STRING COMMENT 'Free‑form comments or observations about the test plan.',
    `pass_fail_criteria` STRING COMMENT 'Textual definition of the conditions that determine pass or fail outcomes.',
    `plan_code` STRING COMMENT 'External code or number used to reference the test plan in manufacturing systems.',
    `plan_name` STRING COMMENT 'Human‑readable name of the test plan.',
    `priority` STRING COMMENT 'Business priority assigned to the test plan.',
    `product_family` STRING COMMENT 'Product family or line to which the test plan applies.',
    `revision_number` STRING COMMENT 'Sequential revision number for change control of the test plan.',
    `target_device` STRING COMMENT 'Identifier of the semiconductor device or die that the test plan validates.',
    `test_category` STRING COMMENT 'Business category of the test plan (e.g., qualification, production, debug).',
    `test_duration_estimate_minutes` STRING COMMENT 'Estimated total execution time for the test plan, in minutes.',
    `test_environment` STRING COMMENT 'Physical or logical environment where the test plan is executed (e.g., cleanroom, probe station).',
    `test_plan_description` STRING COMMENT 'Detailed textual description of the test plan purpose, scope, and methodology.',
    `test_plan_status` STRING COMMENT 'Current lifecycle state of the test plan.',
    `test_type` STRING COMMENT 'Category of testing performed by the plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the test plan record.',
    `version` STRING COMMENT 'Alphanumeric version label (e.g., v1.2, R3) for the test plan.',
    `wafer_size` STRING COMMENT 'Standard wafer diameter (e.g., 200mm, 300mm) for which the plan is defined.',
    CONSTRAINT pk_test_plan PRIMARY KEY(`test_plan_id`)
) COMMENT 'Master reference table for test_plan. Referenced by related_test_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_wafer_map_id` FOREIGN KEY (`wafer_map_id`) REFERENCES `semiconductors_ecm`.`quality`.`wafer_map`(`wafer_map_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ADD CONSTRAINT `fk_quality_wafer_map_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ADD CONSTRAINT `fk_quality_yield_record_wafer_map_id` FOREIGN KEY (`wafer_map_id`) REFERENCES `semiconductors_ecm`.`quality`.`wafer_map`(`wafer_map_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ADD CONSTRAINT `fk_quality_fmea_record_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ADD CONSTRAINT `fk_quality_reliability_test_test_plan_id` FOREIGN KEY (`test_plan_id`) REFERENCES `semiconductors_ecm`.`quality`.`test_plan`(`test_plan_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ADD CONSTRAINT `fk_quality_quality_qualification_program_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_reliability_test_id` FOREIGN KEY (`reliability_test_id`) REFERENCES `semiconductors_ecm`.`quality`.`reliability_test`(`reliability_test_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ADD CONSTRAINT `fk_quality_kgd_certification_wafer_map_id` FOREIGN KEY (`wafer_map_id`) REFERENCES `semiconductors_ecm`.`quality`.`wafer_map`(`wafer_map_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ADD CONSTRAINT `fk_quality_dppm_record_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `semiconductors_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ADD CONSTRAINT `fk_quality_capa_record_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `semiconductors_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ADD CONSTRAINT `fk_quality_nonconformance_report_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ADD CONSTRAINT `fk_quality_failure_analysis_report_reliability_test_id` FOREIGN KEY (`reliability_test_id`) REFERENCES `semiconductors_ecm`.`quality`.`reliability_test`(`reliability_test_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_kgd_certification_id` FOREIGN KEY (`kgd_certification_id`) REFERENCES `semiconductors_ecm`.`quality`.`kgd_certification`(`kgd_certification_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_reliability_test_id` FOREIGN KEY (`reliability_test_id`) REFERENCES `semiconductors_ecm`.`quality`.`reliability_test`(`reliability_test_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ADD CONSTRAINT `fk_quality_qualification_report_superseded_qualification_report_id` FOREIGN KEY (`superseded_qualification_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`qualification_report`(`qualification_report_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_capa_record_id` FOREIGN KEY (`capa_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`capa_record`(`capa_record_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_dppm_record_id` FOREIGN KEY (`dppm_record_id`) REFERENCES `semiconductors_ecm`.`quality`.`dppm_record`(`dppm_record_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_failure_analysis_report_id` FOREIGN KEY (`failure_analysis_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`failure_analysis_report`(`failure_analysis_report_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `semiconductors_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ADD CONSTRAINT `fk_quality_customer_complaint_nonconformance_report_id` FOREIGN KEY (`nonconformance_report_id`) REFERENCES `semiconductors_ecm`.`quality`.`nonconformance_report`(`nonconformance_report_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_quality_qualification_program_id` FOREIGN KEY (`quality_qualification_program_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_qualification_program`(`quality_qualification_program_id`);
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ADD CONSTRAINT `fk_quality_test_plan_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `semiconductors_ecm`.`quality`.`quality_spec`(`quality_spec_id`);

-- ========= TAGS =========
ALTER SCHEMA `semiconductors_ecm`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `semiconductors_ecm`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `approved_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Process Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `defect_density` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (Defects per Unit Area)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'accept|reject|hold|rework');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `external_lot_code` SET TAGS ('dbx_business_glossary_term' = 'External Lot Code');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `iatf_16949_compliant` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|cancelled');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_value_regex' = 'iqc|feol|beol|packaging|final');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'visual|metrology|electrical|functional|chemical');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `iso_9001_compliant` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `jedec_reliability_compliant` SET TAGS ('dbx_business_glossary_term' = 'JEDEC Reliability Compliance Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `kgd_certification_date` SET TAGS ('dbx_business_glossary_term' = 'KGD Certification Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `kgd_certified` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die Certified');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size (Number of Units)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type (Incoming|In-Process|Final|Rework|Hold)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'incoming|in_process|final|rework|hold');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'wafer|mask|chemical|gas|assembly');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'nm|um|mm|percent|count');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `quality_engineer` SET TAGS ('dbx_business_glossary_term' = 'Quality Engineer Name');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `quality_engineer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `quality_engineer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sampling_plan_aql` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Acceptable Quality Level (AQL)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'wafer|die|unit');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (mm)');
ALTER TABLE `semiconductors_ecm`.`quality`.`inspection_lot` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Final Test Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Recipe Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `bin_assignment` SET TAGS ('dbx_business_glossary_term' = 'Bin Assignment');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `defect_area_um2` SET TAGS ('dbx_business_glossary_term' = 'Defect Area (µm²)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `defect_classification` SET TAGS ('dbx_business_glossary_term' = 'Defect Classification');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `defect_density_per_zone` SET TAGS ('dbx_business_glossary_term' = 'Defect Density per Zone');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `defect_layer` SET TAGS ('dbx_business_glossary_term' = 'Defect Layer');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `defect_layer` SET TAGS ('dbx_value_regex' = 'feol|mol|beol|passivation|metal');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `defect_severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `defect_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning|info');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `defect_size_nm` SET TAGS ('dbx_business_glossary_term' = 'Defect Size (nm)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `defect_status` SET TAGS ('dbx_business_glossary_term' = 'Defect Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `defect_status` SET TAGS ('dbx_value_regex' = 'open|investigating|resolved|closed|rejected');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'optical|ebeam|sem|afm');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `die_x` SET TAGS ('dbx_business_glossary_term' = 'Die X Grid Coordinate');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `die_y` SET TAGS ('dbx_business_glossary_term' = 'Die Y Grid Coordinate');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Defect Disposition');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'scrap|rework|accept|hold');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `edge_exclusion_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Edge Exclusion Zone Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `flat_notch_orientation` SET TAGS ('dbx_business_glossary_term' = 'Flat/Notch Orientation');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `flat_notch_orientation` SET TAGS ('dbx_value_regex' = 'flat|notch');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `inspection_recipe` SET TAGS ('dbx_business_glossary_term' = 'Inspection Recipe');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `repeatability_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeatability Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'X Coordinate (mm)');
ALTER TABLE `semiconductors_ecm`.`quality`.`defect_record` ALTER COLUMN `y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Y Coordinate (mm)');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `wafer_map_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Map Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Tool ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Process Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `bin_count_total` SET TAGS ('dbx_business_glossary_term' = 'Total Bin Count');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `compliance_iatf16949` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `compliance_iso9001` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `defect_density_per_sqmm` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (defects per mm²)');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `defect_type` SET TAGS ('dbx_value_regex' = 'particle|scratch|void|contamination|other');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `defect_zone` SET TAGS ('dbx_business_glossary_term' = 'Defect Zone');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `defect_zone` SET TAGS ('dbx_value_regex' = 'center|edge|corner|random');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `die_grid_columns` SET TAGS ('dbx_business_glossary_term' = 'Die Grid Columns');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `die_grid_rows` SET TAGS ('dbx_business_glossary_term' = 'Die Grid Rows');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `die_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Die Yield Percentage');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `edge_exclusion_zone_mm` SET TAGS ('dbx_business_glossary_term' = 'Edge Exclusion Zone (mm)');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `fail_bin_code` SET TAGS ('dbx_business_glossary_term' = 'Fail Bin Code');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `fail_bin_code` SET TAGS ('dbx_value_regex' = 'FAIL');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `failing_die_count` SET TAGS ('dbx_business_glossary_term' = 'Failing Die Count');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `flat_orientation` SET TAGS ('dbx_business_glossary_term' = 'Flat Orientation');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `flat_orientation` SET TAGS ('dbx_value_regex' = 'north|south|east|west');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `is_kgd_certified` SET TAGS ('dbx_business_glossary_term' = 'KGD Certified Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `kgd_certification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'KGD Certification Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `map_checksum` SET TAGS ('dbx_business_glossary_term' = 'Map Checksum');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `map_file_path` SET TAGS ('dbx_business_glossary_term' = 'Map File Path');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `map_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Map Generation Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `map_status` SET TAGS ('dbx_business_glossary_term' = 'Map Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `map_status` SET TAGS ('dbx_value_regex' = 'generated|validated|rejected|archived');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `map_version` SET TAGS ('dbx_business_glossary_term' = 'Map Version');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `pass_bin_code` SET TAGS ('dbx_business_glossary_term' = 'Pass Bin Code');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `pass_bin_code` SET TAGS ('dbx_value_regex' = 'PASS');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `passing_die_count` SET TAGS ('dbx_business_glossary_term' = 'Passing Die Count');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `total_die_count` SET TAGS ('dbx_business_glossary_term' = 'Total Die Count');
ALTER TABLE `semiconductors_ecm`.`quality`.`wafer_map` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Record ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Process Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Process Recipe ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `wafer_map_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Map Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `bin_distribution_summary` SET TAGS ('dbx_business_glossary_term' = 'Bin Distribution Summary');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|uncalibrated');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `defect_density_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (defects/cm²)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `defect_type` SET TAGS ('dbx_value_regex' = 'critical|major|minor|none');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `fab_line` SET TAGS ('dbx_business_glossary_term' = 'Fab Line');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `good_die_count` SET TAGS ('dbx_business_glossary_term' = 'Good Die Count');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|rework');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `inspection_system` SET TAGS ('dbx_business_glossary_term' = 'Inspection System');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `lot_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Lot Humidity (%)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `lot_origin` SET TAGS ('dbx_business_glossary_term' = 'Lot Origin');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'in_process|completed|held');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `lot_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Lot Temperature (°C)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `measurement_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Accuracy (%)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'optical|electrical|thermal');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `measurement_stage` SET TAGS ('dbx_business_glossary_term' = 'Measurement Stage');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `measurement_stage` SET TAGS ('dbx_value_regex' = 'wafer_probe|final_test|packaged');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `measurement_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Variance (%)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `quality_gate` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `quality_gate` SET TAGS ('dbx_value_regex' = 'wafer_sort|final_test|package_test');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|swing|night');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `source_file_name` SET TAGS ('dbx_business_glossary_term' = 'Source File Name');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `test_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Test Time (seconds)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `tool_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Tool Serial Number');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `total_die_count` SET TAGS ('dbx_business_glossary_term' = 'Total Die Count');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `yield_gap_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Gap (%)');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `yield_loss_category` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Category');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `yield_loss_category` SET TAGS ('dbx_value_regex' = 'random_defect|systematic|parametric|test_escape|other');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `yield_record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `yield_record_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|pending_review');
ALTER TABLE `semiconductors_ecm`.`quality`.`yield_record` ALTER COLUMN `yield_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Target (%)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `spc_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control Chart ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `opc_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Opc Rule Set Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `assignable_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Assignable Cause Code');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `chart_type` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Type');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `chart_type` SET TAGS ('dbx_value_regex' = 'xbar_r|c_chart|p_chart|np_chart|cusum|ewma');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `control_limit_center` SET TAGS ('dbx_business_glossary_term' = 'Center Line (CL)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `control_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `control_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `corrective_action_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Reference');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'KLA_ICOS|Camstar|SmartFactory');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `die_position` SET TAGS ('dbx_business_glossary_term' = 'Die Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `is_baseline` SET TAGS ('dbx_business_glossary_term' = 'Baseline Chart Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'inline|offline|automated');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `measurement_subgroup` SET TAGS ('dbx_business_glossary_term' = 'Measurement Subgroup Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `measurement_tool` SET TAGS ('dbx_business_glossary_term' = 'Measurement Tool');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `measurement_tool` SET TAGS ('dbx_value_regex' = 'KLA|ASML|custom');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `out_of_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Control Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `parameter_unit` SET TAGS ('dbx_business_glossary_term' = 'Parameter Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_value_regex' = 'hourly|daily|per_lot|per_shift|per_batch|per_run');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift Designation');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `spc_chart_status` SET TAGS ('dbx_business_glossary_term' = 'SPC Chart Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `spc_chart_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`spc_chart` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Version Number');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` SET TAGS ('dbx_subdomain' = 'product_qualification');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'FMEA Record Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Design Ip Core Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `obligation_register_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Register Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `sales_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Design Win Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `action_owner` SET TAGS ('dbx_business_glossary_term' = 'Action Owner');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `cause_of_failure` SET TAGS ('dbx_business_glossary_term' = 'Cause of Failure');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `compliance_standards` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standards');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `compliance_standards` SET TAGS ('dbx_value_regex' = 'IATF16949|ISO9001|JEDEC');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `control_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Reference');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `detection_rating` SET TAGS ('dbx_business_glossary_term' = 'Detection Rating (D)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `detection_technique` SET TAGS ('dbx_business_glossary_term' = 'Detection Technique');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `detection_technique` SET TAGS ('dbx_value_regex' = 'visual|automated|test|simulation');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `failure_mode_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Description');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `fmea_code` SET TAGS ('dbx_business_glossary_term' = 'FMEA Code');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `fmea_name` SET TAGS ('dbx_business_glossary_term' = 'FMEA Name');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `fmea_record_status` SET TAGS ('dbx_business_glossary_term' = 'FMEA Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `fmea_record_status` SET TAGS ('dbx_value_regex' = 'draft|review|approved|released|retired');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `fmea_scope` SET TAGS ('dbx_business_glossary_term' = 'FMEA Scope');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `fmea_type` SET TAGS ('dbx_business_glossary_term' = 'FMEA Type (Design or Process)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `fmea_type` SET TAGS ('dbx_value_regex' = 'DFMEA|PFMEA');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Failure Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `occurrence_rating` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Rating (O)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `post_action_rpn` SET TAGS ('dbx_business_glossary_term' = 'Post‑Action RPN');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `potential_effect` SET TAGS ('dbx_business_glossary_term' = 'Potential Effect');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'design|process|system');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `risk_priority_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Priority Number (RPN)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Severity Rating (S)');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`fmea_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` SET TAGS ('dbx_subdomain' = 'product_qualification');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `reliability_test_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `obligation_register_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Register Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `reliability_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Test Maintenance Plan Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `test_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Test Plan Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Test Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis Method');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `analysis_method` SET TAGS ('dbx_value_regex' = 'SEM|FIB|EMMI|curve_trace|other');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard (STD)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_value_regex' = 'AEC_Q100|AEC_Q101|JESD47|ISO_9001');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `compliance_iatf_16949` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `compliance_iso_9001` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `compliance_jedec` SET TAGS ('dbx_business_glossary_term' = 'JEDEC Compliance');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `failure_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Failure Mechanism');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `failure_mechanism` SET TAGS ('dbx_value_regex' = 'electromigration|TDDB|HCI|NBTI|stress_rupture|other');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `failure_mode` SET TAGS ('dbx_value_regex' = 'open_circuit|short_circuit|param_shift|timing_error|other');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `failure_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Failed Unit Serial Number');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `failure_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Failure Time (Hours)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `fit_rate` SET TAGS ('dbx_business_glossary_term' = 'FIT Rate (Failures In Time)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `fit_rate_confidence` SET TAGS ('dbx_business_glossary_term' = 'FIT Rate Confidence (%)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `is_kgd_certified` SET TAGS ('dbx_business_glossary_term' = 'KGD Certified Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `milestone_schedule` SET TAGS ('dbx_business_glossary_term' = 'Milestone Schedule');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `overall_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Qualification Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `overall_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|cancelled');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `pass_fail_criteria` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Criteria');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `qualification_plan_version` SET TAGS ('dbx_business_glossary_term' = 'Qualification Plan Version');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type (QUAL_TYPE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'new_product|process_change|osat_qualification|pcn_driven');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `reliability_grade` SET TAGS ('dbx_business_glossary_term' = 'Reliability Grade');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `reliability_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Classification');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_value_regex' = 'design|process|material|handling|unknown');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `test_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Hours)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `test_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `test_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Humidity (%)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|running|completed|aborted');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type (TEST_TYPE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'HTOL|HAST|TC|ESD|JEDEC_stress');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `test_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Test Voltage (V)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `weibull_scale_parameter` SET TAGS ('dbx_business_glossary_term' = 'Weibull Scale Parameter (η)');
ALTER TABLE `semiconductors_ecm`.`quality`.`reliability_test` ALTER COLUMN `weibull_shape_parameter` SET TAGS ('dbx_business_glossary_term' = 'Weibull Shape Parameter (β)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` SET TAGS ('dbx_subdomain' = 'product_qualification');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `quality_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Qualification Program Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percentage');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `change_request_number` SET TAGS ('dbx_business_glossary_term' = 'Change Request Number');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `documentation_link` SET TAGS ('dbx_business_glossary_term' = 'Documentation Link');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `dppm_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Defective Parts Per Million');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `dppm_target` SET TAGS ('dbx_business_glossary_term' = 'Target Defective Parts Per Million');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `final_disposition` SET TAGS ('dbx_business_glossary_term' = 'Final Disposition');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `final_disposition` SET TAGS ('dbx_value_regex' = 'qualified|rejected|conditional|withdrawn');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `kgd_certification_required` SET TAGS ('dbx_business_glossary_term' = 'KGD Certification Required');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|planned|in_progress|completed|closed|cancelled');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `milestone_schedule` SET TAGS ('dbx_business_glossary_term' = 'Milestone Schedule');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `overall_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Qualification Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `overall_status` SET TAGS ('dbx_value_regex' = 'pass|fail|pending|deferred');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `program_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Program Budget (USD)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'internal|customer|regulatory|partner');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program Code');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `program_manager` SET TAGS ('dbx_business_glossary_term' = 'Program Manager');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program Name');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `qualification_plan_version` SET TAGS ('dbx_business_glossary_term' = 'Qualification Plan Version');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'new_product|process_change|osat|pcn_driven');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `statistical_process_control_included` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control Included');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Program Version Number');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_qualification_program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` SET TAGS ('dbx_subdomain' = 'product_qualification');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `kgd_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die Certification ID (KGD_CERT_ID)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Lot Identifier (DIE_LOT_ID)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `quality_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Qualification Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `reliability_test_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `wafer_map_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Map Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Certification Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `burn_in_status` SET TAGS ('dbx_business_glossary_term' = 'Burn‑In Status (BURN_IN_STS)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `burn_in_status` SET TAGS ('dbx_value_regex' = 'completed|not_required|pending');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `certification_batch` SET TAGS ('dbx_business_glossary_term' = 'Certification Batch Identifier (CERT_BATCH)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date (CERT_DATE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `certification_location` SET TAGS ('dbx_business_glossary_term' = 'Certification Facility Location (CERT_LOC)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard (CERT_STD)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `certification_standard` SET TAGS ('dbx_value_regex' = 'JEDEC_JESD49|JEDEC_JESD20|CUSTOM');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `compliance_iatf16949` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance Indicator (COMPLY_IATF16949)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `compliance_iso9001` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Indicator (COMPLY_ISO9001)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `compliance_jedec` SET TAGS ('dbx_business_glossary_term' = 'JEDEC Compliance Indicator (COMPLY_JEDEC)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `customer_requirements` SET TAGS ('dbx_business_glossary_term' = 'Customer Specific KGD Requirements (CUSTOMER_REQ)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `expiration_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Certification Expiration (EXPIRY_REASON)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `expiration_reason` SET TAGS ('dbx_value_regex' = 'end_of_life|customer_request|quality_issue|other');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date (EXPIRY_DATE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `kgd_version` SET TAGS ('dbx_business_glossary_term' = 'KGD Version Identifier (KGD_VER)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `parametric_screen_result` SET TAGS ('dbx_business_glossary_term' = 'Parametric Screen Result (PARAM_SCREEN_RES)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `parametric_screen_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Product Part Number (PART_NUM)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `quality_kgd_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Lifecycle Status (CERT_STATUS)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `quality_kgd_certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `reliability_grade` SET TAGS ('dbx_business_glossary_term' = 'Reliability Grade (REL_GRADE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `reliability_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Revision Number (REV_NUM)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `test_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Percentage (TEST_COV_PCT)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `test_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Test Duration in Hours (TEST_DUR_HRS)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature in Celsius (TEST_TEMP_C)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type Conducted (TEST_TYPE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'electrical|parametric|reliability');
ALTER TABLE `semiconductors_ecm`.`quality`.`kgd_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `dppm_record_id` SET TAGS ('dbx_business_glossary_term' = 'DPPM Record ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `obligation_register_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Register Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Source Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Source Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|deferred');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `compliance_iso9001` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `defective_units` SET TAGS ('dbx_business_glossary_term' = 'Defective Units Returned');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `dppm_value` SET TAGS ('dbx_business_glossary_term' = 'Defective Parts Per Million (DPPM)');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `eight_d_report_reference` SET TAGS ('dbx_business_glossary_term' = '8D Report Reference');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `failure_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Description');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `is_kgd_certified` SET TAGS ('dbx_business_glossary_term' = 'KGD Certified Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `kgd_certification_date` SET TAGS ('dbx_business_glossary_term' = 'KGD Certification Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|closed');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = '8D|SCAR|Customer_Complaint|Field_Return|Other');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Record Number');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `shipment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment End Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `shipment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Start Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`quality`.`dppm_record` ALTER COLUMN `total_units_shipped` SET TAGS ('dbx_business_glossary_term' = 'Total Units Shipped');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Record Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `obligation_register_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Register Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Attachment Reference');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'CAPA Number');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `capa_record_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `capa_record_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|rejected');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Type');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `closure_approval_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Approval Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `closure_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reference');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `cost_actual` SET TAGS ('dbx_business_glossary_term' = 'CAPA Actual Cost');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'CAPA Cost Estimate');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAPA Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|Other');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `detection_date` SET TAGS ('dbx_business_glossary_term' = 'Detection Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `detection_phase` SET TAGS ('dbx_business_glossary_term' = 'Detection Phase');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `detection_phase` SET TAGS ('dbx_value_regex' = 'design|fabrication|testing|field');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `effectiveness_verification_criteria` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Criteria');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `impact` SET TAGS ('dbx_business_glossary_term' = 'CAPA Impact');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'CAPA Notes');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAPA Priority');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `problem_statement` SET TAGS ('dbx_business_glossary_term' = 'Problem Statement');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'CAPA Risk Level');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `root_cause_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Method');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `root_cause_method` SET TAGS ('dbx_value_regex' = '5_why|ishikawa|fta|pareto');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'CAPA Severity');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'pass|fail|partial');
ALTER TABLE `semiconductors_ecm`.`quality`.`capa_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `restricted_party_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Party Screening Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `attached_document_ids` SET TAGS ('dbx_business_glossary_term' = 'Attached Document IDs');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'ISO 9001|IATF 16949|JEDEC');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_applicable');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `customer_notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `detection_point` SET TAGS ('dbx_business_glossary_term' = 'Detection Point');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `die_range` SET TAGS ('dbx_business_glossary_term' = 'Die Range');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `disposition_action_required` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action Required');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'use_as_is|rework|scrap|return_to_supplier');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `hold_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiated Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `hold_release_condition` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Condition');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `hold_released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Released Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'process_excursion|spc_out_of_control|customer_complaint|reliability_failure');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Impact Currency Code');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `impact_currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `is_customer_impact` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `mrb_decision` SET TAGS ('dbx_business_glossary_term' = 'Material Review Board Decision');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `mrb_decision` SET TAGS ('dbx_value_regex' = 'approve|reject|defer');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_description` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Description');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_report_status` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `nonconformance_report_status` SET TAGS ('dbx_value_regex' = 'open|under_review|closed|cancelled');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Number');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `specification_violated` SET TAGS ('dbx_business_glossary_term' = 'Specification Violated');
ALTER TABLE `semiconductors_ecm`.`quality`.`nonconformance_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `quality_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Qualification Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Audit End Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Audit Start Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_value_regex' = 'ISO 9001|IATF 16949|JEDEC|ISO 14001|ISO 45001');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|customer|third_party|certification');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate Reference');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `findings_total` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `major_nonconformances` SET TAGS ('dbx_business_glossary_term' = 'Major Non‑Conformance Count');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `minor_nonconformances` SET TAGS ('dbx_business_glossary_term' = 'Minor Non‑Conformance Count');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `observations` SET TAGS ('dbx_business_glossary_term' = 'Observation Count');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `opportunities_for_improvement` SET TAGS ('dbx_business_glossary_term' = 'Opportunity for Improvement Count');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Result');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional|pending');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `plan_document` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Document Reference');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Audit Date');
ALTER TABLE `semiconductors_ecm`.`quality`.`audit` ALTER COLUMN `team` SET TAGS ('dbx_business_glossary_term' = 'Audit Team');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification ID (QUALITY_SPEC_ID)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Description (ACCEPTANCE_CRITERIA)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Specification Applicability Scope (SPEC_APPLICABILITY_SCOPE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_value_regex' = 'wafer|die|package|assembly');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DATE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVED_BY)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Specification Audit Trail (SPEC_AUDIT_TRAIL)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Specification Change Reason (SPEC_CHANGE_REASON)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Specification Document URL (SPEC_DOCUMENT_URL)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `iatf_16949_compliant` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Compliance Flag (IATF_16949_COMPLIANT)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method (INSPECTION_METHOD)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'optical|electron|acoustic|other');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `iso_9001_compliant` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Flag (ISO_9001_COMPLIANT)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `jedec_reliability_compliant` SET TAGS ('dbx_business_glossary_term' = 'JEDEC Reliability Compliance Flag (JEDEC_RELIABILITY_COMPLIANT)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `last_validated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Validation Date (SPEC_LAST_VALIDATED_DATE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LOWER_LIMIT)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `measurement_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Accuracy Percent (MEASUREMENT_ACCURACY_PCT)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `measurement_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Variance Percent (MEASUREMENT_VARIANCE_PCT)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `nominal_value` SET TAGS ('dbx_business_glossary_term' = 'Nominal Value (NOMINAL_VALUE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes (SPEC_NOTES)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name (PARAMETER_NAME)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family (PRODUCT_FAMILY)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `quality_spec_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Lifecycle Status (SPEC_STATUS)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `quality_spec_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired|pending');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Specification Review Cycle (SPEC_REVIEW_CYCLE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|quarterly|ad_hoc');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Revision Number (SPEC_REVISION_NUMBER)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Specification (SPEC_SOURCE_SYSTEM)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `spec_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Code (SPEC_CODE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `spec_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Name (SPEC_NAME)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `spec_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Type (SPEC_TYPE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `spec_type` SET TAGS ('dbx_value_regex' = 'electrical|dimensional|visual|reliability|other');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type (TEST_TYPE)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'functional|stress|environmental|reliability|visual');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (UPPER_LIMIT)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Specification Validated Flag (SPEC_VALIDATED_FLAG)');
ALTER TABLE `semiconductors_ecm`.`quality`.`quality_spec` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version (SPEC_VERSION)');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_analysis_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis Report ID');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Analysis Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Analysis Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `fabrication_process_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `analysis_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis End Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `analysis_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `analysis_technique` SET TAGS ('dbx_business_glossary_term' = 'Analysis Technique');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `analysis_technique` SET TAGS ('dbx_value_regex' = 'SEM|FIB|EMMI|TEM|EDX|Other');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `defect_code` SET TAGS ('dbx_value_regex' = '^Dd{4}$');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_analysis_report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_analysis_report_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|closed');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Failure Mechanism');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_severity` SET TAGS ('dbx_business_glossary_term' = 'Failure Severity');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `failure_site_location` SET TAGS ('dbx_business_glossary_term' = 'Failure Site Location');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `report_title` SET TAGS ('dbx_business_glossary_term' = 'Report Title');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'reliability_test|customer_return|in_process|design_review');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `sample_description` SET TAGS ('dbx_business_glossary_term' = 'Sample Description');
ALTER TABLE `semiconductors_ecm`.`quality`.`failure_analysis_report` ALTER COLUMN `supporting_evidence_refs` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence References');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` SET TAGS ('dbx_subdomain' = 'product_qualification');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `qualification_report_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Report Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `kgd_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Kgd Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `quality_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `reliability_test_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `superseded_qualification_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `customer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`quality`.`qualification_report` ALTER COLUMN `customer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Record Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `dppm_record_id` SET TAGS ('dbx_business_glossary_term' = 'Dppm Record Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `failure_analysis_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Analysis Report Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`customer_complaint` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Related Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` SET TAGS ('dbx_subdomain' = 'product_qualification');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ALTER COLUMN `test_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Test Plan Identifier');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ALTER COLUMN `quality_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Qualification Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ALTER COLUMN `approver` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ALTER COLUMN `approver` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ALTER COLUMN `author` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`quality`.`test_plan` ALTER COLUMN `author` SET TAGS ('dbx_pii_name' = 'true');
