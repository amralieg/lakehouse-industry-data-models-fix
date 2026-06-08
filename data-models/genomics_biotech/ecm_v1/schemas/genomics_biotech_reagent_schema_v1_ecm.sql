-- Schema for Domain: reagent | Business: Genomics Biotech | Version: v1_ecm
-- Generated on: 2026-05-06 13:04:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`reagent` COMMENT 'Governs the lifecycle of reagents, consumables, and biochemical inputs — including library preparation kits, flow cells, CRISPR reagents, PCR/qPCR master mixes, enzymes, buffers, and array hybridization chips. Owns LOT traceability, COA records, SDS documentation, expiry management, storage requirements, usage tracking, and GMP-compliant release status.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`catalog` (
    `catalog_id` BIGINT COMMENT 'Unique identifier for the reagent catalog entry. Primary key for the reagent catalog master data.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: IVD reagent kits and consumables require regulatory approval (FDA clearance, CE mark) before commercial sale. This links reagent product definitions to their regulatory approval records, enabling comp',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Reagent catalog entries ARE commercial products in the master catalog. Required for pricing synchronization, product lifecycle management, regulatory classification alignment, and commercial analytics',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reagent products are developed and maintained by specific R&D cost centers. Essential for product costing, R&D capitalization decisions, transfer pricing, and financial reporting of reagent developmen',
    `gene_annotation_track_id` BIGINT COMMENT 'Foreign key linking to reference.gene_annotation_track. Business justification: Gene expression arrays, targeted panels, and exome capture reagents are versioned to specific gene annotation releases. Product specifications, target gene counts, and coverage claims reference the an',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Sequencing reagents, primers, probes, and capture kits are designed and validated for specific genome builds (GRCh38, GRCh37, T2T-CHM13). Regulatory submissions, assay validation studies, and customer',
    `glossary_term_id` BIGINT COMMENT 'Foreign key linking to data.glossary_term. Business justification: Reagent types, categories, and applications reference controlled terminology for standardization. Real business need: consistent terminology in regulatory submissions, data exchange, and cross-site ha',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Reagent catalog items are procured as materials through supply chain. Links product specification to procurement master for MRP planning, purchase requisition generation, and spend analytics—foundatio',
    `metadata_schema_id` BIGINT COMMENT 'Foreign key linking to data.metadata_schema. Business justification: Reagent catalog data must conform to FAIR metadata schemas for regulatory submissions and data sharing. Real business need: FAIR compliance for reagent data in public repositories and regulatory filin',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Catalog products often originate from R&D projects before commercialization (assay development, novel reagent formulations). Tracks technology transfer from research to commercial catalog. Essential f',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Strategic pharma/biotech accounts often have custom-validated or co-developed reagent products. Tracks which reagents are approved/qualified for specific customer workflows, supporting sales targeting',
    `variant_database_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database. Business justification: Clinical assay reagents (pharmacogenomics panels, hereditary cancer kits, carrier screening) are designed and validated against specific variant database releases (ClinVar, COSMIC, PharmGKB versions).',
    `catalog_number` STRING COMMENT 'Externally-known unique catalog number or SKU (Stock Keeping Unit) for the reagent product. Used for ordering, inventory management, and customer communication.. Valid values are `^[A-Z0-9]{6,20}$`',
    `coa_required_flag` BOOLEAN COMMENT 'Indicates whether a COA (Certificate of Analysis) is required for each LOT (Lot Number) of this reagent. True indicates COA must be issued; False indicates no COA requirement. COAs document QC test results and compliance.',
    `compatible_instruments` STRING COMMENT 'List of instrument platforms or models compatible with this reagent. Critical for flow cells, sequencing kits, and instrument-specific consumables. Comma-separated list of instrument identifiers.',
    `concentration` STRING COMMENT 'Concentration specification of the reagent with units (e.g., 10X, 5 mg/ml, 100 mM). Critical for protocol development and quality control.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reagent catalog record was first created in the system. Used for audit trail and data lineage tracking.',
    `discontinuation_date` DATE COMMENT 'Date when the reagent product was discontinued or will be discontinued. Null for active products. Used for phase-out planning and customer communication.',
    `freeze_thaw_cycle_limit` STRING COMMENT 'Maximum number of freeze-thaw cycles the reagent can withstand before degradation. Critical for maintaining reagent performance and ensuring reproducible results.',
    `gmp_compliant_flag` BOOLEAN COMMENT 'Indicates whether the reagent is manufactured under GMP (Good Manufacturing Practice) regulations. True indicates GMP-compliant manufacturing; False indicates non-GMP. Critical for IVD and clinical applications.',
    `hazard_classification` STRING COMMENT 'Safety hazard classification code per GHS (Globally Harmonized System) or OSHA standards. Indicates chemical, biological, or physical hazards associated with the reagent (e.g., flammable, corrosive, toxic, biohazard). [ENUM-REF-CANDIDATE: non_hazardous|flammable|corrosive|toxic|oxidizer|biohazard|carcinogen|irritant — promote to reference product]',
    `intended_application` STRING COMMENT 'Primary intended use case or application for the reagent. Describes the genomic workflow or assay type the reagent is designed for (e.g., NGS library preparation, WGS, WES, CRISPR gene editing, qPCR, SNP genotyping, array hybridization).',
    `introduction_date` DATE COMMENT 'Date when the reagent product was first introduced to the catalog and made available for sale. Used for product lifecycle tracking and portfolio management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this reagent catalog record was last updated. Used for change tracking and audit compliance.',
    `light_sensitivity_flag` BOOLEAN COMMENT 'Indicates whether the reagent is light-sensitive and requires storage in dark or amber containers. True indicates light-sensitive; False indicates no special light protection required.',
    `package_size` DECIMAL(18,2) COMMENT 'Quantity of reagent per package in the specified unit_of_measure. Defines the standard package configuration for ordering and inventory.',
    `purity_specification` STRING COMMENT 'Purity level or grade specification of the reagent (e.g., >95%, molecular biology grade, sequencing grade). Ensures reagent quality meets application requirements.',
    `quality_control_tested_flag` BOOLEAN COMMENT 'Indicates whether each LOT (Lot Number) of this reagent undergoes QC (Quality Control) testing before release. True indicates mandatory QC testing; False indicates no routine QC testing required.',
    `reagent_category` STRING COMMENT 'Secondary hierarchical category classification for the reagent. Provides finer-grained grouping within reagent_type (e.g., polymerase, ligase, restriction enzyme under enzyme type). [ENUM-REF-CANDIDATE: library_prep|sequencing|pcr_qpcr|gene_editing|array_hybridization|sample_prep|quality_control|storage_transport — promote to reference product]',
    `reagent_type` STRING COMMENT 'Primary classification of the reagent product type. Categorizes reagents into major functional groups for inventory and usage tracking.. Valid values are `enzyme|buffer|kit|flow_cell|crispr_component|consumable`',
    `sds_id` BIGINT COMMENT 'Reference identifier to the Safety Data Sheet (SDS) document for this reagent. SDS provides detailed safety, handling, and emergency response information required by OSHA and GHS regulations.',
    `shelf_life_months` STRING COMMENT 'Manufacturer-specified shelf life of the reagent in months from date of manufacture when stored under recommended conditions. Used to calculate expiry dates for LOT (Lot Number) tracking.',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling, storage, or safety requirements not covered by standard storage parameters. May include instructions for reconstitution, mixing, or hazardous material handling.',
    `sterility_requirement` STRING COMMENT 'Sterility classification of the reagent. Sterile indicates validated sterile manufacturing; non_sterile indicates no sterility requirement; aseptic indicates aseptic processing without terminal sterilization.. Valid values are `sterile|non_sterile|aseptic`',
    `storage_humidity_max_percent` DECIMAL(18,2) COMMENT 'Maximum relative humidity requirement for storage as a percentage. Prevents moisture-related degradation of reagent components.',
    `storage_humidity_min_percent` DECIMAL(18,2) COMMENT 'Minimum relative humidity requirement for storage as a percentage. Ensures reagent stability in controlled environmental conditions.',
    `storage_temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum storage temperature requirement in degrees Celsius. Exceeding this threshold may compromise reagent integrity and invalidate quality assurance.',
    `storage_temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum storage temperature requirement in degrees Celsius. Critical for maintaining reagent stability and ensuring GMP (Good Manufacturing Practice) compliance.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the reagent quantity. Used for inventory management, ordering, and usage tracking. [ENUM-REF-CANDIDATE: ml|l|mg|g|kg|units|reactions|tests|each — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_catalog PRIMARY KEY(`catalog_id`)
) COMMENT 'Master catalog of all reagents, consumables, and biochemical inputs managed by Genomics Biotech — including library preparation kits, flow cells, CRISPR reagents, PCR/qPCR master mixes, enzymes, buffers, and array hybridization chips. Captures product identity, reagent type classification (enzyme, buffer, kit, flow cell, CRISPR component, consumable), category hierarchy, classification (RUO vs IVD), intended application (NGS, WGS, WES, CRISPR, qPCR, array), storage requirements (temperature range, humidity limits, light sensitivity, freeze-thaw limits, special handling), hazard classification, regulatory status, and lifecycle stage. This is the SSOT for reagent product definitions and their storage condition profiles.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`lot` (
    `lot_id` BIGINT COMMENT 'Unique identifier for the reagent lot. Primary key. Inferred role: MASTER_RESOURCE.',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: Externally sourced reagent lots must trace to supplier batch for regulatory compliance (21 CFR Part 11, ISO 13485). Enables batch genealogy queries, quality investigations, recall traceability, and Co',
    `catalog_id` BIGINT COMMENT 'Reference to the master reagent product definition (e.g., library prep kit, flow cell, CRISPR reagent, PCR master mix). Links this lot to its product catalog entry.',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Deviations during manufacturing or testing affect specific lots and drive disposition decisions. Critical for GMP compliance, lot release, and regulatory inspection readiness in genomics biotech manuf',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Manufacturing lots of sequencing reagents are QC-tested and validated against specific reference genomes. CoA documents cite the genome build used for mapping rate, on-target %, and concordance testin',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Manufacturing lots are produced under internal orders that accumulate production costs, enable cost settlement to inventory valuation, and support GMP batch costing requirements. Critical for standard',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Reagent lots are manufactured outputs requiring traceability to the GMP production batch that created them. Production_batch captures execution-level data (actual yield, deviations, QC checkpoints) es',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: GxP batch release requires qualified employee signature for regulatory compliance. QC approval is a critical control point in genomics reagent manufacturing; employee identity must be traceable for FD',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Reagent lots are frequently manufactured for specific R&D projects (custom synthesis, project-specific formulations). Critical for project cost allocation, technology transfer tracking, and tracing re',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: GMP lots are frequently manufactured for specific customer contracts or reserved for strategic accounts. Critical for contract fulfillment tracking, consignment inventory management, and regulatory tr',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to data.retention_policy. Business justification: Lot data retention driven by regulatory requirements (FDA 21 CFR Part 11, EU GMP Annex 11). Real business need: compliance with data retention mandates for batch records and traceability.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Manufacturing lots are produced against specific SKUs for GMP traceability. Required for lot genealogy, recall execution, inventory valuation (COGS by SKU), and regulatory batch record linkage. Founda',
    `stability_study_id` BIGINT COMMENT 'Foreign key linking to quality.stability_study. Business justification: Stability studies are conducted on specific manufacturing lots to establish shelf life and storage conditions. Critical for regulatory submissions (IND, BLA) and expiry date assignment in genomics rea',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor from whom this lot was purchased. Null for internally manufactured lots.',
    `work_order_id` BIGINT COMMENT 'Reference to the manufacturing work order or production batch that created this lot. Null for purchased lots.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the lot was manufactured. Required for trade compliance, customs, and regulatory submissions.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lot record was first created in the system. Immutable audit field.',
    `disposition` STRING COMMENT 'Final disposition status of the lot: available for use, allocated to specific orders or projects, fully consumed, expired and awaiting disposal, returned to supplier, or destroyed.. Valid values are `available|allocated|consumed|expired|returned|destroyed`',
    `disposition_date` DATE COMMENT 'Date the lot reached its final disposition (e.g., fully consumed, destroyed, returned). Null if lot is still in active use.',
    `disposition_reason` STRING COMMENT 'Free-text explanation for the lot disposition. Examples: normal consumption, expired, failed QC retest, supplier recall, contamination, obsolete product.',
    `expiry_date` DATE COMMENT 'Date after which the lot should not be used. Determined by stability studies and shelf-life specifications. Critical for compliance and patient safety.',
    `gmp_release_status` STRING COMMENT 'Current GMP lifecycle status of the lot. Quarantine: awaiting QC clearance; QC Testing: under quality control evaluation; Released: approved for use; Restricted: conditional use only; Rejected: failed QC; Disposed: destroyed or returned.. Valid values are `quarantine|qc_testing|released|restricted|rejected|disposed`',
    `hazard_classification` STRING COMMENT 'Primary hazard classification of the reagent per Globally Harmonized System (GHS): non-hazardous, flammable, corrosive, toxic, oxidizer, biohazard, carcinogen, or irritant. [ENUM-REF-CANDIDATE: non_hazardous|flammable|corrosive|toxic|oxidizer|biohazard|carcinogen|irritant|compressed_gas|explosive — promote to reference product]',
    `internal_coa_reference` STRING COMMENT 'Document reference or identifier for the internally generated Certificate of Analysis for this lot. Links to the quality documentation in the document management system.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this lot record. Audit trail field for accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lot record was last updated. Updated automatically on every change. Audit trail field.',
    `lot_number` STRING COMMENT 'Externally-known unique lot or batch number assigned during manufacturing or receipt. Used for traceability across the supply chain and in regulatory submissions.. Valid values are `^[A-Z0-9]{6,20}$`',
    `lot_type` STRING COMMENT 'Classification of the lot origin: manufactured in-house, purchased from supplier, consignment inventory, sample lot, or rework/reprocessed lot.. Valid values are `manufactured|purchased|consignment|sample|rework`',
    `manufacturing_date` DATE COMMENT 'Date the lot was manufactured or compounded. For purchased lots, this is the suppliers manufacturing date as stated on the Certificate of Analysis (COA).',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or special handling instructions related to this lot. Used for operational communication and audit trail context.',
    `qc_approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the lot was approved for release by QC/QA. Immutable audit field. Null if not yet approved.',
    `qc_test_completion_date` DATE COMMENT 'Date when all required QC tests for this lot were completed and results finalized. Null if testing is not yet complete.',
    `qc_test_status` STRING COMMENT 'Current status of quality control testing for this lot: not started, in progress, passed, failed, conditional pass (released with restrictions), or waived (testing not required).. Valid values are `not_started|in_progress|passed|failed|conditional_pass|waived`',
    `quantity_available` DECIMAL(18,2) COMMENT 'Current available quantity of the lot after consumption, allocation, and wastage. Updated in real-time by laboratory information management system (LIMS) and manufacturing execution system (MES).',
    `quantity_manufactured` DECIMAL(18,2) COMMENT 'Total quantity produced or received in this lot, expressed in the unit of measure defined for the reagent (e.g., liters, kilograms, units, reactions).',
    `quarantine_flag` BOOLEAN COMMENT 'Boolean indicator whether the lot is currently under quarantine and not available for use. True if quarantined, False if released or in other non-quarantine status.',
    `quarantine_reason` STRING COMMENT 'Free-text explanation of why the lot is quarantined. Examples: pending incoming inspection, QC test failure investigation, supplier quality alert, deviation under review.',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Boolean indicator whether the lot is under regulatory hold due to FDA, EMA, or other regulatory authority action. True if on hold, False otherwise.',
    `regulatory_hold_reason` STRING COMMENT 'Free-text explanation of the regulatory hold. Examples: FDA inspection finding, supplier quality alert, product recall, import detention.',
    `retest_date` DATE COMMENT 'Date by which the lot must be retested to confirm continued suitability for use. Applicable to raw materials and certain reagents with extended shelf life.',
    `sds_reference` STRING COMMENT 'Document reference or identifier for the Safety Data Sheet associated with this reagent lot. Required for hazardous materials and chemical reagents.',
    `sterilization_date` DATE COMMENT 'Date the lot was sterilized. Null if sterilization is not applicable or not performed.',
    `sterilization_method` STRING COMMENT 'Method used to sterilize the lot, if applicable: not applicable, autoclave, gamma irradiation, ethylene oxide, filtration, or chemical sterilization. Critical for reagents used in sterile workflows.. Valid values are `not_applicable|autoclave|gamma_irradiation|ethylene_oxide|filtration|chemical`',
    `storage_condition` STRING COMMENT 'Required storage condition for the lot to maintain stability and efficacy: room temperature, refrigerated (2-8°C), frozen (-20°C), frozen (-80°C), liquid nitrogen, or controlled ambient.. Valid values are `room_temperature|refrigerated_2_8c|frozen_minus_20c|frozen_minus_80c|liquid_nitrogen|controlled_ambient`',
    `supplier_coa_reference` STRING COMMENT 'Document reference or identifier for the suppliers Certificate of Analysis. Links to the quality documentation provided by the supplier.',
    `supplier_lot_number` STRING COMMENT 'Lot or batch number assigned by the supplier. Used for traceability back to the suppliers manufacturing records and for supplier quality investigations.',
    `supplier_quality_grade` STRING COMMENT 'Quality grade or certification level assigned by the supplier: Research Use Only (RUO), GMP Grade, Clinical Grade, In Vitro Diagnostic (IVD) Grade, or Molecular Biology Grade. Determines permissible use cases.. Valid values are `research_use_only|gmp_grade|clinical_grade|ivd_grade|molecular_biology_grade`',
    `traceability_code` STRING COMMENT 'Unique traceability identifier used for end-to-end supply chain tracking, including serialization and aggregation per regulatory requirements (e.g., FDA UDI, EU IVDR).',
    `unit_of_measure` STRING COMMENT 'Unit in which the lot quantity is expressed: liters, milliliters, kilograms, grams, milligrams, units, reactions, tests, vials, or plates. [ENUM-REF-CANDIDATE: L|mL|kg|g|mg|units|reactions|tests|vials|plates — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_lot PRIMARY KEY(`lot_id`)
) COMMENT 'GMP-compliant lot (batch) master record for every manufactured or received reagent lot. Captures lot number, manufacturing date, expiry date, quantity produced, GMP release status, quarantine flags, retest date, originating work order or supplier shipment, supplier lot number, supplier COA reference, country of origin, and supplier quality grade. Includes immutable status audit trail recording all lifecycle transitions (quarantine → QC testing → released → restricted → disposed) with triggering event, operator ID, timestamp, and supporting document reference. SSOT for lot traceability across the reagent lifecycle. Supports FDA 21 CFR Part 211, ISO 13485, and GxP requirements.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`coa` (
    `coa_id` BIGINT COMMENT 'Unique identifier for the Certificate of Analysis record. Primary key for the COA data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Certificate of Analysis approval is a regulatory requirement in genomics biotech. Approver must be a qualified employee with documented training. Links to employee record for qualification verificatio',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Certificates of Analysis are issued to specific customers for regulatory compliance and quality documentation. Customer-specific CoAs support audit trails for GxP customers and enable tracking of whic',
    `lot_id` BIGINT COMMENT 'Reference to the reagent or consumable lot for which this COA was issued. Links to the lot master record.',
    `primary_superseded_by_coa_id` BIGINT COMMENT 'Reference to the COA that supersedes this one, if applicable. Used when a COA is reissued due to corrections, additional testing, or updated specifications.',
    `qc_result_id` BIGINT COMMENT 'Foreign key linking to quality.qc_result. Business justification: COAs document QC test results for customer-facing release documentation. Each COA line item references specific QC results. Required for regulatory compliance and customer quality assurance in genomic',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to data.retention_policy. Business justification: COA documents have specific retention requirements (typically 1 year beyond product expiry plus regulatory period). Real business need: regulatory compliance for batch record retention per GMP and ISO',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Certificates of Analysis certify that specific SKUs meet product specifications. Required for customer-facing documentation, regulatory submissions (FDA/EMA), and quality release decisions. COAs are i',
    `acceptance_criteria_summary` STRING COMMENT 'Summary of the acceptance criteria applied to this lot. May reference specification limits, compendial standards, or customer-specific requirements.',
    `analytical_method_references` STRING COMMENT 'Comma-separated list or structured reference to the analytical methods and standard operating procedures (SOPs) used for testing. Links to controlled method documents.',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the COA was approved by authorized QA personnel. Part of the regulatory audit trail.',
    `coa_status` STRING COMMENT 'Current lifecycle status of the COA document. Tracks progression from draft through approval to release, and handles superseded or voided states for regulatory compliance.. Valid values are `draft|under_review|approved|released|superseded|voided`',
    `comments` STRING COMMENT 'Free-text comments or notes related to the COA, including special handling instructions, customer-specific notes, or additional context not captured in structured fields.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the COA record was first created in the system. Part of the audit trail for regulatory compliance.',
    `customer_facing_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this COA is intended for customer delivery. True indicates the COA will be provided to external customers; false indicates internal use only.',
    `deviation_description` STRING COMMENT 'Detailed description of any deviations noted during testing, including root cause analysis and corrective actions taken. Required when deviations_noted is true.',
    `deviations_noted` BOOLEAN COMMENT 'Boolean flag indicating whether any deviations from standard testing procedures or specifications were noted during testing. Triggers investigation and documentation requirements.',
    `document_number` STRING COMMENT 'Externally-known unique document number for the COA, used for regulatory submission, customer delivery, and audit trail. Typically follows a controlled numbering scheme.. Valid values are `^COA-[A-Z0-9]{8,20}$`',
    `document_url` STRING COMMENT 'URL or file path to the PDF or electronic document version of the COA. Supports document management and customer self-service access.',
    `expiry_date` DATE COMMENT 'Expiration date of the lot as determined by stability studies and documented in the COA. After this date, the lot should not be used.',
    `gmp_release_authorized` BOOLEAN COMMENT 'Boolean flag indicating whether the lot has been authorized for GMP release based on COA results. True indicates the lot meets all acceptance criteria and is approved for distribution.',
    `intended_use` STRING COMMENT 'Regulatory classification of the intended use for this lot: Research Use Only (RUO), In Vitro Diagnostic (IVD), GMP-grade for manufacturing, or other classifications. Determines regulatory requirements and customer eligibility.. Valid values are `RUO|IVD|GMP|research|clinical|diagnostic`',
    `issue_date` DATE COMMENT 'Date on which the COA was officially issued and released for use. This is the authoritative date for regulatory and customer-facing purposes.',
    `issuing_laboratory` STRING COMMENT 'Name or identifier of the laboratory or facility that performed the QC testing and issued the COA. May be an internal GMP facility or a contracted testing laboratory.',
    `issuing_laboratory_location` STRING COMMENT 'Geographic location or site identifier of the issuing laboratory. Required for regulatory traceability and multi-site operations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the COA record was last modified. Tracks changes for audit trail and version control purposes.',
    `overall_result` STRING COMMENT 'Overall pass/fail determination for the lot based on all QC tests performed. A pass result authorizes lot release; fail or conditional results trigger investigation and disposition.. Valid values are `pass|fail|conditional|pending`',
    `regulatory_status` STRING COMMENT 'Regulatory compliance status of the lot based on COA results and applicable regulations (FDA, EMA, IVDR, etc.). Indicates whether the lot meets all regulatory requirements for its intended use.. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `release_authorization_date` DATE COMMENT 'Date on which the lot was authorized for release following COA approval. Critical for regulatory compliance and lot traceability.',
    `retest_date` DATE COMMENT 'Date by which the lot should be retested to confirm continued conformance to specifications. Applicable for reagents with limited stability or time-sensitive performance characteristics.',
    `review_timestamp` TIMESTAMP COMMENT 'Timestamp when the COA was reviewed by QC personnel prior to QA approval. Part of the multi-stage approval workflow.',
    `reviewed_by_name` STRING COMMENT 'Full name of the quality control analyst or reviewer who performed the initial review of test results before QA approval.',
    `specification_document_number` STRING COMMENT 'Controlled document number of the product specification used for testing. Links to the master specification repository.',
    `specification_version` STRING COMMENT 'Version identifier of the product specification document against which the lot was tested. Ensures traceability to the correct acceptance criteria and test methods.',
    `storage_conditions` STRING COMMENT 'Required storage conditions for the lot as documented in the COA (e.g., -20°C, 2-8°C, room temperature, protect from light). Critical for maintaining product integrity.',
    `test_date` DATE COMMENT 'Date on which the quality control testing was performed for this lot. May differ from issue date due to review and approval cycles.',
    `test_summary` STRING COMMENT 'High-level summary of tests performed, including test names and categories (e.g., identity, purity, potency, sterility). Provides quick overview of COA scope.',
    CONSTRAINT pk_coa PRIMARY KEY(`coa_id`)
) COMMENT 'Certificate of Analysis (COA) record for each reagent lot, documenting QC test results, acceptance criteria, pass/fail determinations, analytical method references, and authorized release signatures. Captures COA document number, issuing laboratory, test date, specification version, and GMP release authorization. Supports regulatory submission packages, customer-facing COA delivery, and ISO 13485 / GxP documentation requirements. Linked to the lot master and QC test results.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`sds` (
    `sds_id` BIGINT COMMENT 'Unique identifier for the Safety Data Sheet record. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Safety Data Sheets must reference regulatory approval status (RUO vs IVD) as labeling requirements, hazard communication, and distribution restrictions differ by regulatory designation. Essential for ',
    `catalog_id` BIGINT COMMENT 'Foreign key reference to the reagent or chemical substance that this SDS document describes. Links to the reagent catalog entry.',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: SDSs are controlled documents requiring version control, approval workflows, training tracking, and regulatory submission. Standard document control practice in GMP/GLP genomics operations for safety ',
    `research_protocol_id` BIGINT COMMENT 'Foreign key linking to research.protocol. Business justification: SDS documents reference safe handling protocols for laboratory use. Links safety documentation to operational procedures. Required for EHS compliance, laboratory safety audits, and ensuring proper han',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to data.retention_policy. Business justification: SDS documents have regulatory retention requirements (OSHA 29 CFR 1910.1200, REACH). Real business need: EHS compliance and audit trail for hazardous material documentation.',
    `accidental_release_measures` STRING COMMENT 'Emergency procedures, protective equipment, and proper methods for containment and cleanup of spills or leaks. Section 6 of SDS.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance. Format: XXXXXX-XX-X.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `composition_description` STRING COMMENT 'Detailed description of the chemical composition, including hazardous ingredients, concentration ranges, and CAS numbers for components. Section 3 of SDS.',
    `country_of_issue` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country for which this SDS was prepared (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDS record was first created in the system. Audit trail for record lifecycle.',
    `disposal_considerations` STRING COMMENT 'Guidance on proper disposal methods, waste treatment, and applicable regulations for the substance and contaminated packaging. Section 13 of SDS.',
    `document_language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language in which this SDS is written (e.g., ENG for English, DEU for German).. Valid values are `^[A-Z]{3}$`',
    `ec_number` STRING COMMENT 'Seven-digit identifier assigned to chemical substances registered in the European Union. Format: XXX-XXX-X.. Valid values are `^[0-9]{3}-[0-9]{3}-[0-9]$`',
    `ecological_information` STRING COMMENT 'Environmental effects including ecotoxicity, persistence and degradability, bioaccumulative potential, and mobility in soil. Section 12 of SDS.',
    `effective_date` DATE COMMENT 'Date when this SDS version becomes the official document for use. May differ from revision date to allow distribution time.',
    `emergency_phone` STRING COMMENT '24-hour emergency telephone number for chemical emergencies (e.g., CHEMTREC, manufacturer emergency line). Organizational contact data classified as confidential.',
    `exposure_controls` STRING COMMENT 'Occupational exposure limits, engineering controls, and personal protective equipment recommendations (respiratory, hand, eye, skin protection). Section 8 of SDS.',
    `firefighting_measures` STRING COMMENT 'Suitable extinguishing media, specific hazards arising from the chemical, and special protective equipment for firefighters. Section 5 of SDS.',
    `first_aid_measures` STRING COMMENT 'Instructions for first aid treatment following exposure by different routes (inhalation, skin contact, eye contact, ingestion). Section 4 of SDS.',
    `ghs_classification` STRING COMMENT 'GHS hazard class and category codes for the substance (e.g., Flam. Liq. 2, Acute Tox. 3, Skin Corr. 1A). Multiple classifications separated by semicolons.',
    `handling_precautions` STRING COMMENT 'Precautions for safe handling including advice on protective measures, hygiene practices, and conditions to avoid. Section 7 of SDS.',
    `hazard_statements` STRING COMMENT 'Standardized GHS hazard statement codes and text describing the nature of the hazards (e.g., H225: Highly flammable liquid and vapor). Multiple statements separated by semicolons.',
    `intended_use` STRING COMMENT 'Recommended use and restrictions on use of the chemical product (e.g., laboratory reagent, research use only, in vitro diagnostic).',
    `manufacturer_address` STRING COMMENT 'Complete mailing address of the manufacturer or supplier. Organizational contact data classified as confidential.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactures or supplies the chemical product. Section 1 of SDS.',
    `manufacturer_phone` STRING COMMENT 'Primary contact telephone number for the manufacturer or supplier. Organizational contact data classified as confidential.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDS record was last modified in the system. Audit trail for record lifecycle.',
    `physical_properties` STRING COMMENT 'Physical and chemical characteristics including appearance, odor, pH, melting point, boiling point, flash point, vapor pressure, density, solubility. Section 9 of SDS.',
    `pictogram_codes` STRING COMMENT 'GHS pictogram codes indicating hazard symbols (e.g., GHS02 for flame, GHS06 for skull and crossbones). Multiple codes separated by semicolons.',
    `precautionary_statements` STRING COMMENT 'Standardized GHS precautionary statement codes and text describing recommended measures to minimize or prevent adverse effects (e.g., P210: Keep away from heat/sparks/open flames). Multiple statements separated by semicolons.',
    `product_code` STRING COMMENT 'Manufacturers catalog number or Stock Keeping Unit (SKU) for the reagent or chemical product.',
    `product_name` STRING COMMENT 'Commercial or trade name of the chemical product or reagent as it appears on the label and in the catalog.',
    `reach_registration_number` STRING COMMENT 'Registration number issued under the EU REACH regulation for substances manufactured or imported in quantities of one tonne or more per year.',
    `regulatory_information` STRING COMMENT 'Safety, health, and environmental regulations specific to the product including TSCA, REACH, OSHA, EPA listings and restrictions. Section 15 of SDS.',
    `revision_date` DATE COMMENT 'Date when this version of the SDS was last revised or updated. Critical for ensuring users have current safety information.',
    `sds_number` STRING COMMENT 'Business identifier for the SDS document, typically assigned by the manufacturer or regulatory system. Externally-known unique code.. Valid values are `^SDS-[A-Z0-9]{6,12}$`',
    `sds_status` STRING COMMENT 'Current lifecycle status of the SDS document. Active indicates the document is currently in use; superseded indicates it has been replaced by a newer version.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `signal_word` STRING COMMENT 'GHS signal word indicating the relative level of severity of hazard: Danger (more severe) or Warning (less severe).. Valid values are `danger|warning|none`',
    `stability_reactivity` STRING COMMENT 'Chemical stability, possibility of hazardous reactions, conditions to avoid, incompatible materials, and hazardous decomposition products. Section 10 of SDS.',
    `storage_requirements` STRING COMMENT 'Conditions for safe storage including temperature range, humidity control, incompatible materials, and special storage requirements. Section 7 of SDS.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum recommended storage temperature in degrees Celsius to maintain product stability and safety.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum recommended storage temperature in degrees Celsius to maintain product stability and safety.',
    `supersedes_date` DATE COMMENT 'Date of the previous SDS version that this document replaces. Nullable for initial SDS versions.',
    `toxicological_information` STRING COMMENT 'Information on toxicological effects including routes of exposure, symptoms, acute and chronic effects, and numerical measures of toxicity (LD50, LC50). Section 11 of SDS.',
    `transport_information` STRING COMMENT 'Transportation classification including UN number, proper shipping name, transport hazard class, packing group, and environmental hazards. Section 14 of SDS.',
    `un_number` STRING COMMENT 'Four-digit identification number assigned by the United Nations for hazardous materials transport. Format: UNXXXX.. Valid values are `^UN[0-9]{4}$`',
    `version_number` STRING COMMENT 'Version identifier for this SDS revision, following semantic versioning (e.g., 1.0, 2.1). Incremented when content is updated.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    CONSTRAINT pk_sds PRIMARY KEY(`sds_id`)
) COMMENT 'Safety Data Sheet (SDS) master record for each reagent or chemical substance, capturing GHS hazard classification, signal words, hazard and precautionary statements, first-aid measures, handling and storage requirements, disposal instructions, regulatory identifiers (CAS number, UN number), and SDS version history. Supports OSHA HazCom, REACH, and GHS compliance. Linked to reagent catalog entries and storage location requirements.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the physical or logical storage location. Primary key for the storage location master data.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Storage location setup in GxP-controlled environments requires qualified personnel. Tracks accountability for cold storage, hazardous material areas, and cleanroom qualification. Supports audit trail ',
    `facility_id` BIGINT COMMENT 'Reference to the parent facility or site where this storage location physically resides. Links to facility master data for geographic and organizational context.',
    `parent_location_storage_location_id` BIGINT COMMENT 'Reference to the parent storage location in a hierarchical storage structure. Enables nested location modeling such as freezer containing shelves containing racks.',
    `access_control_level` STRING COMMENT 'Security classification determining who can physically access this storage location. Aligns with facility security protocols and regulatory requirements.. Valid values are `public|restricted|controlled|high_security`',
    `barcode` STRING COMMENT 'Machine-readable barcode identifier affixed to the physical storage location. Used for automated inventory scanning and LIMS integration.',
    `building_code` STRING COMMENT 'Identifier for the specific building within the facility where the storage location is situated. Supports multi-building campus environments.',
    `capacity_occupied_units` STRING COMMENT 'Current number of storage units occupied in this location. Updated by LIMS during inventory transactions to track utilization.',
    `capacity_total_units` STRING COMMENT 'Maximum number of storage units (e.g., boxes, vials, plates) that can be accommodated in this location. Used for capacity planning and space optimization.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for capacity tracking. Defines what constitutes one storage unit for capacity calculations. [ENUM-REF-CANDIDATE: box|vial|plate|tube|bottle|bag|container — 7 candidates stripped; promote to reference product]',
    `cold_chain_compliant_flag` BOOLEAN COMMENT 'Indicates whether this storage location meets cold chain compliance requirements for temperature-sensitive reagents. Requires continuous environmental monitoring and validated temperature control.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was first created in the system. Part of audit trail for data lineage and compliance tracking.',
    `deactivation_date` DATE COMMENT 'Date when the storage location was deactivated or decommissioned. Used for historical tracking and to prevent new inventory assignments to retired locations.',
    `deactivation_reason` STRING COMMENT 'Business justification or reason code for deactivating the storage location. Supports root cause analysis and facility planning decisions.',
    `environmental_monitor_device_code` STRING COMMENT 'Identifier for the temperature/humidity monitoring device or sensor linked to this storage location. Enables traceability to environmental monitoring records.',
    `fefo_enforcement_flag` BOOLEAN COMMENT 'Indicates whether FEFO inventory management rules are enforced for this storage location. When true, LIMS will prioritize inventory with nearest expiry dates for picking.',
    `fifo_enforcement_flag` BOOLEAN COMMENT 'Indicates whether FIFO inventory management rules are enforced for this storage location. When true, LIMS will prioritize oldest inventory for picking.',
    `gmp_qualification_status` STRING COMMENT 'GMP qualification state of the storage location. Indicates whether the location has passed Installation Qualification (IQ), Operational Qualification (OQ), and Performance Qualification (PQ) protocols.. Valid values are `qualified|not_qualified|qualification_in_progress|requalification_required`',
    `hazardous_material_approved_flag` BOOLEAN COMMENT 'Indicates whether this storage location is approved for storing hazardous or flammable reagents. Requires special safety equipment and ventilation per Safety Data Sheet (SDS) requirements.',
    `location_code` STRING COMMENT 'Business identifier code for the storage location, used for operational reference and LIMS integration. Typically follows facility-room-unit-position hierarchy encoding.. Valid values are `^[A-Z0-9]{4,20}$`',
    `location_name` STRING COMMENT 'Human-readable name or label for the storage location, used for identification and reporting purposes.',
    `location_type` STRING COMMENT 'Classification of the storage location based on environmental control and physical characteristics. Determines applicable storage protocols and monitoring requirements.. Valid values are `freezer|refrigerator|ambient_shelf|cold_room|dry_storage|controlled_temperature_unit`',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this storage location record. Supports audit trail and accountability requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was last updated. Tracks data currency and supports change management processes.',
    `next_requalification_date` DATE COMMENT 'Scheduled date for the next periodic requalification of the storage location. Supports proactive compliance management and maintenance planning.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or location-specific information not captured in structured fields.',
    `qualification_date` DATE COMMENT 'Date when the storage location was last qualified or requalified per GMP requirements. Used to track qualification currency and schedule requalification activities.',
    `room_number` STRING COMMENT 'Room or area identifier within the building where the storage location is positioned. Used for physical navigation and access control.',
    `shelf_position` STRING COMMENT 'Granular position identifier within the storage unit, such as shelf level, rack number, or drawer position. Enables precise inventory localization.',
    `storage_location_status` STRING COMMENT 'Current operational status of the storage location. Controls whether the location can accept new inventory assignments and reflects qualification state.. Valid values are `active|inactive|quarantine|maintenance|decommissioned|pending_qualification`',
    `target_humidity_max_pct` DECIMAL(18,2) COMMENT 'Upper bound of the acceptable relative humidity range for this storage location as a percentage. Applicable for humidity-sensitive reagent storage.',
    `target_humidity_min_pct` DECIMAL(18,2) COMMENT 'Lower bound of the acceptable relative humidity range for this storage location as a percentage. Applicable for humidity-sensitive reagent storage.',
    `target_temperature_max_c` DECIMAL(18,2) COMMENT 'Upper bound of the acceptable temperature range for this storage location in degrees Celsius. Used for environmental monitoring and alarm thresholds.',
    `target_temperature_min_c` DECIMAL(18,2) COMMENT 'Lower bound of the acceptable temperature range for this storage location in degrees Celsius. Used for environmental monitoring and alarm thresholds.',
    `temperature_zone` STRING COMMENT 'Designated temperature control zone for the storage location. Determines which reagent types can be stored and monitoring requirements per GMP guidelines.. Valid values are `ultra_low_minus_80c|low_minus_20c|refrigerated_2_to_8c|controlled_15_to_25c|ambient`',
    `unit_identifier` STRING COMMENT 'Specific equipment unit identifier such as freezer serial number, refrigerator asset tag, or shelf unit code. Links to equipment master for maintenance tracking.',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Physical or logical storage location master for reagent inventory — capturing facility, building, room, freezer/refrigerator unit, shelf, and rack/position identifiers. Records monitored temperature zone, humidity range, capacity limits, current occupancy, environmental monitoring device linkage, access control level, and GMP qualification status. Supports LIMS-driven storage assignment, FIFO/FEFO management, cold-chain compliance tracking, and capacity planning.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` (
    `inventory_balance_id` BIGINT COMMENT 'Unique identifier for the inventory balance record. Primary key for the inventory balance entity.',
    `catalog_id` BIGINT COMMENT 'Reference to the specific reagent product (library prep kit, flow cell, CRISPR reagent, PCR master mix, enzyme, buffer, array chip) for which this inventory balance is maintained.',
    `coa_id` BIGINT COMMENT 'Reference to the Certificate of Analysis (COA) document for this reagent lot. COA contains quality test results, specifications, and release approval required for Good Manufacturing Practice (GMP) compliance.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Consignment inventory at customer sites or customer-reserved stock requires tracking ownership/allocation. Supports revenue recognition timing, inventory valuation, and service agreement compliance fo',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this inventory location or reagent usage. Supports departmental cost allocation and financial reporting.',
    `employee_id` BIGINT COMMENT 'User identifier of the person or system account that performed the last update to this inventory balance record. Supports audit trail and accountability.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Inventory balances are inherently lot-specific in GMP environments - each balance record represents quantity of a specific lot at a specific location. Currently inventory_balance has lot_number as STR',
    `sds_id` BIGINT COMMENT 'Reference to the Safety Data Sheet (SDS) document for this reagent. SDS contains hazard information, handling instructions, and emergency procedures required for workplace safety compliance.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Inventory balances are tracked by SKU for financial valuation, MRP planning, and order fulfillment. Required for perpetual inventory, available-to-promise calculations, and inventory aging reports in ',
    `storage_location_id` BIGINT COMMENT 'Reference to the physical storage location (warehouse, cold room, freezer, shelf) where this reagent lot is stored. Supports multi-site inventory management.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor from whom this reagent lot was procured. Supports vendor performance analysis and supply chain traceability.',
    `available_quantity` DECIMAL(18,2) COMMENT 'Quantity available for immediate use or reservation, calculated as on-hand quantity minus reserved quantity minus any quality hold quantity. Drives dispensing and allocation logic.',
    `batch_status` STRING COMMENT 'Current lifecycle status of the inventory balance record. Active indicates normal operations; depleted indicates zero on-hand; expired indicates past expiry date; recalled indicates manufacturer recall.. Valid values are `active|depleted|expired|recalled|transferred|adjusted`',
    `consignment_flag` BOOLEAN COMMENT 'Boolean indicator that this inventory is held on consignment from the vendor and is not owned by the company until consumed. Affects inventory valuation and accounts payable processing. True indicates consignment stock.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory balance record was first created in the system. Supports audit trail and data lineage tracking.',
    `days_to_expiry` STRING COMMENT 'Number of days remaining until the reagent lot reaches its expiry date. Used for expiry alerts, FEFO prioritization, and inventory aging reports.',
    `expiry_alert_flag` BOOLEAN COMMENT 'Boolean indicator that the reagent lot is approaching expiry (typically within 30-90 days based on business rules). True indicates alert condition requiring expedited usage or disposal planning.',
    `expiry_date` DATE COMMENT 'Manufacturer-specified expiration date for the reagent lot. Critical for First Expired First Out (FEFO) dispensing logic, shelf-life management, and Good Manufacturing Practice (GMP) compliance.',
    `fefo_priority_rank` STRING COMMENT 'Calculated ranking for First Expired First Out (FEFO) dispensing logic. Lower rank indicates earlier expiry and higher dispensing priority. Prevents expiry waste and ensures Good Manufacturing Practice (GMP) compliance.',
    `gmp_release_status` STRING COMMENT 'Quality Control (QC) release status indicating whether the reagent lot is approved for use in Good Manufacturing Practice (GMP) operations. Blocked or quarantine status prevents dispensing.. Valid values are `released|blocked|restricted|quarantine|expired`',
    `last_adjustment_reason` STRING COMMENT 'Reason code for the most recent inventory adjustment transaction. Supports audit trail, root cause analysis, and inventory accuracy improvement initiatives. [ENUM-REF-CANDIDATE: physical_count|damage|expiry|transfer|correction|theft|spillage|quality_issue — 8 candidates stripped; promote to reference product]',
    `last_movement_date` DATE COMMENT 'Date of the most recent inventory transaction (goods receipt, dispensing, transfer, adjustment) affecting this balance record. Used for inventory aging and slow-moving stock analysis.',
    `last_physical_count_date` DATE COMMENT 'Date of the most recent physical inventory count or cycle count for this reagent lot at this storage location. Supports Good Manufacturing Practice (GMP) inventory reconciliation and audit requirements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this inventory balance record. Reflects the last goods receipt, dispensing, adjustment, or status change event.',
    `low_stock_alert_flag` BOOLEAN COMMENT 'Boolean indicator that the available quantity has fallen below the reorder point, triggering a low-stock alert for procurement action. True indicates alert condition.',
    `manufacture_date` DATE COMMENT 'Date when the reagent lot was manufactured. Used for shelf-life calculation, traceability, and quality control purposes.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Maximum inventory level allowed at the storage location to prevent overstocking, manage storage capacity, and minimize expiry risk. Used for replenishment order quantity calculation.',
    `minimum_stock_level` DECIMAL(18,2) COMMENT 'Safety stock or minimum inventory level that must be maintained to prevent stockouts and ensure continuous operations. Used for inventory policy enforcement.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special handling instructions, or contextual information about this inventory balance record. Supports operational communication and exception documentation.',
    `on_hand_quantity` DECIMAL(18,2) COMMENT 'Total physical quantity of the reagent lot currently present at the storage location. Represents the actual inventory count before any reservations or allocations.',
    `purchase_order_number` STRING COMMENT 'Purchase order number under which this reagent lot was procured. Links inventory to procurement transaction for audit trail and cost reconciliation.. Valid values are `^PO[0-9]{8,12}$`',
    `quarantine_quantity` DECIMAL(18,2) COMMENT 'Quantity of the reagent lot placed under quality hold or quarantine pending Quality Control (QC) inspection, Certificate of Analysis (COA) review, or investigation. Not available for use.',
    `receipt_date` DATE COMMENT 'Date when the reagent lot was received into inventory at the storage location. Marks the start of internal shelf-life tracking and inventory aging analysis.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Minimum inventory level that triggers a replenishment order or low-stock alert. Calculated based on lead time, consumption rate, and safety stock requirements.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of the reagent lot that has been reserved or allocated for specific orders, experiments, or production runs but not yet physically dispensed. Reduces available-to-use quantity.',
    `restricted_use_flag` BOOLEAN COMMENT 'Boolean indicator that this reagent lot has usage restrictions (e.g., Research Use Only (RUO), specific project allocation, regulatory hold). True indicates restricted access requiring authorization.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that created or last updated this inventory balance record (SAP_MM=SAP Materials Management, LIMS=Laboratory Information Management System, WMS=Warehouse Management System, MES=Manufacturing Execution System, MANUAL=manual entry).. Valid values are `SAP_MM|LIMS|WMS|MES|MANUAL`',
    `storage_condition_code` STRING COMMENT 'Required storage condition for the reagent lot (RT=room temperature, 2-8C=refrigerated, -20C=frozen, -80C=ultra-low freezer, LN2=liquid nitrogen, DRY=desiccated, DARK=light-protected). Ensures proper handling and stability. [ENUM-REF-CANDIDATE: RT|2-8C|-20C|-80C|LN2|DRY|DARK — 7 candidates stripped; promote to reference product]',
    `total_valuation_amount` DECIMAL(18,2) COMMENT 'Total inventory value for this balance record, calculated as on-hand quantity multiplied by valuation price. Used for balance sheet reporting and inventory turnover analysis.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the reagent quantity (e.g., EA for each, ML for milliliters, UL for microliters, KIT for kits, RXNS for reactions). Aligns with SAP Material Master UOM.. Valid values are `^[A-Z]{1,5}$`',
    `valuation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation price (e.g., USD, EUR, GBP). Supports multi-currency inventory valuation.. Valid values are `^[A-Z]{3}$`',
    `valuation_price` DECIMAL(18,2) COMMENT 'Standard or moving average price per unit of measure used for inventory valuation and Cost of Goods Sold (COGS) calculation. Supports financial reporting and profitability analysis.',
    CONSTRAINT pk_inventory_balance PRIMARY KEY(`inventory_balance_id`)
) COMMENT 'Real-time reagent inventory balance record tracking on-hand quantity, reserved quantity, available-to-use quantity, and unit of measure for each reagent lot at each storage location. Captures reorder point, minimum stock level, maximum stock level, and last physical count date. Supports FEFO (First Expired First Out) dispensing logic, low-stock alerts, and GMP inventory reconciliation. Updated by goods receipts, dispensing events, and inventory adjustments.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` (
    `dispensing_event_id` BIGINT COMMENT 'Unique identifier for the reagent dispensing event record. Primary key for tracking individual material movement transactions.',
    `asset_id` BIGINT COMMENT 'Reference to the sequencing or laboratory instrument that consumed the reagent, if applicable (e.g., flow cell loaded into sequencer).',
    `catalog_id` BIGINT COMMENT 'Reference to the master reagent product being dispensed (e.g., library prep kit, flow cell, CRISPR reagent, PCR master mix).',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Reagents dispensed for customer service work, evaluation programs, or contract research require tracking destination account for cost recovery, service agreement compliance, and usage analytics. Suppo',
    `experiment_id` BIGINT COMMENT 'Reference to the research or production experiment that consumed the reagent, if applicable.',
    `batch_record_id` BIGINT COMMENT 'Reference to the GMP batch production record that documents the use of this reagent in manufacturing. Required for FDA-regulated production.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Reagent consumption events charge to internal orders for project cost tracking, R&D capitalization analysis, and activity-based costing. Enables financial analysis of reagent usage by research project',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Critical traceability link - every reagent dispensing event must be traceable to the specific lot (batch) used. Currently dispensing_event has lot_number as STRING but no FK to lot master. Adding lot_',
    `employee_id` BIGINT COMMENT 'Employee or technician who performed the dispensing or transfer operation. Required for GMP chain-of-custody documentation.',
    `quality_issue_id` BIGINT COMMENT 'Foreign key linking to data.quality_issue. Business justification: Quality issues detected during dispensing (temperature excursions, contamination, chain of custody breaks) require tracking for CAPA. Real business need: deviation management and root cause analysis p',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Dispensing events consume specific SKUs for cost allocation to experiments, work orders, or instruments. Required for usage analytics, replenishment triggers, and activity-based costing in genomics la',
    `storage_location_id` BIGINT COMMENT 'Storage location, facility, or inventory site from which the reagent was dispensed or transferred.',
    `tertiary_dispensing_modified_by_employee_id` BIGINT COMMENT 'Employee or system user who last modified this dispensing event record. Required for audit trail and data integrity compliance.',
    `chain_of_custody_confirmed_flag` BOOLEAN COMMENT 'Indicates whether the material transfer was acknowledged and confirmed by the receiving party or system. Required for GMP audit trails.',
    `coa_reference_number` STRING COMMENT 'Reference number of the Certificate of Analysis document associated with this reagent lot. Links dispensing event to quality documentation.',
    `cold_chain_compliant_flag` BOOLEAN COMMENT 'Indicates whether the reagent was maintained within required temperature range during the movement event. Critical for temperature-sensitive materials like enzymes and CRISPR reagents.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the reagent consumption is charged. Supports activity-based costing and departmental expense tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dispensing event record was first created in the data system. Audit trail field for data lineage tracking.',
    `custody_confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the receiving party confirmed custody of the transferred material.',
    `destination_reference_code` STRING COMMENT 'Identifier of the specific destination entity (experiment ID, assay run ID, work order number, instrument serial number, or storage location code).',
    `destination_type` STRING COMMENT 'Category of destination receiving the reagent: experiment, assay run, production work order, instrument, storage location, or waste disposal.. Valid values are `experiment|assay_run|production_order|instrument|storage_location|waste`',
    `dispensing_notes` STRING COMMENT 'Free-text notes or comments recorded by the operator during the dispensing event. May include observations, deviations, or special handling instructions.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the dispensing, transfer, or return event occurred. Critical for chain-of-custody documentation and GMP audit trails.',
    `expiry_date` DATE COMMENT 'Expiration date of the reagent lot at the time of dispensing. Used to enforce FEFO (First Expired First Out) inventory policies and prevent use of expired materials.',
    `hazard_classification` STRING COMMENT 'Safety Data Sheet (SDS) hazard classification for the reagent (e.g., flammable, corrosive, toxic, biohazard). Required for safe handling and disposal.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this dispensing event record was last updated. Audit trail field for change tracking and compliance.',
    `material_document_number` STRING COMMENT 'SAP Material Management (MM) document number generated for the goods movement transaction. Links dispensing event to ERP inventory posting.',
    `movement_type` STRING COMMENT 'Classification of the material movement event: dispense to experiment/assay, internal transfer between storage locations, return to stock, inter-site shipment, instrument consumption, or quarantine relocation.. Valid values are `dispense|transfer|return|inter_site_shipment|consumption|quarantine_move`',
    `movement_type_code` STRING COMMENT 'SAP MM movement type code (e.g., 261 for goods issue to production, 311 for transfer posting). Standardizes inventory transaction classification.',
    `qc_status` STRING COMMENT 'Quality control release status of the reagent lot at the time of dispensing: released for use, quarantined pending investigation, rejected, pending QC approval, or expired.. Valid values are `released|quarantine|rejected|pending|expired`',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'Amount of reagent material moved in this event. Precision supports micro-volume measurements common in genomics workflows.',
    `regulatory_status` STRING COMMENT 'Regulatory classification of the reagent: Research Use Only (RUO), In Vitro Diagnostic (IVD), GMP-released for commercial production, or clinical trial material.. Valid values are `ruo|ivd|gmp_released|clinical_trial`',
    `remaining_lot_quantity` DECIMAL(18,2) COMMENT 'Quantity of reagent remaining in the source lot after this dispensing event. Supports real-time inventory tracking and reorder triggers.',
    `sds_reference_number` STRING COMMENT 'Reference number of the Safety Data Sheet document for the reagent. Required for regulatory compliance and worker safety.',
    `storage_condition_code` STRING COMMENT 'Required storage condition for the reagent: ambient (room temperature), refrigerated (2-8°C), frozen (-20°C), ultra-low (-80°C), or cryogenic (liquid nitrogen).. Valid values are `ambient|refrigerated|frozen|ultra_low|cryogenic`',
    `system_source` STRING COMMENT 'Source system that generated the dispensing event record: LIMS (Laboratory Information Management System), ERP (Enterprise Resource Planning), MES (Manufacturing Execution System), manual entry, or instrument integration.. Valid values are `lims|erp|mes|manual|instrument`',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature recorded during the dispensing or transfer event, measured in degrees Celsius. Used to verify cold-chain compliance.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature recorded during the dispensing or transfer event, measured in degrees Celsius. Used to verify cold-chain compliance.',
    `transfer_reason` STRING COMMENT 'Business justification for the material movement: lab request, cold-chain relocation, quarantine move, expiry management, facility consolidation, or production demand.',
    `unit_of_measure` STRING COMMENT 'Unit in which the dispensed quantity is measured (milliliters, microliters, grams, milligrams, micrograms, units, reactions, tests). [ENUM-REF-CANDIDATE: ml|ul|l|g|mg|ug|units|reactions|tests — 9 candidates stripped; promote to reference product]',
    `work_order_number` STRING COMMENT 'Manufacturing or production work order number to which the reagent was dispensed, if applicable. Links reagent usage to production batch records.',
    CONSTRAINT pk_dispensing_event PRIMARY KEY(`dispensing_event_id`)
) COMMENT 'Transactional record of each reagent material movement — including dispensing to experiments/assays, consumption by instruments, internal transfers between storage locations or facilities, and returns to stock. Captures event timestamp, movement type (dispense, transfer, return, inter-site shipment), operator ID, lot number, quantity moved, unit of measure, source location, destination (experiment, assay run, production work order, instrument, or storage location), transfer reason (lab request, cold-chain relocation, quarantine move), remaining lot quantity post-event, cold-chain compliance flag, and chain-of-custody confirmation. Supports full LOT traceability from receipt through consumption or relocation, GMP usage logs, inter-site transfer documentation, and LIMS-driven reagent tracking.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` (
    `qc_specification_id` BIGINT COMMENT 'Unique identifier for the QC specification record. Primary key.',
    `catalog_id` BIGINT COMMENT 'Reference to the reagent catalog item to which this QC specification applies. Links specification to specific reagent SKU.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer-specific QC specifications are standard in contract manufacturing and custom reagent development. Pharma customers require tailored acceptance criteria. Tracks which specifications apply to c',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: QC specifications for sequencing reagents (e.g., mapping rate ≥95%, on-target rate ≥80%) are genome-build-dependent. Validation studies and acceptance criteria must reference the specific assembly use',
    `validation_study_id` BIGINT COMMENT 'Reference to the analytical method validation study that established the scientific basis for this specification. Links to validation protocol and report documentation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: QC testing specifications are owned and maintained by quality assurance cost centers. Required for quality cost allocation, method validation cost tracking, and SOX control documentation linking testi',
    `employee_id` BIGINT COMMENT 'Reference to the Quality Assurance (QA) manager or authorized personnel who approved this specification version. Supports regulatory audit trail.',
    `process_validation_id` BIGINT COMMENT 'Foreign key linking to manufacturing.process_validation. Business justification: Process validation studies validate that manufacturing processes consistently meet QC specifications. Real-world validation protocols explicitly reference the specifications being validated. This is a',
    `quality_rule_id` BIGINT COMMENT 'Foreign key linking to data.quality_rule. Business justification: QC specifications are implemented as automated quality rules for continuous monitoring. Real business need: automated QC enforcement in manufacturing and real-time deviation detection per GMP requirem',
    `research_protocol_id` BIGINT COMMENT 'Foreign key linking to research.protocol. Business justification: QC specifications are derived from validated analytical protocols. Direct dependency for regulatory compliance—specifications must reference the protocol that defines the test method. Critical for met',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Quality specifications define acceptance criteria at the SKU level for manufacturing release. Required for QC testing protocols, batch disposition decisions, and specification change control. Each SKU',
    `variant_database_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database. Business justification: QC specifications for variant calling reagents cite concordance with specific variant databases (e.g., "≥98% concordance with dbSNP build 155" or "detects 100% of ClinVar pathogenic variants"). Valida',
    `acceptance_criteria_type` STRING COMMENT 'Format of the acceptance criteria: numeric_range (min-max bounds), minimum_threshold (greater than or equal to), maximum_threshold (less than or equal to), pass_fail (binary result), qualitative (descriptive evaluation).. Valid values are `numeric_range|minimum_threshold|maximum_threshold|pass_fail|qualitative`',
    `analytical_parameter` STRING COMMENT 'Specific quality attribute being measured (e.g., Purity, Concentration, pH, Endotoxin Level, Enzyme Activity, Amplification Efficiency).',
    `applicable_product_grade` STRING COMMENT 'Regulatory grade of reagent to which this specification applies: RUO (Research Use Only), IVD (In Vitro Diagnostic), GMP (Good Manufacturing Practice), research (basic research), clinical (clinical trial use). Specifications may differ by grade.. Valid values are `RUO|IVD|GMP|research|clinical`',
    `approval_date` DATE COMMENT 'Date when the QC specification was formally approved by Quality Assurance (QA) for use in lot release testing.',
    `change_control_reference` STRING COMMENT 'Document control number of the change control record authorizing this specification version (e.g., CC-2024-0123). Links specification changes to formal change management process.. Valid values are `^CC-[A-Z0-9-]+$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this QC specification record was first created in the system. Supports audit trail and regulatory compliance.',
    `criticality_level` STRING COMMENT 'Risk-based classification of the specifications impact on product quality and patient safety: critical (directly affects safety/efficacy), major (significant quality impact), minor (cosmetic or documentation).. Valid values are `critical|major|minor`',
    `effective_end_date` DATE COMMENT 'Date when this QC specification version is superseded or retired. Null for currently active specifications.',
    `effective_start_date` DATE COMMENT 'Date when this QC specification version becomes effective and must be applied to reagent lot release testing. Supports regulatory change control.',
    `is_coa_reportable` BOOLEAN COMMENT 'Indicates whether test results for this specification must be included on the Certificate of Analysis (COA) provided to customers. True for customer-facing specifications, false for internal-only tests.',
    `is_stability_indicating` BOOLEAN COMMENT 'Indicates whether this specification is used in stability studies to establish reagent shelf life and storage conditions. True for parameters that degrade over time (e.g., enzyme activity, purity).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this QC specification record. Tracks specification change history.',
    `lower_specification_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for numeric acceptance criteria. Null if not applicable (e.g., pass/fail tests).',
    `out_of_specification_escalation_procedure` STRING COMMENT 'Reference to the procedure or workflow triggered when test results fail this specification (e.g., Initiate OOS investigation per SOP-QA-5678, Quarantine lot and notify QA Manager). Supports deviation management.',
    `pass_fail_criteria_description` STRING COMMENT 'Textual description of acceptance criteria for qualitative or pass/fail tests (e.g., No visible particulates, Amplification curve within 3 Ct of reference, Sterility test shows no growth).',
    `regulatory_standard_reference` STRING COMMENT 'Citation of the regulatory standard or compendial method governing this specification (e.g., USP <85>, EP 2.6.14, FDA Guidance for Industry, ISO 13485:2016 Section 7.5.6).',
    `sample_size_requirement` STRING COMMENT 'Required sample size or sampling plan for the test (e.g., n=3 replicates, AQL 1.5, 10 units per lot). Supports statistical quality control.',
    `specification_code` STRING COMMENT 'Business identifier for the QC specification. Unique alphanumeric code used in quality documentation and Certificate of Analysis (COA) references.. Valid values are `^[A-Z0-9]{4,20}$`',
    `specification_rationale` STRING COMMENT 'Scientific and regulatory justification for the acceptance criteria limits. Documents the basis for specification setting (e.g., Based on method validation data showing 95% confidence interval, Aligned with USP monograph requirements).',
    `specification_status` STRING COMMENT 'Current lifecycle status of the QC specification: draft (in development), under_review (pending approval), approved (authorized for use), active (currently enforced), superseded (replaced by newer version), obsolete (no longer valid).. Valid values are `draft|under_review|approved|active|superseded|obsolete`',
    `specification_type` STRING COMMENT 'Category of QC specification defining the nature of the quality test: identity (confirms correct reagent), purity (contaminant levels), potency (biological activity), sterility (microbial contamination), endotoxin (bacterial toxin levels), functional (performance in assay).. Valid values are `identity|purity|potency|sterility|endotoxin|functional`',
    `specification_version` STRING COMMENT 'Version number of the QC specification following semantic versioning (e.g., 1.0, 2.1, 3.0.1). Supports change control and regulatory traceability.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `target_value` DECIMAL(18,2) COMMENT 'Nominal or target value for the analytical parameter. Represents the ideal measurement outcome within the specification range.',
    `test_frequency` STRING COMMENT 'Required frequency of testing for this specification: per_lot (every manufacturing lot), per_batch (every production batch), periodic (scheduled intervals), skip_lot (reduced testing per approved plan), continuous (in-process monitoring).. Valid values are `per_lot|per_batch|periodic|skip_lot|continuous`',
    `test_method_name` STRING COMMENT 'Name of the analytical test method used to evaluate the reagent (e.g., HPLC Purity Analysis, Endotoxin LAL Assay, qPCR Functional Performance).',
    `test_method_sop_reference` STRING COMMENT 'Document control number of the Standard Operating Procedure (SOP) defining the test method execution (e.g., SOP-QC-1234). Supports method validation and audit traceability.. Valid values are `^SOP-[A-Z0-9-]+$`',
    `unit_of_measure` STRING COMMENT 'Unit of measurement for the analytical parameter (e.g., mg/mL, EU/mL, %, U/mg, Ct value, copies/µL). Null for qualitative or pass/fail tests.',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for numeric acceptance criteria. Null if not applicable (e.g., pass/fail tests).',
    CONSTRAINT pk_qc_specification PRIMARY KEY(`qc_specification_id`)
) COMMENT 'Reference master defining QC acceptance specifications for each reagent catalog item — including test method name, analytical parameter, specification type (identity, purity, potency, sterility, endotoxin, functional), acceptance criteria (numeric limits, pass/fail criteria), unit of measure, applicable regulatory standard, and specification version. Drives automated pass/fail evaluation of QC test results and supports method validation documentation.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` (
    `kit_component_id` BIGINT COMMENT 'Unique identifier for the kit component association record. Primary key for the kit_component entity.',
    `gene_annotation_track_id` BIGINT COMMENT 'Foreign key linking to reference.gene_annotation_track. Business justification: Gene panel kits and targeted sequencing components are designed against specific annotation releases (GENCODE, RefSeq versions). Component probe/primer coordinates, target gene lists, and clinical cla',
    `catalog_id` BIGINT COMMENT 'Reference to the individual component reagent catalog item. Links to the specific reagent, enzyme, buffer, adapter, or consumable that is part of the kit Bill of Materials (BOM).',
    `parent_kit_catalog_id` BIGINT COMMENT 'Reference to the parent multi-component reagent kit catalog item. Links to the master kit product definition in the reagent catalog.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Kit parent must reference the commercial catalog item for BOM costing, pricing rollup, and product configuration management. Enables multi-level product structures and kit-to-catalog synchronization f',
    `primary_kit_substitute_component_catalog_id` BIGINT COMMENT 'Reference to an approved substitute component catalog item. Used when the primary component is unavailable or discontinued. Substitution must be validated and documented per Good Manufacturing Practice (GMP) change control procedures.',
    `validation_study_id` BIGINT COMMENT 'Reference to the validation study that qualified this component for inclusion in the kit. Links to Research and Development (R&D) documentation, analytical validation reports, and regulatory submission packages.',
    `assembly_instruction` STRING COMMENT 'Detailed instructions for incorporating this component into the kit during manufacturing assembly. Includes handling precautions, placement requirements, and Standard Operating Procedure (SOP) references for Good Manufacturing Practice (GMP) compliance.',
    `change_control_number` STRING COMMENT 'Reference to the Good Manufacturing Practice (GMP) change control record that authorized the addition, modification, or removal of this component from the kit Bill of Materials (BOM). Required for regulatory audit trails and quality system compliance.',
    `component_cost_usd` DECIMAL(18,2) COMMENT 'Standard cost of the component in United States Dollars (USD). Used for kit Cost of Goods Sold (COGS) calculation, pricing analysis, and Profit and Loss (P&L) reporting. Confidential business data.',
    `component_quantity` DECIMAL(18,2) COMMENT 'Quantity of the component included in one unit of the parent kit. Used for kit assembly, inventory consumption calculations, and Good Manufacturing Practice (GMP) batch record reconciliation.',
    `component_role` STRING COMMENT 'Functional role of the component within the kit workflow. Defines the biochemical or operational purpose of the component in library preparation, Polymerase Chain Reaction (PCR), or sequencing protocols.. Valid values are `enzyme|buffer|adapter|index_plate|master_mix|reagent`',
    `component_sequence` STRING COMMENT 'Ordinal position of this component within the kit Bill of Materials (BOM). Used for assembly instructions, kit documentation, and Certificate of Analysis (COA) reporting.',
    `component_stability_duration_days` STRING COMMENT 'Number of days the component remains stable within the kit under specified storage conditions. Used to calculate kit expiry date based on the shortest-lived component. Critical for In Vitro Diagnostic (IVD) and Research Use Only (RUO) product labeling.',
    `component_storage_requirement` STRING COMMENT 'Storage temperature requirement for this component within the kit. Drives warehouse zoning, kit assembly logistics, and shipping validation. Must align with the most restrictive component requirement for the overall kit.. Valid values are `room_temperature|refrigerated_2_8c|frozen_minus_20c|frozen_minus_80c|dry_ice|liquid_nitrogen`',
    `component_unit_of_measure` STRING COMMENT 'Unit of measure for the component quantity. Aligns with reagent catalog specifications and manufacturing Bill of Materials (BOM) standards. [ENUM-REF-CANDIDATE: ml|ul|mg|ug|units|reactions|wells|tubes — 8 candidates stripped; promote to reference product]',
    `component_version` STRING COMMENT 'Version identifier for the component reagent. Tracks formulation changes, protocol updates, and component substitutions over the kit lifecycle. Critical for Lot (LOT) traceability and regulatory submissions.',
    `created_by_user` STRING COMMENT 'User identifier of the person who created this kit component association record. Used for audit trails, accountability, and Good Practice (GxP) compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this kit component association record was first created in the system. Used for audit trails, data lineage tracking, and Good Practice (GxP) compliance.',
    `effective_end_date` DATE COMMENT 'Date when this component association was discontinued or superseded in the kit Bill of Materials (BOM). Null for currently active components. Used for version control and regulatory change documentation.',
    `effective_start_date` DATE COMMENT 'Date when this component association became active in the kit Bill of Materials (BOM). Used for version control, change management, and historical traceability of kit composition changes.',
    `hazard_classification` STRING COMMENT 'Safety Data Sheet (SDS) hazard classification for this component. Drives kit labeling, shipping requirements, workplace safety protocols, and regulatory compliance with Occupational Safety and Health Administration (OSHA) and Globally Harmonized System (GHS) standards.. Valid values are `non_hazardous|flammable|corrosive|toxic|biohazard|oxidizer`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this kit component association is currently active and in use. False for historical or discontinued component associations. Used for filtering current Bill of Materials (BOM) configurations.',
    `is_critical_component` BOOLEAN COMMENT 'Indicates whether this component is critical to kit performance and requires enhanced Quality Control (QC) testing, Certificate of Analysis (COA) documentation, and Lot (LOT) traceability. True for components that directly impact assay performance or regulatory compliance.',
    `is_substitutable` BOOLEAN COMMENT 'Indicates whether this component can be substituted with an alternative component during kit assembly without requiring protocol changes or revalidation. Used for supply chain flexibility and manufacturing continuity planning.',
    `lot_traceability_required` BOOLEAN COMMENT 'Indicates whether individual Lot (LOT) numbers for this component must be tracked and recorded for each assembled kit. True for critical components requiring full traceability per Good Manufacturing Practice (GMP) and In Vitro Diagnostic (IVD) regulations.',
    `maximum_quantity` DECIMAL(18,2) COMMENT 'Maximum acceptable quantity of the component for kit release. Used for Quality Control (QC) inspection and Good Manufacturing Practice (GMP) batch record verification. Values above this threshold trigger non-conformance investigations.',
    `minimum_quantity` DECIMAL(18,2) COMMENT 'Minimum acceptable quantity of the component for kit release. Used for Quality Control (QC) inspection and Good Manufacturing Practice (GMP) batch record verification. Values below this threshold trigger non-conformance investigations.',
    `modified_by_user` STRING COMMENT 'User identifier of the person who last modified this kit component association record. Used for audit trails, accountability, and Good Practice (GxP) compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this kit component association record was last modified. Used for audit trails, change tracking, and Good Practice (GxP) compliance.',
    `regulatory_status` STRING COMMENT 'Regulatory approval status of this component within the kit for In Vitro Diagnostic (IVD) or Research Use Only (RUO) use. Approved components have passed validation studies and are cleared for commercial distribution. Pending components are under review. Discontinued components are being phased out. Restricted components have geographic or use limitations.. Valid values are `approved|pending|discontinued|restricted`',
    `requires_separate_shipment` BOOLEAN COMMENT 'Indicates whether this component must be shipped separately from the main kit due to storage incompatibility, hazardous material regulations, or customs restrictions. True for components requiring dry ice, liquid nitrogen, or dangerous goods handling.',
    CONSTRAINT pk_kit_component PRIMARY KEY(`kit_component_id`)
) COMMENT 'Association entity defining the bill-of-materials (BOM) composition of multi-component reagent kits — capturing the parent kit catalog item, each component reagent catalog item, component quantity, unit of measure, component role (e.g., enzyme, buffer, adapter, index plate), and component version. Supports kit assembly work orders, component substitution management, and traceability of individual component lots within assembled kits. Enables downstream LOT-level traceability for each kit component.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` (
    `disposal_record_id` BIGINT COMMENT 'Unique identifier for the reagent disposal record. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Disposal of regulated reagents (especially IVD products) must comply with approval conditions and jurisdictional waste regulations. Links disposal to the approval governing the products regulatory st',
    `catalog_id` BIGINT COMMENT 'Reference to the master reagent or consumable product being disposed.',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Disposal may result from quality deviations (OOS, contamination, handling errors). Linking disposal to originating deviation provides complete audit trail for regulatory inspections and CAPA effective',
    `disposal_authorization_id` BIGINT COMMENT 'The authorization or approval identifier issued by quality assurance or management permitting the disposal action.. Valid values are `^AUTH-[A-Z0-9]{8,15}$`',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Disposal events charge to cost centers for waste management cost tracking, environmental compliance reporting, and variance analysis of expired/failed inventory. Enables financial analysis of disposal',
    `employee_id` BIGINT COMMENT 'Identifier of the operator or technician who executed the disposal activity.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: GMP-compliant disposal tracking requires linking disposal records to lot master. Currently disposal_record has lot_number as STRING but no FK to lot table. Adding lot_id enables regulatory traceabilit',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: Disposal often results from NCRs (failed QC, expired, damaged). Linking disposal to originating NCR provides complete audit trail for regulatory inspections and disposition justification in GMP enviro',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Research-phase reagents disposed after project completion require project traceability for cost accounting, grant reporting, and compliance documentation. Enables project closeout reconciliation and w',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Disposal records track waste by SKU for cost accounting (scrap variance), environmental compliance reporting, and manufacturing yield analysis. Required for COGS adjustment and sustainability metrics ',
    `authorized_by` STRING COMMENT 'Name or identifier of the quality assurance or management personnel who authorized the disposal.',
    `coa_reference` STRING COMMENT 'Reference identifier to the Certificate of Analysis for the disposed lot, linking disposal to original quality documentation.. Valid values are `^COA-[A-Z0-9]{8,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposal record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the disposal cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `disposal_cost` DECIMAL(18,2) COMMENT 'The cost incurred for the disposal activity, including vendor fees and internal labor.',
    `disposal_date` DATE COMMENT 'The date on which the reagent disposal was executed.',
    `disposal_location` STRING COMMENT 'The physical location or facility where the disposal was performed (e.g., warehouse, disposal room, external vendor site).',
    `disposal_method` STRING COMMENT 'The method used to dispose of the reagent (e.g., incineration, chemical neutralization, biohazard waste, autoclave sterilization).. Valid values are `incineration|chemical_neutralization|biohazard_waste|autoclave|landfill|recycling`',
    `disposal_notes` STRING COMMENT 'Free-text field for additional comments, observations, or special instructions related to the disposal activity.',
    `disposal_reason` STRING COMMENT 'The business reason for disposal (e.g., expired, failed quality control, product recall, damage, contamination, obsolescence).. Valid values are `expired|failed_qc|recalled|damaged|contaminated|obsolete`',
    `disposal_status` STRING COMMENT 'Current lifecycle status of the disposal record (e.g., pending approval, approved, completed, cancelled).. Valid values are `pending|approved|completed|cancelled`',
    `disposal_timestamp` TIMESTAMP COMMENT 'Precise date and time when the disposal activity was completed, supporting audit trail requirements.',
    `disposal_vendor` STRING COMMENT 'Name of the external waste disposal vendor or contractor, if applicable.',
    `environmental_permit_number` STRING COMMENT 'The environmental permit or license number under which the disposal is authorized, if required by local regulations.. Valid values are `^ENV-[A-Z0-9]{8,15}$`',
    `expiry_date` DATE COMMENT 'The expiration date of the reagent lot being disposed, if disposal reason is expiration.',
    `gmp_release_status` STRING COMMENT 'The GMP release status of the lot at the time of disposal (e.g., released, quarantined, rejected, blocked).. Valid values are `released|quarantined|rejected|blocked`',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified the disposal record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposal record was last modified.',
    `qc_failure_code` STRING COMMENT 'The quality control failure code or defect classification if disposal is due to failed QC testing.. Valid values are `^QC-[A-Z0-9]{4,10}$`',
    `quantity_disposed` DECIMAL(18,2) COMMENT 'The numeric quantity of reagent or consumable disposed in this transaction.',
    `recall_number` STRING COMMENT 'The recall identifier if the disposal is part of a product recall action.. Valid values are `^RCL-[A-Z0-9]{8,15}$`',
    `regulatory_inspection_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this disposal record is subject to regulatory inspection or audit review.',
    `sds_reference` STRING COMMENT 'Reference identifier to the Safety Data Sheet document for the reagent, ensuring proper handling and disposal procedures are followed.. Valid values are `^SDS-[A-Z0-9]{6,15}$`',
    `storage_location_prior` STRING COMMENT 'The storage location or bin where the reagent was held immediately before disposal (e.g., quarantine area, expired goods zone).',
    `unit_of_measure` STRING COMMENT 'The unit in which the disposed quantity is measured (e.g., milliliters, grams, units, vials). [ENUM-REF-CANDIDATE: mL|L|g|kg|mg|units|vials|plates — 8 candidates stripped; promote to reference product]',
    `waste_classification` STRING COMMENT 'Regulatory classification of the waste material for environmental and safety compliance (e.g., hazardous, biohazardous, non-hazardous, chemical, radioactive).. Valid values are `hazardous|biohazardous|non_hazardous|chemical|radioactive|sharps`',
    `waste_manifest_number` STRING COMMENT 'The unique identifier for the waste manifest document that tracks the disposal from generation to final treatment or disposal site.. Valid values are `^[A-Z0-9]{8,20}$`',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the disposal record.',
    CONSTRAINT pk_disposal_record PRIMARY KEY(`disposal_record_id`)
) COMMENT 'Transactional record documenting the controlled disposal of expired, failed, or recalled reagent lots — capturing disposal date, lot number, quantity disposed, disposal method (incineration, chemical neutralization, biohazard waste), regulatory waste classification, disposal authorization, operator ID, and waste manifest reference. Supports GMP material disposition, environmental health and safety (EHS) compliance, and regulatory inspection documentation.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` (
    `recall_event_id` BIGINT COMMENT 'Unique identifier for the recall event record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Recalls must identify which customers received affected lots for notification and retrieval. Regulatory requirement (FDA 21 CFR Part 7) for traceability. Supports recall effectiveness checks and custo',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Recalls of research-grade reagents require project impact assessment to determine if active research is affected and whether experiments need repeating. Critical for research continuity planning and r',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Recalls trigger CAPAs for root cause analysis and preventive action. Required for regulatory compliance (FDA, ISO 13485) and continuous improvement. Standard genomics biotech quality management proces',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Eliminates silo - recall_event currently has no FK relationships. Every recall event is initiated for a specific reagent catalog item. Currently recall_event has affected_product_sku and affected_prod',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Recalls are issued against catalog products for customer notification and regulatory reporting (FDA/EMA). Required to identify affected SKUs, customer shipments, and replacement product offerings. Fou',
    `field_safety_action_id` BIGINT COMMENT 'Foreign key linking to regulatory.field_safety_action. Business justification: Recalls generate field safety actions (FSN, FSCA) that document customer notification, product recovery, and effectiveness checks. Direct operational link required for CAPA tracking, regulatory report',
    `internal_investigation_id` BIGINT COMMENT 'Reference identifier linking this recall event to the internal quality investigation or non-conformance report that triggered the recall.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Recall investigations and remediation costs are charged to responsible cost centers. Critical for financial impact analysis, insurance claims processing, quality cost reporting, and management account',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Recall events require internal employee ownership for CAPA execution, regulatory reporting (FDA/EMA), and customer communication. Links to employee record for contact information, organizational accou',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Product recalls often trigger mandatory regulatory submissions (field safety corrective actions, adverse event reports to FDA/notified bodies). Links recall event to the submission documenting regulat',
    `adverse_event_count` STRING COMMENT 'Number of reported adverse events (injuries, incorrect results, patient harm) associated with the recalled product.',
    `affected_lot_numbers` STRING COMMENT 'Comma-separated list of reagent lot numbers affected by this recall event. Critical for traceability and scope determination.',
    `affected_product_sku` STRING COMMENT 'Stock Keeping Unit identifier of the reagent product affected by the recall. Links to the product catalog for detailed product information.',
    `affected_unit_count` STRING COMMENT 'Total number of product units (kits, vials, flow cells, etc.) affected by the recall across all lots and distribution channels.',
    `capa_completion_date` DATE COMMENT 'Date when all corrective and preventive actions were verified as complete and effective. Null if CAPA is still in progress.',
    `completion_date` DATE COMMENT 'Date when all recall activities were completed, including retrieval, disposition, and customer notification. Null if recall is still ongoing.',
    `corrective_action_plan` STRING COMMENT 'Detailed description of corrective and preventive actions (CAPA) implemented to address the root cause and prevent recurrence of the issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall event record was first created in the system.',
    `customer_complaint_count` STRING COMMENT 'Number of customer complaints received related to the defect or issue that led to the recall event.',
    `customer_notification_status` STRING COMMENT 'Status of customer notification activities: not_started (notifications pending), in_progress (notifications being sent), or completed (all customers notified).. Valid values are `not_started|in_progress|completed`',
    `disposition_method` STRING COMMENT 'Method used to dispose of retrieved recalled products: destruction (incineration/disposal), rework (repair/reprocess), return_to_vendor, or quarantine (hold for investigation).. Valid values are `destruction|rework|return_to_vendor|quarantine`',
    `distribution_scope` STRING COMMENT 'Geographic scope of product distribution affected by the recall: internal_only (internal labs), domestic (within country), international (multiple countries), or global (worldwide distribution).. Valid values are `internal_only|domestic|international|global`',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated total financial impact of the recall event in USD, including product replacement costs, retrieval logistics, customer credits, and regulatory penalties.',
    `health_hazard_evaluation` STRING COMMENT 'Assessment of the potential health risk posed by the defective product, including probability and severity of adverse events. Used to determine recall classification.',
    `initiation_date` DATE COMMENT 'Date when the recall event was officially initiated and announced to stakeholders.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall event record was last updated or modified.',
    `modified_by_user` STRING COMMENT 'User identifier or username of the person who last modified this recall event record. Supports audit trail and accountability.',
    `notification_date` DATE COMMENT 'Date when initial customer notifications were sent regarding the recall event.',
    `notification_method` STRING COMMENT 'Primary method used to notify affected customers and stakeholders about the recall event.. Valid values are `email|phone|letter|press_release|website|multiple`',
    `press_release_date` DATE COMMENT 'Date when the public press release was issued. Null if no press release was issued.',
    `press_release_issued` BOOLEAN COMMENT 'Boolean flag indicating whether a public press release was issued for this recall event. True if press release was issued, False otherwise.',
    `recall_class` STRING COMMENT 'FDA recall classification indicating the severity of the health hazard: Class I (serious injury or death), Class II (temporary or reversible adverse health consequences), Class III (unlikely to cause adverse health consequences).. Valid values are `Class I|Class II|Class III`',
    `recall_effectiveness_check_date` DATE COMMENT 'Date when the recall effectiveness check was conducted to verify that the recall achieved its intended purpose and all affected products were retrieved.',
    `recall_effectiveness_result` STRING COMMENT 'Result of the recall effectiveness check: effective (recall goals met), partially_effective (some goals met), ineffective (recall goals not met), or pending (check not yet completed).. Valid values are `effective|partially_effective|ineffective|pending`',
    `recall_number` STRING COMMENT 'Externally-known unique recall identifier assigned by the organization or regulatory authority for tracking and reference purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `recall_status` STRING COMMENT 'Current lifecycle status of the recall event: initiated (recall announced), ongoing (retrieval in progress), completed (all actions finished), terminated (recall stopped), or closed (regulatory closure achieved).. Valid values are `initiated|ongoing|completed|terminated|closed`',
    `recall_type` STRING COMMENT 'Type of recall action: voluntary (initiated by manufacturer), mandatory (required by regulatory authority), field correction (on-site correction without removal), or market withdrawal (removal for non-safety reasons).. Valid values are `voluntary|mandatory|field_correction|market_withdrawal`',
    `regulatory_authority` STRING COMMENT 'Primary regulatory authority overseeing the recall: FDA (United States), EMA (European Union), MHRA (United Kingdom), TGA (Australia), Health Canada, or PMDA (Japan).. Valid values are `FDA|EMA|MHRA|TGA|Health_Canada|PMDA`',
    `regulatory_report_reference` STRING COMMENT 'Reference number or identifier for the regulatory report submitted to authorities (e.g., FDA MedWatch report number, IVDR vigilance report ID).',
    `regulatory_submission_date` DATE COMMENT 'Date when the recall event was officially reported to the regulatory authority.',
    `retrieval_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of affected units successfully retrieved, calculated as (units_retrieved / affected_unit_count) * 100. Key performance indicator for recall effectiveness.',
    `root_cause_summary` STRING COMMENT 'Detailed summary of the root cause analysis findings that led to the recall, including manufacturing defects, contamination, labeling errors, or quality control failures.',
    `units_retrieved` STRING COMMENT 'Number of affected product units successfully retrieved from customers and internal inventory as of the current status update.',
    CONSTRAINT pk_recall_event PRIMARY KEY(`recall_event_id`)
) COMMENT 'Transactional record managing reagent lot recall or field correction events — capturing recall initiation date, recall class (I/II/III per FDA), affected lot numbers, root cause summary, scope of distribution (internal labs, external customers), notification status, affected unit count, retrieval status, and regulatory reporting reference (FDA MedWatch, IVDR vigilance). Supports post-market surveillance, regulatory reporting obligations, and customer notification workflows.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` (
    `inventory_transaction_id` BIGINT COMMENT 'Unique identifier for the inventory transaction record. Primary key for the inventory transaction entity.',
    `asset_id` BIGINT COMMENT 'Sequencing instrument, array scanner, or laboratory equipment that consumed the reagent. Critical for tracking flow cell usage, library preparation kit consumption, and instrument-specific reagent utilization.',
    `catalog_id` BIGINT COMMENT 'Reference to the reagent catalog item involved in this transaction. Links to the master reagent definition including product specifications and regulatory classification.',
    `storage_location_id` BIGINT COMMENT 'Storage location to which the reagent was moved. Null for goods issue or consumption transactions where material leaves inventory. References the storage location master data including facility, room, and environmental controls.',
    `employee_id` BIGINT COMMENT 'User or employee who executed or authorized the inventory transaction. Critical for accountability, audit trails, and Good Manufacturing Practice (GMP) compliance.',
    `experiment_id` BIGINT COMMENT 'Unique identifier for the research experiment or assay run that consumed the reagent. Enables tracking of reagent usage in Research Use Only (RUO) and Laboratory Developed Test (LDT) workflows.',
    `batch_record_id` BIGINT COMMENT 'Batch record identifier for Good Manufacturing Practice (GMP) regulated manufacturing operations. Links reagent consumption to specific production batches for regulatory compliance and traceability.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Inventory movements trigger general ledger postings for inventory valuation changes, COGS recognition, and financial statement accuracy. Fundamental accounting control linking physical inventory trans',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Every inventory movement (goods receipt, transfer, consumption, adjustment) must be traceable to the specific lot being moved. Currently inventory_transaction has lot_number as STRING but no FK to lot',
    `primary_inventory_storage_location_id` BIGINT COMMENT 'Storage location from which the reagent was moved. Null for goods receipt transactions where material enters inventory from external sources. References the storage location master data including facility, room, and environmental controls.',
    `reversed_transaction_inventory_transaction_id` BIGINT COMMENT 'Reference to the original inventory transaction that this record reverses or cancels. Null for original transactions. Populated for reversal entries to maintain audit trail.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: All inventory movements (receipts, issues, transfers, adjustments) are recorded against SKUs. Foundation of perpetual inventory, COGS calculation, and inventory reconciliation in genomics ERP systems.',
    `supplier_id` BIGINT COMMENT 'Vendor or supplier from whom the reagent was received. Populated for goods receipt transactions. Used for supplier performance tracking and supply chain analytics.',
    `reversal_inventory_transaction_id` BIGINT COMMENT 'Self-referencing FK on inventory_transaction (reversal_inventory_transaction_id)',
    `coa_reference_number` STRING COMMENT 'Certificate of Analysis (COA) document number associated with the lot involved in this transaction. Provides traceability to quality test results and specifications compliance.',
    `cold_chain_compliant_flag` BOOLEAN COMMENT 'Indicates whether the inventory transaction maintained required temperature controls throughout the movement. True indicates temperature was maintained within specification. False indicates potential temperature excursion requiring investigation.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the inventory transaction is charged. Used for internal cost allocation and departmental expense tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory transaction record was first created in the system. Audit field for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction value, such as USD, EUR, or GBP. Supports multi-currency inventory valuation for global operations.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Date on the source document that triggered this inventory transaction, such as the date on a goods receipt note or transfer order.',
    `expiry_date` DATE COMMENT 'Expiration date of the reagent lot at the time of transaction. Critical for First Expired First Out (FEFO) inventory management and preventing use of expired materials in Good Manufacturing Practice (GMP) environments.',
    `gmp_release_status` STRING COMMENT 'Quality control release status of the lot at the time of transaction. Released indicates Quality Assurance (QA) approved for use. Quarantine indicates hold pending quality testing. Rejected indicates failed Quality Control (QC) and restricted from use. Pending QC indicates testing in progress. Conditional release indicates approved for specific limited use cases.. Valid values are `released|quarantine|rejected|pending_qc|conditional_release`',
    `internal_order_number` STRING COMMENT 'Internal order or project number for cost tracking purposes. Used when reagent consumption needs to be allocated to specific research projects, validation studies, or manufacturing campaigns.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this inventory transaction record. Audit field for accountability and compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory transaction record was last modified. Audit field for change tracking and data quality monitoring.',
    `movement_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the inventory movement, such as production consumption, quality control testing, research and development (R&D) use, expired material disposal, or inventory adjustment.',
    `posting_date` DATE COMMENT 'Accounting date on which the inventory transaction is posted to the financial ledger. May differ from transaction timestamp for period-end adjustments or backdated corrections.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with goods receipt transactions. Links inventory receipt to procurement process for three-way matching and accounts payable processing.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of reagent moved in this transaction. Positive values represent increases to destination location. Negative values represent decreases from source location. Precision supports fractional units for liquid reagents and consumables.',
    `reference_document_line_item` STRING COMMENT 'Line item number within the reference document that corresponds to this inventory transaction. Used when a single document contains multiple material movements.',
    `reference_document_number` STRING COMMENT 'Document number of the source transaction that triggered this inventory movement, such as purchase order number, work order number, or transfer order number. Provides audit trail to originating business event.',
    `reference_document_type` STRING COMMENT 'Type of source document that triggered or authorized this inventory transaction. Enables traceability back to originating business process. [ENUM-REF-CANDIDATE: purchase_order|work_order|transfer_order|sales_order|quality_order|adjustment_document|disposal_record — 7 candidates stripped; promote to reference product]',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this transaction is a reversal or cancellation of a previous inventory movement. True indicates this is a correcting entry. False indicates this is an original transaction.',
    `sds_reference_number` STRING COMMENT 'Safety Data Sheet (SDS) document number for the reagent. Required for hazardous material handling, storage compliance, and environmental health and safety (EHS) management.',
    `system_source` STRING COMMENT 'Source system or application that originated the inventory transaction record, such as SAP, LIMS, or warehouse management system. Used for data lineage and integration troubleshooting.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature in degrees Celsius recorded during the inventory transaction or transfer. Used for cold chain monitoring and temperature-sensitive reagent quality assurance.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature in degrees Celsius recorded during the inventory transaction or transfer. Used for cold chain monitoring and temperature-sensitive reagent quality assurance.',
    `total_transaction_value` DECIMAL(18,2) COMMENT 'Total financial value of the inventory transaction calculated as quantity multiplied by unit cost. Used for financial reporting, inventory valuation, and cost accounting.',
    `transaction_notes` STRING COMMENT 'Free-text notes or comments providing additional context about the inventory transaction, such as special handling instructions, deviation explanations, or operational observations.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number or document number assigned to this inventory movement event. Used for traceability and audit purposes.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the inventory transaction was executed in the operational system. Represents the actual business event time of the inventory movement.',
    `transaction_type` STRING COMMENT 'Classification of the inventory movement type. Goods receipt represents incoming stock from suppliers or manufacturing. Goods issue represents outbound movements. Transfer posting represents internal location changes. Consumption represents usage in experiments or production. Adjustment represents inventory corrections. Return represents material returned to stock. Disposal represents waste or expired material removal. [ENUM-REF-CANDIDATE: goods_receipt|goods_issue|transfer_posting|consumption|adjustment|return|disposal — 7 candidates stripped; promote to reference product]',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of measure for the reagent at the time of transaction. Used for inventory valuation and Cost of Goods Sold (COGS) calculation. May represent standard cost, moving average price, or actual purchase price depending on valuation method.',
    `unit_of_measure` STRING COMMENT 'Unit in which the transaction quantity is expressed, such as milliliters (mL), grams (g), units (EA), kits (KIT), or flow cells (FC). Must align with the reagent catalog base unit or approved alternate units.',
    `created_by` STRING COMMENT 'User identifier or system account that created this inventory transaction record. Audit field for accountability and compliance.',
    CONSTRAINT pk_inventory_transaction PRIMARY KEY(`inventory_transaction_id`)
) COMMENT 'Unified transactional record of all reagent inventory movements — goods receipts from suppliers or manufacturing, internal transfers between storage locations, and consumption events. Captures transaction type, source/destination, quantity, lot reference, and timestamp.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` (
    `tag_assignment_id` BIGINT COMMENT 'Unique identifier for this reagent-tag assignment record. Primary key for the association.',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to the reagent catalog entry being tagged for classification and discovery',
    `catalog_tag_id` BIGINT COMMENT 'Foreign key linking to the controlled vocabulary tag being applied to the reagent',
    `assigned_by` STRING COMMENT 'Username or system identifier of the user or automated process that created this tag assignment. Used for audit and accountability.',
    `assignment_date` DATE COMMENT 'The date when this tag was assigned to the reagent catalog entry. Tracks when the classification was applied.',
    `assignment_notes` STRING COMMENT 'Free-text notes explaining the rationale for this tag assignment, special considerations, or review comments. Used for documentation and knowledge transfer.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this tag assignment. Active assignments are used for search. Pending_review assignments require steward approval. Deprecated assignments are historical.',
    `classification_algorithm` STRING COMMENT 'The algorithm or method used to assign this tag. Examples: manual_curation, ml_classifier_v2, rule_based_engine, ontology_mapping. Enables traceability and quality control.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Numeric confidence score (0.0 to 1.0) indicating the certainty or relevance of this tag assignment. Used for machine-learning-based tagging and quality assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was first created in the system. Used for audit trail.',
    `effective_from_date` DATE COMMENT 'The date from which this tag assignment is effective and should be used for search and discovery. Supports temporal validity of classifications.',
    `effective_to_date` DATE COMMENT 'The date until which this tag assignment is effective. Null for currently active assignments. Supports tag deprecation and reclassification workflows.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last updated. Used for change tracking and synchronization.',
    `review_date` DATE COMMENT 'Date when this tag assignment was reviewed and approved by a data steward. Null for unreviewed assignments.',
    `reviewed_by` STRING COMMENT 'Username of the data steward who reviewed and approved this tag assignment. Null for auto-approved or pending assignments.',
    CONSTRAINT pk_tag_assignment PRIMARY KEY(`tag_assignment_id`)
) COMMENT 'This association product represents the classification assignment between reagent_catalog and catalog_tag. It captures the application of controlled vocabulary tags to reagent products for data catalog discovery, FAIR compliance, and faceted search. Each record links one reagent catalog entry to one catalog tag with metadata about the assignment confidence, algorithm used, and temporal validity of the classification.. Existence Justification: In genomics biotech data governance operations, reagent catalog entries are tagged with multiple controlled vocabulary tags for FAIR-compliant discovery, faceted search, and regulatory classification (e.g., GMP-Critical, Cold-Chain, Hazardous, RUO, IVD). Each tag can be applied to many reagents across different product families. The business actively manages these tag assignments through data stewardship workflows, tracking assignment confidence, classification algorithms, temporal validity, and approval status.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`disposal_authorization` (
    `disposal_authorization_id` BIGINT COMMENT 'Primary key for disposal_authorization',
    `batch_id` BIGINT COMMENT 'Identifier of the reagent batch linked to this disposal authorization.',
    `employee_id` BIGINT COMMENT 'Internal identifier for the person or role that authorized the disposal.',
    `facility_id` BIGINT COMMENT 'Internal identifier for the disposal location.',
    `superseded_disposal_authorization_id` BIGINT COMMENT 'Self-referencing FK on disposal_authorization (superseded_disposal_authorization_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Exact time when the disposal authorization was approved.',
    `authorization_number` STRING COMMENT 'External reference number assigned to the disposal authorization by regulatory or internal systems.',
    `authorization_type` STRING COMMENT 'Category describing the nature of the waste the authorization covers.',
    `authorized_by` STRING COMMENT 'Name of the individual or department that granted the disposal authorization.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the authorization against regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposal authorization record was first created in the system.',
    `disposal_location` STRING COMMENT 'Designated facility or site where the waste will be disposed.',
    `disposal_method` STRING COMMENT 'Method prescribed for the safe disposal of the waste.',
    `document_reference` STRING COMMENT 'Reference number or code for the supporting regulatory document.',
    `effective_date` DATE COMMENT 'Date when the disposal authorization becomes legally effective.',
    `expiration_reason` STRING COMMENT 'Reason why the authorization was terminated or expired.',
    `expiry_date` DATE COMMENT 'Date when the disposal authorization expires or is no longer valid.',
    `hazardous_flag` BOOLEAN COMMENT 'Indicates whether the waste is classified as hazardous.',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance or safety review of the authorization.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions related to the disposal authorization.',
    `regulatory_body` STRING COMMENT 'Governing agency that issued or oversees the disposal authorization.',
    `required_documentation` STRING COMMENT 'Documentation that must accompany the disposal process.',
    `revocation_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorization was revoked, if applicable.',
    `disposal_authorization_status` STRING COMMENT 'Current lifecycle state of the disposal authorization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the disposal authorization record.',
    `waste_category` STRING COMMENT 'Classification of the waste type covered by the authorization.',
    CONSTRAINT pk_disposal_authorization PRIMARY KEY(`disposal_authorization_id`)
) COMMENT 'Master reference table for disposal_authorization. Referenced by disposal_authorization_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`facility` (
    `facility_id` BIGINT COMMENT 'Primary key for facility',
    `parent_facility_id` BIGINT COMMENT 'Self-referencing FK on facility (parent_facility_id)',
    `address_line1` STRING COMMENT 'Primary street address of the facility.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `backup_capacity_kw` DECIMAL(18,2) COMMENT 'Maximum kilowatt capacity of the backup power system.',
    `building_sqft` DECIMAL(18,2) COMMENT 'Total usable square footage of the facility.',
    `capacity_units` STRING COMMENT 'Maximum number of reagent/storage units the facility can hold.',
    `city` STRING COMMENT 'City where the facility is located.',
    `closing_date` DATE COMMENT 'Date the facility ceased operations (null if still active).',
    `facility_code` STRING COMMENT 'Internal alphanumeric code used to reference the facility in systems.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of compliance certifications held by the facility.',
    `contact_email` STRING COMMENT 'Primary email address for facility communications.',
    `contact_phone` STRING COMMENT 'Primary telephone number for facility communications.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the facility resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the facility record was first created.',
    `current_occupancy_units` STRING COMMENT 'Current number of reagent/storage units occupying the facility.',
    `floor_number` STRING COMMENT 'Floor on which the facility is located within a multi‑story building.',
    `gmp_compliant` BOOLEAN COMMENT 'True if the facility meets Good Manufacturing Practice (GMP) standards.',
    `humidity_controlled` BOOLEAN COMMENT 'Indicates whether the facility maintains controlled humidity levels.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the facility (decimal degrees).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the facility (decimal degrees).',
    `maintenance_schedule` STRING COMMENT 'Frequency of routine maintenance activities.',
    `facility_name` STRING COMMENT 'Human‑readable name of the facility (e.g., "Main Sequencing Lab").',
    `next_audit_due` DATE COMMENT 'Scheduled date for the next compliance audit.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or observations.',
    `opening_date` DATE COMMENT 'Date the facility commenced operations.',
    `operational_status` STRING COMMENT 'Current operational condition of the facility.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the facility.',
    `power_backup` BOOLEAN COMMENT 'Indicates whether the facility has an uninterruptible power supply.',
    `responsible_manager_name` STRING COMMENT 'Name of the manager accountable for the facility.',
    `security_level` STRING COMMENT 'Security classification of the facility.',
    `state_province` STRING COMMENT 'State or province of the facility location.',
    `facility_status` STRING COMMENT 'Current operational status of the facility.',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether the facility maintains controlled temperature conditions.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the facility (e.g., "America/New_York").',
    `facility_type` STRING COMMENT 'Category of the facility based on its primary function.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the facility record.',
    `waste_disposal_method` STRING COMMENT 'Method used for hazardous waste disposal at the facility.',
    `zone` STRING COMMENT 'Designated zone or area within the facility (e.g., "Cold Room", "QC Lab").',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master reference table for facility. Referenced by facility_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_primary_superseded_by_coa_id` FOREIGN KEY (`primary_superseded_by_coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ADD CONSTRAINT `fk_reagent_sds_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ADD CONSTRAINT `fk_reagent_storage_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`facility`(`facility_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ADD CONSTRAINT `fk_reagent_storage_location_parent_location_storage_location_id` FOREIGN KEY (`parent_location_storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`sds`(`sds_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ADD CONSTRAINT `fk_reagent_kit_component_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ADD CONSTRAINT `fk_reagent_kit_component_parent_kit_catalog_id` FOREIGN KEY (`parent_kit_catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ADD CONSTRAINT `fk_reagent_kit_component_primary_kit_substitute_component_catalog_id` FOREIGN KEY (`primary_kit_substitute_component_catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ADD CONSTRAINT `fk_reagent_disposal_record_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ADD CONSTRAINT `fk_reagent_disposal_record_disposal_authorization_id` FOREIGN KEY (`disposal_authorization_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`disposal_authorization`(`disposal_authorization_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ADD CONSTRAINT `fk_reagent_disposal_record_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ADD CONSTRAINT `fk_reagent_recall_event_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_primary_inventory_storage_location_id` FOREIGN KEY (`primary_inventory_storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_reversed_transaction_inventory_transaction_id` FOREIGN KEY (`reversed_transaction_inventory_transaction_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`inventory_transaction`(`inventory_transaction_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_reversal_inventory_transaction_id` FOREIGN KEY (`reversal_inventory_transaction_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`inventory_transaction`(`inventory_transaction_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ADD CONSTRAINT `fk_reagent_tag_assignment_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_authorization` ADD CONSTRAINT `fk_reagent_disposal_authorization_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`facility`(`facility_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_authorization` ADD CONSTRAINT `fk_reagent_disposal_authorization_superseded_disposal_authorization_id` FOREIGN KEY (`superseded_disposal_authorization_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`disposal_authorization`(`disposal_authorization_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ADD CONSTRAINT `fk_reagent_facility_parent_facility_id` FOREIGN KEY (`parent_facility_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`facility`(`facility_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`reagent` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `genomics_biotech_ecm`.`reagent` SET TAGS ('dbx_domain' = 'reagent');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `glossary_term_id` SET TAGS ('dbx_business_glossary_term' = 'Glossary Term Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `metadata_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Metadata Schema Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Strategic Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `catalog_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `catalog_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `coa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `compatible_instruments` SET TAGS ('dbx_business_glossary_term' = 'Compatible Instruments');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `concentration` SET TAGS ('dbx_business_glossary_term' = 'Concentration');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `freeze_thaw_cycle_limit` SET TAGS ('dbx_business_glossary_term' = 'Freeze-Thaw Cycle Limit');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `gmp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `intended_application` SET TAGS ('dbx_business_glossary_term' = 'Intended Application');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `introduction_date` SET TAGS ('dbx_business_glossary_term' = 'Introduction Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `light_sensitivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Light Sensitivity Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `purity_specification` SET TAGS ('dbx_business_glossary_term' = 'Purity Specification');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `quality_control_tested_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Tested Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `reagent_category` SET TAGS ('dbx_business_glossary_term' = 'Reagent Category');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `reagent_type` SET TAGS ('dbx_business_glossary_term' = 'Reagent Type');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `reagent_type` SET TAGS ('dbx_value_regex' = 'enzyme|buffer|kit|flow_cell|crispr_component|consumable');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Months)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `sterility_requirement` SET TAGS ('dbx_business_glossary_term' = 'Sterility Requirement');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `sterility_requirement` SET TAGS ('dbx_value_regex' = 'sterile|non_sterile|aseptic');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `storage_humidity_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity Maximum (Percent)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `storage_humidity_min_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Humidity Minimum (Percent)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `storage_temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Maximum (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `storage_temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Minimum (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Approved By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Reserved For Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Lot Disposition');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'available|allocated|consumed|expired|returned|destroyed');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `gmp_release_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Release Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `gmp_release_status` SET TAGS ('dbx_value_regex' = 'quarantine|qc_testing|released|restricted|rejected|disposed');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `internal_coa_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Certificate of Analysis (COA) Reference');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'manufactured|purchased|consignment|sample|rework');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lot Notes');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `qc_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `qc_test_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Test Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `qc_test_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Test Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `qc_test_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|conditional_pass|waived');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `quantity_manufactured` SET TAGS ('dbx_business_glossary_term' = 'Quantity Manufactured');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Reason');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Reason');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `sds_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `sterilization_date` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Method');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_value_regex' = 'not_applicable|autoclave|gamma_irradiation|ethylene_oxide|filtration|chemical');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'room_temperature|refrigerated_2_8c|frozen_minus_20c|frozen_minus_80c|liquid_nitrogen|controlled_ambient');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `supplier_coa_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Certificate of Analysis (COA) Reference');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `supplier_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `supplier_quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quality Grade');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `supplier_quality_grade` SET TAGS ('dbx_value_regex' = 'research_use_only|gmp_grade|clinical_grade|ivd_grade|molecular_biology_grade');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `traceability_code` SET TAGS ('dbx_business_glossary_term' = 'Traceability Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Issued To Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `primary_superseded_by_coa_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Certificate of Analysis (COA) Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `qc_result_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Result Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `acceptance_criteria_summary` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Summary');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `analytical_method_references` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method References');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `coa_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `coa_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|released|superseded|voided');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `customer_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Facing Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `deviations_noted` SET TAGS ('dbx_business_glossary_term' = 'Deviations Noted Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Document Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^COA-[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Document URL');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `gmp_release_authorized` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Release Authorization Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Classification');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `intended_use` SET TAGS ('dbx_value_regex' = 'RUO|IVD|GMP|research|clinical|diagnostic');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Issue Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `issuing_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Issuing Laboratory Name');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `issuing_laboratory_location` SET TAGS ('dbx_business_glossary_term' = 'Issuing Laboratory Location');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `issuing_laboratory_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `issuing_laboratory_location` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Quality Control (QC) Result');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|pending');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempt');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `release_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Release Authorization Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Name');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `specification_document_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Document Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Test Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `test_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Summary');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) ID');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent ID');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `accidental_release_measures` SET TAGS ('dbx_business_glossary_term' = 'Accidental Release Measures');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `composition_description` SET TAGS ('dbx_business_glossary_term' = 'Chemical Composition Description');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `country_of_issue` SET TAGS ('dbx_business_glossary_term' = 'Country of Issue');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `country_of_issue` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `disposal_considerations` SET TAGS ('dbx_business_glossary_term' = 'Disposal Considerations');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `document_language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `document_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `ec_number` SET TAGS ('dbx_business_glossary_term' = 'European Community (EC) Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `ec_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{3}-[0-9]$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `ecological_information` SET TAGS ('dbx_business_glossary_term' = 'Ecological Information');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `emergency_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `emergency_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `emergency_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `exposure_controls` SET TAGS ('dbx_business_glossary_term' = 'Exposure Controls and Personal Protective Equipment (PPE)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `firefighting_measures` SET TAGS ('dbx_business_glossary_term' = 'Firefighting Measures');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `first_aid_measures` SET TAGS ('dbx_business_glossary_term' = 'First Aid Measures');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Hazard Classification');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `handling_precautions` SET TAGS ('dbx_business_glossary_term' = 'Handling Precautions');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `hazard_statements` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Hazard Statements');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Address');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `manufacturer_phone` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `manufacturer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `manufacturer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `physical_properties` SET TAGS ('dbx_business_glossary_term' = 'Physical and Chemical Properties');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `pictogram_codes` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Pictogram Codes');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `precautionary_statements` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Precautionary Statements');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration, Evaluation, Authorisation and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `regulatory_information` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Information');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Revision Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `sds_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `sds_number` SET TAGS ('dbx_value_regex' = '^SDS-[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `sds_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `sds_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `signal_word` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Signal Word');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `signal_word` SET TAGS ('dbx_value_regex' = 'danger|warning|none');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `stability_reactivity` SET TAGS ('dbx_business_glossary_term' = 'Stability and Reactivity Information');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `supersedes_date` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `toxicological_information` SET TAGS ('dbx_business_glossary_term' = 'Toxicological Information');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `transport_information` SET TAGS ('dbx_business_glossary_term' = 'Transport Information');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Version Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `parent_location_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Storage Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `access_control_level` SET TAGS ('dbx_business_glossary_term' = 'Access Control Level');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `access_control_level` SET TAGS ('dbx_value_regex' = 'public|restricted|controlled|high_security');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Barcode');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `capacity_occupied_units` SET TAGS ('dbx_business_glossary_term' = 'Occupied Storage Capacity (Units)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `capacity_total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Capacity (Units)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `cold_chain_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Deactivation Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Deactivation Reason');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `environmental_monitor_device_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Device Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `environmental_monitor_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `environmental_monitor_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `fefo_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Enforcement Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `fifo_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Enforcement Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `gmp_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `gmp_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|not_qualified|qualification_in_progress|requalification_required');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `hazardous_material_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Approved Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'freezer|refrigerator|ambient_shelf|cold_room|dry_storage|controlled_temperature_unit');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `next_requalification_date` SET TAGS ('dbx_business_glossary_term' = 'Next Requalification Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Notes');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `shelf_position` SET TAGS ('dbx_business_glossary_term' = 'Shelf or Rack Position');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `storage_location_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `storage_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|quarantine|maintenance|decommissioned|pending_qualification');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `target_humidity_max_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Maximum Humidity (Percent)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `target_humidity_min_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Minimum Humidity (Percent)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `target_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Target Maximum Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `target_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Target Minimum Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Classification');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ultra_low_minus_80c|low_minus_20c|refrigerated_2_to_8c|controlled_15_to_25c|ambient');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `unit_identifier` SET TAGS ('dbx_business_glossary_term' = 'Storage Unit Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `inventory_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Balance Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'active|depleted|expired|recalled|transferred|adjusted');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `consignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Consignment Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `days_to_expiry` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiry');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `expiry_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Expiry Alert Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `fefo_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Priority Rank');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `gmp_release_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Release Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `gmp_release_status` SET TAGS ('dbx_value_regex' = 'released|blocked|restricted|quarantine|expired');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `last_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Last Adjustment Reason');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `low_stock_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Low Stock Alert Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `minimum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^PO[0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `quarantine_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Quantity');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `restricted_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Use Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_MM|LIMS|WMS|MES|MANUAL');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `storage_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `total_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Valuation Amount');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `total_valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,5}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `valuation_price` SET TAGS ('dbx_business_glossary_term' = 'Valuation Price');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `valuation_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `dispensing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Event Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Batch Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `quality_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `tertiary_dispensing_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `tertiary_dispensing_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `tertiary_dispensing_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `chain_of_custody_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Confirmed Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `coa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `cold_chain_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `custody_confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Custody Confirmed Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `destination_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Reference Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `destination_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Type');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `destination_type` SET TAGS ('dbx_value_regex' = 'experiment|assay_run|production_order|instrument|storage_location|waste');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `dispensing_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Notes');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = 'dispense|transfer|return|inter_site_shipment|consumption|quarantine_move');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `movement_type_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `qc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `qc_status` SET TAGS ('dbx_value_regex' = 'released|quarantine|rejected|pending|expired');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `quantity_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'ruo|ivd|gmp_released|clinical_trial');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `remaining_lot_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Lot Quantity (LOT)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `sds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `storage_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `storage_condition_code` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|ultra_low|cryogenic');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `system_source` SET TAGS ('dbx_value_regex' = 'lims|erp|mes|manual|instrument');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Celsius (C)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Celsius (C)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `transfer_reason` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `qc_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Specification Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Item Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Method Validation Study Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `process_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Process Validation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `quality_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Rule Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `acceptance_criteria_type` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Type');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `acceptance_criteria_type` SET TAGS ('dbx_value_regex' = 'numeric_range|minimum_threshold|maximum_threshold|pass_fail|qualitative');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `analytical_parameter` SET TAGS ('dbx_business_glossary_term' = 'Analytical Parameter');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `applicable_product_grade` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Grade');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `applicable_product_grade` SET TAGS ('dbx_value_regex' = 'RUO|IVD|GMP|research|clinical');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `change_control_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Control Reference');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `change_control_reference` SET TAGS ('dbx_value_regex' = '^CC-[A-Z0-9-]+$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `criticality_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `is_coa_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Certificate of Analysis (COA) Reportable');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `is_stability_indicating` SET TAGS ('dbx_business_glossary_term' = 'Is Stability Indicating');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `lower_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `out_of_specification_escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification (OOS) Escalation Procedure');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `pass_fail_criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Criteria Description');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `regulatory_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard Reference');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `sample_size_requirement` SET TAGS ('dbx_business_glossary_term' = 'Sample Size Requirement');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `specification_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Specification Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `specification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `specification_rationale` SET TAGS ('dbx_business_glossary_term' = 'Specification Rationale');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|obsolete');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_value_regex' = 'identity|purity|potency|sterility|endotoxin|functional');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `specification_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `test_frequency` SET TAGS ('dbx_business_glossary_term' = 'Test Frequency');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `test_frequency` SET TAGS ('dbx_value_regex' = 'per_lot|per_batch|periodic|skip_lot|continuous');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `test_method_name` SET TAGS ('dbx_business_glossary_term' = 'Test Method Name');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `test_method_sop_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Method Standard Operating Procedure (SOP) Reference');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `test_method_sop_reference` SET TAGS ('dbx_value_regex' = '^SOP-[A-Z0-9-]+$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `kit_component_id` SET TAGS ('dbx_business_glossary_term' = 'Kit Component Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Component Catalog Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `parent_kit_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Kit Catalog Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Kit Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `primary_kit_substitute_component_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Component Catalog Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `assembly_instruction` SET TAGS ('dbx_business_glossary_term' = 'Component Assembly Instruction');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `component_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Component Cost (United States Dollar - USD)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `component_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `component_quantity` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `component_role` SET TAGS ('dbx_business_glossary_term' = 'Component Role');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `component_role` SET TAGS ('dbx_value_regex' = 'enzyme|buffer|adapter|index_plate|master_mix|reagent');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `component_sequence` SET TAGS ('dbx_business_glossary_term' = 'Component Sequence Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `component_stability_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Component Stability Duration (Days)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `component_storage_requirement` SET TAGS ('dbx_business_glossary_term' = 'Component Storage Requirement');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `component_storage_requirement` SET TAGS ('dbx_value_regex' = 'room_temperature|refrigerated_2_8c|frozen_minus_20c|frozen_minus_80c|dry_ice|liquid_nitrogen');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `component_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Component Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `component_version` SET TAGS ('dbx_business_glossary_term' = 'Component Version');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'non_hazardous|flammable|corrosive|toxic|biohazard|oxidizer');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `is_critical_component` SET TAGS ('dbx_business_glossary_term' = 'Critical Component Indicator');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `is_substitutable` SET TAGS ('dbx_business_glossary_term' = 'Substitutable Component Indicator');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `lot_traceability_required` SET TAGS ('dbx_business_glossary_term' = 'Lot (LOT) Traceability Required Indicator');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `maximum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Component Quantity');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `minimum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Component Quantity');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'approved|pending|discontinued|restricted');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `requires_separate_shipment` SET TAGS ('dbx_business_glossary_term' = 'Separate Shipment Required Indicator');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_record_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Authorization Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_authorization_id` SET TAGS ('dbx_value_regex' = '^AUTH-[A-Z0-9]{8,15}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Authorized By');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `authorized_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `coa_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Reference');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `coa_reference` SET TAGS ('dbx_value_regex' = '^COA-[A-Z0-9]{8,15}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_cost` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cost');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_location` SET TAGS ('dbx_business_glossary_term' = 'Disposal Location');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'incineration|chemical_neutralization|biohazard_waste|autoclave|landfill|recycling');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposal Notes');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposal Reason');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_reason` SET TAGS ('dbx_value_regex' = 'expired|failed_qc|recalled|damaged|contaminated|obsolete');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_status` SET TAGS ('dbx_business_glossary_term' = 'Disposal Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_status` SET TAGS ('dbx_value_regex' = 'pending|approved|completed|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposal Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `disposal_vendor` SET TAGS ('dbx_business_glossary_term' = 'Disposal Vendor');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_value_regex' = '^ENV-[A-Z0-9]{8,15}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `gmp_release_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Release Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `gmp_release_status` SET TAGS ('dbx_value_regex' = 'released|quarantined|rejected|blocked');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `qc_failure_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Failure Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `qc_failure_code` SET TAGS ('dbx_value_regex' = '^QC-[A-Z0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `quantity_disposed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Disposed');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `recall_number` SET TAGS ('dbx_value_regex' = '^RCL-[A-Z0-9]{8,15}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `regulatory_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `sds_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `sds_reference` SET TAGS ('dbx_value_regex' = '^SDS-[A-Z0-9]{6,15}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `storage_location_prior` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Prior to Disposal');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `waste_classification` SET TAGS ('dbx_business_glossary_term' = 'Waste Classification');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `waste_classification` SET TAGS ('dbx_value_regex' = 'hazardous|biohazardous|non_hazardous|chemical|radioactive|sharps');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `waste_manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Waste Manifest Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `waste_manifest_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `field_safety_action_id` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Action Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `internal_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Investigation Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `internal_investigation_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `adverse_event_count` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Count');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `affected_lot_numbers` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot (LOT) Numbers');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `affected_product_sku` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Stock Keeping Unit (SKU)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `affected_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Unit Count');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `capa_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `customer_complaint_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Count');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `customer_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `customer_notification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `disposition_method` SET TAGS ('dbx_business_glossary_term' = 'Product Disposition Method');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `disposition_method` SET TAGS ('dbx_value_regex' = 'destruction|rework|return_to_vendor|quarantine');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_business_glossary_term' = 'Distribution Scope');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_value_regex' = 'internal_only|domestic|international|global');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact Amount');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_business_glossary_term' = 'Health Hazard Evaluation');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|phone|letter|press_release|website|multiple');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `press_release_date` SET TAGS ('dbx_business_glossary_term' = 'Press Release Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `press_release_issued` SET TAGS ('dbx_business_glossary_term' = 'Press Release Issued Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `recall_class` SET TAGS ('dbx_business_glossary_term' = 'Recall Classification Class');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `recall_class` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `recall_effectiveness_check_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Effectiveness Check Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `recall_effectiveness_result` SET TAGS ('dbx_business_glossary_term' = 'Recall Effectiveness Result');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `recall_effectiveness_result` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|pending');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `recall_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'initiated|ongoing|completed|terminated|closed');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Type');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'voluntary|mandatory|field_correction|market_withdrawal');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'FDA|EMA|MHRA|TGA|Health_Canada|PMDA');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `retrieval_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retrieval Completion Percentage');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ALTER COLUMN `units_retrieved` SET TAGS ('dbx_business_glossary_term' = 'Units Retrieved Count');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `inventory_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Transaction Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Storage Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Batch Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `primary_inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `reversed_transaction_inventory_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Transaction Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `reversal_inventory_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `coa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `cold_chain_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `gmp_release_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Release Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `gmp_release_status` SET TAGS ('dbx_value_regex' = 'released|quarantine|rejected|pending_qc|conditional_release');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `movement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transaction Quantity');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `reference_document_line_item` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Line Item');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `sds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Celsius');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Celsius');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `total_transaction_value` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Value');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `total_transaction_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `transaction_notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` SET TAGS ('dbx_association_edges' = 'reagent.reagent_catalog,data.catalog_tag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `tag_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Tag Assignment Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Tag Assignment - Reagent Catalog Id');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `catalog_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Tag Assignment - Catalog Tag Id');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Tag Assigned By');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Notes');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Status');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `classification_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Classification Algorithm');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Assignment Confidence Score');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Tag Effective From Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Tag Effective To Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Review Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Tag Assignment Reviewed By');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_authorization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_authorization` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_authorization` ALTER COLUMN `disposal_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Authorization Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_authorization` ALTER COLUMN `superseded_disposal_authorization_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `parent_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
