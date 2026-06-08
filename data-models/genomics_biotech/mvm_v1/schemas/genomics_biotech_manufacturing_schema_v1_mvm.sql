-- Schema for Domain: manufacturing | Business: Genomics Biotech | Version: v1_mvm
-- Generated on: 2026-05-06 15:33:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`manufacturing` COMMENT 'GMP-compliant production of instruments, reagent kits, arrays, flow cells, and consumables — encompassing work orders, MES-driven production steps, BOM execution, batch records, in-process QC checkpoints, yield tracking, equipment qualification, and process validation. Integrates SAP PP/QM and MES for shop-floor execution. Ensures traceability from raw material receipt through finished goods release.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the GMP-compliant production work order. Primary key for the work order entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Custom manufacturing orders for customer-specific reagent kits, custom panels, or contract manufacturing runs must track the customer account for order fulfillment, invoicing, and regulatory traceabil',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Manufacturing orders for regulated genomics products must execute under the approved process described in the regulatory filing. Required for GMP compliance and to ensure production stays within appro',
    `assay_development_id` BIGINT COMMENT 'Foreign key linking to research.assay_development. Business justification: Technology transfer from assay development to manufacturing creates work orders for producing the assay kit. Regulatory submissions (PMA, 510k, CE-IVD) require traceability from the assay development ',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Work orders trigger CAPAs when systemic issues identified (recurring scrap, process capability problems). Process improvement linkage essential for manufacturing excellence in biotech operations.',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: In GMP genomics manufacturing, work orders initiated under a process or BOM change must reference the governing change control record for regulatory traceability. Change control approval is a prerequi',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Make-to-order manufacturing work orders (instruments, custom reagent kits) should reference the sales order that triggered production. This links manufacturing execution to customer orders, enabling o',
    `manufacturing_bom_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_bom. Business justification: A work order executes against a specific manufacturing BOM version. While work_order already references product_bom_id (cross-domain, product design BOM), it lacks a direct FK to the in-domain manufac',
    `material_id` BIGINT COMMENT 'Reference to the product or material being manufactured in this work order (instrument, reagent kit, array, flow cell, or consumable). Links to master material/product catalog.',
    `pipeline_version_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_version. Business justification: A manufacturing work order for a genomics assay kit specifies the required bioinformatics pipeline version for release testing. GMP requirement: the work order must prescribe which validated pipeline ',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: Work orders are executed at a specific ERP plant for MRP scheduling and capacity planning. In genomics biotech ERP integration, every work order must reference the supply plant for goods movement post',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Work orders in GMP genomics manufacturing must identify the specific output SKU (e.g., reagent kit SKU) for inventory posting, demand fulfillment, and lot traceability. product_bom_id identifies the B',
    `production_routing_id` BIGINT COMMENT 'Reference to the production routing (sequence of operations) used for this work order. Defines the manufacturing process steps.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Manufacturing work orders execute production of products developed in R&D projects. Essential for tech transfer traceability, regulatory submissions (linking commercial batches to development history)',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Manufacturing work orders for custom reagent production or instrument service are executed under a specific customer service agreement governing SLA terms, pricing, and billing. Contract-driven manufa',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where production is executed. Links to plant master data.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Work orders for regulated genomics/IVD products must be traceable to the regulatory submission authorizing the product and process. This supports GMP compliance reporting and regulatory inspection rea',
    `technical_requirement_id` BIGINT COMMENT 'Foreign key linking to customer.technical_requirement. Business justification: Custom genomics manufacturing work orders (bespoke library prep kits, custom reagent formulations) are initiated from a customers technical requirement specification capturing read length, coverage d',
    `work_center_id` BIGINT COMMENT 'Reference to the primary work center (production line, equipment group, or manufacturing cell) where the order is executed. Links to work center master.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when all production operations were completed and final goods receipt was posted. Used for TAT analysis and performance metrics.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Actual quantity produced and confirmed through goods receipt. May differ from planned quantity due to yield variance, scrap, or rework.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when production operations commenced, captured from MES or manual confirmation. Critical for cycle time analysis and GMP batch record.',
    `batch_number` STRING COMMENT 'Unique batch or lot number assigned to the production output. Critical for traceability, recall management, and GMP compliance. Format varies by product category.. Valid values are `^[A-Z0-9]{8,16}$`',
    `bom_version` STRING COMMENT 'Version number of the BOM used (e.g., 01, 02). Critical for traceability and change control under GMP.. Valid values are `^[0-9]{2}$`',
    `cost_center_code` STRING COMMENT 'Ten-digit SAP cost center code to which production costs (labor, materials, overhead) are allocated. Used for P&L reporting and COGS calculation.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order record was first created in the SAP PP system. Audit trail for order lifecycle.',
    `deviation_count` STRING COMMENT 'Number of GMP deviations or non-conformances logged during production execution. Zero indicates clean batch; non-zero triggers investigation and CAPA.',
    `expiration_date` DATE COMMENT 'Calculated expiration or use-by date for the manufactured batch based on stability studies and shelf life. Critical for inventory management and customer shipment.',
    `gmp_flag` BOOLEAN COMMENT 'Indicates whether this work order is subject to GMP regulations and requires full electronic batch record, validation, and quality oversight. True for IVD and clinical products; False for RUO products.',
    `goods_receipt_number` STRING COMMENT 'SAP goods receipt document number posted when finished goods are received into inventory. Triggers inventory valuation and availability update.. Valid values are `^GR-[0-9]{10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the work order record. Tracks changes for audit and compliance.',
    `mes_integration_reference` STRING COMMENT 'External reference key linking this SAP work order to the corresponding production order or job in the shop floor MES system. Enables bidirectional data synchronization.. Valid values are `^MES-[A-Z0-9]{12}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the work order. Created: order entered but not released; Released: approved for execution; In Progress: active manufacturing; Confirmed: production complete, pending QC; Technically Complete: all operations finished; Closed: final goods receipt posted; Cancelled: order terminated. [ENUM-REF-CANDIDATE: created|released|in_progress|confirmed|technically_complete|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the production work order type. Process orders are used for batch manufacturing (reagents, consumables), production orders for discrete manufacturing (instruments, arrays), rework orders for quality remediation, validation orders for process qualification, pilot orders for scale-up studies, and engineering orders for R&D prototypes.. Valid values are `process_order|production_order|rework_order|validation_order|pilot_order|engineering_order`',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Target quantity to be produced as specified in the work order. Measured in the base unit of measure for the material.',
    `priority` STRING COMMENT 'Production priority level for scheduling and resource allocation. Urgent: customer escalation or critical shortage; High: committed customer orders; Normal: standard replenishment; Low: safety stock build.. Valid values are `urgent|high|normal|low`',
    `process_validation_status` STRING COMMENT 'Status of process validation for this production run. Validated: process has passed IQ/OQ/PQ; Revalidation Required: change control triggered revalidation; Not Required: RUO product or established process.. Valid values are `not_required|pending|in_progress|validated|revalidation_required`',
    `product_classification` STRING COMMENT 'Regulatory classification of the product being manufactured. IVD: In Vitro Diagnostic (FDA-cleared); RUO: Research Use Only; LDT: Laboratory Developed Test; CE-IVD: European IVD regulation compliant.. Valid values are `IVD|RUO|LDT|CE_IVD`',
    `qc_hold_flag` BOOLEAN COMMENT 'Indicates whether the batch is on QC hold pending final release testing or deviation investigation. True: batch quarantined; False: released or not yet tested.',
    `release_date` DATE COMMENT 'Date when the batch was released by QA for distribution after passing all quality tests and batch record review. Null if still on hold or rejected.',
    `reservation_number` STRING COMMENT 'SAP reservation document number that reserves component materials from inventory for this work order. Links to inventory allocation.. Valid values are `^[0-9]{10}$`',
    `routing_version` STRING COMMENT 'Version number of the routing used (e.g., 01, 02). Ensures process consistency and supports validation requirements.. Valid values are `^[0-9]{2}$`',
    `sales_order_number` STRING COMMENT 'Reference to the originating customer sales order if this is a make-to-order production. Null for make-to-stock orders. Enables order-to-cash traceability.. Valid values are `^SO-[0-9]{10}$`',
    `scheduled_finish_date` DATE COMMENT 'Planned date for production completion and goods receipt. Used for delivery commitment and capacity planning.',
    `scheduled_start_date` DATE COMMENT 'Planned date for production to begin, based on capacity planning and material availability. Used for shop floor scheduling.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of material scrapped or rejected during production due to quality defects or process deviations.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for quantities (EA=each for instruments/arrays, KIT for reagent kits, L/ML for liquid reagents, G/KG for solid materials, M for arrays/strips). [ENUM-REF-CANDIDATE: EA|KIT|L|ML|G|KG|M|UNIT — 8 candidates stripped; promote to reference product]',
    `work_order_number` STRING COMMENT 'Externally-known unique business identifier for the production work order, typically generated by SAP PP module. Format: WO-NNNNNNNN.. Valid values are `^WO-[0-9]{8}$`',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Calculated yield as (actual_quantity / planned_quantity) * 100. Key performance indicator for manufacturing efficiency and process capability.',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'GMP-compliant production work order representing a discrete manufacturing execution unit for instruments, reagent kits, arrays, flow cells, or consumables. Captures SAP PP production order details including order number, product/material being produced, planned vs actual quantities, scheduled start/finish dates, actual start/finish dates, production plant, work center, BOM version, routing version, order type (e.g., process order, production order), order status (created, released, confirmed, technically complete), priority, batch number assigned, MES integration reference, and GxP-relevant fields such as GMP flag and electronic batch record reference.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` (
    `production_batch_id` BIGINT COMMENT 'Unique identifier for the production batch. Primary key for the production batch master record.',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Production batches manufactured under a changed process must reference the governing change control for GMP traceability. Regulatory inspectors require evidence that batches produced post-change were ',
    `device_identifier_id` BIGINT COMMENT 'Foreign key linking to regulatory.device_identifier. Business justification: Under FDA UDI rules and EU IVDR, every IVD production batch must be traceable to its device identifier (UDI-DI). The device identifier defines the product configuration; the batch carries the UDI-PI. ',
    `manufacturing_bom_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_bom. Business justification: Each production batch is manufactured using a specific BOM version. Cardinality: N batches : 1 BOM. Adding manufacturing_bom_header_id FK establishes authoritative BOM reference. Removing bom_version ',
    `material_id` BIGINT COMMENT 'Reference to the material master record representing the product being manufactured (reagent kit, flow cell, array, consumable, or instrument sub-assembly).',
    `batch_id` BIGINT COMMENT 'Unique batch identifier in the Manufacturing Execution System (MES) for shop-floor execution tracking.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: GMP batch records must be traceable to the ERP plant for regulatory submissions, batch disposition, and goods movement posting. In genomics biotech, FDA 21 CFR Part 211 and ISO 13485 require plant-lev',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Production batch records in genomics biotech must be traceable to the specific output SKU for CoA generation, lot release, and inventory posting. batch_record links to catalog_item but production_batc',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site or plant where this batch was produced.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: GMP batch disposition in genomics biotech requires direct traceability from each production batch to the product specification used for acceptance criteria evaluation. This link supports batch release',
    `study_id` BIGINT COMMENT 'Foreign key linking to research.study. Business justification: GMP/GCP traceability requires production batches of study-specific genomics reagents (sequencing kits, CRISPR materials) to be linked to the originating research study. Regulatory audits and study clo',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_order. Business justification: Production batch is created from a work order. Cardinality: N batches : 1 work order (campaign scenarios allow multiple batches per work order). Adding work_order_id FK enables direct linkage. Removin',
    `batch_disposition` STRING COMMENT 'Quality disposition decision for the batch indicating release readiness. Linked to QM usage decision.. Valid values are `pending|approved|rejected|conditional_release`',
    `batch_number` STRING COMMENT 'Externally-known unique batch or lot number assigned to this production run. Used for traceability and Certificate of Analysis (COA) reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `batch_size_actual` DECIMAL(18,2) COMMENT 'Actual quantity of units produced in this batch after manufacturing completion.',
    `batch_size_planned` DECIMAL(18,2) COMMENT 'Planned quantity of units to be produced in this batch as defined in the production order.',
    `batch_status` STRING COMMENT 'Current lifecycle status of the production batch in the manufacturing workflow. [ENUM-REF-CANDIDATE: planned|in_production|completed|on_hold|released|rejected|quarantine — 7 candidates stripped; promote to reference product]',
    `coa_reference_number` STRING COMMENT 'Reference number for the Certificate of Analysis document issued for this batch.. Valid values are `^COA-[A-Z0-9]{8,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production batch record was first created in the system.',
    `deviation_count` STRING COMMENT 'Number of manufacturing deviations recorded during batch production. Deviations require investigation and disposition.',
    `ebr_approval_date` DATE COMMENT 'Date when the batch record was formally approved for batch release.',
    `ebr_approver_name` STRING COMMENT 'Full name of the quality manager who approved the batch record.',
    `ebr_document_reference` STRING COMMENT 'Unique document identifier for the Electronic Batch Record in the document management system (e.g., Veeva Vault).. Valid values are `^[A-Z0-9-]{10,30}$`',
    `ebr_review_date` DATE COMMENT 'Date when the batch record review was completed.',
    `ebr_reviewer_name` STRING COMMENT 'Full name of the quality assurance reviewer who reviewed the batch record.',
    `ebr_status` STRING COMMENT 'Current status of the Electronic Batch Record (EBR) in the review and approval workflow.. Valid values are `draft|in_review|approved|rejected|archived`',
    `ebr_version` STRING COMMENT 'Version number of the Electronic Batch Record document.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `equipment_qualification_status` STRING COMMENT 'Indicates whether all equipment used in this batch production was in a qualified state (IQ/OQ/PQ).. Valid values are `qualified|requalification_required|not_qualified`',
    `exception_count` STRING COMMENT 'Number of exceptions or non-conformances identified during batch production or quality review.',
    `expiry_date` DATE COMMENT 'Date after which the batch is no longer suitable for use. Critical for reagent kits and consumables with shelf life.',
    `gmp_classification` STRING COMMENT 'Indicates whether this batch was manufactured under Good Manufacturing Practice (GMP) regulations.. Valid values are `gmp|non_gmp`',
    `manufacturing_end_date` DATE COMMENT 'Date when manufacturing operations for this batch were completed.',
    `manufacturing_start_date` DATE COMMENT 'Date when manufacturing operations for this batch commenced.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production batch record was last modified.',
    `process_validation_status` STRING COMMENT 'Indicates whether the manufacturing process used for this batch is in a validated state per GMP requirements.. Valid values are `validated|revalidation_required|not_validated`',
    `product_category` STRING COMMENT 'High-level classification of the manufactured product type.. Valid values are `reagent_kit|flow_cell|array|consumable|instrument_subassembly|other`',
    `qc_checkpoint_count` STRING COMMENT 'Number of in-process quality control checkpoints executed during batch production.',
    `qc_fail_count` STRING COMMENT 'Number of quality control checkpoints that failed acceptance criteria and required investigation.',
    `qc_pass_count` STRING COMMENT 'Number of quality control checkpoints that passed acceptance criteria.',
    `retest_date` DATE COMMENT 'Date when the batch must be retested to confirm continued suitability for use.',
    `shelf_life_months` STRING COMMENT 'Validated shelf life of the product in months from manufacturing date.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for batch size (e.g., EA for each, KIT for kit, L for liters).. Valid values are `^[A-Z]{2,6}$`',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Manufacturing yield calculated as (actual batch size / planned batch size) * 100. Key performance indicator for production efficiency.',
    CONSTRAINT pk_production_batch PRIMARY KEY(`production_batch_id`)
) COMMENT 'Master record for a discrete manufactured batch (LOT) of a genomics/biotech product — reagent kit, flow cell, array, consumable, or instrument sub-assembly. Serves as the single source of truth for batch identity, batch documentation (Electronic Batch Record / EBR), and batch release readiness. Captures batch number, material, batch size, manufacturing/expiry/retest dates, batch status and disposition, GMP classification, manufacturing site, production line, and COA reference. Owns the complete EBR lifecycle: batch record status (draft, in-review, approved, rejected), review/approval workflow with electronic signatures (21 CFR Part 11 / Annex 11), reviewer/approver identities, deviation and exception counts, material consumption records, and MES/Veeva Vault document references. Integrates with SAP PP batch master and QM usage decision.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` (
    `manufacturing_bom_id` BIGINT COMMENT 'Primary key for bom',
    `assay_development_id` BIGINT COMMENT 'Foreign key linking to research.assay_development. Business justification: The manufacturing BOM for a genomics assay kit is directly derived from the assay development program that defined required components, reagent specifications, and formulations. FDA Design History Fil',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: BOM changes in GMP genomics manufacturing must be governed by an approved change control record per ICH Q10. The manufacturing_bom has change_number as a plain text field. A proper FK to quality.chang',
    `crispr_construct_id` BIGINT COMMENT 'Foreign key linking to research.crispr_construct. Business justification: CRISPR constructs developed in R&D become manufactured components in gene editing products. BOMs must reference specific construct designs for regulatory traceability, IP protection, and quality contr',
    `device_identifier_id` BIGINT COMMENT 'Foreign key linking to regulatory.device_identifier. Business justification: The manufacturing BOM defines the exact component configuration of an IVD/genomics device as registered under a specific UDI-DI. BOM-to-device-identifier traceability is required for UDI compliance — ',
    `molecular_design_id` BIGINT COMMENT 'Foreign key linking to research.molecular_design. Business justification: Manufacturing BOMs for genomic products (sequencing panels, gene editing kits) include molecular designs (oligos, probes, guides) developed in R&D. Essential for IP traceability, regulatory submission',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: Manufacturing BOMs in ERP are plant-specific — reagent grades, component sources, and shelf-life requirements differ by plant. In genomics biotech, BOM approval and change control are managed per plan',
    `product_bom_id` BIGINT COMMENT 'Foreign key linking to product.bom. Business justification: Manufacturing BOMs are plant-specific implementations of engineering BOMs. Process engineers trace manufacturing variants to master product BOMs for change control, validation protocols, and regulator',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: The manufacturing BOM defines the exact component configuration of a regulated IVD/genomics product. BOM versions are included in regulatory submissions (technical file/dossier). BOM changes trigger s',
    `alternative` STRING COMMENT 'Alternative BOM sequence number. Allows multiple BOMs for the same material (e.g., different production methods, regional variants, or process alternatives). Default is typically 01.. Valid values are `^[0-9]{1,2}$`',
    `assembly_type` STRING COMMENT 'The type of finished product assembly defined by this BOM. Instruments are capital equipment; reagent kits and arrays are consumables; flow cells are single-use sequencing components. [ENUM-REF-CANDIDATE: instrument|reagent_kit|array|flow_cell|consumable|accessory|spare_part — 7 candidates stripped; promote to reference product]',
    `authorization_group` STRING COMMENT 'Security authorization group controlling access to this BOM. Restricts visibility and modification rights based on user roles and organizational responsibilities.. Valid values are `^[A-Z0-9]{4}$`',
    `base_quantity` DECIMAL(18,2) COMMENT 'The quantity of the finished product for which the component quantities are defined. Typically 1 unit, but may vary for batch or bulk production (e.g., 100 units, 1000 liters).',
    `base_unit_of_measure` STRING COMMENT 'The unit of measure for the base quantity (e.g., EA for each, KG for kilogram, L for liter). Must align with the material master base UoM.. Valid values are `^[A-Z]{2,3}$`',
    `bom_category` STRING COMMENT 'The structural category of the BOM. Material BOMs define physical assemblies; equipment BOMs define installed base configurations; document BOMs group related documentation.. Valid values are `material|equipment|document|standard|variant`',
    `bom_status` STRING COMMENT 'Current lifecycle status of the BOM. Active BOMs are used in production; inactive or blocked BOMs are not available for MRP or manufacturing execution.. Valid values are `active|inactive|blocked|in_review|obsolete`',
    `bom_text` STRING COMMENT 'Free-form descriptive text or notes about the BOM. May include assembly instructions, special handling requirements, or process notes.',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether the finished product requires temperature-controlled storage and shipping (typically 2-8°C or -20°C). True for many reagent kits and biological materials.',
    `cost_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the standard cost (e.g., USD, EUR, GBP). Aligns with the plants controlling area currency.. Valid values are `^[A-Z]{3}$`',
    `costing_lot_size` DECIMAL(18,2) COMMENT 'The production lot size used for standard cost calculation. Fixed costs are amortized over this quantity. May differ from actual production batch sizes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM record was first created in the system. Immutable audit field.',
    `deletion_flag` BOOLEAN COMMENT 'Indicates whether this BOM is marked for deletion. True means the BOM is flagged for archival and will not be used in future production planning.',
    `explosion_type` STRING COMMENT 'Defines how the BOM is exploded in MRP and production planning. Single-level shows only immediate components; multi-level recursively expands all sub-assemblies; summarized aggregates across levels.. Valid values are `single_level|multi_level|summarized`',
    `gmp_relevant` BOOLEAN COMMENT 'Indicates whether this BOM is subject to GMP regulations and requires enhanced documentation, validation, and change control. True for IVD and clinical products.',
    `hazmat_classification` STRING COMMENT 'The hazardous material classification code for the finished product if it contains dangerous goods (e.g., flammable reagents, corrosive chemicals). Used for shipping and safety compliance.',
    `ivd_classification` STRING COMMENT 'The regulatory classification of the product defined by this BOM. RUO (Research Use Only) products have minimal regulatory burden; IVD products require CE-IVD or FDA clearance; LDT (Laboratory Developed Test) products are lab-specific. [ENUM-REF-CANDIDATE: ruo|ivd|ldt|class_i|class_ii|class_iii|not_applicable — 7 candidates stripped; promote to reference product]',
    `laboratory_design_office` STRING COMMENT 'The R&D laboratory or engineering design office responsible for creating and maintaining this BOM. Links to organizational master data.. Valid values are `^[A-Z0-9]{3,8}$`',
    `last_modified_by` STRING COMMENT 'The user ID of the person who last modified this BOM record. Updated with each change to support change tracking.. Valid values are `^[A-Z0-9]{6,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM record was last modified. Updated with each change to support version control and audit compliance.',
    `lot_size_from` DECIMAL(18,2) COMMENT 'The minimum production lot size for which this BOM is valid. Supports lot-size-dependent BOMs where component quantities or assembly methods vary by batch size.',
    `lot_size_to` DECIMAL(18,2) COMMENT 'The maximum production lot size for which this BOM is valid. Nullable for open-ended upper bound. Used in conjunction with lot_size_from for range-based BOM selection.',
    `material_number` STRING COMMENT 'The finished product material number for which this BOM is defined. Represents the parent assembly (instrument, reagent kit, array, flow cell, or consumable).. Valid values are `^[A-Z0-9]{8,18}$`',
    `product_family` STRING COMMENT 'The high-level product family or platform to which this BOM belongs (e.g., NovaSeq, MiSeq, Infinium, TruSeq). Used for portfolio management and cross-product analytics.',
    `production_version` STRING COMMENT 'Links this BOM to a specific production version that combines BOM alternative, routing, and production line. Enables integrated production planning and execution.. Valid values are `^[0-9]{4}$`',
    `serialization_required` BOOLEAN COMMENT 'Indicates whether finished goods produced from this BOM must be individually serialized for traceability. True for instruments and high-value components; false for bulk consumables.',
    `shelf_life_days` STRING COMMENT 'The maximum shelf life of the finished product in days from manufacturing date. Critical for reagent kits and consumables with expiration dates. Null for non-perishable items.',
    `source_system` STRING COMMENT 'The operational system from which this BOM record was extracted (e.g., SAP S/4HANA PP, PLM system). Supports data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'The unique identifier of this BOM record in the source system. Enables traceability back to the operational system of record.',
    `standard_cost` DECIMAL(18,2) COMMENT 'The standard manufacturing cost of the finished product as calculated from this BOM and routing. Used for cost accounting, variance analysis, and pricing decisions.',
    `usage` STRING COMMENT 'The purpose or application context for this BOM. Production BOMs drive MRP and shop-floor execution; engineering BOMs support R&D and design; costing BOMs enable standard cost rollup.. Valid values are `production|engineering|costing|maintenance|universal`',
    `valid_from_date` DATE COMMENT 'The date from which this BOM version becomes effective and available for production planning and execution. Supports time-phased BOM management.',
    `valid_to_date` DATE COMMENT 'The date until which this BOM version remains effective. Nullable for open-ended BOMs. Used for planned obsolescence or product transitions.',
    `created_by` STRING COMMENT 'The user ID of the person who created this BOM record in the system. Supports audit trail and accountability.. Valid values are `^[A-Z0-9]{6,12}$`',
    CONSTRAINT pk_manufacturing_bom PRIMARY KEY(`manufacturing_bom_id`)
) COMMENT 'Bill of Materials defining the complete assembly structure for a manufactured product (instrument, reagent kit, array, flow cell, consumable) — including both the header definition and all component line items. Header captures: material number, BOM usage (production, engineering, costing), BOM status (active, inactive), valid-from/valid-to dates, base quantity, unit of measure, plant, BOM alternative number, change number, and ECM reference. Components capture: component material number, item category (stock, non-stock, document, text), required quantity, unit of measure, scrap factor, valid-from/valid-to dates, operation assignment, storage location, batch classification requirement, controlled substance flag, and cold-chain requirement. Serves as the authoritative BOM definition for production execution, MRP explosion, and cost rollup. Integrates with SAP PP BOM (CS01/CS02).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` (
    `bom_component_id` BIGINT COMMENT 'Unique identifier for the BOM component line item. Primary key.',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Manufacturing BOMs specify reagents as raw material components. Real-world material planning, MRP, and regulatory traceability require linking BOM components to specific reagent catalog items with the',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: In genomics biotech, many manufacturing BOM components are internal product SKUs (e.g., primer mixes, enzyme kits used as sub-components). Linking bom_component to product.sku enables where-used analy',
    `manufacturing_bom_id` BIGINT COMMENT 'Reference to the parent BOM header that this component belongs to. Links component to the assembly being manufactured.',
    `material_id` BIGINT COMMENT 'Reference to the material master record representing the component (raw material, reagent, sub-assembly, or consumable).',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: Manufacturing BOMs are plant-specific in ERP systems. BOM components in genomics biotech are validated and approved per plant (e.g., different reagent grades per facility). ERP MRP explosion requires ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: GMP-regulated genomics manufacturing requires approved supplier designation per BOM component (reagents, enzymes, primers). Single-source risk management and supplier qualification audits depend on kn',
    `alternative_bom_indicator` STRING COMMENT 'Identifier for alternative or substitute components that can be used in place of the primary component. Supports supply chain flexibility and shortage management.',
    `backflush_indicator` BOOLEAN COMMENT 'Indicates whether the component is consumed via backflushing (automatic goods issue upon operation confirmation) rather than manual issue. Common for high-volume consumables.',
    `base_quantity` DECIMAL(18,2) COMMENT 'The reference quantity of the parent assembly for which the component quantity is specified. Typically 1, but may vary for batch-based formulations.',
    `batch_managed_flag` BOOLEAN COMMENT 'Indicates whether this component requires batch-level traceability and lot tracking. Critical for GMP compliance and recall management in genomics manufacturing.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether the component requires temperature-controlled storage and handling (e.g., reagents, enzymes). Critical for maintaining reagent stability and assay performance.',
    `component_cost` DECIMAL(18,2) COMMENT 'Standard cost or moving average price of the component. Used for product costing, cost roll-up, and COGS calculation. Business-confidential financial data.',
    `component_description` STRING COMMENT 'Detailed textual description of the component, including technical specifications, grade, purity, or other distinguishing characteristics relevant to manufacturing.',
    `component_number` STRING COMMENT 'The material number (SKU) of the component as defined in the material master. Business identifier for the component.',
    `component_quantity` DECIMAL(18,2) COMMENT 'Required quantity of the component per base quantity of the parent assembly. Used for material requirements planning (MRP) and production order explosion.',
    `component_source` STRING COMMENT 'Origin of the component: internally manufactured, externally procured, customer-supplied, or OEM (Original Equipment Manufacturer) supplied.. Valid values are `internal|external|customer_supplied|oem`',
    `component_status` STRING COMMENT 'Current lifecycle status of the component within the BOM. Controls whether the component is used in production planning and execution.. Valid values are `active|inactive|obsolete|pending_approval|blocked`',
    `controlled_substance_flag` BOOLEAN COMMENT 'Indicates whether the component is a controlled or hazardous substance requiring special handling, storage, and regulatory reporting under GxP and safety regulations.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the component cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created the BOM component record. Part of audit trail for regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the BOM component record was first created in the system. Audit trail for record creation.',
    `critical_part_flag` BOOLEAN COMMENT 'Designates the component as critical for product quality, safety, or regulatory compliance. Triggers enhanced quality control and documentation requirements.',
    `engineering_change_number` STRING COMMENT 'Engineering change order or revision number that introduced or modified this component in the BOM. Supports change control and traceability.',
    `item_category` STRING COMMENT 'Classification of the component type: stock item (inventory-managed), non-stock item (procured per order), variable size item (cut-to-length), document item (reference document), text item (instruction), or class item (configurable characteristic).. Valid values are `stock_item|non_stock_item|variable_size_item|document_item|text_item|class_item`',
    `item_number` STRING COMMENT 'Sequential line item number within the BOM, used for ordering and referencing components in the assembly structure.',
    `lead_time_days` STRING COMMENT 'Procurement or production lead time for the component in days. Used for MRP planning and production scheduling.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum remaining shelf life required at the time of goods issue for production. Prevents use of near-expiry materials that could compromise product quality.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the BOM component record. Part of audit trail for regulatory compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the BOM component record was last modified. Audit trail for change tracking and compliance.',
    `operation_number` STRING COMMENT 'The routing operation number at which this component is consumed or installed. Links BOM component to the production routing step.',
    `procurement_type` STRING COMMENT 'Defines how the component is sourced: manufactured in-house, purchased externally, or both. Drives MRP planning strategy.. Valid values are `in_house_production|external_procurement|both|no_procurement`',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming or in-process quality inspection is mandatory for this component before use in production. Enforces QC checkpoints per GMP requirements.',
    `scrap_percentage` DECIMAL(18,2) COMMENT 'Expected scrap or waste factor for this component during production, expressed as a percentage. Used to increase material requirements in MRP calculations.',
    `serial_number_profile` STRING COMMENT 'Serial number management profile for components requiring unit-level serialization (e.g., instruments, flow cells). Defines serialization rules and format.',
    `shelf_life_days` STRING COMMENT 'Maximum shelf life of the component in days from manufacturing or receipt date. Used for expiry management and FEFO (First Expired First Out) inventory strategies.',
    `storage_location` STRING COMMENT 'Default storage location from which the component should be issued for production. Used for warehouse management and inventory allocation.',
    `supply_area` STRING COMMENT 'Production supply area or staging location where the component is kitted or staged before consumption. Used in lean manufacturing and kanban systems.',
    `unit_of_measure` STRING COMMENT 'Unit in which the component quantity is expressed (e.g., EA for each, L for liters, KG for kilograms, ML for milliliters). Must match material master base unit or alternate unit.',
    `valid_from_date` DATE COMMENT 'Effective start date for this component in the BOM. Supports engineering change management and BOM versioning.',
    `valid_to_date` DATE COMMENT 'Effective end date for this component in the BOM. Null indicates the component is currently valid. Used for phase-out and obsolescence management.',
    CONSTRAINT pk_bom_component PRIMARY KEY(`bom_component_id`)
) COMMENT 'Individual component line item within a Bill of Materials, representing a raw material, sub-assembly, reagent, or consumable required to manufacture the parent assembly. Captures component material number, item category (stock item, non-stock, document, text), required quantity, unit of measure, scrap factor, valid-from/valid-to dates, operation assignment, storage location, batch classification requirement, and GMP-relevant fields such as controlled substance flag and cold-chain requirement. Enables BOM explosion for production planning and material requirements planning (MRP).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` (
    `production_operation_id` BIGINT COMMENT 'Unique identifier for the production operation. Primary key for the production operation entity.',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: GMP genomics manufacturing requires operation-level batch traceability — which reagent/material batch was consumed in each production operation. Critical for deviation investigations, recall managemen',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.deviation. Business justification: Individual production operations generate deviations (e.g., temperature excursion, equipment failure at a specific step). The production_operation has deviation_flag and deviation_number as plain text',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment or instrument used during this operation. Critical for equipment qualification and maintenance traceability.',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.bioinformatics_pipeline_run. Business justification: Sequencing-based QC production operations in genomics kit manufacturing trigger bioinformatics pipeline runs as part of the operation execution. Linking production operations to pipeline runs enables ',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Production operations are executed as part of batch manufacturing. Cardinality: N operations : 1 production_batch (multiple operations per batch per routing). Adding production_batch_id FK links opera',
    `production_routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_routing. Business justification: Each production_operation is a discrete step executed as part of a routing sequence. While production_operation links to work_order (which has production_routing_id), a direct FK to production_routing',
    `work_center_id` BIGINT COMMENT 'Reference to the work center (production resource) where this operation is performed. Represents the machine, equipment, or production line.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order under which this operation is executed. Links this operation to the manufacturing order in SAP PP.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the operation execution was completed on the shop floor.',
    `actual_labor_time_minutes` DECIMAL(18,2) COMMENT 'Actual labor time in minutes recorded during operation execution.',
    `actual_machine_time_minutes` DECIMAL(18,2) COMMENT 'Actual machine processing time in minutes recorded during operation execution.',
    `actual_setup_time_minutes` DECIMAL(18,2) COMMENT 'Actual setup time in minutes recorded during operation execution. Used for variance analysis and continuous improvement.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the operation execution began on the shop floor. Captured via MES or manual confirmation.',
    `confirmation_number` STRING COMMENT 'SAP PP confirmation document number generated when the operation is confirmed. Links to detailed confirmation data including times and quantities.. Valid values are `^[0-9]{10,12}$`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the operation was confirmed in SAP PP or MES system. Represents the official recording of operation completion.',
    `control_key` STRING COMMENT 'SAP control key that determines operation characteristics such as scheduling, costing, confirmation requirements, and external processing flags (e.g., PP01, PP02, PP03).. Valid values are `^[A-Z0-9]{2,4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this operation record was first created in the system. Part of the audit trail for data integrity.',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether a deviation from standard process parameters or procedures occurred during this operation. Triggers investigation and CAPA processes.',
    `electronic_signature_reference` STRING COMMENT 'Unique identifier for the electronic signature applied to this operation record. Required for 21 CFR Part 11 compliance in GMP environments.. Valid values are `^[A-Z0-9]{10,50}$`',
    `electronic_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the electronic signature was applied to this operation record. Part of the audit trail for GMP compliance.',
    `in_process_qc_checkpoint_flag` BOOLEAN COMMENT 'Indicates whether this operation includes a mandatory in-process quality control checkpoint that must be completed before proceeding.',
    `labor_time_standard_minutes` DECIMAL(18,2) COMMENT 'Standard labor time in minutes per unit required for operator activities during this operation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this operation record was last updated. Critical for audit trail and change tracking in GMP environments.',
    `machine_time_standard_minutes` DECIMAL(18,2) COMMENT 'Standard machine processing time in minutes per unit for this operation. Used for capacity planning and costing.',
    `mes_transaction_reference` STRING COMMENT 'Reference identifier to the originating transaction in the Manufacturing Execution System. Enables traceability between MES and ERP systems.. Valid values are `^[A-Z0-9-]{10,50}$`',
    `operation_long_text` STRING COMMENT 'Detailed description of the operation including specific instructions, parameters, and Standard Operating Procedure (SOP) references for shop-floor execution.',
    `operation_number` STRING COMMENT 'Sequential operation number within the work order routing. Defines the order of execution in the manufacturing process (e.g., 0010, 0020, 0030).. Valid values are `^[0-9]{4,10}$`',
    `operation_short_text` STRING COMMENT 'Brief description of the manufacturing operation (e.g., Reagent Dispensing, PCR Amplification, Optical Alignment, Fill-Finish).',
    `operation_status` STRING COMMENT 'Current lifecycle status of the manufacturing operation indicating its execution state on the shop floor. [ENUM-REF-CANDIDATE: not_started|released|in_progress|confirmed|partially_confirmed|completed|skipped|cancelled — 8 candidates stripped; promote to reference product]',
    `planned_end_timestamp` TIMESTAMP COMMENT 'Scheduled completion date and time for this operation based on standard values and capacity planning.',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Scheduled start date and time for this operation based on work order scheduling and capacity planning.',
    `process_validation_run_flag` BOOLEAN COMMENT 'Indicates whether this operation is part of a formal process validation study (IQ/OQ/PQ). Requires enhanced documentation and data collection.',
    `qc_inspection_lot_number` STRING COMMENT 'SAP QM inspection lot number created for in-process quality inspection at this operation. Links to detailed inspection results.. Valid values are `^[0-9]{10,12}$`',
    `qc_result_status` STRING COMMENT 'Status of the in-process quality control inspection for this operation. Determines whether production can proceed to the next step.. Valid values are `not_required|pending|in_progress|passed|failed|conditional_release`',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Quantity of units requiring rework or reprocessing due to non-conformance identified during this operation.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of units rejected or scrapped during this operation due to quality defects or process failures.',
    `setup_time_standard_minutes` DECIMAL(18,2) COMMENT 'Standard setup time in minutes required to prepare the work center and equipment before production can begin for this operation.',
    `sop_document_number` STRING COMMENT 'Reference to the Standard Operating Procedure document that governs the execution of this operation. Critical for GMP compliance and training verification.. Valid values are `^SOP-[A-Z0-9-]{6,20}$`',
    `sop_version` STRING COMMENT 'Version number of the SOP document used during operation execution. Ensures operators followed the correct approved procedure version.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `target_quantity` DECIMAL(18,2) COMMENT 'Planned quantity to be produced in this operation. Represents the expected output based on work order requirements.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities in this operation (e.g., EA for each, KG for kilograms, L for liters). ISO standard unit codes.. Valid values are `^[A-Z]{2,3}$`',
    `yield_quantity` DECIMAL(18,2) COMMENT 'Actual good quantity produced and confirmed for this operation. Represents units that passed in-process quality checks.',
    CONSTRAINT pk_production_operation PRIMARY KEY(`production_operation_id`)
) COMMENT 'Individual manufacturing operation executed on the shop floor as part of a work order, representing a discrete production step (e.g., reagent dispensing, mixing, fill-finish, optical alignment, PCR amplification). Captures operation number, short text, work center, control key, standard values (setup/machine/labor time), actual times, operation status (not started, in progress, confirmed, skipped), yield and scrap quantities, operator ID, equipment used, in-process QC checkpoint flag, electronic signature (21 CFR Part 11), and MES transaction reference. Supports GMP batch record completeness and shop-floor traceability.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` (
    `inprocess_qc_result_id` BIGINT COMMENT 'Unique identifier for the in-process quality control inspection result record. Primary key.',
    `aliquot_id` BIGINT COMMENT 'Foreign key linking to sample.aliquot. Business justification: In-process QC in genomics manufacturing is performed on specific aliquots (e.g., library QC on a specific aliquot volume). Direct aliquot-level QC traceability is required for GMP batch records and en',
    `equipment_id` BIGINT COMMENT 'Identifier of the measurement equipment or instrument used to perform the inspection. Required for equipment qualification traceability.',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: In-process QC failures generate nonconformance reports for immediate quality response and disposition. Critical linkage for real-time quality control in genomics biotech manufacturing operations.',
    `oos_investigation_id` BIGINT COMMENT 'Foreign key linking to quality.oos_investigation. Business justification: Out-of-specification in-process results trigger formal OOS investigations per FDA/ICH guidelines. Regulatory requirement for genomics-biotechnology manufacturing to investigate and document all OOS ev',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.bioinformatics_pipeline_run. Business justification: In genomics manufacturing, in-process QC steps (e.g., sequencing-based library QC, array hybridization QC) generate bioinformatics pipeline runs. The inprocess_qc_result must reference the pipeline ru',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: In-process QC results are recorded for a specific production batch. Cardinality: N QC results : 1 production_batch (multiple checkpoints per batch). Adding production_batch_id FK enables traceability ',
    `production_operation_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_operation. Business justification: In-process QC checkpoints occur at specific manufacturing operations. Cardinality: N QC results : 1 production_operation (multiple measurements per operation). Adding production_operation_id FK links ',
    `qc_result_id` BIGINT COMMENT 'Reference to the follow-up retest inspection result record if a retest was performed.',
    `qc_specification_id` BIGINT COMMENT 'Foreign key linking to reagent.qc_specification. Business justification: In-process QC results must link to the specification defining acceptance criteria for automated pass/fail determination, trend analysis, and regulatory compliance. Real-world manufacturing execution s',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: In-process QC tests in genomics-biotech manufacturing consume specific reagent lots (PCR master mixes, sequencing reagents, buffers). GMP traceability mandates recording which reagent lot was used for',
    `sample_specimen_id` BIGINT COMMENT 'Foreign key linking to sample.sample_specimen. Business justification: In-process QC results in GMP genomics manufacturing must be traceable to the specific specimen being processed. QA uses this link to pull all in-process QC results for a specimen during deviation inve',
    `site_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_site. Business justification: inprocess_qc_result currently stores manufacturing_site_code as a denormalized STRING. Replacing this with a proper FK to manufacturing_site normalizes the data model, enables referential integrity, a',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: In-process QC results must be traceable to the specific product SKU for OOS investigations, quality trending, and regulatory reporting. The existing product_sku plain-text column is a denormalizatio',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: inprocess_qc_result stores production_line_code as a denormalized STRING reference to the production line/work center where the QC inspection was performed. Replacing this with a FK to work_center nor',
    `work_order_id` BIGINT COMMENT 'Reference to the manufacturing work order under which this in-process QC inspection was performed.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection result was reviewed and approved by quality assurance.',
    `calibration_due_date` DATE COMMENT 'Next scheduled calibration due date for the inspection equipment used. Ensures measurement validity and GMP compliance.',
    `control_chart_rule_violation` STRING COMMENT 'Identifier of any Statistical Process Control (SPC) rule violation detected (e.g., Western Electric rules, trend, shift, out-of-control point).',
    `data_source_system` STRING COMMENT 'Identifier of the source system from which this inspection result was captured (SAP QM, Manufacturing Execution System, Laboratory Information Management System, or manual entry).. Valid values are `SAP_QM|MES|LIMS|manual_entry`',
    `defect_count` STRING COMMENT 'Number of defective units identified in the sample for attribute-based inspections (e.g., visual defects, functional failures).',
    `deviation_flag` BOOLEAN COMMENT 'Boolean indicator whether this inspection result represents an out-of-specification (OOS) condition requiring deviation investigation.',
    `deviation_number` STRING COMMENT 'Reference number of the formal deviation investigation record if this result triggered an out-of-specification (OOS) investigation.',
    `disposition_code` STRING COMMENT 'Quality disposition decision for the inspected material: accept for next step, reject, conditional release with restrictions, rework, scrap, or hold pending investigation.. Valid values are `accept|reject|conditional_release|rework|scrap|hold`',
    `disposition_reason` STRING COMMENT 'Textual explanation or justification for the disposition decision, especially for conditional releases or rejections.',
    `environmental_condition_humidity` DECIMAL(18,2) COMMENT 'Relative humidity percentage at the time of inspection. Required for humidity-sensitive measurements and GMP environmental monitoring.',
    `environmental_condition_temperature` DECIMAL(18,2) COMMENT 'Ambient temperature in degrees Celsius at the time of inspection. Required for temperature-sensitive measurements and GMP environmental monitoring.',
    `inspection_characteristic_code` STRING COMMENT 'Code identifying the specific quality characteristic being measured (e.g., pH, concentration, optical density, dimensional tolerance, purity percentage).',
    `inspection_characteristic_description` STRING COMMENT 'Human-readable description of the quality characteristic being inspected.',
    `inspection_lot_number` STRING COMMENT 'SAP QM inspection lot number assigned to this quality control checkpoint. Used for traceability and integration with SAP QM module.',
    `inspection_method_code` STRING COMMENT 'Code identifying the Standard Operating Procedure (SOP) or analytical method used to perform the inspection (e.g., HPLC, spectrophotometry, visual inspection, dimensional measurement).',
    `inspection_notes` STRING COMMENT 'Free-text notes or observations recorded by the inspector during the quality control inspection.',
    `inspection_plan_code` STRING COMMENT 'Reference to the master inspection plan that defines the QC checkpoints, characteristics, and acceptance criteria for this product.',
    `inspection_result_status` STRING COMMENT 'Pass/fail determination for this inspection characteristic based on comparison of measured value against specification limits.. Valid values are `pass|fail|conditional_release|pending|retest`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the in-process quality control inspection was performed. Critical for batch record chronology and Turnaround Time (TAT) tracking.',
    `measured_value` DECIMAL(18,2) COMMENT 'Actual quantitative value measured during the in-process quality control inspection.',
    `production_step_sequence` STRING COMMENT 'Sequential number of the manufacturing step at which this QC checkpoint occurred within the overall production routing.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this in-process QC result record was first created in the system.',
    `record_last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this in-process QC result record was last updated or modified.',
    `retest_required_flag` BOOLEAN COMMENT 'Boolean indicator whether this result requires a confirmatory retest before final disposition.',
    `sample_size` STRING COMMENT 'Number of units or samples tested in this inspection. Used for statistical process control and sampling plan compliance.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the measured value (e.g., mg/mL, pH units, mm, percent, OD units, nM).',
    CONSTRAINT pk_inprocess_qc_result PRIMARY KEY(`inprocess_qc_result_id`)
) COMMENT 'In-process quality control inspection result recorded at a defined checkpoint during manufacturing execution. Captures inspection lot number (SAP QM), inspection characteristic, measured value, unit of measure, specification lower/upper limits, pass/fail result, inspection method, operator ID, inspection date/time, equipment used for measurement, deviation flag, and disposition (accept, reject, conditional release). Supports GMP compliance, real-time yield monitoring, and out-of-specification (OOS) investigation triggers. Integrates with SAP QM inspection lots and MES QC checkpoints.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` (
    `batch_record_id` BIGINT COMMENT 'Unique identifier for the electronic batch record. Primary key for the batch record entity. Serves as the GMP-compliant reference for all manufacturing documentation associated with a specific production batch.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Electronic batch records for customer-specific manufacturing runs must link to the customer account for regulatory traceability, audit trail, complaint investigation, and FDA/ISO compliance in genomic',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Electronic batch records must document that manufacturing was performed under the approved process described in the regulatory filing. Required for GMP compliance and regulatory inspections of genomic',
    `assay_version_id` BIGINT COMMENT 'Foreign key linking to clinical.assay_version. Business justification: GMP batch records for reagent kit manufacturing must document which assay version specification was followed during production. This is a core GMP requirement — the electronic batch record must refere',
    `batch_id` BIGINT COMMENT 'Reference to the production batch for which this electronic batch record was created. Links the batch record to the physical manufacturing batch entity.',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Batch records trigger CAPAs for recurring issues or systemic problems identified during batch review. Quality system integration required for continuous improvement in biotech manufacturing.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Batch records are regulatory documents referencing commercial products for FDA/EMA submissions, COA generation, and product release. QA teams need direct traceability from batch record to marketed cat',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Batch records must reference the change control that authorized any process or document revision reflected in that batch record version. This is a standard GMP electronic batch record requirement for ',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Electronic batch records document deviations as they occur during manufacturing execution. GMP documentation requirement for linking batch record entries to formal deviation investigations in genomics',
    `installed_instrument_id` BIGINT COMMENT 'Foreign key linking to customer.installed_instrument. Business justification: GMP batch records for custom reagent lots manufactured for a specific customer instrument require instrument-level traceability for IVD regulatory audits and validated reagent lot assignment. A genomi',
    `labeling_id` BIGINT COMMENT 'Foreign key linking to regulatory.labeling. Business justification: GMP batch records must document the labeling version in effect at time of manufacture. This is a regulatory requirement for IVD/genomics products — the batch record must reference the approved labelin',
    `master_batch_record_id` BIGINT COMMENT 'Reference to the approved master batch record template that this executed batch record is based on. Ensures manufacturing followed validated procedures.',
    `pipeline_version_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_version. Business justification: GMP electronic batch records for genomics kit/assay products must document the bioinformatics pipeline version used for in-process or release testing of that batch. Required for GMP audit trails, batc',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: GMP batch records must reference the ERP plant for goods receipt posting and regulatory inspection traceability. In genomics biotech, batch records submitted to FDA/EMA must identify the manufacturing',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Batch record is the GMP electronic batch record (EBR) documenting a production batch. Cardinality: 1 batch_record : 1 production_batch (1:1 relationship). Adding production_batch_id FK links documenta',
    `sequencing_run_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_run. Business justification: GMP release testing: sequencing reagent kit batch records must reference the sequencing run used for release QC testing. This is a direct ISO 13485 / 21 CFR Part 820 requirement — the electronic batch',
    `site_id` BIGINT COMMENT 'Reference to the GMP-registered manufacturing facility where this batch was produced. Critical for regulatory compliance, site-specific SOPs, and supply chain traceability.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Electronic batch records (EBRs) in GMP genomics manufacturing are issued at the SKU level — the SKU determines labeling, pack size, and regulatory classification on the CoA. The existing catalog_item_',
    `study_id` BIGINT COMMENT 'Foreign key linking to research.study. Business justification: GMP batch records for study-specific genomics products (IVD kits, CRISPR reagents for gene therapy studies) must be traceable to the originating study for regulatory submissions and GCP audit trails. ',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Batch records for regulated genomics/IVD products must reference the regulatory submission that authorized the manufacturing process. This is a standard GMP traceability requirement for regulatory ins',
    `document_id` BIGINT COMMENT 'Unique document identifier in Veeva Vault QMS where the finalized, approved batch record PDF is archived for regulatory retention. Supports 21 CFR Part 11 compliant long-term storage.',
    `work_order_id` BIGINT COMMENT 'Reference to the manufacturing work order that authorized and governs this batch production. Links to SAP PP work order for material planning and capacity scheduling.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the batch record received final QA approval and the batch was released for distribution. Null if not yet approved. Critical for regulatory lot release documentation.',
    `batch_record_number` STRING COMMENT 'Human-readable unique business identifier for the electronic batch record. Externally referenced in regulatory submissions, audits, and quality investigations. Format follows site-specific EBR numbering convention.. Valid values are `^EBR-[A-Z0-9]{8,20}$`',
    `batch_record_status` STRING COMMENT 'Current lifecycle state of the electronic batch record in the GMP workflow. Governs whether the batch can be released for distribution. Transitions follow 21 CFR Part 11 audit trail requirements. [ENUM-REF-CANDIDATE: draft|in_process|in_review|approved|rejected|superseded|archived — 7 candidates stripped; promote to reference product]',
    `batch_size_uom` STRING COMMENT 'Unit of measure for the batch size quantity. Standardized to SAP MM UOM codes for consistency across manufacturing and supply chain systems. [ENUM-REF-CANDIDATE: EA|KIT|L|ML|KG|G|M|DOSE — 8 candidates stripped; promote to reference product]',
    `bom_version` STRING COMMENT 'Version identifier of the Bill of Materials used for this batch. Ensures traceability to the approved component list and material specifications. Links to SAP PP BOM master.. Valid values are `^[A-Z0-9]{1,10}$`',
    `coa_document_reference` STRING COMMENT 'External reference or URI to the Certificate of Analysis document for this batch. Links to Veeva Vault or QMS document repository. Null if COA not yet issued.',
    `coa_issued_flag` BOOLEAN COMMENT 'Boolean indicator of whether a Certificate of Analysis has been issued for this batch. True indicates COA is available; false indicates pending or not yet generated.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when all manufacturing steps and in-process QC checkpoints were completed and the batch record was closed for review. Null if batch is still in process.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this batch record entity was first created in the data warehouse. Part of audit trail for data lineage. ISO 8601 format with timezone.',
    `deviation_count` STRING COMMENT 'Total number of manufacturing deviations or exceptions recorded during batch production. Each deviation requires investigation and disposition per GMP. Zero indicates no deviations.',
    `environmental_class` STRING COMMENT 'ISO 14644 cleanroom classification where the batch was manufactured. Critical for sterile and aseptic product compliance. Null or unclassified for non-cleanroom manufacturing.. Valid values are `ISO_5|ISO_6|ISO_7|ISO_8|unclassified`',
    `equipment_train` STRING COMMENT 'Comma-separated list or identifier of the qualified equipment units used in this batch production (e.g., Reactor-101, Filler-203). Critical for equipment qualification traceability and investigation.',
    `exception_count` STRING COMMENT 'Total number of in-process QC exceptions or out-of-specification results recorded during batch production. Each exception requires investigation and quality disposition.',
    `expiry_date` DATE COMMENT 'Calculated expiration or use-by date for the batch based on stability data and shelf-life specifications. Printed on product labeling and COA. Format: yyyy-MM-dd.',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the batch record was first created or initiated in the MES. Marks the start of the GMP-documented manufacturing event. ISO 8601 format with timezone.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this batch record entity was last updated in the data warehouse. Supports change tracking and audit trail requirements. ISO 8601 format with timezone.',
    `mes_document_reference` STRING COMMENT 'External reference or URI to the batch record document stored in the MES platform. Enables traceability to the source system of record for shop-floor execution data.',
    `process_order_number` STRING COMMENT 'SAP PP process order number that governs the manufacturing execution for this batch. Links batch record to ERP planning and material consumption transactions.. Valid values are `^[A-Z0-9]{8,15}$`',
    `quarantine_flag` BOOLEAN COMMENT 'Boolean indicator of whether the batch is currently under quarantine pending investigation or disposition. True indicates batch is on hold; false indicates released or rejected.',
    `rejected_timestamp` TIMESTAMP COMMENT 'Date and time when the batch record was rejected. Null if batch was not rejected. Triggers investigation and CAPA workflow per GMP requirements.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the batch record was rejected. Documents the quality or compliance issue that prevented batch release. Null if batch was not rejected.',
    `release_date` DATE COMMENT 'Date when the batch was officially released by QA for distribution and sale. Marks the completion of all GMP release activities including batch record review, QC testing, and disposition. Format: yyyy-MM-dd.',
    `retest_date` DATE COMMENT 'Date by which the batch must be retested to confirm continued conformance to specifications. Applicable for raw materials and intermediates with defined retest intervals. Null if not applicable.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the QA review of the batch record was completed. Null if review has not yet occurred. Part of the GMP release workflow.',
    `sterilization_method` STRING COMMENT 'Method used to sterilize the product or components during manufacturing, if applicable. Critical for sterile product compliance and validation. Null or not_applicable for non-sterile products.. Valid values are `autoclave|gamma_irradiation|ethylene_oxide|filtration|none|not_applicable`',
    `version` STRING COMMENT 'Version identifier for the batch record template or master batch record used. Ensures manufacturing followed the approved, validated procedure. Format: v1.0, v2.3, etc.. Valid values are `^v[0-9]+.[0-9]+$`',
    CONSTRAINT pk_batch_record PRIMARY KEY(`batch_record_id`)
) COMMENT 'Electronic Batch Record (EBR) — the GMP-mandated comprehensive record of all activities, materials, equipment, and results associated with the manufacture of a specific production batch. Captures batch record number, associated batch and work order, product name and code, manufacturing site, batch record status (draft, in-review, approved, rejected), review/approval workflow steps, reviewer and approver identities with electronic signatures (21 CFR Part 11 / Annex 11 compliant), review date, approval date, deviation count, exception count, and MES/Veeva Vault document reference. Serves as the primary GMP compliance artifact for batch release.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` (
    `equipment_qualification_id` BIGINT COMMENT 'Unique identifier for the equipment qualification record. Primary key.',
    `assay_development_id` BIGINT COMMENT 'Foreign key linking to research.assay_development. Business justification: Equipment qualification for genomics instruments (NGS sequencers, digital PCR platforms, gene synthesis systems) is performed to meet performance requirements established during assay development. IVD',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Equipment qualification failures or deviations require CAPAs to address root causes. Validation lifecycle management requirement for maintaining qualified state of manufacturing equipment in biotech.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Equipment qualifications specify which products the equipment is qualified to manufacture. Process validation and regulatory submissions require explicit equipment-to-product qualification matrices fo',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Qualification deviations (test failures, protocol deviations) must be documented as quality deviations. GMP compliance requirement for equipment validation in genomics-biotechnology manufacturing.',
    `equipment_id` BIGINT COMMENT 'Identifier of the manufacturing equipment being qualified. Links to the equipment master record.',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.model. Business justification: IQ/OQ/PQ qualification protocols in genomics are model-specific — a qualification for one instrument model does not cover another. QA engineers must link equipment qualifications to instrument models ',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Equipment qualification protocols in genomics-biotech use specific reagent lots (calibration standards, cleaning validation reagents, performance verification reagents). GMP traceability requires reco',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to quality.risk_assessment. Business justification: Equipment qualification scope and frequency in GMP genomics are determined by risk assessment per GAMP5 and ICH Q9. The equipment_qualification has risk_assessment_reference as a plain text field. A p',
    `site_id` BIGINT COMMENT 'Unique identifier of the manufacturing site, linking to the facility or location master record.',
    `validation_study_id` BIGINT COMMENT 'Foreign key linking to quality.validation_study. Business justification: Equipment qualification (IQ/OQ/PQ) in GMP genomics facilities is formally documented as a validation study per GAMP5 and FDA equipment qualification guidance. Linking equipment_qualification to valida',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: Equipment qualifications in GMP manufacturing are conducted in the context of specific work centers (clean rooms, fill-finish lines, assembly stations). Linking equipment_qualification to work_center ',
    `approval_date` DATE COMMENT 'Date when the qualification report was formally approved by Quality Assurance, authorizing equipment for GMP production use.',
    `calibration_status` STRING COMMENT 'Current calibration status of the equipment at the time of qualification (current, expired, not_required).. Valid values are `current|expired|not_required`',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether a CAPA was required to address qualification findings (True/False).',
    `comments` STRING COMMENT 'Additional notes, observations, or context related to the qualification activity, including any special conditions or considerations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system.',
    `deviation_count` STRING COMMENT 'Number of deviations or non-conformances identified during the qualification activity.',
    `equipment_type` STRING COMMENT 'Category of manufacturing equipment (e.g., sequencer, thermal cycler, liquid handler, centrifuge, incubator, biosafety cabinet, clean room, assembly station, inspection system, packaging equipment). [ENUM-REF-CANDIDATE: sequencer|thermal_cycler|liquid_handler|centrifuge|incubator|biosafety_cabinet|clean_room|assembly_station|inspection_system|packaging_equipment|other — 11 candidates stripped; promote to reference product]',
    `installation_date` DATE COMMENT 'Date when the equipment was physically installed at the manufacturing site, typically the starting point for IQ activities.',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration performed on the equipment prior to or during qualification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last updated in the system.',
    `next_requalification_due_date` DATE COMMENT 'Scheduled date for the next periodic requalification of the equipment to maintain GMP compliance.',
    `qualification_completion_date` DATE COMMENT 'Date when all qualification testing and documentation were completed, regardless of pass/fail outcome.',
    `qualification_cycle_number` STRING COMMENT 'Sequential number indicating which qualification cycle this record represents (1 for initial qualification, 2+ for requalifications).',
    `qualification_date` DATE COMMENT 'Date when the qualification was successfully completed and the equipment was approved for GMP use.',
    `qualification_protocol_reference` STRING COMMENT 'Document number or identifier of the qualification protocol that defines the test procedures and acceptance criteria (e.g., IQ-2024-001).',
    `qualification_report_reference` STRING COMMENT 'Document number or Veeva Vault identifier of the qualification report containing test results and approval signatures.',
    `qualification_start_date` DATE COMMENT 'Date when the qualification activity was initiated.',
    `qualification_status` STRING COMMENT 'Current status of the qualification activity (pending, in-progress, qualified, expired, failed, suspended).. Valid values are `pending|in_progress|qualified|expired|failed|suspended`',
    `qualification_type` STRING COMMENT 'Type of qualification activity: IQ (Installation Qualification), OQ (Operational Qualification), or PQ (Performance Qualification).. Valid values are `IQ|OQ|PQ`',
    `qualification_validity_period_days` STRING COMMENT 'Number of days the qualification remains valid before requalification is required, as defined by the equipment qualification plan.',
    `regulatory_standard_applied` STRING COMMENT 'Regulatory standard or guideline applied during qualification (e.g., ISO 13485, GMP Annex 15, FDA 21 CFR Part 820).',
    `test_results_summary` STRING COMMENT 'High-level summary of qualification test outcomes, including pass/fail status and any deviations observed.',
    CONSTRAINT pk_equipment_qualification PRIMARY KEY(`equipment_qualification_id`)
) COMMENT 'Records the qualification and validation status of manufacturing equipment used in GMP production — covering Installation Qualification (IQ), Operational Qualification (OQ), and Performance Qualification (PQ) activities. Captures equipment ID, equipment name, equipment type, qualification type (IQ/OQ/PQ), qualification status (pending, in-progress, qualified, expired, failed), qualification date, next requalification due date, qualification protocol reference, qualification report reference (Veeva Vault), responsible engineer, and regulatory standard applied (ISO 13485, GMP Annex 15). Ensures only qualified equipment is used in GMP manufacturing.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` (
    `process_validation_id` BIGINT COMMENT 'Unique identifier for the process validation study record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Process validations performed for customer-specific applications (e.g., validating sequencing workflow for pharma customers clinical trial, or custom assay validation for research institution) requir',
    `analytical_validation_id` BIGINT COMMENT 'Foreign key linking to clinical.analytical_validation. Business justification: FDA IVD and CLIA regulatory submissions require both process validation (manufacturing consistency) and analytical validation (clinical performance) to be linked. Process validation studies reference ',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Process validations demonstrate that the approved manufacturing process for genomics products performs as intended. Ongoing validation studies verify continued state of control under the regulatory ap',
    `assay_development_id` BIGINT COMMENT 'Foreign key linking to research.assay_development. Business justification: Process validation is required before commercial manufacturing of assays developed in R&D. FDA/regulatory submissions require traceability from assay development through validation. Critical for IVD a',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Process validation failures trigger corrective actions to achieve validated state. Validation lifecycle requirement for genomics biotech manufacturing processes per FDA Process Validation Guidance.',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Process validation deviations (acceptance criteria failures, protocol deviations) tracked for regulatory compliance. Required linkage for validation documentation in genomics-biotechnology manufacturi',
    `device_identifier_id` BIGINT COMMENT 'Foreign key linking to regulatory.device_identifier. Business justification: Process validations in IVD/genomics biotech are conducted for specific device configurations identified by their UDI-DI. The device identifier scopes the validation — a validation is only valid for th',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.asset. Business justification: GMP process validation protocols must identify the specific instrument asset (by serial number) used during validation runs per FDA 21 CFR 211 and ICH Q7. Validation engineers and regulatory affairs t',
    `pipeline_version_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_version. Business justification: Manufacturing process validation for genomics kits includes bioinformatics pipeline validation as a component. The process validation record must reference the pipeline version used during validation ',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: Process validations in genomics biotech are plant-specific — a validation at one facility does not transfer to another. Regulatory submissions (FDA, EMA) require the validated plant to be identified. ',
    `controlled_document_id` BIGINT COMMENT 'Document identifier in Veeva Vault or document management system for the final validation report.',
    `production_routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_routing. Business justification: Process validation studies validate a specific manufacturing routing (sequence of operations). Cardinality: N validation studies : 1 production_routing (multiple validation runs per routing). Adding p',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to quality.risk_assessment. Business justification: Process validation scope and critical process parameters are determined by risk assessment per ICH Q9 and FDA Process Validation Guidance. The process_validation has risk_assessment_reference as a pla',
    `sample_specimen_id` BIGINT COMMENT 'Foreign key linking to sample.sample_specimen. Business justification: Process validation studies in genomics biotech use specific reference or control specimens (e.g., reference DNA, characterized cell lines). Linking process_validation to sample_specimen provides regul',
    `sequencing_protocol_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_protocol. Business justification: Process validation scope for sequencing reagent kits must specify which sequencing protocol was used during validation runs. Regulatory submissions (FDA 510(k), CE-IVD) require documentation of the ex',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site or plant where the validated process is executed.',
    `sku_id` BIGINT COMMENT 'Reference to the product being validated (instrument, reagent kit, array, flow cell, or consumable).',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Process validation studies are performed to generate data for regulatory submissions (510k, PMA, CE technical file). The validation report is a required module in genomics device submissions demonstra',
    `validation_study_id` BIGINT COMMENT 'Foreign key linking to quality.validation_study. Business justification: Manufacturing process validation is formally documented as a validation study in the quality system per FDA Process Validation Guidance (2011) and ICH Q7. Linking process_validation to validation_stud',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: Process validation studies are conducted at specific work centers (e.g., a specific fill-finish line, a specific clean room). While process_validation links to manufacturing_site and production_routin',
    `acceptance_criteria` STRING COMMENT 'Detailed acceptance criteria defined in the validation protocol that the process must meet to be considered validated (e.g., yield thresholds, quality specifications, process capability indices).',
    `batch_size_unit` STRING COMMENT 'Unit of measure for the validated batch size: units, liters, kilograms, flow cells, arrays, or kits.. Valid values are `units|liters|kilograms|flow_cells|arrays|kits`',
    `batch_size_validated` DECIMAL(18,2) COMMENT 'Production batch size (in units or volume) for which the process was validated. Process changes outside this range may require revalidation.',
    `capa_reference_number` STRING COMMENT 'Reference number of the CAPA record initiated as a result of validation findings, if applicable.',
    `capa_required` BOOLEAN COMMENT 'Indicates whether Corrective and Preventive Action (CAPA) was required based on validation findings.',
    `change_control_reference` STRING COMMENT 'Reference number of the change control record that triggered this validation or revalidation activity.',
    `comments` STRING COMMENT 'Additional comments, notes, or observations related to the validation study, including lessons learned or recommendations for future validations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process validation record was first created in the system.',
    `critical_process_parameters` STRING COMMENT 'List of critical process parameters (CPPs) monitored and controlled during validation (e.g., temperature, pressure, time, reagent concentration). Comma-separated list.',
    `critical_quality_attributes` STRING COMMENT 'List of critical quality attributes (CQAs) measured during validation to ensure product quality (e.g., purity, potency, yield, accuracy). Comma-separated list.',
    `deviation_count` STRING COMMENT 'Number of deviations or non-conformances recorded during the validation study execution.',
    `equipment_qualification_status` STRING COMMENT 'Status of equipment qualification for the manufacturing equipment used in this process: IQ/OQ/PQ complete (Installation/Operational/Performance Qualification), IQ/OQ complete, not qualified, or requalification required.. Valid values are `IQ_OQ_PQ_complete|IQ_OQ_complete|not_qualified|requalification_required`',
    `gmp_classification` STRING COMMENT 'GMP classification of the product being validated: IVD (In Vitro Diagnostic), RUO (Research Use Only), LDT (Laboratory Developed Test), medical device, or pharmaceutical.. Valid values are `IVD|RUO|LDT|medical_device|pharmaceutical`',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this process validation record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this process validation record was last modified.',
    `process_capability_index` DECIMAL(18,2) COMMENT 'Statistical process capability index (Cpk) calculated from validation data, indicating how well the process meets specifications. Values ≥1.33 typically indicate capable process.',
    `quality_approver` STRING COMMENT 'Name of the Quality Assurance (QA) manager or authorized person who approved the validation report.',
    `regulatory_authority` STRING COMMENT 'Primary regulatory authority for which this validation was conducted: FDA (United States), EMA (European Union), MHRA (United Kingdom), TGA (Australia), PMDA (Japan), NMPA (China).. Valid values are `FDA|EMA|MHRA|TGA|PMDA|NMPA`',
    `statistical_method` STRING COMMENT 'Statistical methods and tools used for validation data analysis (e.g., ANOVA, control charts, process capability analysis, hypothesis testing).',
    `validation_completion_date` DATE COMMENT 'Date when all validation runs were completed and the validation report was approved.',
    `validation_expiry_date` DATE COMMENT 'Date when the process validation expires and revalidation is required. Typically set based on regulatory requirements, process changes, or periodic review schedules.',
    `validation_outcome` STRING COMMENT 'Overall outcome of the validation study: passed (all acceptance criteria met), failed (criteria not met), conditional pass (minor deviations with justification), in progress, or not started.. Valid values are `passed|failed|conditional_pass|in_progress|not_started`',
    `validation_protocol_number` STRING COMMENT 'Unique business identifier for the validation protocol document. Externally-known reference number used across regulatory submissions and quality systems.. Valid values are `^PV-[A-Z0-9]{6,12}$`',
    `validation_runs_completed` STRING COMMENT 'Number of validation runs successfully completed to date.',
    `validation_runs_planned` STRING COMMENT 'Number of validation runs planned in the protocol (typically 3 consecutive successful runs for prospective validation per FDA guidance).',
    `validation_scope` STRING COMMENT 'Detailed description of the validation scope, including process steps, equipment, materials, and environmental conditions covered by the validation study.',
    `validation_stage` STRING COMMENT 'Current lifecycle status of the validation study: protocol approved, execution in progress, report approved, validated (active), revalidation required, or expired.. Valid values are `protocol_approved|execution_in_progress|report_approved|validated|revalidation_required|expired`',
    `validation_start_date` DATE COMMENT 'Date when the validation study execution began (first validation run initiated).',
    `validation_team_lead` STRING COMMENT 'Name of the validation team lead or principal investigator responsible for the validation study.',
    `validation_type` STRING COMMENT 'Classification of the validation approach: prospective (before routine production), concurrent (during initial production), retrospective (using historical data), or revalidation (periodic re-qualification).. Valid values are `prospective|concurrent|retrospective|revalidation`',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this process validation record.',
    CONSTRAINT pk_process_validation PRIMARY KEY(`process_validation_id`)
) COMMENT 'Master record for process validation studies conducted to demonstrate that a manufacturing process consistently produces a product meeting its predetermined specifications and quality attributes. Captures validation protocol number, product/process being validated, validation type (prospective, concurrent, retrospective, revalidation), validation stage (protocol approved, execution in progress, report approved, validated, revalidation required), number of validation runs, acceptance criteria, validation outcome, regulatory submission reference (FDA, EMA), validation report reference (Veeva Vault), and process validation expiry date. Critical for IVD/GMP regulatory compliance.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` (
    `work_center_id` BIGINT COMMENT 'Unique identifier for the manufacturing work center. Primary key.',
    `controlled_document_id` BIGINT COMMENT 'Reference to the master SOP document governing operations, maintenance, and quality procedures for this work center.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: Work centers are assigned to ERP plants for capacity planning and MRP scheduling. In genomics biotech, work center availability and qualification status must be tracked per plant for production schedu',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing plant where this work center is physically located.',
    `activity_type` STRING COMMENT 'SAP CO activity type used for internal cost allocation and activity-based costing for operations performed at this work center.',
    `allows_overlapping_operations` BOOLEAN COMMENT 'Flag indicating whether this work center supports overlapping operations where subsequent operations can begin before the previous operation is fully complete.',
    `available_capacity_hours_per_day` DECIMAL(18,2) COMMENT 'Total available production hours per day calculated from shifts and hours per shift, accounting for planned downtime.',
    `capacity_category` STRING COMMENT 'SAP PP capacity category code used for grouping work centers with similar capacity characteristics for planning purposes.',
    `capacity_hours_per_shift` DECIMAL(18,2) COMMENT 'Standard operating hours per shift for this work center, used for capacity planning and scheduling calculations.',
    `capacity_shifts_per_day` DECIMAL(18,2) COMMENT 'Number of production shifts this work center operates per day (e.g., 1.0 for single shift, 2.0 for two shifts, 3.0 for continuous operation).',
    `control_key` STRING COMMENT 'SAP PP control key defining how operations at this work center are scheduled, confirmed, and costed (e.g., internal processing, external processing, inspection).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center record was first created in the system.',
    `efficiency_factor_percent` DECIMAL(18,2) COMMENT 'Standard efficiency factor as a percentage representing the work centers expected performance relative to theoretical maximum (e.g., 85.00 means 85% efficiency).',
    `environmental_monitoring_zone` STRING COMMENT 'Designated environmental monitoring zone identifier for tracking particulate, microbial, and environmental parameters per GMP requirements.',
    `equipment_list` STRING COMMENT 'Comma-separated list or summary of major equipment assets assigned to this work center (e.g., sequencers, liquid handlers, autoclaves, fill-finish machines).',
    `formula_key` STRING COMMENT 'SAP PP formula key used for calculating operation times, setup times, and processing times based on lot size and work center parameters.',
    `gmp_classification` STRING COMMENT 'GMP environmental classification for the work center indicating cleanroom grade per ISO 14644 (Class 5/7/8) or EU GMP Annex 1 (Grade A/B/C/D), or non-GMP for non-controlled areas. Critical for IVD and RUO product manufacturing. [ENUM-REF-CANDIDATE: iso_class_5|iso_class_7|iso_class_8|eu_gmp_grade_a|eu_gmp_grade_b|eu_gmp_grade_c|eu_gmp_grade_d|non_gmp — 8 candidates stripped; promote to reference product]',
    `is_bottleneck` BOOLEAN COMMENT 'Flag indicating whether this work center is identified as a production bottleneck requiring special capacity management and scheduling attention.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this work center record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center record was last updated or modified.',
    `last_qualification_date` DATE COMMENT 'Date when the work center last completed qualification (IQ/OQ/PQ) or requalification activities.',
    `location_building` STRING COMMENT 'Building identifier or name where the work center is physically located within the plant.',
    `location_floor` STRING COMMENT 'Floor or level within the building where the work center is located.',
    `location_room` STRING COMMENT 'Room number or identifier for the specific room or area where the work center operates.',
    `next_qualification_due_date` DATE COMMENT 'Scheduled date for the next periodic requalification or recertification of the work center per GMP maintenance schedules.',
    `processing_time_per_unit_minutes` DECIMAL(18,2) COMMENT 'Standard processing time in minutes required to produce one unit of output at this work center, used for capacity and scheduling calculations.',
    `qualification_status` STRING COMMENT 'Current qualification state of the work center per GxP requirements: Installation Qualification (IQ), Operational Qualification (OQ), Performance Qualification (PQ), fully qualified, or requiring requalification.. Valid values are `not_qualified|iq_complete|oq_complete|pq_complete|qualified|requalification_required`',
    `queue_time_minutes` DECIMAL(18,2) COMMENT 'Standard queue time in minutes representing the typical wait time before an operation can start at this work center.',
    `requires_batch_record` BOOLEAN COMMENT 'Flag indicating whether operations at this work center require formal GMP batch record documentation and electronic batch record (EBR) execution.',
    `scheduling_type` STRING COMMENT 'Default scheduling direction for operations at this work center (forward from start date, backward from due date, or midpoint scheduling).. Valid values are `forward|backward|midpoint`',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Standard setup or changeover time in minutes required to prepare the work center for a new production run or product changeover.',
    `standard_value_key` STRING COMMENT 'SAP PP standard value key defining the costing and time calculation parameters for operations performed at this work center.',
    `teardown_time_minutes` DECIMAL(18,2) COMMENT 'Standard teardown or cleanup time in minutes required after completing a production run, including cleaning and decontamination for GMP compliance.',
    `usage_unit_of_measure` STRING COMMENT 'Unit of measure for tracking work center usage and capacity consumption (e.g., hours, minutes, units produced, batches, cycles).. Valid values are `hour|minute|unit|batch|cycle`',
    `utilization_rate_percent` DECIMAL(18,2) COMMENT 'Current utilization rate as a percentage of available capacity actually used for production operations.',
    `work_center_category` STRING COMMENT 'Classification of the work center type indicating its primary operational mode (machine-based, labor-intensive, full production line, assembly station, controlled environment clean room, or packaging line).. Valid values are `machine|labor|production_line|assembly_station|clean_room|packaging_line`',
    `work_center_code` STRING COMMENT 'Business identifier for the work center used in production planning and scheduling. Externally visible code used in SAP PP module.. Valid values are `^[A-Z0-9]{4,12}$`',
    `work_center_description` STRING COMMENT 'Detailed description of the work centers purpose, capabilities, and operational scope.',
    `work_center_name` STRING COMMENT 'Human-readable name of the work center (e.g., Flow Cell Assembly Line 3, Reagent Fill-Finish Suite A, NGS Library Prep Station).',
    `work_center_status` STRING COMMENT 'Current operational status of the work center in its lifecycle (active for production, inactive/idle, under maintenance, undergoing qualification, or permanently decommissioned).. Valid values are `active|inactive|maintenance|qualification|decommissioned`',
    CONSTRAINT pk_work_center PRIMARY KEY(`work_center_id`)
) COMMENT 'Master data for manufacturing work centers — production lines, assembly stations, clean rooms, fill-finish suites, and packaging lines — where production operations are executed. Captures work center ID, name, category (machine, labor, production line), plant, cost center, capacity (shifts, hours), efficiency factor, utilization rate, GMP classification (ISO class 5/7/8, EU GMP grade A/B/C/D), associated equipment list, and qualification status. Used for production scheduling, capacity planning, and GMP environmental monitoring zone assignment. Integrates with SAP PP work center master (CR01/CR02).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` (
    `finished_goods_release_id` BIGINT COMMENT 'Unique identifier for the finished goods release record. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer-specific release decisions for custom lots, special quality agreements, or customer-specific acceptance criteria require account linkage for CoA delivery, release documentation, and regulator',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Cannot release genomics products (sequencers, reagent kits, arrays) to market without linking to the regulatory approval authorizing distribution. QA must verify the batch was manufactured under the a',
    `assay_version_id` BIGINT COMMENT 'Foreign key linking to clinical.assay_version. Business justification: Finished goods release of a reagent kit lot must confirm the lot meets specifications of the current assay version. GMP/CLIA lot release requires documenting which assay version the released lot suppo',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Finished goods release references the GMP batch record as part of release criteria verification. Cardinality: 1 release : 1 batch_record. Adding batch_record_id FK enables direct access to EBR documen',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Release holds or rejections trigger CAPAs to prevent recurrence. Batch disposition process requirement for genomics biotech products to ensure quality system closure.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: FG release records authorize commercial distribution of specific catalog items. QA release decisions, COA issuance, and regulatory lot disposition require direct catalog_item reference for commercial ',
    `coa_id` BIGINT COMMENT 'Foreign key linking to reagent.coa. Business justification: The finished goods release record documents the GMP quality decision and must reference the CoA issued for the released batch. finished_goods_release.coa_number and coa_issue_date are plain-text denor',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Release deviations (missing documentation, test failures, regulatory holds) documented for regulatory compliance. Required for batch release decision audit trail in genomics-biotechnology.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: A finished goods release decision is made for a specific commercial reagent lot — the lot disposition (released, rejected, quarantined) is the direct outcome of the release record. GMP lot disposition',
    `pipeline_validation_study_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_validation_study. Business justification: Finished goods release for a genomics assay kit requires confirmation that the associated bioinformatics pipeline has a current validated status. The release checklist must reference the pipeline vali',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: Finished goods release is plant-specific — the release authorization triggers goods movement posting at a specific ERP plant. In genomics biotech, regulatory release documents must identify the plant ',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Finished goods release decision is made for a specific production batch. Cardinality: 1 release : 1 production_batch (typically 1:1, though re-release scenarios possible). Adding production_batch_id F',
    `qc_result_id` BIGINT COMMENT 'Foreign key linking to quality.qc_result. Business justification: Finished goods release decisions in GMP genomics are directly based on formal QC test results. The release record must reference the governing qc_result for Certificate of Analysis issuance, regulator',
    `sequencing_run_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_run. Business justification: Finished goods release for sequencing kits/reagents requires sequencing-based QC testing. The release record must reference the sequencing run that generated the QC data supporting the release decisio',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Reagent-as-a-service and reagent rental contracts in genomics biotech govern which finished goods batches are released to which customer under what contractual terms. Revenue recognition and contract ',
    `site_id` BIGINT COMMENT 'Identifier of the GMP-compliant manufacturing facility where the batch was produced.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Finished goods release in GMP genomics manufacturing is executed at the SKU level — the specific SKU determines labeling requirements, pack size, regulatory classification, and CoA content. The existi',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Finished goods release for regulated IVD/genomics products requires confirmation that the product is released under the scope of an active regulatory submission/approval. Release records must referenc',
    `document_id` BIGINT COMMENT 'Unique identifier for the batch release record stored in Veeva Vault regulatory document management system.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Upon QC release, finished genomics products (sequencing kits, reagents) are assigned to a specific warehouse location (released stock zone, cold storage). Release decision triggers stock transfer to a',
    `capa_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether Corrective and Preventive Action (CAPA) is required based on quality issues identified during batch review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the finished goods release record was first created in the system.',
    `distribution_authorization_date` DATE COMMENT 'Date when the batch was formally authorized for commercial distribution or internal use following quality release approval.',
    `electronic_signature_reference` STRING COMMENT 'Reference identifier for the electronic signature applied to the release record, ensuring compliance with 21 CFR Part 11 requirements for electronic records and signatures.. Valid values are `^ESIG-[0-9]{10,20}$`',
    `expiration_date` DATE COMMENT 'Date after which the finished goods batch is no longer suitable for use, based on stability studies and shelf-life validation.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) confirming that the batch was manufactured in accordance with Good Manufacturing Practice (GMP) requirements.',
    `intended_use_classification` STRING COMMENT 'Regulatory classification of the products intended use: RUO (Research Use Only), IVD (In Vitro Diagnostic), LDT (Laboratory Developed Test), clinical trial, or internal use.. Valid values are `RUO|IVD|LDT|clinical_trial|internal_use`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the finished goods release record was last updated or modified.',
    `outstanding_deviation_count` STRING COMMENT 'Number of unresolved quality deviations or non-conformances associated with this batch at the time of release decision.',
    `qc_test_results_summary` STRING COMMENT 'High-level summary of quality control test results and acceptance criteria verification performed on the batch.',
    `quality_approver_name` STRING COMMENT 'Full name of the Qualified Person or QA manager who authorized the release decision.',
    `quality_reviewer_name` STRING COMMENT 'Full name of the quality reviewer who conducted the batch quality assessment.',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the batch is under regulatory hold, preventing distribution pending regulatory clearance or investigation.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of finished goods units rejected and not approved for distribution due to quality non-conformance.',
    `release_criteria_checklist_status` STRING COMMENT 'Status indicating whether all mandatory release criteria and quality checkpoints have been completed and verified.. Valid values are `complete|incomplete|not_applicable`',
    `release_decision_date` DATE COMMENT 'Date when the final quality release decision was made by the authorized quality personnel.',
    `release_notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the batch release decision, including any conditional release terms or distribution restrictions.',
    `release_record_number` STRING COMMENT 'Externally-known unique business identifier for the finished goods release record, used for traceability and regulatory documentation.. Valid values are `^FGR-[0-9]{8}-[A-Z0-9]{6}$`',
    `release_status` STRING COMMENT 'Current workflow status of the release record in the quality review and approval process.. Valid values are `pending_review|under_review|approved|rejected|on_hold`',
    `release_type` STRING COMMENT 'Classification of the release decision: full release (approved for distribution), conditional release (approved with restrictions), reject (not approved), quarantine (hold pending investigation), or rework (return to production).. Valid values are `full_release|conditional_release|reject|quarantine|rework`',
    `released_quantity` DECIMAL(18,2) COMMENT 'Quantity of finished goods units approved for release and distribution from this batch (may be less than batch size if partial release or rejection occurred).',
    `sap_qm_inspection_lot` STRING COMMENT 'SAP QM inspection lot number associated with the finished goods quality inspection and usage decision.. Valid values are `^[0-9]{10,12}$`',
    `storage_condition_requirement` STRING COMMENT 'Required storage conditions for the finished goods batch (e.g., temperature range, humidity, light protection) to maintain product stability and quality.',
    CONSTRAINT pk_finished_goods_release PRIMARY KEY(`finished_goods_release_id`)
) COMMENT 'Records the formal quality release decision for a finished goods batch, authorizing it for commercial distribution or internal use. Captures release record number, batch number, product code, product name, manufacturing site, release type (full release, conditional release, reject), release decision date, quality reviewer ID, quality approver ID (QP/QA), electronic signature reference (21 CFR Part 11), COA number, COA issue date, release criteria checklist completion status, outstanding deviation count, regulatory hold flag, and distribution authorization date. Integrates with SAP QM usage decision and Veeva Vault batch release workflow.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` (
    `production_routing_id` BIGINT COMMENT 'Unique identifier for the production routing master record. Primary key for the routing entity.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Production routings for regulated IVD/genomics products must be approved as part of the regulatory approval. Changes to routing require approval amendments. This FK enables change control impact asses',
    `controlled_document_id` BIGINT COMMENT 'Reference to the master SOP document that governs the execution of this routing. Links routing to controlled documentation for GMP compliance.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: Production routings in ERP are plant-specific — they define operation sequences for a specific manufacturing plant. In genomics biotech, MRP scheduling and capacity planning require routing-to-plant a',
    `sku_id` BIGINT COMMENT 'Reference to the product or material that this routing produces. Links to the master product catalog.',
    `product_bom_id` BIGINT COMMENT 'Reference to the Bill of Materials that defines the components and materials consumed during execution of this routing. Links routing to material requirements.',
    `research_protocol_id` BIGINT COMMENT 'Foreign key linking to research.protocol. Business justification: Production routings are industrialized versions of research protocols. Tech transfer process scales lab protocols to manufacturing SOPs. Essential for traceability in regulatory filings, process devia',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing plant where this routing is valid and executed. Routings are plant-specific in SAP PP.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Production routings for regulated IVD/genomics products are filed as part of regulatory submissions. Changes to routing require submission amendments. The existing plain-text `regulatory_submission_re',
    `alternative_routing_number` STRING COMMENT 'Reference to an alternative routing that can be used if this routing is unavailable. Enables flexible production planning and capacity management.. Valid values are `^[A-Z0-9]{8,12}$`',
    `approval_date` DATE COMMENT 'Date when this routing was formally approved for production use. Part of the GMP document control audit trail.',
    `approval_status` STRING COMMENT 'Current approval status of the routing in the document control workflow. Only approved routings can be released for production use.. Valid values are `draft|pending_review|approved|rejected`',
    `base_quantity` DECIMAL(18,2) COMMENT 'Reference quantity for which the standard times in this routing are defined. Actual times are scaled proportionally based on order quantity.',
    `base_unit_of_measure` STRING COMMENT 'Unit of measure for the base quantity and lot sizes (e.g., EA for each, KG for kilograms, L for liters). ISO standard unit codes.. Valid values are `^[A-Z]{2,3}$`',
    `change_control_number` STRING COMMENT 'Reference to the change control record that authorized the creation or last modification of this routing. Required for GMP traceability and audit compliance.. Valid values are `^CC-[0-9]{6,10}$`',
    `comments` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about this routing. Used for operational communication and knowledge transfer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this routing record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `gmp_classification` STRING COMMENT 'GMP criticality classification of the routing. GMP-critical routings require enhanced documentation, validation, and electronic signatures per FDA 21 CFR Part 11 and EU GMP Annex 11.. Valid values are `gmp_critical|gmp_non_critical|non_gmp`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this routing record was last updated. Tracks the currency of the routing data and supports change management.',
    `last_validation_date` DATE COMMENT 'Date when the most recent process validation study for this routing was completed and approved. Used to track validation currency.',
    `lot_size_from` DECIMAL(18,2) COMMENT 'Minimum production lot size for which this routing is valid. Used in SAP PP to select the appropriate routing based on order quantity.',
    `lot_size_to` DECIMAL(18,2) COMMENT 'Maximum production lot size for which this routing is valid. Enables lot-size-dependent routing selection in SAP PP.',
    `mes_integration_reference` STRING COMMENT 'External reference identifier used to link this routing to the shop-floor MES system for real-time production execution and data collection.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `next_revalidation_due_date` DATE COMMENT 'Date by which the routing must undergo revalidation to maintain its validated status. Periodic revalidation is required per GMP regulations.',
    `operation_count` STRING COMMENT 'Total number of manufacturing operations defined in this routing. Each operation represents a discrete production step with its own work center and times.',
    `process_validation_required` BOOLEAN COMMENT 'Flag indicating whether this routing requires formal process validation studies before use in commercial production. Required for IVD and RUO products per FDA and ISO 13485.',
    `process_validation_status` STRING COMMENT 'Current status of process validation for this routing. Validated status is required before the routing can be used for commercial GMP production.. Valid values are `not_required|pending|in_progress|validated|expired`',
    `requires_batch_record` BOOLEAN COMMENT 'Flag indicating whether production using this routing requires a formal batch manufacturing record (BMR) for traceability and compliance. Mandatory for GMP-regulated products.',
    `requires_electronic_signature` BOOLEAN COMMENT 'Flag indicating whether operations in this routing require electronic signatures for GMP compliance. True for IVD and regulated product routings per FDA 21 CFR Part 11.',
    `routing_group` STRING COMMENT 'Group key that categorizes related routings together. Used in SAP PP to organize routings by product family or process type.. Valid values are `^[A-Z0-9]{1,8}$`',
    `routing_group_counter` STRING COMMENT 'Sequential counter within the routing group to distinguish multiple routings for the same material. Part of the composite routing key in SAP PP.',
    `routing_number` STRING COMMENT 'Business identifier for the routing. Externally-known unique code used in SAP PP for routing identification and work order generation.. Valid values are `^[A-Z0-9]{8,12}$`',
    `routing_status` STRING COMMENT 'Current lifecycle status of the routing. Active routings are available for work order generation, released routings are approved for production, locked routings are temporarily unavailable, and obsolete routings are retired.. Valid values are `active|inactive|released|locked|obsolete`',
    `routing_type` STRING COMMENT 'Classification of the routing by its usage pattern. Standard routings are used for regular production, rate routings for repetitive manufacturing, reference routings as templates, and special routings for one-time or custom orders.. Valid values are `standard|rate|reference|special`',
    `routing_usage` STRING COMMENT 'SAP PP usage indicator defining the purpose of the routing (1=production, 2=maintenance, 3=quality inspection, etc.). Controls which business processes can reference this routing.. Valid values are `^[0-9]{1}$`',
    `total_labor_time_minutes` DECIMAL(18,2) COMMENT 'Sum of all labor times across all operations in the routing for the base quantity. Labor time represents manual work and scales with lot size.',
    `total_machine_time_minutes` DECIMAL(18,2) COMMENT 'Sum of all machine processing times across all operations in the routing for the base quantity. Machine time is equipment-dependent and scales with lot size.',
    `total_setup_time_minutes` DECIMAL(18,2) COMMENT 'Sum of all setup times across all operations in the routing. Setup time is independent of lot size and occurs once per production run.',
    `total_standard_lead_time_days` DECIMAL(18,2) COMMENT 'Total manufacturing lead time in days required to complete all operations in this routing, including setup, processing, queue, and move times. Used for production planning and scheduling.',
    `valid_from_date` DATE COMMENT 'Date from which this routing becomes effective and can be used for work order generation. Part of the routing validity period.',
    `valid_to_date` DATE COMMENT 'Date until which this routing remains valid. Nullable for routings with indefinite validity. After this date, the routing cannot be used for new work orders.',
    `version_number` STRING COMMENT 'Version identifier for this routing. Incremented with each approved change to maintain change history and support regulatory traceability.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    CONSTRAINT pk_production_routing PRIMARY KEY(`production_routing_id`)
) COMMENT 'Master data defining the sequence of manufacturing operations (routing) required to produce a specific product, including standard times, work center assignments, and control keys. Captures routing number, routing group, material/product, plant, routing status (active, inactive), valid-from/valid-to dates, total standard lead time, operation sequence with operation numbers, work center per operation, standard setup/machine/labor times, GMP-critical operation flags, electronic signature requirement per operation, and MES integration reference. Serves as the manufacturing process template for work order generation and shop-floor execution. Integrates with SAP PP routing (CA01/CA02).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`site` (
    `site_id` BIGINT COMMENT 'Primary key for manufacturing_site',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Every GMP manufacturing site in genomics/IVD biotech must be registered as an establishment with regulatory authorities (FDA, EMA). The establishment registration defines the authorized manufacturing ',
    `parent_manufacturing_site_id` BIGINT COMMENT 'Self-referencing FK on manufacturing_site (parent_manufacturing_site_id)',
    `address_line1` STRING COMMENT 'First line of the site’s street address.',
    `address_line2` STRING COMMENT 'Second line of the site’s street address (optional).',
    `city` STRING COMMENT 'City where the manufacturing site is located.',
    `closure_date` DATE COMMENT 'Date when the site ceased operations (if applicable).',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of other regulatory certifications held by the site (e.g., ISO 13485, ISO 9001).',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the site location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the site record was first created in the data lake.',
    `critical_equipment` STRING COMMENT 'Comma‑separated identifiers of equipment critical for GMP compliance.',
    `data_classification` STRING COMMENT 'Classification level applied to the site record for governance.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether the site meets environmental regulatory requirements.',
    `equipment_count` STRING COMMENT 'Total count of major equipment pieces at the site.',
    `floor_area_sqm` DECIMAL(18,2) COMMENT 'Total usable floor area of the manufacturing facility.',
    `gmp_certified` BOOLEAN COMMENT 'Indicates whether the site holds current GMP certification.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the site in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the site in decimal degrees.',
    `manager_email` STRING COMMENT 'Primary email address for the site manager.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for site operations.',
    `manager_phone` STRING COMMENT 'Contact phone number for the site manager.',
    `manufacturing_site_status` STRING COMMENT 'Current operational status of the site.',
    `next_audit_due` DATE COMMENT 'Planned date for the next scheduled audit.',
    `number_of_shifts` STRING COMMENT 'Number of production shifts operated per day.',
    `opening_date` DATE COMMENT 'Date when the site began operations.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the site address.',
    `production_capacity_units_per_day` DECIMAL(18,2) COMMENT 'Maximum number of production units the site can output per day.',
    `production_capacity_units_per_month` DECIMAL(18,2) COMMENT 'Maximum number of production units the site can output per month.',
    `region` STRING COMMENT 'Broad geographic region used for reporting and planning.',
    `shift_hours_per_day` DECIMAL(18,2) COMMENT 'Length of each shift in hours.',
    `site_code` STRING COMMENT 'External code used to reference the site in ERP/MES systems.',
    `site_name` STRING COMMENT 'Human‑readable name of the manufacturing site.',
    `site_type` STRING COMMENT 'Category of the site based on its primary function.',
    `state_province` STRING COMMENT 'State or province of the site location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the site record.',
    `waste_disposal_method` STRING COMMENT 'Primary method used for disposing of manufacturing waste.',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Master reference table for manufacturing_site. Referenced by manufacturing_site_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment` (
    `equipment_id` BIGINT COMMENT 'Primary key for equipment',
    `parent_equipment_id` BIGINT COMMENT 'Self-referencing FK on equipment (parent_equipment_id)',
    `service_contract_id` BIGINT COMMENT 'Identifier of the maintenance service contract.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Genomics biotech equipment (sequencers, liquid handlers, PCR systems) is procured from specific suppliers. Equipment qualification (IQ/OQ/PQ), spare parts procurement, and maintenance contracts requir',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: Manufacturing equipment is physically installed and operated within a specific work center (production line, assembly station, clean room). Linking equipment to work_center enables work-center-level e',
    `asset_lifecycle_stage` STRING COMMENT 'Current stage of the equipment within its overall lifecycle.',
    `asset_tag` STRING COMMENT 'Internal asset tag used for tracking the equipment within the enterprise.',
    `calibration_status` STRING COMMENT 'Current calibration state of the equipment.',
    `capacity_value` STRING COMMENT 'Maximum number of samples or units the equipment can process per run.',
    `cleaning_status` STRING COMMENT 'Current cleaning state of the equipment.',
    `cleanroom_class` STRING COMMENT 'Cleanroom ISO class of the environment housing the equipment.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of regulatory certifications (e.g., ISO 13485, GMP).',
    `cost` DECIMAL(18,2) COMMENT 'Capital cost of the equipment at acquisition.',
    `decommissioned_flag` BOOLEAN COMMENT 'Indicates whether the equipment has been decommissioned.',
    `disposal_info` STRING COMMENT 'Details on disposal method and date, if applicable.',
    `equipment_name` STRING COMMENT 'Human‑readable name or designation of the equipment.',
    `equipment_status` STRING COMMENT 'Current operational status of the equipment.',
    `equipment_type` STRING COMMENT 'Category of equipment based on its primary function.',
    `firmware_version` STRING COMMENT 'Version of the embedded firmware.',
    `installation_date` DATE COMMENT 'Date the equipment was installed on the shop floor.',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration.',
    `last_cleaning_date` DATE COMMENT 'Date the equipment was last cleaned.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance was performed.',
    `location` STRING COMMENT 'Facility, building and room where the equipment resides.',
    `maintenance_provider` STRING COMMENT 'External or internal party responsible for maintenance.',
    `maintenance_status` STRING COMMENT 'Current maintenance state of the equipment.',
    `model_number` STRING COMMENT 'Model identifier defined by the manufacturer.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating hours between equipment failures.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair the equipment after a failure.',
    `next_calibration_due` DATE COMMENT 'Scheduled date for the next calibration.',
    `next_cleaning_due` DATE COMMENT 'Scheduled date for the next cleaning activity.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next scheduled maintenance.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Maximum electrical power consumption.',
    `purchase_date` DATE COMMENT 'Date the equipment was purchased from the supplier.',
    `qualification_date` DATE COMMENT 'Date the equipment was qualified for production use.',
    `qualification_expiry_date` DATE COMMENT 'Date the current qualification expires.',
    `risk_classification` STRING COMMENT 'Risk level assigned to the equipment based on impact and failure probability.',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number uniquely identifying the unit.',
    `software_version` STRING COMMENT 'Version of the primary control software running on the equipment.',
    `throughput_per_day` STRING COMMENT 'Typical number of samples processed in a 24‑hour period.',
    `usage_hours_total` DECIMAL(18,2) COMMENT 'Cumulative operating hours since installation.',
    `validation_status` STRING COMMENT 'GMP validation state of the equipment.',
    `warranty_expiration_date` DATE COMMENT 'Date the manufacturer warranty ends.',
    CONSTRAINT pk_equipment PRIMARY KEY(`equipment_id`)
) COMMENT 'Master reference table for equipment. Referenced by equipment_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` (
    `validation_run_id` BIGINT COMMENT 'Primary key for the validation_run association',
    `process_validation_id` BIGINT COMMENT 'Foreign key linking to the process validation study for which this batch serves as a validation run.',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to the production batch designated as a validation run.',
    `acceptance_status` STRING COMMENT 'Whether this run met the acceptance criteria defined in the validation protocol. Values: ACCEPTED, REJECTED, PENDING_REVIEW. Belongs to the relationship because acceptance is evaluated against the specific studys protocol criteria, not the batchs general quality disposition.',
    `deviation_count` STRING COMMENT 'Number of deviations recorded specifically during the execution of this batch as a validation run. Distinct from the production_batch.deviation_count which covers all batch deviations. Run-specific deviations are evaluated against the validation protocols acceptance criteria.',
    `run_date` DATE COMMENT 'The date on which this production batch was executed as a validation run. May differ from the batchs manufacturing_start_date if the batch was produced for other purposes and subsequently designated as a validation run.',
    `run_outcome` STRING COMMENT 'The overall outcome of this specific validation run: PASS, FAIL, or INCONCLUSIVE. Distinct from batch disposition — a batch may be released (PASS disposition) but still FAIL a validation run criterion.',
    `sequence_number` STRING COMMENT 'The sequential order of this batch within the validation study (e.g., 1, 2, 3). Required by regulatory guidance to demonstrate consecutive run consistency. Belongs to the relationship, not to the batch or study alone.',
    CONSTRAINT pk_validation_run PRIMARY KEY(`validation_run_id`)
) COMMENT 'This association product represents the formal designation of a production batch as an executed run within a process validation study. It captures the operational and regulatory evidence generated when a specific production batch is used to demonstrate process consistency for a validation study. Each record links one process_validation study to one production_batch and carries run-specific attributes — sequence number, outcome, acceptance status, run date, and deviation count — that exist only in the context of this specific batch-within-study execution. Governed by ICH Q7, FDA Process Validation Guidance (2011), and EMA guidelines.. Existence Justification: In GMP biotech/genomics manufacturing, process validation studies formally designate specific production batches as validation runs — this is a regulated, actively managed business activity governed by ICH Q7 and FDA Process Validation Guidance (2011). One validation study requires multiple batches (typically 3 consecutive runs minimum per regulatory guidance), and one production batch can legitimately serve as a validation run for multiple concurrent studies (e.g., a batch validating both a new process parameter and a site transfer simultaneously). The Validation Run is a recognized regulatory and operational concept with its own data (run sequence, outcome, acceptance status) that belongs to neither the validation study nor the batch record alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_manufacturing_bom_id` FOREIGN KEY (`manufacturing_bom_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom`(`manufacturing_bom_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_production_routing_id` FOREIGN KEY (`production_routing_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_routing`(`production_routing_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_manufacturing_bom_id` FOREIGN KEY (`manufacturing_bom_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom`(`manufacturing_bom_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_manufacturing_bom_id` FOREIGN KEY (`manufacturing_bom_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom`(`manufacturing_bom_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ADD CONSTRAINT `fk_manufacturing_production_operation_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ADD CONSTRAINT `fk_manufacturing_production_operation_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ADD CONSTRAINT `fk_manufacturing_production_operation_production_routing_id` FOREIGN KEY (`production_routing_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_routing`(`production_routing_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ADD CONSTRAINT `fk_manufacturing_production_operation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ADD CONSTRAINT `fk_manufacturing_production_operation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_production_operation_id` FOREIGN KEY (`production_operation_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_operation`(`production_operation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_production_routing_id` FOREIGN KEY (`production_routing_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_routing`(`production_routing_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ADD CONSTRAINT `fk_manufacturing_site_parent_manufacturing_site_id` FOREIGN KEY (`parent_manufacturing_site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_parent_equipment_id` FOREIGN KEY (`parent_equipment_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` ADD CONSTRAINT `fk_manufacturing_validation_run_process_validation_id` FOREIGN KEY (`process_validation_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`process_validation`(`process_validation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` ADD CONSTRAINT `fk_manufacturing_validation_run_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`manufacturing` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `genomics_biotech_ecm`.`manufacturing` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `assay_development_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Development Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `manufacturing_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Bom Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `pipeline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Produced Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `production_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `technical_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Requirement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (LOT)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `bom_version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `bom_version` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Product Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `gmp_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_value_regex' = '^GR-[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `mes_integration_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Integration Reference');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `mes_integration_reference` SET TAGS ('dbx_value_regex' = '^MES-[A-Z0-9]{12}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'process_order|production_order|rework_order|validation_order|pilot_order|engineering_order');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `process_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Process Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `process_validation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|validated|revalidation_required');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `product_classification` SET TAGS ('dbx_business_glossary_term' = 'Product Classification');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `product_classification` SET TAGS ('dbx_value_regex' = 'IVD|RUO|LDT|CE_IVD');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `qc_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Hold Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Material Reservation Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `reservation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `routing_version` SET TAGS ('dbx_business_glossary_term' = 'Routing Version');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `routing_version` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order (SO) Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_value_regex' = '^SO-[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `device_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `manufacturing_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Bom Header Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Batch Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Produced Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `batch_disposition` SET TAGS ('dbx_business_glossary_term' = 'Batch Disposition');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `batch_disposition` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional_release');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (LOT)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `batch_size_actual` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Actual');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `batch_size_planned` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Planned');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `coa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `coa_reference_number` SET TAGS ('dbx_value_regex' = '^COA-[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `ebr_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Electronic Batch Record (EBR) Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `ebr_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Batch Record (EBR) Approver Name');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `ebr_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Batch Record (EBR) Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `ebr_document_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,30}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `ebr_review_date` SET TAGS ('dbx_business_glossary_term' = 'Electronic Batch Record (EBR) Review Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `ebr_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Batch Record (EBR) Reviewer Name');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `ebr_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Batch Record (EBR) Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `ebr_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|archived');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `ebr_version` SET TAGS ('dbx_business_glossary_term' = 'Electronic Batch Record (EBR) Version');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `ebr_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `equipment_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `equipment_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|requalification_required|not_qualified');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'gmp|non_gmp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `manufacturing_end_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing End Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `manufacturing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Start Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `process_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Process Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `process_validation_status` SET TAGS ('dbx_value_regex' = 'validated|revalidation_required|not_validated');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'reagent_kit|flow_cell|array|consumable|instrument_subassembly|other');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `qc_checkpoint_count` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Checkpoint Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `qc_fail_count` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Fail Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `qc_pass_count` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Pass Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Months)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` SET TAGS ('dbx_subdomain' = 'assembly_engineering');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `manufacturing_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Identifier');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `assay_development_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Development Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `crispr_construct_id` SET TAGS ('dbx_business_glossary_term' = 'Crispr Construct Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `device_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `molecular_design_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Design Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `alternative` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Alternative Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `alternative` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `assembly_type` SET TAGS ('dbx_business_glossary_term' = 'Assembly Type');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `authorization_group` SET TAGS ('dbx_business_glossary_term' = 'Authorization Group');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `authorization_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UoM)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_category` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Category');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_category` SET TAGS ('dbx_value_regex' = 'material|equipment|document|standard|variant');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|in_review|obsolete');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_text` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header Text');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `costing_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Costing Lot Size');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `deletion_flag` SET TAGS ('dbx_business_glossary_term' = 'Deletion Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `explosion_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Explosion Type');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `explosion_type` SET TAGS ('dbx_value_regex' = 'single_level|multi_level|summarized');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `gmp_relevant` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Relevant');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Classification');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `ivd_classification` SET TAGS ('dbx_business_glossary_term' = 'In Vitro Diagnostic (IVD) Classification');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `laboratory_design_office` SET TAGS ('dbx_business_glossary_term' = 'Laboratory or Design Office');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `laboratory_design_office` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,8}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `lot_size_from` SET TAGS ('dbx_business_glossary_term' = 'Lot Size From');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `lot_size_to` SET TAGS ('dbx_business_glossary_term' = 'Lot Size To');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `production_version` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `serialization_required` SET TAGS ('dbx_business_glossary_term' = 'Serialization Required');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Days');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `usage` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Usage');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `usage` SET TAGS ('dbx_value_regex' = 'production|engineering|costing|maintenance|universal');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `created_by` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` SET TAGS ('dbx_subdomain' = 'assembly_engineering');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `bom_component_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Component ID');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Component Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `manufacturing_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header ID');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `alternative_bom_indicator` SET TAGS ('dbx_business_glossary_term' = 'Alternative BOM Indicator');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `backflush_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backflush Indicator');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `component_cost` SET TAGS ('dbx_business_glossary_term' = 'Component Cost');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `component_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `component_number` SET TAGS ('dbx_business_glossary_term' = 'Component Material Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `component_quantity` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `component_source` SET TAGS ('dbx_business_glossary_term' = 'Component Source');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `component_source` SET TAGS ('dbx_value_regex' = 'internal|external|customer_supplied|oem');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `component_status` SET TAGS ('dbx_business_glossary_term' = 'Component Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `component_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending_approval|blocked');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `controlled_substance_flag` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `critical_part_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Part Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `engineering_change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number (ECN)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'BOM Item Category');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'stock_item|non_stock_item|variable_size_item|document_item|text_item|class_item');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `item_number` SET TAGS ('dbx_business_glossary_term' = 'BOM Item Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life Days');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'in_house_production|external_procurement|both|no_procurement');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `scrap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Component Scrap Percentage');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `serial_number_profile` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Profile');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `supply_area` SET TAGS ('dbx_business_glossary_term' = 'Supply Area');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `production_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Production Operation Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Bioinformatics Pipeline Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `production_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Production Routing Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `actual_labor_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Time (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `actual_machine_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Machine Time (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `actual_setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Setup Time (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10,12}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `control_key` SET TAGS ('dbx_business_glossary_term' = 'Control Key');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `control_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `electronic_signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `electronic_signature_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,50}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `electronic_signature_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `electronic_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `in_process_qc_checkpoint_flag` SET TAGS ('dbx_business_glossary_term' = 'In-Process Quality Control (QC) Checkpoint Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `labor_time_standard_minutes` SET TAGS ('dbx_business_glossary_term' = 'Labor Time Standard (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `machine_time_standard_minutes` SET TAGS ('dbx_business_glossary_term' = 'Machine Time Standard (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction Reference');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,50}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `operation_long_text` SET TAGS ('dbx_business_glossary_term' = 'Operation Long Text Description');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `operation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `operation_short_text` SET TAGS ('dbx_business_glossary_term' = 'Operation Short Text Description');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `operation_status` SET TAGS ('dbx_business_glossary_term' = 'Operation Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `planned_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned End Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `planned_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `process_validation_run_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Validation Run Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `qc_inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspection Lot Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `qc_inspection_lot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10,12}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `qc_result_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Result Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `qc_result_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed|conditional_release');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `setup_time_standard_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time Standard (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `sop_document_number` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Document Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `sop_document_number` SET TAGS ('dbx_value_regex' = '^SOP-[A-Z0-9-]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `sop_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Version');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `sop_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ALTER COLUMN `yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Yield Quantity');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `inprocess_qc_result_id` SET TAGS ('dbx_business_glossary_term' = 'In-Process Quality Control (QC) Result Identifier');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `aliquot_id` SET TAGS ('dbx_business_glossary_term' = 'Aliquot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Equipment Identifier');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `oos_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Oos Investigation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Bioinformatics Pipeline Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `production_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Production Operation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `qc_result_id` SET TAGS ('dbx_business_glossary_term' = 'Retest Result Identifier');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `qc_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `sample_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Specimen Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Calibration Due Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `control_chart_rule_violation` SET TAGS ('dbx_business_glossary_term' = 'Control Chart Rule Violation');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP_QM|MES|LIMS|manual_entry');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `deviation_number` SET TAGS ('dbx_business_glossary_term' = 'Deviation Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Disposition Code');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'accept|reject|conditional_release|rework|scrap|hold');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `environmental_condition_humidity` SET TAGS ('dbx_business_glossary_term' = 'Environmental Condition Relative Humidity (Percent)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `environmental_condition_temperature` SET TAGS ('dbx_business_glossary_term' = 'Environmental Condition Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `inspection_characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Code');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `inspection_characteristic_description` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Description');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `inspection_method_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method Code');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `inspection_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Code');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `inspection_result_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `inspection_result_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_release|pending|retest');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `production_step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Production Step Sequence Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `record_last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `retest_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `assay_version_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `installed_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Instrument Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `labeling_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `master_batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Master Batch Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `pipeline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Release Sequencing Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Approved Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_record_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_record_number` SET TAGS ('dbx_value_regex' = '^EBR-[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_record_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `bom_version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `bom_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `coa_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Document Reference');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `coa_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Issued Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Completed Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `environmental_class` SET TAGS ('dbx_business_glossary_term' = 'Environmental Classification');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `environmental_class` SET TAGS ('dbx_value_regex' = 'ISO_5|ISO_6|ISO_7|ISO_8|unclassified');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `equipment_train` SET TAGS ('dbx_business_glossary_term' = 'Equipment Train');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Batch Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Initiated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `mes_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Document Reference');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `process_order_number` SET TAGS ('dbx_business_glossary_term' = 'Process Order Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `process_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `rejected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Rejected Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Rejection Reason');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Batch Retest Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Reviewed Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Method');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_value_regex' = 'autoclave|gamma_irradiation|ethylene_oxide|filtration|none|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Version');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` SET TAGS ('dbx_subdomain' = 'assembly_engineering');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `equipment_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Qualification ID');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `assay_development_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Development Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Reagent Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site ID');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'current|expired|not_required');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `next_requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Requalification Due Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Cycle Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_protocol_reference` SET TAGS ('dbx_business_glossary_term' = 'Qualification Protocol Reference');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Qualification Report Reference');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Start Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|qualified|expired|failed|suspended');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type (IQ/OQ/PQ)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'IQ|OQ|PQ');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `qualification_validity_period_days` SET TAGS ('dbx_business_glossary_term' = 'Qualification Validity Period (Days)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `regulatory_standard_applied` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard Applied');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ALTER COLUMN `test_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Results Summary');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `process_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Process Validation Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `analytical_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Validation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `assay_development_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Development Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `device_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `pipeline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Report Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `production_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Production Routing Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `sample_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Specimen Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `sequencing_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `batch_size_unit` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `batch_size_unit` SET TAGS ('dbx_value_regex' = 'units|liters|kilograms|flow_cells|arrays|kits');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `batch_size_validated` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Validated');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `capa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `capa_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `change_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Control Reference');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Validation Comments');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `critical_process_parameters` SET TAGS ('dbx_business_glossary_term' = 'Critical Process Parameters (CPP)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `critical_quality_attributes` SET TAGS ('dbx_business_glossary_term' = 'Critical Quality Attributes (CQA)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `equipment_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `equipment_qualification_status` SET TAGS ('dbx_value_regex' = 'IQ_OQ_PQ_complete|IQ_OQ_complete|not_qualified|requalification_required');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'IVD|RUO|LDT|medical_device|pharmaceutical');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `process_capability_index` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `quality_approver` SET TAGS ('dbx_business_glossary_term' = 'Quality Approver');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'FDA|EMA|MHRA|TGA|PMDA|NMPA');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `statistical_method` SET TAGS ('dbx_business_glossary_term' = 'Statistical Method');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Validation Outcome');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional_pass|in_progress|not_started');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_protocol_number` SET TAGS ('dbx_value_regex' = '^PV-[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_runs_completed` SET TAGS ('dbx_business_glossary_term' = 'Validation Runs Completed');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_runs_planned` SET TAGS ('dbx_business_glossary_term' = 'Validation Runs Planned');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_scope` SET TAGS ('dbx_business_glossary_term' = 'Validation Scope');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_stage` SET TAGS ('dbx_business_glossary_term' = 'Validation Stage');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_stage` SET TAGS ('dbx_value_regex' = 'protocol_approved|execution_in_progress|report_approved|validated|revalidation_required|expired');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Start Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_team_lead` SET TAGS ('dbx_business_glossary_term' = 'Validation Team Lead');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_business_glossary_term' = 'Validation Type');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_value_regex' = 'prospective|concurrent|retrospective|revalidation');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `allows_overlapping_operations` SET TAGS ('dbx_business_glossary_term' = 'Allows Overlapping Operations');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `available_capacity_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Hours Per Day');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `capacity_category` SET TAGS ('dbx_business_glossary_term' = 'Capacity Category');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `capacity_hours_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Capacity Hours Per Shift');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `capacity_shifts_per_day` SET TAGS ('dbx_business_glossary_term' = 'Capacity Shifts Per Day');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `control_key` SET TAGS ('dbx_business_glossary_term' = 'Control Key');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `efficiency_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Efficiency Factor Percentage');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `environmental_monitoring_zone` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Zone');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `equipment_list` SET TAGS ('dbx_business_glossary_term' = 'Associated Equipment List');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `formula_key` SET TAGS ('dbx_business_glossary_term' = 'Formula Key');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `is_bottleneck` SET TAGS ('dbx_business_glossary_term' = 'Is Bottleneck Work Center');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `last_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Qualification Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `location_building` SET TAGS ('dbx_business_glossary_term' = 'Location Building');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `location_floor` SET TAGS ('dbx_business_glossary_term' = 'Location Floor');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `location_room` SET TAGS ('dbx_business_glossary_term' = 'Location Room');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `next_qualification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Qualification Due Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `processing_time_per_unit_minutes` SET TAGS ('dbx_business_glossary_term' = 'Processing Time Per Unit (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_qualified|iq_complete|oq_complete|pq_complete|qualified|requalification_required');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `queue_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Queue Time (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `requires_batch_record` SET TAGS ('dbx_business_glossary_term' = 'Requires Batch Record');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `scheduling_type` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Type');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `scheduling_type` SET TAGS ('dbx_value_regex' = 'forward|backward|midpoint');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Setup Time (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `standard_value_key` SET TAGS ('dbx_business_glossary_term' = 'Standard Value Key');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `teardown_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Teardown Time (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `usage_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Usage Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `usage_unit_of_measure` SET TAGS ('dbx_value_regex' = 'hour|minute|unit|batch|cycle');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `utilization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_business_glossary_term' = 'Work Center Category');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_value_regex' = 'machine|labor|production_line|assembly_station|clean_room|packaging_line');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_description` SET TAGS ('dbx_business_glossary_term' = 'Work Center Description');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_name` SET TAGS ('dbx_business_glossary_term' = 'Work Center Name');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_status` SET TAGS ('dbx_business_glossary_term' = 'Work Center Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|qualification|decommissioned');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `finished_goods_release_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Goods Release ID');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `assay_version_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `pipeline_validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Validation Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `qc_result_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Result Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Release Sequencing Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site ID');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `distribution_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Authorization Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `electronic_signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Reference (21 CFR Part 11)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `electronic_signature_reference` SET TAGS ('dbx_value_regex' = '^ESIG-[0-9]{10,20}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `intended_use_classification` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Classification');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `intended_use_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT|clinical_trial|internal_use');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `outstanding_deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `qc_test_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Test Results Summary');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `quality_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Approver Name (QP/QA)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `quality_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Reviewer Name');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `release_criteria_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Release Criteria Checklist Completion Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `release_criteria_checklist_status` SET TAGS ('dbx_value_regex' = 'complete|incomplete|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `release_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Release Decision Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `release_record_number` SET TAGS ('dbx_business_glossary_term' = 'Release Record Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `release_record_number` SET TAGS ('dbx_value_regex' = '^FGR-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'pending_review|under_review|approved|rejected|on_hold');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Type');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `release_type` SET TAGS ('dbx_value_regex' = 'full_release|conditional_release|reject|quarantine|rework');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Released Quantity');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `sap_qm_inspection_lot` SET TAGS ('dbx_business_glossary_term' = 'SAP Quality Management (QM) Inspection Lot');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `sap_qm_inspection_lot` SET TAGS ('dbx_value_regex' = '^[0-9]{10,12}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ALTER COLUMN `storage_condition_requirement` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Requirement');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `production_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Production Routing Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Research Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `alternative_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative Routing Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `alternative_routing_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `alternative_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `alternative_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `change_control_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'gmp_critical|gmp_non_critical|non_gmp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `last_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Validation Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `lot_size_from` SET TAGS ('dbx_business_glossary_term' = 'Lot Size From');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `lot_size_to` SET TAGS ('dbx_business_glossary_term' = 'Lot Size To');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `mes_integration_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Integration Reference');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `mes_integration_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `next_revalidation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Revalidation Due Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `operation_count` SET TAGS ('dbx_business_glossary_term' = 'Operation Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `process_validation_required` SET TAGS ('dbx_business_glossary_term' = 'Process Validation Required');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `process_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Process Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `process_validation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|validated|expired');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `requires_batch_record` SET TAGS ('dbx_business_glossary_term' = 'Requires Batch Record');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `requires_electronic_signature` SET TAGS ('dbx_business_glossary_term' = 'Requires Electronic Signature');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `routing_group` SET TAGS ('dbx_business_glossary_term' = 'Routing Group');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `routing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,8}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `routing_group_counter` SET TAGS ('dbx_business_glossary_term' = 'Routing Group Counter');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_value_regex' = 'active|inactive|released|locked|obsolete');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Type');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_value_regex' = 'standard|rate|reference|special');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `routing_usage` SET TAGS ('dbx_business_glossary_term' = 'Routing Usage');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `routing_usage` SET TAGS ('dbx_value_regex' = '^[0-9]{1}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `total_labor_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Time (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `total_machine_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Machine Time (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `total_setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Setup Time (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `total_standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Total Standard Lead Time (Days)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `parent_manufacturing_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment` SET TAGS ('dbx_subdomain' = 'assembly_engineering');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment` ALTER COLUMN `parent_equipment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` SET TAGS ('dbx_association_edges' = 'manufacturing.process_validation,manufacturing.production_batch');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` ALTER COLUMN `validation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Run - Validation Run Id');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` ALTER COLUMN `process_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Run - Process Validation Id');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Run - Production Batch Id');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Run Acceptance Status');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Run Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Run Date');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` ALTER COLUMN `run_outcome` SET TAGS ('dbx_business_glossary_term' = 'Run Outcome');
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`validation_run` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Validation Run Sequence Number');
