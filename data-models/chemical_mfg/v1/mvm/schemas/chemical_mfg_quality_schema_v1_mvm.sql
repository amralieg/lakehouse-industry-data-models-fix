-- Schema for Domain: quality | Business: Chemical Mfg | Version: v1_mvm
-- Generated on: 2026-05-06 14:37:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`quality` COMMENT 'Quality control and assurance domain managing laboratory testing, analytical results, COA/COC generation, and quality specifications. Includes QC test methods, sampling plans, inspection lots, quality notifications (OOS, OOT), CAPA workflows, quality hold/release decisions, SPC metrics, and GMP compliance records. Integrates with LabWare LIMS for test data and maintains quality history for regulatory audits and ISO 9001 compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT 'System-generated unique identifier for the inspection lot record.',
    `calibration_record_id` BIGINT COMMENT 'Foreign key linking to maintenance.calibration_record. Business justification: GMP batch release requires that the calibration record of inspection equipment is valid during the inspection lot. Regulatory audits (FDA, EMA) verify this traceability. Chemical manufacturing quality',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Required for Lot‑to‑Product traceability report linking each inspected lot to its chemical product for release and compliance.',
    `coa_document_id` BIGINT COMMENT 'Reference to the generated Certificate of Analysis for this lot.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection cost allocation: each inspection lots labor/material cost is charged to a cost center for budgeting and variance analysis.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Required for batch traceability to the specific equipment that produced the lot, enabling root‑cause analysis and maintenance planning.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Inspection lots are performed at a specific facility. Multi-site chemical manufacturers require facility-level traceability for regulatory reporting, site quality metrics, and EHS compliance audits. p',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Grade-specific inspection is fundamental in chemical manufacturing — USP, ACS, and technical grades have distinct acceptance criteria and sampling requirements. Inspection lots must reference grade to',
    `inbound_delivery_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_delivery. Business justification: Inspection lots are triggered by inbound deliveries in chemical manufacturing. inbound_delivery already has a denormalized inspection_lot_number plain text field; a proper FK replaces this and enables',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: inspection_lot is executed according to an inspection_plan; linking to the plan provides the test method and other plan details, removing duplicated method code fields.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Inspection lots in chemical manufacturing generate lab and inspection costs (analyst time, reagents, equipment usage). Internal orders track inspection campaign costs for project-level quality cost re',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: An inspection lot is created for a specific inventory lot in chemical manufacturing QM. lot_number on inspection_lot is a denormalized text reference. Direct FK enables GMP batch traceability, inspect',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Inspection lots are performed on specific physical lots; linking enables the Inspection Lot Report to pull lot provenance data.',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Incoming inspection lots must be evaluated against the approved material specification (assay, pH, moisture, particle size limits). QC labs reference material_specification for acceptance criteria dur',
    `order_id` BIGINT COMMENT 'Foreign key linking to product.product_order. Business justification: Order-triggered inspection lots are standard in chemical manufacturing. Linking inspection lot to product order enables order-level quality status tracking, automated delivery hold/release workflows, ',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to planning.planned_order. Business justification: Production Order Completion Confirmation: inspection lot results are recorded against the specific planned order that produced the lot, enabling closure and traceability.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or chemical substance being inspected.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: In chemical manufacturing, inspection lots are created per production schedule run. Linking inspection_lot to production_schedule enables schedule-quality correlation reports and batch traceability — ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Incoming inspection lots in chemical manufacturing are created from purchase orders. Direct FK enables incoming inspection reporting by PO, supports GR/GI quality gating, and is standard in SAP QM-MM ',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: OSHA HazCom and GMP require SDS availability at point of inspection for chemical products. Inspectors must reference SDS for correct PPE, handling, and hazard protocols during sampling. Chemical manuf',
    `sampling_plan_id` BIGINT COMMENT 'Identifier of the sampling plan applied to this lot.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Incoming goods and outbound release inspections in chemical mfg are triggered by specific shipments. Tracing inspection_lot to the causative shipment is essential for GMP compliance, shipment release ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Receiving and finished-goods inspection lots in chemical manufacturing are tied to specific SKUs (pack size, packaging type). CoA generation, batch release, and customer traceability all require SKU-l',
    `supplier_material_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.supplier_material. Business justification: Incoming inspection lots are received from a specific suppliers material offering. This link enables supplier-specific quality performance KPIs (acceptance rates, OOS frequency by supplier-material),',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Regulatory traceability report requires linking each inspection lot to its supplying vendor for batch provenance.',
    `batch_number` STRING COMMENT 'Batch or lot identifier of the material supplied to the inspection.',
    `coa_number` STRING COMMENT 'Human‑readable identifier of the COA document.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the inspection lot record was first created.',
    `disposition_by` STRING COMMENT 'User identifier of the person who authorized the disposition.',
    `disposition_code` STRING COMMENT 'Final decision for the lot after inspection (e.g., accept, rework, scrap).. Valid values are `accept|rework|scrap|return|quarantine`',
    `disposition_date` DATE COMMENT 'Date on which the disposition decision was recorded.',
    `expiration_date` DATE COMMENT 'Date after which the inspected material is considered expired or unsuitable for use.',
    `gmp_compliant` BOOLEAN COMMENT 'Indicates whether the inspection complies with Good Manufacturing Practice requirements.',
    `hold_flag` BOOLEAN COMMENT 'Indicates whether the lot is placed on quality hold pending further investigation.',
    `inspection_end_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection activity was completed.',
    `inspection_lot_status` STRING COMMENT 'Current lifecycle status of the inspection lot.. Valid values are `created|sample_drawn|results_recorded|decision_made|closed|cancelled`',
    `inspection_reason` STRING COMMENT 'Reason for initiating the inspection (e.g., incoming goods, in‑process, periodic, customer complaint).. Valid values are `incoming|in_process|outgoing|periodic|complaint`',
    `inspection_source` STRING COMMENT 'Origin of the inspection data: performed in‑lab, field sampling, or automated sensor.. Valid values are `lab|field|automated`',
    `inspection_start_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection activity began.',
    `inspection_version` STRING COMMENT 'Version number of the inspection record for concurrency control.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last updated the inspection lot record.',
    `lot_type` STRING COMMENT 'Category indicating why the lot was created: incoming goods receipt, in‑process production, scheduled periodic inspection, or customer return.. Valid values are `goods_receipt|production|periodic|customer_return`',
    `measurement_uom` STRING COMMENT 'Unit of measure for the primary measurement value. [ENUM-REF-CANDIDATE: kg|lb|L|gal|ppm|%|mol — 7 candidates stripped; promote to reference product]',
    `measurement_value` DECIMAL(18,2) COMMENT 'Resulting numeric value from the primary analytical measurement.',
    `oos_flag` BOOLEAN COMMENT 'True if any test result falls outside the defined specification limits.',
    `oot_flag` BOOLEAN COMMENT 'True if test results deviate from historical trend limits.',
    `pass_fail_flag` BOOLEAN COMMENT 'Indicates whether the lot passed all required specifications (True = Pass).',
    `quantity_inspected` DECIMAL(18,2) COMMENT 'Total amount of material inspected, expressed in the unit of measure.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the inspection satisfies applicable regulatory requirements (e.g., EPA, OSHA).',
    `remarks` STRING COMMENT 'Free‑form comments or notes entered by quality personnel.',
    `sample_quantity` DECIMAL(18,2) COMMENT 'Quantity of material taken as a sample for testing.',
    `sample_uom` STRING COMMENT 'Unit of measure for the sample quantity.. Valid values are `kg|lb|L|gal|pcs|mol`',
    `uom` STRING COMMENT 'Unit of measure for the inspected quantity (e.g., kilograms, liters).. Valid values are `kg|lb|L|gal|pcs|mol`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the inspection lot record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the inspection lot record.',
    CONSTRAINT pk_inspection_lot PRIMARY KEY(`inspection_lot_id`)
) COMMENT 'Core inspection lot entity representing a quality inspection event triggered by goods receipt, production completion, periodic inspection, or customer return. Captures lot origin, inspection type, lot quantity, material/batch reference, plant, storage location, inspection start/end dates, lot status (created, sample drawn, results recorded, usage decision made), usage decision reference, and GMP compliance flags. Central transactional hub linking samples, test results, and disposition decisions in the quality workflow.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`qc_result` (
    `qc_result_id` BIGINT COMMENT 'Unique surrogate key for each QC test result record.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to production.batch_record. Business justification: QC result is recorded per batch; linking enables batch‑level yield and defect analytics required by GMP.',
    `calibration_record_id` BIGINT COMMENT 'Foreign key linking to maintenance.calibration_record. Business justification: GMP and ISO 17025 require traceability from every QC measurement result to the calibration record of the instrument used. Chemical manufacturing OOS investigations and regulatory audits depend on this',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Enables Product Quality Dashboard aggregating QC results per chemical product, a standard GMP reporting requirement.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Links test results to the equipment used, supporting equipment performance monitoring and preventive maintenance decisions.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: GMP traceability requires linking analytical QC results directly to the physical goods receipt event. Enables incoming material release reporting and supports regulatory audit trails from receipt thro',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: QC results must be evaluated against grade-specific specification limits (USP purity ≥99.5% vs. technical grade ≥95%). Grade-level result tracking drives CoA content, batch release decisions, and regu',
    `inspection_characteristic_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_characteristic. Business justification: A QC result measures a specific inspection characteristic (quality parameter). qc_result currently stores characteristic_name as a STRING but has no FK to the inspection_characteristic master. Adding ',
    `inspection_lot_id` BIGINT COMMENT 'Identifier of the inspection lot to which this result belongs.',
    `lab_sample_id` BIGINT COMMENT 'Identifier of the associated control sample, if applicable.',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to order.line_item. Business justification: QC result tied to order line enables the Quality Release Decision process that determines release of goods to the customer.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: QC results must be tied to the specific production lot they belong to for release and traceability.',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: QC results must be traceable to the specific raw material lot for batch disposition, recall management, and regulatory audit trails. Lot-level QC traceability is a fundamental GMP requirement in chemi',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Required for QC test result traceability to the master material record; QC labs report results per material type in daily QC reports.',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Each QC result is measured against a specific material specifications LSL/USL limits. This link enables OOS investigation, specification change impact analysis, and pass/fail determination — core qua',
    `measurement_point_id` BIGINT COMMENT 'Foreign key linking to maintenance.measurement_point. Business justification: QC results from inline analyzers and process sensors in chemical manufacturing are taken at specific measurement points on equipment. Tracing a QC result to its measurement point enables process capab',
    `quality_deviation_id` BIGINT COMMENT 'Reference to an OOS/OOT quality notification linked to this result.',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: QC results for chemical products reference SDS to validate test conditions (flash point, pH, vapor pressure) against SDS specifications. GHS/REACH compliance verification in chemical QC labs requires ',
    `safety_incident_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_incident. Business justification: OOS QC results in chemical manufacturing can directly trigger safety incidents (toxic exposure, process upset). Quality investigators cross-reference QC results with safety incidents for root cause an',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: QC results in chemical manufacturing are recorded against specific SKUs for CoA generation, customer-specific spec compliance, and batch release. SKU-level QC traceability is required for regulatory s',
    `spc_control_id` BIGINT COMMENT 'Identifier of the SPC chart to which this result contributes.',
    `test_method_id` BIGINT COMMENT 'Foreign key linking to quality.test_method. Business justification: Every QC result is produced using a specific analytical test method. qc_result currently stores test_method_code as a STRING denormalized attribute but has no FK to the test_method master table. Addin',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Vendor quality performance reporting (pass/fail rates, OOS frequency by vendor) is a standard procurement KPI in chemical manufacturing. QC results on incoming materials must be attributable to the su',
    `comment` STRING COMMENT 'Free‑text notes or observations entered by the analyst.',
    `compliance_reference` STRING COMMENT 'Reference to the regulatory or standard clause (e.g., ISO 9001) governing this test.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the QC result record was created in the system.',
    `data_source_system` STRING COMMENT 'Originating system that supplied the result data.. Valid values are `LabWare LIMS|SAP QM`',
    `deviation_amount` DECIMAL(18,2) COMMENT 'Numeric difference between result value and nearest specification limit.',
    `deviation_percent` DECIMAL(18,2) COMMENT 'Percentage deviation of the result from the target specification.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage at time of measurement.',
    `is_control_sample` BOOLEAN COMMENT 'Indicates whether the sample is a control sample used for method verification.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Lower acceptable limit for the characteristic.',
    `material_cas_number` STRING COMMENT 'Unique CAS registry number identifying the chemical substance.. Valid values are `^d{2,7}-d{2}-d$`',
    `measurement_sequence` STRING COMMENT 'Ordinal position of this measurement within the inspection lot.',
    `measurement_type` STRING COMMENT 'Indicates if the measurement is quantitative or qualitative.. Valid values are `quantitative|qualitative`',
    `pressure_kpa` DECIMAL(18,2) COMMENT 'Atmospheric pressure during measurement, in kilopascals.',
    `raw_data_reference` STRING COMMENT 'Link or identifier to the raw instrument data file or dataset.',
    `result_status` STRING COMMENT 'Outcome of the test relative to specifications.. Valid values are `pass|fail|oos|oot|pending`',
    `result_value` DECIMAL(18,2) COMMENT 'Numeric value measured for the characteristic.',
    `retest_flag` BOOLEAN COMMENT 'Indicates whether the sample requires a retest (true) or not (false).',
    `spc_flag` BOOLEAN COMMENT 'True if the result is included in Statistical Process Control analysis.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Ambient or sample temperature at time of measurement, in degrees Celsius.',
    `test_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was taken.',
    `unit_of_measure` STRING COMMENT 'Unit in which the result value is expressed.. Valid values are `mg/L|ppm|%|pH|°C`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the QC result record.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper acceptable limit for the characteristic.',
    CONSTRAINT pk_qc_result PRIMARY KEY(`qc_result_id`)
) COMMENT 'Individual analytical test result record from LabWare LIMS or SAP QM for a specific characteristic measured during an inspection lot. Captures test method, characteristic name, measured value, unit of measure, lower/upper specification limits, result status (pass, fail, OOS, OOT), analyst ID, instrument ID, test date/time, retest flag, and raw data reference. Supports SPC charting and regulatory audit trails per ISO 9001 and GMP requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`test_method` (
    `test_method_id` BIGINT COMMENT 'Unique surrogate key for each analytical test method.',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: Test methods for chemical analysis must reference SDS for safe handling of reagents, required PPE, and waste disposal procedures. ISO 17025 and GLP require documented safety procedures linked to test ',
    `accuracy_percent` DECIMAL(18,2) COMMENT 'Typical accuracy of the method expressed as a percentage.',
    `applicable_product_family` STRING COMMENT 'Product families for which the method is valid.',
    `approval_date` DATE COMMENT 'Date when the method received formal approval.',
    `approval_status` STRING COMMENT 'Regulatory or quality approval state of the method.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name of the person or authority that approved the method.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test method record was created.',
    `detection_limit` STRING COMMENT 'Lowest concentration reliably measurable by the method (e.g., "0.01 mg/L").',
    `effective_date` DATE COMMENT 'Date when the method became officially usable.',
    `expiration_date` DATE COMMENT 'Date after which the method is no longer valid (nullable).',
    `instrument_type` STRING COMMENT 'Primary analytical instrument required for the method.. Valid values are `HPLC|GC|ICP-MS|UV-Vis|FTIR|NMR`',
    `is_gmp_compliant` BOOLEAN COMMENT 'Indicates whether the method complies with Good Manufacturing Practice.',
    `is_iso17025_compliant` BOOLEAN COMMENT 'Indicates whether the method meets ISO/IEC 17025 laboratory accreditation requirements.',
    `method_code` STRING COMMENT 'Business code uniquely identifying the test method.',
    `method_name` STRING COMMENT 'Human‑readable name of the analytical test method.',
    `method_type` STRING COMMENT 'Category of analytical technique used by the method.. Valid values are `titration|chromatography|spectroscopy|gravimetric|microbiological|other`',
    `precision_percent` DECIMAL(18,2) COMMENT 'Typical repeatability (precision) of the method expressed as a percentage.',
    `revision_number` STRING COMMENT 'Sequential revision count for the method.',
    `safety_considerations` STRING COMMENT 'Safety notes and precautions associated with the method.',
    `sample_preparation_steps` STRING COMMENT 'Detailed procedural steps to prepare a sample before analysis.',
    `stock_quantity` DECIMAL(18,2) COMMENT 'Current inventory quantity of the reference standard.',
    `test_method_status` STRING COMMENT 'Current lifecycle status of the test method.. Valid values are `active|inactive|deprecated|draft|retired`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test method record.',
    `validation_by` STRING COMMENT 'Name of the person or group that performed the validation.',
    `validation_date` DATE COMMENT 'Date when the method was last validated against standards.',
    `version_number` STRING COMMENT 'Version identifier for the method definition.',
    CONSTRAINT pk_test_method PRIMARY KEY(`test_method_id`)
) COMMENT 'Master record defining standardized analytical test methods and associated reference standards/reagents used in quality control and laboratory testing. Includes method code, method name, method type (titration, chromatography, spectroscopy, gravimetric, microbiological), applicable product families, instrument type, reagent requirements, sample preparation steps, applicable standard (ASTM, ISO, USP, internal), version number, effective date, and approval status. Embeds reference standard master data: standard ID, standard name, CAS number, standard type (primary, secondary, working, certified reference material), supplier, lot number, purity/concentration, certificate number, receipt date, expiry date, storage condition, current stock quantity, reorder level, and traceability chain (NIST, ECHA, pharmacopoeia). Single source of truth for analytical methodology and the certified reference materials that support measurement traceability per ISO/IEC 17025 and GMP requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` (
    `inspection_characteristic_id` BIGINT COMMENT 'Unique surrogate key for the inspection characteristic record.',
    `measurement_point_id` BIGINT COMMENT 'Foreign key linking to maintenance.measurement_point. Business justification: In chemical manufacturing, inline and at-line quality inspection characteristics (e.g., reactor temperature, pH, viscosity) map directly to equipment measurement points with PI historian tags. Process',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: An inspection characteristic is governed by a quality specification that defines the approved acceptance limits. inspection_characteristic currently stores lower_spec_limit, upper_spec_limit, and targ',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: Inspection characteristics for hazardous chemical properties (flash point, pH, vapor pressure) must reference SDS to ensure test methods and acceptance criteria align with GHS hazard classifications. ',
    `test_method_id` BIGINT COMMENT 'Foreign key linking to quality.test_method. Business justification: inspection_characteristic defines which test method is used; linking to test_method eliminates redundant string reference and enforces referential integrity.',
    `acceptance_criteria` STRING COMMENT 'Textual description of the criteria used to accept or reject a result.',
    `characteristic_code` STRING COMMENT 'Business identifier used to reference the characteristic in processes and documentation.',
    `characteristic_type` STRING COMMENT 'Indicates whether the characteristic is quantitative, qualitative, or an attribute‑type check.. Valid values are `quantitative|qualitative|attribute`',
    `confidentiality_level` STRING COMMENT 'Data classification level for the characteristic definition.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the characteristic record was created.',
    `data_source_system` STRING COMMENT 'System of record where the characteristic definition originates.. Valid values are `SAP_QM|LabWare_LIMS|Custom`',
    `decimal_precision` STRING COMMENT 'Number of decimal places stored for numeric values of this characteristic.',
    `default_sampling_size` STRING COMMENT 'Standard number of samples to be taken per lot when this characteristic is applied.',
    `effective_end_date` DATE COMMENT 'Date after which the characteristic definition is no longer valid (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which the characteristic definition is valid.',
    `gmp_critical_flag` BOOLEAN COMMENT 'Indicates whether the characteristic is critical for Good Manufacturing Practice compliance.',
    `inspection_characteristic_description` STRING COMMENT 'Detailed description of what the characteristic measures and its relevance.',
    `inspection_characteristic_name` STRING COMMENT 'Human‑readable name of the quality characteristic.',
    `inspection_characteristic_status` STRING COMMENT 'Current lifecycle status of the characteristic.. Valid values are `active|inactive|deprecated|pending`',
    `last_review_date` DATE COMMENT 'Date when the characteristic definition was last reviewed for relevance or accuracy.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Statistical lower control limit used for SPC monitoring.',
    `measurement_category` STRING COMMENT 'Broad category of the measurement (e.g., physical, chemical).. Valid values are `physical|chemical|biological|microbial`',
    `owner_department` STRING COMMENT 'Business department responsible for maintaining the characteristic.. Valid values are `quality|production|research|safety`',
    `regulatory_requirement` STRING COMMENT 'Regulation(s) that drive the definition or limits of this characteristic.. Valid values are `EPA|OSHA|REACH|GHS|ISO9001|ISO14001`',
    `review_cycle_days` STRING COMMENT 'Planned interval in days between periodic reviews of the characteristic.',
    `sampling_procedure` STRING COMMENT 'Method used to select samples for this characteristic.. Valid values are `random|systematic|stratified|batch|continuous`',
    `specification_version` STRING COMMENT 'Version identifier of the specification governing this characteristic.',
    `unit_of_measure` STRING COMMENT 'Unit in which the characteristic is measured (e.g., kg, L, ppm, pH). [ENUM-REF-CANDIDATE: kg|g|mg|L|mL|ppm|%|pH|°C|°F — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the characteristic record.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Statistical upper control limit used for SPC monitoring.',
    CONSTRAINT pk_inspection_characteristic PRIMARY KEY(`inspection_characteristic_id`)
) COMMENT 'Master definition of a quality characteristic (parameter) to be measured within an inspection plan. Captures characteristic code, description, characteristic type (quantitative, qualitative, attribute), unit of measure, target value, lower/upper specification limits (LSL/USL), lower/upper control limits (LCL/UCL) for SPC, sampling procedure, test method reference, decimal precision, and GMP-critical flag. Linked to inspection plans and drives qc_result recording.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` (
    `inspection_plan_id` BIGINT COMMENT 'Unique identifier for the inspection plan.',
    `chemical_product_id` BIGINT COMMENT 'FK to product.chemical_product',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Inspection plans are scoped to specific manufacturing facilities due to different equipment, regulatory jurisdictions, and process conditions. Multi-site chemical manufacturers maintain facility-speci',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Inspection plans in chemical manufacturing are grade-specific — pharmaceutical grades require tighter AQL, more frequent sampling, and additional test methods than technical grades. Grade-to-inspectio',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Inspection plans are created per material; the plan definition references the Material Master for specification lookup.',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Inspection plans are built from material specifications — acceptance criteria (assay limits, pH range, moisture limits) come directly from material_specification. This link enables specification-drive',
    `pm_plan_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_plan. Business justification: Integrated inspection planning in chemical manufacturing coordinates quality inspection plans with preventive maintenance plans for equipment-based inspections (pressure vessels, reactors, heat exchan',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: Inspection plans for chemical products must reference SDS to define safe handling procedures, required PPE, and hazard controls for the inspection process. GMP and PSM standards in chemical manufactur',
    `sampling_plan_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_plan. Business justification: An inspection plan defines which sampling plan to use for sample collection. inspection_plan currently has sample_size_code, sampling_scheme_type, and sampling_standard as denormalized STRING attribut',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: SKU-specific inspection plans cover packaging-related criteria (container integrity, fill weight, label verification) that vary by pack size and packaging type. Regulatory and customer audit requireme',
    `test_method_id` BIGINT COMMENT 'FK to quality.test_method',
    `acceptance_number` STRING COMMENT 'Maximum number of defectives allowed for acceptance.',
    `aql` DECIMAL(18,2) COMMENT 'Maximum acceptable percentage of defective items.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) the plan must satisfy.. Valid values are `GHS|REACH|TSCA|EPA`',
    `control_lcl` DECIMAL(18,2) COMMENT 'Lower statistical control limit for SPC.',
    `control_ucl` DECIMAL(18,2) COMMENT 'Upper statistical control limit for SPC.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection plan record was created.',
    `decimal_precision` STRING COMMENT 'Number of decimal places for numeric results.',
    `dynamic_modification_rules` STRING COMMENT 'Textual rules allowing plan modifications based on lot size or other triggers.',
    `effective_from` DATE COMMENT 'Date from which the inspection plan becomes valid.',
    `effective_until` DATE COMMENT 'Date when the inspection plan expires (null if open‑ended).',
    `gmp_critical_flag` BOOLEAN COMMENT 'Indicates if the characteristic is GMP‑critical.',
    `inspection_level` STRING COMMENT 'Inspection level code determining sample size per AQL.. Valid values are `I|II|III|IV|V`',
    `inspection_plan_status` STRING COMMENT 'Current lifecycle status of the inspection plan.. Valid values are `active|inactive|deprecated`',
    `inspection_stage` STRING COMMENT 'Stage of production where the inspection occurs.. Valid values are `incoming|in_process|final|rework`',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent plan review.',
    `lot_size_max` BIGINT COMMENT 'Largest lot size for which this sampling plan applies.',
    `lot_size_min` BIGINT COMMENT 'Smallest lot size for which this sampling plan applies.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the inspection plan.',
    `plan_number` STRING COMMENT 'External identifier assigned to the inspection plan.',
    `plan_type` STRING COMMENT 'Classification of the plan based on its applicability (material, product, or process).. Valid values are `material|product|process`',
    `plan_version` STRING COMMENT 'Version label of the inspection plan, allowing multiple revisions.',
    `rejection_number` STRING COMMENT 'Minimum number of defectives that triggers rejection.',
    `review_status` STRING COMMENT 'Current status of the plans review process.. Valid values are `pending|approved|rejected`',
    `spec_type` STRING COMMENT 'Nature of the specification limits.. Valid values are `absolute|percentage|ratio`',
    `specification_lsl` DECIMAL(18,2) COMMENT 'Lower bound of the acceptable specification range.',
    `specification_usl` DECIMAL(18,2) COMMENT 'Upper bound of the acceptable specification range.',
    `target_value` DECIMAL(18,2) COMMENT 'Desired target measurement for the characteristic.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection plan.',
    `usage_context` STRING COMMENT 'Business context in which the plan is executed.. Valid values are `goods_receipt|in_process|final_release`',
    CONSTRAINT pk_inspection_plan PRIMARY KEY(`inspection_plan_id`)
) COMMENT 'Master quality inspection plan defining the complete template for material/product quality evaluation. Includes plan number, version, material/product reference, plant, usage context (goods receipt, in-process, final release), inspection stage, and the full set of inspection characteristics (parameter definitions with target values, specification limits LSL/USL, control limits LCL/UCL for SPC, characteristic types, test method references, decimal precision, GMP-critical flags). Embeds statistical sampling plan details: sampling scheme type (single, double, sequential), inspection level, AQL (Acceptable Quality Level), lot size range, sample size code letter, acceptance/rejection numbers, dynamic modification rules, and applicable sampling standard (ISO 2859, MIL-STD-1916). Serves as the single authoritative template driving inspection lot creation, sample size determination, and characteristic assignment in SAP QM.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` (
    `sampling_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the sampling plan.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Sampling plans in chemical manufacturing are defined for specific chemical products based on hazard class, regulatory requirements, and historical quality data. Product-level sampling plan assignment ',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Sampling frequency and sample size differ by grade — pharmaceutical grades require tighter sampling than industrial grades. Grade-specific sampling plans are a GMP requirement in chemical manufacturin',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Sampling plans can be material‑specific to meet regulatory sampling frequency; linking provides direct material context.',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: Sampling plans for hazardous chemicals must reference SDS to define safe sampling procedures, required PPE, and containment requirements. OSHA HazCom and GMP standards in chemical manufacturing requir',
    `acceptance_number` STRING COMMENT 'Maximum number of defective items allowed for the lot to be accepted.',
    `applicable_material_class` STRING COMMENT 'Material class to which the sampling plan applies.. Valid values are `raw_material|intermediate|finished|packaging`',
    `applicable_process_stage` STRING COMMENT 'Manufacturing process stage where the plan is used.. Valid values are `procurement|synthesis|blending|packaging|distribution`',
    `aql_unit` STRING COMMENT 'Unit for the AQL value (typically percent).',
    `aql_value` DECIMAL(18,2) COMMENT 'Numeric AQL value defining the acceptable defect rate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sampling plan record was created.',
    `dynamic_modification_flag` BOOLEAN COMMENT 'Indicates whether the sampling plan can be modified dynamically during execution.',
    `effective_end_date` DATE COMMENT 'Date when the sampling plan expires or is superseded (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the sampling plan becomes effective.',
    `inspection_level` STRING COMMENT 'Inspection level code defining the sampling intensity as per ISO 2859.. Valid values are `I|II|III|IV|V`',
    `last_review_date` DATE COMMENT 'Date when the sampling plan was last reviewed for relevance.',
    `lot_size_max` BIGINT COMMENT 'Maximum lot size (in units) for which this plan is applicable.',
    `lot_size_min` BIGINT COMMENT 'Minimum lot size (in units) for which this plan is applicable.',
    `next_review_date` DATE COMMENT 'Planned date for the next review of the sampling plan.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the sampling plan.',
    `plan_code` STRING COMMENT 'Business code used to reference the sampling plan in operational systems.',
    `plan_name` STRING COMMENT 'Human‑readable name of the sampling plan.',
    `plan_type` STRING COMMENT 'Classification of the plan based on the sampling scheme (single, double, or sequential).. Valid values are `single|double|sequential`',
    `regulatory_standard` STRING COMMENT 'Regulatory or industry standard governing the sampling plan (e.g., ISO 2859, MIL‑STD‑1916).. Valid values are `ISO2859|MILSTD1916`',
    `rejection_number` STRING COMMENT 'Minimum number of defective items that cause the lot to be rejected.',
    `sample_size` BIGINT COMMENT 'Number of units to be sampled from each lot.',
    `sample_size_code` STRING COMMENT 'Letter code representing the sample size according to the sampling table.',
    `sampling_frequency` STRING COMMENT 'Frequency at which sampling is performed.. Valid values are `per_batch|per_shift|per_day|per_week`',
    `sampling_method` STRING COMMENT 'Statistical method used to select samples (e.g., random, stratified).. Valid values are `random|stratified|systematic|judgmental`',
    `sampling_plan_description` STRING COMMENT 'Detailed description of the purpose, scope, and application of the plan.',
    `sampling_plan_status` STRING COMMENT 'Current lifecycle status of the sampling plan.. Valid values are `active|inactive|retired|draft|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sampling plan.',
    `version_number` STRING COMMENT 'Version number of the sampling plan for change control.',
    CONSTRAINT pk_sampling_plan PRIMARY KEY(`sampling_plan_id`)
) COMMENT 'Statistical sampling plan defining sample size, sampling frequency, acceptance/rejection criteria, and AQL (Acceptable Quality Level) for a given inspection stage and material class. Captures sampling scheme type (single, double, sequential), inspection level, lot size range, sample size code letter, acceptance number, rejection number, dynamic modification rules, and applicable regulatory standard (ISO 2859, MIL-STD-1916). Referenced by inspection plans to determine how many samples to draw.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` (
    `usage_decision_id` BIGINT COMMENT 'System generated unique identifier for the usage decision record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Ties release/hold decisions to the product, required for release‑authorization workflow and audit trail.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Release/rework cost allocation: usage decisions (release, rework, hold) generate cost entries that must be posted to the responsible cost center.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Usage decision (release/reject/reprocess) is the disposition outcome for received goods. Direct FK to goods_receipt enables incoming material disposition reporting, return-to-vendor processing, and GM',
    `inspection_lot_id` BIGINT COMMENT 'Reference to the inspection lot that this decision applies to.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Usage decisions release material from a specific lot; linking to inventory lot enables accurate stock deduction and compliance.',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Usage decisions (release, reject, reprocess) are made on specific raw material lots after incoming inspection. Direct lot_record linkage enables lot disposition tracking and regulatory audit trails fo',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Usage decisions apply to a specific raw material. Direct material_master linkage supports material-level disposition reporting and regulatory compliance dashboards without requiring joins through insp',
    `order_id` BIGINT COMMENT 'Foreign key linking to product.product_order. Business justification: Usage decisions (release/reject/reprocess) in chemical manufacturing directly affect order fulfillment. Linking usage decision to product order enables automated order release, backorder management, a',
    `quality_specification_id` BIGINT COMMENT 'Reference to the quality specification that governs the inspection criteria.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to the audit trail entry capturing the decision workflow.',
    `batch_number` STRING COMMENT 'Batch identifier for the production batch associated with the inspection lot.',
    `comments` STRING COMMENT 'Free‑text comments entered by the decision maker or quality engineer.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the decision complies with GMP and ISO 9001 requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the usage decision record was first created in the system.',
    `decision_code` STRING COMMENT 'Code representing the final disposition of the inspection lot after evaluation.. Valid values are `accept|reject|conditional_release|reprocess|scrap|return_to_vendor`',
    `decision_date` TIMESTAMP COMMENT 'Timestamp when the usage decision was made.',
    `defect_quantity` DECIMAL(18,2) COMMENT 'Quantity of material identified as defective in the inspection lot.',
    `digital_signature` STRING COMMENT 'Base‑64 encoded digital signature of the decision maker for GMP compliance.',
    `expiration_date` DATE COMMENT 'Expiration date of the material, if applicable.',
    `follow_up_action_code` STRING COMMENT 'Code indicating the follow‑up action triggered by the decision.. Valid values are `none|rework|investigate|capability|audit`',
    `hold_quantity` DECIMAL(18,2) COMMENT 'Quantity of material placed on hold or blocked.',
    `is_conditional_release` BOOLEAN COMMENT 'Indicates whether the decision includes a conditional release of the material.',
    `plant_code` STRING COMMENT 'Code of the manufacturing plant where the inspection took place.',
    `reason_code` STRING COMMENT 'Code describing the primary reason for the usage decision.. Valid values are `out_of_spec|out_of_trend|process_deviation|customer_complaint`',
    `release_date` TIMESTAMP COMMENT 'Timestamp when the material was released to inventory.',
    `release_quantity` DECIMAL(18,2) COMMENT 'Quantity of material approved for unrestricted release.',
    `reprocess_quantity` DECIMAL(18,2) COMMENT 'Quantity of material earmarked for reprocessing as a result of the decision.',
    `source_system` STRING COMMENT 'System of record where the usage decision originated.. Valid values are `SAP_QM|LabWare|Custom`',
    `stock_posting_instruction` STRING COMMENT 'Instruction for how the material should be posted in inventory after the decision.. Valid values are `unrestricted|blocked|returns|quarantine`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the usage decision record.',
    `usage_decision_status` STRING COMMENT 'Current lifecycle status of the usage decision record.. Valid values are `pending|completed|closed|cancelled`',
    CONSTRAINT pk_usage_decision PRIMARY KEY(`usage_decision_id`)
) COMMENT 'Quality usage decision record capturing the final disposition of an inspection lot after all test results are evaluated. Records decision code (accept, reject, conditional release, reprocess, scrap, return to vendor), decision date, decision maker, stock posting instruction (unrestricted, blocked, returns), defect quantity, follow-up action triggered, and digital signature for GMP compliance. Drives downstream inventory stock transfer in SAP QM/EWM.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` (
    `quality_deviation_id` BIGINT COMMENT 'Primary key for deviation',
    `breakdown_event_id` BIGINT COMMENT 'Foreign key linking to maintenance.breakdown_event. Business justification: Root cause analysis (RCA/RCFA) in chemical manufacturing requires correlating quality deviations with equipment breakdown events. Off-spec batches caused by reactor or mixer failures must be traceable',
    `calibration_record_id` BIGINT COMMENT 'Foreign key linking to maintenance.calibration_record. Business justification: OOS (out-of-specification) investigations in GMP chemical manufacturing must evaluate whether an out-of-calibration instrument caused the deviation. Linking quality_deviation to calibration_record ena',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Links each deviation directly to the affected product for regulatory incident reports and root‑cause analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deviation cost allocation: quality notifications are charged to the cost center responsible for the material/process that caused the deviation.',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: Cost of Quality reporting in chemical manufacturing classifies deviation costs by cost element (scrap, rework, inspection failure). The cost_of_quality field on quality_deviation needs cost element cl',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer Complaint Management report requires linking each quality deviation to the reporting customer account to track complaints and regulatory notifications.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Complaint handling process records the specific contact who raised the issue, enabling traceability and follow‑up in the Customer Interaction system.',
    `emission_event_id` BIGINT COMMENT 'Foreign key linking to ehs.emission_event. Business justification: Quality deviations involving chemical releases or process upsets may directly cause emission events. Environmental compliance teams cross-reference quality deviations with emission events for TRI/CERC',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Quality deviations on incoming raw materials must trace to the originating goods receipt for supplier claims, return-to-vendor (RTV) processing, and incoming quality reporting. Standard NCR management',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A quality deviation (OOS/OOT notification) is typically triggered by a failed inspection lot result. quality_deviation currently has no FK to inspection_lot — it only has indirect traceability via qc_',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Quality deviations in chemical manufacturing trigger rework, disposal, or reprocessing costs tracked via internal orders. The cost_of_quality field on quality_deviation requires an internal order refe',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Quality deviations are investigated per lot; linking to the lot record supports root‑cause analysis and hold management.',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Quality deviations (NCRs) are raised against specific raw material lots. Lot-level deviation tracking is required for batch disposition decisions and regulatory investigations — every chemical manufac',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Deviation reports reference a material; a FK to Material Master enables root‑cause analysis and regulatory reporting.',
    `notification_id` BIGINT COMMENT 'Foreign key linking to maintenance.notification. Business justification: Equipment malfunction notifications in SAP PM directly trigger quality deviations in chemical plants. Quality engineers reference the maintenance notification when documenting equipment-related deviat',
    `order_id` BIGINT COMMENT 'Foreign key linking to product.product_order. Business justification: Quality deviations in chemical manufacturing are frequently triggered by order-specific non-conformances or customer complaints. Linking deviation to the originating product order enables order-level ',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: A quality deviation represents a departure from an approved quality specification. Adding quality_specification_id to quality_deviation links the deviation to the specific specification that was viola',
    `safety_incident_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_incident. Business justification: Root‑cause analysis: quality deviations that result in safety incidents need a direct link to the incident for integrated investigation and reporting.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Quality deviations in chemical mfg are frequently caused by in-transit temperature excursions, carrier damage, or delivery discrepancies. Linking deviation to the causative shipment is required for ca',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Quality deviations are often SKU-specific (e.g., a specific drum pack size has contamination, a specific grade variant fails purity). SKU-level deviation tracking drives targeted recalls, inventory ho',
    `supplier_material_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.supplier_material. Business justification: Quality deviations are frequently supplier-material specific. This link supports supplier quality scorecards and targeted corrective actions — identifying which supplier-material combination caused th',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Supplier‑origin tracking of quality deviations is needed for root‑cause analysis and regulatory compliance.',
    `waste_disposal_record_id` BIGINT COMMENT 'Foreign key linking to ehs.waste_disposal_record. Business justification: Off-spec batches (quality deviations) in chemical manufacturing generate hazardous waste requiring RCRA-compliant disposal. Linking quality_deviation to waste_disposal_record provides regulatory trace',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Deviations often trigger corrective maintenance work orders; linking tracks the maintenance action tied to each deviation.',
    `analysis_method` STRING COMMENT 'Laboratory test method used to evaluate the material (e.g., HPLC, GC).',
    `analysis_result` STRING COMMENT 'Outcome of the laboratory analysis.. Valid values are `pass|fail|out_of_spec`',
    `batch_number` STRING COMMENT 'Manufacturing batch identifier associated with the deviation.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the notification reached a closed state.',
    `complaint_source` STRING COMMENT 'Origin of the complaint (e.g., customer, internal audit, supplier).',
    `cost_of_quality` DECIMAL(18,2) COMMENT 'Monetary impact of the deviation (e.g., rework, scrap, warranty).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the notification record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost_of_quality.',
    `customer_complaint_type` STRING COMMENT 'Classification of the customer‑originated complaint.. Valid values are `product|service|delivery|other`',
    `customer_reference` STRING COMMENT 'External customer identifier linked to the deviation.',
    `detection_phase` STRING COMMENT 'Process phase where the deviation was detected.. Valid values are `incoming|in_process|outgoing|customer`',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of the actual occurrence or detection of the quality event.',
    `hold_reason` STRING COMMENT 'Reason for placing the material on hold.',
    `impact_quantity` DECIMAL(18,2) COMMENT 'Quantity of material impacted by the deviation.',
    `impact_unit` STRING COMMENT 'Unit of measure for impact_quantity.. Valid values are `kg|l|pcs|g|ml`',
    `is_hold` BOOLEAN COMMENT 'True if the affected material/lot is placed on hold pending investigation.',
    `measurement_unit` STRING COMMENT 'Unit of measure for measurement_value (e.g., ppm, mg/L).',
    `measurement_value` DECIMAL(18,2) COMMENT 'Quantitative measurement associated with the analysis (e.g., concentration).',
    `ncr_disposition` STRING COMMENT 'Final disposition decision for a non‑conformance report.. Valid values are `use_as_is|rework|scrap|return`',
    `notification_type` STRING COMMENT 'Category of quality event triggering the notification.. Valid values are `OOS|OOT|NCR|COMPLAINT|DEVIATION|CUSTOMER_COMPLAINT`',
    `priority` STRING COMMENT 'Operational priority for investigation and resolution.. Valid values are `high|medium|low`',
    `quality_deviation_description` STRING COMMENT 'Detailed narrative of the quality issue, including observed symptoms.',
    `quality_deviation_status` STRING COMMENT 'Current lifecycle status of the quality deviation.. Valid values are `open|in_process|resolved|closed|rejected`',
    `regulatory_reportable` BOOLEAN COMMENT 'Indicates if the deviation must be reported to regulatory bodies (e.g., EPA, FDA).',
    `resolution_action` STRING COMMENT 'Action taken to resolve the deviation (e.g., rework, scrap, release).',
    `resolution_date` DATE COMMENT 'Date on which the deviation was resolved.',
    `responsible_department` STRING COMMENT 'Organizational department accountable for handling the deviation.. Valid values are `production|quality|supply_chain|rd|maintenance|logistics`',
    `root_cause_category` STRING COMMENT 'High‑level classification of the root cause.. Valid values are `equipment|process|material|human|method|environment`',
    `root_cause_detail` STRING COMMENT 'Detailed description of the identified root cause.',
    `severity` STRING COMMENT 'Business impact severity of the deviation.. Valid values are `critical|high|medium|low|informational`',
    `subject` STRING COMMENT 'Brief title or subject line summarizing the deviation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the notification.',
    CONSTRAINT pk_quality_deviation PRIMARY KEY(`quality_deviation_id`)
) COMMENT 'Quality deviation and notification record capturing all types of quality events requiring investigation: OOS (Out of Specification), OOT (Out of Trend), non-conformance reports (NCR), customer complaints, internal deviations, and supplier quality issues. Includes notification type (complaint, defect, NCR, deviation, OOS, OOT), notification number, subject, affected material/batch/lot, defect description, severity/defect class, priority, originator, responsible department, detection phase (incoming, in-process, outgoing, customer), complaint source details (customer reference, complaint type), NCR disposition (use-as-is, rework, scrap, return), status lifecycle (open, in-process, completed, closed), root cause category, cost of quality impact, and regulatory reportability flag. Single source of truth for all quality events requiring investigation, triggering CAPA workflow and linking to hold decisions.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`capa` (
    `capa_id` BIGINT COMMENT 'Primary key for capa',
    `quality_deviation_id` BIGINT COMMENT 'Reference to the Out‑of‑Specification event that triggered the CAPA, if applicable.',
    `capa_related_quality_notification_quality_notification_quality_deviation_id` BIGINT COMMENT 'Reference to a quality notification (e.g., OOS, OOT) linked to this CAPA.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: CAPAs in chemical manufacturing are initiated for specific chemical products (e.g., recurring purity failures on a product line). Product-level CAPA tracking is required for quality management system ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAPAs incur departmental costs (labor, materials, validation). Linking to cost_center enables Cost of Quality (CoQ) reporting by department — a standard financial control requirement in chemical manuf',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: CAPA expenditure classification by cost element (e.g., rework labor, disposal, revalidation) is required for Cost of Quality analysis in chemical manufacturing. cost_actual and cost_estimate on capa n',
    `hazop_study_id` BIGINT COMMENT 'Foreign key linking to ehs.hazop_study. Business justification: CAPAs in chemical manufacturing are initiated from HAZOP study findings (identified process hazards requiring corrective action). Linking quality.capa to the triggering HAZOP study enables PSM complia',
    `incident_investigation_id` BIGINT COMMENT 'Foreign key linking to ehs.incident_investigation. Business justification: CAPAs are formal outputs of incident investigations in chemical manufacturing. OSHA PSM and EPA RMP require CAPAs to be traceable to the investigation that generated them for regulatory closure. No ex',
    `inspection_audit_id` BIGINT COMMENT 'Foreign key linking to ehs.inspection_audit. Business justification: EHS inspection audits (EPA/OSHA regulatory or internal) generate findings requiring CAPAs. In chemical manufacturing, audit findings must be formally linked to CAPAs for compliance closure tracking. q',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: CAPA cost tracking (cost_actual, cost_estimate fields on capa) requires an internal order for financial posting of corrective action expenditures. In GMP chemical manufacturing, CAPA costs must be cap',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: CAPAs are frequently initiated for raw material quality failures (OOS results, supplier non-conformances). Linking CAPA to material_master enables material-level CAPA trending, supplier quality manage',
    `safety_incident_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_incident. Business justification: CAPAs in chemical manufacturing are frequently initiated in response to safety incidents (spills, exposures, process upsets). Direct linkage enables PSM/RMP compliance tracking and CAPA effectiveness ',
    `supplier_material_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.supplier_material. Business justification: CAPAs are often supplier-material specific — a particular suppliers grade repeatedly fails specification. Linking CAPA to supplier_material enables supplier-specific corrective action tracking, a cor',
    `vendor_audit_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_audit. Business justification: Supplier CAPA Management is a named process in chemical manufacturing: critical vendor audit findings mandate a CAPA. Direct FK enables audit-to-CAPA traceability required by ISO 9001 and GMP supplier',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: GMP CAPA closure requires evidence of completed corrective maintenance actions. In chemical manufacturing, CAPAs for equipment-related deviations generate maintenance work orders (equipment repair, mo',
    `actual_completion_date` DATE COMMENT 'Date when the CAPA action was actually finished.',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes capturing audit trail comments, approvals, or change history.',
    `capa_description` STRING COMMENT 'Detailed narrative of the issue, its impact, and the rationale for the CAPA.',
    `capa_number` STRING COMMENT 'Business-visible CAPA identifier assigned per company naming convention.',
    `capa_status` STRING COMMENT 'Current lifecycle state of the CAPA record.. Valid values are `open|in_progress|closed|cancelled`',
    `capa_type` STRING COMMENT 'Indicates whether the action addresses an existing issue (corrective) or aims to prevent future occurrence (preventive).. Valid values are `corrective|preventive`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date‑time when the CAPA status was set to closed.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective steps to be taken.',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual financial cost incurred after CAPA implementation.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Projected financial cost to implement the corrective or preventive action.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the CAPA record was first created in the system.',
    `department` STRING COMMENT 'Business department owning the CAPA.. Valid values are `quality|production|r&d|safety|maintenance`',
    `documentation_reference` STRING COMMENT 'Reference to supporting documents, SOPs, or work instructions (e.g., document number or URL).',
    `effectiveness_outcome` STRING COMMENT 'Result of the effectiveness verification.. Valid values are `effective|partially_effective|ineffective`',
    `effectiveness_verification_date` DATE COMMENT 'Date on which the effectiveness of the CAPA was evaluated.',
    `gmp_compliance` BOOLEAN COMMENT 'Indicates whether the CAPA satisfies Good Manufacturing Practice requirements.',
    `location` STRING COMMENT 'Site or plant where the CAPA originated.',
    `preventive_action_description` STRING COMMENT 'Detailed description of the preventive measures to avoid recurrence.',
    `priority` STRING COMMENT 'Priority assigned to the CAPA for scheduling and resource allocation.. Valid values are `high|medium|low`',
    `rci_method` STRING COMMENT 'Methodology used to determine the root cause.. Valid values are `5_why|fishbone|fmea|pareto|kaizen`',
    `regulatory_reference` STRING COMMENT 'Identifier of the regulatory requirement or standard (e.g., ISO 9001 clause, FDA CFR) that the CAPA addresses.',
    `root_cause` STRING COMMENT 'Comprehensive description of the underlying cause identified for the non‑conformance.',
    `root_cause_category` STRING COMMENT 'High‑level classification of the root cause.. Valid values are `process|equipment|material|human|method|environment`',
    `severity` STRING COMMENT 'Severity rating of the issue prompting the CAPA.. Valid values are `critical|high|medium|low`',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective or preventive action should be completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the CAPA record.',
    `verification_method` STRING COMMENT 'Method used to verify that the CAPA is effective.. Valid values are `audit|test|inspection|review`',
    `verification_result` STRING COMMENT 'Outcome of the verification activity.. Valid values are `pass|fail|conditional`',
    CONSTRAINT pk_capa PRIMARY KEY(`capa_id`)
) COMMENT 'Corrective and Preventive Action (CAPA) record managing the full lifecycle of quality improvement actions triggered by OOS events, quality notifications, audit findings, or customer complaints. Captures CAPA number, CAPA type (corrective, preventive), root cause description, RCI method (5-Why, Fishbone, FMEA), proposed actions, responsible owner, target completion date, actual completion date, effectiveness verification date, effectiveness outcome, and GMP compliance status. Central to ISO 9001 and GMP compliance.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`coc_record` (
    `coc_record_id` BIGINT COMMENT 'System‑generated surrogate primary key for the certificate record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer receiving the certificate.',
    `coa_template_id` BIGINT COMMENT 'Foreign key linking to quality.coa_template. Business justification: A COC/COA record is generated using a specific COA template that defines the format, layout, and regulatory content of the certificate. coc_record has no coa_template_id FK currently. Adding this FK l',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: CoC records must certify grade compliance (e.g., This product meets USP grade specifications). Grade is a mandatory field on CoC documents for pharmaceutical and food-grade chemicals, required for c',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A Certificate of Conformance/Analysis (COC/COA) is generated for a specific inspection lot after quality release. coc_record has batch_number and lot_number as STRING attributes but no FK to the inspe',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to product.line_item. Business justification: CoC records in chemical manufacturing are issued per shipment line item (specific quantity of a specific product on a specific order). Line-item-level CoC traceability is required for customer receivi',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Certificates of Conformance are issued for specific inventory lots in chemical manufacturing. lot_number on coc_record is a denormalized text field. Direct FK enables automated CoC generation from lot',
    `order_id` BIGINT COMMENT 'Sales order identifier associated with the batch.',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: A COC/COA certifies that a product batch meets a specific quality specification. coc_record currently stores specification_reference as a STRING but has no FK to the quality_specification master. Addi',
    `safety_data_sheet_id` BIGINT COMMENT 'Reference to the SDS document for the product.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: In chemical manufacturing, a Certificate of Conformance is issued per shipment and must accompany the delivery. Linking coc_record directly to shipment enables shipment release validation, customer do',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Certificate of Conformance records in chemical manufacturing are issued for specific SKUs (the actual packaged unit shipped). Customer receiving, regulatory submission, and traceability audits all req',
    `usage_decision_id` BIGINT COMMENT 'Foreign key linking to quality.usage_decision. Business justification: A COC/COA is issued upon quality release, which is formally captured in a usage decision record. Adding usage_decision_id to coc_record links the certificate to the specific release decision that auth',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the certificate was approved for release.',
    `archive_timestamp` TIMESTAMP COMMENT 'Timestamp when the certificate was moved to archive.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number to which the certificate applies.',
    `batch_quantity` DECIMAL(18,2) COMMENT 'Quantity of product produced in the batch.',
    `certificate_number` STRING COMMENT 'Unique business‑assigned identifier for the certificate.',
    `certificate_type` STRING COMMENT 'Indicates whether the document is a Certificate of Analysis (COA) or Certificate of Compliance (COC).. Valid values are `COA|COC`',
    `coc_record_status` STRING COMMENT 'Current lifecycle status of the certificate.. Valid values are `draft|released|revoked|expired|under_review`',
    `compliance_statement` STRING COMMENT 'Textual statement affirming compliance with applicable specifications and regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certificate record was first created in the system.',
    `distribution_list` STRING COMMENT 'Comma‑separated list of internal or external recipients of the certificate.',
    `document_url` STRING COMMENT 'Link to the stored PDF or electronic version of the certificate.',
    `expiry_date` DATE COMMENT 'Date after which the product is no longer considered fit for use.',
    `failed_test_count` STRING COMMENT 'Number of tests that did not meet specification limits.',
    `hazard_class` STRING COMMENT 'GHS hazard class of the product.. Valid values are `explosive|flammable|corrosive|toxic|oxidizer|non_hazardous`',
    `is_archived` BOOLEAN COMMENT 'Indicates whether the certificate record has been archived.',
    `is_confidential` BOOLEAN COMMENT 'Indicates if the certificate contains confidential information.',
    `is_customer_specific` BOOLEAN COMMENT 'Indicates whether the certificate includes customer‑specific requirements or format.',
    `issue_date` DATE COMMENT 'Date the certificate was issued to the customer or internal stakeholder.',
    `manufacturing_date` DATE COMMENT 'Date the batch was produced.',
    `notes` STRING COMMENT 'Free‑form field for any extra remarks or observations.',
    `overall_result` STRING COMMENT 'Overall pass/fail outcome of the certificate based on specifications.. Valid values are `pass|fail`',
    `passed_test_count` STRING COMMENT 'Number of tests that met specification limits.',
    `product_code` STRING COMMENT 'Internal code identifying the chemical product or grade.',
    `product_name` STRING COMMENT 'Descriptive name of the chemical product.',
    `qa_signatory_name` STRING COMMENT 'Name of the Quality Assurance person who approved the certificate.',
    `regulatory_compliance_codes` STRING COMMENT 'Pipe‑separated list of regulatory codes (e.g., REACH, TSCA) applicable to the batch.',
    `released_timestamp` TIMESTAMP COMMENT 'Timestamp when the certificate status changed to released.',
    `revision_reason` STRING COMMENT 'Reason for re‑issuing or revising the certificate.',
    `total_test_count` STRING COMMENT 'Number of analytical tests performed for this batch.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for batch quantity.. Valid values are `kg|g|lb|L|mL|ton`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the certificate record.',
    `version_number` STRING COMMENT 'Version identifier for the certificate document, incremented on re‑issue.',
    CONSTRAINT pk_coc_record PRIMARY KEY(`coc_record_id`)
) COMMENT 'Quality certificate master record (COA or COC) generated for a product batch upon quality release. Supports Certificate of Analysis (COA) listing individual test parameters with specification limits and actual measured values, and Certificate of Compliance (COC) attesting overall conformance to specifications without detailed test data. Captures certificate number, certificate type (COA/COC), batch/lot number, product code/grade, manufacturing and expiry dates, test results summary, applicable specification reference, compliance statement, release status, QA signatory, customer-specific variant flag, issue date, document version, and distribution history. Serves as the single authoritative source for all outbound quality certificates supporting customer order fulfillment, regulatory submissions, and audit requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` (
    `quality_hold_id` BIGINT COMMENT 'System-generated unique identifier for the quality hold record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Associates holds with the specific product, supporting inventory control and compliance hold reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Holding cost allocation: material hold incurs storage and opportunity costs charged to the owning cost center.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A quality hold is frequently triggered by a failed or pending inspection lot. quality_hold currently references quality_deviation but has no direct FK to the inspection_lot that triggered the hold. Ad',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Quality holds in chemical manufacturing incur holding costs (extended storage, retesting, potential disposal of held quantity). Internal orders capture these costs for financial reporting. quantity_he',
    `inventory_target_id` BIGINT COMMENT 'Foreign key linking to planning.inventory_target. Business justification: Inventory target calculations consider active quality holds to adjust safety stock and reorder points, requiring a direct link.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Finance must block or flag invoices for batches under quality hold, ensuring no payment is collected before release.',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to product.line_item. Business justification: Quality holds in chemical manufacturing are placed on specific order line items (a particular SKU quantity on a specific order). Line-item-level hold tracking is required for order management, custome',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Quality holds block usage of a specific lot; FK to inventory lot enables automated quarantine handling.',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Quality holds are placed on specific raw material lots pending investigation. Direct lot_record linkage enables lot-level quarantine management and regulatory reporting on held raw material inventory ',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Quality hold is applied to a manufacturing order; linking supports hold/release workflow and regulatory reporting.',
    `material_master_id` BIGINT COMMENT 'Internal identifier of the material subject to the hold.',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Quality hold linked to a sales order enables the Order Hold Management workflow to prevent shipping non‑conforming goods.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: Quality holds placed on batches must be traced to the specific production schedule run to assess schedule impact and trigger rescheduling. Chemical manufacturing planners require this link to determin',
    `quality_deviation_id` BIGINT COMMENT 'Link to the quality notification (e.g., OOS, OOT) that generated the hold.',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: A quality hold is placed when material fails to meet a quality specification. Adding quality_specification_id to quality_hold links the hold to the specific specification that was violated or is under',
    `safety_incident_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_incident. Business justification: Regulatory traceability: when a quality hold is placed due to a safety incident, the hold must reference the incident for compliance reporting.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Hold Management process tracks shipments placed on hold due to quality issues, linking hold records to the affected shipment.',
    `usage_decision_id` BIGINT COMMENT 'Foreign key linking to quality.usage_decision. Business justification: A quality hold is released based on a usage decision. Adding usage_decision_id to quality_hold links the hold record to the formal release decision that authorized lifting the hold. This is essential ',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: Quality holds specify where held material must be physically stored (quarantine zone, segregated area). storage_location on quality_hold is a denormalized text field. FK to warehouse_location enables ',
    `waste_disposal_record_id` BIGINT COMMENT 'Foreign key linking to ehs.waste_disposal_record. Business justification: Held chemical inventory condemned after quality hold must be disposed of as hazardous waste under RCRA. Linking quality_hold to waste_disposal_record ensures condemned material is properly manifested ',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Quality holds are often held until a maintenance work order is completed; linking coordinates release decisions with maintenance schedules.',
    `actual_release_date` DATE COMMENT 'Date the hold was actually released; null if still active.',
    `batch_number` STRING COMMENT 'Batch identifier of the material under hold.',
    `comments` STRING COMMENT 'Additional free‑text notes entered by users regarding the hold.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hold record was first created in the system.',
    `ehs_incident_reference` STRING COMMENT 'Identifier of an associated environmental, health, or safety incident, if applicable.',
    `expected_release_date` DATE COMMENT 'Planned date for releasing the hold, based on investigation or process schedule.',
    `hold_date` DATE COMMENT 'Calendar date on which the hold was placed.',
    `hold_number` STRING COMMENT 'External business identifier assigned to the hold, used in operational communications and reports.',
    `hold_type` STRING COMMENT 'Classification of the hold based on where the material is in the value chain.. Valid values are `incoming|in_process|finished_goods|customer_return|internal_transfer`',
    `quality_hold_status` STRING COMMENT 'Current lifecycle status of the hold record.. Valid values are `active|closed|cancelled`',
    `quantity_held` DECIMAL(18,2) COMMENT 'Amount of material placed on hold, expressed in the unit of measure.',
    `reason_code` STRING COMMENT 'Standardized code indicating why the material was placed on hold.. Valid values are `quality_issue|regulatory|safety|customer_complaint|inventory_adjustment`',
    `reason_description` STRING COMMENT 'Free‑text explanation of the hold reason providing additional context.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the hold is required for regulatory compliance (true) or internal quality control (false).',
    `release_outcome` STRING COMMENT 'Result of the hold disposition after investigation.. Valid values are `released|rejected|reprocessed|scrapped`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the held quantity (e.g., kilograms, liters).. Valid values are `kg|l|g|ml|pcs`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the hold record.',
    CONSTRAINT pk_quality_hold PRIMARY KEY(`quality_hold_id`)
) COMMENT 'Quality hold record placing a material batch, lot, or inventory quantity under restricted status pending quality investigation or disposition. Captures hold number, hold type (incoming, in-process, finished goods, customer return), affected material, batch/lot, quantity, storage location, hold reason, hold initiator, hold date, expected release date, actual release date, release authority, and hold outcome (released, rejected, reprocessed, scrapped). Integrates with SAP QM blocked stock and EWM.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`spc_control` (
    `spc_control_id` BIGINT COMMENT 'Primary key for spc_control',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: SPC control charts in chemical manufacturing are maintained for specific chemical products to monitor process capability. Product-level SPC tracking is required for process validation, FDA/regulatory ',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to ehs.emission_source. Business justification: SPC control charts monitoring process parameters at emission sources enable real-time detection of process upsets causing permit exceedances. Linking SPC charts to emission sources supports continuous',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: SPC control charts in chemical manufacturing are defined per equipment unit (e.g., reactor R-101 viscosity chart, extruder E-201 melt index chart). Linking spc_control to equipment enables equipment-l',
    `inspection_characteristic_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_characteristic. Business justification: An SPC control chart is configured to monitor a specific quality characteristic. spc_control currently stores characteristic_code and characteristic_name as denormalized STRING attributes but has no F',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: SPC charts are maintained for raw material incoming quality parameters (e.g., tracking assay % trends for a specific material over time). Material-level process capability analysis for incoming raw ma',
    `measurement_point_id` BIGINT COMMENT 'Foreign key linking to maintenance.measurement_point. Business justification: SPC control charts in chemical manufacturing are populated from process historian data sourced at specific equipment measurement points (PI tags, DCS sensors). Linking spc_control to measurement_point',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: SPC control limits are derived from and governed by quality specifications. spc_control has no FK to quality_specification currently. Adding quality_specification_id links the SPC chart configuration ',
    `chart_description` STRING COMMENT 'Free‑text description of the chart purpose, scope, and configuration notes.',
    `chart_status` STRING COMMENT 'Current lifecycle status of the SPC chart.. Valid values are `active|inactive|retired|pending`',
    `chart_type` STRING COMMENT 'Type of control chart used for monitoring the quality characteristic.. Valid values are `xbar_r|xbar_s|i_mr|p_chart|c_chart|u_chart`',
    `control_limit_cl` DECIMAL(18,2) COMMENT 'Target or nominal value for the quality characteristic.',
    `control_limit_lcl` DECIMAL(18,2) COMMENT 'Statistical lower control limit for the chart.',
    `control_limit_ucl` DECIMAL(18,2) COMMENT 'Statistical upper control limit for the chart.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SPC chart record was initially created.',
    `last_recalculation_timestamp` TIMESTAMP COMMENT 'Date‑time when control limits were last recomputed.',
    `notes` STRING COMMENT 'Free‑form notes entered by investigators or operators.',
    `process_step_code` STRING COMMENT 'Unique code for the process step (e.g., STEP_01, REACTOR_A).. Valid values are `^[A-Z0-9_]+$`',
    `process_step_name` STRING COMMENT 'Name of the manufacturing process step where the SPC chart is applied.',
    `sampling_frequency` STRING COMMENT 'How often samples are collected for the SPC chart.. Valid values are `hourly|daily|per_shift|per_batch`',
    `source_system` STRING COMMENT 'System of record that supplied the violation data.. Valid values are `LabWare LIMS|Aveva PI|SAP QM`',
    `subgroup_size` STRING COMMENT 'Number of consecutive samples grouped for each SPC calculation.',
    `trend_analysis_flag` BOOLEAN COMMENT 'Indicates whether the violation contributed to a longer‑term trend analysis.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the characteristic values (e.g., °C, kg, ppm).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SPC chart record.',
    `warning_limit_lcl` DECIMAL(18,2) COMMENT 'Threshold that triggers a warning before reaching the LCL.',
    `warning_limit_ucl` DECIMAL(18,2) COMMENT 'Threshold that triggers a warning before reaching the UCL.',
    CONSTRAINT pk_spc_control PRIMARY KEY(`spc_control_id`)
) COMMENT 'Statistical Process Control (SPC) chart configuration, control limits, and violation event management for monitored quality characteristics at specific process steps or production units. Captures chart type (X-bar R, X-bar S, I-MR, p-chart, c-chart, u-chart), characteristic reference, process step, control limits (UCL, LCL, CL), warning limits, subgroup size, sampling frequency, chart status, last recalculation date. Includes all violation event records: rule violations (Western Electric / Nelson rules 1-8), violation type, measured value, control limit breached, detection timestamp, operator notification, investigation required flag, disposition (false alarm, assignable cause identified, process adjusted), and trend analysis. Single source of truth for both SPC chart configuration and all control chart violation events. Drives real-time SPC monitoring via LabWare LIMS and Aveva PI integration, feeding quality deviation creation for out-of-control conditions.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` (
    `quality_specification_id` BIGINT COMMENT 'Unique identifier for the quality specification record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Quality specifications in chemical manufacturing are defined at the chemical product level and govern all downstream inspection, CoA, and regulatory compliance activities. A domain expert would expect',
    `coa_template_id` BIGINT COMMENT 'Identifier of the COA template used for reporting against this specification.',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Quality specifications are grade-specific in chemical manufacturing — USP, ACS, FCC, EP grades each have distinct specification limits. The grade determines which quality_specification applies for bat',
    `hazmat_storage_rule_id` BIGINT COMMENT 'Foreign key linking to inventory.hazmat_storage_rule. Business justification: Quality specifications for hazardous chemicals must reference applicable hazmat storage rules (OSHA, EPA, GHS compliance). In chemical manufacturing, the quality spec defines the chemicals hazard pro',
    `material_master_id` BIGINT COMMENT 'FK to rawmaterial.material_master',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Quality specifications are derived from raw material specifications. Linking them enables specification change management — when material_specification is updated, the corresponding quality_specificat',
    `process_safety_info_id` BIGINT COMMENT 'Foreign key linking to ehs.process_safety_info. Business justification: Quality specifications for PSM-covered chemicals must reference process safety information to ensure specification limits (LSL/USL) are consistent with safe operating limits. EPA RMP and OSHA PSM requ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Customer-specific or packaging-specific quality specifications (e.g., different fill tolerance for drum vs. IBC) are tied to specific SKUs. This drives customer CoA generation and order-specific compl',
    `applicable_process` STRING COMMENT 'Manufacturing process type (e.g., batch, continuous) to which the specification applies.',
    `applicable_region` STRING COMMENT 'Geographic region(s) where the specification is valid (e.g., NA, EU).',
    `approval_date` DATE COMMENT 'Date the specification was formally approved.',
    `approving_authority` STRING COMMENT 'Name or identifier of the person/role that approved the specification.',
    `change_control_number` STRING COMMENT 'Identifier linking the specification change to the change‑control system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level indicating data sensitivity and handling requirements.. Valid values are `public|internal|confidential|restricted`',
    `default_batch_size` DECIMAL(18,2) COMMENT 'Typical batch size for production runs governed by this specification.',
    `effective_date` DATE COMMENT 'Date on which the specification becomes effective.',
    `expiry_date` DATE COMMENT 'Date after which the specification is no longer valid (nullable if open‑ended).',
    `is_ghs_compliant` BOOLEAN COMMENT 'Indicates compliance with the Globally Harmonized System of Classification and Labelling.',
    `is_gmp_compliant` BOOLEAN COMMENT 'Indicates whether the specification meets Good Manufacturing Practice requirements.',
    `is_iso9001_compliant` BOOLEAN COMMENT 'Indicates compliance with ISO 9001 quality management standards.',
    `is_reach_compliant` BOOLEAN COMMENT 'Indicates compliance with REACH regulatory requirements.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the specification.',
    `lsl_value` DECIMAL(18,2) COMMENT 'Numeric lower bound for the specification parameter.',
    `next_review_date` DATE COMMENT 'Planned date for the next scheduled review of the specification.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `owner_department` STRING COMMENT 'Business department responsible for maintaining the specification.',
    `quality_specification_description` STRING COMMENT 'Free‑form description of the specification purpose and scope.',
    `quality_specification_status` STRING COMMENT 'Current lifecycle status of the specification.. Valid values are `draft|active|retired|superseded|pending`',
    `regulatory_standard` STRING COMMENT 'Applicable regulatory or industry standard governing the specification.. Valid values are `ISO|ASTM|EP|USP|GHS|REACH`',
    `revision_reason` STRING COMMENT 'Reason documented for the latest revision of the specification.',
    `sds_reference` STRING COMMENT 'Reference (ID or URL) to the associated Safety Data Sheet.',
    `specification_category` STRING COMMENT 'Broad category indicating whether the spec applies to raw material, intermediate, or finished product.. Valid values are `raw_material|intermediate|finished_product`',
    `specification_number` STRING COMMENT 'Business identifier assigned to the specification, used for external reference.',
    `specification_type` STRING COMMENT 'Classification of the specification source: internal, customer‑provided, regulatory, or pharmacopoeia.. Valid values are `internal|customer|regulatory|pharmacopoeia`',
    `target_value` DECIMAL(18,2) COMMENT 'Target or nominal value for the specification parameter.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for numeric specification limits (e.g., kg, ppm, pH).',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the specification record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the specification record.',
    `usl_value` DECIMAL(18,2) COMMENT 'Numeric upper bound for the specification parameter.',
    `version` STRING COMMENT 'Version identifier of the specification, incremented on each change.',
    `created_by` STRING COMMENT 'User identifier of the person who created the specification record.',
    CONSTRAINT pk_quality_specification PRIMARY KEY(`quality_specification_id`)
) COMMENT 'Master quality specification record defining the approved limits, grades, and acceptance criteria for a finished product, intermediate, or raw material. Captures specification number, specification version, material/product code, grade, specification type (internal, customer, regulatory, pharmacopoeia), parameter list with LSL/USL/target values, effective date, expiry date, approval status, approving authority, and applicable regulatory standard (ISO, ASTM, EP, USP). Serves as the authoritative specification against which COA results are evaluated.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` (
    `lab_sample_id` BIGINT COMMENT 'System-generated unique identifier for the laboratory sample record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lab samples in chemical manufacturing incur direct costs (reagents, analyst time, equipment). Cost center linkage enables lab cost management and allocation reporting. Without this link, lab operation',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Lab samples are taken from specific equipment; linking provides traceability and supports equipment cleaning schedules.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Lab samples drawn from incoming chemical shipments must be traceable to the specific goods receipt event for chain-of-custody documentation, a GMP and ISO 17025 requirement. Enables sample-to-receipt ',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Lab samples must reference the grade being tested to apply correct acceptance criteria and generate grade-appropriate CoA. Grade-specific sampling and testing is a standard GMP requirement in chemical',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A lab sample is physically drawn as part of an inspection lot event. One inspection lot can have many lab samples drawn from it. Adding inspection_lot_id to lab_sample establishes the parent-child tra',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to order.line_item. Business justification: Lab sample linked to order line provides traceability for the Sample Tracking report required by regulatory bodies.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Lab samples are drawn from specific inventory lots in chemical manufacturing. FDA 21 CFR Part 211 and GMP require full traceability from sample result back to the source lot. This FK enables sample-to',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Lab samples are drawn from specific raw material lots for incoming inspection or stability testing. GMP chain-of-custody requirements mandate that every lab sample be traceable to its source lot — a s',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Lab samples are associated with a specific raw material for sample scheduling, analytical method assignment, and material-level sample history reporting. Every chemical manufacturing QC system links s',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: In specialty chemical sales, customer trial samples are dispatched against specific quote lines. Linking lab_sample to quote_line enables sample-to-order conversion tracking, supports technical sales ',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: Lab samples of chemical products require SDS reference for safe handling, storage conditions, and disposal per OSHA HazCom and GLP standards. Chemical manufacturing labs must have SDS available for al',
    `sampling_plan_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_plan. Business justification: A lab sample is drawn according to a sampling plan that governs sample size, frequency, and method. Adding sampling_plan_id to lab_sample links each physical sample to the statistical sampling plan th',
    `shipment_line_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment_line. Business justification: Outbound Shipment Sampling requires linking each lab sample to the specific shipment line from which the sample was taken.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Lab samples in chemical manufacturing are drawn from specific SKUs (packaged units). Sample traceability to SKU is required for CoA generation, stability studies, and regulatory submissions. No existi',
    `storage_bin_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_bin. Business justification: GMP regulations require physical traceability of retained lab samples to their storage location. lab_sample has storage_condition and temperature attributes but no location FK. Linking to storage_bin ',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to ehs.waste_stream. Business justification: Lab samples generate chemical waste classified and disposed of per specific waste streams. RCRA compliance and waste minimization reporting in chemical manufacturing labs require sample disposal to be',
    `chain_of_custody_status` STRING COMMENT 'Status of the chain‑of‑custody tracking for the sample.. Valid values are `in_progress|completed|broken`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample record was first created in the data lake.',
    `disposal_date` DATE COMMENT 'Date the sample was disposed of, if applicable.',
    `lab_sample_status` STRING COMMENT 'Current state of the sample in the testing workflow.. Valid values are `received|in_testing|tested|disposed|on_hold|rejected`',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the sample.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of material taken for the sample.',
    `sample_code` STRING COMMENT 'External business identifier assigned to the sample (e.g., barcode or alphanumeric code).',
    `sample_name` STRING COMMENT 'Human‑readable label or description of the sample.',
    `sample_type` STRING COMMENT 'Classification of how the sample was obtained.. Valid values are `composite|grab|retention|split|other`',
    `sampling_point` STRING COMMENT 'Location or process stream where the sample was taken.',
    `sampling_timestamp` TIMESTAMP COMMENT 'Date and time when the sample was collected.',
    `storage_condition` STRING COMMENT 'General condition of storage (e.g., refrigerated, frozen).. Valid values are `refrigerated|frozen|ambient|controlled|dry|other`',
    `storage_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity of the storage environment, expressed as a percentage.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the sample is stored, expressed in degrees Celsius.',
    `unit_of_measure` STRING COMMENT 'Unit associated with the sample quantity.. Valid values are `kg|g|ml|l|pcs|other`',
    `updated_by` STRING COMMENT 'User identifier who last modified the sample record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sample record.',
    `created_by` STRING COMMENT 'User identifier who created the sample record.',
    CONSTRAINT pk_lab_sample PRIMARY KEY(`lab_sample_id`)
) COMMENT 'Physical laboratory sample record tracking a sample drawn from a batch, process stream, or incoming material for quality testing. Captures sample number, sample type (composite, grab, retention), sampling point, sampled quantity, sample container type, sampling date/time, sampler ID, chain of custody status, storage condition (temperature, humidity), sample status (received, in-testing, tested, disposed), disposal date, and LabWare LIMS sample ID. Provides full chain of custody for GMP and regulatory audit purposes.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`coa_template` (
    `coa_template_id` BIGINT COMMENT 'Primary key for coa_template',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: CoA templates in chemical manufacturing are designed for specific chemical products or product families. Linking coa_template to chemical_product enables product-specific CoA generation, regulatory co',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: CoA templates are grade-specific in chemical manufacturing — a USP grade CoA template includes different parameters and certification statements than a technical grade template. Grade-specific CoA tem',
    `superseded_coa_template_id` BIGINT COMMENT 'Self-referencing FK on coa_template (superseded_coa_template_id)',
    `applicable_product_line` STRING COMMENT 'Product line or family to which the template applies.',
    `approval_date` TIMESTAMP COMMENT 'Timestamp when the template was approved.',
    `approval_status` STRING COMMENT 'Current approval status of the template.',
    `approved_by` STRING COMMENT 'Name of the person who approved the template.',
    `author_name` STRING COMMENT 'Name of the employee who authored the template.',
    `change_control_number` STRING COMMENT 'Identifier of the change control request associated with the latest version.',
    `coa_template_status` STRING COMMENT 'Current lifecycle status of the template.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the template record was first created in the system.',
    `department_name` STRING COMMENT 'Organizational department responsible for the template.',
    `effective_from` DATE COMMENT 'Date from which the template is considered valid for use.',
    `effective_until` DATE COMMENT 'Date after which the template should no longer be used (nullable for indefinite).',
    `file_format` STRING COMMENT 'File format in which the template is stored.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the template contains confidential information.',
    `language` STRING COMMENT 'Language of the template content.',
    `notes` STRING COMMENT 'Free‑text field for additional remarks or special handling instructions.',
    `regulatory_standard` STRING COMMENT 'Regulatory framework that the template complies with.',
    `retention_period_days` STRING COMMENT 'Number of days the template must be retained according to policy.',
    `template_code` STRING COMMENT 'Unique code used to reference the COA template across systems.',
    `template_name` STRING COMMENT 'Human‑readable name of the certificate of analysis template.',
    `template_type` STRING COMMENT 'Category of the template indicating what kind of item the COA applies to.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the template record.',
    `version_number` STRING COMMENT 'Version identifier of the template.',
    CONSTRAINT pk_coa_template PRIMARY KEY(`coa_template_id`)
) COMMENT 'Master reference table for coa_template. Referenced by coa_template_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` (
    `plan_characteristic_assignment_id` BIGINT COMMENT 'Unique surrogate key for the plan-characteristic assignment record',
    `inspection_characteristic_id` BIGINT COMMENT 'Foreign key linking to the characteristic master definition being assigned to the plan',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to the inspection plan that contains this characteristic',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this characteristic assignment within the plan',
    `characteristic_weight` DECIMAL(18,2) COMMENT 'Relative importance or weighting of this characteristic within the plan, used for scoring or prioritization',
    `control_limit_override` DECIMAL(18,2) COMMENT 'Plan-specific control limit that overrides the standard control limits defined in the characteristic master',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this characteristic was assigned to the plan',
    `effective_from` DATE COMMENT 'Date from which this characteristic assignment is valid within the plan',
    `effective_until` DATE COMMENT 'Date when this characteristic assignment expires or is removed from the plan',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this characteristic must be inspected for the plan to be considered complete',
    `sampling_size_override` STRING COMMENT 'Plan-specific sample size that overrides the default sampling size defined in the characteristic master',
    `sequence_number` STRING COMMENT 'Order in which this characteristic appears within the inspection plan, controlling presentation and execution sequence',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this assignment record',
    CONSTRAINT pk_plan_characteristic_assignment PRIMARY KEY(`plan_characteristic_assignment_id`)
) COMMENT 'This association product represents the assignment of a quality characteristic to an inspection plan in SAP QM. It captures the operational configuration that determines which characteristics must be inspected when a plan is executed, including sequence, mandatory status, and plan-specific overrides to the characteristic master definition. Each record links one inspection plan to one inspection characteristic with attributes that exist only in the context of this assignment.. Existence Justification: In SAP QM and chemical manufacturing quality systems, inspection plans are reusable templates that define which characteristics must be measured, and characteristics are master definitions reused across multiple plans (e.g., Assay by HPLC appears in every API product plan). The assignment of a characteristic to a plan is an operational configuration managed by quality engineers, carrying plan-specific data like sequence, mandatory flag, and overrides to the characteristic master definition.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_inspection_characteristic_id` FOREIGN KEY (`inspection_characteristic_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_characteristic`(`inspection_characteristic_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_spc_control_id` FOREIGN KEY (`spc_control_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`spc_control`(`spc_control_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`test_method`(`test_method_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ADD CONSTRAINT `fk_quality_inspection_characteristic_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ADD CONSTRAINT `fk_quality_inspection_characteristic_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`test_method`(`test_method_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`test_method`(`test_method_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_capa_related_quality_notification_quality_notification_quality_deviation_id` FOREIGN KEY (`capa_related_quality_notification_quality_notification_quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_coa_template_id` FOREIGN KEY (`coa_template_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`coa_template`(`coa_template_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ADD CONSTRAINT `fk_quality_coc_record_usage_decision_id` FOREIGN KEY (`usage_decision_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`usage_decision`(`usage_decision_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_usage_decision_id` FOREIGN KEY (`usage_decision_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`usage_decision`(`usage_decision_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ADD CONSTRAINT `fk_quality_spc_control_inspection_characteristic_id` FOREIGN KEY (`inspection_characteristic_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_characteristic`(`inspection_characteristic_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ADD CONSTRAINT `fk_quality_spc_control_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ADD CONSTRAINT `fk_quality_quality_specification_coa_template_id` FOREIGN KEY (`coa_template_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`coa_template`(`coa_template_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ADD CONSTRAINT `fk_quality_coa_template_superseded_coa_template_id` FOREIGN KEY (`superseded_coa_template_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`coa_template`(`coa_template_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ADD CONSTRAINT `fk_quality_plan_characteristic_assignment_inspection_characteristic_id` FOREIGN KEY (`inspection_characteristic_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_characteristic`(`inspection_characteristic_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ADD CONSTRAINT `fk_quality_plan_characteristic_assignment_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `chemical_mfg_ecm`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `coa_document_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Product Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `supplier_material_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `coa_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `disposition_by` SET TAGS ('dbx_business_glossary_term' = 'Disposition By User');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Disposition Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'accept|rework|scrap|return|quarantine');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `gmp_compliant` SET TAGS ('dbx_business_glossary_term' = 'GMP Compliant Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_status` SET TAGS ('dbx_value_regex' = 'created|sample_drawn|results_recorded|decision_made|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_reason` SET TAGS ('dbx_business_glossary_term' = 'Inspection Reason');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_reason` SET TAGS ('dbx_value_regex' = 'incoming|in_process|outgoing|periodic|complaint');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_source` SET TAGS ('dbx_business_glossary_term' = 'Inspection Source');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_source` SET TAGS ('dbx_value_regex' = 'lab|field|automated');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_version` SET TAGS ('dbx_business_glossary_term' = 'Inspection Version');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'goods_receipt|production|periodic|customer_return');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `measurement_uom` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Specification Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `oot_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Trend Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `pass_fail_flag` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `quantity_inspected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Inspected');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sample_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sample_uom` SET TAGS ('dbx_business_glossary_term' = 'Sample Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sample_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|L|gal|pcs|mol');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'kg|lb|L|gal|pcs|mol');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `qc_result_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Result ID (QC_RESULT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `inspection_characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Identifier (LOT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Control Sample Identifier (CTRL_SAMPLE_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Identifier (QN_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `spc_control_id` SET TAGS ('dbx_business_glossary_term' = 'SPC Chart Identifier (SPC_CHART_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Comment (COMMENT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reference (COMP_REF)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System (SRC_SYS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'LabWare LIMS|SAP QM');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `deviation_amount` SET TAGS ('dbx_business_glossary_term' = 'Deviation Amount (DEV_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `deviation_percent` SET TAGS ('dbx_business_glossary_term' = 'Deviation Percent (DEV_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity Percent (RH_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `is_control_sample` SET TAGS ('dbx_business_glossary_term' = 'Control Sample Flag (CTRL_FLG)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `material_cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service Number (CAS_NO)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `material_cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `measurement_sequence` SET TAGS ('dbx_business_glossary_term' = 'Measurement Sequence (MEAS_SEQ)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type (MEAS_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'quantitative|qualitative');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Pressure (kPa) (PRESS_KPA)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `raw_data_reference` SET TAGS ('dbx_business_glossary_term' = 'Raw Data Reference (RAW_DATA_REF)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status (RESULT_STS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'pass|fail|oos|oot|pending');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value (RESULT_VAL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `retest_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Flag (RETEST_FLG)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `spc_flag` SET TAGS ('dbx_business_glossary_term' = 'SPC Inclusion Flag (SPC_FLG)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (°C) (TEMP_C)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp (TEST_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'mg/L|ppm|%|pH|°C');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Method Accuracy (Percent)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `applicable_product_family` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Family');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'HPLC|GC|ICP-MS|UV-Vis|FTIR|NMR');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `is_gmp_compliant` SET TAGS ('dbx_business_glossary_term' = 'GMP Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `is_iso17025_compliant` SET TAGS ('dbx_business_glossary_term' = 'ISO/IEC 17025 Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `method_code` SET TAGS ('dbx_business_glossary_term' = 'Test Method Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `method_name` SET TAGS ('dbx_business_glossary_term' = 'Test Method Name');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `method_type` SET TAGS ('dbx_business_glossary_term' = 'Test Method Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `method_type` SET TAGS ('dbx_value_regex' = 'titration|chromatography|spectroscopy|gravimetric|microbiological|other');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `precision_percent` SET TAGS ('dbx_business_glossary_term' = 'Method Precision (Percent)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `safety_considerations` SET TAGS ('dbx_business_glossary_term' = 'Safety Considerations');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `sample_preparation_steps` SET TAGS ('dbx_business_glossary_term' = 'Sample Preparation Steps');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Stock Quantity');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `test_method_status` SET TAGS ('dbx_business_glossary_term' = 'Method Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `test_method_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|draft|retired');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `validation_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `inspection_characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Code (ICC)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `characteristic_type` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `characteristic_type` SET TAGS ('dbx_value_regex' = 'quantitative|qualitative|attribute');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP_QM|LabWare_LIMS|Custom');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `decimal_precision` SET TAGS ('dbx_business_glossary_term' = 'Decimal Precision');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `default_sampling_size` SET TAGS ('dbx_business_glossary_term' = 'Default Sampling Size');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `gmp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'GMP Critical Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `inspection_characteristic_description` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `inspection_characteristic_name` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Name');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `inspection_characteristic_status` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `inspection_characteristic_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `measurement_category` SET TAGS ('dbx_business_glossary_term' = 'Measurement Category');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `measurement_category` SET TAGS ('dbx_value_regex' = 'physical|chemical|biological|microbial');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `owner_department` SET TAGS ('dbx_value_regex' = 'quality|production|research|safety');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_value_regex' = 'EPA|OSHA|REACH|GHS|ISO9001|ISO14001');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Days)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `sampling_procedure` SET TAGS ('dbx_business_glossary_term' = 'Sampling Procedure');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `sampling_procedure` SET TAGS ('dbx_value_regex' = 'random|systematic|stratified|batch|continuous');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `test_method_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `acceptance_number` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Number (AN)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `aql` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Level (AQL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation (CR)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'GHS|REACH|TSCA|EPA');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `control_lcl` SET TAGS ('dbx_business_glossary_term' = 'Control Lower Control Limit (LCL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `control_ucl` SET TAGS ('dbx_business_glossary_term' = 'Control Upper Control Limit (UCL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `decimal_precision` SET TAGS ('dbx_business_glossary_term' = 'Decimal Precision (DP)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `dynamic_modification_rules` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Modification Rules (DMR)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `gmp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'GMP Critical Flag (GMP_CF)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_level` SET TAGS ('dbx_business_glossary_term' = 'Inspection Level (IL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_level` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status (PS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage (IS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_value_regex' = 'incoming|in_process|final|rework');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp (LRT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `lot_size_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lot Size (LXS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `lot_size_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size (LMS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Number (IPN)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Type (IPT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'material|product|process');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Version (IPV)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `rejection_number` SET TAGS ('dbx_business_glossary_term' = 'Rejection Number (RN)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status (RS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `spec_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type (ST)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `spec_type` SET TAGS ('dbx_value_regex' = 'absolute|percentage|ratio');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `specification_lsl` SET TAGS ('dbx_business_glossary_term' = 'Specification Lower Specification Limit (LSL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `specification_usl` SET TAGS ('dbx_business_glossary_term' = 'Specification Upper Specification Limit (USL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value (TV)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context (UC)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `usage_context` SET TAGS ('dbx_value_regex' = 'goods_receipt|in_process|final_release');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `acceptance_number` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `applicable_material_class` SET TAGS ('dbx_business_glossary_term' = 'Applicable Material Class');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `applicable_material_class` SET TAGS ('dbx_value_regex' = 'raw_material|intermediate|finished|packaging');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `applicable_process_stage` SET TAGS ('dbx_business_glossary_term' = 'Applicable Process Stage');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `applicable_process_stage` SET TAGS ('dbx_value_regex' = 'procurement|synthesis|blending|packaging|distribution');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `aql_unit` SET TAGS ('dbx_business_glossary_term' = 'AQL Unit');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `aql_value` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Level (AQL) Value');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `dynamic_modification_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Modification Allowed');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `inspection_level` SET TAGS ('dbx_business_glossary_term' = 'Inspection Level');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `inspection_level` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `lot_size_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lot Size');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `lot_size_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Notes');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Name');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'single|double|sequential');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_value_regex' = 'ISO2859|MILSTD1916');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `rejection_number` SET TAGS ('dbx_business_glossary_term' = 'Rejection Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `sample_size_code` SET TAGS ('dbx_business_glossary_term' = 'Sample Size Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_value_regex' = 'per_batch|per_shift|per_day|per_week');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `sampling_method` SET TAGS ('dbx_value_regex' = 'random|stratified|systematic|judgmental');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `sampling_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `sampling_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `sampling_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft|pending');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Product Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `decision_code` SET TAGS ('dbx_business_glossary_term' = 'Decision Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `decision_code` SET TAGS ('dbx_value_regex' = 'accept|reject|conditional_release|reprocess|scrap|return_to_vendor');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `defect_quantity` SET TAGS ('dbx_business_glossary_term' = 'Defect Quantity');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `digital_signature` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `follow_up_action_code` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Action Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `follow_up_action_code` SET TAGS ('dbx_value_regex' = 'none|rework|investigate|capability|audit');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `hold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Hold Quantity');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `is_conditional_release` SET TAGS ('dbx_business_glossary_term' = 'Conditional Release Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'out_of_spec|out_of_trend|process_deviation|customer_complaint');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Release Quantity');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `reprocess_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reprocess Quantity');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_QM|LabWare|Custom');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `stock_posting_instruction` SET TAGS ('dbx_business_glossary_term' = 'Stock Posting Instruction');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `stock_posting_instruction` SET TAGS ('dbx_value_regex' = 'unrestricted|blocked|returns|quarantine');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_status` SET TAGS ('dbx_business_glossary_term' = 'Decision Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_status` SET TAGS ('dbx_value_regex' = 'pending|completed|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` SET TAGS ('dbx_subdomain' = 'deviation_resolution');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `breakdown_event_id` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Event Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `emission_event_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Event Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `notification_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Product Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `supplier_material_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `waste_disposal_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Analysis Method');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `analysis_result` SET TAGS ('dbx_business_glossary_term' = 'Analysis Result');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `analysis_result` SET TAGS ('dbx_value_regex' = 'pass|fail|out_of_spec');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `complaint_source` SET TAGS ('dbx_business_glossary_term' = 'Complaint Source');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `cost_of_quality` SET TAGS ('dbx_business_glossary_term' = 'Cost of Quality');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `customer_complaint_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `customer_complaint_type` SET TAGS ('dbx_value_regex' = 'product|service|delivery|other');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `customer_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Reference');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `customer_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `customer_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `detection_phase` SET TAGS ('dbx_business_glossary_term' = 'Detection Phase');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `detection_phase` SET TAGS ('dbx_value_regex' = 'incoming|in_process|outgoing|customer');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `impact_quantity` SET TAGS ('dbx_business_glossary_term' = 'Impact Quantity');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `impact_unit` SET TAGS ('dbx_business_glossary_term' = 'Impact Unit');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `impact_unit` SET TAGS ('dbx_value_regex' = 'kg|l|pcs|g|ml');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `is_hold` SET TAGS ('dbx_business_glossary_term' = 'Product Hold Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `ncr_disposition` SET TAGS ('dbx_business_glossary_term' = 'NCR Disposition');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `ncr_disposition` SET TAGS ('dbx_value_regex' = 'use_as_is|rework|scrap|return');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'OOS|OOT|NCR|COMPLAINT|DEVIATION|CUSTOMER_COMPLAINT');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `quality_deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `quality_deviation_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `quality_deviation_status` SET TAGS ('dbx_value_regex' = 'open|in_process|resolved|closed|rejected');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_value_regex' = 'production|quality|supply_chain|rd|maintenance|logistics');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment|process|material|human|method|environment');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `root_cause_detail` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Detail');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Notification Subject');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` SET TAGS ('dbx_subdomain' = 'deviation_resolution');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Related OOS Event Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `capa_related_quality_notification_quality_notification_quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Related Quality Notification Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `hazop_study_id` SET TAGS ('dbx_business_glossary_term' = 'Hazop Study Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `incident_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Investigation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `inspection_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Audit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `supplier_material_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `vendor_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Audit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `capa_description` SET TAGS ('dbx_business_glossary_term' = 'CAPA Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'CAPA Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Type (Corrective or Preventive)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `cost_actual` SET TAGS ('dbx_business_glossary_term' = 'CAPA Actual Cost');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'CAPA Cost Estimate');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `department` SET TAGS ('dbx_value_regex' = 'quality|production|r&d|safety|maintenance');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Documentation Reference');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_outcome` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Outcome');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_outcome` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `gmp_compliance` SET TAGS ('dbx_business_glossary_term' = 'GMP Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Plant/Location Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAPA Priority');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `rci_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Investigation Method');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `rci_method` SET TAGS ('dbx_value_regex' = '5_why|fishbone|fmea|pareto|kaizen');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'process|equipment|material|human|method|environment');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'CAPA Severity');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Method');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'audit|test|inspection|review');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` SET TAGS ('dbx_subdomain' = 'certification_standards');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `coc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Record ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CUSTOMER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `coa_template_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Template Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID (ORDER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet ID (SDS_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `archive_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archive Timestamp (ARCHIVE_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch/Lot Number (BATCH_NO)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `batch_quantity` SET TAGS ('dbx_business_glossary_term' = 'Batch Quantity (BATCH_QTY)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number (CERT_NO)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type (CERT_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'COA|COC');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `coc_record_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status (CERT_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `coc_record_status` SET TAGS ('dbx_value_regex' = 'draft|released|revoked|expired|under_review');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `compliance_statement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Statement (COMPLIANCE_STMT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List (DIST_LIST)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL (DOC_URL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (EXP_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `failed_test_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Test Count (FAILED_TESTS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class (HAZ_CLASS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `hazard_class` SET TAGS ('dbx_value_regex' = 'explosive|flammable|corrosive|toxic|oxidizer|non_hazardous');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Archived Flag (ARCHIVED)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag (CONFIDENTIAL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `is_customer_specific` SET TAGS ('dbx_business_glossary_term' = 'Customer Specific Flag (CUSTOMER_SPECIFIC)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date (ISSUE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date (MFG_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Result (OVERALL_RESULT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `passed_test_count` SET TAGS ('dbx_business_glossary_term' = 'Passed Test Count (PASSED_TESTS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code (PROD_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name (PROD_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `qa_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'QA Signatory Name (QA_SIGN_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `regulatory_compliance_codes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Codes (REG_CODES)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp (RELEASED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason (REV_REASON)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `total_test_count` SET TAGS ('dbx_business_glossary_term' = 'Total Test Count (TOTAL_TESTS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|lb|L|mL|ton');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Version (CERT_VER)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` SET TAGS ('dbx_subdomain' = 'deviation_resolution');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `quality_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `inventory_target_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Target Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Ehs Incident Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `waste_disposal_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Hold Comments');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `ehs_incident_reference` SET TAGS ('dbx_business_glossary_term' = 'EHS Incident Reference');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `expected_release_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Release Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `hold_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'incoming|in_process|finished_goods|customer_return|internal_transfer');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `quality_hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `quality_hold_status` SET TAGS ('dbx_value_regex' = 'active|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `quantity_held` SET TAGS ('dbx_business_glossary_term' = 'Quantity Held');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'quality_issue|regulatory|safety|customer_complaint|inventory_adjustment');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `release_outcome` SET TAGS ('dbx_business_glossary_term' = 'Release Outcome');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `release_outcome` SET TAGS ('dbx_value_regex' = 'released|rejected|reprocessed|scrapped');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|l|g|ml|pcs');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` SET TAGS ('dbx_subdomain' = 'certification_standards');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `spc_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `inspection_characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `chart_description` SET TAGS ('dbx_business_glossary_term' = 'SPC Chart Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `chart_status` SET TAGS ('dbx_business_glossary_term' = 'SPC Chart Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `chart_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `chart_type` SET TAGS ('dbx_business_glossary_term' = 'SPC Chart Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `chart_type` SET TAGS ('dbx_value_regex' = 'xbar_r|xbar_s|i_mr|p_chart|c_chart|u_chart');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `control_limit_cl` SET TAGS ('dbx_business_glossary_term' = 'Center Line (CL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `control_limit_lcl` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `control_limit_ucl` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `last_recalculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Recalculation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Violation Notes');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `process_step_code` SET TAGS ('dbx_business_glossary_term' = 'Process Step Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `process_step_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]+$');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `process_step_name` SET TAGS ('dbx_business_glossary_term' = 'Process Step Name');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_value_regex' = 'hourly|daily|per_shift|per_batch');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'LabWare LIMS|Aveva PI|SAP QM');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `subgroup_size` SET TAGS ('dbx_business_glossary_term' = 'Subgroup Size');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `trend_analysis_flag` SET TAGS ('dbx_business_glossary_term' = 'Trend Analysis Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `warning_limit_lcl` SET TAGS ('dbx_business_glossary_term' = 'Lower Warning Limit');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `warning_limit_ucl` SET TAGS ('dbx_business_glossary_term' = 'Upper Warning Limit');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` SET TAGS ('dbx_subdomain' = 'certification_standards');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `coa_template_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis Template ID (COA_TPL_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `hazmat_storage_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Storage Rule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `material_master_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `process_safety_info_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Info Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `applicable_process` SET TAGS ('dbx_business_glossary_term' = 'Applicable Process (PROCESS_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `applicable_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region (REGION)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority (APPROVER)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number (CC_NUM)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification (DATA_CLASS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `default_batch_size` SET TAGS ('dbx_business_glossary_term' = 'Default Batch Size (BATCH_SIZE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (EXPIRY_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `is_ghs_compliant` SET TAGS ('dbx_business_glossary_term' = 'GHS Compliance Flag (GHS_COMPLIANT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `is_gmp_compliant` SET TAGS ('dbx_business_glossary_term' = 'GMP Compliance Flag (GMP_COMPLIANT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `is_iso9001_compliant` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Flag (ISO9001_COMPLIANT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `is_reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliance Flag (REACH_COMPLIANT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `lsl_value` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit Value (LSL_VAL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date (NEXT_REVIEW_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department (DEPT_OWNER)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `quality_specification_description` SET TAGS ('dbx_business_glossary_term' = 'Specification Description (DESC)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `quality_specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `quality_specification_status` SET TAGS ('dbx_value_regex' = 'draft|active|retired|superseded|pending');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard (REG_STD)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_value_regex' = 'ISO|ASTM|EP|USP|GHS|REACH');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason (REV_REASON)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `sds_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Reference (SDS_REF)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `specification_category` SET TAGS ('dbx_business_glossary_term' = 'Specification Category (SPEC_CAT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `specification_category` SET TAGS ('dbx_value_regex' = 'raw_material|intermediate|finished_product');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number (SPEC_NO)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type (SPEC_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_value_regex' = 'internal|customer|regulatory|pharmacopoeia');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Specification Value (TARGET_VAL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User (UPDATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `usl_value` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit Value (USL_VAL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version (VER)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User (CREATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `shipment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `storage_bin_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Bin Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Status (CHAIN_OF_CUSTODY_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|broken');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date (DISPOSAL_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `lab_sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Lifecycle Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `lab_sample_status` SET TAGS ('dbx_value_regex' = 'received|in_testing|tested|disposed|on_hold|rejected');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sample Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity (QUANTITY)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `sample_code` SET TAGS ('dbx_business_glossary_term' = 'Sample Code (SAMPLE_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `sample_name` SET TAGS ('dbx_business_glossary_term' = 'Sample Name (SAMPLE_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type (SAMPLE_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'composite|grab|retention|split|other');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `sampling_point` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point (SAMPLING_POINT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `sampling_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sampling Timestamp (SAMPLING_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition (STORAGE_CONDITION)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'refrigerated|frozen|ambient|controlled|dry|other');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `storage_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity (%) (STORAGE_HUMIDITY_PERCENT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C) (STORAGE_TEMPERATURE_C)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|ml|l|pcs|other');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (UPDATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` SET TAGS ('dbx_subdomain' = 'certification_standards');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ALTER COLUMN `coa_template_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Template Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ALTER COLUMN `superseded_coa_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ALTER COLUMN `author_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` SET TAGS ('dbx_association_edges' = 'quality.inspection_plan,quality.inspection_characteristic');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ALTER COLUMN `plan_characteristic_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Characteristic Assignment ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ALTER COLUMN `inspection_characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Characteristic Assignment - Inspection Characteristic Id');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Characteristic Assignment - Inspection Plan Id');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ALTER COLUMN `characteristic_weight` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Weight');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ALTER COLUMN `control_limit_override` SET TAGS ('dbx_business_glossary_term' = 'Plan-Specific Control Limit Override');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Characteristic Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ALTER COLUMN `sampling_size_override` SET TAGS ('dbx_business_glossary_term' = 'Plan-Specific Sample Size Override');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Sequence Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`plan_characteristic_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Updated Timestamp');
