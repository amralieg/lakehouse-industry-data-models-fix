-- Schema for Domain: quality | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`quality` COMMENT 'Quality control and assurance domain managing laboratory testing, analytical results, COA/COC generation, and quality specifications. Includes QC test methods, sampling plans, inspection lots, quality notifications (OOS, OOT), CAPA workflows, quality hold/release decisions, SPC metrics, and GMP compliance records. Integrates with LabWare LIMS for test data and maintains quality history for regulatory audits and ISO 9001 compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT 'System-generated unique identifier for the inspection lot record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Required for Lot‑to‑Product traceability report linking each inspected lot to its chemical product for release and compliance.',
    `coa_document_id` BIGINT COMMENT 'Reference to the generated Certificate of Analysis for this lot.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection cost allocation: each inspection lots labor/material cost is charged to a cost center for budgeting and variance analysis.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Required for batch traceability to the specific equipment that produced the lot, enabling root‑cause analysis and maintenance planning.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Required for Batch Quality Inspection Report to record the exact formulation version used for the lot, ensuring regulatory traceability.',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: inspection_lot is executed according to an inspection_plan; linking to the plan provides the test method and other plan details, removing duplicated method code fields.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Inspection execution requires assigning a qualified inspector; the inspector is recorded for each lot to support compliance reports.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Traceability report linking each invoice to the inspection lot that cleared the batch, required for regulatory audit of shipped product.',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to order.line_item. Business justification: Inspection lot must be linked to the sales order line it fulfills for traceability in the GMP Lot Traceability Report.',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Inspection lots are performed on specific physical lots; linking enables the Inspection Lot Report to pull lot provenance data.',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Required for traceability: inspection lot is generated for a specific manufacturing order; regulatory reports need order linkage.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to planning.planned_order. Business justification: Production Order Completion Confirmation: inspection lot results are recorded against the specific planned order that produced the lot, enabling closure and traceability.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or chemical substance being inspected.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Batch Release Report requires traceability of each inspected lot to the originating R&D project for regulatory genealogy.',
    `sampling_plan_id` BIGINT COMMENT 'Identifier of the sampling plan applied to this lot.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Inspection lot needs to reference the exact stock position where material resides during inspection for inventory reconciliation.',
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
    `lot_number` STRING COMMENT 'Business identifier assigned to the inspection lot (e.g., LOT-2024-00123).',
    `lot_type` STRING COMMENT 'Category indicating why the lot was created: incoming goods receipt, in‑process production, scheduled periodic inspection, or customer return.. Valid values are `goods_receipt|production|periodic|customer_return`',
    `measurement_uom` STRING COMMENT 'Unit of measure for the primary measurement value. [ENUM-REF-CANDIDATE: kg|lb|L|gal|ppm|%|mol — 7 candidates stripped; promote to reference product]',
    `measurement_value` DECIMAL(18,2) COMMENT 'Resulting numeric value from the primary analytical measurement.',
    `oos_flag` BOOLEAN COMMENT 'True if any test result falls outside the defined specification limits.',
    `oot_flag` BOOLEAN COMMENT 'True if test results deviate from historical trend limits.',
    `pass_fail_flag` BOOLEAN COMMENT 'Indicates whether the lot passed all required specifications (True = Pass).',
    `plant_code` STRING COMMENT 'Code of the manufacturing plant where the inspection took place.',
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
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Enables Product Quality Dashboard aggregating QC results per chemical product, a standard GMP reporting requirement.',
    `employee_id` BIGINT COMMENT 'Identifier of the analyst who performed or reviewed the test.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Links test results to the equipment used, supporting equipment performance monitoring and preventive maintenance decisions.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: QC test results are evaluated against specifications that depend on the specific formula version produced.',
    `inspection_lot_id` BIGINT COMMENT 'Identifier of the inspection lot to which this result belongs.',
    `lab_instrument_id` BIGINT COMMENT 'Identifier of the analytical instrument used.',
    `lab_sample_id` BIGINT COMMENT 'Identifier of the associated control sample, if applicable.',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to order.line_item. Business justification: QC result tied to order line enables the Quality Release Decision process that determines release of goods to the customer.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: QC results must be tied to the specific production lot they belong to for release and traceability.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Required for QC test result traceability to the master material record; QC labs report results per material type in daily QC reports.',
    `quality_deviation_id` BIGINT COMMENT 'Reference to an OOS/OOT quality notification linked to this result.',
    `sample_id` BIGINT COMMENT 'Identifier of the physical sample tested.',
    `spc_control_id` BIGINT COMMENT 'Identifier of the SPC chart to which this result contributes.',
    `characteristic_name` STRING COMMENT 'Name of the measured characteristic (e.g., pH, impurity level).',
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
    `test_method_code` STRING COMMENT 'Code representing the analytical method used (e.g., HPLC, GC, FTIR).',
    `test_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was taken.',
    `unit_of_measure` STRING COMMENT 'Unit in which the result value is expressed.. Valid values are `mg/L|ppm|%|pH|°C`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the QC result record.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper acceptable limit for the characteristic.',
    CONSTRAINT pk_qc_result PRIMARY KEY(`qc_result_id`)
) COMMENT 'Individual analytical test result record from LabWare LIMS or SAP QM for a specific characteristic measured during an inspection lot. Captures test method, characteristic name, measured value, unit of measure, lower/upper specification limits, result status (pass, fail, OOS, OOT), analyst ID, instrument ID, test date/time, retest flag, and raw data reference. Supports SPC charting and regulatory audit trails per ISO 9001 and GMP requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`test_method` (
    `test_method_id` BIGINT COMMENT 'Unique surrogate key for each analytical test method.',
    `reference_standard_id` BIGINT COMMENT 'Surrogate key linking to the certified reference material used for the method.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Method validation is performed by a qualified employee; required for ISO/GLP compliance and method change control.',
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
    `related_standard_codes` STRING COMMENT 'Comma‑separated list of external standard identifiers referenced by the method.',
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
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the characteristic as defined by specifications.',
    `measurement_category` STRING COMMENT 'Broad category of the measurement (e.g., physical, chemical).. Valid values are `physical|chemical|biological|microbial`',
    `owner_department` STRING COMMENT 'Business department responsible for maintaining the characteristic.. Valid values are `quality|production|research|safety`',
    `regulatory_requirement` STRING COMMENT 'Regulation(s) that drive the definition or limits of this characteristic.. Valid values are `EPA|OSHA|REACH|GHS|ISO9001|ISO14001`',
    `related_documentation` STRING COMMENT 'Reference (e.g., URL or document ID) to supporting specifications, SOPs, or test method documents.',
    `review_cycle_days` STRING COMMENT 'Planned interval in days between periodic reviews of the characteristic.',
    `sampling_procedure` STRING COMMENT 'Method used to select samples for this characteristic.. Valid values are `random|systematic|stratified|batch|continuous`',
    `specification_version` STRING COMMENT 'Version identifier of the specification governing this characteristic.',
    `target_value` DECIMAL(18,2) COMMENT 'Target or nominal value expected for the characteristic.',
    `unit_of_measure` STRING COMMENT 'Unit in which the characteristic is measured (e.g., kg, L, ppm, pH). [ENUM-REF-CANDIDATE: kg|g|mg|L|mL|ppm|%|pH|°C|°F — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the characteristic record.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Statistical upper control limit used for SPC monitoring.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the characteristic as defined by specifications.',
    CONSTRAINT pk_inspection_characteristic PRIMARY KEY(`inspection_characteristic_id`)
) COMMENT 'Master definition of a quality characteristic (parameter) to be measured within an inspection plan. Captures characteristic code, description, characteristic type (quantitative, qualitative, attribute), unit of measure, target value, lower/upper specification limits (LSL/USL), lower/upper control limits (LCL/UCL) for SPC, sampling procedure, test method reference, decimal precision, and GMP-critical flag. Linked to inspection plans and drives qc_result recording.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` (
    `inspection_plan_id` BIGINT COMMENT 'Unique identifier for the inspection plan.',
    `chemical_product_id` BIGINT COMMENT 'FK to product.chemical_product',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Inspection plans are created by a responsible employee; the link supports traceability for regulatory inspections.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Inspection plans are created per material; the plan definition references the Material Master for specification lookup.',
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
    `plant_code` STRING COMMENT 'Code of the manufacturing plant where the plan is used.',
    `rejection_number` STRING COMMENT 'Minimum number of defectives that triggers rejection.',
    `review_status` STRING COMMENT 'Current status of the plans review process.. Valid values are `pending|approved|rejected`',
    `sample_size_code` STRING COMMENT 'Code letter that maps to a specific sample size.. Valid values are `A|B|C|D|E|F`',
    `sampling_scheme_type` STRING COMMENT 'Type of statistical sampling applied by the plan.. Valid values are `single|double|sequential`',
    `sampling_standard` STRING COMMENT 'Reference standard governing the sampling rules.. Valid values are `ISO2859|MIL1916|CUSTOM`',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sampling plans are authored by a quality engineer; linking to employee enables audit of plan ownership and training records.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Sampling plans can be material‑specific to meet regulatory sampling frequency; linking provides direct material context.',
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
    `employee_id` BIGINT COMMENT 'Identifier of the employee or authorized person who approved the usage decision.',
    `experimental_formulation_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formulation. Business justification: Release decisions are based on approval of a specific experimental formulation; linking enables automated release authorization.',
    `inspection_lot_id` BIGINT COMMENT 'Reference to the inspection lot that this decision applies to.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Usage decisions release material from a specific lot; linking to inventory lot enables accurate stock deduction and compliance.',
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
    `material_number` STRING COMMENT 'SAP material master number of the inspected material.',
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
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Links each deviation directly to the affected product for regulatory incident reports and root‑cause analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deviation cost allocation: quality notifications are charged to the cost center responsible for the material/process that caused the deviation.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer Complaint Management report requires linking each quality deviation to the reporting customer account to track complaints and regulatory notifications.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Complaint handling process records the specific contact who raised the issue, enabling traceability and follow‑up in the Customer Interaction system.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or system that created the notification.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Quality deviations are investigated per lot; linking to the lot record supports root‑cause analysis and hold management.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Deviation reports reference a material; a FK to Material Master enables root‑cause analysis and regulatory reporting.',
    `safety_incident_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_incident. Business justification: Root‑cause analysis: quality deviations that result in safety incidents need a direct link to the incident for integrated investigation and reporting.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Supplier‑origin tracking of quality deviations is needed for root‑cause analysis and regulatory compliance.',
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
    `notification_number` STRING COMMENT 'Business identifier assigned to the quality deviation (e.g., QD-2024-000123).',
    `notification_type` STRING COMMENT 'Category of quality event triggering the notification.. Valid values are `OOS|OOT|NCR|COMPLAINT|DEVIATION|CUSTOMER_COMPLAINT`',
    `priority` STRING COMMENT 'Operational priority for investigation and resolution.. Valid values are `high|medium|low`',
    `quality_deviation_description` STRING COMMENT 'Detailed narrative of the quality issue, including observed symptoms.',
    `quality_deviation_status` STRING COMMENT 'Current lifecycle status of the quality deviation.. Valid values are `open|in_process|resolved|closed|rejected`',
    `regulatory_reportable` BOOLEAN COMMENT 'Indicates if the deviation must be reported to regulatory bodies (e.g., EPA, FDA).',
    `related_coa_number` STRING COMMENT 'Certificate of Analysis number linked to the affected batch.',
    `related_coc_number` STRING COMMENT 'Certificate of Compliance number associated with the material.',
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
    `employee_id` BIGINT COMMENT 'Identifier of the employee who raised the CAPA.',
    `quality_deviation_id` BIGINT COMMENT 'Reference to the Out‑of‑Specification event that triggered the CAPA, if applicable.',
    `capa_related_quality_notification_quality_notification_quality_deviation_id` BIGINT COMMENT 'Reference to a quality notification (e.g., OOS, OOT) linked to this CAPA.',
    `mrp_exception_id` BIGINT COMMENT 'Foreign key linking to planning.mrp_exception. Business justification: CAPA actions are triggered by MRP exceptions (e.g., material shortage) and must be linked to the originating exception for root‑cause tracking.',
    `owner_employee_id` BIGINT COMMENT 'Identifier of the employee responsible for implementing the CAPA.',
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
    `employee_id` BIGINT COMMENT 'Identifier of the QA employee who approved the certificate.',
    `product_order_id` BIGINT COMMENT 'Sales order identifier associated with the batch.',
    `safety_data_sheet_id` BIGINT COMMENT 'Reference to the SDS document for the product.',
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
    `lot_number` STRING COMMENT 'Lot identifier used for traceability across the supply chain.',
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
    `specification_reference` STRING COMMENT 'Reference code to the product specification document used for evaluation.',
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
    `inventory_target_id` BIGINT COMMENT 'Foreign key linking to planning.inventory_target. Business justification: Inventory target calculations consider active quality holds to adjust safety stock and reorder points, requiring a direct link.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Finance must block or flag invoices for batches under quality hold, ensuring no payment is collected before release.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Quality holds block usage of a specific lot; FK to inventory lot enables automated quarantine handling.',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Quality hold is applied to a manufacturing order; linking supports hold/release workflow and regulatory reporting.',
    `material_master_id` BIGINT COMMENT 'Internal identifier of the material subject to the hold.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or system that created the hold.',
    `product_order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Quality hold linked to a sales order enables the Order Hold Management workflow to prevent shipping non‑conforming goods.',
    `quality_deviation_id` BIGINT COMMENT 'Link to the quality notification (e.g., OOS, OOT) that generated the hold.',
    `safety_incident_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_incident. Business justification: Regulatory traceability: when a quality hold is placed due to a safety incident, the hold must reference the incident for compliance reporting.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Hold Management process tracks shipments placed on hold due to quality issues, linking hold records to the affected shipment.',
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
    `related_coa_number` STRING COMMENT 'Reference to the COA that triggered or is associated with the hold.',
    `release_outcome` STRING COMMENT 'Result of the hold disposition after investigation.. Valid values are `released|rejected|reprocessed|scrapped`',
    `storage_location` STRING COMMENT 'Warehouse or storage area code where the held material is physically located.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the held quantity (e.g., kilograms, liters).. Valid values are `kg|l|g|ml|pcs`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the hold record.',
    CONSTRAINT pk_quality_hold PRIMARY KEY(`quality_hold_id`)
) COMMENT 'Quality hold record placing a material batch, lot, or inventory quantity under restricted status pending quality investigation or disposition. Captures hold number, hold type (incoming, in-process, finished goods, customer return), affected material, batch/lot, quantity, storage location, hold reason, hold initiator, hold date, expected release date, actual release date, release authority, and hold outcome (released, rejected, reprocessed, scrapped). Integrates with SAP QM blocked stock and EWM.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`spc_control` (
    `spc_control_id` BIGINT COMMENT 'Primary key for spc_control',
    `spc_violation_id` BIGINT COMMENT 'Unique identifier for an individual SPC rule violation event.',
    `characteristic_code` STRING COMMENT 'Standardized code identifying the quality characteristic (e.g., CAS number, internal KPI code).. Valid values are `^[A-Z0-9_]+$`',
    `characteristic_name` STRING COMMENT 'Human‑readable name of the quality characteristic being monitored (e.g., pH, viscosity).',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` (
    `spc_violation_id` BIGINT COMMENT 'System‑generated unique identifier for each SPC control‑chart violation event.',
    `capa_id` BIGINT COMMENT 'Reference to the corrective action record linked to this violation.',
    `spc_chart_id` BIGINT COMMENT 'Identifier of the control chart (X‑bar, R, etc.) that recorded the violation.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the operator on duty at the time of the violation.',
    `sample_id` BIGINT COMMENT 'Identifier of the laboratory sample from which the measurement originated.',
    `batch_lot_number` STRING COMMENT 'Lot identifier for the material batch associated with the measurement.',
    `center_line` DECIMAL(18,2) COMMENT 'Target or average value plotted as the center line on the control chart.',
    `characteristic_name` STRING COMMENT 'Name of the quality characteristic monitored (e.g., pH, temperature, viscosity).',
    `comments` STRING COMMENT 'Free‑form notes entered by quality personnel.',
    `control_chart_type` STRING COMMENT 'Type of SPC chart used (X‑bar, R, S, p, np, c, u). [ENUM-REF-CANDIDATE: Xbar|R|S|p|np|c|u — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the violation record was first created in the system.',
    `disposition` STRING COMMENT 'Outcome of the violation handling process.. Valid values are `false_alarm|assignable_cause|process_adjusted`',
    `investigation_required` BOOLEAN COMMENT 'Indicates whether a root‑cause investigation must be launched (True) or not (False).',
    `limit_type` STRING COMMENT 'Indicates whether the upper, lower, or both control limits were breached.. Valid values are `upper|lower|both`',
    `limit_value` DECIMAL(18,2) COMMENT 'Numeric value of the control limit that was exceeded (upper or lower).',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Lower statistical control limit for the characteristic.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric value recorded for the characteristic at the time of violation.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date‑time when the operator or quality team was notified of the violation.',
    `operator_name` STRING COMMENT 'Full name of the operator on duty.',
    `process_step` STRING COMMENT 'Name or code of the manufacturing step where the violation occurred.',
    `root_cause_identified` BOOLEAN COMMENT 'True if a root cause has been determined, otherwise False.',
    `rule_description` STRING COMMENT 'Human‑readable description of the triggered SPC rule.',
    `rule_number` STRING COMMENT 'Number (1‑8) of the Western Electric/Nelson rule that was triggered.',
    `source_system` STRING COMMENT 'Originating system that generated the violation record (e.g., SAP QM, LabWare LIMS).',
    `spc_violation_status` STRING COMMENT 'Current lifecycle status of the violation.. Valid values are `open|closed|in_review`',
    `unit_of_measure` STRING COMMENT 'Unit associated with the measured value (e.g., °C, pH units, ppm).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the violation record.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Upper statistical control limit for the characteristic.',
    `violation_timestamp` TIMESTAMP COMMENT 'Date‑time when the SPC rule breach was detected.',
    CONSTRAINT pk_spc_violation PRIMARY KEY(`spc_violation_id`)
) COMMENT 'SPC control chart violation event record capturing instances where a measured quality characteristic breaches control limits or triggers a Western Electric / Nelson rule violation. Records violation type (rule 1-8), chart reference, characteristic, measured value, control limit breached, detection timestamp, process step, operator notified, investigation required flag, and disposition (false alarm, assignable cause identified, process adjusted). Feeds quality notification creation and process improvement workflows.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` (
    `quality_specification_id` BIGINT COMMENT 'Unique identifier for the quality specification record.',
    `coa_template_id` BIGINT COMMENT 'Identifier of the COA template used for reporting against this specification.',
    `formula_spec_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_spec. Business justification: Quality specifications must be aligned with the corresponding formulation specification for regulatory compliance.',
    `material_master_id` BIGINT COMMENT 'FK to rawmaterial.material_master',
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
    `grade` STRING COMMENT 'Quality grade or class assigned to the specification (e.g., A, B, C).',
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
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the sampling.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Lab samples are taken from specific equipment; linking provides traceability and supports equipment cleaning schedules.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Lab samples are taken from production runs of a defined formulation version; linking enables traceability of analytical results.',
    `lab_experiment_id` BIGINT COMMENT 'Foreign key linking to research.lab_experiment. Business justification: Quality lab samples often originate from R&D lab experiments; linking supports method validation traceability and audit.',
    `sample_id` BIGINT COMMENT 'Identifier of the sample in the LabWare LIMS system.',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to order.line_item. Business justification: Lab sample linked to order line provides traceability for the Sample Tracking report required by regulatory bodies.',
    `shipment_line_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment_line. Business justification: Outbound Shipment Sampling requires linking each lab sample to the specific shipment line from which the sample was taken.',
    `chain_of_custody_status` STRING COMMENT 'Status of the chain‑of‑custody tracking for the sample.. Valid values are `in_progress|completed|broken`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample record was first created in the data lake.',
    `disposal_date` DATE COMMENT 'Date the sample was disposed of, if applicable.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the sample.. Valid values are `incineration|landfill|chemical_treatment|recycle|other`',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` (
    `lab_instrument_id` BIGINT COMMENT 'Primary key for lab_instrument',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Instrument depreciation & maintenance costs are charged to the cost center that owns the lab instrument.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Instrument operation is assigned to a specific employee; needed for calibration history and GMP records.',
    `adjusted_value` DECIMAL(18,2) COMMENT 'Value applied to the instrument after calibration to bring it within tolerance.',
    `asset_tag` STRING COMMENT 'Internal asset tag or barcode used for inventory tracking.',
    `calibration_certificate_number` STRING COMMENT 'Identifier of the calibration certificate issued after a successful calibration.',
    `calibration_history_count` STRING COMMENT 'Total number of calibration events recorded for this instrument.',
    `calibration_notes` STRING COMMENT 'Free‑form comments or observations recorded during calibration.',
    `calibration_result` STRING COMMENT 'Outcome of the calibration event.. Valid values are `pass|fail|adjusted`',
    `calibration_standard` STRING COMMENT 'Reference material or standard used during calibration.',
    `calibration_status` STRING COMMENT 'Current status of the instruments calibration lifecycle.. Valid values are `in_calibration|overdue|out_of_service`',
    `calibration_type` STRING COMMENT 'Nature of the calibration event (routine, after repair, or verification).. Valid values are `routine|after_repair|verification`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the instrument master record was first created.',
    `gmp_compliant` BOOLEAN COMMENT 'Indicates whether the instrument meets Good Manufacturing Practice requirements.',
    `installation_date` DATE COMMENT 'Date the instrument was first installed and made operational.',
    `instrument_name` STRING COMMENT 'Human‑readable name or label of the instrument as used in the lab.',
    `instrument_type` STRING COMMENT 'Category of analytical instrument (e.g., HPLC, GC, ICP‑MS, UV‑Vis, Titrator, pH Meter).. Valid values are `HPLC|GC|ICP-MS|UV-Vis|Titrator|pH_Meter`',
    `iso17025_compliant` BOOLEAN COMMENT 'Indicates compliance with the international standard for testing and calibration laboratories.',
    `lab_instrument_status` STRING COMMENT 'Current operational status of the instrument.. Valid values are `active|inactive|retired|maintenance`',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration event.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent preventive maintenance was performed.',
    `location` STRING COMMENT 'Physical location or plant code where the instrument is installed.',
    `maintenance_cycle_days` STRING COMMENT 'Planned interval in days between routine maintenance activities.',
    `manufacturer` STRING COMMENT 'Company that manufactured the instrument.',
    `model_number` STRING COMMENT 'Model identifier assigned by the manufacturer.',
    `next_due_date` DATE COMMENT 'Scheduled date when the next calibration must be performed.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance.',
    `part11_compliant` BOOLEAN COMMENT 'Indicates compliance with electronic records and signatures regulations.',
    `performed_by` STRING COMMENT 'Name or identifier of the technician who performed the calibration.',
    `post_calibration_reading` DECIMAL(18,2) COMMENT 'Instrument reading recorded after calibration adjustments.',
    `pre_calibration_reading` DECIMAL(18,2) COMMENT 'Instrument reading recorded before calibration adjustments.',
    `qualification_date` DATE COMMENT 'Date the most recent qualification activity was completed.',
    `qualification_status` STRING COMMENT 'Current qualification stage of the instrument (Installation Qualification, Operational Qualification, Performance Qualification, or not qualified).. Valid values are `IQ|OQ|PQ|Not_Qualified`',
    `qualified_by` STRING COMMENT 'Name or identifier of the person/department that performed the qualification.',
    `regulatory_status` STRING COMMENT 'Overall regulatory compliance status of the instrument.. Valid values are `compliant|non_compliant|pending`',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the instrument hardware.',
    `tolerance` DECIMAL(18,2) COMMENT 'Acceptable deviation range for the calibration reading.',
    `updated_by` STRING COMMENT 'User or system identifier that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the instrument record.',
    `created_by` STRING COMMENT 'User or system identifier that created the record.',
    CONSTRAINT pk_lab_instrument PRIMARY KEY(`lab_instrument_id`)
) COMMENT 'Master record for laboratory analytical instruments and their complete calibration history used in quality testing. Captures instrument identity (ID, name, type: HPLC, GC, ICP-MS, UV-Vis, titrator, pH meter, viscometer), manufacturer, model, serial number, location, qualification status (IQ/OQ/PQ), and full calibration event records including calibration event ID, calibration type (routine, after-repair, verification), calibration standard used, calibration date, performed by, calibration result (pass, fail, adjusted), pre-calibration reading, post-calibration reading, tolerance, next due date, calibration certificate number, and calibration status (in-calibration, overdue, out-of-service). Single source of truth for instrument master data and all calibration lifecycle events. Supports GMP instrument qualification, 21 CFR Part 11 compliance, and ISO/IEC 17025 audit trails.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` (
    `instrument_calibration_id` BIGINT COMMENT 'System-generated unique identifier for each calibration event.',
    `lab_instrument_id` BIGINT COMMENT 'Unique identifier of the laboratory instrument that was calibrated.',
    `employee_id` BIGINT COMMENT 'Identifier of the qualified personnel who executed the calibration.',
    `adjusted_value` DECIMAL(18,2) COMMENT 'Value applied to the instrument to bring it within tolerance, if a correction was needed.',
    `calibration_date` DATE COMMENT 'Date on which the calibration activity was performed.',
    `calibration_location` STRING COMMENT 'Physical location or plant where the calibration was performed.',
    `calibration_method` STRING COMMENT 'Technique used for calibration (e.g., gravimetric, electronic, photometric).',
    `calibration_standard` STRING COMMENT 'Name or code of the reference standard used for calibration (e.g., NIST SRM).',
    `calibration_status` STRING COMMENT 'Current lifecycle status of the calibration record.. Valid values are `completed|pending|failed|cancelled`',
    `calibration_type` STRING COMMENT 'Category of calibration performed (e.g., routine, after repair, verification).. Valid values are `routine|after_repair|verification|initial|requalification`',
    `certificate_issue_date` DATE COMMENT 'Date on which the calibration certificate was formally issued.',
    `certificate_number` STRING COMMENT 'Unique identifier of the calibration certificate issued after a successful calibration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration record was initially created in the system.',
    `gmp_compliant` BOOLEAN COMMENT 'True if the calibration activity complies with Good Manufacturing Practice standards.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the pre- and post-calibration readings (e.g., mg/L, ppm).',
    `next_due_date` DATE COMMENT 'Scheduled date for the next required calibration of the instrument.',
    `post_calibration_reading` DECIMAL(18,2) COMMENT 'Instrument reading recorded after calibration adjustment.',
    `pre_calibration_reading` DECIMAL(18,2) COMMENT 'Instrument reading recorded before calibration adjustment.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the calibration meets applicable regulatory requirements (e.g., 21 CFR Part 11, ISO/IEC 17025).',
    `remarks` STRING COMMENT 'Free-text comments or observations recorded by the calibrator.',
    `result` STRING COMMENT 'Outcome of the calibration activity indicating whether the instrument passed, failed, or required adjustment.. Valid values are `pass|fail|adjusted`',
    `standard_version` STRING COMMENT 'Version or revision identifier of the calibration standard.',
    `tolerance` DECIMAL(18,2) COMMENT 'Acceptable deviation range for the instrument reading, expressed in the same unit as the readings.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the calibration record.',
    CONSTRAINT pk_instrument_calibration PRIMARY KEY(`instrument_calibration_id`)
) COMMENT 'Calibration event record for a laboratory instrument capturing each calibration activity performed to ensure measurement accuracy and GMP compliance. Records calibration event ID, instrument reference, calibration type (routine, after-repair, verification), calibration standard used, calibration date, performed by, calibration result (pass, fail, adjusted), pre-calibration reading, post-calibration reading, tolerance, next due date, and calibration certificate number. Supports 21 CFR Part 11 and ISO/IEC 17025 audit trails.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`stability_study` (
    `stability_study_id` BIGINT COMMENT 'Primary key for stability_study',
    `chemical_product_id` BIGINT COMMENT 'Reference to the product or formulation under study.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Stability testing cost allocation: each stability study is budgeted and expensed against a cost center.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Stability studies run in controlled chambers (equipment); linking ensures equipment calibration and compliance tracking.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Stability studies assess shelf‑life of a particular formulation version, requiring direct linkage for compliance reporting.',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Stability studies are assigned to a specific production order batch; required for shelf‑life documentation.',
    `employee_id` BIGINT COMMENT 'Identifier of the quality analyst responsible for the study.',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Production Planning uses stability study outcomes to set shelf‑life limits and batch size constraints for the associated production plan.',
    `actual_end_date` DATE COMMENT 'Date when the final time‑point measurement was recorded.',
    `approval_status` STRING COMMENT 'Regulatory or quality approval status of the study.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name of the person who approved the study.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the study was approved.',
    `batch_lot_number` STRING COMMENT 'Manufacturing lot number used for the study sample.',
    `comments` STRING COMMENT 'Free‑text notes or observations about the study.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the study record was created in the system.',
    `degradation_trend_flag` BOOLEAN COMMENT 'Indicates whether a degradation trend was observed across time‑points.',
    `labware_lims_study_ref` STRING COMMENT 'Reference identifier linking to the study record in LabWare LIMS.',
    `light_exposure` STRING COMMENT 'Description of light exposure condition for the study.. Valid values are `none|ambient|controlled|UV`',
    `oos_flag` BOOLEAN COMMENT 'Indicates if any measurement exceeded specification limits.',
    `oot_flag` BOOLEAN COMMENT 'Indicates if any measurement was out of trend criteria.',
    `planned_end_date` DATE COMMENT 'Target date for study completion as per protocol.',
    `regulatory_reference` STRING COMMENT 'Regulatory guideline or standard governing the study (e.g., ICH Q1A, EPA).',
    `shelf_life_estimate_months` STRING COMMENT 'Estimated shelf life in months based on study results.',
    `shelf_life_units` STRING COMMENT 'Units for the shelf life estimate.. Valid values are `months|years`',
    `stability_study_status` STRING COMMENT 'Current lifecycle status of the stability study.. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `start_date` DATE COMMENT 'Date when the stability study commenced.',
    `storage_humidity_percent` DECIMAL(18,2) COMMENT 'Target relative humidity percentage for the study condition.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Target storage temperature in degrees Celsius for the study condition.',
    `study_number` STRING COMMENT 'External identifier for the stability study as assigned by the quality department.',
    `study_protocol_version` STRING COMMENT 'Version identifier of the study protocol document.',
    `study_type` STRING COMMENT 'Category of stability testing performed.. Valid values are `long_term|accelerated|stress|photostability`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the study record.',
    `version_number` STRING COMMENT 'Version number for audit tracking of the study record.',
    CONSTRAINT pk_stability_study PRIMARY KEY(`stability_study_id`)
) COMMENT 'Stability study master record and complete time-point result data managing long-term, accelerated, and stress stability testing programs for chemical products and formulations. Captures study number, study type (long-term, accelerated, stress, photostability), product/formulation reference, storage conditions (temperature, humidity, light), study protocol, testing intervals, regulatory reference (ICH Q1A, EPA), study status, and all individual time-point measurement results including stability result ID, time point (T0, T3M, T6M, T12M, T24M), storage condition, characteristic tested, measured value, specification limit, pass/fail status, degradation trend flag, OOT flag, analyst, test date, and LabWare LIMS result reference. Single source of truth for stability study design and all associated measurement data. Supports shelf-life determination, product registration dossiers, and regulatory stability report generation.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`stability_result` (
    `stability_result_id` BIGINT COMMENT 'System-generated unique identifier for the stability result record.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to production.batch_record. Business justification: Stability result must be tied to the exact batch record to correlate test conditions with production data.',
    `employee_id` BIGINT COMMENT 'Identifier of the laboratory analyst who performed or reviewed the test.',
    `lab_instrument_id` BIGINT COMMENT 'Identifier of the laboratory instrument used for the test.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Stability results are generated for a stored lot; association with inventory lot is required for shelf‑life tracking.',
    `sample_id` BIGINT COMMENT 'Identifier of the physical sample taken for analysis.',
    `stability_study_id` BIGINT COMMENT 'Identifier of the stability study to which this result belongs.',
    `batch_number` STRING COMMENT 'Manufacturing batch number of the product being tested.',
    `characteristic_code` STRING COMMENT 'Code identifying the analytical characteristic tested (e.g., potency, impurity).',
    `characteristic_name` STRING COMMENT 'Human‑readable name of the characteristic tested.',
    `comments` STRING COMMENT 'Analyst or system comments related to the result.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the stability result record was first created in the data lake.',
    `data_source_system` STRING COMMENT 'System of record that originally captured the result.. Valid values are `LabWare LIMS|SAP QM|Custom`',
    `degradation_trend_flag` BOOLEAN COMMENT 'True if the result shows a statistically significant degradation trend over time.',
    `expiration_date` DATE COMMENT 'Date after which the product is considered expired for regulatory purposes.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage at the time of testing.',
    `labware_result_reference` BIGINT COMMENT 'Reference to the raw result record stored in LabWare LIMS.',
    `location_code` STRING COMMENT 'Code of the storage location where the sample was kept.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric result of the analytical measurement.',
    `measurement_method_code` STRING COMMENT 'Code of the analytical method used for the measurement.',
    `measurement_method_description` STRING COMMENT 'Full description of the analytical method.',
    `oot_flag` BOOLEAN COMMENT 'True if the result deviates from the expected trend (Out‑of‑Trend).',
    `pass_fail_flag` STRING COMMENT 'Indicates whether the measured value meets the specification (pass) or not (fail).. Valid values are `pass|fail`',
    `product_code` STRING COMMENT 'Internal code identifying the product under stability study.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the result complies with applicable regulatory specifications.',
    `sample_weight` DECIMAL(18,2) COMMENT 'Weight of the sample used for the test.',
    `sample_weight_uom` STRING COMMENT 'Unit of measure for the sample weight (e.g., g, mg).',
    `specification_limit` DECIMAL(18,2) COMMENT 'Acceptable limit defined in the product specification for this characteristic.',
    `stability_result_status` STRING COMMENT 'Current lifecycle status of the result record.. Valid values are `active|archived|deleted`',
    `storage_condition` STRING COMMENT 'Condition under which the sample was stored during the stability interval.. Valid values are `ambient|refrigerated|frozen`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature during the test, expressed in degrees Celsius.',
    `test_timestamp` TIMESTAMP COMMENT 'Date and time when the stability test was executed.',
    `time_point` STRING COMMENT 'Scheduled time point of the stability measurement (e.g., T0, T3M, T6M, T12M, T24M).. Valid values are `T0|T3M|T6M|T12M|T24M`',
    `unit_of_measure` STRING COMMENT 'Unit associated with the measured value (e.g., mg/L, % w/w).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the stability result record.',
    `version_number` STRING COMMENT 'Version number of the result record for audit and change tracking.',
    CONSTRAINT pk_stability_result PRIMARY KEY(`stability_result_id`)
) COMMENT 'Individual test result record from a stability study time point measurement. Captures stability result ID, study reference, time point (T0, T3M, T6M, T12M, T24M), storage condition, characteristic tested, measured value, specification limit, pass/fail status, degradation trend flag, OOT flag, analyst, test date, and LabWare LIMS result reference. Feeds shelf-life calculations and regulatory stability reports for product registration dossiers.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`audit` (
    `audit_id` BIGINT COMMENT 'Primary key for audit',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Audit cost allocation: internal audit expenses are posted to the cost center responsible for the audited process.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Lead auditor is a designated employee; linking enables audit assignment tracking and regulatory reporting.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Material‑focused compliance audits require linking the audit record to the specific Material Master under review.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the audit actually concluded.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the audit actually began.',
    `audit_number` STRING COMMENT 'Business identifier assigned to the audit, used for tracking and reference.',
    `audit_scope` STRING COMMENT 'Scope of the audit, e.g., ISO 9001, GMP, Process Safety, etc.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit record.. Valid values are `draft|scheduled|in_progress|completed|closed`',
    `audit_type` STRING COMMENT 'Classification of the audit based on its origin or purpose.. Valid values are `internal|external|supplier|customer|regulatory`',
    `closure_date` DATE COMMENT 'Date when the audit record was formally closed.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the audit record.. Valid values are `public|internal|confidential|restricted`',
    `corrective_action_due_date` DATE COMMENT 'Date by which corrective actions must be completed.',
    `corrective_action_owner` STRING COMMENT 'Name of the person or group responsible for implementing corrective actions.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action.. Valid values are `open|in_progress|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `department_code` STRING COMMENT 'Code of the department or functional area audited.',
    `document_reference` STRING COMMENT 'Link or identifier to the audit report or supporting documents.',
    `end_date` DATE COMMENT 'Planned end date of the audit (date level).',
    `external_auditor` STRING COMMENT 'Name of the external auditor or audit firm, if applicable.',
    `findings_major` STRING COMMENT 'Count of major non‑conformance findings.',
    `findings_minor` STRING COMMENT 'Count of minor non‑conformance findings.',
    `findings_observation` STRING COMMENT 'Count of observation‑type findings.',
    `findings_ofi` STRING COMMENT 'Count of OFI‑type findings.',
    `findings_total` STRING COMMENT 'Total number of findings recorded for the audit.',
    `last_review_date` DATE COMMENT 'Date when the audit record was last reviewed for accuracy.',
    `lead_auditor` STRING COMMENT 'Name of the primary auditor responsible for the audit.',
    `next_review_date` DATE COMMENT 'Planned date for the next review of the audit record.',
    `notes` STRING COMMENT 'Free‑form notes captured by auditors.',
    `outcome` STRING COMMENT 'Result of the audit after evaluation.. Valid values are `pass|conditional_pass|fail`',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant where the audit took place.',
    `regulation_reference` STRING COMMENT 'Specific regulation or clause referenced by the audit.',
    `regulatory_body` STRING COMMENT 'Regulatory authority associated with the audit, if applicable. [ENUM-REF-CANDIDATE: EPA|OSHA|ECHA|ISO|FDA|TSCA|DOT|NFPA — 8 candidates stripped; promote to reference product]',
    `root_cause_category` STRING COMMENT 'High‑level category of the root cause for findings.. Valid values are `process|material|equipment|method|management`',
    `root_cause_description` STRING COMMENT 'Detailed description of the root cause identified.',
    `standard` STRING COMMENT 'Standard or regulation against which the audit is performed.',
    `start_date` DATE COMMENT 'Planned start date of the audit (date level).',
    `team` STRING COMMENT 'Comma‑separated list of auditors participating in the audit.',
    `type_detail` STRING COMMENT 'Additional detail describing the audit type, e.g., supplier certification, customer compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit record.',
    `verification_status` STRING COMMENT 'Status of verification for the corrective action.. Valid values are `verified|not_verified|pending`',
    `version` STRING COMMENT 'Version number of the audit record for change tracking.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Quality audit record managing internal and external quality system audits and all associated findings for ISO 9001, GMP, customer, and regulatory compliance. Captures audit header (audit number, type: internal/external/supplier/customer/regulatory, scope, standard, lead auditor, audit team, dates, plant/department, outcome) and individual finding detail records (finding ID, finding type: major NC, minor NC, observation, OFI; finding description, clause reference, affected process, root cause category, assigned owner, response due date, response submitted date, response description, verification status, closure date). Tracks number of findings by severity, audit outcome (pass, conditional pass, fail), follow-up due dates, and CAPA linkages for major non-conformances. Single source of truth for audit program management, finding tracking, and continuous improvement evidence.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'System-generated unique identifier for each audit finding.',
    `audit_id` BIGINT COMMENT 'Identifier of the audit that generated this finding.',
    `capa_id` BIGINT COMMENT 'Identifier of the associated CAPA record, if one exists.',
    `evidence_document_id` BIGINT COMMENT 'Identifier of the document or file that provides evidence for the finding.',
    `employee_id` BIGINT COMMENT 'Identifier of the person or team assigned to address the finding.',
    `tertiary_audit_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who performed the latest update.',
    `affected_process` STRING COMMENT 'Name or code of the process, unit, or operation impacted by the finding.',
    `audit_finding_description` STRING COMMENT 'Detailed narrative of the audit observation or non‑conformance.',
    `audit_finding_source` STRING COMMENT 'Indicates whether the finding originated from an internal audit or an external party.. Valid values are `internal|external`',
    `audit_finding_status` STRING COMMENT 'Current lifecycle status of the audit finding.. Valid values are `open|in_progress|closed|deferred`',
    `clause_reference` STRING COMMENT 'Reference to the ISO 9001 or GMP clause that the finding relates to.',
    `closure_date` DATE COMMENT 'Date when the finding was formally closed after verification.',
    `compliance_flag` BOOLEAN COMMENT 'True if the finding represents a regulatory non‑compliance.',
    `corrective_action_required` BOOLEAN COMMENT 'True if the finding mandates a corrective action plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the audit finding record was first created.',
    `finding_number` STRING COMMENT 'Human‑readable sequential number of the finding within the audit.',
    `finding_type` STRING COMMENT 'Classification of the finding: major non‑conformance, minor non‑conformance, observation, or opportunity for improvement.. Valid values are `major_nc|minor_nc|observation|ofi`',
    `regulatory_clause` STRING COMMENT 'Specific regulatory requirement (e.g., EPA, OSHA, REACH) cited by the finding.',
    `response_description` STRING COMMENT 'Textual description of the corrective or preventive action proposed.',
    `response_due_date` DATE COMMENT 'Date by which a corrective response must be submitted.',
    `response_submitted_date` DATE COMMENT 'Date on which the corrective response was actually submitted.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0‑100) calculated from severity, likelihood, and exposure.',
    `root_cause_category` STRING COMMENT 'High‑level category describing the underlying cause of the finding.. Valid values are `material|method|machine|man|environment|management`',
    `severity_level` STRING COMMENT 'Severity rating assigned to the finding based on impact.. Valid values are `critical|high|medium|low`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the finding record.',
    `verification_status` STRING COMMENT 'Current verification state of the response: pending, verified, or rejected.. Valid values are `pending|verified|rejected`',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual finding record from a quality audit capturing a specific non-conformance, observation, or opportunity for improvement identified during an audit. Records finding ID, audit reference, finding type (major NC, minor NC, observation, OFI), finding description, clause reference (ISO 9001 clause, GMP section), affected process, root cause category, assigned owner, response due date, response submitted date, response description, verification status, and closure date. Drives CAPA creation for major non-conformances.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` (
    `reference_standard_id` BIGINT COMMENT 'System-generated unique identifier for the reference standard record.',
    `cas_number` STRING COMMENT 'Unique CAS registry number identifying the chemical substance.. Valid values are `^d{2,7}-d{2}-d$`',
    `certificate_number` STRING COMMENT 'Identifier of the certificate of analysis issued for the standard.',
    `concentration` DECIMAL(18,2) COMMENT 'Concentration of the standard (e.g., mol/L) when applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reference standard record was first created in the system.',
    `expiry_date` DATE COMMENT 'Date after which the reference standard is no longer considered valid for use.',
    `hazard_classification` STRING COMMENT 'GHS hazard class applicable to the standard.. Valid values are `flammable|corrosive|toxic|oxidizer|environmental_hazard|none`',
    `is_gmp_compliant` BOOLEAN COMMENT 'Indicates whether the standard meets Good Manufacturing Practice requirements.',
    `is_iso17025_compliant` BOOLEAN COMMENT 'Indicates compliance with ISO/IEC 17025 laboratory accreditation standards.',
    `lot_number` STRING COMMENT 'Lot or batch identifier assigned by the supplier for traceability.',
    `purity_percent` DECIMAL(18,2) COMMENT 'Purity of the standard expressed as a percentage.',
    `receipt_date` DATE COMMENT 'Date the reference standard was received into inventory.',
    `reference_standard_code` STRING COMMENT 'Business identifier or catalogue code assigned to the reference standard.',
    `reference_standard_name` STRING COMMENT 'Descriptive name of the reference standard as used in laboratory documentation.',
    `reference_standard_status` STRING COMMENT 'Current lifecycle state of the reference standard.. Valid values are `active|retired|on_hold|pending`',
    `reference_standard_type` STRING COMMENT 'Classification of the standard (e.g., primary, secondary, working, certified reference material).. Valid values are `primary|secondary|working|certified|reference_material|custom`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the standard satisfies all applicable regulatory requirements (EPA, OSHA, REACH, etc.).',
    `reorder_level` BIGINT COMMENT 'Minimum quantity threshold that triggers a replenishment request.',
    `safety_considerations` STRING COMMENT 'Notes on handling, PPE, and safety precautions for the standard.',
    `stock_quantity` BIGINT COMMENT 'Current on‑hand quantity of the reference standard in the designated unit of measure.',
    `stock_uom` STRING COMMENT 'Unit of measure for the stock quantity (e.g., kg, L).. Valid values are `kg|g|mg|l|ml|units`',
    `storage_condition` STRING COMMENT 'Required storage environment for the standard (e.g., refrigerated, ambient).. Valid values are `refrigerated|ambient|frozen|controlled|room_temp`',
    `supplier` STRING COMMENT 'Name of the external supplier or manufacturer of the reference standard.',
    `traceability_source` STRING COMMENT 'Origin of the standards traceability chain (e.g., NIST, ECHA).. Valid values are `NIST|ECHA|pharmacopoeia|internal|supplier`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the reference standard record.',
    CONSTRAINT pk_reference_standard PRIMARY KEY(`reference_standard_id`)
) COMMENT 'Master record for certified reference standards and reagents used in laboratory testing and instrument calibration. Captures standard ID, standard name, CAS number, standard type (primary, secondary, working, certified reference material), supplier, lot number, purity/concentration, certificate number, receipt date, expiry date, storage condition, current stock quantity, reorder level, and traceability chain (NIST, ECHA, pharmacopoeia). Ensures measurement traceability per ISO/IEC 17025 and GMP requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`evidence_document` (
    `evidence_document_id` BIGINT COMMENT 'Primary key for evidence_document',
    `superseded_evidence_document_id` BIGINT COMMENT 'Self-referencing FK on evidence_document (superseded_evidence_document_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the document was formally approved.',
    `archive_date` DATE COMMENT 'Date on which the document was archived.',
    `archived` BOOLEAN COMMENT 'True if the document has been moved to archive storage.',
    `author_name` STRING COMMENT 'Name of the person who originally created the document.',
    `checksum` STRING COMMENT 'SHA‑256 checksum used to verify file integrity.',
    `confidentiality_level` STRING COMMENT 'Organizational classification of the documents sensitivity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the document record was first created in the system.',
    `evidence_document_description` STRING COMMENT 'Free‑form description providing context or summary of the document content.',
    `document_name` STRING COMMENT 'Human‑readable name of the evidence document.',
    `document_number` STRING COMMENT 'Business‑assigned unique code or number for the document, used in quality records and audits.',
    `document_type` STRING COMMENT 'Category of the evidence document, such as Certificate of Analysis (COA) or Test Report.',
    `effective_date` DATE COMMENT 'Date on which the document becomes effective for its intended use.',
    `expiration_date` DATE COMMENT 'Date after which the document is no longer valid or must be reviewed.',
    `file_path` STRING COMMENT 'Logical storage location or URI of the document in the lakehouse.',
    `file_size_bytes` BIGINT COMMENT 'Size of the stored document file in bytes.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the document contains confidential information.',
    `mime_type` STRING COMMENT 'Internet media type of the document file (e.g., application/pdf).',
    `related_process` STRING COMMENT 'Quality or manufacturing process to which the document is linked (e.g., Batch Release).',
    `retention_period_days` STRING COMMENT 'Number of days the document must be retained according to policy.',
    `reviewer_name` STRING COMMENT 'Name of the person who performed the most recent review of the document.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the document (e.g., LabWare LIMS).',
    `evidence_document_status` STRING COMMENT 'Current lifecycle state of the document within the quality system.',
    `tags` STRING COMMENT 'Comma‑separated list of user‑defined tags for ad‑hoc categorization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the document record.',
    `version_number` STRING COMMENT 'Version identifier of the document, incremented on each revision.',
    CONSTRAINT pk_evidence_document PRIMARY KEY(`evidence_document_id`)
) COMMENT 'Master reference table for evidence_document. Referenced by evidence_document_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`coa_template` (
    `coa_template_id` BIGINT COMMENT 'Primary key for coa_template',
    `superseded_coa_template_id` BIGINT COMMENT 'Self-referencing FK on coa_template (superseded_coa_template_id)',
    `applicable_product_line` STRING COMMENT 'Product line or family to which the template applies.',
    `approval_date` TIMESTAMP COMMENT 'Timestamp when the template was approved.',
    `approval_status` STRING COMMENT 'Current approval status of the template.',
    `approved_by` STRING COMMENT 'Name of the person who approved the template.',
    `author_name` STRING COMMENT 'Name of the employee who authored the template.',
    `change_control_number` STRING COMMENT 'Identifier of the change control request associated with the latest version.',
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
    `coa_template_status` STRING COMMENT 'Current lifecycle status of the template.',
    `template_code` STRING COMMENT 'Unique code used to reference the COA template across systems.',
    `template_name` STRING COMMENT 'Human‑readable name of the certificate of analysis template.',
    `template_type` STRING COMMENT 'Category of the template indicating what kind of item the COA applies to.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the template record.',
    `version_number` STRING COMMENT 'Version identifier of the template.',
    CONSTRAINT pk_coa_template PRIMARY KEY(`coa_template_id`)
) COMMENT 'Master reference table for coa_template. Referenced by coa_template_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`quality`.`spc_chart` (
    `spc_chart_id` BIGINT COMMENT 'Primary key for spc_chart',
    `employee_id` BIGINT COMMENT 'Identifier of the person or group responsible for the chart.',
    `parent_spc_chart_id` BIGINT COMMENT 'Self-referencing FK on spc_chart (parent_spc_chart_id)',
    `chart_category` STRING COMMENT 'High‑level classification of the charts focus area.',
    `chart_code` STRING COMMENT 'Business identifier or code assigned to the chart for quick lookup.',
    `chart_name` STRING COMMENT 'Human‑readable name of the SPC chart used in reports and dashboards.',
    `chart_type` STRING COMMENT 'Statistical method used for the chart (e.g., X‑Bar, R, S, P, NP, C).',
    `chart_version` STRING COMMENT 'Version identifier for the chart definition, supporting change management.',
    `control_limit_lower` DECIMAL(18,2) COMMENT 'Statistical lower control limit for the chart.',
    `control_limit_upper` DECIMAL(18,2) COMMENT 'Statistical upper control limit for the chart.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the chart record was first created in the system.',
    `data_points_count` STRING COMMENT 'Total number of data points currently stored for the chart.',
    `data_source` STRING COMMENT 'Origin of the data feeding the chart (e.g., LabWare LIMS, process sensor).',
    `spc_chart_description` STRING COMMENT 'Detailed description of the chart purpose, scope, and application.',
    `effective_from` DATE COMMENT 'Date when the chart becomes active for monitoring.',
    `effective_until` DATE COMMENT 'Date when the chart is retired or no longer used (null if open‑ended).',
    `frequency` STRING COMMENT 'How often new data points are collected for the chart.',
    `last_run_timestamp` TIMESTAMP COMMENT 'Date and time when the chart was most recently refreshed with new data.',
    `measurement_parameter` STRING COMMENT 'Name of the process variable or quality attribute being monitored (e.g., viscosity, impurity %).',
    `notes` STRING COMMENT 'Free‑form comments or observations about the chart.',
    `sample_size` STRING COMMENT 'Number of individual observations collected for each subgroup.',
    `spec_limit_lower` DECIMAL(18,2) COMMENT 'Minimum acceptable specification limit for the parameter.',
    `spec_limit_upper` DECIMAL(18,2) COMMENT 'Maximum acceptable specification limit for the parameter.',
    `spc_chart_status` STRING COMMENT 'Current lifecycle status of the chart definition.',
    `subgroup_size` STRING COMMENT 'Number of units in each subgroup used for control‑limit calculations.',
    `target_value` DECIMAL(18,2) COMMENT 'Desired nominal value or set point for the measured parameter.',
    `unit_of_measure` STRING COMMENT 'Standard unit for the measured parameter (e.g., kg, ppm, °C).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the chart record.',
    CONSTRAINT pk_spc_chart PRIMARY KEY(`spc_chart_id`)
) COMMENT 'Master reference table for spc_chart. Referenced by chart_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_spc_control_id` FOREIGN KEY (`spc_control_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`spc_control`(`spc_control_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ADD CONSTRAINT `fk_quality_test_method_reference_standard_id` FOREIGN KEY (`reference_standard_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`reference_standard`(`reference_standard_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ADD CONSTRAINT `fk_quality_inspection_characteristic_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`test_method`(`test_method_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`test_method`(`test_method_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_quality_specification_id` FOREIGN KEY (`quality_specification_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_specification`(`quality_specification_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_capa_related_quality_notification_quality_notification_quality_deviation_id` FOREIGN KEY (`capa_related_quality_notification_quality_notification_quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ADD CONSTRAINT `fk_quality_spc_control_spc_violation_id` FOREIGN KEY (`spc_violation_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`spc_violation`(`spc_violation_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ADD CONSTRAINT `fk_quality_spc_violation_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ADD CONSTRAINT `fk_quality_spc_violation_spc_chart_id` FOREIGN KEY (`spc_chart_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`spc_chart`(`spc_chart_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ADD CONSTRAINT `fk_quality_quality_specification_coa_template_id` FOREIGN KEY (`coa_template_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`coa_template`(`coa_template_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ADD CONSTRAINT `fk_quality_instrument_calibration_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ADD CONSTRAINT `fk_quality_stability_result_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`stability_study`(`stability_study_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_evidence_document_id` FOREIGN KEY (`evidence_document_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`evidence_document`(`evidence_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`evidence_document` ADD CONSTRAINT `fk_quality_evidence_document_superseded_evidence_document_id` FOREIGN KEY (`superseded_evidence_document_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`evidence_document`(`evidence_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ADD CONSTRAINT `fk_quality_coa_template_superseded_coa_template_id` FOREIGN KEY (`superseded_coa_template_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`coa_template`(`coa_template_id`);
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_parent_spc_chart_id` FOREIGN KEY (`parent_spc_chart_id`) REFERENCES `chemical_mfg_ecm`.`quality`.`spc_chart`(`spc_chart_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `chemical_mfg_ecm`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `coa_document_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'goods_receipt|production|periodic|customer_return');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `measurement_uom` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Specification Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `oot_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Trend Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `pass_fail_flag` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_lot` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `qc_result_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Result ID (QC_RESULT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Identifier (ANALYST_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Identifier (LOT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (INSTR_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Control Sample Identifier (CTRL_SAMPLE_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Identifier (QN_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier (SAMPLE_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `spc_control_id` SET TAGS ('dbx_business_glossary_term' = 'SPC Chart Identifier (SPC_CHART_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `characteristic_name` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Name (CHAR_NAME)');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `test_method_code` SET TAGS ('dbx_business_glossary_term' = 'Test Method Code (METHOD_CD)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp (TEST_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'mg/L|ppm|%|pH|°C');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`qc_result` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `reference_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validation By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`test_method` ALTER COLUMN `related_standard_codes` SET TAGS ('dbx_business_glossary_term' = 'Related Standard Codes');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `inspection_characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic ID');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `measurement_category` SET TAGS ('dbx_business_glossary_term' = 'Measurement Category');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `measurement_category` SET TAGS ('dbx_value_regex' = 'physical|chemical|biological|microbial');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `owner_department` SET TAGS ('dbx_value_regex' = 'quality|production|research|safety');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_value_regex' = 'EPA|OSHA|REACH|GHS|ISO9001|ISO14001');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `related_documentation` SET TAGS ('dbx_business_glossary_term' = 'Related Documentation');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Days)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `sampling_procedure` SET TAGS ('dbx_business_glossary_term' = 'Sampling Procedure');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `sampling_procedure` SET TAGS ('dbx_value_regex' = 'random|systematic|stratified|batch|continuous');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_characteristic` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (WERKS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `rejection_number` SET TAGS ('dbx_business_glossary_term' = 'Rejection Number (RN)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status (RS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `sample_size_code` SET TAGS ('dbx_business_glossary_term' = 'Sample Size Code (SSC)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `sample_size_code` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `sampling_scheme_type` SET TAGS ('dbx_business_glossary_term' = 'Sampling Scheme Type (SST)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `sampling_scheme_type` SET TAGS ('dbx_value_regex' = 'single|double|sequential');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `sampling_standard` SET TAGS ('dbx_business_glossary_term' = 'Sampling Standard (SS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `sampling_standard` SET TAGS ('dbx_value_regex' = 'ISO2859|MIL1916|CUSTOM');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `spec_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type (ST)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `spec_type` SET TAGS ('dbx_value_regex' = 'absolute|percentage|ratio');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `specification_lsl` SET TAGS ('dbx_business_glossary_term' = 'Specification Lower Specification Limit (LSL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `specification_usl` SET TAGS ('dbx_business_glossary_term' = 'Specification Upper Specification Limit (USL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value (TV)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context (UC)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`inspection_plan` ALTER COLUMN `usage_context` SET TAGS ('dbx_value_regex' = 'goods_receipt|in_process|final_release');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`sampling_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`usage_decision` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` SET TAGS ('dbx_subdomain' = 'quality_documentation');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Originator ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Notification Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'OOS|OOT|NCR|COMPLAINT|DEVIATION|CUSTOMER_COMPLAINT');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `quality_deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `quality_deviation_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `quality_deviation_status` SET TAGS ('dbx_value_regex' = 'open|in_process|resolved|closed|rejected');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `related_coa_number` SET TAGS ('dbx_business_glossary_term' = 'Related COA Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_deviation` ALTER COLUMN `related_coc_number` SET TAGS ('dbx_business_glossary_term' = 'Related COC Number');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` SET TAGS ('dbx_subdomain' = 'quality_documentation');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Initiator Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Related OOS Event Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `capa_related_quality_notification_quality_notification_quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Related Quality Notification Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `mrp_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Exception Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Owner Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`capa` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` SET TAGS ('dbx_subdomain' = 'quality_documentation');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `coc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Record ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CUSTOMER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'QA Signatory ID (QA_SIGN_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID (ORDER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet ID (SDS_ID)');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NO)');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference (SPEC_REF)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `total_test_count` SET TAGS ('dbx_business_glossary_term' = 'Total Test Count (TOTAL_TESTS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|lb|L|mL|ton');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coc_record` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Version (CERT_VER)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` SET TAGS ('dbx_subdomain' = 'quality_documentation');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `quality_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `inventory_target_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Target Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiator Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Ehs Incident Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `related_coa_number` SET TAGS ('dbx_business_glossary_term' = 'Related Certificate of Analysis Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `release_outcome` SET TAGS ('dbx_business_glossary_term' = 'Release Outcome');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `release_outcome` SET TAGS ('dbx_value_regex' = 'released|rejected|reprocessed|scrapped');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|l|g|ml|pcs');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `spc_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `spc_violation_id` SET TAGS ('dbx_business_glossary_term' = 'SPC Violation Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Characteristic Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `characteristic_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]+$');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_control` ALTER COLUMN `characteristic_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Characteristic Name');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `spc_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Violation Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `spc_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `batch_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Batch/Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `center_line` SET TAGS ('dbx_business_glossary_term' = 'Center Line (CL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `characteristic_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Characteristic Name');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `control_chart_type` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Violation Disposition');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'false_alarm|assignable_cause|process_adjusted');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `investigation_required` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'upper|lower|both');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `limit_value` SET TAGS ('dbx_business_glossary_term' = 'Breached Limit Value');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `root_cause_identified` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Identified Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `rule_number` SET TAGS ('dbx_business_glossary_term' = 'Western Electric Rule Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `spc_violation_status` SET TAGS ('dbx_business_glossary_term' = 'Violation Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `spc_violation_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_review');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_violation` ALTER COLUMN `violation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Violation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` SET TAGS ('dbx_subdomain' = 'quality_documentation');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `coa_template_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis Template ID (COA_TPL_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `formula_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Spec Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `material_master_id` SET TAGS ('dbx_internal' = 'true');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`quality_specification` ALTER COLUMN `grade` SET TAGS ('dbx_business_glossary_term' = 'Specification Grade (GRADE)');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sampler ID (SAMPLER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `lab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Experiment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'LabWare LIMS Sample ID (LABWARE_LIMS_SAMPLE_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `shipment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Status (CHAIN_OF_CUSTODY_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|broken');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date (DISPOSAL_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method (DISPOSAL_METHOD)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_sample` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'incineration|landfill|chemical_treatment|recycle|other');
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
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Instrument Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Performed By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `adjusted_value` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Calibration Value');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `calibration_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `calibration_history_count` SET TAGS ('dbx_business_glossary_term' = 'Calibration History Count');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `calibration_notes` SET TAGS ('dbx_business_glossary_term' = 'Calibration Notes');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `calibration_result` SET TAGS ('dbx_business_glossary_term' = 'Calibration Result');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `calibration_result` SET TAGS ('dbx_value_regex' = 'pass|fail|adjusted');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `calibration_standard` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'in_calibration|overdue|out_of_service');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `calibration_type` SET TAGS ('dbx_business_glossary_term' = 'Calibration Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `calibration_type` SET TAGS ('dbx_value_regex' = 'routine|after_repair|verification');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `gmp_compliant` SET TAGS ('dbx_business_glossary_term' = 'GMP Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'Instrument Name');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'HPLC|GC|ICP-MS|UV-Vis|Titrator|pH_Meter');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `iso17025_compliant` SET TAGS ('dbx_business_glossary_term' = 'ISO/IEC 17025 Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `lab_instrument_status` SET TAGS ('dbx_business_glossary_term' = 'Instrument Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `lab_instrument_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|maintenance');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Instrument Location');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `maintenance_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle (Days)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Instrument Manufacturer');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `part11_compliant` SET TAGS ('dbx_business_glossary_term' = '21 CFR Part 11 Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `performed_by` SET TAGS ('dbx_business_glossary_term' = 'Calibration Performed By');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `post_calibration_reading` SET TAGS ('dbx_business_glossary_term' = 'Post‑Calibration Reading');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `pre_calibration_reading` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Calibration Reading');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'IQ|OQ|PQ|Not_Qualified');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `qualified_by` SET TAGS ('dbx_business_glossary_term' = 'Qualified By');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `tolerance` SET TAGS ('dbx_business_glossary_term' = 'Calibration Tolerance');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`lab_instrument` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `instrument_calibration_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Calibration ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Performed By Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `adjusted_value` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Calibration Value');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `calibration_location` SET TAGS ('dbx_business_glossary_term' = 'Calibration Location');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `calibration_method` SET TAGS ('dbx_business_glossary_term' = 'Calibration Method');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `calibration_standard` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'completed|pending|failed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `calibration_type` SET TAGS ('dbx_business_glossary_term' = 'Calibration Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `calibration_type` SET TAGS ('dbx_value_regex' = 'routine|after_repair|verification|initial|requalification');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `gmp_compliant` SET TAGS ('dbx_business_glossary_term' = 'GMP Compliance Indicator');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `post_calibration_reading` SET TAGS ('dbx_business_glossary_term' = 'Post-Calibration Reading');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `pre_calibration_reading` SET TAGS ('dbx_business_glossary_term' = 'Pre-Calibration Reading');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Calibration Remarks');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Calibration Result');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `result` SET TAGS ('dbx_value_regex' = 'pass|fail|adjusted');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `standard_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Version');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `tolerance` SET TAGS ('dbx_business_glossary_term' = 'Calibration Tolerance');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`instrument_calibration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID (PRODUCT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID (ANALYST_ID)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date (ACTUAL_END_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `approved_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `batch_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Batch/Lot Number (LOT_NO)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Study Comments (COMMENTS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `degradation_trend_flag` SET TAGS ('dbx_business_glossary_term' = 'Degradation Trend Flag (DEGRADATION_TREND)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `labware_lims_study_ref` SET TAGS ('dbx_business_glossary_term' = 'LabWare LIMS Study Reference (LIMS_REF)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `light_exposure` SET TAGS ('dbx_business_glossary_term' = 'Light Exposure Condition (LIGHT_EXPOSURE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `light_exposure` SET TAGS ('dbx_value_regex' = 'none|ambient|controlled|UV');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification Flag (OOS_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `oot_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Trend Flag (OOT_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date (PLANNED_END_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (REG_REF)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `shelf_life_estimate_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Estimate (Months)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `shelf_life_units` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Units (SHELF_LIFE_UNIT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `shelf_life_units` SET TAGS ('dbx_value_regex' = 'months|years');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `stability_study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `stability_study_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date (START_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `storage_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Relative Humidity (%)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `study_number` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Number (STUDY_NO)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `study_protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Study Protocol Version (PROTOCOL_VER)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Type (STUDY_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'long_term|accelerated|stress|photostability');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_study` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number (VERSION_NO)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `stability_result_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Result Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `lab_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `characteristic_name` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Name');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'LabWare LIMS|SAP QM|Custom');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `degradation_trend_flag` SET TAGS ('dbx_business_glossary_term' = 'Degradation Trend Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity (%)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `labware_result_reference` SET TAGS ('dbx_business_glossary_term' = 'LabWare LIMS Result Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `measurement_method_code` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `measurement_method_description` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `oot_flag` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Trend Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `pass_fail_flag` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `pass_fail_flag` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `sample_weight` SET TAGS ('dbx_business_glossary_term' = 'Sample Weight');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `sample_weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Sample Weight Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Limit');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `stability_result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Record Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `stability_result_status` SET TAGS ('dbx_value_regex' = 'active|archived|deleted');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `time_point` SET TAGS ('dbx_business_glossary_term' = 'Stability Time Point');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `time_point` SET TAGS ('dbx_value_regex' = 'T0|T3M|T6M|T12M|T24M');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`stability_result` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Result Version Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` SET TAGS ('dbx_subdomain' = 'quality_documentation');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Lead Auditor Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Audit End Timestamp (AUDIT_ACT_END_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Audit Start Timestamp (AUDIT_ACT_START_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number (AUDIT_NO)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope (AUDIT_SCOPE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Lifecycle Status (AUDIT_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|in_progress|completed|closed');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AUDIT_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|external|supplier|customer|regulatory');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Closure Date (AUDIT_CLOSE_DT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Audit Confidentiality Level (AUDIT_CONF_LVL)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CA_DUE_DT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `corrective_action_owner` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner (CA_OWNER)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `corrective_action_owner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `corrective_action_owner` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (CA_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Record Created Timestamp (AUDIT_CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code (DEPT_CD)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Document Reference (DOC_REF)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Audit End Date (AUDIT_END_DT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `external_auditor` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name (EXT_AUDITOR)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `external_auditor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `external_auditor` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `findings_major` SET TAGS ('dbx_business_glossary_term' = 'Major Non‑Conformance Findings Count (FINDINGS_MAJOR)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `findings_minor` SET TAGS ('dbx_business_glossary_term' = 'Minor Non‑Conformance Findings Count (FINDINGS_MINOR)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `findings_observation` SET TAGS ('dbx_business_glossary_term' = 'Observation Findings Count (FINDINGS_OBS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `findings_ofi` SET TAGS ('dbx_business_glossary_term' = 'Opportunity for Improvement Findings Count (FINDINGS_OFI)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `findings_total` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count (FINDINGS_TOT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW_DT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `lead_auditor` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name (LEAD_AUDITOR)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `lead_auditor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `lead_auditor` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date (NEXT_REVIEW_DT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes (AUDIT_NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome (AUDIT_OUTCOME)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT_CD)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulation Reference (REG_REF)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REG_BODY)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category (RC_CATEGORY)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'process|material|equipment|method|management');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description (RC_DESC)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `standard` SET TAGS ('dbx_business_glossary_term' = 'Audit Standard (AUDIT_STD)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Audit Start Date (AUDIT_START_DT)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `team` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members (AUDIT_TEAM)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `team` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `team` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `type_detail` SET TAGS ('dbx_business_glossary_term' = 'Audit Type Detail (AUDIT_TYPE_DET)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Record Updated Timestamp (AUDIT_UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status (VERIF_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|not_verified|pending');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Audit Version (AUDIT_VER)');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` SET TAGS ('dbx_subdomain' = 'quality_documentation');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `evidence_document_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `tertiary_audit_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `tertiary_audit_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `tertiary_audit_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `affected_process` SET TAGS ('dbx_business_glossary_term' = 'Affected Process');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_source` SET TAGS ('dbx_business_glossary_term' = 'Finding Source');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_source` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|deferred');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Clause Reference');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'major_nc|minor_nc|observation|ofi');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `regulatory_clause` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Clause');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `response_description` SET TAGS ('dbx_business_glossary_term' = 'Response Description');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'material|method|machine|man|environment|management');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `reference_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard ID');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `concentration` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Concentration');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Hazard Classification');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'flammable|corrosive|toxic|oxidizer|environmental_hazard|none');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `is_gmp_compliant` SET TAGS ('dbx_business_glossary_term' = 'GMP Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `is_iso17025_compliant` SET TAGS ('dbx_business_glossary_term' = 'ISO/IEC 17025 Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `purity_percent` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Purity Percent');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Receipt Date');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `reference_standard_code` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Code');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `reference_standard_name` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Name');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `reference_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Status');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `reference_standard_status` SET TAGS ('dbx_value_regex' = 'active|retired|on_hold|pending');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `reference_standard_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Type');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `reference_standard_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|working|certified|reference_material|custom');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `reorder_level` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Reorder Level');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `safety_considerations` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Safety Considerations');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Stock Quantity');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `stock_uom` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Stock Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `stock_uom` SET TAGS ('dbx_value_regex' = 'kg|g|mg|l|ml|units');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Storage Condition');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'refrigerated|ambient|frozen|controlled|room_temp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `supplier` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Supplier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `traceability_source` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Traceability Source');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `traceability_source` SET TAGS ('dbx_value_regex' = 'NIST|ECHA|pharmacopoeia|internal|supplier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`reference_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`evidence_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`evidence_document` SET TAGS ('dbx_subdomain' = 'quality_documentation');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`evidence_document` ALTER COLUMN `evidence_document_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`evidence_document` ALTER COLUMN `superseded_evidence_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` SET TAGS ('dbx_subdomain' = 'quality_documentation');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ALTER COLUMN `coa_template_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Template Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ALTER COLUMN `superseded_coa_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`coa_template` ALTER COLUMN `author_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_chart` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_chart` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_chart` ALTER COLUMN `spc_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Chart Identifier');
ALTER TABLE `chemical_mfg_ecm`.`quality`.`spc_chart` ALTER COLUMN `parent_spc_chart_id` SET TAGS ('dbx_self_ref_fk' = 'true');
