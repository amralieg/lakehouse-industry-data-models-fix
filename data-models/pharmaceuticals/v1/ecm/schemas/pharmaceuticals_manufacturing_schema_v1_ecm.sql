-- Schema for Domain: manufacturing | Business: Pharmaceuticals | Version: v1_ecm
-- Generated on: 2026-05-05 17:50:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`manufacturing` COMMENT 'Manages production of drug substances (DS) and drug products (DP) including API production, formulation, fill-finish, and packaging under cGMP. Covers manufacturing execution system (MES) data, batch records, critical process parameters (CPP), critical quality attributes (CQA), equipment scheduling, and production schedules. Includes CMO and CDMO oversight. Integrates with SAP PP/QM and MES systems. Supports QbD principles and PAT implementation per 21 CFR Parts 210/211.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` (
    `production_order_id` BIGINT COMMENT 'Unique identifier for the production order. Primary key for the production order entity.',
    `bill_of_materials_id` BIGINT COMMENT 'Identifier for the Bill of Materials defining all raw materials, Active Pharmaceutical Ingredients (API), excipients, and packaging components required for production. Links to component specifications and quantities per batch size.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Production orders manufacture specific branded products. Essential for revenue recognition, gross-to-net calculations, supply-demand planning, and linking manufacturing output to commercial product po',
    `campaign_id` BIGINT COMMENT 'Identifier for a manufacturing campaign grouping multiple production orders for the same material or product family. Used for campaign-based manufacturing to minimize changeovers and optimize equipment utilization.. Valid values are `^CMP-[A-Z0-9]{8,12}$`',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Production orders specify which drug product to manufacture. Fundamental to MRP/ERP integration, production planning, capacity allocation, and linking manufacturing demand to product portfolio. Drives',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Commercial production scheduling must respect exclusivity periods (orphan, pediatric, data exclusivity) to avoid regulatory violations, ensure compliant market entry timing, and coordinate launch read',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Production orders must comply with specific GXP obligations (GMP requirements per 21 CFR Part 211). Essential for batch release decisions, regulatory submissions, and inspection readiness. Pharmaceuti',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Production orders for validation batches, clinical trial material, and process development are charged to internal orders for project cost tracking and R&D capitalization decisions per GAAP/IFRS requi',
    `line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_line. Business justification: Production orders are executed on a specific manufacturing line within a site. The production_order table has manufacturing_line (STRING) which should be a FK to the manufacturing_line master data. Th',
    `master_batch_record_id` BIGINT COMMENT 'Identifier for the approved Master Batch Record that defines the manufacturing process, Critical Process Parameters (CPP), Critical Quality Attributes (CQA), in-process controls, and acceptance criteria. The production order must execute according to this controlled document per 21 CFR Part 211.186.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Commercial production orders must track covering patent for IP compliance verification, royalty calculation basis, freedom-to-operate confirmation, and regulatory submission documentation in pharmaceu',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plan. Business justification: Production orders execute supply plans in S&OP process. MRP systems require linking scheduled production to the supply plan version that authorized it for capacity planning and variance analysis.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Manufacturing production orders should link to procurement purchase orders for raw material procurement tracking. This enables integrated production planning and procurement execution, ensuring materi',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Production orders require supervisor assignment for GMP accountability, deviation escalation authority, batch release approval chain, and manufacturing execution oversight. Essential for production ma',
    `routing_id` BIGINT COMMENT 'Identifier for the production routing defining the sequence of manufacturing operations, work centers, standard times, and in-process quality checks. Routing must align with the Master Batch Record process flow.. Valid values are `^RTG-[A-Z0-9]{8,15}$`',
    `site_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_site. Business justification: Production orders are executed at a specific manufacturing site. The production_order table currently has production_facility_code (STRING) which should be normalized to a FK relationship with manufac',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to intellectual.trademark. Business justification: Production orders for branded products must track trademark usage for serialization compliance, packaging artwork verification, brand protection, anti-counterfeiting measures, and ensuring manufacturi',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when all production operations were completed and order was confirmed. Captured from Manufacturing Execution System (MES) at final operation completion.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Actual quantity produced and confirmed at order completion. May differ from planned quantity due to yield loss, in-process rejections, or overproduction within acceptable limits.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when production order execution commenced. Captured from Manufacturing Execution System (MES) at first operation start. Critical for cycle time analysis and Current Good Manufacturing Practice (cGMP) batch record documentation.',
    `batch_number` STRING COMMENT 'Unique batch or lot number assigned to the production output. Critical identifier for traceability, quality control testing, Certificate of Analysis (CoA), and pharmacovigilance. Must be unique per material and comply with batch numbering conventions per 21 CFR Part 211.188.. Valid values are `^[A-Z0-9]{6,15}$`',
    `cmo_cdmo_code` STRING COMMENT 'Identifier for the external Contract Manufacturing Organization (CMO) or Contract Development and Manufacturing Organization (CDMO) if production is outsourced. Links to supplier master data and quality agreements.. Valid values are `^[A-Z0-9]{3,10}$`',
    `created_by_user` STRING COMMENT 'User ID of the person who created the production order record. Required for audit trail and accountability per 21 CFR Part 11 electronic records requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the production order record was first created in the system. Audit trail field for data governance and compliance.',
    `expiry_date` DATE COMMENT 'Calculated expiration date for the manufactured batch based on approved shelf life and manufacturing date. Critical for inventory management, distribution planning, and regulatory compliance. Must be printed on product labeling per 21 CFR Part 201.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified the production order record. Required for audit trail and accountability per 21 CFR Part 11 electronic records requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the production order record was last updated. Audit trail field for tracking changes to order details, status transitions, or confirmations.',
    `ndc_code` STRING COMMENT 'National Drug Code assigned by the FDA for the finished drug product. Required for packaging orders to ensure correct labeling and serialization. Format: labeler code (5 digits) + product code (4 digits) + package code (1-2 digits).. Valid values are `^[0-9]{10,11}$`',
    `order_number` STRING COMMENT 'Externally-known business identifier for the production order. Human-readable order number used across manufacturing execution systems and batch records.. Valid values are `^[A-Z0-9]{10,12}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the production order in the manufacturing execution workflow. Created indicates order planning complete; released indicates order approved for execution; in_progress indicates active manufacturing; confirmed indicates production complete pending quality review; technically_complete indicates all operations and quality checks complete; closed indicates final settlement and batch record archived; cancelled indicates order terminated without execution. [ENUM-REF-CANDIDATE: created|released|in_progress|confirmed|technically_complete|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the production order indicating the type of manufacturing operation: process order for Drug Substance (DS) production, production order for Drug Product (DP) formulation, packaging order for fill-finish and labeling, rework order for reprocessing, validation batch for process qualification, or exhibit batch for regulatory submission samples.. Valid values are `process_order|production_order|packaging_order|rework_order|validation_batch|exhibit_batch`',
    `pat_enabled_flag` BOOLEAN COMMENT 'Indicates whether Process Analytical Technology (PAT) tools are used for real-time monitoring and control of Critical Process Parameters (CPP) and Critical Quality Attributes (CQA) during manufacturing. True for processes with inline/online/at-line analytical instrumentation per FDA PAT Guidance.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Target quantity to be produced as specified in the production order. Represents the batch size defined in the master batch record or Bill of Materials (BOM).',
    `priority` STRING COMMENT 'Scheduling priority for the production order. Urgent for critical supply shortages or regulatory commitments; high for commercial launch or clinical trial material; normal for routine replenishment; low for strategic inventory build.. Valid values are `urgent|high|normal|low`',
    `qbd_flag` BOOLEAN COMMENT 'Indicates whether the production order follows Quality by Design (QbD) principles with defined design space, Critical Process Parameters (CPP), and Critical Quality Attributes (CQA) per ICH Q8/Q9/Q10. True for QbD-enabled processes with enhanced process understanding and control strategy.',
    `reconciliation_status` STRING COMMENT 'Status of material reconciliation comparing issued raw materials and components against actual consumption and finished goods produced. Reconciliation is required per 21 CFR Part 211.188 to detect significant unexplained discrepancies that may indicate diversion, contamination, or process issues.. Valid values are `pending|reconciled|variance_identified|investigation_required|approved`',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether material from this production order will be used for regulatory submission purposes such as stability studies, exhibit batches for New Drug Application (NDA), Biologics License Application (BLA), or Marketing Authorization Application (MAA). Requires enhanced documentation and retention per regulatory requirements.',
    `retest_date` DATE COMMENT 'Date by which Drug Substance (DS) or Active Pharmaceutical Ingredient (API) must be retested to confirm continued compliance with specifications. Applicable primarily to bulk API and intermediates stored before further processing.',
    `rework_flag` BOOLEAN COMMENT 'Indicates whether the production order involves rework or reprocessing of previously manufactured material that did not meet specifications. Rework must be performed according to approved procedures and documented per 21 CFR Part 211.115.',
    `scheduled_finish_date` DATE COMMENT 'Planned date for production order completion including all manufacturing operations and in-process quality checks.',
    `scheduled_start_date` DATE COMMENT 'Planned date for production order execution to begin. Used for capacity planning and material staging.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of material scrapped or rejected during production due to Out of Specification (OOS) results, equipment failures, or process deviations. Scrap must be documented and investigated per Current Good Manufacturing Practice (cGMP) requirements.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for planned and actual quantities. KG/G/MG for bulk Drug Substance (DS) and Active Pharmaceutical Ingredient (API); L/ML for liquids; EA/TAB/CAP for countable dosage units; VIAL/SYRINGE/BOTTLE for primary packaging; CARTON for secondary packaging. [ENUM-REF-CANDIDATE: KG|G|MG|L|ML|EA|TAB|CAP|VIAL|SYRINGE|BOTTLE|CARTON — 12 candidates stripped; promote to reference product]',
    `validation_batch_flag` BOOLEAN COMMENT 'Indicates whether the production order is a validation batch used for process qualification, process performance qualification (PPQ), or continued process verification. Validation batches require enhanced documentation and are used to demonstrate process capability and reproducibility.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Calculated yield percentage representing actual quantity produced divided by planned quantity, expressed as a percentage. Used for process performance monitoring and variance analysis. Deviations outside acceptable yield ranges may trigger investigation per Current Good Manufacturing Practice (cGMP).',
    CONSTRAINT pk_production_order PRIMARY KEY(`production_order_id`)
) COMMENT 'Core manufacturing execution record representing a discrete production order for drug substance (DS), drug product (DP), or packaging/labeling operations. Captures order type (process order, production order, packaging order), planned/actual quantities, scheduled and actual start/finish dates, production facility, manufacturing line, order status (created, released, confirmed, technically complete), priority, batch size, unit of measure, material/SKU, NDC code (for packaging), reconciliation data, and linkage to master batch record. Central transactional entity for all manufacturing execution aligned with SAP PP module.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` (
    `batch_record_id` BIGINT COMMENT 'Unique identifier for the electronic batch record (eBR). Primary key for the batch record entity. This is the system-generated surrogate key for the batch manufacturing record.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Batch manufacturing must comply with market access strategy requirements (e.g., QbD compliance for HTA submissions, specific manufacturing standards for target markets). Batches are manufactured to su',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: GMP regulation 21 CFR 211.188 requires batch records document the operator who performed each manufacturing step. Critical for regulatory inspection readiness, deviation investigation, and GMP account',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Every batch is manufactured for a specific brand. Critical for serialization compliance, track-and-trace systems, product complaint investigations, recall management, and commercial supply chain visib',
    `campaign_id` BIGINT COMMENT 'Identifier for the manufacturing campaign to which this batch belongs. A campaign is a series of consecutive batches of the same product manufactured in a defined time period using the same equipment and process. Used for campaign-level yield analysis and equipment utilization tracking.. Valid values are `^CAMP-[A-Z0-9]{6,12}$`',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: Batches manufactured using DMF-registered API, excipients, or processes must reference the DMF for regulatory traceability, CMC compliance verification, letter of authorization validation, and support',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Batch records document manufacturing of specific drug products. Essential for batch disposition, regulatory traceability, product genealogy, and linking manufacturing execution to product specificatio',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Batch production costs for validation, clinical trials, and development batches are allocated to internal orders for proper project accounting, cost tracking, and capitalization assessment.',
    `line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_line. Business justification: Batch records are executed on a specific manufacturing line. The batch_record table has production_line_code (STRING) which should be normalized to a FK to manufacturing_line. This enables access to l',
    `master_batch_record_id` BIGINT COMMENT 'Reference to the approved master batch record (MBR) that defines the standard manufacturing procedure, formula, and process parameters for this product. The MBR is the template from which this batch record is executed.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Each batch record must document patent protection status for regulatory submissions (NDA/ANDA), commercial release decisions, IP lifecycle management, and demonstrating patent coverage during GMP insp',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Batch records are the execution records for production orders. Each batch_record is created to document the manufacturing execution of a specific production_order. This is a standard child→parent rela',
    `site_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_site. Business justification: Batch records are executed at a specific manufacturing site. Currently batch_record has manufacturing_site_code and manufacturing_site_name (STRING) which are redundant with the manufacturing_site mas',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Manufacturing batch records must link to supply inventory lots to enable end-to-end traceability from production to distribution. This is critical for product recalls, quality investigations, and supp',
    `warehouse_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_receipt. Business justification: Manufactured batches are received into warehouse inventory. GMP chain of custody requires linking batch production completion to warehouse receipt event for regulatory traceability and inventory recon',
    `actual_yield_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of product produced at the end of the manufacturing process. Compared against theoretical yield to calculate yield percentage and identify process inefficiencies or material losses.',
    `batch_number` STRING COMMENT 'The unique business identifier assigned to the manufacturing batch. This is the externally-known batch identifier used across all manufacturing, quality, and regulatory documentation. Must be unique and traceable per cGMP requirements.. Valid values are `^[A-Z0-9]{6,20}$`',
    `batch_size_quantity` DECIMAL(18,2) COMMENT 'The planned or target quantity of product to be manufactured in this batch. Expressed in the unit of measure specified in batch_size_uom. Used for yield calculations and material planning.',
    `batch_size_uom` STRING COMMENT 'The unit of measure for the batch size quantity. Common units include kilograms (kg) for bulk API, liters (L) for liquids, or discrete units (tablets, vials, capsules) for finished dosage forms. [ENUM-REF-CANDIDATE: kg|g|L|mL|units|tablets|vials|capsules — 8 candidates stripped; promote to reference product]',
    `batch_status` STRING COMMENT 'Current lifecycle status of the batch. In-process indicates active manufacturing; Released indicates QA approval for distribution; Rejected indicates failed quality specifications; Quarantine indicates pending investigation or testing; On-hold indicates temporary suspension; Expired indicates past shelf life.. Valid values are `in_process|released|rejected|quarantine|on_hold|expired`',
    `batch_type` STRING COMMENT 'Classification of the batch by manufacturing stage. Drug Substance (DS) refers to API production; Drug Product (DP) refers to formulated finished dosage form (FDF). Intermediate refers to in-process materials.. Valid values are `drug_substance|drug_product|api|intermediate|bulk|finished_dosage_form`',
    `capa_required` BOOLEAN COMMENT 'Indicates whether a formal CAPA investigation was required for this batch due to deviations, out-of-specification (OOS) results, or quality issues. True indicates CAPA was initiated; False indicates no CAPA required.',
    `deviation_count` STRING COMMENT 'The number of manufacturing deviations or non-conformances documented during the production of this batch. Deviations require investigation and impact assessment per cGMP. Zero indicates no deviations occurred.',
    `disposition_approver_name` STRING COMMENT 'The name of the qualified quality unit personnel who approved the final disposition decision. Must be an authorized individual per the quality management system (QMS).',
    `disposition_date` DATE COMMENT 'The date on which the final disposition decision was made by the quality unit. Marks the completion of batch review and approval process.',
    `disposition_decision` STRING COMMENT 'The final quality decision on the batch. Release indicates approval for distribution; Reject indicates failure to meet specifications; Rework indicates batch will be reprocessed; Destroy indicates batch will be disposed of. This is the authoritative disposition outcome.. Valid values are `release|reject|rework|reprocess|destroy`',
    `disposition_rationale` STRING COMMENT 'The documented justification for the disposition decision. For rejections, includes the specific quality failures or deviations. For releases, confirms all specifications and cGMP requirements were met. Required for regulatory compliance and audit trail.',
    `environmental_monitoring_compliant` BOOLEAN COMMENT 'Indicates whether environmental monitoring results (viable and non-viable particulates, temperature, humidity) were within acceptable limits throughout the manufacturing process. Critical for sterile and aseptic manufacturing per cGMP.',
    `expiry_date` DATE COMMENT 'The date after which the batch should not be used or distributed. Calculated based on manufacture date plus approved shelf life from stability studies. Required on all drug product labels per regulatory requirements.',
    `formulation_version` STRING COMMENT 'The version number of the product formulation used for this batch. Tracks changes to the formula, process parameters, or specifications. Critical for change control and regulatory submissions (CMC section).. Valid values are `^V[0-9]{1,3}(.[0-9]{1,2})?$`',
    `gmp_classification` STRING COMMENT 'The GMP classification under which this batch was manufactured. cGMP (current Good Manufacturing Practice) is required for commercial and late-stage clinical batches. GMP applies to earlier development batches. Non-GMP may apply to research-only materials.. Valid values are `cgmp|gmp|non_gmp`',
    `manufacture_date` DATE COMMENT 'The calendar date on which the batch manufacturing was completed. Used for regulatory labeling, shelf-life calculations, and expiry date determination. Distinct from manufacturing_end_timestamp which includes time precision.',
    `manufacturing_end_timestamp` TIMESTAMP COMMENT 'The date and time when manufacturing operations for this batch were completed. Marks the end of the production cycle before quality testing and release. Used to calculate cycle time and production efficiency.',
    `manufacturing_start_timestamp` TIMESTAMP COMMENT 'The date and time when manufacturing operations for this batch commenced. Marks the beginning of the batch production cycle. Critical for batch genealogy and process timeline documentation.',
    `pat_monitoring_enabled` BOOLEAN COMMENT 'Indicates whether Process Analytical Technology (PAT) tools were used for real-time monitoring and control of critical quality attributes (CQA) during this batch. PAT enables continuous quality verification per FDA PAT guidance.',
    `qbd_design_space_compliance` BOOLEAN COMMENT 'Indicates whether all critical process parameters (CPP) remained within the approved QbD design space during manufacturing. True indicates full compliance; False indicates deviation requiring investigation. Applicable for products developed under QbD principles per ICH Q8.',
    `reconciliation_status` STRING COMMENT 'Status of the material reconciliation process comparing input materials consumed against output product and documented waste. Discrepancies require investigation per cGMP. Reconciled indicates all materials are accounted for within acceptable limits.. Valid values are `reconciled|pending|discrepancy_identified|under_investigation`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this batch record was first created in the system. Audit trail field for data governance and compliance. Distinct from manufacturing_start_timestamp which reflects the physical production start.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this batch record was last modified in the system. Audit trail field for data governance and compliance. Updated whenever any field in the batch record is changed.',
    `regulatory_submission_reference` STRING COMMENT 'Reference to the regulatory submission (IND, NDA, BLA, MAA) under which this batch was manufactured. Links the batch to the approved regulatory dossier and ensures manufacturing is conducted per approved CMC specifications.',
    `retest_date` DATE COMMENT 'The date by which the batch must be re-examined to ensure it still meets quality specifications. Primarily applicable to drug substances (API) and intermediates. If testing confirms specifications are met, the material may continue to be used.',
    `sterility_assurance_level` STRING COMMENT 'The probability of a single viable microorganism being present on a product unit after sterilization. Expressed as SAL-10^-N (e.g., SAL-10^-6 means one in a million probability). Required for sterile products. Not applicable for non-sterile products.. Valid values are `^SAL-10^-[0-9]$`',
    `sterilization_method` STRING COMMENT 'The sterilization method applied to this batch, if applicable. Required for sterile drug products and certain medical devices. Not applicable for non-sterile products. Method must be validated per regulatory requirements.. Valid values are `autoclave|dry_heat|ethylene_oxide|gamma_irradiation|filtration|not_applicable`',
    `theoretical_yield_quantity` DECIMAL(18,2) COMMENT 'The expected quantity of product that should be produced based on the master batch record formula and input materials, assuming 100% efficiency with no losses. Used as the baseline for yield percentage calculation.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'The ratio of actual yield to theoretical yield expressed as a percentage. Calculated as (actual_yield_quantity / theoretical_yield_quantity) * 100. Deviations from expected yield ranges trigger investigations per cGMP.',
    CONSTRAINT pk_batch_record PRIMARY KEY(`batch_record_id`)
) COMMENT 'Electronic batch record (eBR) representing the complete manufacturing history of a specific batch of drug substance or drug product, as required under 21 CFR Parts 210/211 and cGMP. Captures batch number, product code, batch size, manufacturing date, expiry date, retest date, manufacturing site, batch status (in-process, released, rejected, quarantine), master batch record reference, yield data (theoretical vs actual, yield percentage, reconciliation status), disposition decision (release/reject with approver and rationale), material consumption actuals, parent/child batch genealogy links, and campaign reference. Serves as the primary cGMP compliance document and SSOT for batch lifecycle from production through disposition. Sourced from MES and SAP PP/QM.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` (
    `master_batch_record_id` BIGINT COMMENT 'Unique identifier for the master batch record. Primary key. Role: MASTER_RESOURCE.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: MBRs define manufacturing processes for specific brands. Links technical manufacturing documentation to commercial product lifecycle management, launch planning, and regulatory submission tracking. Es',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: MBRs for API or proprietary excipient manufacturing must link to holders DMF for regulatory submissions, supply chain qualification, change control coordination, and ensuring manufacturing process al',
    `drug_product_id` BIGINT COMMENT 'Reference to the drug product (DP) or drug substance (DS) that this master batch record defines manufacturing instructions for.',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: MBRs define API/drug substance used in formulation. Critical for API sourcing strategy, DMF linkage, regulatory submissions (CTD Module 3), and ensuring correct active ingredient specification. Suppor',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: MBRs are designed to satisfy specific GXP obligations (21 CFR 211.186, EU GMP Chapter 4). Essential for regulatory submissions (NDA/BLA/MAA), change control, and demonstrating compliance-by-design. Ph',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: MBR authorship must be tracked for change control accountability, document lifecycle management, regulatory inspection readiness, and technical transfer. GMP requires documented authorship for all con',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: MBRs define manufacturing processes that must reference covering process/formulation patents for technology transfer documentation, licensing agreement compliance, regulatory filings, and IP strategy ',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site or facility where this master batch record is used. Supports multi-site operations and Contract Manufacturing Organization (CMO) / Contract Development and Manufacturing Organization (CDMO) oversight.',
    `superseded_by_mbr_master_batch_record_id` BIGINT COMMENT 'Reference to the newer master batch record that supersedes this version, enabling version lineage tracking.',
    `approval_status` STRING COMMENT 'The approval status of this master batch record: pending, approved, or rejected by quality assurance and regulatory affairs.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'The name or identifier of the quality assurance (QA) manager or authorized person who approved this master batch record.',
    `approved_date` DATE COMMENT 'The date on which this master batch record was formally approved by quality assurance.',
    `batch_size_maximum` DECIMAL(18,2) COMMENT 'The maximum allowable batch size that can be manufactured using this master batch record, supporting scale flexibility.',
    `batch_size_minimum` DECIMAL(18,2) COMMENT 'The minimum allowable batch size that can be manufactured using this master batch record, supporting scale flexibility.',
    `batch_size_standard` DECIMAL(18,2) COMMENT 'The standard or nominal batch size for which this master batch record is designed, expressed in the unit of measure defined in batch_size_uom.',
    `batch_size_uom` STRING COMMENT 'The unit of measure for batch size: kilograms (kg), liters (L), units, tablets, vials, or doses.. Valid values are `kg|L|units|tablets|vials|doses`',
    `cgmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether this master batch record is compliant with current Good Manufacturing Practice (cGMP) regulations per 21 CFR Parts 210 and 211.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this master batch record was first created in the system.',
    `document_location` STRING COMMENT 'The storage location or URI of the full master batch record document in the document management system (Veeva Vault QualityDocs or MasterControl).',
    `dosage_form` STRING COMMENT 'The finished dosage form (FDF) of the product: tablet, capsule, injection, suspension, solution, cream, ointment, or powder. [ENUM-REF-CANDIDATE: tablet|capsule|injection|suspension|solution|cream|ointment|powder — 8 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'The date on which this master batch record becomes effective and can be used for manufacturing operations.',
    `equipment_requirements` STRING COMMENT 'Description of the equipment required for executing this master batch record, including specific equipment types, models, or identifiers.',
    `expected_yield_percentage` DECIMAL(18,2) COMMENT 'The expected theoretical yield for this batch as a percentage, used to calculate acceptable yield ranges and detect deviations.',
    `formulation_details` STRING COMMENT 'Detailed formulation information including active pharmaceutical ingredient (API) and excipient quantities, ratios, and specifications. Business-confidential intellectual property.',
    `in_process_control_specifications` STRING COMMENT 'Summary of in-process control specifications and acceptance criteria that must be met during batch execution, including critical quality attributes (CQAs).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this master batch record was last modified or updated.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the master batch record: draft, under review, approved, active (in use), superseded (replaced by newer version), obsolete, or retired. [ENUM-REF-CANDIDATE: draft|under_review|approved|active|superseded|obsolete|retired — 7 candidates stripped; promote to reference product]',
    `manufacturing_process_type` STRING COMMENT 'The type of manufacturing process covered by this master batch record: API synthesis, formulation, fill-finish, packaging, blending, granulation, coating, or lyophilization. [ENUM-REF-CANDIDATE: api_synthesis|formulation|fill_finish|packaging|blending|granulation|coating|lyophilization — 8 candidates stripped; promote to reference product]',
    `mbr_number` STRING COMMENT 'The externally-known unique business identifier for this master batch record, used across manufacturing, quality, and regulatory systems.. Valid values are `^MBR-[A-Z0-9]{6,12}$`',
    `mbr_title` STRING COMMENT 'Human-readable title or name of the master batch record, typically including product name and dosage form.',
    `minimum_yield_percentage` DECIMAL(18,2) COMMENT 'The minimum acceptable yield percentage below which a batch is considered out of specification (OOS) and requires investigation.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this master batch record.',
    `pat_enabled_flag` BOOLEAN COMMENT 'Indicates whether Process Analytical Technology (PAT) is implemented for real-time monitoring and control of critical process parameters (CPPs) and critical quality attributes (CQAs).',
    `process_description` STRING COMMENT 'High-level description of the manufacturing process steps covered by this master batch record, including key operations and sequence.',
    `qbd_approach_flag` BOOLEAN COMMENT 'Indicates whether this master batch record was developed using Quality by Design (QbD) principles per ICH Q8/Q9/Q10.',
    `regulatory_approval_reference` STRING COMMENT 'Reference to the regulatory approval document (NDA, BLA, MAA, or ANDA number) under which this master batch record is authorized for commercial manufacturing.',
    `review_cycle_months` STRING COMMENT 'The periodic review cycle in months for this master batch record, ensuring ongoing compliance and relevance per quality management system (QMS) requirements.',
    `strength` STRING COMMENT 'The strength or potency of the active pharmaceutical ingredient (API) in the finished dosage form, e.g., 500mg, 10mg/mL.',
    `superseded_date` DATE COMMENT 'The date on which this master batch record was superseded by a newer version and is no longer used for new batches.',
    `version_number` STRING COMMENT 'The version number of this master batch record, incremented with each revision. Format: major.minor (e.g., 1.0, 2.1).. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    CONSTRAINT pk_master_batch_record PRIMARY KEY(`master_batch_record_id`)
) COMMENT 'The approved master batch record (MBR) template defining the standard manufacturing instructions, formulation, process steps, critical process parameters (CPPs) with target values and acceptance criteria, critical quality attributes (CQAs), in-process control specifications, equipment requirements, and expected yields for a specific product and batch size. Represents the recipe or master formula from which individual batch records are generated. Tracks version number, approval status, effective date, superseded date, product code, dosage form, batch size range, and regulatory approval linkage. Serves as the SSOT for all parameter specifications — parameter names, types, target values, control limits (upper/lower), specification limits, and acceptance criteria. Actual measured values during execution are recorded in process_parameter_result, not here. Managed in Veeva Vault QualityDocs or MasterControl.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` (
    `site_id` BIGINT COMMENT 'Unique identifier for the manufacturing site. Primary key for the manufacturing site master data entity.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Manufacturing sites have operating budgets for utilities, maintenance, overhead, and capital expenditures requiring linkage for budget planning, variance analysis, and site-level financial performance',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: When site is operated by contract manufacturing organization (ownership_type = CMO/CDMO), links to vendor master for quality agreements, audit scheduling, regulatory oversight, and performance managem',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Manufacturing sites are capitalized fixed assets requiring depreciation tracking, capital planning, insurance valuation, and regulatory asset documentation for GMP compliance and financial reporting.',
    `activation_date` DATE COMMENT 'Date when the manufacturing site became operational and began commercial production. Used for calculating site age, depreciation schedules, and historical performance analysis.',
    `address_line_1` STRING COMMENT 'Primary street address line of the manufacturing site including street number and name. Required for regulatory establishment registration and inspection scheduling.',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details such as building number, suite, floor, or industrial park name.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the site capacity metric. Varies by site type: API sites typically use kg or metric tons, formulation sites use million units or batches, fill-finish sites use thousand vials or liters.. Valid values are `kg|metric_ton|million_units|thousand_vials|batches|liters`',
    `capacity_units_per_year` DECIMAL(18,2) COMMENT 'Annual production capacity of the site measured in units appropriate to the site type (e.g., kilograms of API, millions of tablets, thousands of vials). Used for capacity planning, supply chain optimization, and network strategy.',
    `city` STRING COMMENT 'City or municipality where the manufacturing site is located. Used for regulatory reporting and supply chain logistics planning.',
    `closure_date` DATE COMMENT 'Date when the manufacturing site ceased operations or was decommissioned. Null for active sites. Used for historical record keeping and regulatory reporting of discontinued manufacturing locations.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country where the manufacturing site is located. Critical for determining applicable regulatory authority jurisdiction (FDA, EMA, PMDA, NMPA, etc.).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the manufacturing site record was first created in the master data system. Used for data lineage and audit trail purposes.',
    `ema_authorization_number` STRING COMMENT 'EMA manufacturing authorization number or EudraGMP identifier for sites manufacturing medicinal products for the European market. Required for GMP compliance verification.',
    `ema_authorization_status` STRING COMMENT 'Current status of the EMA manufacturing authorization indicating whether the site is actively authorized to manufacture for EU markets, authorization has expired, application is pending, authorization is not required, or has been suspended.. Valid values are `authorized|expired|pending|not_applicable|suspended`',
    `email_address` STRING COMMENT 'Primary email contact for the manufacturing site used for regulatory correspondence, quality notifications, and business communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `environmental_monitoring_program` BOOLEAN COMMENT 'Indicates whether the site has an active environmental monitoring program for tracking viable and non-viable particulates, temperature, humidity, and other environmental conditions in classified manufacturing areas. Required for sterile and aseptic manufacturing operations.',
    `erp_plant_code` STRING COMMENT 'SAP S/4HANA plant code or equivalent ERP system identifier for the manufacturing site. Links site master data to production planning (PP), materials management (MM), quality management (QM), and warehouse management (WM) modules.. Valid values are `^[A-Z0-9]{4}$`',
    `fda_registration_expiry_date` DATE COMMENT 'Date when the current FDA establishment registration expires. FDA registrations must be renewed annually between October 1 and December 31.',
    `fda_registration_number` STRING COMMENT 'FDA establishment registration number assigned to the site. Required for all facilities manufacturing drugs for the US market per 21 CFR Part 207. Must be renewed annually.. Valid values are `^[0-9]{7,10}$`',
    `fda_registration_status` STRING COMMENT 'Current status of the FDA establishment registration indicating whether the site is actively registered, registration has expired, renewal is pending, registration is not required, or registration has been suspended.. Valid values are `registered|expired|pending|not_applicable|suspended`',
    `gmp_certification_status` STRING COMMENT 'Overall current Good Manufacturing Practice (cGMP) certification status of the site indicating compliance with pharmaceutical quality standards. Certified means site has passed recent GMP inspection, expired means certification has lapsed, pending means inspection scheduled, not certified means site has not been inspected or failed inspection, conditional means certification granted with specific conditions or CAPA requirements.. Valid values are `certified|expired|pending|not_certified|conditional`',
    `iso_9001_certification_date` DATE COMMENT 'Date when the site received ISO 9001 certification. ISO 9001 certificates are typically valid for three years with annual surveillance audits.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the site holds ISO 9001 Quality Management System certification. While not required for pharmaceutical manufacturing, ISO 9001 certification demonstrates commitment to quality management best practices.',
    `last_gmp_inspection_date` DATE COMMENT 'Date of the most recent GMP inspection conducted by any regulatory authority (FDA, EMA, PMDA, MHRA, etc.). Used to track inspection frequency and predict next inspection window.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the manufacturing site record was last updated in the master data system. Critical for change tracking and data governance.',
    `mes_site_identifier` STRING COMMENT 'Unique identifier for the site in the Manufacturing Execution System (MES). Used to link batch records, equipment data, and process parameters to the physical manufacturing location.',
    `next_gmp_inspection_due_date` DATE COMMENT 'Expected or scheduled date for the next GMP inspection. Typically inspections occur every 2-3 years for routine surveillance or more frequently for sites with compliance issues or new product approvals.',
    `operational_status` STRING COMMENT 'Current operational state of the manufacturing site indicating whether the facility is actively producing, temporarily offline, permanently closed, being built, in validation phase, or suspended due to regulatory or quality issues.. Valid values are `operational|temporarily_closed|decommissioned|under_construction|startup|suspended`',
    `ownership_type` STRING COMMENT 'Indicates whether the site is owned and operated internally by the company, operated by a Contract Manufacturing Organization (CMO), a Contract Development and Manufacturing Organization (CDMO), or a joint venture partnership.. Valid values are `internal|cmo|cdmo|joint_venture`',
    `pat_capability` BOOLEAN COMMENT 'Indicates whether the site has Process Analytical Technology (PAT) capabilities for real-time monitoring and control of critical process parameters (CPP) and critical quality attributes (CQA) during manufacturing. PAT enables continuous process verification and improved process understanding.',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the manufacturing site. Used for regulatory authority communications, audit scheduling, and emergency contact.',
    `pics_membership_status` STRING COMMENT 'Indicates whether the site is located in a PIC/S member country, enabling mutual recognition of GMP inspections across participating regulatory authorities. Member status facilitates international regulatory acceptance.. Valid values are `member|non_member|applicant`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the manufacturing site address. Used for logistics, shipping, and regulatory correspondence.',
    `qbd_implementation_status` STRING COMMENT 'Indicates the level of Quality by Design (QbD) principles implementation at the site. QbD is a systematic approach to pharmaceutical development that begins with predefined objectives and emphasizes product and process understanding based on sound science and quality risk management.. Valid values are `fully_implemented|partially_implemented|not_implemented|planned`',
    `quality_management_system` STRING COMMENT 'Primary Quality Management System platform deployed at the site for managing deviations, CAPA (Corrective and Preventive Action), change control, and document management. Critical for compliance and audit readiness.. Valid values are `mastercontrol|trackwise|veeva_quality|sap_qm|other`',
    `site_code` STRING COMMENT 'Unique business identifier code for the manufacturing site used across enterprise systems and regulatory submissions. Typically alphanumeric code assigned by corporate master data management.. Valid values are `^[A-Z0-9]{4,12}$`',
    `site_name` STRING COMMENT 'Official legal or business name of the manufacturing facility as registered with regulatory authorities and used in regulatory submissions.',
    `site_type` STRING COMMENT 'Classification of the primary manufacturing capability of the site. API manufacturing produces active pharmaceutical ingredients (drug substance), formulation creates drug product, fill-finish performs sterile filling operations, packaging performs secondary packaging, combination sites perform multiple operations, and analytical testing sites perform quality control testing.. Valid values are `api_manufacturing|formulation|fill_finish|packaging|combination|analytical_testing`',
    `state_province` STRING COMMENT 'State, province, or regional administrative division where the site is located. Required for regulatory jurisdiction determination and tax compliance.',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Master data for physical manufacturing facilities including owned sites and CMO/CDMO contract sites. Captures site name, site code, address, country, site type (API manufacturing, formulation, fill-finish, packaging, combination), GMP certification status, regulatory approval status (FDA, EMA, PMDA registered), site capacity, site owner (internal vs CMO/CDMO), ERP plant code, and operational status. Serves as the SSOT for manufacturing location master data within the manufacturing domain.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` (
    `line_id` BIGINT COMMENT 'Unique identifier for the manufacturing line. Primary key.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Production lines have dedicated budgets for maintenance, validation campaigns, and operating costs tracked separately from site-level budgets for line-level financial performance and capacity planning',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site where this line is located. Links to the site master data for facility-level context.',
    `automation_level` STRING COMMENT 'Degree of automation for the manufacturing line. Continuous manufacturing represents advanced Process Analytical Technology (PAT) and Quality by Design (QbD) implementations.. Valid values are `manual|semi-automated|fully-automated|continuous-manufacturing`',
    `capacity_kg_per_batch` DECIMAL(18,2) COMMENT 'Maximum batch size capacity in kilograms for bulk processing lines such as granulation, blending, or Active Pharmaceutical Ingredient (API) synthesis. Null for unit-based lines.',
    `capacity_units_per_hour` DECIMAL(18,2) COMMENT 'Rated production capacity of the line expressed as units per hour. For solid dosage forms, this represents tablets or capsules per hour; for liquids, vials or bottles per hour.',
    `changeover_time_hours` DECIMAL(18,2) COMMENT 'Average time in hours required to perform a product changeover on this manufacturing line, including cleaning, setup, and line clearance activities per Good Manufacturing Practice (GMP) requirements.',
    `cleaning_validation_status` STRING COMMENT 'Current status of cleaning validation for the manufacturing line. Critical for preventing cross-contamination and ensuring compliance with Current Good Manufacturing Practice (cGMP) per 21 CFR Part 211.. Valid values are `validated|pending|expired|not-required`',
    `cleanroom_classification` STRING COMMENT 'ISO 14644 or European Union (EU) Good Manufacturing Practice (GMP) Annex 1 cleanroom classification for the manufacturing line environment. Critical for sterile and aseptic manufacturing operations. [ENUM-REF-CANDIDATE: ISO-5|ISO-6|ISO-7|ISO-8|Grade-A|Grade-B|Grade-C|Grade-D|non-classified — 9 candidates stripped; promote to reference product]',
    `cmo_cdmo_name` STRING COMMENT 'Name of the Contract Manufacturing Organization (CMO) or Contract Development and Manufacturing Organization (CDMO) operating this line, if applicable. Null for internally operated lines.',
    `cmo_cdmo_operated` BOOLEAN COMMENT 'Indicates whether this manufacturing line is operated by a Contract Manufacturing Organization (CMO) or Contract Development and Manufacturing Organization (CDMO) rather than owned and operated internally.',
    `commissioning_date` DATE COMMENT 'Date when the manufacturing line was commissioned and became operational. Used for asset lifecycle management and depreciation tracking.',
    `cost_center` STRING COMMENT 'Financial cost center code to which manufacturing costs for this line are allocated. Links to the Enterprise Resource Planning (ERP) financial module for Cost of Goods Sold (COGS) tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this manufacturing line record was first created in the system. Audit trail field.',
    `decommissioning_date` DATE COMMENT 'Date when the manufacturing line was decommissioned and taken out of service. Null for active lines.',
    `dosage_form_type` STRING COMMENT 'Type of Finished Dosage Form (FDF) produced on this manufacturing line. Aligns with regulatory submissions and product master data. [ENUM-REF-CANDIDATE: tablet|capsule|injectable|lyophilized-vial|suspension|solution|cream|ointment|patch|inhaler — 10 candidates stripped; promote to reference product]',
    `environmental_monitoring_required` BOOLEAN COMMENT 'Indicates whether the manufacturing line requires environmental monitoring for viable and non-viable particulates per Good Manufacturing Practice (GMP) Annex 1 for sterile manufacturing.',
    `equipment_train_composition` STRING COMMENT 'Comma-separated list or description of major equipment units that comprise the manufacturing line, such as Mixer-Granulator-Dryer-Mill or Filling Machine-Capper-Labeler. Supports equipment traceability and maintenance planning.',
    `inspection_outcome` STRING COMMENT 'Outcome classification from the most recent regulatory inspection. Food and Drug Administration (FDA) uses classifications such as No Action Indicated (NAI), Voluntary Action Indicated (VAI), and Official Action Indicated (OAI).. Valid values are `no-observations|voluntary-action-indicated|official-action-indicated|not-inspected`',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance activity performed on the manufacturing line. Supports equipment reliability and Overall Equipment Effectiveness (OEE) tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this manufacturing line record was last updated. Audit trail field for change tracking.',
    `line_code` STRING COMMENT 'Business identifier code for the manufacturing line, used in production scheduling, batch records, and Manufacturing Execution System (MES). Typically alphanumeric and unique within a site.. Valid values are `^[A-Z0-9]{3,20}$`',
    `line_name` STRING COMMENT 'Human-readable name or designation of the manufacturing line, such as Tablet Compression Line 3 or Sterile Fill-Finish Suite A.',
    `line_type` STRING COMMENT 'Classification of the manufacturing line by its primary production function. Defines the type of manufacturing operation performed on this line. [ENUM-REF-CANDIDATE: granulation|blending|compression|coating|filling|lyophilization|packaging|inspection|labeling|serialization — 10 candidates stripped; promote to reference product]',
    `mes_integration_status` STRING COMMENT 'Indicates whether the manufacturing line is integrated with the Manufacturing Execution System (MES) for real-time batch tracking, Critical Process Parameter (CPP) monitoring, and electronic batch record generation.. Valid values are `integrated|partial|not-integrated`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this manufacturing line record. Supports audit trail and compliance with 21 CFR Part 11 electronic signature requirements.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance activity. Used for production scheduling and capacity planning to avoid conflicts with manufacturing campaigns.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special considerations, or operational remarks about the manufacturing line.',
    `oee_target_percent` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness (OEE) percentage for this manufacturing line. OEE is a key performance indicator combining availability, performance, and quality metrics.',
    `operational_status` STRING COMMENT 'Current operational state of the manufacturing line. Indicates whether the line is available for production, actively running, undergoing maintenance, or out of service.. Valid values are `available|in-use|under-maintenance|under-qualification|decommissioned|quarantined`',
    `pat_enabled` BOOLEAN COMMENT 'Indicates whether the line is equipped with Process Analytical Technology (PAT) tools for real-time monitoring and control of Critical Quality Attributes (CQA) and Critical Process Parameters (CPP).',
    `product_family` STRING COMMENT 'Primary product family or therapeutic category manufactured on this line, such as Oncology Tablets, Sterile Injectables, or Oral Solid Dosage Forms. Supports product-line affinity and changeover planning.',
    `qualification_expiry_date` DATE COMMENT 'Date when the current qualification or validation of the manufacturing line expires and requalification is required. Critical for compliance with Current Good Manufacturing Practice (cGMP) and Quality by Design (QbD) principles.',
    `regulatory_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection by Food and Drug Administration (FDA), European Medicines Agency (EMA), or other regulatory authority. Critical for Pre-Approval Inspection (PAI) and ongoing compliance tracking.',
    `serialization_capable` BOOLEAN COMMENT 'Indicates whether the manufacturing line is equipped with serialization and track-and-trace capabilities to comply with Drug Supply Chain Security Act (DSCSA) and Falsified Medicines Directive (FMD) requirements.',
    `shift_pattern` STRING COMMENT 'Operating shift pattern for the manufacturing line. Determines production capacity and labor planning requirements.. Valid values are `single-shift|two-shift|three-shift|continuous|campaign-based`',
    `validated_status` STRING COMMENT 'Current validation state of the manufacturing line under Computer System Validation (CSV) and process validation requirements per 21 CFR Part 11 and Good Manufacturing Practice (GMP) guidelines.. Valid values are `validated|qualification-in-progress|not-validated|revalidation-required`',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Master data for individual production lines, suites, or manufacturing units within a site. Captures line code, line name, line type (granulation, blending, compression, coating, filling, lyophilization, packaging), associated site, capacity (units/hour or kg/batch), equipment train composition, cleanroom classification, validated status, current operational status (available, in-use, under maintenance, decommissioned), and qualification expiry date. Enables production scheduling and capacity planning at the line level.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` (
    `equipment_id` BIGINT COMMENT 'Unique identifier for the manufacturing equipment asset. Primary key.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Major GMP equipment has dedicated budgets for qualification programs, calibration, and preventive maintenance requiring linkage for equipment lifecycle cost tracking and capital planning decisions.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: GMP-critical equipment is capitalized as fixed assets requiring depreciation calculation, net book value tracking, asset retirement planning, and regulatory documentation for FDA/EMA inspections.',
    `line_id` BIGINT COMMENT 'Identifier of the specific manufacturing line or production area where this equipment is assigned. Nullable for equipment not assigned to a specific line (e.g., utilities, mobile equipment).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Equipment ownership assignment is standard for maintenance accountability, calibration scheduling coordination, deviation investigation ownership, and qualification lifecycle management. Critical for ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Tracks original procurement transaction for capital equipment. Critical for asset accounting, warranty validation, depreciation calculations, and audit trail. Links equipment.purchase_order_number (de',
    `site_id` BIGINT COMMENT 'Identifier of the manufacturing site or facility where this equipment is installed.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Equipment is procured from vendors; links asset to supplier for warranty management, spare parts sourcing, service contract management, and vendor performance evaluation. Essential for capital asset l',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase cost of the equipment in the currency specified in acquisition_cost_currency.',
    `acquisition_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `asset_criticality` STRING COMMENT 'Business criticality classification of the equipment based on impact to production, product quality, and regulatory compliance. Critical assets require highest priority for maintenance and spare parts availability.. Valid values are `critical|high|medium|low`',
    `calibration_frequency_days` STRING COMMENT 'Number of days between required calibrations for this equipment, as defined in the calibration program.',
    `calibration_status` STRING COMMENT 'Current calibration status of the equipment. Indicates whether the equipments measurement and control systems are within acceptable tolerances.. Valid values are `not_calibrated|calibrated|calibration_due|overdue|not_applicable`',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the equipment capacity value (e.g., liters for reactors, tablets per hour for tablet presses, vials per hour for filling lines). [ENUM-REF-CANDIDATE: liters|kilograms|tablets_per_hour|vials_per_hour|units_per_batch|square_meters|cubic_meters — 7 candidates stripped; promote to reference product]',
    `capacity_value` DECIMAL(18,2) COMMENT 'Nominal production capacity or throughput of the equipment. The unit of measure is specified in capacity_unit_of_measure.',
    `clean_room_classification` STRING COMMENT 'ISO 14644-1 clean room classification of the area where the equipment is installed. Applicable for equipment in controlled environments for sterile or aseptic manufacturing. [ENUM-REF-CANDIDATE: iso_3|iso_4|iso_5|iso_6|iso_7|iso_8|non_classified — 7 candidates stripped; promote to reference product]',
    `commissioning_date` DATE COMMENT 'Date when the equipment was commissioned and made ready for qualification activities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment master record was first created in the system.',
    `csv_status` STRING COMMENT 'Validation status for computerized equipment systems per 21 CFR Part 11 requirements. Applicable to equipment with electronic controls, data acquisition, or automated processes.. Valid values are `not_applicable|not_validated|validation_in_progress|validated|revalidation_required`',
    `equipment_category` STRING COMMENT 'High-level categorization of equipment by operational function: production (API/DP manufacturing), packaging (primary/secondary), quality control (testing/inspection), utilities (water/HVAC/compressed air), or support (material handling/storage).. Valid values are `production|packaging|quality_control|utilities|support`',
    `equipment_description` STRING COMMENT 'Detailed description of the equipment including its purpose, key features, and operational characteristics.',
    `equipment_name` STRING COMMENT 'Descriptive name of the equipment asset (e.g., Reactor-101, Tablet Press Line 3, Lyophilizer A).',
    `equipment_type` STRING COMMENT 'Classification of the equipment based on its function in the manufacturing process. Includes primary manufacturing equipment, utilities, and support systems. [ENUM-REF-CANDIDATE: reactor|blender|granulator|tablet_press|capsule_filler|coating_machine|lyophilizer|autoclave|filling_machine|packaging_line|labeling_machine|inspection_system|fermentor|centrifuge|dryer|mill|sifter|homogenizer|mixer|sterilizer|isolator|laminar_flow_hood|clean_room_hvac|water_system|compressed_air_system|nitrogen_generator|other — 27 candidates stripped; promote to reference product]',
    `gmp_critical_flag` BOOLEAN COMMENT 'Indicates whether this equipment is classified as GMP-critical, meaning it directly impacts product quality, safety, or efficacy and requires enhanced qualification, calibration, and change control.',
    `installation_date` DATE COMMENT 'Date when the equipment was physically installed at the manufacturing site.',
    `iq_completion_date` DATE COMMENT 'Date when Installation Qualification was successfully completed and approved.',
    `last_calibration_date` DATE COMMENT 'Date when the equipment was last calibrated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment master record was last updated.',
    `last_pm_date` DATE COMMENT 'Date when the last scheduled preventive maintenance was completed on this equipment.',
    `model_number` STRING COMMENT 'Manufacturers model number or designation for the equipment.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next calibration of the equipment to maintain measurement accuracy and GMP compliance.',
    `next_pm_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity on this equipment.',
    `next_qualification_due_date` DATE COMMENT 'Scheduled date for the next periodic requalification of the equipment to maintain GMP compliance.',
    `operational_status` STRING COMMENT 'Current operational state of the equipment. Operational indicates the equipment is available for production use; under_maintenance indicates scheduled or unscheduled maintenance; quarantined indicates the equipment is restricted from use pending investigation; decommissioned indicates permanent removal from service. [ENUM-REF-CANDIDATE: operational|under_maintenance|quarantined|decommissioned|idle|startup|shutdown — 7 candidates stripped; promote to reference product]',
    `oq_completion_date` DATE COMMENT 'Date when Operational Qualification was successfully completed and approved.',
    `pq_completion_date` DATE COMMENT 'Date when Performance Qualification was successfully completed and approved, confirming the equipment consistently performs as intended in the production environment.',
    `qualification_status` STRING COMMENT 'Current qualification status of the equipment per Good Manufacturing Practice (GMP) requirements. Tracks progression through Installation Qualification (IQ), Operational Qualification (OQ), and Performance Qualification (PQ). [ENUM-REF-CANDIDATE: not_qualified|iq_in_progress|iq_complete|oq_in_progress|oq_complete|pq_in_progress|pq_complete|qualified|requalification_required — 9 candidates stripped; promote to reference product]',
    `sap_equipment_number` STRING COMMENT 'Equipment master record number in SAP PM module used for maintenance planning, work orders, and asset tracking.. Valid values are `^[0-9]{8,10}$`',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific equipment unit.',
    `tag_number` STRING COMMENT 'Unique alphanumeric tag number assigned to the equipment for identification and tracking purposes in the manufacturing facility. This is the business identifier used in operations and maintenance.. Valid values are `^[A-Z0-9]{3,20}$`',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty coverage for this equipment expires.',
    CONSTRAINT pk_equipment PRIMARY KEY(`equipment_id`)
) COMMENT 'Master data for manufacturing equipment assets including reactors, blenders, granulators, tablet presses, filling machines, lyophilizers, autoclaves, and packaging lines. Captures equipment ID (tag number), equipment name, equipment type, manufacturer, model, serial number, installation date, qualification status (IQ/OQ/PQ), next qualification due date, calibration status, next calibration due date, associated manufacturing line and site, current status (operational, under maintenance, quarantined, decommissioned), and SAP PM equipment number. Supports equipment scheduling and GMP compliance.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` (
    `equipment_qualification_id` BIGINT COMMENT 'Unique identifier for the equipment qualification record. Primary key for this entity.',
    `equipment_id` BIGINT COMMENT 'Reference to the manufacturing equipment being qualified. Links to the equipment master record.',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Equipment qualification protocols (IQ/OQ/PQ) are written to satisfy specific GXP requirements (21 CFR Part 211.63, EU GMP Annex 15). Required for regulatory submissions, inspection readiness, and vali',
    `line_id` BIGINT COMMENT 'Reference to the specific production line where the equipment operates. Provides manufacturing context for the qualification.',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing facility where the equipment is installed and qualified. Links to the site master data.',
    `acceptance_criteria_summary` STRING COMMENT 'Summary of the key acceptance criteria defined in the qualification protocol. Defines the pass/fail thresholds for qualification tests.',
    `capa_reference_number` STRING COMMENT 'Reference number of the associated Corrective and Preventive Action (CAPA) record if corrective action was required. Links to the Quality Management System (QMS).. Valid values are `^[A-Z0-9-]{6,30}$`',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether Corrective and Preventive Action (CAPA) is required based on qualification results. True if failures or significant deviations necessitate formal corrective action.',
    `comments` STRING COMMENT 'Additional comments, observations, or notes related to the qualification activity. Captures context not covered by structured fields.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this qualification record. Required for 21 CFR Part 11 compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system. Audit trail field for record lifecycle tracking.',
    `csv_category` STRING COMMENT 'Computer System Validation (CSV) category per Good Automated Manufacturing Practice (GAMP) 5 guidelines. Category 3 (non-configured products), Category 4 (configured products), and Category 5 (custom applications) require different validation approaches.. Valid values are `Category 1|Category 2|Category 3|Category 4|Category 5`',
    `deviation_count` STRING COMMENT 'Number of deviations from the qualification protocol that occurred during execution. Each deviation requires documentation and impact assessment per Good Manufacturing Practice (GMP).',
    `engineering_approval_date` DATE COMMENT 'Date when the Engineering department formally approved the qualification from a technical perspective.',
    `engineering_approver_name` STRING COMMENT 'Full name of the Engineering representative who reviewed and approved the technical aspects of the qualification.',
    `execution_end_date` DATE COMMENT 'Date when qualification testing activities were completed. Marks the conclusion of all qualification tests defined in the protocol.',
    `execution_start_date` DATE COMMENT 'Date when qualification testing activities commenced. Marks the beginning of the qualification execution phase.',
    `gmp_impact_classification` STRING COMMENT 'Classification of the equipment based on its impact on product quality and Good Manufacturing Practice (GMP) compliance. GMP Critical equipment directly impacts product quality and requires full qualification.. Valid values are `GMP Critical|GMP Non-Critical|GMP Impact|Non-GMP`',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this qualification record. Required for 21 CFR Part 11 compliance and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last modified. Audit trail field for change tracking per 21 CFR Part 11.',
    `next_requalification_date` DATE COMMENT 'Scheduled date for the next periodic requalification of the equipment. Ensures ongoing compliance with Current Good Manufacturing Practice (cGMP) requirements.',
    `qualification_lead_email` STRING COMMENT 'Email address of the qualification lead for communication and coordination purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `qualification_lead_name` STRING COMMENT 'Full name of the individual responsible for leading and coordinating the qualification activities. Primary point of contact for the qualification project.',
    `qualification_outcome` STRING COMMENT 'Final result of the qualification activity indicating whether the equipment met all acceptance criteria defined in the qualification protocol.. Valid values are `Pass|Fail|Pass with Deviation|Conditional Pass`',
    `qualification_protocol_number` STRING COMMENT 'Unique protocol document number that defines the qualification test plan and acceptance criteria. Externally-known business identifier for this qualification activity.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `qualification_scope_description` STRING COMMENT 'Detailed description of the qualification scope including systems, subsystems, and Critical Process Parameters (CPP) or Critical Quality Attributes (CQA) being validated.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification activity. Tracks progression from planning through execution to final outcome. [ENUM-REF-CANDIDATE: Planned|In Progress|Completed|Passed|Failed|On Hold|Cancelled — 7 candidates stripped; promote to reference product]',
    `qualification_type` STRING COMMENT 'Type of qualification activity performed. IQ (Installation Qualification) verifies equipment is installed correctly; OQ (Operational Qualification) verifies equipment operates within specified parameters; PQ (Performance Qualification) verifies equipment consistently produces quality product under normal operating conditions.. Valid values are `IQ|OQ|PQ|Requalification|Concurrent Validation|Retrospective Validation`',
    `quality_approval_date` DATE COMMENT 'Date when the Quality Assurance unit formally approved the qualification results and released the equipment for production use.',
    `quality_approver_name` STRING COMMENT 'Full name of the Quality Assurance (QA) representative who reviewed and approved the qualification results. Required for Good Manufacturing Practice (GMP) compliance.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this qualification is part of a regulatory submission package (New Drug Application (NDA), Biologics License Application (BLA), or Marketing Authorization Application (MAA)). True if qualification data will be submitted to regulatory authorities.',
    `regulatory_submission_reference` STRING COMMENT 'Reference number of the regulatory submission (New Drug Application (NDA), Biologics License Application (BLA), Marketing Authorization Application (MAA)) that includes this qualification data.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `risk_assessment_reference` STRING COMMENT 'Reference number of the risk assessment document that informed the qualification strategy. Aligns with Quality by Design (QbD) principles.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `test_cases_executed_count` STRING COMMENT 'Total number of test cases executed during the qualification activity. Provides a measure of qualification scope and thoroughness.',
    `test_cases_failed_count` STRING COMMENT 'Number of test cases that did not meet acceptance criteria during qualification execution. Triggers investigation and Corrective and Preventive Action (CAPA) if applicable.',
    `test_cases_passed_count` STRING COMMENT 'Number of test cases that met acceptance criteria during qualification execution. Used to calculate pass rate.',
    `validation_report_number` STRING COMMENT 'Document number of the validation report that summarizes qualification results, deviations, and conclusions. Links to the formal documentation package.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `vendor_name` STRING COMMENT 'Name of the vendor or Original Equipment Manufacturer (OEM) who supplied the equipment. Important for vendor qualification and audit trail.',
    `vendor_qualification_status` STRING COMMENT 'Current qualification status of the equipment vendor. Vendors must be qualified before their equipment can be used in Good Manufacturing Practice (GMP) production.. Valid values are `Qualified|Not Qualified|Qualification Pending|Requalification Required`',
    CONSTRAINT pk_equipment_qualification PRIMARY KEY(`equipment_qualification_id`)
) COMMENT 'Records of equipment qualification activities including Installation Qualification (IQ), Operational Qualification (OQ), and Performance Qualification (PQ) as required under cGMP and 21 CFR Part 211. Captures qualification type, equipment reference, qualification protocol number, execution date, qualification outcome (pass/fail), next requalification date, approver, and associated validation report reference. Tracks the qualification lifecycle for each piece of equipment to ensure GMP compliance and readiness for production use.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` (
    `production_schedule_id` BIGINT COMMENT 'Unique identifier for the production schedule record. Primary key.',
    `campaign_plan_id` BIGINT COMMENT 'Identifier of the production campaign plan to which this schedule belongs, enabling grouping of related production runs.',
    `drug_product_id` BIGINT COMMENT 'Identifier of the drug substance (DS) or drug product (DP) scheduled for production.',
    `line_id` BIGINT COMMENT 'Identifier of the specific manufacturing line or production line within the site for which this schedule applies.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plan. Business justification: Production schedules execute supply plans. S&OP process requires linking scheduled production runs to the supply plan version that authorized them for plan vs. actual variance tracking and capacity co',
    `employee_id` BIGINT COMMENT 'Identifier of the production planner or scheduler responsible for creating and maintaining this schedule.',
    `production_order_id` BIGINT COMMENT 'Identifier of the production order scheduled on this manufacturing line during the planning period.',
    `site_id` BIGINT COMMENT 'Identifier of the manufacturing site or plant where production is scheduled to occur.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the production schedule was approved for execution.',
    `batch_quantity_planned` STRING COMMENT 'Number of batches planned for production during the scheduled period.',
    `batch_size_planned` DECIMAL(18,2) COMMENT 'Planned quantity or batch size for the scheduled production run, expressed in the products unit of measure.',
    `campaign_type` STRING COMMENT 'Type of production campaign (e.g., single-product campaign, multi-product campaign, validation campaign).. Valid values are `single_product|multi_product|validation|clinical|commercial`',
    `capacity_utilization_percent` DECIMAL(18,2) COMMENT 'Planned capacity utilization percentage for the manufacturing line during the scheduled period.',
    `cgmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether this production schedule has been reviewed and confirmed to comply with cGMP requirements per 21 CFR Parts 210 and 211.',
    `cmo_cdmo_flag` BOOLEAN COMMENT 'Indicates whether this production schedule involves a CMO or CDMO partner rather than internal manufacturing.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this production schedule record was first created in the system.',
    `downtime_reason` STRING COMMENT 'Reason for the scheduled downtime window (e.g., preventive maintenance, line cleaning, product changeover). [ENUM-REF-CANDIDATE: maintenance|cleaning|changeover|validation|calibration|inspection|other — 7 candidates stripped; promote to reference product]',
    `downtime_window_end_timestamp` TIMESTAMP COMMENT 'End timestamp of any scheduled downtime window for maintenance, cleaning, or changeover activities.',
    `downtime_window_start_timestamp` TIMESTAMP COMMENT 'Start timestamp of any scheduled downtime window for maintenance, cleaning, or changeover activities.',
    `executed_timestamp` TIMESTAMP COMMENT 'Date and time when the production schedule was marked as executed or completed.',
    `frozen_timestamp` TIMESTAMP COMMENT 'Date and time when the production schedule was frozen, preventing further changes without formal change control.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this production schedule record was last modified or updated.',
    `pat_implementation_flag` BOOLEAN COMMENT 'Indicates whether Process Analytical Technology is implemented for real-time monitoring during the scheduled production.',
    `planning_period_end_date` DATE COMMENT 'End date of the planning horizon covered by this production schedule.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning horizon covered by this production schedule.',
    `priority_level` STRING COMMENT 'Priority level assigned to this production schedule, influencing resource allocation and sequencing decisions.. Valid values are `critical|high|medium|low`',
    `qbd_principles_applied_flag` BOOLEAN COMMENT 'Indicates whether Quality by Design principles have been applied in the development of this production schedule.',
    `schedule_notes` STRING COMMENT 'Free-text notes or comments related to the production schedule, capturing special instructions, constraints, or considerations.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the production schedule indicating its approval and execution state.. Valid values are `draft|approved|frozen|executed|cancelled|revised`',
    `schedule_type` STRING COMMENT 'Type of production schedule indicating the planning level (e.g., master schedule, operational schedule).. Valid values are `master|operational|tactical|strategic`',
    `schedule_version` STRING COMMENT 'Version identifier for the production schedule, enabling tracking of schedule revisions and changes over time.. Valid values are `^[A-Z0-9]{1,20}$`',
    `scheduled_duration_hours` DECIMAL(18,2) COMMENT 'Planned duration of the production run in hours, calculated from scheduled start to end timestamps.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end date and time for the production run on the manufacturing line.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date and time for the production run on the manufacturing line.',
    `supply_chain_planning_system` STRING COMMENT 'Name of the supply chain planning system that generated or influenced this production schedule (e.g., Kinaxis RapidResponse, Blue Yonder).. Valid values are `kinaxis|blue_yonder|sap_ibp|other`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the batch size (e.g., KG for kilograms, L for liters, EA for each).. Valid values are `^[A-Z]{2,6}$`',
    CONSTRAINT pk_production_schedule PRIMARY KEY(`production_schedule_id`)
) COMMENT 'Planned production schedule for manufacturing lines and sites over a defined planning horizon. Captures schedule version, planning period (start/end date), site, manufacturing line, scheduled production orders, planned batch quantities, scheduled downtime windows, campaign plan, and schedule status (draft, approved, frozen, executed). Integrates with SAP PP capacity planning and Kinaxis RapidResponse supply chain planning. Enables capacity utilization analysis and production campaign management.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` (
    `process_parameter_id` BIGINT COMMENT 'Unique identifier for the process parameter definition. Primary key for the process parameter entity.',
    `batch_record_id` BIGINT COMMENT 'Reference to the manufacturing batch for which this parameter measurement was recorded. Links parameter measurements to specific batch execution records.',
    `employee_id` BIGINT COMMENT 'Identifier of the manufacturing operator or technician who recorded or verified this parameter measurement. Required for batch record accountability and Good Manufacturing Practice (GMP) compliance.',
    `equipment_id` BIGINT COMMENT 'Unique identifier of the measuring instrument, sensor, or equipment used to capture this parameter value. Required for traceability, calibration verification, and Computer System Validation (CSV) compliance.',
    `manufacturing_deviation_id` BIGINT COMMENT 'Reference to the deviation record if this parameter measurement triggered an Out of Specification (OOS) or Out of Trend (OOT) investigation. Links to the Quality Management System (QMS) deviation tracking system.',
    `process_step_id` BIGINT COMMENT 'Reference to the specific manufacturing process step where this parameter is measured or controlled. Links to the master process definition.',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual measured or recorded value of this parameter during batch execution. Captured from Manufacturing Execution System (MES), PAT instruments, or manual operator entry. Used for batch record documentation and process validation.',
    `comments` STRING COMMENT 'Free-text field for operator or QA comments regarding this parameter measurement, including explanations for deviations, corrective actions taken, or contextual information for batch record documentation.',
    `conformance_status` STRING COMMENT 'Assessment of whether the measured value meets the defined control and specification limits. Out of Specification (OOS) or Out of Trend (OOT) results trigger investigation and Corrective and Preventive Action (CAPA) processes.. Valid values are `within_specification|within_control|out_of_control|out_of_specification|under_investigation|deviation_raised`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this process parameter record was first created in the system. Part of the audit trail for regulatory compliance and data lineage.',
    `criticality_justification` STRING COMMENT 'Scientific rationale and risk assessment documentation explaining why this parameter is classified as critical or non-critical. Required for regulatory submissions and Quality by Design (QbD) documentation per ICH Q8.',
    `data_integrity_hash` STRING COMMENT 'Cryptographic hash or checksum of the parameter measurement record to ensure data integrity and detect unauthorized modifications. Supports 21 CFR Part 11 electronic signature and audit trail requirements.',
    `data_source_system` STRING COMMENT 'The system or application from which this parameter data originated (e.g., SAP PP, MES, LIMS, PAT instrument software). Required for data lineage and audit trail per 21 CFR Part 11.',
    `effective_end_date` DATE COMMENT 'The date on which this parameter specification version was superseded or retired. Null for currently active specifications. Supports historical batch record interpretation and regulatory compliance.',
    `effective_start_date` DATE COMMENT 'The date from which this parameter specification version became effective. Used to determine which specification applies to historical batch records and supports regulatory audit trails.',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether this parameter measurement requires formal investigation due to exceeding control or specification limits. True triggers Quality Assurance (QA) review and potential Corrective and Preventive Action (CAPA).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this process parameter record was last updated. Supports change tracking and audit trail requirements per 21 CFR Part 11 and Good Manufacturing Practice (GMP).',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'The lower boundary of the normal operating range for this parameter. Values below this trigger investigation but may not require batch rejection. Used for statistical process control and continuous process verification.',
    `lower_specification_limit` DECIMAL(18,2) COMMENT 'The minimum acceptable value for this parameter as defined in regulatory filings and approved specifications. Values below this limit may result in batch rejection or deviation investigation per Current Good Manufacturing Practice (cGMP).',
    `measurement_frequency` STRING COMMENT 'The required frequency or timing for measuring this parameter during batch execution. Defines sampling plan and monitoring requirements per the approved batch record. [ENUM-REF-CANDIDATE: continuous|per_batch|hourly|per_shift|daily|on_demand|at_process_step — 7 candidates stripped; promote to reference product]',
    `measurement_method` STRING COMMENT 'The method by which this parameter is measured or recorded. Indicates whether data is captured through Process Analytical Technology (PAT), manual operator entry, or laboratory testing. [ENUM-REF-CANDIDATE: manual_entry|automated_sensor|pat_instrument|laboratory_analysis|inline_measurement|atline_measurement|offline_measurement — 7 candidates stripped; promote to reference product]',
    `measurement_timestamp` TIMESTAMP COMMENT 'The date and time when this parameter measurement was recorded. Critical for establishing batch record chronology and supporting 21 CFR Part 11 electronic records compliance.',
    `parameter_code` STRING COMMENT 'Unique alphanumeric code identifying the parameter within the manufacturing process. Used for cross-referencing with Manufacturing Execution System (MES) and Process Analytical Technology (PAT) instruments.',
    `parameter_name` STRING COMMENT 'Human-readable name of the process parameter (e.g., Mixing Temperature, Compression Force, pH Level, Dissolution Rate).',
    `parameter_type` STRING COMMENT 'Classification of the parameter based on its impact on product quality. Critical Process Parameters (CPPs) have direct impact on Critical Quality Attributes (CQAs) and require stringent control per Quality by Design (QbD) principles.. Valid values are `critical_process_parameter|non_critical_parameter|critical_quality_attribute|in_process_control`',
    `parameter_version` STRING COMMENT 'Version number of the parameter specification. Incremented when control limits, specification limits, or other parameter attributes are changed through the change control process. Supports regulatory change history requirements.',
    `pat_enabled_flag` BOOLEAN COMMENT 'Indicates whether this parameter is monitored using Process Analytical Technology (PAT) instruments for real-time or near-real-time measurement and control. True if PAT is implemented for this parameter.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether deviations or out-of-specification results for this parameter must be reported to regulatory authorities (FDA, EMA, etc.) as part of annual product reviews or post-approval change protocols.',
    `target_value` DECIMAL(18,2) COMMENT 'The intended setpoint or target value for this parameter as defined in the master batch record or process development documentation. Represents the optimal operating point.',
    `unit_of_measure` STRING COMMENT 'The measurement unit for this parameter (e.g., degrees Celsius, bar, pH units, RPM, minutes, mg/mL). Must be consistent with International System of Units (SI) or industry-standard pharmaceutical units.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'The upper boundary of the normal operating range for this parameter. Values above this trigger investigation but may not require batch rejection. Used for statistical process control and continuous process verification.',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'The maximum acceptable value for this parameter as defined in regulatory filings and approved specifications. Values above this limit may result in batch rejection or deviation investigation per Current Good Manufacturing Practice (cGMP).',
    `verification_timestamp` TIMESTAMP COMMENT 'The date and time when this parameter measurement was reviewed and verified by Quality Assurance (QA) or supervisory personnel. Part of the batch record review and release process.',
    `verified_by` STRING COMMENT 'Identifier of the Quality Assurance (QA) or supervisory personnel who reviewed and verified this parameter measurement. Required for Good Manufacturing Practice (GMP) batch record review.',
    CONSTRAINT pk_process_parameter PRIMARY KEY(`process_parameter_id`)
) COMMENT 'Defines and records Critical Process Parameters (CPPs) and non-critical process parameters for manufacturing processes, including both the specification (target values, control limits, specification limits) from the master batch record and the actual measured values recorded during batch execution from MES, PAT instruments, or manual entry. Captures parameter name, type (CPP vs non-critical), process step, target value, control/specification limits, unit of measure, measurement frequency, PAT indicator, and per-batch actual measurements with timestamps, instrument IDs, and pass/fail status. Supports QbD principles, process validation, CPV trending, and regulatory inspection readiness per ICH Q8/Q9/Q10.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` (
    `process_parameter_result_id` BIGINT COMMENT 'Unique identifier for the process parameter result record. Primary key for this entity.',
    `batch_record_id` BIGINT COMMENT 'Reference to the manufacturing batch in which this parameter was measured. Links to the batch master record.',
    `equipment_id` BIGINT COMMENT 'Reference to the instrument, sensor, or equipment used to capture the measurement. Links to equipment master for calibration and qualification tracking.',
    `manufacturing_deviation_id` BIGINT COMMENT 'Reference to the deviation or OOS investigation record if this measurement triggered a deviation. Null if no deviation occurred.',
    `employee_id` BIGINT COMMENT 'Reference to the operator or technician who recorded or verified the measurement. Links to employee master for audit trail.',
    `process_parameter_id` BIGINT COMMENT 'Reference to the parameter definition in the master batch record or parameter library. Links to the parameter specification.',
    `process_step_id` BIGINT COMMENT 'Reference to the specific manufacturing process step or unit operation where this parameter was measured (e.g., blending, granulation, coating, fill-finish).',
    `sample_id` BIGINT COMMENT 'Identifier for the physical sample taken for laboratory testing, if applicable. Links to LIMS for IPC test results.',
    `batch_number` STRING COMMENT 'Human-readable batch number or lot number for traceability and regulatory reporting. Denormalized for query performance.',
    `comments` STRING COMMENT 'Free-text comments or observations recorded by the operator or system regarding the measurement, including any contextual notes or anomalies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this process parameter result record was first created in the system. Audit trail field.',
    `data_source` STRING COMMENT 'System or source from which the measurement data originated: MES (Manufacturing Execution System), SCADA (Supervisory Control and Data Acquisition), LIMS (Laboratory Information Management System), Manual Entry, PAT System, ELN (Electronic Lab Notebook).. Valid values are `MES|SCADA|LIMS|Manual Entry|PAT System|ELN`',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether this measurement triggered a process deviation or Out of Specification (OOS) event requiring investigation and CAPA.',
    `evaluation_result` STRING COMMENT 'Result of comparing the measured value against specification limits: Pass (within limits), Fail (out of specification), Warning (approaching limits), Not Evaluated (no limits defined).. Valid values are `Pass|Fail|Warning|Not Evaluated`',
    `instrument_code` STRING COMMENT 'Human-readable code or tag number of the instrument or equipment (e.g., TMP-101, PRS-205). Denormalized for traceability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this process parameter result record was last modified. Audit trail field for change tracking.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Lower acceptable limit for the parameter as defined in the master batch record or process specification. Used for pass/fail evaluation.',
    `measured_value` DECIMAL(18,2) COMMENT 'Actual measured value of the process parameter as recorded during batch execution. This is the primary result field.',
    `measurement_method` STRING COMMENT 'Method by which the parameter was measured: Manual (operator entry), Automated (MES/SCADA), PAT (real-time analyzer), Laboratory (offline test).. Valid values are `Manual|Automated|PAT|SCADA|Laboratory`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the parameter measurement was taken or recorded. Critical for batch chronology and process validation.',
    `operator_name` STRING COMMENT 'Name of the operator or technician who recorded the measurement. Denormalized for audit and compliance reporting.',
    `parameter_type` STRING COMMENT 'Classification of the parameter: CPP (Critical Process Parameter), Non-Critical (monitored but not critical), IPC (In-Process Control test result), PAT (Process Analytical Technology real-time measurement).. Valid values are `CPP|Non-Critical|IPC|PAT`',
    `pat_indicator` BOOLEAN COMMENT 'Indicates whether this measurement was captured using Process Analytical Technology (PAT) real-time monitoring tools per FDA PAT guidance.',
    `record_status` STRING COMMENT 'Lifecycle status of the parameter result record: Active (current and valid), Superseded (replaced by corrected value), Voided (invalidated), Archived (historical, no longer active).. Valid values are `Active|Superseded|Voided|Archived`',
    `sampling_point` STRING COMMENT 'Physical location or sampling point within the process equipment where the measurement was taken (e.g., Inlet, Outlet, Mid-Point, Probe Location).',
    `target_value` DECIMAL(18,2) COMMENT 'Target or setpoint value for the parameter as defined in the master batch record. Used for comparison and deviation detection.',
    `test_method_reference` STRING COMMENT 'Reference to the validated test method or Standard Operating Procedure (SOP) used for the measurement (e.g., SOP-QC-1234, USP Method 621).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the measured value (e.g., Celsius, bar, pH units, RPM, L/min, %RH). Critical for interpretation and compliance.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Upper acceptable limit for the parameter as defined in the master batch record or process specification. Used for pass/fail evaluation.',
    `verification_status` STRING COMMENT 'Status of the measurement verification by a supervisor or quality assurance: Pending (awaiting review), Verified (approved), Rejected (invalid), Under Review (investigation in progress).. Valid values are `Pending|Verified|Rejected|Under Review`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was verified or approved by a supervisor or quality assurance personnel.',
    CONSTRAINT pk_process_parameter_result PRIMARY KEY(`process_parameter_result_id`)
) COMMENT 'Actual measured values of critical process parameters (CPPs), non-critical process parameters, and in-process control (IPC) results recorded during batch manufacturing execution. Captured from MES, PAT instruments, SCADA systems, or manual entry in the electronic batch record. Captures batch reference, process step, parameter name, parameter type (CPP, non-critical, IPC), measured value, unit of measure, measurement timestamp, measurement method, instrument ID, operator ID, pass/fail evaluation against specification limits defined in the master batch record, deviation flag, and PAT indicator. This entity is the sole SSOT for all in-process parameter measurements — parameter specifications (targets, control limits, acceptance criteria) are owned by master_batch_record while this entity owns all actuals. Provides the complete CPP/CQA data trail for each batch, supporting QbD principles, process validation (Stage 2/3), continued process verification (CPV) trending, statistical process control, and regulatory inspection readiness per ICH Q8/Q9/Q10 and 21 CFR 211.188.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` (
    `manufacturing_deviation_id` BIGINT COMMENT 'Unique identifier for the manufacturing deviation record. Primary key.',
    `batch_record_id` BIGINT COMMENT 'Reference to the manufacturing batch affected by this deviation.',
    `drug_product_id` BIGINT COMMENT 'Reference to the drug product (DP) or drug substance (DS) affected by the deviation.',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment or instrument involved in the deviation, if applicable.',
    `icsr_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.icsr. Business justification: Manufacturing deviations impacting product quality can trigger ICSR reporting when distributed product causes adverse events. Quality-to-safety escalation process required by GMP and pharmacovigilance',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Manufacturing deviations often trigger compliance incidents requiring regulatory reporting (field alerts, recalls, annual product reviews). Essential for regulatory intelligence, risk management, and ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Deviation investigation costs for clinical or validation batches are charged to project-specific internal orders for accurate project cost tracking and capitalization assessment.',
    `patent_litigation_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent_litigation. Business justification: Manufacturing deviations in patent-protected processes may trigger litigation risk assessment, especially for paragraph IV ANDA products where process deviations could impact non-infringement argument',
    `employee_id` BIGINT COMMENT 'Reference to the user or personnel who initiated the deviation record.',
    `quality_capa_id` BIGINT COMMENT 'Reference to the associated CAPA record initiated to address the root cause and prevent recurrence.',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Manufacturing deviations are frequently cited as inspection observations (Form 483, EU GMP non-conformances). Direct link needed for inspection response, CAPA tracking, and trend analysis. Inspectors ',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site or facility where the deviation occurred.',
    `tertiary_manufacturing_approved_by_user_employee_id` BIGINT COMMENT 'Reference to the quality assurance or management user who approved the deviation closure.',
    `batch_number` STRING COMMENT 'Human-readable batch number or lot number associated with the deviation for traceability and reporting.',
    `capa_number` STRING COMMENT 'Human-readable CAPA reference number for traceability and cross-referencing with quality management system.',
    `closure_date` DATE COMMENT 'Date when the deviation record was formally closed after all investigations, actions, and approvals were completed.',
    `cmo_cdmo_flag` BOOLEAN COMMENT 'Indicates whether the deviation occurred at a contract manufacturing organization (CMO) or contract development and manufacturing organization (CDMO) rather than an internal facility.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the deviation record was first created in the system.',
    `detection_date` DATE COMMENT 'Date when the deviation was first identified or detected.',
    `detection_phase` STRING COMMENT 'Manufacturing or quality control phase during which the deviation was detected: in-process (during production), packaging (during fill-finish or labeling), qc_testing (during in-process or final QC), release_testing (during batch release), stability_testing (during ongoing stability studies), post_release (after product distribution).. Valid values are `in_process|packaging|qc_testing|release_testing|stability_testing|post_release`',
    `detection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the deviation was first identified, providing granular traceability for time-sensitive deviations.',
    `deviation_category` STRING COMMENT 'Secondary classification or sub-category providing additional granularity within the deviation type (e.g., temperature excursion, equipment calibration failure, material identity mix-up).',
    `deviation_number` STRING COMMENT 'Business identifier for the deviation, typically system-generated or manually assigned following organizational numbering convention. Used for external reference and tracking.. Valid values are `^DEV-[0-9]{6,10}$`',
    `deviation_type` STRING COMMENT 'Classification of the deviation by root category: process (procedure not followed), equipment (malfunction or failure), material (raw material or component issue), environmental (cleanroom or facility condition), documentation (batch record or SOP error), personnel (training or human error).. Valid values are `process|equipment|material|environmental|documentation|personnel`',
    `immediate_action_taken` STRING COMMENT 'Description of containment or corrective actions taken immediately upon detection to prevent further impact or recurrence during the batch.',
    `impact_assessment` STRING COMMENT 'Evaluation of the deviations impact on product quality, safety, efficacy, and compliance. Includes assessment of affected batches, potential patient risk, and regulatory implications.',
    `investigation_completion_date` DATE COMMENT 'Date when the deviation investigation was completed and root cause determined.',
    `investigation_start_date` DATE COMMENT 'Date when formal investigation of the deviation was initiated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the deviation record was last updated or modified.',
    `manufacturing_area` STRING COMMENT 'Specific production area, cleanroom, or facility location where the deviation occurred (e.g., API synthesis suite, formulation room, fill line 3, packaging hall B).',
    `manufacturing_deviation_description` STRING COMMENT 'Detailed narrative description of the deviation event, including what occurred, when it was observed, and the circumstances surrounding the event.',
    `manufacturing_deviation_status` STRING COMMENT 'Current lifecycle state of the deviation: open (newly identified), under_investigation (root cause analysis in progress), pending_capa (awaiting corrective action), closed (investigation and actions complete), cancelled (determined not to be a deviation).. Valid values are `open|under_investigation|pending_capa|closed|cancelled`',
    `occurrence_date` DATE COMMENT 'Estimated or known date when the deviation actually occurred, which may differ from detection date.',
    `process_step` STRING COMMENT 'Specific manufacturing process step or operation during which the deviation occurred (e.g., blending, granulation, tablet compression, sterile filtration, lyophilization).',
    `product_disposition` STRING COMMENT 'Final disposition decision for the affected batch or product: released (approved for distribution), rejected (destroyed or returned), reworked (reprocessed per approved procedure), quarantined (held pending further evaluation), pending_investigation (disposition not yet determined).. Valid values are `released|rejected|reworked|quarantined|pending_investigation`',
    `qms_system_reference` STRING COMMENT 'External reference identifier from the source quality management system (MasterControl, TrackWise, or other QMS) for integration and traceability.',
    `regulatory_report_date` DATE COMMENT 'Date when the deviation was reported to regulatory authorities, if applicable.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the deviation must be reported to regulatory authorities (FDA, EMA, etc.) based on severity, product impact, or compliance requirements.',
    `root_cause_category` STRING COMMENT 'High-level classification of the identified root cause after investigation (e.g., human error, equipment failure, material defect, procedure inadequacy, environmental control failure).',
    `root_cause_description` STRING COMMENT 'Detailed explanation of the root cause identified through investigation, including contributing factors and evidence supporting the conclusion.',
    `severity` STRING COMMENT 'Impact classification of the deviation: critical (direct impact on product quality, safety, or efficacy), major (potential impact requiring investigation), minor (no expected impact on product quality).. Valid values are `critical|major|minor`',
    CONSTRAINT pk_manufacturing_deviation PRIMARY KEY(`manufacturing_deviation_id`)
) COMMENT 'Records unplanned departures from approved manufacturing procedures, specifications, or batch records during production. Captures deviation number, batch reference, deviation type (process, equipment, material, environmental, documentation), description, severity (critical, major, minor), detection date, detection phase (in-process, packaging, QC testing), root cause category, immediate containment actions, impact assessment, CAPA reference, closure date, and regulatory reportability flag. Integrates with MasterControl/TrackWise QMS. Distinct from quality CAPA records owned by the quality domain.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` (
    `bill_of_materials_id` BIGINT COMMENT 'Unique identifier for the bill of materials record. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: BOMs define material costs for branded products. Essential for cost-of-goods-sold calculations, gross-to-net analysis, commercial profitability reporting, and pricing strategy. Pharma finance requires',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: BOMs list drug substance as primary ingredient with quantity and grade specifications. Essential for API procurement, material master data, cost rollup, and linking manufacturing material requirements',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: BOMs operationalize formulations for manufacturing. Links formulation design (R&D) to manufacturing execution (production). Essential for change control, formulation version management, material requi',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: BOMs must comply with pharmacopeial standards (USP, EP, JP) and GMP requirements for formulation composition (21 CFR 211.84). Essential for regulatory submissions (drug substance/product specification',
    `master_batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.master_batch_record. Business justification: BOMs are tightly coupled with master batch records - the MBR defines the process, the BOM defines the materials. The bill_of_materials table has master_batch_record_reference (STRING) which should be ',
    `medicinal_product_id` BIGINT COMMENT 'FK to product.medicinal_product',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Formulation BOMs must link to composition-of-matter and formulation patents for IP protection verification, licensing compliance, freedom-to-operate clearance, and regulatory submission documentation ',
    `site_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_site. Business justification: BOMs are often site-specific due to equipment differences, local material sourcing, or regulatory requirements. The bill_of_materials table has manufacturing_site_code (STRING) which should be a FK to',
    `allergen_declaration` STRING COMMENT 'Free-text declaration of any known allergens present in the formulation (e.g., lactose, egg protein, soy). Required for labeling and patient safety.',
    `animal_derived_material_flag` BOOLEAN COMMENT 'Indicates whether any component in this BOM is derived from animal sources. Triggers additional TSE/BSE risk assessment and documentation requirements.',
    `api_component_count` STRING COMMENT 'Number of API components in this BOM. Most formulations have 1-3 APIs; combination products may have more.',
    `approval_date` DATE COMMENT 'Date when this BOM version was formally approved for production use. Part of the GMP documentation and audit trail.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized person who approved this BOM version for production use. Typically Quality Assurance or Manufacturing Science.',
    `batch_size` DECIMAL(18,2) COMMENT 'The standard batch size (quantity) for which this BOM is defined. All component quantities are specified relative to this batch size.',
    `batch_size_uom` STRING COMMENT 'Unit of measure for the standard batch size (e.g., kg for bulk API, dose for vaccine, tablet for solid oral dosage). [ENUM-REF-CANDIDATE: kg|L|EA|dose|vial|tablet|capsule — 7 candidates stripped; promote to reference product]',
    `bom_number` STRING COMMENT 'Business identifier for the BOM, externally visible and used in manufacturing execution and procurement systems.. Valid values are `^BOM-[A-Z0-9]{8,12}$`',
    `bom_status` STRING COMMENT 'Current lifecycle status of the BOM. Only active BOMs may be used in production. Superseded BOMs are retained for historical batch traceability.. Valid values are `draft|under_review|approved|active|superseded|obsolete`',
    `bom_version` STRING COMMENT 'Version identifier for the BOM. Incremented when formulation or component changes occur. Critical for change control and regulatory traceability.. Valid values are `^V[0-9]{2,4}$`',
    `change_control_number` STRING COMMENT 'Reference to the change control record that authorized the creation or modification of this BOM version. Required for GMP compliance and audit trail.. Valid values are `^CC-[0-9]{6,10}$`',
    `controlled_substance_flag` BOOLEAN COMMENT 'Indicates whether this BOM includes any DEA-controlled substances requiring special handling, documentation, and security per 21 CFR Part 1300.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this BOM record was first created in the system. Part of audit trail.',
    `effective_date` DATE COMMENT 'The date from which this BOM version becomes effective and may be used in production. Critical for change control and regulatory compliance.',
    `excipient_component_count` STRING COMMENT 'Number of excipient (inactive ingredient) components in this BOM. Includes binders, fillers, preservatives, stabilizers, etc.',
    `expiry_date` DATE COMMENT 'The date after which this BOM version is no longer valid for new production batches. Nullable for currently active BOMs.',
    `gmp_grade_requirement` STRING COMMENT 'The minimum quality grade required for all components in this BOM. Typically GMP or compendial grade for pharmaceutical manufacturing. [ENUM-REF-CANDIDATE: gmp|usp_nf|ep|jp|compendial|food_grade|technical — 7 candidates stripped; promote to reference product]',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicates whether this BOM formulation is certified Halal, relevant for certain markets and patient populations.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicates whether this BOM formulation is certified Kosher, relevant for certain markets and patient populations.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this BOM record. Part of audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this BOM record was last modified. Part of audit trail for change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or comments related to this BOM. May include process considerations or historical context.',
    `overage_percentage` DECIMAL(18,2) COMMENT 'Standard overage percentage applied to component quantities to account for process losses, sampling, and testing. Typically 5-15% depending on process capability.',
    `packaging_component_count` STRING COMMENT 'Number of packaging material components (primary and secondary) in this BOM. Includes vials, stoppers, labels, cartons, inserts.',
    `qbd_design_space_flag` BOOLEAN COMMENT 'Indicates whether this BOM was developed using Quality by Design principles with an established design space per ICH Q8.',
    `regulatory_approval_reference` STRING COMMENT 'Reference to the regulatory submission (NDA, BLA, MAA) that includes this BOM formulation. Critical for ensuring production matches approved formulation.',
    `total_component_count` STRING COMMENT 'Total number of distinct component line items (raw materials, APIs, excipients, packaging) in this BOM. Used for completeness validation.',
    `total_material_cost` DECIMAL(18,2) COMMENT 'Total cost of all materials (API, excipients, packaging) for one standard batch. Used for COGS calculation and pricing analysis. Currency assumed USD unless otherwise specified.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Expected manufacturing yield percentage for this BOM (typically 95-100%). Accounts for normal process losses. Used to calculate actual material requirements.',
    CONSTRAINT pk_bill_of_materials PRIMARY KEY(`bill_of_materials_id`)
) COMMENT 'Manufacturing bill of materials (BOM) defining the complete list of raw materials, APIs, excipients, and packaging components required to produce a specific drug product at a defined batch size, including individual component line items. Captures BOM version, product code, batch size, BOM status (active, superseded), and for each component: sequence number, item code, description, category (DS, excipient, solvent, packaging, label), required quantity, unit of measure, overage allowance, substitution flag, GMP grade requirement, and approved supplier reference. Aligned with SAP PP BOM and master batch record formulation. Supports MRP calculations, material traceability, and procurement.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` (
    `process_validation_id` BIGINT COMMENT 'Unique identifier for the process validation record. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Process validations are brand-specific regulatory requirements. Links manufacturing compliance status to commercial product launch readiness, lifecycle maintenance, and regulatory submission tracking.',
    `drug_product_id` BIGINT COMMENT 'Reference to the drug product (DP) or drug substance (DS) being validated. Links to the product master data.',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment or system being validated. Links to equipment master data for process equipment, cleaning equipment, or computerized systems.',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Process validation is mandated by specific GXP obligations (FDA Process Validation Guidance 2011, EU GMP Annex 15). Essential for regulatory submissions, lifecycle management, and inspection readiness',
    `line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_line. Business justification: Process validations are performed on specific manufacturing lines to demonstrate consistent process performance. While process_validation already links to manufacturing_site and equipment, it should a',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Process validation protocols must reference process patents for regulatory filings (PPQ documentation), technology transfer packages, demonstrating freedom-to-operate, and supporting patent prosecutio',
    `pv_product_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.pv_product. Business justification: Process validation ensures manufacturing quality for products under PV monitoring. Regulatory requirement to link validation status to safety surveillance. Supports assessment of whether process valid',
    `rd_capitalization_id` BIGINT COMMENT 'Foreign key linking to finance.rd_capitalization. Business justification: Successful process validation is a key capitalization milestone demonstrating commercial feasibility, triggering transfer of development costs from expense to intangible asset per GAAP/IFRS.',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site or facility where the validation is being performed. May be internal site or Contract Manufacturing Organization (CMO) / Contract Development and Manufacturing Organization (CDMO) facility.',
    `acceptance_criteria` STRING COMMENT 'Pre-defined acceptance criteria that the validation study must meet to be considered successful. Includes Critical Quality Attributes (CQA) specifications, Critical Process Parameters (CPP) ranges, yield targets, impurity limits, and other quality metrics. Must be established before validation execution.',
    `batch_size_max` DECIMAL(18,2) COMMENT 'Maximum batch size validated in the study, expressed in the unit of measure appropriate for the product. Defines the upper bound of the validated batch size range.',
    `batch_size_min` DECIMAL(18,2) COMMENT 'Minimum batch size validated in the study, expressed in the unit of measure appropriate for the product (kg for API, number of units for finished dosage form). Defines the lower bound of the validated batch size range.',
    `batch_size_uom` STRING COMMENT 'Unit of measure for the batch size (e.g., kg for bulk API, units/tablets/capsules for solid oral dosage forms, vials/syringes for injectables). [ENUM-REF-CANDIDATE: kg|g|L|mL|units|tablets|capsules|vials|syringes — 9 candidates stripped; promote to reference product]',
    `change_control_number` STRING COMMENT 'Reference to the change control record that authorized this validation or revalidation activity. Links validation to the change management process per ICH Q10.',
    `comments` STRING COMMENT 'Additional comments, notes, or observations related to the validation study. May include summary of key findings, lessons learned, or special considerations.',
    `cpp_monitored` STRING COMMENT 'List of Critical Process Parameters (CPP) monitored during the validation study. CPPs are process parameters whose variability has an impact on a CQA and therefore should be monitored or controlled to ensure the process produces the desired quality. Examples include temperature, pressure, mixing time, pH, flow rate.',
    `cqa_monitored` STRING COMMENT 'List of Critical Quality Attributes (CQA) monitored during the validation study. CQAs are physical, chemical, biological, or microbiological properties that should be within an appropriate limit, range, or distribution to ensure the desired product quality. Examples include assay, impurities, dissolution, content uniformity, sterility, endotoxin.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this validation record was first created in the system. Supports audit trail and data lineage requirements per 21 CFR Part 11.',
    `design_space_defined` BOOLEAN COMMENT 'Indicates whether a design space was defined as part of the validation. Design space is the multidimensional combination and interaction of input variables and process parameters that have been demonstrated to provide assurance of quality per ICH Q8. True if design space was established through QbD approach.',
    `deviation_count` STRING COMMENT 'Number of deviations from the validation protocol that occurred during execution. Deviations must be documented, investigated, and assessed for impact on validation outcome per cGMP requirements.',
    `execution_end_date` DATE COMMENT 'Date when validation execution was completed (last validation batch or run completed and all testing finished).',
    `execution_start_date` DATE COMMENT 'Date when validation execution began (first validation batch or run initiated).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this validation record was last modified. Supports audit trail and data lineage requirements per 21 CFR Part 11.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the validation. Per ICH Q10 and continued process verification principles, validations must be periodically reviewed to ensure the process remains in a state of control. Typically reviewed annually or based on risk assessment.',
    `number_of_runs` STRING COMMENT 'Number of validation batches or runs executed as part of the validation study. Typically minimum 3 consecutive successful batches for process validation per FDA guidance. May vary based on validation type and risk assessment.',
    `oos_count` STRING COMMENT 'Number of Out of Specification (OOS) results encountered during validation execution. OOS results require investigation per FDA OOS guidance and may impact validation outcome.',
    `pat_implementation` BOOLEAN COMMENT 'Indicates whether Process Analytical Technology (PAT) tools were implemented as part of the validation. PAT is a system for designing, analyzing, and controlling manufacturing through timely measurements of critical quality and performance attributes with the goal of ensuring final product quality. True if PAT tools (e.g., NIR, Raman, in-line sensors) were used.',
    `process_step` STRING COMMENT 'Specific manufacturing process step or unit operation being validated (e.g., API synthesis, granulation, blending, compression, coating, fill-finish, lyophilization, sterilization, packaging). For cleaning validation, this is the equipment or system being cleaned. For CSV, this is the computerized system being validated.',
    `protocol_approval_date` DATE COMMENT 'Date when the validation protocol was approved by Quality Assurance and authorized for execution. Represents the start of the validation lifecycle.',
    `protocol_number` STRING COMMENT 'Unique protocol number assigned to the validation study. Serves as the externally-known business identifier for this validation activity.. Valid values are `^PV-[A-Z0-9]{6,12}$`',
    `qa_approver` STRING COMMENT 'Name of the Quality Assurance representative who reviewed and approved the validation protocol and report. QA approval is required per cGMP regulations.',
    `regulatory_filing_reference` STRING COMMENT 'Reference to the regulatory filing (IND, NDA, BLA, MAA, eCTD section) where this validation data is or will be submitted. Validation data is typically included in Module 3 (Quality) of the Common Technical Document (CTD).',
    `report_approval_date` DATE COMMENT 'Date when the validation report was reviewed and approved by Quality Assurance. This is the official validation completion date and triggers the validated state for the process.',
    `revalidation_trigger` STRING COMMENT 'Event or condition that triggered the need for revalidation. Examples include: process changes, equipment changes, facility changes, raw material supplier changes, scale-up or scale-down, transfer to new site, out-of-specification results, quality issues, regulatory inspection findings, or periodic review schedule. Supports change control and lifecycle management per ICH Q12.',
    `validation_approach` STRING COMMENT 'Validation approach methodology. Traditional approach uses fixed process parameters and extensive testing. Quality by Design (QbD) approach uses design space and process understanding per ICH Q8. Hybrid combines traditional and QbD elements. Risk-based approach uses ICH Q9 risk management principles to focus validation efforts.. Valid values are `traditional|qbd|hybrid|risk_based`',
    `validation_lead` STRING COMMENT 'Name of the person responsible for leading the validation study. Typically a validation engineer, process engineer, or quality assurance specialist.',
    `validation_outcome` STRING COMMENT 'Overall outcome of the validation study. Pass indicates all acceptance criteria were met. Fail indicates one or more acceptance criteria were not met. Conditional indicates validation passed with minor deviations that require corrective action but do not invalidate the study. Inconclusive indicates validation could not be completed or results were ambiguous.. Valid values are `pass|fail|conditional|inconclusive`',
    `validation_stage` STRING COMMENT 'Stage of process validation per FDA lifecycle approach. Stage 1 (Process Design) establishes commercial manufacturing process based on development knowledge. Stage 2 (Process Qualification) confirms process design is capable of reproducible commercial manufacturing. Stage 3 (Continued Process Verification) provides ongoing assurance that process remains in control. Also includes legacy approaches: prospective (validation before routine production), concurrent (validation during routine production), and retrospective (validation using historical data).. Valid values are `stage_1_process_design|stage_2_process_qualification|stage_3_continued_verification|prospective|concurrent|retrospective`',
    `validation_status` STRING COMMENT 'Current lifecycle status of the validation study. Draft indicates protocol is being prepared. In Progress indicates validation execution is underway. Under Review indicates validation report is being reviewed by Quality Assurance. Approved indicates validation successfully completed and approved. Rejected indicates validation failed to meet acceptance criteria. Conditional indicates validation passed with minor deviations requiring follow-up. Expired indicates validation has exceeded its periodic review date and requires revalidation. Superseded indicates validation has been replaced by a newer study. [ENUM-REF-CANDIDATE: draft|in_progress|under_review|approved|rejected|conditional|expired|superseded — 8 candidates stripped; promote to reference product]',
    `validation_type` STRING COMMENT 'Type of validation being performed. Process validation covers manufacturing processes, cleaning validation covers equipment cleaning procedures, computerized system validation covers MES/SCADA/LIMS systems per 21 CFR Part 11, analytical method validation covers laboratory test methods, equipment validation covers production equipment qualification, and sterilization validation covers sterilization cycles.. Valid values are `process|cleaning|computerized_system|analytical_method|equipment|sterilization`',
    CONSTRAINT pk_process_validation PRIMARY KEY(`process_validation_id`)
) COMMENT 'Records of process validation studies conducted to demonstrate that a manufacturing process consistently produces a product meeting its predetermined specifications and quality attributes, per FDA Process Validation Guidance (2011) and ICH Q8/Q10. Covers all validation types including process validation (Stages 1-3), cleaning validation (dirty hold time, clean hold time, swab/rinse recovery), and computer system validation (CSV/CSA for MES, SCADA, LIMS). Captures validation protocol number, product, process step or system, validation stage (Stage 1 prospective, Stage 2 process qualification, Stage 3 continued process verification), validation type (process, cleaning, computerized system, analytical method transfer), number of validation batches or runs, acceptance criteria, validation outcome (pass/fail/conditional), approval date, revalidation triggers, and next periodic review date. Supports lifecycle approach to validation per ICH Q12.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` (
    `environmental_monitoring_id` BIGINT COMMENT 'Unique identifier for the environmental monitoring record. Primary key.',
    `batch_record_id` BIGINT COMMENT 'Reference to the manufacturing batch being produced during this environmental monitoring event.',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Environmental monitoring programs are designed to meet specific GXP requirements for sterile/aseptic manufacturing (EU GMP Annex 1, FDA Aseptic Processing Guidance). Essential for contamination contro',
    `manufacturing_deviation_id` BIGINT COMMENT 'Reference to the quality deviation record if this environmental monitoring result triggered a deviation investigation.',
    `employee_id` BIGINT COMMENT 'Reference to the laboratory analyst or quality technician who performed the environmental monitoring and analysis.',
    `quality_capa_id` BIGINT COMMENT 'Reference to the CAPA record if corrective or preventive actions were initiated based on this environmental monitoring result.',
    `sample_id` BIGINT COMMENT 'Unique identifier for the environmental monitoring sample, typically generated by the LIMS or MES system.',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing facility where the environmental monitoring was performed.',
    `action_limit` DECIMAL(18,2) COMMENT 'Action limit threshold for the monitoring type and location. Exceeding this limit requires immediate corrective action and deviation investigation.',
    `action_limit_exceeded_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the action limit was exceeded (True) or not (False).',
    `alert_limit` DECIMAL(18,2) COMMENT 'Alert limit threshold for the monitoring type and location. Exceeding this limit triggers investigation but does not necessarily indicate a deviation.',
    `alert_limit_exceeded_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the alert limit was exceeded (True) or not (False).',
    `cfu_count` STRING COMMENT 'Number of colony forming units (CFU) detected in the sample. For viable air, typically reported as CFU per cubic meter; for surface, CFU per plate or per area.',
    `cfu_per_cubic_meter` DECIMAL(18,2) COMMENT 'Normalized CFU count per cubic meter of air sampled, calculated for viable air monitoring.',
    `cleanroom_classification_iso` STRING COMMENT 'ISO 14644-1 cleanroom classification for the monitored area.. Valid values are `ISO 5|ISO 6|ISO 7|ISO 8|ISO 9`',
    `cleanroom_grade_eu` STRING COMMENT 'EU GMP Annex 1 cleanroom grade classification for the monitored area.. Valid values are `Grade A|Grade B|Grade C|Grade D`',
    `comments` STRING COMMENT 'Free-text comments or observations recorded by the analyst regarding the environmental monitoring event, sample collection, or result.',
    `exposure_duration_minutes` STRING COMMENT 'Duration in minutes that a passive settle plate or contact plate was exposed. Null for active air sampling.',
    `incubation_duration_hours` STRING COMMENT 'Duration in hours for which the microbial sample was incubated before reading.',
    `incubation_temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature in degrees Celsius at which the microbial sample was incubated.',
    `manufacturing_operation_phase` STRING COMMENT 'Phase of manufacturing operation during which the environmental monitoring was performed: at-rest (no activity), operational (normal production), or intervention (during maintenance or setup).. Valid values are `at-rest|operational|intervention`',
    `monitoring_location_code` STRING COMMENT 'Unique code identifying the specific location within the cleanroom or controlled area where the sample was taken (e.g., FILL-ROOM-A-LOC-001).',
    `monitoring_location_description` STRING COMMENT 'Human-readable description of the monitoring location (e.g., Near filling line conveyor belt, 1 meter from HEPA filter).',
    `monitoring_type` STRING COMMENT 'Type of environmental monitoring performed: viable air (microbial air sampling), surface (contact plates or swabs), personnel (gown or glove sampling), non-viable particulate (particle counting), or water (for water systems).. Valid values are `viable air|surface|personnel|non-viable particulate|water`',
    `organism_identified` STRING COMMENT 'Name of the microorganism identified in the sample (e.g., Staphylococcus epidermidis, Bacillus species). Null if no growth or if identification not performed.',
    `particulate_count_0_5_micron` BIGINT COMMENT 'Number of particles equal to or greater than 0.5 microns detected per cubic meter for non-viable particulate monitoring.',
    `particulate_count_5_0_micron` BIGINT COMMENT 'Number of particles equal to or greater than 5.0 microns detected per cubic meter for non-viable particulate monitoring.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this environmental monitoring record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this environmental monitoring record was last updated in the system.',
    `result_status` STRING COMMENT 'Status of the environmental monitoring result: pass (within limits), alert (exceeded alert limit), action (exceeded action limit), or fail (critical excursion).. Valid values are `pass|alert|action|fail`',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental monitoring result was reviewed and approved by quality assurance.',
    `sample_collection_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental monitoring sample was collected.',
    `sample_volume_liters` DECIMAL(18,2) COMMENT 'Volume of air sampled in liters for viable or non-viable air monitoring. Null for surface or personnel monitoring.',
    `sampling_method` STRING COMMENT 'Specific method used to collect the environmental sample (e.g., active air sampling with impactor, passive settle plate, contact plate, swab, finger dab, glove print).. Valid values are `active air|passive air|contact plate|swab|finger dab|glove print`',
    `trend_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this result is part of an adverse trend requiring investigation (True) or not (False).',
    CONSTRAINT pk_environmental_monitoring PRIMARY KEY(`environmental_monitoring_id`)
) COMMENT 'Records of environmental monitoring (EM) results for cleanrooms and controlled manufacturing areas, capturing microbial and particulate data as required under cGMP for sterile and non-sterile manufacturing. Captures monitoring location, cleanroom classification (ISO 5/6/7/8, Grade A/B/C/D), monitoring type (viable air, surface, personnel, non-viable particulate), sample date/time, organism identified, colony forming units (CFU), action limit, alert limit, pass/fail status, and trend flag. Supports contamination control strategy per Annex 1 (EMA) and 21 CFR 211.42.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` (
    `cmo_oversight_id` BIGINT COMMENT 'Unique identifier for the CMO/CDMO oversight record. Primary key for tracking contract manufacturing relationships and performance.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: CMO contract manufacturing invoices flow through accounts payable for payment processing, accrual management, and vendor performance tracking against quality agreements and service contracts.',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: CMO relationships are governed by licensing agreements covering IP usage rights, know-how transfer, royalty terms, quality agreements, and commercial terms. Oversight activities must reference governi',
    `pv_product_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.pv_product. Business justification: CMO oversight tracks third-party manufacturing of PV products. Quality agreements define PV responsibilities between MAH and CMO. Essential for ICSR processing when adverse events involve CMO-manufact',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: CMO/CDMO sites undergo regulatory inspections that directly impact sponsor compliance and product approval status. Essential for supply chain risk management, quality agreements, and regulatory intell',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to supply.service_agreement. Business justification: CMO oversight tracks performance against service agreements. Contract management requires linking oversight scorecards (OTD, quality metrics) to contractual SLAs for vendor performance evaluation and ',
    `site_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_site. Business justification: CMO oversight records track performance and compliance for specific CMO/CDMO manufacturing sites. The cmo_oversight table has cmo_site_reference (STRING) and duplicates site address/country data. The ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: CMO oversight records manage contract manufacturing organizations; must link to vendor master for consolidated vendor performance tracking, audit scheduling, quality agreement management, and regulato',
    `active_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the CMO relationship is currently active. True indicates active manufacturing relationship; False indicates terminated or inactive relationship.',
    `audit_status` STRING COMMENT 'Current audit status reflecting the outcome of the most recent quality or cGMP compliance audit conducted at the CMO site.. Valid values are `compliant|minor_findings|major_findings|critical_findings|not_audited|audit_overdue`',
    `avl_status` STRING COMMENT 'Current status of the CMO on the companys Approved Vendor List. Approved vendors have passed qualification audits and are authorized for manufacturing activities.. Valid values are `approved|conditional|suspended|disqualified|under_review`',
    `batch_success_rate` DECIMAL(18,2) COMMENT 'Performance metric representing the percentage of manufacturing batches that pass all quality specifications on first attempt without requiring rework or rejection. Indicates manufacturing process capability.',
    `capa_closure_rate` DECIMAL(18,2) COMMENT 'Performance metric representing the percentage of Corrective and Preventive Actions (CAPA) closed on time. Indicates effectiveness of quality management and continuous improvement processes.',
    `cgmp_certification_status` STRING COMMENT 'Status of the CMOs current Good Manufacturing Practice certification. Indicates whether the site maintains valid cGMP compliance certification from relevant regulatory authorities.. Valid values are `certified|expired|pending_renewal|not_certified`',
    `cmo_type` STRING COMMENT 'Classification of the contract manufacturing organization based on service scope: CMO (manufacturing only), CDMO (development and manufacturing), or specialized service provider.. Valid values are `CMO|CDMO|fill_finish_specialist|packaging_specialist|api_manufacturer`',
    `contract_end_date` DATE COMMENT 'Date when the current manufacturing contract or quality agreement with the CMO expires. Nullable for open-ended or evergreen contracts. Used for contract renewal planning.',
    `contract_start_date` DATE COMMENT 'Date when the manufacturing contract or quality agreement with the CMO became effective. Marks the beginning of the contractual relationship.',
    `contract_type` STRING COMMENT 'Type of manufacturing service contracted: Drug Substance (DS) manufacturing, Drug Product (DP) manufacturing, fill-finish operations, packaging, API production, or formulation development.. Valid values are `ds_manufacturing|dp_manufacturing|fill_finish|packaging|api_production|formulation`',
    `contracted_products` STRING COMMENT 'Comma-separated list or description of drug substances, drug products, or SKUs that the CMO is contracted to manufacture. References internal product master data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CMO oversight record was first created in the system. Used for audit trail and data lineage tracking.',
    `deviation_rate` DECIMAL(18,2) COMMENT 'Performance metric representing the rate of manufacturing deviations, Out of Specification (OOS) events, or non-conformances per batch or per time period. Lower rates indicate better process control.',
    `last_audit_date` DATE COMMENT 'Date when the most recent quality or compliance audit of the CMO site was completed. Used to track audit frequency and compliance monitoring.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CMO oversight record was most recently modified. Used for audit trail and change tracking.',
    `manufacturing_capacity` STRING COMMENT 'Description of the CMO sites manufacturing capacity including batch sizes, annual production volume, or throughput capabilities. Used for capacity planning and supply chain risk management.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next quality or compliance audit of the CMO site. Typically based on risk assessment and regulatory requirements for periodic vendor audits.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context regarding the CMO relationship, performance issues, strategic considerations, or special handling requirements.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Performance metric representing the percentage of manufacturing batches or shipments delivered on or before the committed delivery date. Key performance indicator for supply chain reliability.',
    `quality_agreement_reference` STRING COMMENT 'Reference number or identifier for the Quality Agreement governing quality responsibilities, specifications, and compliance obligations between the company and the CMO.',
    `quality_scorecard_rating` STRING COMMENT 'Composite quality performance rating based on multiple metrics including on-time delivery, batch success rate, deviation rate, audit findings, and CAPA effectiveness. Used for vendor performance management.. Valid values are `excellent|good|acceptable|needs_improvement|unacceptable`',
    `regulatory_authority_jurisdiction` STRING COMMENT 'Primary regulatory authority or health authority with jurisdiction over the CMO site (e.g., FDA, EMA, PMDA, NMPA). Determines applicable regulatory requirements and inspection oversight.',
    `regulatory_inspection_history` STRING COMMENT 'Summary of recent regulatory inspections by FDA, EMA, PMDA, or other health authorities, including inspection dates and outcomes (e.g., VAI, OAI, NAI classifications).',
    `relationship_manager` STRING COMMENT 'Name of the internal employee or manager responsible for managing the business relationship, contract performance, and communication with the CMO. Primary point of contact for CMO oversight.',
    `risk_tier` STRING COMMENT 'Risk classification of the CMO based on factors including single-source dependency, product criticality, regulatory compliance history, and geographic risk. Used for risk-based oversight planning.. Valid values are `low|medium|high|critical`',
    `technical_agreement_reference` STRING COMMENT 'Reference number or identifier for the Technical Agreement defining manufacturing processes, specifications, Critical Process Parameters (CPP), and Critical Quality Attributes (CQA).',
    `technology_platform` STRING COMMENT 'Description of the manufacturing technology platforms or modalities supported by the CMO (e.g., small molecule, biologics, cell therapy, gene therapy, mRNA, ADC). Indicates technical capabilities.',
    CONSTRAINT pk_cmo_oversight PRIMARY KEY(`cmo_oversight_id`)
) COMMENT 'Master data and performance tracking for Contract Manufacturing Organizations (CMOs) and CDMOs engaged to manufacture drug substances or drug products on behalf of the company. Captures CMO/CDMO name, site reference, contracted product(s), contract type (DS manufacturing, DP manufacturing, fill-finish, packaging), quality agreement reference, technical agreement reference, audit status, last audit date, next audit due date, approved vendor list (AVL) status, performance scorecard metrics (on-time delivery, batch success rate, deviation rate), and relationship manager. Distinct from procurement supplier master.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` (
    `technology_transfer_id` BIGINT COMMENT 'Unique identifier for the technology transfer record. Primary key.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Technology transfers to new sites or CMOs are driven by market access strategies requiring local manufacturing for market entry, favorable pricing, or regulatory requirements. Transfer decisions align',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Tech transfers move branded product manufacturing between sites. Critical for commercial supply continuity planning, launch execution, capacity management, and brand portfolio optimization. Pharma com',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: When transferring manufacturing technology to external CMO (cmo_cdmo_flag=true), links to vendor entity for regulatory change control filings, quality agreement references, and technology transfer agr',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: Technology transfers involving API or proprietary excipients require DMF cross-reference coordination, letter of authorization management, ensuring receiving site has DMF access rights, and maintainin',
    `drug_product_id` BIGINT COMMENT 'Reference to the drug product or drug substance being transferred.',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Technology transfers must maintain GXP compliance across sites (ICH Q10, EU GMP Chapter 7). Required for regulatory change control (CBE-30, variations), comparability protocols, and site qualification',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: CMO/CDMO technology transfers operate under licensing agreements that define IP usage rights, royalty obligations, territory restrictions, sublicensing permissions, and quality/technical agreement ter',
    `master_batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.master_batch_record. Business justification: Technology transfers move manufacturing processes (defined by MBRs) between sites. The technology_transfer table should link to the master_batch_record being transferred to enable access to the proces',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Technology transfers inherently involve patent rights transfer between sites, patent prosecution coordination for manufacturing claims, IP due diligence, and ensuring receiving site operates within pa',
    `pv_product_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.pv_product. Business justification: Technology transfers change manufacturing sites/processes for PV products, requiring regulatory change control and safety impact assessment. Enables tracking whether site transfers correlate with adve',
    `rd_capitalization_id` BIGINT COMMENT 'Foreign key linking to finance.rd_capitalization. Business justification: Technology transfer completion to commercial manufacturing sites represents a capitalization event when products achieve commercial readiness, requiring linkage to capitalized development cost records',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site or CMO/CDMO facility that is receiving the manufacturing process.',
    `source_site_id` BIGINT COMMENT 'Reference to the manufacturing site or R&D facility from which the manufacturing process is being transferred.',
    `predecessor_technology_transfer_id` BIGINT COMMENT 'Self-referencing FK on technology_transfer (predecessor_technology_transfer_id)',
    `actual_completion_date` DATE COMMENT 'The actual date when the technology transfer was completed and the receiving site was approved to manufacture the product commercially.',
    `analytical_methods_transferred_flag` BOOLEAN COMMENT 'Indicates whether analytical test methods have been successfully transferred and qualified at the receiving site.',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether corrective and preventive actions (CAPA) are required to address issues identified during the technology transfer.',
    `cgmp_compliance_verified_flag` BOOLEAN COMMENT 'Indicates whether the receiving site has been verified to be compliant with current Good Manufacturing Practice (cGMP) requirements per 21 CFR Parts 210 and 211.',
    `cleaning_procedures_transferred_flag` BOOLEAN COMMENT 'Indicates whether cleaning validation procedures and acceptance criteria have been successfully transferred to the receiving site.',
    `cmo_cdmo_flag` BOOLEAN COMMENT 'Indicates whether the transfer involves a contract manufacturing organization (CMO) or contract development and manufacturing organization (CDMO). True if either source or receiving site is a CMO/CDMO, false if transfer is between internal sites only.',
    `comments` STRING COMMENT 'Additional notes, observations, or context regarding the technology transfer activities, challenges, or lessons learned.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this technology transfer record was first created in the system.',
    `deviation_count` STRING COMMENT 'The total number of deviations or non-conformances identified during the technology transfer activities.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this technology transfer record was last updated or modified.',
    `pat_implementation_flag` BOOLEAN COMMENT 'Indicates whether Process Analytical Technology (PAT) tools and real-time monitoring are part of the transferred manufacturing process.',
    `planned_completion_date` DATE COMMENT 'The target date for completing all technology transfer activities including qualification batches and regulatory submissions.',
    `process_parameters_transferred_flag` BOOLEAN COMMENT 'Indicates whether critical process parameters (CPP) and process controls have been successfully transferred and validated at the receiving site.',
    `qbd_approach_flag` BOOLEAN COMMENT 'Indicates whether the technology transfer follows Quality by Design (QbD) principles with defined design space and control strategy.',
    `qualification_batch_count` STRING COMMENT 'The number of qualification or validation batches required to be manufactured at the receiving site to demonstrate process capability and consistency.',
    `qualification_batches_completed` STRING COMMENT 'The number of qualification batches that have been successfully manufactured and released at the receiving site.',
    `readiness_assessment_date` DATE COMMENT 'The date when the receiving site readiness assessment was completed and approved.',
    `readiness_assessment_status` STRING COMMENT 'Status of the receiving site readiness assessment: not-started (assessment not yet begun), in-progress (assessment underway), completed (assessment finished), approved (site deemed ready for transfer).. Valid values are `not-started|in-progress|completed|approved`',
    `regulatory_approval_date` DATE COMMENT 'The date when regulatory approval was received from health authorities to manufacture the product at the receiving site.',
    `regulatory_change_control_number` STRING COMMENT 'The change control or variation number associated with regulatory submissions for the site transfer, if applicable.',
    `regulatory_submission_date` DATE COMMENT 'The date when regulatory submissions for the site transfer were filed with the relevant health authorities.',
    `regulatory_submission_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory submissions (e.g., prior approval supplement, variation) are required for this technology transfer.',
    `stability_data_transferred_flag` BOOLEAN COMMENT 'Indicates whether stability protocols and historical stability data have been transferred and stability studies initiated at the receiving site.',
    `transfer_initiation_date` DATE COMMENT 'The date when the technology transfer project was formally initiated and the protocol was approved.',
    `transfer_outcome` STRING COMMENT 'The final outcome of the technology transfer: successful (all acceptance criteria met), successful-with-deviations (completed with minor issues documented), unsuccessful (failed to meet acceptance criteria), cancelled (terminated before completion).. Valid values are `successful|successful-with-deviations|unsuccessful|cancelled`',
    `transfer_protocol_number` STRING COMMENT 'The externally-known unique protocol number assigned to this technology transfer activity. Used for regulatory and quality management system tracking.',
    `transfer_report_approval_date` DATE COMMENT 'The date when the final technology transfer report was approved by quality assurance and management.',
    `transfer_report_number` STRING COMMENT 'The document number of the final technology transfer report summarizing all activities, results, and conclusions.',
    `transfer_stage` STRING COMMENT 'Current stage in the technology transfer lifecycle: initiation (planning and protocol development), knowledge-transfer (documentation and training), process-demonstration (trial runs), qualification-batches (validation batches), regulatory-submission (filing with authorities), approval (regulatory and internal approval), closure (final report and handover). [ENUM-REF-CANDIDATE: initiation|knowledge-transfer|process-demonstration|qualification-batches|regulatory-submission|approval|closure — 7 candidates stripped; promote to reference product]',
    `transfer_status` STRING COMMENT 'Overall status of the technology transfer: planned (scheduled but not started), in-progress (actively executing), on-hold (temporarily suspended), completed (successfully finished), cancelled (terminated before completion).. Valid values are `planned|in-progress|on-hold|completed|cancelled`',
    `transfer_team_lead_email` STRING COMMENT 'The email address of the technology transfer team lead for project communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `transfer_team_lead_name` STRING COMMENT 'The name of the individual responsible for leading the technology transfer project team.',
    `transfer_type` STRING COMMENT 'Classification of the technology transfer activity: site-to-site (between internal manufacturing sites), r&d-to-commercial (from development to commercial manufacturing), cmo-onboarding (to contract manufacturing organization), cmo-offboarding (from CMO back to internal or to another CMO), scale-up (pilot to commercial scale), or process-improvement (transfer of improved process).. Valid values are `site-to-site|r&d-to-commercial|cmo-onboarding|cmo-offboarding|scale-up|process-improvement`',
    CONSTRAINT pk_technology_transfer PRIMARY KEY(`technology_transfer_id`)
) COMMENT 'Records technology transfer activities for moving manufacturing processes between sites, from R&D to commercial manufacturing, or to/from CMO/CDMO partners. Captures transfer protocol number, source site, receiving site, product code, transfer type (site-to-site, R&D-to-commercial, CMO onboarding, CMO offboarding), transfer stage (initiation, knowledge transfer, process demonstration, qualification batches, regulatory submission, approval, closure), key deliverables checklist (analytical methods, process parameters, cleaning procedures, stability data), readiness assessment status, regulatory change control reference, transfer team members, planned/actual completion dates, and transfer outcome. Critical for CMO/CDMO lifecycle management and multi-site manufacturing networks per ICH Q10 pharmaceutical quality system requirements.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` (
    `investigational_product_supply_id` BIGINT COMMENT 'Unique identifier for this investigational product supply allocation record. Primary key.',
    `investigator_id` BIGINT COMMENT 'Foreign key linking to the clinical trial investigator receiving investigational product manufactured according to this master batch record.',
    `master_batch_record_id` BIGINT COMMENT 'Foreign key linking to the master batch record that defines the manufacturing specification for the investigational product supplied to this investigator.',
    `approved_indication` STRING COMMENT 'The specific therapeutic indication or disease state for which this MBR-investigator supply allocation is approved. An investigator may receive different MBRs for different indications across multiple trials.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this investigational product supply allocation record was created in the system.',
    `dosing_regimen` STRING COMMENT 'The approved dosing regimen for this specific MBR-investigator combination, including frequency, route of administration, and duration. Varies by trial protocol and investigator site.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this investigational product supply allocation record was last modified.',
    `protocol_number` STRING COMMENT 'The clinical trial protocol number under which this investigational product supply is provided. Links supply allocation to specific trial regulatory documentation.',
    `regulatory_approval_reference` STRING COMMENT 'Reference to the regulatory approval (IND, CTA, or equivalent) under which this specific MBR-investigator supply is authorized. Required for regulatory traceability.',
    `supply_allocation_quantity` DECIMAL(18,2) COMMENT 'The quantity of investigational product (manufactured per this MBR) allocated to this investigator for this trial. Measured in units consistent with the MBR batch size UOM.',
    `supply_end_date` DATE COMMENT 'The date when investigational product supply from this MBR to this investigator ended or is planned to end. Used for supply chain planning and batch reconciliation.',
    `supply_start_date` DATE COMMENT 'The date when investigational product supply from this MBR to this investigator began. Critical for regulatory traceability and shelf-life management.',
    `supply_status` STRING COMMENT 'Current status of this investigational product supply allocation. Tracks lifecycle from planning through completion or cancellation.',
    `trial_phase` STRING COMMENT 'The clinical trial phase for which this investigational product supply is allocated. Different phases may use different formulations or strengths from different MBRs.',
    CONSTRAINT pk_investigational_product_supply PRIMARY KEY(`investigational_product_supply_id`)
) COMMENT 'This association product represents the supply allocation and usage tracking between master batch records (manufacturing specifications for investigational products) and clinical trial investigators. It captures trial-specific supply chain planning, dosing regimens, approved indications, and regulatory traceability requirements per ICH GMP Annex 13. Each record links one master batch record to one investigator with attributes that exist only in the context of this clinical supply relationship.. Existence Justification: In pharmaceutical clinical operations, a single master batch record (manufacturing specification) is used to produce investigational product that is supplied to multiple investigators across different trials, phases, and sites. Conversely, each investigator typically receives investigational product from multiple master batch records representing different formulations, strengths, or product variants across their portfolio of trials. The business actively manages these supply allocations as distinct operational records with trial-specific attributes.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Primary key for campaign',
    `approved_by_user_employee_id` BIGINT COMMENT 'Reference to the authorized user who approved this campaign.',
    `created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this campaign record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for managing and overseeing this manufacturing campaign.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this campaign record.',
    `line_id` BIGINT COMMENT 'Reference to the specific production line or suite assigned to this campaign.',
    `master_batch_record_id` BIGINT COMMENT 'Reference to the approved Master Batch Record (MBR) governing this campaigns manufacturing process.',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product being manufactured in this campaign.',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing facility where the campaign is executed.',
    `vendor_id` BIGINT COMMENT 'Reference to the Contract Manufacturing Organization (CMO) or Contract Development and Manufacturing Organization (CDMO) executing this campaign, if applicable.',
    `preceding_campaign_id` BIGINT COMMENT 'Self-referencing FK on campaign (preceding_campaign_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the campaign manufacturing operations were completed, recorded from Manufacturing Execution System (MES).',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Actual production quantity achieved by the campaign, expressed in the unit of measure specified.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the campaign manufacturing operations commenced, recorded from Manufacturing Execution System (MES).',
    `approval_status` STRING COMMENT 'Approval workflow status for the campaign: draft, pending approval, approved, or rejected.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign was approved by authorized personnel.',
    `batch_size` DECIMAL(18,2) COMMENT 'Standard batch size for this campaign, representing the quantity produced per batch cycle.',
    `campaign_name` STRING COMMENT 'Human-readable name or title of the manufacturing campaign.',
    `campaign_notes` STRING COMMENT 'Free-text notes and comments related to the campaign, including special instructions, deviations, or observations.',
    `campaign_number` STRING COMMENT 'Business identifier for the campaign, externally known and used in manufacturing execution systems and batch documentation.',
    `campaign_type` STRING COMMENT 'Classification of the campaign by manufacturing stage: drug substance (DS), drug product (DP), active pharmaceutical ingredient (API) production, formulation, fill-finish, or packaging.',
    `cgmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the campaign is executed under current Good Manufacturing Practice (cGMP) regulations as required by 21 CFR Parts 210 and 211.',
    `contract_manufacturing_flag` BOOLEAN COMMENT 'Indicates whether this campaign is executed by a Contract Manufacturing Organization (CMO) or Contract Development and Manufacturing Organization (CDMO).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign record was first created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign record was last modified.',
    `manufacturing_mode` STRING COMMENT 'Mode of manufacturing operation: batch, continuous, or semi-continuous processing.',
    `number_of_batches_completed` STRING COMMENT 'Total number of batches successfully completed during this campaign.',
    `number_of_batches_planned` STRING COMMENT 'Total number of batches planned to be manufactured during this campaign.',
    `planned_end_date` DATE COMMENT 'Scheduled date when the campaign is planned to complete all manufacturing operations.',
    `planned_start_date` DATE COMMENT 'Scheduled date when the campaign is planned to begin manufacturing operations.',
    `priority_level` STRING COMMENT 'Business priority assigned to this campaign: critical, high, medium, or low, used for resource allocation and scheduling decisions.',
    `process_analytical_technology_flag` BOOLEAN COMMENT 'Indicates whether Process Analytical Technology (PAT) is implemented in this campaign for real-time quality monitoring and control.',
    `quality_by_design_flag` BOOLEAN COMMENT 'Indicates whether the campaign follows Quality by Design (QbD) principles as outlined in ICH Q8, Q9, and Q10.',
    `regulatory_market` STRING COMMENT 'Target regulatory market or region for which this campaigns output is intended (e.g., USA, EUR, JPN, CHN). Uses 3-letter country codes or regional identifiers.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the manufacturing campaign: planned, scheduled, in progress, on hold, completed, cancelled, or closed.',
    `target_quantity` DECIMAL(18,2) COMMENT 'Planned production quantity for the campaign, expressed in the unit of measure specified.',
    `therapeutic_area` STRING COMMENT 'Therapeutic area classification for the product being manufactured: oncology, immunology, rare diseases, cardiovascular, neurology, or infectious diseases.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for campaign quantities: kilograms, grams, milligrams, liters, milliliters, units, vials, tablets, or capsules.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master reference table for campaign. Referenced by campaign_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` (
    `sample_id` BIGINT COMMENT 'Primary key for sample',
    `batch_record_id` BIGINT COMMENT 'Reference to the manufacturing batch from which this sample was collected. Links sample to production batch record.',
    `created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this sample record in the system. Required for audit trail and data integrity.',
    `disposition_by_user_employee_id` BIGINT COMMENT 'Reference to the quality assurance personnel who made the final disposition decision. Required for regulatory accountability.',
    `employee_id` BIGINT COMMENT 'Reference to the operator or quality control personnel who collected the sample. Required for audit trail and accountability.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this sample record. Required for audit trail and data integrity per 21 CFR Part 11.',
    `material_id` BIGINT COMMENT 'Reference to the material being sampled (drug substance, drug product, raw material, or intermediate). Links to material master data.',
    `received_by_user_employee_id` BIGINT COMMENT 'Reference to the laboratory personnel who received and logged the sample into the LIMS. Part of chain of custody documentation.',
    `specification_id` BIGINT COMMENT 'Reference to the test specification or analytical method that defines the testing protocol for this sample. Links to quality control test procedures.',
    `tested_by_user_employee_id` BIGINT COMMENT 'Reference to the analyst or laboratory technician who performed the testing. Required for accountability and audit trail.',
    `parent_sample_id` BIGINT COMMENT 'Self-referencing FK on sample (parent_sample_id)',
    `chain_of_custody_verified` BOOLEAN COMMENT 'Indicates whether the chain of custody for the sample has been verified and documented from collection through testing. Critical for sample integrity and regulatory compliance.',
    `collection_point` STRING COMMENT 'Specific location or process step where the sample was collected (e.g., reactor vessel, blending tank, filling line station 3, packaging line A).',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the sample was physically collected from the manufacturing process or storage location. Principal business event timestamp for sample lifecycle.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or special handling instructions related to the sample. Used by laboratory and quality personnel for context and communication.',
    `container_type` STRING COMMENT 'Type of container used to store the sample (e.g., glass vial, plastic bottle, amber bottle, sealed bag, sterile container). Important for sample integrity and stability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sample record was first created in the system. Part of audit trail for regulatory compliance.',
    `deviation_description` STRING COMMENT 'Detailed description of any deviations that occurred during sample collection, handling, or testing. Required when deviation_flag is true.',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether any deviations from standard sampling or testing procedures occurred. Triggers investigation and documentation requirements.',
    `disposition` STRING COMMENT 'Final disposition decision for the sample and associated batch: approved (released for use/distribution), rejected (not suitable), quarantined (held pending investigation), pending review (awaiting QA decision), released (testing complete and approved), or destroyed (disposed per protocol).',
    `disposition_timestamp` TIMESTAMP COMMENT 'Date and time when the final disposition decision was made by quality assurance. Critical for batch release timeline and regulatory compliance.',
    `expiry_date` DATE COMMENT 'Date after which the sample is no longer considered valid for testing or reference purposes. Based on material stability and storage conditions.',
    `investigation_required` BOOLEAN COMMENT 'Indicates whether an out-of-specification (OOS) investigation or other formal investigation is required for this sample. Triggers quality event workflow.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this sample record is currently active in the system. Used for soft deletion and historical record management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this sample record was last updated. Tracks data changes for audit trail and regulatory compliance.',
    `priority_level` STRING COMMENT 'Testing priority assigned to the sample: routine (standard turnaround), urgent (accelerated testing), expedited (fast-track), or critical (immediate attention required). Drives laboratory scheduling.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the sample was received by the quality control laboratory. Used to track sample transit time and testing turnaround.',
    `retest_date` DATE COMMENT 'Date when the sample or associated material should be retested to confirm continued compliance with specifications. Applicable for stability and retain samples.',
    `sample_number` STRING COMMENT 'Externally-known unique sample identifier used in laboratory information management systems (LIMS) and batch records. Human-readable business identifier for tracking and referencing.',
    `sample_quantity` DECIMAL(18,2) COMMENT 'Amount of material collected for the sample. Used with unit_of_measure to specify sample size.',
    `sample_status` STRING COMMENT 'Current lifecycle status of the sample in the quality control workflow. Tracks progression from collection through testing to final disposition.',
    `sample_type` STRING COMMENT 'Classification of the sample based on its intended purpose: in-process (during manufacturing), release (final product testing), stability (long-term storage testing), retain (archived for future reference), reference (standard material), or investigational (R&D).',
    `storage_condition` STRING COMMENT 'Required storage conditions for the sample to maintain integrity: room temperature (15-25°C), refrigerated (2-8°C), frozen (-20°C), controlled room temperature (20-25°C), or ultra-low temperature (-80°C).',
    `storage_location` STRING COMMENT 'Physical location where the sample is stored (e.g., QC laboratory refrigerator 3, stability chamber A, warehouse freezer 2). Enables sample retrieval and inventory management.',
    `test_result_summary` STRING COMMENT 'Overall outcome of the sample testing: pass (meets specifications), fail (does not meet specifications), out of specification (OOS - requires investigation), pending (testing incomplete), or inconclusive (requires retest).',
    `testing_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all analytical testing for the sample was completed. Marks readiness for review and disposition decision.',
    `testing_start_timestamp` TIMESTAMP COMMENT 'Date and time when analytical testing of the sample commenced. Used to calculate testing duration and laboratory throughput metrics.',
    `unit_of_measure` STRING COMMENT 'Unit in which the sample quantity is expressed (grams, kilograms, milligrams, liters, milliliters, units, tablets, vials, ampoules).',
    CONSTRAINT pk_sample PRIMARY KEY(`sample_id`)
) COMMENT 'Master reference table for sample. Referenced by sample_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_step` (
    `process_step_id` BIGINT COMMENT 'Primary key for process_step',
    `preceding_process_step_id` BIGINT COMMENT 'Self-referencing FK on process_step (preceding_process_step_id)',
    `approved_by` STRING COMMENT 'Name or identifier of the qualified person who approved this process step definition for manufacturing use per change control procedures.',
    `cleanroom_grade` STRING COMMENT 'Required cleanroom classification grade for this process step per EU GMP Annex 1 or ISO 14644 standards. Null if cleanroom not required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process step record was first created in the manufacturing execution system.',
    `process_step_description` STRING COMMENT 'Detailed description of the manufacturing process step including purpose, scope, and key activities performed.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Standard or target duration for completing this process step under normal operating conditions, measured in minutes.',
    `duration_tolerance_minutes` DECIMAL(18,2) COMMENT 'Acceptable variance in process step duration before triggering deviation investigation, measured in minutes.',
    `effective_date` DATE COMMENT 'Date when this process step definition became or will become effective for use in manufacturing operations.',
    `equipment_class` STRING COMMENT 'General class or type of equipment required to execute this process step (e.g., Reactor, Blender, Tablet Press, Filling Line, Autoclave).',
    `expiration_date` DATE COMMENT 'Date when this process step definition is scheduled to expire or be superseded by a revised version. Null for indefinite validity.',
    `gowning_level` STRING COMMENT 'Required level of personnel gowning for this process step, ranging from basic PPE to full aseptic gowning. Null if gowning not required.',
    `in_process_control_required` BOOLEAN COMMENT 'Indicates whether in-process controls or testing must be performed during or immediately after this step per batch record requirements.',
    `is_critical_step` BOOLEAN COMMENT 'Indicates whether this step is identified as a critical process step (CPS) that directly impacts Critical Quality Attributes (CQA) per Quality by Design (QbD) principles.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this process step record was last updated or modified in the system.',
    `ph_setpoint` DECIMAL(18,2) COMMENT 'Target pH level for this process step. Applicable for synthesis, fermentation, and formulation steps requiring pH control.',
    `ph_tolerance` DECIMAL(18,2) COMMENT 'Acceptable pH variance from setpoint before triggering out-of-specification investigation.',
    `pressure_setpoint_bar` DECIMAL(18,2) COMMENT 'Target pressure for this process step measured in bar. Null if pressure control is not applicable.',
    `pressure_tolerance_bar` DECIMAL(18,2) COMMENT 'Acceptable pressure variance from setpoint in bar before triggering out-of-specification investigation.',
    `requires_cleanroom` BOOLEAN COMMENT 'Indicates whether this process step must be performed in a controlled cleanroom environment per cGMP requirements.',
    `requires_gowning` BOOLEAN COMMENT 'Indicates whether personnel must wear specialized gowning or personal protective equipment (PPE) to perform this step.',
    `revalidation_due_date` DATE COMMENT 'Scheduled date for next periodic revalidation or requalification of this process step.',
    `risk_classification` STRING COMMENT 'Risk level assigned to this process step based on its potential impact on product quality, patient safety, and regulatory compliance per ICH Q9 risk management principles.',
    `sampling_required` BOOLEAN COMMENT 'Indicates whether material sampling is required at this process step for quality control or in-process testing purposes.',
    `sequence_order` STRING COMMENT 'Numeric ordering of this step within the overall manufacturing process flow. Lower numbers execute first.',
    `speed_setpoint_rpm` DECIMAL(18,2) COMMENT 'Target rotational speed for equipment in this process step measured in revolutions per minute (RPM). Applicable for mixing, blending, and centrifugation steps.',
    `speed_tolerance_rpm` DECIMAL(18,2) COMMENT 'Acceptable speed variance from setpoint in RPM before triggering out-of-specification investigation.',
    `standard_operating_procedure_number` STRING COMMENT 'Reference number of the governing Standard Operating Procedure document that defines how to execute this process step.',
    `process_step_status` STRING COMMENT 'Current lifecycle status of the process step in the manufacturing master data system.',
    `step_category` STRING COMMENT 'High-level categorization indicating whether the step is part of drug substance (API) or drug product (DP) manufacturing.',
    `step_name` STRING COMMENT 'Human-readable name of the manufacturing process step (e.g., API Synthesis, Granulation, Fill-Finish, Lyophilization).',
    `step_number` STRING COMMENT 'Business identifier for the process step used in batch records and manufacturing instructions (e.g., MIX-010, FILL-020).',
    `step_type` STRING COMMENT 'Classification of the manufacturing process step based on its function in the production workflow.',
    `temperature_setpoint_c` DECIMAL(18,2) COMMENT 'Target temperature for this process step in degrees Celsius. Null if temperature control is not applicable.',
    `temperature_tolerance_c` DECIMAL(18,2) COMMENT 'Acceptable temperature variance from setpoint in degrees Celsius before triggering out-of-specification investigation.',
    `validation_date` DATE COMMENT 'Date when this process step was last successfully validated or qualified per cGMP requirements.',
    `validation_status` STRING COMMENT 'Current validation status of this process step per process validation lifecycle requirements.',
    `version_number` STRING COMMENT 'Version identifier for this process step definition following change control procedures (e.g., 1.0, 2.1, 3.0).',
    `work_instruction_number` STRING COMMENT 'Reference number of the detailed work instruction document that provides step-by-step execution guidance for operators.',
    CONSTRAINT pk_process_step PRIMARY KEY(`process_step_id`)
) COMMENT 'Master reference table for process_step. Referenced by process_step_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`manufacturing`.`routing` (
    `routing_id` BIGINT COMMENT 'Primary key for routing',
    `created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this routing record.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this routing for production use.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this routing record.',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing facility or site where this routing is executed.',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the drug substance or drug product that this routing produces.',
    `superseded_by_routing_id` BIGINT COMMENT 'Reference to the newer routing that replaces this one when status is superseded. Null if not superseded.',
    `superseded_routing_id` BIGINT COMMENT 'Self-referencing FK on routing (superseded_routing_id)',
    `approval_date` DATE COMMENT 'Date when this routing was formally approved for use in production.',
    `batch_size_uom` STRING COMMENT 'Unit of measure for the standard batch size quantity.',
    `cgmp_compliant_flag` BOOLEAN COMMENT 'Indicates whether this routing has been validated and approved for current Good Manufacturing Practice compliance.',
    `change_control_number` STRING COMMENT 'Change control or deviation tracking number associated with the creation or modification of this routing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this routing record was first created in the system.',
    `critical_process_flag` BOOLEAN COMMENT 'Indicates whether this routing contains critical process parameters that directly impact critical quality attributes.',
    `routing_description` STRING COMMENT 'Detailed description of the manufacturing routing including process overview and special considerations.',
    `effective_end_date` DATE COMMENT 'Date when this routing is no longer valid for production. Null for open-ended routings.',
    `effective_start_date` DATE COMMENT 'Date when this routing becomes valid and can be used for production.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this routing record was last updated.',
    `last_validation_date` DATE COMMENT 'Date when this routing was last validated or revalidated.',
    `maximum_batch_size` DECIMAL(18,2) COMMENT 'Maximum allowable batch size that can be manufactured using this routing while maintaining quality standards.',
    `minimum_batch_size` DECIMAL(18,2) COMMENT 'Minimum allowable batch size that can be manufactured using this routing while maintaining quality standards.',
    `next_revalidation_date` DATE COMMENT 'Scheduled date for the next periodic revalidation of this routing.',
    `pat_enabled_flag` BOOLEAN COMMENT 'Indicates whether this routing includes Process Analytical Technology tools for real-time quality monitoring.',
    `process_category` STRING COMMENT 'High-level classification of the manufacturing process type covered by this routing.',
    `qbd_enabled_flag` BOOLEAN COMMENT 'Indicates whether this routing incorporates Quality by Design principles with defined design space and control strategy.',
    `regulatory_filing_reference` STRING COMMENT 'Reference to the regulatory submission or filing that includes this routing (e.g., NDA, ANDA, BLA number).',
    `routing_name` STRING COMMENT 'Human-readable name describing the manufacturing routing process.',
    `routing_number` STRING COMMENT 'Business identifier for the routing used in manufacturing execution systems and batch records. Externally visible routing code.',
    `routing_type` STRING COMMENT 'Classification of the routing indicating its purpose and usage context in manufacturing operations.',
    `routing_version` STRING COMMENT 'Version number of the routing to track changes and revisions over time. Follows semantic versioning pattern.',
    `standard_batch_size` DECIMAL(18,2) COMMENT 'Standard production batch quantity for which this routing is designed.',
    `standard_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Expected total time in minutes to complete all operations in this routing under normal conditions.',
    `routing_status` STRING COMMENT 'Current lifecycle status of the routing in the manufacturing system.',
    `sterile_process_flag` BOOLEAN COMMENT 'Indicates whether this routing requires aseptic or sterile manufacturing conditions.',
    `total_operation_count` STRING COMMENT 'Total number of manufacturing operations or steps defined in this routing.',
    `validation_protocol_number` STRING COMMENT 'Reference to the process validation protocol that qualified this routing for commercial production.',
    `validation_status` STRING COMMENT 'Current status of process validation for this routing.',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Master reference table for routing. Referenced by routing_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`campaign`(`campaign_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_line_id` FOREIGN KEY (`line_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`line`(`line_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`campaign`(`campaign_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_line_id` FOREIGN KEY (`line_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`line`(`line_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_superseded_by_mbr_master_batch_record_id` FOREIGN KEY (`superseded_by_mbr_master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ADD CONSTRAINT `fk_manufacturing_line_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_line_id` FOREIGN KEY (`line_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`line`(`line_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_line_id` FOREIGN KEY (`line_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`line`(`line_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_line_id` FOREIGN KEY (`line_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`line`(`line_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_manufacturing_deviation_id` FOREIGN KEY (`manufacturing_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation`(`manufacturing_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`process_step`(`process_step_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ADD CONSTRAINT `fk_manufacturing_process_parameter_result_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ADD CONSTRAINT `fk_manufacturing_process_parameter_result_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ADD CONSTRAINT `fk_manufacturing_process_parameter_result_manufacturing_deviation_id` FOREIGN KEY (`manufacturing_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation`(`manufacturing_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ADD CONSTRAINT `fk_manufacturing_process_parameter_result_process_parameter_id` FOREIGN KEY (`process_parameter_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`process_parameter`(`process_parameter_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ADD CONSTRAINT `fk_manufacturing_process_parameter_result_process_step_id` FOREIGN KEY (`process_step_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`process_step`(`process_step_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ADD CONSTRAINT `fk_manufacturing_process_parameter_result_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`sample`(`sample_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_line_id` FOREIGN KEY (`line_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`line`(`line_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ADD CONSTRAINT `fk_manufacturing_environmental_monitoring_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ADD CONSTRAINT `fk_manufacturing_environmental_monitoring_manufacturing_deviation_id` FOREIGN KEY (`manufacturing_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation`(`manufacturing_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ADD CONSTRAINT `fk_manufacturing_environmental_monitoring_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`sample`(`sample_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ADD CONSTRAINT `fk_manufacturing_environmental_monitoring_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ADD CONSTRAINT `fk_manufacturing_cmo_oversight_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_source_site_id` FOREIGN KEY (`source_site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_predecessor_technology_transfer_id` FOREIGN KEY (`predecessor_technology_transfer_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer`(`technology_transfer_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ADD CONSTRAINT `fk_manufacturing_investigational_product_supply_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` ADD CONSTRAINT `fk_manufacturing_campaign_line_id` FOREIGN KEY (`line_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`line`(`line_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` ADD CONSTRAINT `fk_manufacturing_campaign_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` ADD CONSTRAINT `fk_manufacturing_campaign_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` ADD CONSTRAINT `fk_manufacturing_campaign_preceding_campaign_id` FOREIGN KEY (`preceding_campaign_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`campaign`(`campaign_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` ADD CONSTRAINT `fk_manufacturing_sample_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` ADD CONSTRAINT `fk_manufacturing_sample_parent_sample_id` FOREIGN KEY (`parent_sample_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`sample`(`sample_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_step` ADD CONSTRAINT `fk_manufacturing_process_step_preceding_process_step_id` FOREIGN KEY (`preceding_process_step_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`process_step`(`process_step_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_superseded_by_routing_id` FOREIGN KEY (`superseded_by_routing_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_superseded_routing_id` FOREIGN KEY (`superseded_routing_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`routing`(`routing_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`manufacturing` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `pharmaceuticals_ecm`.`manufacturing` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Campaign ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_value_regex' = '^CMP-[A-Z0-9]{8,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Line Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `master_batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Master Batch Record (MBR) ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Purchase Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Production Supervisor Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Production Routing ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `routing_id` SET TAGS ('dbx_value_regex' = '^RTG-[A-Z0-9]{8,15}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `cmo_cdmo_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Manufacturing Organization (CMO) / Contract Development and Manufacturing Organization (CDMO) Code');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `cmo_cdmo_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Product Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{10,11}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Production Order Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Production Order Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'process_order|production_order|packaging_order|rework_order|validation_batch|exhibit_batch');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `pat_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Analytical Technology (PAT) Enabled Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Production Priority');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `qbd_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality by Design (QbD) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Material Reconciliation Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|variance_identified|investigation_required|approved');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `rework_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `validation_batch_flag` SET TAGS ('dbx_business_glossary_term' = 'Validation Batch Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Yield Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Operator Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `campaign_id` SET TAGS ('dbx_value_regex' = '^CAMP-[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Line Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `master_batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Master Batch Record (MBR) ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `warehouse_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Receipt Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `actual_yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'in_process|released|rejected|quarantine|on_hold|expired');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_type` SET TAGS ('dbx_value_regex' = 'drug_substance|drug_product|api|intermediate|bulk|finished_dosage_form');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `capa_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `disposition_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approver Name');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'release|reject|rework|reprocess|destroy');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `disposition_rationale` SET TAGS ('dbx_business_glossary_term' = 'Disposition Rationale');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `environmental_monitoring_compliant` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Compliant');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `formulation_version` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `formulation_version` SET TAGS ('dbx_value_regex' = '^V[0-9]{1,3}(.[0-9]{1,2})?$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'cgmp|gmp|non_gmp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `manufacturing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing End Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `manufacturing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Start Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `pat_monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Process Analytical Technology (PAT) Monitoring Enabled');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `qbd_design_space_compliance` SET TAGS ('dbx_business_glossary_term' = 'Quality by Design (QbD) Design Space Compliance');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|discrepancy_identified|under_investigation');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `sterility_assurance_level` SET TAGS ('dbx_business_glossary_term' = 'Sterility Assurance Level (SAL)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `sterility_assurance_level` SET TAGS ('dbx_value_regex' = '^SAL-10^-[0-9]$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Method');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_value_regex' = 'autoclave|dry_heat|ethylene_oxide|gamma_irradiation|filtration|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `theoretical_yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Yield Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `master_batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Master Batch Record (MBR) ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Mbr Author Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `superseded_by_mbr_master_batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Master Batch Record (MBR) ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `batch_size_maximum` SET TAGS ('dbx_business_glossary_term' = 'Maximum Batch Size');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `batch_size_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Batch Size');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `batch_size_standard` SET TAGS ('dbx_business_glossary_term' = 'Standard Batch Size');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_value_regex' = 'kg|L|units|tablets|vials|doses');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `cgmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Current Good Manufacturing Practice (cGMP) Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Document Location');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `equipment_requirements` SET TAGS ('dbx_business_glossary_term' = 'Equipment Requirements');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `expected_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Expected Yield Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `formulation_details` SET TAGS ('dbx_business_glossary_term' = 'Formulation Details');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `formulation_details` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `in_process_control_specifications` SET TAGS ('dbx_business_glossary_term' = 'In-Process Control Specifications');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `manufacturing_process_type` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Process Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `mbr_number` SET TAGS ('dbx_business_glossary_term' = 'Master Batch Record (MBR) Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `mbr_number` SET TAGS ('dbx_value_regex' = '^MBR-[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `mbr_title` SET TAGS ('dbx_business_glossary_term' = 'Master Batch Record (MBR) Title');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `minimum_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Acceptable Yield Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `pat_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Analytical Technology (PAT) Enabled Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `process_description` SET TAGS ('dbx_business_glossary_term' = 'Process Description');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `qbd_approach_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality by Design (QbD) Approach Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Product Strength');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` SET TAGS ('dbx_subdomain' = 'asset_infrastructure');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Cmo Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Site Activation Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|metric_ton|million_units|thousand_vials|batches|liters');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `capacity_units_per_year` SET TAGS ('dbx_business_glossary_term' = 'Site Capacity Units Per Year');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Site Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `ema_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'European Medicines Agency (EMA) Authorization Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `ema_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'European Medicines Agency (EMA) Authorization Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `ema_authorization_status` SET TAGS ('dbx_value_regex' = 'authorized|expired|pending|not_applicable|suspended');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `environmental_monitoring_program` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Program');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `erp_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Plant Code');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `erp_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `fda_registration_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Registration Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `fda_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Registration Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `fda_registration_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `fda_registration_status` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Registration Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `fda_registration_status` SET TAGS ('dbx_value_regex' = 'registered|expired|pending|not_applicable|suspended');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `gmp_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `gmp_certification_status` SET TAGS ('dbx_value_regex' = 'certified|expired|pending|not_certified|conditional');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `iso_9001_certification_date` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 9001 Certification Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 9001 Certified');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `last_gmp_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Good Manufacturing Practice (GMP) Inspection Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `mes_site_identifier` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Site Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `next_gmp_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Good Manufacturing Practice (GMP) Inspection Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|temporarily_closed|decommissioned|under_construction|startup|suspended');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'internal|cmo|cdmo|joint_venture');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `pat_capability` SET TAGS ('dbx_business_glossary_term' = 'Process Analytical Technology (PAT) Capability');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `pics_membership_status` SET TAGS ('dbx_business_glossary_term' = 'Pharmaceutical Inspection Co-operation Scheme (PIC/S) Membership Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `pics_membership_status` SET TAGS ('dbx_value_regex' = 'member|non_member|applicant');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `qbd_implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Quality by Design (QbD) Implementation Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `qbd_implementation_status` SET TAGS ('dbx_value_regex' = 'fully_implemented|partially_implemented|not_implemented|planned');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `quality_management_system` SET TAGS ('dbx_business_glossary_term' = 'Quality Management System (QMS)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `quality_management_system` SET TAGS ('dbx_value_regex' = 'mastercontrol|trackwise|veeva_quality|sap_qm|other');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'api_manufacturing|formulation|fill_finish|packaging|combination|analytical_testing');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` SET TAGS ('dbx_subdomain' = 'asset_infrastructure');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Line Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi-automated|fully-automated|continuous-manufacturing');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `capacity_kg_per_batch` SET TAGS ('dbx_business_glossary_term' = 'Capacity Kilograms (kg) Per Batch');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `capacity_units_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Hour');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `changeover_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time Hours');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `cleaning_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Validation Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `cleaning_validation_status` SET TAGS ('dbx_value_regex' = 'validated|pending|expired|not-required');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `cleanroom_classification` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Classification');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `cmo_cdmo_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Manufacturing Organization (CMO) or Contract Development and Manufacturing Organization (CDMO) Name');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `cmo_cdmo_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `cmo_cdmo_operated` SET TAGS ('dbx_business_glossary_term' = 'Contract Manufacturing Organization (CMO) or Contract Development and Manufacturing Organization (CDMO) Operated');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `dosage_form_type` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `environmental_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Required');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `equipment_train_composition` SET TAGS ('dbx_business_glossary_term' = 'Equipment Train Composition');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'no-observations|voluntary-action-indicated|official-action-indicated|not-inspected');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Line Code');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Line Name');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Line Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `mes_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Integration Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `mes_integration_status` SET TAGS ('dbx_value_regex' = 'integrated|partial|not-integrated');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `oee_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Target Percent');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'available|in-use|under-maintenance|under-qualification|decommissioned|quarantined');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `pat_enabled` SET TAGS ('dbx_business_glossary_term' = 'Process Analytical Technology (PAT) Enabled');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `regulatory_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `serialization_capable` SET TAGS ('dbx_business_glossary_term' = 'Serialization Capable');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single-shift|two-shift|three-shift|continuous|campaign-based');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `validated_status` SET TAGS ('dbx_business_glossary_term' = 'Validated Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ALTER COLUMN `validated_status` SET TAGS ('dbx_value_regex' = 'validated|qualification-in-progress|not-validated|revalidation-required');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` SET TAGS ('dbx_subdomain' = 'asset_infrastructure');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Line Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Owner Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Purchase Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Equipment Acquisition Cost');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `acquisition_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `acquisition_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `asset_criticality` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Classification');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `asset_criticality` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `calibration_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency in Days');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Calibration Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_calibrated|calibrated|calibration_due|overdue|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Equipment Capacity Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `capacity_value` SET TAGS ('dbx_business_glossary_term' = 'Equipment Capacity Value');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `clean_room_classification` SET TAGS ('dbx_business_glossary_term' = 'Clean Room Classification');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Commissioning Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `csv_status` SET TAGS ('dbx_business_glossary_term' = 'Computer System Validation (CSV) Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `csv_status` SET TAGS ('dbx_value_regex' = 'not_applicable|not_validated|validation_in_progress|validated|revalidation_required');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `equipment_category` SET TAGS ('dbx_value_regex' = 'production|packaging|quality_control|utilities|support');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `equipment_description` SET TAGS ('dbx_business_glossary_term' = 'Equipment Description');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `gmp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Critical Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Installation Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `iq_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Qualification (IQ) Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `last_pm_date` SET TAGS ('dbx_business_glossary_term' = 'Last Preventive Maintenance Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `next_pm_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Preventive Maintenance Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `next_qualification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Qualification Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Operational Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `oq_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Operational Qualification (OQ) Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `pq_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Qualification (PQ) Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `sap_equipment_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Maintenance (PM) Equipment Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `sap_equipment_number` SET TAGS ('dbx_value_regex' = '^[0-9]{8,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `tag_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Tag Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` SET TAGS ('dbx_subdomain' = 'asset_infrastructure');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `equipment_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Qualification ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `acceptance_criteria_summary` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Summary');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `capa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `capa_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Qualification Comments');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `csv_category` SET TAGS ('dbx_business_glossary_term' = 'Computer System Validation (CSV) Category');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `csv_category` SET TAGS ('dbx_value_regex' = 'Category 1|Category 2|Category 3|Category 4|Category 5');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `engineering_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Engineering Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `engineering_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Engineering Approver Name');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `engineering_approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `execution_end_date` SET TAGS ('dbx_business_glossary_term' = 'Execution End Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `execution_start_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `gmp_impact_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Impact Classification');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `gmp_impact_classification` SET TAGS ('dbx_value_regex' = 'GMP Critical|GMP Non-Critical|GMP Impact|Non-GMP');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `next_requalification_date` SET TAGS ('dbx_business_glossary_term' = 'Next Requalification Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_lead_email` SET TAGS ('dbx_business_glossary_term' = 'Qualification Lead Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_lead_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_lead_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_lead_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_lead_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Lead Name');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_lead_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Qualification Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_outcome` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Pass with Deviation|Conditional Pass');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Protocol Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_protocol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Qualification Scope Description');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'IQ|OQ|PQ|Requalification|Concurrent Validation|Retrospective Validation');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `quality_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `quality_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Approver Name');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `quality_approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `risk_assessment_reference` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `risk_assessment_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `test_cases_executed_count` SET TAGS ('dbx_business_glossary_term' = 'Test Cases Executed Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `test_cases_failed_count` SET TAGS ('dbx_business_glossary_term' = 'Test Cases Failed Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `test_cases_passed_count` SET TAGS ('dbx_business_glossary_term' = 'Test Cases Passed Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `validation_report_number` SET TAGS ('dbx_business_glossary_term' = 'Validation Report Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `validation_report_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Vendor Name');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `vendor_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `vendor_qualification_status` SET TAGS ('dbx_value_regex' = 'Qualified|Not Qualified|Qualification Pending|Requalification Required');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `campaign_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Plan ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Line ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `batch_quantity_planned` SET TAGS ('dbx_business_glossary_term' = 'Batch Quantity Planned');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `batch_size_planned` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Planned');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'single_product|multi_product|validation|clinical|commercial');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `capacity_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Percent');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `cgmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Current Good Manufacturing Practice (cGMP) Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `cmo_cdmo_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Manufacturing Organization (CMO) / Contract Development and Manufacturing Organization (CDMO) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `downtime_reason` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `downtime_window_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Window End Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `downtime_window_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Window Start Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Executed Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `frozen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Frozen Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `pat_implementation_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Analytical Technology (PAT) Implementation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `qbd_principles_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality by Design (QbD) Principles Applied Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|approved|frozen|executed|cancelled|revised');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'master|operational|tactical|strategic');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `scheduled_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Duration Hours');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `supply_chain_planning_system` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Planning System');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `supply_chain_planning_system` SET TAGS ('dbx_value_regex' = 'kinaxis|blue_yonder|sap_ibp|other');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `process_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Process Parameter Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `manufacturing_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Measured Value');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `conformance_status` SET TAGS ('dbx_business_glossary_term' = 'Conformance Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `conformance_status` SET TAGS ('dbx_value_regex' = 'within_specification|within_control|out_of_control|out_of_specification|under_investigation|deviation_raised');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `criticality_justification` SET TAGS ('dbx_business_glossary_term' = 'Criticality Justification');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `data_integrity_hash` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity Hash');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `lower_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `parameter_type` SET TAGS ('dbx_business_glossary_term' = 'Parameter Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `parameter_type` SET TAGS ('dbx_value_regex' = 'critical_process_parameter|non_critical_parameter|critical_quality_attribute|in_process_control');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `parameter_version` SET TAGS ('dbx_business_glossary_term' = 'Parameter Version');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `pat_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Analytical Technology (PAT) Enabled Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `process_parameter_result_id` SET TAGS ('dbx_business_glossary_term' = 'Process Parameter Result ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `manufacturing_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `process_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Parameter ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'MES|SCADA|LIMS|Manual Entry|PAT System|ELN');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `evaluation_result` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Result');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `evaluation_result` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Warning|Not Evaluated');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `instrument_code` SET TAGS ('dbx_business_glossary_term' = 'Instrument Code');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'Manual|Automated|PAT|SCADA|Laboratory');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `operator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `parameter_type` SET TAGS ('dbx_business_glossary_term' = 'Parameter Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `parameter_type` SET TAGS ('dbx_value_regex' = 'CPP|Non-Critical|IPC|PAT');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `pat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Process Analytical Technology (PAT) Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'Active|Superseded|Voided|Archived');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `sampling_point` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `test_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Pending|Verified|Rejected|Under Review');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `manufacturing_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Deviation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `icsr_id` SET TAGS ('dbx_business_glossary_term' = 'Icsr Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `patent_litigation_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Litigation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By User Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `quality_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `tertiary_manufacturing_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `tertiary_manufacturing_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `tertiary_manufacturing_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `cmo_cdmo_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Manufacturing Organization (CMO) / Contract Development and Manufacturing Organization (CDMO) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `detection_date` SET TAGS ('dbx_business_glossary_term' = 'Detection Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `detection_phase` SET TAGS ('dbx_business_glossary_term' = 'Detection Phase');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `detection_phase` SET TAGS ('dbx_value_regex' = 'in_process|packaging|qc_testing|release_testing|stability_testing|post_release');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_business_glossary_term' = 'Deviation Category');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `deviation_number` SET TAGS ('dbx_business_glossary_term' = 'Deviation Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `deviation_number` SET TAGS ('dbx_value_regex' = '^DEV-[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `deviation_type` SET TAGS ('dbx_business_glossary_term' = 'Deviation Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `deviation_type` SET TAGS ('dbx_value_regex' = 'process|equipment|material|environmental|documentation|personnel');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `manufacturing_area` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Area');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `manufacturing_deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `manufacturing_deviation_status` SET TAGS ('dbx_business_glossary_term' = 'Deviation Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `manufacturing_deviation_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_capa|closed|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `product_disposition` SET TAGS ('dbx_business_glossary_term' = 'Product Disposition');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `product_disposition` SET TAGS ('dbx_value_regex' = 'released|rejected|reworked|quarantined|pending_investigation');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `qms_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Management System (QMS) System Reference');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Deviation Severity');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `master_batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Master Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `animal_derived_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Animal-Derived Material (ADM) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `api_component_count` SET TAGS ('dbx_business_glossary_term' = 'Active Pharmaceutical Ingredient (API) Component Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Standard Batch Size');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `bom_number` SET TAGS ('dbx_value_regex' = '^BOM-[A-Z0-9]{8,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `bom_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|obsolete');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `bom_version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `bom_version` SET TAGS ('dbx_value_regex' = '^V[0-9]{2,4}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `change_control_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `controlled_substance_flag` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `excipient_component_count` SET TAGS ('dbx_business_glossary_term' = 'Excipient Component Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `gmp_grade_requirement` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Grade Requirement');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'BOM Notes');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `overage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overage Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `packaging_component_count` SET TAGS ('dbx_business_glossary_term' = 'Packaging Component Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `qbd_design_space_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality by Design (QbD) Design Space Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `total_component_count` SET TAGS ('dbx_business_glossary_term' = 'Total Component Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `total_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Material Cost');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `total_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Yield Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `process_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Process Validation ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Line Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `pv_product_id` SET TAGS ('dbx_business_glossary_term' = 'Pv Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `rd_capitalization_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Capitalization Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `batch_size_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Batch Size');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `batch_size_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Batch Size');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `cpp_monitored` SET TAGS ('dbx_business_glossary_term' = 'Critical Process Parameters (CPP) Monitored');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `cqa_monitored` SET TAGS ('dbx_business_glossary_term' = 'Critical Quality Attributes (CQA) Monitored');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `design_space_defined` SET TAGS ('dbx_business_glossary_term' = 'Design Space Defined');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `execution_end_date` SET TAGS ('dbx_business_glossary_term' = 'Execution End Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `execution_start_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Periodic Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `number_of_runs` SET TAGS ('dbx_business_glossary_term' = 'Number of Validation Runs');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `oos_count` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification (OOS) Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `pat_implementation` SET TAGS ('dbx_business_glossary_term' = 'Process Analytical Technology (PAT) Implementation');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `protocol_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `protocol_number` SET TAGS ('dbx_value_regex' = '^PV-[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `qa_approver` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Approver');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `report_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Report Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `revalidation_trigger` SET TAGS ('dbx_business_glossary_term' = 'Revalidation Trigger');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_approach` SET TAGS ('dbx_business_glossary_term' = 'Validation Approach');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_approach` SET TAGS ('dbx_value_regex' = 'traditional|qbd|hybrid|risk_based');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_lead` SET TAGS ('dbx_business_glossary_term' = 'Validation Lead');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Validation Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|inconclusive');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_stage` SET TAGS ('dbx_business_glossary_term' = 'Validation Stage');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_stage` SET TAGS ('dbx_value_regex' = 'stage_1_process_design|stage_2_process_qualification|stage_3_continued_verification|prospective|concurrent|retrospective');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_business_glossary_term' = 'Validation Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_value_regex' = 'process|cleaning|computerized_system|analytical_method|equipment|sterilization');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring (EM) ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `manufacturing_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `quality_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `action_limit` SET TAGS ('dbx_business_glossary_term' = 'Action Limit');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `action_limit_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Action Limit Exceeded Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `alert_limit` SET TAGS ('dbx_business_glossary_term' = 'Alert Limit');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `alert_limit_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Limit Exceeded Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `cfu_count` SET TAGS ('dbx_business_glossary_term' = 'Colony Forming Units (CFU) Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `cfu_per_cubic_meter` SET TAGS ('dbx_business_glossary_term' = 'Colony Forming Units (CFU) per Cubic Meter');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `cleanroom_classification_iso` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Classification (ISO)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `cleanroom_classification_iso` SET TAGS ('dbx_value_regex' = 'ISO 5|ISO 6|ISO 7|ISO 8|ISO 9');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `cleanroom_grade_eu` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Grade (EU GMP)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `cleanroom_grade_eu` SET TAGS ('dbx_value_regex' = 'Grade A|Grade B|Grade C|Grade D');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `exposure_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Exposure Duration (Minutes)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `incubation_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Incubation Duration (Hours)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `incubation_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Incubation Temperature (Celsius)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `manufacturing_operation_phase` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Operation Phase');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `manufacturing_operation_phase` SET TAGS ('dbx_value_regex' = 'at-rest|operational|intervention');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `monitoring_location_code` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location Code');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `monitoring_location_description` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location Description');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_value_regex' = 'viable air|surface|personnel|non-viable particulate|water');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `organism_identified` SET TAGS ('dbx_business_glossary_term' = 'Organism Identified');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `particulate_count_0_5_micron` SET TAGS ('dbx_business_glossary_term' = 'Particulate Count (0.5 Micron)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `particulate_count_5_0_micron` SET TAGS ('dbx_business_glossary_term' = 'Particulate Count (5.0 Micron)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'pass|alert|action|fail');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `sample_collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `sample_volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume (Liters)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `sampling_method` SET TAGS ('dbx_value_regex' = 'active air|passive air|contact plate|swab|finger dab|glove print');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ALTER COLUMN `trend_flag` SET TAGS ('dbx_business_glossary_term' = 'Trend Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` SET TAGS ('dbx_subdomain' = 'partner_network');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `cmo_oversight_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Manufacturing Organization (CMO) Oversight ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `pv_product_id` SET TAGS ('dbx_business_glossary_term' = 'Pv Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Relationship Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Audit Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'compliant|minor_findings|major_findings|critical_findings|not_audited|audit_overdue');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `avl_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `avl_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|suspended|disqualified|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `batch_success_rate` SET TAGS ('dbx_business_glossary_term' = 'Batch Success Rate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `capa_closure_rate` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Closure Rate');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `cgmp_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Current Good Manufacturing Practice (cGMP) Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `cgmp_certification_status` SET TAGS ('dbx_value_regex' = 'certified|expired|pending_renewal|not_certified');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `cmo_type` SET TAGS ('dbx_business_glossary_term' = 'CMO Organization Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `cmo_type` SET TAGS ('dbx_value_regex' = 'CMO|CDMO|fill_finish_specialist|packaging_specialist|api_manufacturer');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Contract Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'ds_manufacturing|dp_manufacturing|fill_finish|packaging|api_production|formulation');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `contracted_products` SET TAGS ('dbx_business_glossary_term' = 'Contracted Product List');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `deviation_rate` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Deviation Rate');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `manufacturing_capacity` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Capacity Description');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `manufacturing_capacity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'CMO Oversight Notes');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `quality_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `quality_agreement_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `quality_scorecard_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Quality Scorecard Rating');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `quality_scorecard_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|acceptable|needs_improvement|unacceptable');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `regulatory_authority_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Authority Jurisdiction');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `regulatory_inspection_history` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection History Summary');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `relationship_manager` SET TAGS ('dbx_business_glossary_term' = 'CMO Relationship Manager Name');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Risk Tier');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `technical_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Technical Agreement Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `technical_agreement_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ALTER COLUMN `technology_platform` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Technology Platform');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` SET TAGS ('dbx_subdomain' = 'partner_network');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `technology_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Cmo Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `master_batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Master Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `pv_product_id` SET TAGS ('dbx_business_glossary_term' = 'Pv Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `rd_capitalization_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Capitalization Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `source_site_id` SET TAGS ('dbx_business_glossary_term' = 'Source Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `predecessor_technology_transfer_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `analytical_methods_transferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Analytical Methods Transferred Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `cgmp_compliance_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Current Good Manufacturing Practice (cGMP) Compliance Verified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `cleaning_procedures_transferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Procedures Transferred Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `cmo_cdmo_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Manufacturing Organization (CMO) / Contract Development and Manufacturing Organization (CDMO) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `pat_implementation_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Analytical Technology (PAT) Implementation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `process_parameters_transferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Parameters Transferred Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `qbd_approach_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality by Design (QbD) Approach Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `qualification_batch_count` SET TAGS ('dbx_business_glossary_term' = 'Qualification Batch Count');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `qualification_batches_completed` SET TAGS ('dbx_business_glossary_term' = 'Qualification Batches Completed');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `readiness_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Readiness Assessment Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `readiness_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Readiness Assessment Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `readiness_assessment_status` SET TAGS ('dbx_value_regex' = 'not-started|in-progress|completed|approved');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `regulatory_change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Control Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `regulatory_submission_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `stability_data_transferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Stability Data Transferred Flag');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Initiation Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_outcome` SET TAGS ('dbx_business_glossary_term' = 'Transfer Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_outcome` SET TAGS ('dbx_value_regex' = 'successful|successful-with-deviations|unsuccessful|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Protocol Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_report_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Report Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_report_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Report Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_stage` SET TAGS ('dbx_business_glossary_term' = 'Transfer Stage');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_value_regex' = 'planned|in-progress|on-hold|completed|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_team_lead_email` SET TAGS ('dbx_business_glossary_term' = 'Transfer Team Lead Email');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_team_lead_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_team_lead_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_team_lead_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_team_lead_name` SET TAGS ('dbx_business_glossary_term' = 'Transfer Team Lead Name');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'site-to-site|r&d-to-commercial|cmo-onboarding|cmo-offboarding|scale-up|process-improvement');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` SET TAGS ('dbx_subdomain' = 'partner_network');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` SET TAGS ('dbx_association_edges' = 'manufacturing.master_batch_record,hcp.investigator');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `investigational_product_supply_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Supply ID');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Supply - Investigator Id');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `master_batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Supply - Master Batch Record Id');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `approved_indication` SET TAGS ('dbx_business_glossary_term' = 'Approved Indication');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `dosing_regimen` SET TAGS ('dbx_business_glossary_term' = 'Dosing Regimen');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Protocol Number');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `supply_allocation_quantity` SET TAGS ('dbx_business_glossary_term' = 'Supply Allocation Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `supply_end_date` SET TAGS ('dbx_business_glossary_term' = 'Supply End Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `supply_start_date` SET TAGS ('dbx_business_glossary_term' = 'Supply Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `supply_status` SET TAGS ('dbx_business_glossary_term' = 'Supply Status');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ALTER COLUMN `trial_phase` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Phase');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` ALTER COLUMN `preceding_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` ALTER COLUMN `parent_sample_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_step` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_step` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_step` ALTER COLUMN `preceding_process_step_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`routing` SET TAGS ('dbx_subdomain' = 'execution_operations');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`routing` ALTER COLUMN `superseded_routing_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`routing` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_confidential' = 'true');
