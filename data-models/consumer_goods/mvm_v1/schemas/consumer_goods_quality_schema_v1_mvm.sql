-- Schema for Domain: quality | Business: Consumer Goods | Version: v1_mvm
-- Generated on: 2026-05-05 11:04:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `consumer_goods_ecm`.`quality` COMMENT 'Owns quality assurance, quality control, and GMP compliance data across the product lifecycle. Manages QC inspection results, non-conformance records, CAPA processes, batch release decisions, stability studies, certificate of analysis, GMP audit findings, supplier quality assessments, product complaints, and regulatory hold events. Integrates with SAP QM and Veeva Vault.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` (
    `inspection_plan_id` BIGINT COMMENT 'Unique identifier for the inspection plan. Primary key for the inspection plan master data entity.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Inspection plans are designed to fulfill specific regulatory compliance obligations (e.g., GMP testing mandates, pharmacopoeial requirements). QA managers link each plan to the obligation it satisfies',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection plans define resource requirements (sample_size, test_equipment_required, inspection_lead_time_days) budgeted against a cost center. Consumer goods quality finance planning requires linking',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: DC-specific Inspection Planning: inspection plans for inbound goods can be scoped to specific distribution centers with different AQL levels, sampling procedures, or regulatory requirements by market.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand Quality Assurance Plan links inspection plans to specific brand for compliance reporting and marketing claim validation.',
    `sku_id` BIGINT COMMENT 'Reference to the material (raw material, packaging component, intermediate, or finished good) that this inspection plan applies to.',
    `approval_date` DATE COMMENT 'Date on which this inspection plan was formally approved for use. Part of the plans audit trail and regulatory documentation.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether inspection results under this plan require formal approval by a quality manager or authorized person before batch release. Typically true for GMP-critical inspections.',
    `aql_level` DECIMAL(18,2) COMMENT 'Acceptable Quality Level expressed as a percentage. Maximum percent defective that is considered acceptable for the inspection plan. Used in acceptance sampling decisions.',
    `certificate_of_analysis_required_flag` BOOLEAN COMMENT 'Indicates whether a formal Certificate of Analysis document must be generated upon successful completion of inspections under this plan. Typically required for finished goods and customer-facing materials.',
    `change_control_number` STRING COMMENT 'Reference to the change control request or document that authorized the creation or last modification of this inspection plan. Required for GMP compliance and audit trail.. Valid values are `^CC-[0-9]{6,10}$`',
    `characteristic_count` STRING COMMENT 'Number of quality characteristics (test parameters) defined in this inspection plan. Each characteristic has its own specification limits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection plan record was first created in the source system. Part of the audit trail.',
    `effective_end_date` DATE COMMENT 'Date after which this inspection plan is no longer valid. Nullable for open-ended plans. Used for version control and regulatory compliance.',
    `effective_start_date` DATE COMMENT 'Date from which this inspection plan becomes valid and applicable for quality inspections. Part of the plans effective date range.',
    `gmp_critical_flag` BOOLEAN COMMENT 'Indicates whether this inspection plan covers GMP-critical quality attributes that directly impact product safety, efficacy, or regulatory compliance. GMP-critical inspections require enhanced documentation and cannot be skipped.',
    `inspection_lead_time_days` STRING COMMENT 'Expected number of calendar days required to complete all inspections and testing defined in this plan. Used for production scheduling and inventory planning.',
    `inspection_method` STRING COMMENT 'Primary method used to perform the inspection: manual measurement, automated testing, laboratory analysis, visual examination, destructive testing, or non-destructive testing.. Valid values are `manual|automated|laboratory|visual|destructive|non_destructive`',
    `inspection_severity` STRING COMMENT 'Severity level of inspection based on supplier quality history and risk assessment. Tightened inspection applies stricter acceptance criteria.. Valid values are `normal|tightened|reduced`',
    `inspection_stage` STRING COMMENT 'Production or supply chain stage at which this inspection is triggered. Aligns with GMP critical control points.. Valid values are `goods_receipt|production_start|production_end|pre_release|post_release`',
    `inspection_type` STRING COMMENT 'Type of quality inspection this plan governs: incoming (supplier materials), in-process (production intermediates), final (finished goods), stability (shelf-life studies), release (batch release), or periodic (routine surveillance).. Valid values are `incoming|in_process|final|stability|release|periodic`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this inspection plan record. Used for change tracking and data synchronization.',
    `material_type` STRING COMMENT 'Classification of the material subject to inspection. Determines applicable GMP requirements and inspection rigor.. Valid values are `raw_material|packaging_material|intermediate|finished_good|bulk_product`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this inspection plan. GMP requires regular review of quality procedures to ensure continued appropriateness.',
    `plan_code` STRING COMMENT 'Business identifier for the inspection plan, used across quality management systems and documentation. Externally visible code for referencing the plan in quality specifications and batch records.. Valid values are `^[A-Z0-9]{6,20}$`',
    `plan_description` STRING COMMENT 'Detailed description of the inspection plan including scope, objectives, and special instructions for quality control personnel.',
    `plan_name` STRING COMMENT 'Human-readable name of the inspection plan describing its purpose and scope.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the inspection plan. Only active plans are used for inspection lot creation.. Valid values are `draft|active|inactive|obsolete|under_review`',
    `regulatory_requirement` STRING COMMENT 'Reference to the regulatory requirement, standard, or guideline that mandates this inspection (e.g., FDA 21 CFR Part 211, EU GMP Annex 1, ISO 22716). Critical for compliance audits.',
    `responsible_inspector_role` STRING COMMENT 'Job role or qualification level required for personnel authorized to perform inspections under this plan (e.g., QC Technician, QC Analyst, QC Manager). Ensures competency requirements are met.',
    `revision_number` STRING COMMENT 'Sequential revision number of this inspection plan. Incremented each time the plan is updated. Part of change control and audit trail.',
    `sample_size` STRING COMMENT 'Number of sample units to be drawn per inspection lot. Determined by statistical sampling plan and AQL requirements.',
    `sample_unit` STRING COMMENT 'Unit of measure for the sample (e.g., pieces, kg, liters, containers). Defines what constitutes one sample unit.',
    `sampling_procedure_code` STRING COMMENT 'Code identifying the sampling procedure to be followed: sample size, sampling frequency, sampling method (random, systematic, stratified). References approved sampling SOP.. Valid values are `^[A-Z0-9]{4,12}$`',
    `skip_lot_allowed_flag` BOOLEAN COMMENT 'Indicates whether skip-lot inspection (reduced frequency based on consistent quality history) is permitted for this plan. Not allowed for GMP-critical inspections.',
    `source_system` STRING COMMENT 'Name of the operational system from which this inspection plan record originated (e.g., SAP QM, Veeva Vault). Used for data lineage and troubleshooting.',
    `source_system_code` STRING COMMENT 'Unique identifier of this inspection plan in the source operational system. Enables traceability back to the system of record.',
    `specification_version` STRING COMMENT 'Version number of the quality specification document that this inspection plan implements. Ensures traceability to approved specifications.. Valid values are `^V[0-9]{1,3}(.[0-9]{1,2})?$`',
    `test_equipment_required` STRING COMMENT 'List or description of test equipment, instruments, or laboratory apparatus required to execute this inspection plan. Ensures resource availability.',
    CONSTRAINT pk_inspection_plan PRIMARY KEY(`inspection_plan_id`)
) COMMENT 'Master data defining QC inspection plans and quality specifications for raw materials, in-process intermediates, packaging, and finished goods. Captures sampling procedures, inspection characteristics with specification limits (USL/LSL/target), acceptable quality levels (AQL), test methods, units of measure, effective date ranges, and GMP-mandated control points. Serves as the single authoritative source for what to test, how to sample, and what limits apply — governing all inspection lot execution and feeding CoA generation. Aligned with SAP QM inspection planning.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT 'Unique identifier for the inspection lot. Primary key for the inspection lot entity representing a discrete QC inspection event triggered by production batch, goods receipt, or periodic review.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Required for traceability: each inspection lot must be linked to the specific manufacturing batch record that produced the lot, enabling batch-level quality release decisions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost-of-quality reporting in consumer goods requires attributing inspection labor, sampling, and overhead costs to a cost center. Finance teams use inspection_lot cost center attribution for quality c',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Inbound Quality Inspection at DC: inspection lots are executed at specific distribution centers. DC-level quality performance reporting and GMP compliance audits require knowing which facility perform',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Goods receipt triggers inspection lot creation in standard QM/MM integration (SAP pattern). Traceability from inspection lot back to the specific GR document is required for stock posting, three-way m',
    `inbound_receipt_id` BIGINT COMMENT 'Foreign key linking to distribution.inbound_receipt. Business justification: Goods Receipt Quality Inspection: when inbound goods arrive at a DC, an inspection lot is created against that receipt. QA managers need to trace every inspection lot back to the triggering inbound re',
    `inspection_plan_id` BIGINT COMMENT 'Identifier of the inspection plan template applied to this lot. Defines the characteristics to be inspected, sampling procedures, and acceptance criteria.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Regulatory traceability report requires linking each inspection lot to its originating lot batch for audit trails.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Inspection lots are created per PO line item (specific material and quantity). Linking to po_line enables per-line quality tracking, rejection quantity reconciliation against ordered quantity, and sup',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Required for traceability: link each inspection lot to the purchase order that supplied the material, enabling regulatory compliance and release decisions.',
    `sku_id` BIGINT COMMENT 'Identifier of the material (raw material, semi-finished good, or finished good) being inspected in this lot.',
    `stock_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_movement. Business justification: Quality inspection results trigger stock movements (goods receipt posting, transfer to unrestricted, scrapping of rejected material). Standard SAP QM/MM integration in consumer goods: inspection_lot d',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Quality inspection blocks stock in the stock_position (quality_inspection_quantity, quarantine_flag). Linking inspection_lot to stock_position enables QC teams to manage blocked-stock transitions and ',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor for goods receipt inspection lots. Used for supplier quality performance tracking.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Incoming inspection lots must be traceable to the specific supplier manufacturing site for site-level quality performance tracking, audit scheduling, and regulatory compliance. Consumer goods companie',
    `certificate_of_analysis_number` STRING COMMENT 'Document number of the Certificate of Analysis issued for this inspection lot. Links to formal quality documentation in Veeva Vault.',
    `coa_issue_date` DATE COMMENT 'Date when the Certificate of Analysis was formally issued for this inspection lot.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection lot record was first created in the quality management system. Audit trail field.',
    `decision_date` DATE COMMENT 'Date when the formal usage decision was made and recorded in the quality management system.',
    `decision_timestamp` TIMESTAMP COMMENT 'Precise date and time when the usage decision was recorded. Used for audit trail and compliance reporting.',
    `defect_count` STRING COMMENT 'Total number of defects or non-conformances identified during inspection. Used for quality metrics and trend analysis.',
    `disposition_outcome` STRING COMMENT 'Final outcome status of the lot after disposition decision and stock posting. Confirms the actual inventory movement executed.. Valid values are `released|blocked|scrapped|returned|reworked`',
    `expiration_date` DATE COMMENT 'Expiration or best-before date assigned to the batch based on stability study results and shelf-life specifications.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the inspection lot was produced and inspected in compliance with Good Manufacturing Practice regulations.',
    `inspection_end_date` DATE COMMENT 'Date when all inspection and testing activities were completed for this lot.',
    `inspection_location` STRING COMMENT 'Physical location or quality lab where the inspection was performed. May be different from the plant code for centralized testing facilities.',
    `inspection_lot_number` STRING COMMENT 'Business identifier for the inspection lot. Externally visible alphanumeric code used in SAP QM and quality documentation for traceability and audit purposes.. Valid values are `^[A-Z0-9]{8,12}$`',
    `inspection_notes` STRING COMMENT 'Free-text field for inspector comments, observations, or special conditions noted during the inspection process.',
    `inspection_priority` STRING COMMENT 'Priority level assigned to the inspection lot. Determines the sequence and urgency of inspection execution in the quality lab.. Valid values are `urgent|high|normal|low`',
    `inspection_start_date` DATE COMMENT 'Date when the physical inspection and testing activities began for this lot.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection lot. Tracks progression from creation through inspection execution to final disposition decision.. Valid values are `created|released|in_progress|completed|cancelled`',
    `inspection_type` STRING COMMENT 'Classification of the inspection lot based on the triggering event. Determines the inspection plan template and sampling strategy applied.. Valid values are `goods_receipt|production_batch|periodic|in_process|final_release|stability`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection lot record was last updated. Tracks the most recent change for audit and compliance purposes.',
    `lot_origin_number` STRING COMMENT 'Document number of the originating transaction (production order number, purchase order number, delivery number, etc.) that triggered this inspection lot.',
    `lot_origin_type` STRING COMMENT 'Source document type that triggered the creation of this inspection lot. Links the quality inspection to the originating business transaction.. Valid values are `production_order|purchase_order|process_order|delivery|stock_transfer`',
    `lot_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material in the inspection lot. Represents the population from which samples are drawn for inspection.',
    `lot_quantity_uom` STRING COMMENT 'Unit of measure for the lot quantity (each, kilogram, liter, meter, etc.). Aligns with material master UOM. [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|BOX|CASE — 8 candidates stripped; promote to reference product]',
    `material_number` STRING COMMENT 'Business material code (SKU) of the product being inspected. Used for cross-reference and reporting.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code where the inspection is performed. Aligns with SAP plant master data.. Valid values are `^[A-Z0-9]{4}$`',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Indicates whether the lot is under regulatory hold pending additional review or approval from regulatory affairs or quality assurance.',
    `regulatory_hold_reason` STRING COMMENT 'Detailed explanation of why the lot is under regulatory hold. Documents the specific compliance or quality concern requiring additional review.',
    `retest_date` DATE COMMENT 'Date when the material must be re-inspected to confirm continued compliance with quality specifications. Applicable for raw materials and intermediates.',
    `sample_quantity` DECIMAL(18,2) COMMENT 'Quantity of material drawn as a sample for inspection testing. Determined by the inspection plan sampling procedure.',
    `sample_quantity_uom` STRING COMMENT 'Unit of measure for the sample quantity drawn for testing. [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|BOX|CASE — 8 candidates stripped; promote to reference product]',
    `stock_posting_instruction` STRING COMMENT 'Instruction for inventory movement based on the usage decision. Determines the target stock type for material posting in warehouse management.. Valid values are `release_to_unrestricted|move_to_blocked|move_to_quality|scrap|return`',
    `storage_location_code` STRING COMMENT 'Warehouse storage location code where the inspected material is held during quality inspection.',
    `usage_decision` STRING COMMENT 'Final disposition decision for the inspected lot. Determines whether material can be released for use, must be reworked, or should be rejected.. Valid values are `accepted|rejected|restricted_use|rework|scrap|return_to_vendor`',
    `usage_decision_code` STRING COMMENT 'Standardized code representing the usage decision. Used for automated stock posting and reporting in SAP QM.. Valid values are `^[A-Z0-9]{2,4}$`',
    CONSTRAINT pk_inspection_lot PRIMARY KEY(`inspection_lot_id`)
) COMMENT 'Transactional record of a QC inspection lot triggered by a production batch, goods receipt, or periodic review. Tracks lot origin (batch, purchase order, production order), inspection type, assigned inspection plan, lot quantity, inspection status, and complete disposition lifecycle including formal usage decision (accept/reject/restricted use/rework), decision maker, decision date, decision code, stock posting instruction, regulatory hold flag, and disposition outcome. Core operational entity in SAP QM representing the end-to-end inspection-to-disposition workflow.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`quality`.`inspection_result` (
    `inspection_result_id` BIGINT COMMENT 'Unique identifier for the inspection result record. Primary key for granular QC (Quality Control) measurement and test result records captured at the characteristic level within an inspection lot.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Inspection results for incoming goods must be directly traceable to the goods receipt document for GR-based quality holds, three-way match validation, and regulatory traceability. Quality teams refere',
    `inspection_lot_id` BIGINT COMMENT 'Reference to the parent inspection lot under which this characteristic-level result was captured. Links to the inspection lot entity that groups multiple inspection results for a batch or production run.',
    `sample_id` BIGINT COMMENT 'Unique identifier of the physical sample from which this measurement was taken. Enables traceability back to the specific sample unit within the inspection lot.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Link inspection_result to its governing specification for easy access to spec limits and versioning.',
    `approval_status` STRING COMMENT 'Approval status of this inspection result by a quality supervisor or manager. Pending indicates awaiting review; approved indicates result accepted; rejected indicates result invalidated and retest required.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection result was approved. Required for GMP audit trails and batch release decision traceability.',
    `coa_inclusion_flag` BOOLEAN COMMENT 'Flag indicating whether this result should be included in the Certificate of Analysis (COA) document for the batch. True indicates inclusion; false indicates internal-only result.',
    `control_chart_rule_violated` STRING COMMENT 'Description of the specific SPC control chart rule that was violated (e.g., point beyond control limit, 7 consecutive points above centerline, 2 of 3 points beyond 2-sigma). Populated when control_chart_violation_flag is true.',
    `control_chart_violation_flag` BOOLEAN COMMENT 'Flag indicating whether this measurement violates SPC (Statistical Process Control) control chart rules (e.g., out of control limits, run rules, trend rules). True indicates a violation requiring investigation.',
    `data_source_system` STRING COMMENT 'Identifier of the source system from which this inspection result was captured (e.g., SAP QM, LIMS, Veeva Vault, manual entry). Used for data lineage and audit purposes.',
    `defect_code` STRING COMMENT 'Standardized code classifying the type of defect or non-conformance observed when result_status is fail. Used for defect trending and root cause analysis.',
    `defect_severity` STRING COMMENT 'Classification of the severity of the non-conformance. Critical defects pose safety or regulatory risk; major defects affect functionality; minor defects are cosmetic or non-functional.. Valid values are `critical|major|minor`',
    `deviation_code` STRING COMMENT 'Reference to an approved deviation or waiver document that authorizes acceptance of a non-conforming result. Populated when result_status is waived.',
    `environmental_condition_humidity` DECIMAL(18,2) COMMENT 'Relative humidity (percentage) at the time of measurement. Critical for tests sensitive to moisture levels.',
    `environmental_condition_temperature` DECIMAL(18,2) COMMENT 'Ambient temperature (in degrees Celsius) at the time of measurement. Critical for tests sensitive to environmental conditions.',
    `inspection_characteristic_code` STRING COMMENT 'Unique code identifying the specific quality characteristic being measured (e.g., pH level, viscosity, weight, color, microbial count). Corresponds to the master inspection characteristic definition.',
    `inspection_characteristic_name` STRING COMMENT 'Human-readable name of the quality characteristic being tested (e.g., Product pH, Net Weight, Microbial Load, Color Consistency).',
    `inspection_method_code` STRING COMMENT 'Code identifying the standardized test method or procedure used to perform this measurement (e.g., ASTM method, USP method, internal SOP number).',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when this specific characteristic measurement was performed. Critical for time-sensitive tests and GMP audit trails.',
    `instrument_code` STRING COMMENT 'Unique identifier of the measurement instrument or equipment used to capture this result (e.g., balance ID, pH meter ID, spectrophotometer ID). Required for GMP (Good Manufacturing Practice) audit trails and instrument calibration traceability.',
    `laboratory_code` STRING COMMENT 'Identifier of the laboratory or testing facility where this measurement was performed. May be an internal QC lab or an external contract lab.',
    `lower_specification_limit` DECIMAL(18,2) COMMENT 'The minimum acceptable value for this characteristic as defined in the product specification or quality standard. Values below this threshold indicate non-conformance.',
    `measured_value` DECIMAL(18,2) COMMENT 'The actual quantitative measurement or test result value recorded during inspection. For qualitative characteristics, this may be encoded numerically or stored as a code.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Quantified estimate of the uncertainty or error margin associated with the measured value. Required for ISO 17025 compliance and advanced SPC (Statistical Process Control) analysis.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection result record was first created in the system. Audit trail field for data governance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection result record was last modified. Audit trail field for data governance and change tracking.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Flag indicating whether this result must be reported to regulatory authorities (e.g., FDA, EPA) due to non-conformance or safety concerns. True indicates reportable event.',
    `remarks` STRING COMMENT 'Free-text comments or observations recorded by the inspector regarding this measurement. May include notes on sample condition, procedural deviations, or contextual information.',
    `result_status` STRING COMMENT 'Pass/fail status of this individual characteristic measurement. Pass indicates the measured value is within specification limits; fail indicates non-conformance; conditional indicates acceptance with restrictions; pending indicates awaiting review; waived indicates non-conformance accepted by authorized deviation.. Valid values are `pass|fail|conditional|pending|waived`',
    `retest_indicator` BOOLEAN COMMENT 'Flag indicating whether this result is a retest of a previously failed or inconclusive measurement. True indicates this is a retest; false indicates initial test.',
    `retest_reason_code` STRING COMMENT 'Code indicating the reason for retesting this characteristic. Applicable only when retest_indicator is true.. Valid values are `initial_failure|inconclusive|instrument_error|sample_contamination|procedural_deviation|other`',
    `sample_sequence_number` STRING COMMENT 'Sequential number of this sample within the inspection lot (e.g., 1, 2, 3). Used to track sampling order and support statistical sampling plans.',
    `target_value` DECIMAL(18,2) COMMENT 'The ideal or nominal value for this characteristic. Used for process capability analysis and SPC (Statistical Process Control) charting.',
    `test_batch_number` STRING COMMENT 'Batch or run number of the test reagents or consumables used during this measurement. Required for traceability in regulated environments.',
    `unit_of_measure` STRING COMMENT 'The unit in which the measured value is expressed (e.g., grams, milliliters, pH units, CFU/g for colony forming units per gram, percentage).',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'The maximum acceptable value for this characteristic as defined in the product specification or quality standard. Values above this threshold indicate non-conformance.',
    CONSTRAINT pk_inspection_result PRIMARY KEY(`inspection_result_id`)
) COMMENT 'Granular QC measurement and test result records captured at the characteristic level within an inspection lot. Stores measured values, upper/lower specification limits, pass/fail status, instrument used, inspector ID, and timestamp. Supports SPC (Statistical Process Control) and GMP audit trails per ISO 9001 and GMP requirements.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`quality`.`usage_decision` (
    `usage_decision_id` BIGINT COMMENT 'Unique identifier for the quality control usage decision record. Primary key.',
    `capa_id` BIGINT COMMENT 'Reference to the CAPA record initiated as a result of this usage decision, if applicable. Null if no CAPA was required.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Usage decisions (accept/reject/rework) directly drive financial postings: rejections trigger inventory write-offs, rework triggers cost postings. Consumer goods finance requires cost center attributio',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: DC-level Disposition Management: usage decisions (accept/reject/rework) made at distribution facilities must reference the DC for inventory disposition execution and WMS stock posting. plant_code is a',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Usage decision (accept/reject/rework) is executed against a specific goods receipt document to trigger stock posting and GR reversal. Standard SAP QM workflow: usage decision references the GR to upda',
    `inbound_receipt_id` BIGINT COMMENT 'Foreign key linking to distribution.inbound_receipt. Business justification: Inbound Disposition Reporting: usage decisions made after inspecting inbound receipts at DCs must reference the receipt for end-to-end inbound quality disposition tracking. Supplier scorecards and rec',
    `inspection_lot_id` BIGINT COMMENT 'Reference to the inspection lot for which this usage decision was made. Links to the QC inspection lot that was evaluated.',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Usage decisions (accept/reject/rework) directly drive logistics actions — return-to-vendor shipments, destruction movements, or release-for-distribution. Linking usage_decision to logistics_shipment e',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Usage decision rejection quantities must reconcile against the specific PO line to update outstanding/invoiced quantities and trigger accounts payable deductions. Procurement teams require this link f',
    `sku_id` BIGINT COMMENT 'Reference to the material or product that was inspected and for which the usage decision applies.',
    `stock_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_movement. Business justification: Usage decision posts a stock movement (material document) in ERP — accepted stock to unrestricted, rejected to scrap/returns. Consumer goods QM standard: usage_decision.stock_posting_instruction resol',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Usage decision (accept/reject/rework) directly drives stock posting to unrestricted, blocked, or scrap stock positions. This is the core QM-to-MM integration in consumer goods ERP; the link enables au',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who provided the material, if applicable. Used for supplier quality management and vendor scorecarding.',
    `approval_date` DATE COMMENT 'The date when the usage decision was formally approved by authorized quality management personnel. Null if no approval was required.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this usage decision requires additional management or quality assurance approval before batch release. True=Approval required, False=No additional approval needed.',
    `batch_number` STRING COMMENT 'The production batch or lot number to which this usage decision applies. Critical for traceability and recall management.',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether this usage decision triggers a CAPA process due to significant non-conformance. True=CAPA required, False=No CAPA needed. Links to continuous improvement.',
    `certificate_of_analysis_number` STRING COMMENT 'Reference number of the Certificate of Analysis document that supports this usage decision. Links to detailed test results and specifications.',
    `comments` STRING COMMENT 'Additional free-text comments or notes related to the usage decision. May include special handling instructions, escalation notes, or contextual information.',
    `decision_code` STRING COMMENT 'The formal quality control usage decision code. A=Accept (Unrestricted Use), R=Reject, Q=Quality Hold, S=Restricted Use (Sample/Scrap), X=Rework Required. Drives downstream inventory disposition.. Valid values are `A|R|Q|S|X`',
    `decision_date` DATE COMMENT 'The calendar date on which the usage decision was formally made and recorded. Critical for compliance timelines and batch release tracking.',
    `decision_maker_name` STRING COMMENT 'Full name of the quality control inspector or authorized personnel who made the usage decision. Captured for audit and traceability purposes.',
    `decision_text` STRING COMMENT 'Detailed textual description or rationale for the usage decision. Captures the quality assessors reasoning and any special conditions or instructions.',
    `decision_timestamp` TIMESTAMP COMMENT 'The precise date and time when the usage decision was recorded in the system. Provides audit trail precision for regulatory compliance.',
    `defect_code` STRING COMMENT 'Standardized code identifying the primary defect or non-conformance that led to rejection or restricted use decision. Used for root cause analysis and trend reporting.',
    `defect_description` STRING COMMENT 'Detailed description of the defect, non-conformance, or quality issue identified during inspection. Supports CAPA and continuous improvement processes.',
    `disposition_date` DATE COMMENT 'The date when the material disposition action was completed (e.g., stock posted to unrestricted, blocked, or scrapped). Null if disposition is still pending.',
    `disposition_status` STRING COMMENT 'Current status of the material disposition action following the usage decision. pending=Decision made but stock not yet moved, completed=Stock posting completed, cancelled=Decision reversed or voided.. Valid values are `pending|completed|cancelled`',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the batch meets Good Manufacturing Practice requirements. True=GMP compliant, False=Non-compliant. Required for pharmaceutical and cosmetic products.',
    `inspection_type` STRING COMMENT 'The type of quality inspection that led to this usage decision. goods_receipt=incoming material inspection, in_process=during production, final=finished goods, stability=shelf-life testing, complaint=customer complaint investigation.. Valid values are `goods_receipt|in_process|final|stability|complaint`',
    `plant_code` STRING COMMENT 'The manufacturing plant or facility code where the inspection and usage decision were performed. Critical for multi-site quality management.',
    `quantity_accepted` DECIMAL(18,2) COMMENT 'The quantity of material accepted for unrestricted use based on the usage decision. Measured in the materials base unit of measure.',
    `quantity_rejected` DECIMAL(18,2) COMMENT 'The quantity of material rejected and not suitable for use. Measured in the materials base unit of measure. May trigger disposal or return to supplier.',
    `quantity_rework` DECIMAL(18,2) COMMENT 'The quantity of material designated for rework or reprocessing to meet quality standards. Measured in the materials base unit of measure.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this usage decision record was first created in the lakehouse. Part of the audit trail for data governance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this usage decision record was last updated in the lakehouse. Tracks data freshness and change history.',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Indicates whether the material is under regulatory hold and cannot be released for distribution. True=Hold in effect, False=No regulatory hold. Critical for FDA and EPA compliance.',
    `regulatory_hold_reason` STRING COMMENT 'Detailed explanation of why the material is under regulatory hold. May reference specific test failures, compliance issues, or pending regulatory approvals.',
    `sampling_procedure` STRING COMMENT 'The sampling method or procedure used during the inspection (e.g., random sampling, statistical sampling, 100% inspection). Ensures inspection validity.',
    `source_system` STRING COMMENT 'The operational system from which this usage decision record originated (e.g., SAP QM, Veeva Vault, Siemens Opcenter MES). Used for data lineage and integration tracking.',
    `source_system_code` STRING COMMENT 'The unique identifier of this usage decision record in the source operational system. Enables traceability back to the system of record.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantities in this usage decision (e.g., EA=Each, KG=Kilogram, L=Liter, CS=Case). Aligns with material master UOM.',
    CONSTRAINT pk_usage_decision PRIMARY KEY(`usage_decision_id`)
) COMMENT 'Records the formal QC usage decision made at the conclusion of an inspection lot — accept, reject, restricted use, or rework. Captures decision code, decision maker, decision date, stock posting instruction, and regulatory hold flag. Drives downstream batch release and inventory disposition in SAP QM/MM.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`quality`.`nonconformance` (
    `nonconformance_id` BIGINT COMMENT 'Unique identifier for the nonconformance record. Primary key for the nonconformance data product.',
    `capa_id` BIGINT COMMENT 'Foreign key reference to the CAPA record created to address the root cause of this nonconformance. Links to capa_record for tracking corrective and preventive actions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost of quality report allocates nonconformance financial impact to responsible cost center for internal cost tracking.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Distribution Nonconformance Reporting: nonconformances detected during DC receiving, storage, or picking must reference the originating facility. DC quality scorecards and regulatory deviation reports',
    `distribution_shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_shipment. Business justification: Transit Damage Nonconformance: goods damaged or temperature-compromised during shipment generate nonconformances linked to the specific distribution shipment. Carrier liability claims, insurance repor',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Nonconformances detected at incoming inspection are raised against the specific goods receipt document. This link is required for supplier debit memo processing, GR reversal workflows, and regulatory ',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A nonconformance is frequently triggered by or directly linked to a failed inspection lot. This FK normalizes the relationship between the quality event record and the inspection lot that surfaced the',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Non‑conformance investigations must reference the specific lot batch to drive root‑cause analysis and recall actions.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_brand. Business justification: Brand managers in consumer goods must track nonconformance events by brand for brand crisis management, brand-level quality KPI dashboards, and regulatory reporting. A contamination or defect event on',
    `outbound_order_id` BIGINT COMMENT 'Foreign key linking to distribution.outbound_order. Business justification: Outbound Fulfillment Nonconformance: nonconformances detected during pick/pack operations (e.g., damaged goods, wrong lot picked) must reference the outbound order. Order-level quality defect tracking',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Nonconformances on incoming materials must reference the PO line to enable contract penalty clause enforcement, supplier debit memo generation, and procurement reporting on defect rates by purchased m',
    `product_complaint_id` BIGINT COMMENT 'Foreign key reference to the customer complaint record that triggered this nonconformance, when applicable. Links to consumer complaint tracking system.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Nonconformances detected at retail (shelf damage, temperature excursion, mislabeling) must reference the specific store for field quality investigations and corrective actions. Retail field quality n',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Non‑conformance events are tied to the SKU that caused the issue, enabling targeted CAPA and impact analysis.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Regulatory-reportable nonconformances (regulatory_reportable_flag exists on nonconformance) require formal regulatory submissions. Linking the nonconformance to its regulatory submission supports mand',
    `supplier_id` BIGINT COMMENT 'Foreign key reference to the supplier associated with this nonconformance, applicable when the issue originates from supplier-provided materials or components. Links to supplier master data.',
    `usage_decision_id` BIGINT COMMENT 'Foreign key linking to quality.usage_decision. Business justification: A nonconformance is often initiated as a direct consequence of a reject or conditional usage decision. Linking nonconformance.usage_decision_id → usage_decision.usage_decision_id establishes the forma',
    `affected_quantity` DECIMAL(18,2) COMMENT 'Quantity of product units or material affected by the nonconformance. Used for containment scope and financial impact assessment.',
    `affected_quantity_uom` STRING COMMENT 'Unit of measure for the affected quantity: EA (each/units), KG (kilograms), L (liters), M (meters), BOX (boxes), PALLET (pallets).. Valid values are `EA|KG|L|M|BOX|PALLET`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the nonconformance was formally closed after verification of corrective actions and effectiveness checks. Null if still open.',
    `containment_action` STRING COMMENT 'Immediate containment actions taken to prevent further occurrence or distribution of nonconforming product. Describes short-term corrective measures implemented before root cause analysis.',
    `containment_timestamp` TIMESTAMP COMMENT 'Date and time when containment actions were completed and verified effective. Critical for regulatory reporting and OTIF compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this nonconformance record was first created in the lakehouse silver layer. Audit trail for data governance.',
    `defect_classification` STRING COMMENT 'Technical classification of the defect type: appearance (cosmetic defect), functionality (performance issue), safety (consumer safety risk), labeling (incorrect or missing label information), packaging (packaging integrity issue), contamination (foreign material or microbial contamination), specification_failure (out-of-specification test result), or process_deviation (manufacturing process non-conformance). [ENUM-REF-CANDIDATE: appearance|functionality|safety|labeling|packaging|contamination|specification_failure|process_deviation — 8 candidates stripped; promote to reference product]',
    `defect_description` STRING COMMENT 'Detailed narrative description of the nonconformance, including observed symptoms, affected characteristics, and initial assessment. Captures the what, where, and when of the quality event.',
    `detected_timestamp` TIMESTAMP COMMENT 'Date and time when the nonconformance was first detected or observed. Represents the real-world event time of quality issue identification.',
    `detection_source` STRING COMMENT 'Origin point where the nonconformance was first identified: QC inspection (quality control laboratory testing), manufacturing line (in-process detection), supplier receipt (incoming material inspection), customer complaint (consumer-reported issue), regulatory audit (FDA or regulatory body inspection), internal audit (GMP self-audit), or stability study (long-term product stability testing). [ENUM-REF-CANDIDATE: qc_inspection|manufacturing_line|supplier_receipt|customer_complaint|regulatory_audit|internal_audit|stability_study — 7 candidates stripped; promote to reference product]',
    `disposition_approved_by` STRING COMMENT 'User identifier of the quality authority who approved the disposition decision. Links to workforce/employee master data for audit trail and GMP compliance.. Valid values are `^[A-Z0-9]{6,20}$`',
    `disposition_approved_timestamp` TIMESTAMP COMMENT 'Date and time when the disposition decision was formally approved by quality authority. Critical for GMP audit trail and batch release decisions.',
    `disposition_decision` STRING COMMENT 'Final disposition decision for the nonconforming product or material: use_as_is (approved for use despite nonconformance), rework (reprocess to meet specifications), scrap (destroy), return_to_supplier (send back to vendor), downgrade (sell as lower grade), or quarantine (hold pending further investigation).. Valid values are `use_as_is|rework|scrap|return_to_supplier|downgrade|quarantine`',
    `event_type` STRING COMMENT 'Classification of the quality event: complaint (customer-reported issue), defect (internal manufacturing defect), deviation (process deviation from standard), improvement request (continuous improvement opportunity), supplier issue (supplier quality problem), or audit finding (GMP audit observation).. Valid values are `complaint|defect|deviation|improvement_request|supplier_issue|audit_finding`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the nonconformance, including costs of rework, scrap, containment, investigation, customer credits, and potential recall costs. Expressed in base currency.',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `nonconformance_status` STRING COMMENT 'Current lifecycle status of the nonconformance record: open (newly created), in_investigation (root cause analysis underway), containment_active (immediate containment actions in progress), capa_assigned (corrective and preventive action assigned), closed (resolved and verified), or cancelled (invalidated).. Valid values are `open|in_investigation|containment_active|capa_assigned|closed|cancelled`',
    `notification_number` STRING COMMENT 'External business identifier for the quality notification or nonconformance event. Corresponds to SAP QM notification number or Veeva Vault quality event identifier.. Valid values are `^[A-Z0-9]{8,20}$`',
    `priority` STRING COMMENT 'Business priority for resolution based on operational impact, customer visibility, and regulatory risk. Urgent: immediate action required; High: expedited resolution needed; Medium: standard timeline; Low: routine handling.. Valid values are `urgent|high|medium|low`',
    `regulatory_report_date` DATE COMMENT 'Date when the nonconformance was reported to regulatory authorities, if applicable. Null if not reportable or not yet reported.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Boolean indicator whether this nonconformance requires reporting to regulatory authorities (FDA, EPA, CPSC) based on severity, product category, and regulatory requirements. True indicates mandatory regulatory notification.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the nonconformance was formally logged into the quality management system (SAP QM or Veeva Vault). May differ from detection timestamp due to reporting lag.',
    `responsible_department` STRING COMMENT 'Functional department responsible for investigating and resolving the nonconformance (e.g., Quality Assurance, Manufacturing, Supply Chain, R&D).',
    `responsible_plant_code` STRING COMMENT 'Manufacturing plant or facility code where the nonconformance originated or is being managed. Links to distribution_facility for organizational accountability.. Valid values are `^[A-Z0-9]{4,10}$`',
    `root_cause_analysis` STRING COMMENT 'Detailed findings from root cause investigation, including methodology used (5-Why, Fishbone, Fault Tree Analysis) and identified root causes. Supports CAPA development.',
    `severity` STRING COMMENT 'Severity classification of the quality event based on impact to product safety, efficacy, and regulatory compliance. Critical: immediate risk to consumer safety or regulatory violation; Major: significant quality impact requiring containment; Minor: low impact quality issue.. Valid values are `critical|major|minor`',
    `source_system` STRING COMMENT 'Originating system of record for this nonconformance: SAP_QM (SAP Quality Management module), VEEVA_VAULT (Veeva Vault Quality), or MANUAL_ENTRY (direct data entry).. Valid values are `SAP_QM|VEEVA_VAULT|MANUAL_ENTRY`',
    `source_system_code` STRING COMMENT 'Unique identifier of this nonconformance record in the source system (SAP QM notification number or Veeva Vault quality event ID). Enables traceability back to operational system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this nonconformance record was last modified in the lakehouse silver layer. Audit trail for data governance and change tracking.',
    `verification_method` STRING COMMENT 'Method used to verify effectiveness of corrective actions and confirm the nonconformance has been resolved (e.g., re-inspection, re-testing, process validation, trend analysis).',
    CONSTRAINT pk_nonconformance PRIMARY KEY(`nonconformance_id`)
) COMMENT 'Unified quality event record for non-conformances, deviations, quality notifications, and improvement requests identified during manufacturing, QC inspection, supplier receipt, or customer complaint escalation. Captures event type (complaint, defect, deviation, improvement request), defect description, defect classification, affected batch/SKU, detection source, severity, priority, containment actions, task assignments, responsible plant, and linkage to CAPA. Serves as the single routing point for all quality events across SAP QM notifications and Veeva Vault workflows. Aligns with ISO 9001:2015 clause 10.2 and GMP deviation reporting requirements.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`quality`.`capa` (
    `capa_id` BIGINT COMMENT 'Unique identifier for the CAPA record. Primary key.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: CAPA actions are often initiated to meet specific compliance obligations; linking ties corrective actions to the obligation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAPA cost impact must be charged to a cost center for budgeting and expense analysis.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Distribution CAPA Management: CAPAs initiated for DC-level issues (temperature excursions, handling damage patterns, storage violations) must reference the responsible distribution facility. DC qualit',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: CAPAs in consumer goods are routinely initiated from logistics events — cold chain breaches, repeated OTIF failures, or in-transit damage patterns. Linking capa to logistics_shipment enables carrier p',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: CAPA Impact Report tracks corrective actions affecting brand reputation, used by marketing for risk communication and messaging.',
    `sku_id` BIGINT COMMENT 'Identifier of the product affected by or related to this CAPA. Links to the product master data.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: CAPAs with regulatory_reportable_flag require formal regulatory submissions (e.g., field safety corrective action reports, deviation notifications to authorities). Linking CAPA to its regulatory submi',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: CAPA actions often stem from supplier contract obligations; linking ensures contract compliance tracking and auditability of corrective measures.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier associated with the CAPA, if the issue originated from supplier-provided materials or services.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: CAPAs raised from supplier quality failures must be traceable to the specific supplier site where the issue originated. Site-level CAPA tracking is required for supplier audit management, re-qualifica',
    `actual_completion_date` DATE COMMENT 'The actual date when all CAPA actions were completed and verified, prior to formal closure.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number associated with the CAPA, if applicable. Used to trace quality issues to specific production runs.',
    `capa_description` STRING COMMENT 'Detailed description of the nonconformance, audit finding, complaint, or stability failure that triggered the CAPA.',
    `capa_number` STRING COMMENT 'Business-facing unique identifier for the CAPA record, typically formatted as CAPA-NNNNNN. Used for external communication and audit trails.. Valid values are `^CAPA-[0-9]{6,10}$`',
    `capa_status` STRING COMMENT 'Current lifecycle status of the CAPA record, tracking progression from initiation through closure. [ENUM-REF-CANDIDATE: open|investigation|action_plan|implementation|verification|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `capa_type` STRING COMMENT 'Classification of the CAPA as corrective (addressing existing nonconformance), preventive (preventing potential nonconformance), or combined (both corrective and preventive actions).. Valid values are `corrective|preventive|combined`',
    `closure_comments` STRING COMMENT 'Final comments or notes recorded at the time of CAPA closure, summarizing outcomes and lessons learned.',
    `closure_date` DATE COMMENT 'The date when the CAPA was formally closed after successful completion and verification of all actions.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action(s) taken to address the existing nonconformance and eliminate its cause.',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial cost impact of the CAPA issue, including costs of investigation, rework, scrap, recall, or other remediation activities.',
    `cost_impact_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost impact amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPA record was first created in the quality management system.',
    `customer_impact_flag` BOOLEAN COMMENT 'Indicates whether the CAPA issue had a direct impact on customers, such as product quality defects, delivery delays, or safety concerns.',
    `effectiveness_verification_method` STRING COMMENT 'The method or approach used to verify that the corrective and preventive actions were effective in resolving the issue and preventing recurrence (e.g., follow-up audit, process monitoring, trend analysis).',
    `effectiveness_verification_result` STRING COMMENT 'The outcome of the effectiveness verification, indicating whether the CAPA actions successfully resolved the issue and prevented recurrence.. Valid values are `effective|ineffective|pending`',
    `gmp_deviation_flag` BOOLEAN COMMENT 'Indicates whether the CAPA issue involved a deviation from Good Manufacturing Practice (GMP) standards.',
    `initiated_date` DATE COMMENT 'The date when the CAPA record was formally initiated and opened in the quality management system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPA record was last updated or modified.',
    `preventive_action_description` STRING COMMENT 'Detailed description of the preventive action(s) implemented to prevent recurrence of the issue or occurrence of similar issues.',
    `priority` STRING COMMENT 'Priority level assigned to the CAPA for resource allocation and scheduling purposes.. Valid values are `high|medium|low`',
    `process_area` STRING COMMENT 'The specific process, department, or functional area where the issue occurred (e.g., Manufacturing, Packaging, Quality Control, Supply Chain).',
    `regulatory_report_date` DATE COMMENT 'The date when the CAPA issue was reported to the relevant regulatory authority, if applicable.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this CAPA issue is required to be reported to regulatory authorities such as FDA, EPA, or other governing bodies.',
    `responsible_department` STRING COMMENT 'The department or functional area responsible for implementing the CAPA actions.',
    `root_cause_analysis_method` STRING COMMENT 'The methodology used to identify the root cause of the issue, such as 5 Whys, Fishbone Diagram, Fault Tree Analysis, Pareto Analysis, or Failure Mode and Effects Analysis (FMEA).. Valid values are `5_whys|fishbone|fault_tree|pareto|failure_mode_effects_analysis|other`',
    `root_cause_description` STRING COMMENT 'Detailed description of the identified root cause(s) of the nonconformance or issue.',
    `severity` STRING COMMENT 'Severity classification of the CAPA issue based on impact to product quality, safety, regulatory compliance, or business operations.. Valid values are `critical|major|minor`',
    `source_type` STRING COMMENT 'The origin or trigger event that initiated the CAPA, such as nonconformance, audit finding, customer complaint, supplier quality issue, stability study failure, or regulatory inspection finding.. Valid values are `nonconformance|audit_finding|customer_complaint|supplier_issue|stability_failure|regulatory_inspection`',
    `target_completion_date` DATE COMMENT 'The planned or target date by which all CAPA actions should be completed and verified.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the CAPA issue or focus area.',
    `verification_date` DATE COMMENT 'The date when the effectiveness verification was completed.',
    CONSTRAINT pk_capa PRIMARY KEY(`capa_id`)
) COMMENT 'Corrective and Preventive Action (CAPA) records initiated in response to nonconformances, audit findings, complaints, or stability failures. Tracks root cause analysis method, corrective actions, preventive actions, responsible owner, target completion dates, effectiveness verification, and closure status. Managed in Veeva Vault QMS.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`quality`.`batch_release` (
    `batch_release_id` BIGINT COMMENT 'Unique identifier for the batch release decision record. Primary key for the batch release entity.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Batch release decisions are based on the manufacturing batch record; linking ensures release status reflects the underlying production data and supports regulatory audit trails.',
    `certificate_of_analysis_id` BIGINT COMMENT 'Foreign key linking to quality.certificate_of_analysis. Business justification: Link batch_release to the Certificate of Analysis that documents the released batch, removing redundant reference number.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Batch Release by Distribution Center: in consumer goods, batch release authorization can be scoped to specific DCs for market-specific regulatory compliance. Qualified Person sign-off and regulatory m',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: For purchased/contract-manufactured materials, batch release is triggered after goods receipt and quality inspection. Linking batch_release to goods_receipt enables GMP traceability from release decis',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A batch release decision is formally linked to the QC inspection lot that validated the batch. batch_release currently has sap_qm_inspection_lot (STRING) which is a denormalized string reference to th',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Batch release decisions rely on the exact lot batch record to confirm quality release status and regulatory compliance.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: GMP batch release requires a Qualified Person to certify a batch against the products regulatory registration for the target market. product_registration_number and regulatory_market on batch_rel',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Batch release reports require linking each release to the specific SKU for traceability, regulatory filing, and inventory reconciliation.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: QP-signed batch release moves stock from quality-hold to unrestricted in the stock_position. Consumer goods regulatory requirement: released_quantity and release_decision must be traceable to the spec',
    `audit_trail_reference` STRING COMMENT 'Reference to the complete audit trail log for all actions and approvals related to this batch release. Required for 21 CFR Part 11 compliance.. Valid values are `^AUDIT-[A-Z0-9]{8,20}$`',
    `batch_size_quantity` DECIMAL(18,2) COMMENT 'Total quantity of finished goods produced in this batch. Used for yield calculation and inventory planning.',
    `batch_size_uom` STRING COMMENT 'Unit of measure for the batch size quantity (e.g., kilograms, liters, units). Aligns with GS1 standards for trade item measurement. [ENUM-REF-CANDIDATE: kg|lbs|liters|gallons|units|cases|pallets — 7 candidates stripped; promote to reference product]',
    `capa_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a CAPA investigation is required based on deviations or non-conformances identified during batch production or testing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch release record was first created in the system. Part of audit trail for regulatory compliance.',
    `deviation_count` STRING COMMENT 'Number of manufacturing or quality deviations recorded during the production and testing of this batch. Used for quality trend analysis.',
    `expiry_date` DATE COMMENT 'Date after which the batch should not be sold or used. Calculated from production date plus shelf life. Critical for FEFO inventory management and regulatory compliance.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the batch was manufactured in full compliance with GMP requirements. False indicates deviation or non-conformance.',
    `hold_initiated_date` DATE COMMENT 'Date when the regulatory or business hold was placed on the batch. Nullable if no hold exists.',
    `hold_reason` STRING COMMENT 'Detailed explanation of why the batch is on hold, if applicable. Includes regulatory citation, investigation reference, or customer complaint number.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch release record was last updated. Tracks changes to release status, hold status, or other critical fields.',
    `manufacturing_site_code` STRING COMMENT 'Code identifying the manufacturing facility or plant where the batch was produced. Used for site-level quality tracking and regulatory reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `production_date` DATE COMMENT 'Date when the batch manufacturing was completed. Critical for shelf-life calculation and FEFO inventory management.',
    `qc_inspection_status` STRING COMMENT 'Overall status of QC inspection and testing for this batch. Summarizes results from multiple QC test records.. Valid values are `passed|failed|conditional_pass|pending|waived`',
    `qp_signature_timestamp` TIMESTAMP COMMENT 'Timestamp when the Qualified Person electronically signed the batch release decision. Part of 21 CFR Part 11 electronic signature compliance.',
    `qualified_person_name` STRING COMMENT 'Full name of the Qualified Person who signed off on the batch release. Required for regulatory audit trail.',
    `regulatory_hold_status` STRING COMMENT 'Indicates if the batch is under any regulatory or business hold that prevents distribution. Holds may be imposed by FDA, EPA, internal quality, customer complaint, or recall investigation.. Valid values are `no_hold|fda_hold|epa_hold|internal_hold|customer_hold|recall_hold`',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of the batch that was rejected and marked for destruction or rework. Part of quality yield tracking.',
    `release_date` DATE COMMENT 'Date when the batch was officially released for distribution and sale. Marks the point at which product becomes available to promise (ATP).',
    `release_decision` STRING COMMENT 'Final disposition decision for the batch: released for distribution, rejected for destruction, quarantine for further testing, conditional release with restrictions, pending review, or on hold pending investigation. Critical GMP control point.. Valid values are `released|rejected|quarantine|conditional_release|pending_review|on_hold`',
    `release_notes` STRING COMMENT 'Free-text notes and comments from the Qualified Person regarding the release decision. May include justification for conditional release or special handling instructions.',
    `release_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the batch release decision was recorded in the system. Used for audit trail and regulatory compliance.',
    `released_quantity` DECIMAL(18,2) COMMENT 'Quantity of the batch that was approved for release and distribution. May be less than batch size if partial rejection occurred.',
    `retest_date` DATE COMMENT 'Date when the batch must be retested to confirm continued quality and stability. Common for raw materials and intermediates.',
    `stability_study_reference` STRING COMMENT 'Reference number linking to the stability study protocol and results that support the assigned shelf life and expiry date for this batch.. Valid values are `^STAB-[A-Z0-9]{8,20}$`',
    `veeva_vault_document_reference` STRING COMMENT 'Document identifier in Veeva Vault system linking to the official batch release record and supporting quality documents. Integrates with Veeva Vault QMS.. Valid values are `^VV-[A-Z0-9]{10,20}$`',
    CONSTRAINT pk_batch_release PRIMARY KEY(`batch_release_id`)
) COMMENT 'Formal batch release decision records authorizing finished goods batches for distribution and sale. Captures batch number, product SKU, release decision (released, rejected, quarantine), QP (Qualified Person) sign-off, release date, certificate of analysis reference, and regulatory hold status. Critical GMP control point per FDA 21 CFR and EU GMP.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` (
    `certificate_of_analysis_id` BIGINT COMMENT 'Unique identifier for the certificate of analysis record. Primary key.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: CoA accompanies each goods receipt; the GR has certificate_of_analysis_received_flag confirming CoA was received. Linking CoA to GR enables three-way match (PO+GR+CoA) for GMP batch release and regula',
    `inbound_receipt_id` BIGINT COMMENT 'Foreign key linking to distribution.inbound_receipt. Business justification: Inbound COA Verification: COAs are received with inbound goods at DCs and must be verified against the receipt. Supplier quality management and GMP inbound inspection processes require linking the COA',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A Certificate of Analysis is issued based on the test results from a specific inspection lot. inspection_lot currently has certificate_of_analysis_number (STRING) as a denormalized reference, but the ',
    `lot_batch_id` BIGINT COMMENT 'Reference to the lot or batch for which this certificate of analysis was issued. Links to the specific production batch of finished goods or raw materials.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: A CoA is issued for a specific material quantity delivered on a PO line. This link enables direct CoA-to-PO-line traceability for supplier audits, regulatory submissions, and quality specification com',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: COA must reference the supplier of the batch for traceability and regulatory compliance; supplier_name is replaced by FK.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the certificate was officially approved by the authorized signatory. Represents the moment of quality release decision.',
    `authorized_signatory_name` STRING COMMENT 'Full name of the quality assurance professional authorized to approve and sign this certificate. Must have appropriate delegation of authority.',
    `authorized_signatory_title` STRING COMMENT 'Job title or role of the authorized signatory (e.g., QA Manager, Quality Director, Laboratory Supervisor).',
    `batch_number` STRING COMMENT 'The manufacturing batch or lot number for the material being certified. Critical for traceability and recall management.. Valid values are `^[A-Z0-9]{6,20}$`',
    `batch_size` DECIMAL(18,2) COMMENT 'Total quantity produced in the manufacturing batch. Used to assess sample representativeness and for statistical quality control.',
    `batch_size_uom` STRING COMMENT 'Unit of measure for the batch size. Typically matches the materials production UOM.. Valid values are `kg|g|L|mL|units|cases`',
    `certificate_number` STRING COMMENT 'Externally-known unique certificate number assigned to this CoA document. Used for customer communication and regulatory submissions.. Valid values are `^COA-[A-Z0-9]{8,20}$`',
    `certificate_type` STRING COMMENT 'Classification of the certificate based on the material type being certified. Determines applicable test parameters and regulatory requirements.. Valid values are `finished_goods|raw_material|intermediate|packaging_material`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this certificate record was first created in the system. Audit trail for record lifecycle.',
    `customer_facing_flag` BOOLEAN COMMENT 'Indicates whether this certificate is intended for external distribution to trade customers or is for internal use only. True if customer-facing.',
    `document_url` STRING COMMENT 'URL or file path to the digitally signed PDF or scanned image of the certificate stored in Veeva Vault or document management system.. Valid values are `^https?://.*`',
    `expiry_date` DATE COMMENT 'The date after which the material should not be used or sold. Based on stability studies and regulatory requirements.',
    `gmp_compliant_flag` BOOLEAN COMMENT 'Indicates whether the batch and testing process were conducted under GMP conditions. True if GMP-compliant.',
    `issue_date` DATE COMMENT 'The date on which this certificate of analysis was officially issued and authorized for distribution to customers or regulatory bodies.',
    `manufacturing_date` DATE COMMENT 'The date on which the batch was manufactured or produced. Used for shelf-life calculations and FEFO inventory management.',
    `manufacturing_site_code` STRING COMMENT 'Code identifying the manufacturing facility or plant where the batch was produced. Critical for site-specific compliance and traceability.. Valid values are `^SITE-[A-Z0-9]{4,10}$`',
    `manufacturing_site_name` STRING COMMENT 'Full name and location of the manufacturing site. Supports multi-site operations and regulatory site registration requirements.',
    `material_code` STRING COMMENT 'The product or material code (SKU, item number, or raw material identifier) for which this certificate was issued. Links to master product or material data.. Valid values are `^[A-Z0-9]{6,20}$`',
    `material_description` STRING COMMENT 'Full textual description of the material or product covered by this certificate. Includes product name, variant, and key characteristics.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this certificate record was last modified. Supports change tracking and audit compliance.',
    `overall_result_status` STRING COMMENT 'Aggregate pass/fail status for all test parameters on this certificate. Determines batch release decision and customer distribution eligibility.. Valid values are `pass|fail|conditional_pass|pending_review`',
    `quantity_tested` DECIMAL(18,2) COMMENT 'The quantity of material sampled and tested for this certificate. Expressed in the materials base unit of measure.',
    `quantity_tested_uom` STRING COMMENT 'Unit of measure for the quantity tested (e.g., kilograms, liters, units). Aligns with material master UOM.. Valid values are `kg|g|L|mL|units|cases`',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this certificate is required for regulatory submissions or compliance filings with FDA, EPA, or other governing bodies. True if required for submission.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special conditions related to the testing or batch. May include deviations or special handling instructions.',
    `retest_date` DATE COMMENT 'The date by which the material should be retested to confirm continued conformance to specifications. Applicable primarily to raw materials.',
    `specification_version` STRING COMMENT 'Version number of the product specification or quality standard used for testing. Ensures traceability to the correct specification limits.. Valid values are `^V[0-9]{1,3}.[0-9]{1,3}$`',
    `storage_condition` STRING COMMENT 'Recommended storage conditions for the material (e.g., store in cool dry place, refrigerate at 2-8°C, protect from light). Based on stability data.',
    `supplier_lot_number` STRING COMMENT 'The lot or batch number assigned by the supplier for raw materials or packaging materials. Used for supplier quality traceability.',
    `test_date` DATE COMMENT 'The date on which quality control testing was performed for this certificate. May differ from manufacturing date for retained samples.',
    `test_method_reference` STRING COMMENT 'Reference to the analytical test methods used (e.g., USP, ASTM, internal method codes). May be a comma-separated list for multiple methods.',
    `veeva_vault_document_reference` STRING COMMENT 'Unique document identifier in Veeva Vault system where the certificate is stored. Enables integration with regulatory document management.. Valid values are `^[A-Z0-9]{10,30}$`',
    CONSTRAINT pk_certificate_of_analysis PRIMARY KEY(`certificate_of_analysis_id`)
) COMMENT 'Certificate of Analysis (CoA) documents issued per finished goods or raw material batch. Stores test parameters, specification limits, actual results, pass/fail status, issuing lab, authorized signatory, issue date, and customer-facing distribution flag. Supports trade customer requirements and regulatory submissions. Managed in Veeva Vault.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`quality`.`product_complaint` (
    `product_complaint_id` BIGINT COMMENT 'Unique identifier for the product complaint record. Primary key.',
    `consumer_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.consumer_offer. Business justification: Complaints arising from a specific consumer offer (coupon misredemption, BOGO defect, rebate product quality issue) must be linked to the offer for offer-level complaint rate tracking, regulatory repo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Financial impact of product complaints is allocated to a cost center for cost‑of‑quality reporting.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Distribution-linked Complaint Investigation: product complaints traced to DC storage or handling issues (temperature abuse, damage) require referencing the responsible distribution facility. DC qualit',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Consumer goods companies track complaint rates during promotional windows as a standard KPI. Complaints about promoted products (damaged promo packs, counterfeit during promo period, wrong price) must',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to sales.invoice. Business justification: A product complaint investigation requires the original invoice to confirm purchase date, price, and billing details for credit/refund processing and regulatory case documentation. Complaint-to-invoi',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Customer complaints must be tied to the exact lot batch to assess impact, trigger investigations, and manage recalls.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand Complaint Dashboard requires linking complaints to the brand to monitor reputation and adjust campaigns.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: Product complaints are filed against specific registered products in specific markets. Post-market surveillance reporting requires linking complaints to the products regulatory registration to identi',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to customer.retail_store. Business justification: Store‑level complaint tracking required for quality investigations and performance dashboards; linking complaints to the retail store where purchase occurred is standard in consumer‑goods.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: A product complaint must trace back to the originating sales order to establish purchase date, batch, and channel. Complaint-to-order traceability is a regulatory requirement (FDA, EU MDR) and stand',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to consumer.shopper. Business justification: Complaint handling process requires linking each product complaint to the shopper who reported it for traceability and regulatory reporting.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Complaints are investigated per SKU; linking enables root‑cause analysis, corrective actions, and compliance reporting.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Regulatory-reportable product complaints (adverse events, safety incidents) require formal regulatory submissions (FDA MedWatch, EU RAPEX). regulatory_agency and regulatory_case_number on product_',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Complaints must be tied to the responsible supplier for performance monitoring and regulatory reporting.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retail or trade account where the product was purchased, if applicable.',
    `complainant_address` STRING COMMENT 'Mailing address of the complainant for correspondence and product sample return.',
    `complainant_country_code` STRING COMMENT 'Three-letter ISO country code of the complainant location.. Valid values are `^[A-Z]{3}$`',
    `complainant_email` STRING COMMENT 'Email address of the complainant for follow-up communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `complainant_name` STRING COMMENT 'Full name of the individual or organization filing the complaint.',
    `complainant_phone` STRING COMMENT 'Contact phone number of the complainant.',
    `complaint_category` STRING COMMENT 'Primary classification of the complaint type based on the nature of the quality issue reported.. Valid values are `foreign_body|contamination|labeling_error|efficacy_failure|packaging_defect|adverse_reaction`',
    `complaint_description` STRING COMMENT 'Detailed narrative description of the complaint as reported by the complainant, including symptoms, observations, and circumstances.',
    `complaint_number` STRING COMMENT 'Externally-visible unique complaint reference number used for tracking and communication with consumers and regulatory bodies.. Valid values are `^CPL-[0-9]{8}$`',
    `complaint_received_timestamp` TIMESTAMP COMMENT 'Date and time when the complaint was first received by the organization.',
    `complaint_source` STRING COMMENT 'Origin channel through which the complaint was received.. Valid values are `consumer_direct|retailer|distributor|regulatory_agency|social_media|call_center`',
    `complaint_status` STRING COMMENT 'Current lifecycle state of the complaint investigation and resolution process.. Valid values are `open|under_investigation|pending_lab_analysis|resolved|closed|escalated`',
    `complaint_subcategory` STRING COMMENT 'Detailed sub-classification providing additional granularity to the complaint category.',
    `corrective_action` STRING COMMENT 'Description of corrective actions taken to address the immediate complaint.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the complaint record was first created in the system.',
    `expiry_date` DATE COMMENT 'Product expiration or best-before date printed on the package.',
    `gtin` STRING COMMENT 'Global Trade Item Number uniquely identifying the product in the supply chain.. Valid values are `^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$`',
    `incident_date` DATE COMMENT 'Date when the consumer or customer experienced the quality issue or adverse event.',
    `investigation_completion_date` DATE COMMENT 'Date when the investigation was concluded and findings documented.',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation of the complaint was initiated.',
    `investigation_status` STRING COMMENT 'Current state of the internal quality investigation process.. Valid values are `not_started|in_progress|lab_testing|pending_capa|completed`',
    `lab_analysis_result` STRING COMMENT 'Summary of laboratory test results conducted on the returned product sample.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the complaint record was last updated.',
    `manufacturing_date` DATE COMMENT 'Date when the product batch was manufactured.',
    `preventive_action` STRING COMMENT 'Description of preventive actions implemented to prevent recurrence of similar issues.',
    `purchase_date` DATE COMMENT 'Date when the complainant purchased the product.',
    `regulatory_report_date` DATE COMMENT 'Date when the complaint was reported to the relevant regulatory authority.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this complaint must be reported to regulatory authorities such as FDA, EPA, or CPSC.',
    `resolution_date` DATE COMMENT 'Date when the complaint was resolved and closed.',
    `resolution_outcome` STRING COMMENT 'Final outcome or action taken to resolve the complaint with the complainant.. Valid values are `refund_issued|replacement_sent|no_action_required|product_recall|investigation_ongoing`',
    `root_cause` STRING COMMENT 'Identified root cause of the quality issue based on investigation findings.',
    `sample_received_date` DATE COMMENT 'Date when the returned product sample was received by the quality assurance team.',
    `sample_returned_flag` BOOLEAN COMMENT 'Indicates whether the complainant returned a physical product sample for laboratory analysis.',
    `severity_level` STRING COMMENT 'Risk classification indicating the potential impact to consumer safety and business reputation.. Valid values are `critical|high|medium|low`',
    CONSTRAINT pk_product_complaint PRIMARY KEY(`product_complaint_id`)
) COMMENT 'Consumer and trade customer product complaint records capturing post-market quality issues. Stores complaint source (consumer, retailer, regulatory), product SKU, batch number, complaint category (foreign body, contamination, labeling, efficacy), severity, investigation status, regulatory reportability flag, and resolution outcome. Integrates with Salesforce Consumer Goods Cloud and Veeva Vault.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`quality`.`specification` (
    `specification_id` BIGINT COMMENT 'Unique identifier for the quality specification record. Primary key for this entity.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Each quality specification must satisfy a compliance obligation; linking ensures traceability to the governing regulation.',
    `inspection_plan_id` BIGINT COMMENT 'Reference to the SAP QM inspection plan that uses this specification. Links specification to operational quality control procedures.',
    `sku_id` BIGINT COMMENT 'Reference to the material or product this specification applies to. Links to the master material record in SAP MM.',
    `specification_sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Quality specifications are defined per SKU to ensure manufacturing compliance and product release criteria.',
    `superseded_by_specification_id` BIGINT COMMENT 'Reference to the newer specification that replaces this one when status is superseded. Maintains specification version lineage.',
    `approval_date` DATE COMMENT 'Date when this specification was formally approved for use. Part of the specification lifecycle audit trail.',
    `coa_inclusion_flag` BOOLEAN COMMENT 'Indicates whether test results for this specification must be included on the Certificate of Analysis provided to customers. Drives CoA generation logic.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this specification record was first created in the system. Part of the audit trail for compliance and traceability.',
    `critical_quality_attribute_flag` BOOLEAN COMMENT 'Indicates whether this characteristic is a Critical Quality Attribute that directly impacts product safety, efficacy, or regulatory compliance. CQAs require enhanced controls and documentation.',
    `customer_requirement_flag` BOOLEAN COMMENT 'Indicates whether this specification is driven by specific customer contractual requirements rather than internal or regulatory standards.',
    `effective_end_date` DATE COMMENT 'The date after which this specification is no longer valid. Null indicates an open-ended specification. Used for specification versioning and supersession.',
    `effective_start_date` DATE COMMENT 'The date from which this specification becomes valid and must be used for quality control testing. Supports time-based specification management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this specification record was last updated. Tracks change history for audit and compliance purposes.',
    `lower_specification_limit` DECIMAL(18,2) COMMENT 'The minimum acceptable value for the test characteristic. Results below this limit indicate non-conformance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this specification. Used for compliance tracking and specification maintenance planning.',
    `notes` STRING COMMENT 'Additional context, special instructions, or clarifications related to this specification. May include testing conditions, sample preparation requirements, or interpretation guidance.',
    `review_frequency_months` STRING COMMENT 'How often this specification must be reviewed and revalidated, expressed in months. Ensures specifications remain current and appropriate.',
    `sampling_plan` STRING COMMENT 'Description of the sampling methodology and sample size requirements for this test (e.g., AQL 2.5, n=10, ANSI/ASQ Z1.4). Ensures statistical validity of test results.',
    `source_system` STRING COMMENT 'The operational system from which this specification record originated (e.g., SAP QM, Veeva Vault, PLM system). Used for data lineage and integration troubleshooting.',
    `specification_category` STRING COMMENT 'High-level classification of the type of quality attribute being specified. Groups related test characteristics for reporting and analysis.. Valid values are `physical|chemical|microbiological|sensory|functional|safety`',
    `specification_number` STRING COMMENT 'Business identifier for the quality specification, used for external reference and documentation. Unique across the organization.. Valid values are `^[A-Z0-9]{6,20}$`',
    `specification_status` STRING COMMENT 'Current lifecycle status of the specification. Only active specifications are used for quality control and Certificate of Analysis (CoA) generation.. Valid values are `draft|under_review|approved|active|superseded|obsolete`',
    `specification_type` STRING COMMENT 'Classification of the specification based on the material or product stage it applies to. Determines the applicable quality control procedures.. Valid values are `raw_material|packaging_material|in_process|finished_good|intermediate|bulk`',
    `stability_indicating_flag` BOOLEAN COMMENT 'Indicates whether this test characteristic is used in stability studies to monitor product degradation over time. Critical for shelf-life determination.',
    `target_value` DECIMAL(18,2) COMMENT 'The ideal or nominal value for the test characteristic. Represents the center point of the acceptable range.',
    `test_characteristic` STRING COMMENT 'The specific quality attribute or property being measured or tested (e.g., pH, viscosity, color, weight, purity, microbial count). Defines what is being inspected.',
    `test_equipment_required` STRING COMMENT 'Description of specialized equipment or instrumentation needed to perform this test (e.g., HPLC, spectrophotometer, viscometer). Supports resource planning and capability assessment.',
    `test_frequency` STRING COMMENT 'How often this test characteristic must be measured during production or quality control. Drives inspection plan scheduling. [ENUM-REF-CANDIDATE: per_batch|per_lot|hourly|daily|weekly|monthly|on_demand — 7 candidates stripped; promote to reference product]',
    `test_method_reference` STRING COMMENT 'Reference to the standard test method or procedure used to measure the characteristic (e.g., ASTM D1475, USP 621, internal SOP number). Ensures consistent testing methodology.',
    `unit_of_measure` STRING COMMENT 'The unit in which the test characteristic is measured (e.g., mg/L, %, pH units, cP, CFU/g). Critical for interpreting specification limits.',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'The maximum acceptable value for the test characteristic. Results above this limit indicate non-conformance.',
    `veeva_vault_document_reference` STRING COMMENT 'Reference to the controlled document in Veeva Vault that contains the full specification details and supporting documentation. Ensures document control and regulatory compliance.',
    `version` STRING COMMENT 'Version number of the specification to track revisions and changes over time. Follows major.minor versioning convention.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    CONSTRAINT pk_specification PRIMARY KEY(`specification_id`)
) COMMENT 'Master data defining quality specifications for raw materials, packaging, in-process intermediates, and finished goods. Stores specification type, test characteristic, unit of measure, target value, upper/lower specification limits (USL/LSL), test method reference, and effective date range. Serves as the authoritative specification repository linked to inspection plans and CoA generation.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`quality`.`notification` (
    `notification_id` BIGINT COMMENT 'Unique identifier for the quality notification record. Primary key.',
    `capa_id` BIGINT COMMENT 'Reference identifier linking this quality notification to a formal CAPA record for corrective and preventive actions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality notification financial impact is allocated to a cost center for expense reporting.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Distribution Quality Notification: quality notifications for DC issues (temperature deviations, handling damage, storage violations) must reference the facility. plant_name is a denormalized DC name t',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Quality notifications for incoming goods defects are raised against the specific goods receipt document. This link enables automated GR hold, supplier notification workflows, and debit memo processing',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: SAP QM quality notifications are frequently created in direct response to inspection lot failures. notification currently has no structured FK to inspection_lot despite being the formal routing mechan',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Connects quality notifications triggered by shipment issues (e.g., temperature breach) to the specific shipment for corrective actions.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_brand. Business justification: Quality notifications (holds, deviations, regulatory alerts) in consumer goods are routed to brand managers by brand. Brand-level notification tracking supports brand risk management, campaign pause d',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: SAP QM notifications serve as the formal routing and workflow mechanism for nonconformances. A notification is raised to document and route a nonconformance through the quality system. notification cu',
    `product_complaint_id` BIGINT COMMENT 'Reference identifier linking this quality notification to an originating customer complaint record, if applicable.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Quality notifications flagged as regulatory-reportable (regulatory_reportable_flag, regulatory_report_date, regulatory_authority on notification) are linked to formal regulatory submissions. This FK p',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier associated with the quality issue, used when the notification relates to supplier quality performance.',
    `affected_quantity` DECIMAL(18,2) COMMENT 'Quantity of material or product units affected by the quality issue.',
    `affected_quantity_uom` STRING COMMENT 'Unit of measure for the affected quantity (e.g., EA for each, KG for kilograms, L for liters).. Valid values are `^[A-Z]{2,3}$`',
    `assigned_to_name` STRING COMMENT 'Full name of the person assigned to handle this quality notification.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number of the affected material, enabling traceability and containment actions.. Valid values are `^[A-Z0-9]{6,20}$`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the quality notification was formally closed after all actions were completed and verified.',
    `containment_action` STRING COMMENT 'Immediate containment actions taken to prevent further impact or spread of the quality issue while root cause investigation is underway.',
    `containment_timestamp` TIMESTAMP COMMENT 'Date and time when containment actions were implemented.',
    `created_date` DATE COMMENT 'Date when the quality notification was initially created in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality notification record was first created in the lakehouse, representing the audit trail for data lineage.',
    `defect_class` STRING COMMENT 'Severity classification of the defect based on its impact on product safety, functionality, and regulatory compliance.. Valid values are `critical|major|minor|cosmetic`',
    `defect_code` STRING COMMENT 'Standardized code classifying the type of defect or quality issue for categorization and trend analysis.. Valid values are `^[A-Z0-9]{2,10}$`',
    `detected_timestamp` TIMESTAMP COMMENT 'Date and time when the quality issue was first detected or observed, which may differ from when it was formally reported.',
    `detection_source` STRING COMMENT 'Origin or source where the quality issue was first identified or detected. [ENUM-REF-CANDIDATE: customer|production|inspection|audit|supplier|warehouse|field — 7 candidates stripped; promote to reference product]',
    `disposition_approved_by` STRING COMMENT 'Name or identifier of the quality authority who approved the material disposition decision.',
    `disposition_approved_timestamp` TIMESTAMP COMMENT 'Date and time when the disposition decision was formally approved.',
    `disposition_decision` STRING COMMENT 'Final disposition decision for the affected material or product: use as-is, rework, scrap, return to supplier, or downgrade to alternate use.. Valid values are `use_as_is|rework|scrap|return_to_supplier|downgrade`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the quality issue including costs of rework, scrap, customer credits, and remediation.',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality notification record was most recently updated in the lakehouse, supporting change tracking and audit requirements.',
    `material_code` STRING COMMENT 'SAP material master code identifying the product or raw material affected by this quality notification.. Valid values are `^[A-Z0-9]{6,18}$`',
    `material_description` STRING COMMENT 'Human-readable description of the material or product affected by the quality issue.',
    `notification_description` STRING COMMENT 'Detailed textual description of the quality issue, defect, or improvement opportunity documented in this notification.',
    `notification_number` STRING COMMENT 'Business identifier for the quality notification, externally visible and used for tracking and reference across systems.. Valid values are `^[A-Z0-9]{10,20}$`',
    `notification_status` STRING COMMENT 'Current lifecycle status of the quality notification indicating its position in the resolution workflow.. Valid values are `open|in_progress|pending_approval|closed|cancelled`',
    `notification_type` STRING COMMENT 'Classification of the quality notification indicating the nature of the issue: customer complaint, internal defect, improvement request, process deviation, audit finding, or supplier quality issue.. Valid values are `complaint|defect|improvement|deviation|audit_finding|supplier_issue`',
    `plant_code` STRING COMMENT 'SAP plant code identifying the manufacturing facility or distribution center responsible for addressing this quality notification.. Valid values are `^[A-Z0-9]{4,10}$`',
    `priority` STRING COMMENT 'Business priority level assigned to the notification based on severity, impact, and urgency of resolution required.. Valid values are `critical|high|medium|low`',
    `regulatory_report_date` DATE COMMENT 'Date when the quality issue was formally reported to the relevant regulatory authority.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this quality notification must be reported to regulatory authorities such as FDA, EPA, or CPSC.',
    `reported_timestamp` TIMESTAMP COMMENT 'Precise date and time when the quality issue was formally reported, representing the principal business event timestamp for this notification.',
    `responsible_department` STRING COMMENT 'Department or functional area responsible for investigating and resolving the quality notification.',
    `root_cause_analysis` STRING COMMENT 'Detailed findings from root cause analysis investigation documenting the underlying cause of the quality issue.',
    `source_system` STRING COMMENT 'Identifier of the source system from which this quality notification record originated (e.g., SAP_QM, VEEVA_VAULT).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `source_system_code` STRING COMMENT 'Unique identifier of this quality notification record in the source system, used for traceability and reconciliation.',
    `veeva_vault_document_reference` STRING COMMENT 'Reference identifier linking this quality notification to supporting documentation stored in Veeva Vault quality document management system.. Valid values are `^[A-Z0-9]{10,30}$`',
    `verification_method` STRING COMMENT 'Method or approach used to verify that corrective actions were effective and the quality issue was resolved.',
    CONSTRAINT pk_notification PRIMARY KEY(`notification_id`)
) COMMENT 'SAP QM quality notification records used to formally document and route quality defects, deviations, and improvement requests within the organization. Captures notification type (complaint, defect, improvement), priority, affected material/batch, responsible plant, task assignments, and closure details. Native SAP QM entity.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`quality`.`sample` (
    `sample_id` BIGINT COMMENT 'Primary key for sample',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: DC Sample Collection: samples collected at distribution facilities (environmental monitoring, inbound goods sampling, stability samples) must reference the DC. location_code is a plain text field; str',
    `inbound_receipt_id` BIGINT COMMENT 'Foreign key linking to distribution.inbound_receipt. Business justification: Inbound Sampling Process: samples drawn from inbound receipts at DCs must reference the receipt for inbound quality traceability. GMP inbound inspection and supplier quality management require linking',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Samples are physically collected as part of an inspection lot — the inspection lot defines the sampling plan, sample size, and collection context. sample currently has no direct FK to inspection_lot; ',
    `inventory_storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_storage_location. Business justification: Samples are collected from specific warehouse storage locations (environmental monitoring, incoming goods, stability chambers). Linking sample to inventory_storage_location enables location-based qual',
    `parent_sample_id` BIGINT COMMENT 'Self-referencing FK on sample (parent_sample_id)',
    `sku_id` BIGINT COMMENT 'Identifier of the finished product from which the sample was taken.',
    `analysis_date` DATE COMMENT 'Date on which the analysis was completed.',
    `analysis_result` STRING COMMENT 'Outcome of the quality analysis for the sample.',
    `analysis_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the analysis result was recorded.',
    `analyst_name` STRING COMMENT 'Name of the quality analyst who performed the test.',
    `collected_by` STRING COMMENT 'Name of the person who performed the sample collection.',
    `collection_date` DATE COMMENT 'Date on which the sample was physically collected.',
    `collection_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the sample was collected.',
    `comments` STRING COMMENT 'Additional observations or notes recorded by the analyst.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample record was first created in the system.',
    `expiry_date` DATE COMMENT 'Date after which the sample is considered expired for testing.',
    `is_control` BOOLEAN COMMENT 'Indicates whether the sample is a control specimen used for method verification.',
    `is_retest` BOOLEAN COMMENT 'True if the sample is a repeat test due to a prior failure or out‑of‑spec result.',
    `lot_number` STRING COMMENT 'Manufacturing lot number associated with the sample.',
    `result_unit` STRING COMMENT 'Unit of measure for the numeric result.',
    `result_value` DECIMAL(18,2) COMMENT 'Quantitative measurement obtained from the analysis (e.g., concentration).',
    `sample_code` STRING COMMENT 'External code or barcode assigned to the sample for tracking in the quality system.',
    `sample_name` STRING COMMENT 'Human‑readable name or description of the sample (e.g., "Batch 12 – Tablet Sample").',
    `sample_status` STRING COMMENT 'Current lifecycle state of the sample within the quality process.',
    `sample_type` STRING COMMENT 'Category of the sample indicating its purpose in quality testing.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the sample is stored, expressed in degrees Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sample record.',
    `volume_ml` DECIMAL(18,2) COMMENT 'Measured volume of the sample in milliliters.',
    `weight_g` DECIMAL(18,2) COMMENT 'Measured weight of the sample in grams.',
    CONSTRAINT pk_sample PRIMARY KEY(`sample_id`)
) COMMENT 'Master reference table for sample. Referenced by sample_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `consumer_goods_ecm`.`quality`.`sample`(`sample_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `consumer_goods_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ADD CONSTRAINT `fk_quality_usage_decision_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `consumer_goods_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `consumer_goods_ecm`.`quality`.`product_complaint`(`product_complaint_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_usage_decision_id` FOREIGN KEY (`usage_decision_id`) REFERENCES `consumer_goods_ecm`.`quality`.`usage_decision`(`usage_decision_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `consumer_goods_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ADD CONSTRAINT `fk_quality_batch_release_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_superseded_by_specification_id` FOREIGN KEY (`superseded_by_specification_id`) REFERENCES `consumer_goods_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `consumer_goods_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `consumer_goods_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ADD CONSTRAINT `fk_quality_notification_product_complaint_id` FOREIGN KEY (`product_complaint_id`) REFERENCES `consumer_goods_ecm`.`quality`.`product_complaint`(`product_complaint_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `consumer_goods_ecm`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_parent_sample_id` FOREIGN KEY (`parent_sample_id`) REFERENCES `consumer_goods_ecm`.`quality`.`sample`(`sample_id`);

-- ========= TAGS =========
ALTER SCHEMA `consumer_goods_ecm`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `consumer_goods_ecm`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `aql_level` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Level (AQL)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `certificate_of_analysis_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Required Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `change_control_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{6,10}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `characteristic_count` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Count');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `gmp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Critical Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lead Time (Days)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'manual|automated|laboratory|visual|destructive|non_destructive');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_severity` SET TAGS ('dbx_business_glossary_term' = 'Inspection Severity Level');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_severity` SET TAGS ('dbx_value_regex' = 'normal|tightened|reduced');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_value_regex' = 'goods_receipt|production_start|production_end|pre_release|post_release');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'incoming|in_process|final|stability|release|periodic');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'raw_material|packaging_material|intermediate|finished_good|bulk_product');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Description');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Name');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|obsolete|under_review');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `responsible_inspector_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Inspector Role');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `sample_unit` SET TAGS ('dbx_business_glossary_term' = 'Sample Unit of Measure');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `sampling_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Sampling Procedure Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `sampling_procedure_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `skip_lot_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Skip Lot Inspection Allowed Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `specification_version` SET TAGS ('dbx_value_regex' = '^V[0-9]{1,3}(.[0-9]{1,2})?$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_plan` ALTER COLUMN `test_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Required');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `certificate_of_analysis_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `coa_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Issue Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `disposition_outcome` SET TAGS ('dbx_business_glossary_term' = 'Disposition Outcome');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `disposition_outcome` SET TAGS ('dbx_value_regex' = 'released|blocked|scrapped|returned|reworked');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_end_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_location` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_priority` SET TAGS ('dbx_business_glossary_term' = 'Inspection Priority');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_start_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'created|released|in_progress|completed|cancelled');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'goods_receipt|production_batch|periodic|in_process|final_release|stability');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_origin_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Origin Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_origin_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Origin Type');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_origin_type` SET TAGS ('dbx_value_regex' = 'production_order|purchase_order|process_order|delivery|stock_transfer');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_quantity` SET TAGS ('dbx_business_glossary_term' = 'Lot Quantity');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `lot_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Lot Quantity Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Reason');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sample_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `sample_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `stock_posting_instruction` SET TAGS ('dbx_business_glossary_term' = 'Stock Posting Instruction');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `stock_posting_instruction` SET TAGS ('dbx_value_regex' = 'release_to_unrestricted|move_to_blocked|move_to_quality|scrap|return');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `usage_decision` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `usage_decision` SET TAGS ('dbx_value_regex' = 'accepted|rejected|restricted_use|rework|scrap|return_to_vendor');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `usage_decision_code` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_lot` ALTER COLUMN `usage_decision_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result Specification Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `coa_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Inclusion Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `control_chart_rule_violated` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Rule Violated');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `control_chart_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Violation Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `defect_severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `defect_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `deviation_code` SET TAGS ('dbx_business_glossary_term' = 'Deviation Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `environmental_condition_humidity` SET TAGS ('dbx_business_glossary_term' = 'Environmental Condition Humidity');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `environmental_condition_temperature` SET TAGS ('dbx_business_glossary_term' = 'Environmental Condition Temperature');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `inspection_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `inspection_characteristic_name` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Name');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `inspection_method_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `instrument_code` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `laboratory_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `lower_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|pending|waived');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `retest_indicator` SET TAGS ('dbx_business_glossary_term' = 'Retest Indicator');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `retest_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Retest Reason Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `retest_reason_code` SET TAGS ('dbx_value_regex' = 'initial_failure|inconclusive|instrument_error|sample_contamination|procedural_deviation|other');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `sample_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Sequence Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `test_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Test Batch Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`inspection_result` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `certificate_of_analysis_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Comments');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `decision_code` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `decision_code` SET TAGS ('dbx_value_regex' = 'A|R|Q|S|X');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `decision_maker_name` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker Name');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `decision_text` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Description');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Disposition Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'pending|completed|cancelled');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'goods_receipt|in_process|final|stability|complaint');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `quantity_accepted` SET TAGS ('dbx_business_glossary_term' = 'Quantity Accepted');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `quantity_rejected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Rejected');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `quantity_rework` SET TAGS ('dbx_business_glossary_term' = 'Quantity for Rework');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Reason');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `sampling_procedure` SET TAGS ('dbx_business_glossary_term' = 'Sampling Procedure');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`usage_decision` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `distribution_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `affected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `affected_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `affected_quantity_uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|BOX|PALLET');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `containment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Containment Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `defect_classification` SET TAGS ('dbx_business_glossary_term' = 'Defect Classification');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `disposition_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approved By User ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `disposition_approved_by` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `disposition_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approved Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'use_as_is|rework|scrap|return_to_supplier|downgrade|quarantine');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Event Type');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'complaint|defect|deviation|improvement_request|supplier_issue|audit_finding');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_status` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_status` SET TAGS ('dbx_value_regex' = 'open|in_investigation|containment_active|capa_assigned|closed|cancelled');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `notification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Priority');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|medium|low');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `responsible_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Plant Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `responsible_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Severity');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_QM|VEEVA_VAULT|MANUAL_ENTRY');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`nonconformance` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `capa_description` SET TAGS ('dbx_business_glossary_term' = 'CAPA Description');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'CAPA Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_value_regex' = '^CAPA-[0-9]{6,10}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Type');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|combined');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `closure_comments` SET TAGS ('dbx_business_glossary_term' = 'Closure Comments');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `cost_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Currency Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `cost_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `customer_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Method');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_verification_result` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Result');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_verification_result` SET TAGS ('dbx_value_regex' = 'effective|ineffective|pending');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `gmp_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Deviation Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Initiated Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAPA Priority');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Method');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_value_regex' = '5_whys|fishbone|fault_tree|pareto|failure_mode_effects_analysis|other');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'CAPA Severity');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Source Type');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'nonconformance|audit_finding|customer_complaint|supplier_issue|stability_failure|regulatory_inspection');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'CAPA Title');
ALTER TABLE `consumer_goods_ecm`.`quality`.`capa` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Certificate Of Analysis Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_value_regex' = '^AUDIT-[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `batch_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Quantity');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `hold_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiated Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `manufacturing_site_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `manufacturing_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `qc_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspection Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `qc_inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional_pass|pending|waived');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `qp_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Qualified Person (QP) Signature Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `qualified_person_name` SET TAGS ('dbx_business_glossary_term' = 'Qualified Person (QP) Name');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `qualified_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `regulatory_hold_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `regulatory_hold_status` SET TAGS ('dbx_value_regex' = 'no_hold|fda_hold|epa_hold|internal_hold|customer_hold|recall_hold');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `release_decision` SET TAGS ('dbx_business_glossary_term' = 'Release Decision');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `release_decision` SET TAGS ('dbx_value_regex' = 'released|rejected|quarantine|conditional_release|pending_review|on_hold');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Released Quantity');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `stability_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Reference');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `stability_study_reference` SET TAGS ('dbx_value_regex' = '^STAB-[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`batch_release` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_value_regex' = '^VV-[A-Z0-9]{10,20}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `authorized_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Title');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_value_regex' = 'kg|g|L|mL|units|cases');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_number` SET TAGS ('dbx_value_regex' = '^COA-[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'finished_goods|raw_material|intermediate|packaging_material');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `customer_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Facing Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `document_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `gmp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliant Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `manufacturing_site_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `manufacturing_site_code` SET TAGS ('dbx_value_regex' = '^SITE-[A-Z0-9]{4,10}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `manufacturing_site_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Name');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `overall_result_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Result Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `overall_result_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending_review');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `quantity_tested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Tested');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `quantity_tested_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Tested Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `quantity_tested_uom` SET TAGS ('dbx_value_regex' = 'kg|g|L|mL|units|cases');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `specification_version` SET TAGS ('dbx_value_regex' = '^V[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `supplier_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `test_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`certificate_of_analysis` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Product Complaint ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `consumer_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Offer Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Account ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_address` SET TAGS ('dbx_business_glossary_term' = 'Complainant Address');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_country_code` SET TAGS ('dbx_business_glossary_term' = 'Complainant Country Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_business_glossary_term' = 'Complainant Email Address');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_name` SET TAGS ('dbx_business_glossary_term' = 'Complainant Name');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_phone` SET TAGS ('dbx_business_glossary_term' = 'Complainant Phone Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complainant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_value_regex' = 'foreign_body|contamination|labeling_error|efficacy_failure|packaging_defect|adverse_reaction');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_value_regex' = '^CPL-[0-9]{8}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complaint_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Complaint Received Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complaint_source` SET TAGS ('dbx_business_glossary_term' = 'Complaint Source');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complaint_source` SET TAGS ('dbx_value_regex' = 'consumer_direct|retailer|distributor|regulatory_agency|social_media|call_center');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_lab_analysis|resolved|closed|escalated');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `complaint_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Complaint Subcategory');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$|^[0-9]{12}$|^[0-9]{13}$|^[0-9]{14}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|lab_testing|pending_capa|completed');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `lab_analysis_result` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Result');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'refund_issued|replacement_sent|no_action_required|product_recall|investigation_ongoing');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `sample_received_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Received Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `sample_returned_flag` SET TAGS ('dbx_business_glossary_term' = 'Sample Returned Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `consumer_goods_ecm`.`quality`.`product_complaint` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `specification_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `superseded_by_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Specification ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `coa_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Inclusion Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `critical_quality_attribute_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Quality Attribute (CQA) Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `customer_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Requirement Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `lower_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `sampling_plan` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `specification_category` SET TAGS ('dbx_business_glossary_term' = 'Specification Category');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `specification_category` SET TAGS ('dbx_value_regex' = 'physical|chemical|microbiological|sensory|functional|safety');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|obsolete');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_value_regex' = 'raw_material|packaging_material|in_process|finished_good|intermediate|bulk');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `stability_indicating_flag` SET TAGS ('dbx_business_glossary_term' = 'Stability Indicating Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `test_characteristic` SET TAGS ('dbx_business_glossary_term' = 'Test Characteristic');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `test_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Required');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `test_frequency` SET TAGS ('dbx_business_glossary_term' = 'Test Frequency');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `test_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `consumer_goods_ecm`.`quality`.`specification` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `notification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `affected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `affected_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `affected_quantity_uom` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `assigned_to_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Name');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Closed Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `containment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Containment Action Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Creation Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `defect_class` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Classification');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `defect_class` SET TAGS ('dbx_value_regex' = 'critical|major|minor|cosmetic');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `defect_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Detection Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Detection Source');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `disposition_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approved By');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `disposition_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approval Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Material Disposition Decision');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'use_as_is|rework|scrap|return_to_supplier|downgrade');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,18}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `notification_description` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Description');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Number');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Status');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_approval|closed|cancelled');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Type');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'complaint|defect|improvement|deviation|audit_finding|supplier_issue');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification Priority');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Reported Timestamp');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `consumer_goods_ecm`.`quality`.`notification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` SET TAGS ('dbx_subdomain' = 'inspection_control');
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Storage Location Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ALTER COLUMN `parent_sample_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ALTER COLUMN `analyst_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ALTER COLUMN `analyst_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ALTER COLUMN `collected_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`quality`.`sample` ALTER COLUMN `collected_by` SET TAGS ('dbx_pii_name' = 'true');
