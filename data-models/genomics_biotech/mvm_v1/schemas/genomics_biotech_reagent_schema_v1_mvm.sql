-- Schema for Domain: reagent | Business: Genomics Biotech | Version: v1_mvm
-- Generated on: 2026-05-06 15:33:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`reagent` COMMENT 'Governs the lifecycle of reagents, consumables, and biochemical inputs — including library preparation kits, flow cells, CRISPR reagents, PCR/qPCR master mixes, enzymes, buffers, and array hybridization chips. Owns LOT traceability, COA records, SDS documentation, expiry management, storage requirements, usage tracking, and GMP-compliant release status.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`catalog` (
    `catalog_id` BIGINT COMMENT 'Unique identifier for the reagent catalog entry. Primary key for the reagent catalog master data.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: IVD reagent kits and consumables require regulatory approval (FDA clearance, CE mark) before commercial sale. This links reagent product definitions to their regulatory approval records, enabling comp',
    `assay_development_id` BIGINT COMMENT 'Foreign key linking to research.assay_development. Business justification: A reagent catalog entry is the commercial output of an assay development program. Linking catalog to assay_development supports product lifecycle management, IP traceability, and regulatory submission',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Reagent catalog entries ARE commercial products in the master catalog. Required for pricing synchronization, product lifecycle management, regulatory classification alignment, and commercial analytics',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: GMP reagent catalog changes (formulation, storage, labeling, specifications) must be governed by a formal Change Control record. In genomics biotech, any catalog-level modification requires change con',
    `device_identifier_id` BIGINT COMMENT 'Foreign key linking to regulatory.device_identifier. Business justification: IVD reagent catalog items require UDI/EUDAMED device identifier assignment for regulatory compliance. Regulatory affairs and product management teams link catalog items to their UDI-DI for GUDID submi',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Reagent catalog entries are grouped into product families for portfolio lifecycle management, go-to-market segmentation, and pricing strategy. In genomics biotech, product managers classify reagents (',
    `labeling_id` BIGINT COMMENT 'Foreign key linking to regulatory.labeling. Business justification: Catalog item label management requires tracking the current approved labeling document for each reagent product. Regulatory affairs teams use this link to manage labeling change controls and ensure ca',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Reagent catalog items are procured as materials through supply chain. Links product specification to procurement master for MRP planning, purchase requisition generation, and spend analytics—foundatio',
    `molecular_design_id` BIGINT COMMENT 'Foreign key linking to research.molecular_design. Business justification: Synthesized reagents (oligonucleotides, probes, CRISPR guides) in the catalog originate from a molecular design record. This link enables IP traceability, patent filing support, and sequence-to-produc',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Catalog products often originate from R&D projects before commercialization (assay development, novel reagent formulations). Tracks technology transfer from research to commercial catalog. Essential f',
    `catalog_number` STRING COMMENT 'Externally-known unique catalog number or SKU (Stock Keeping Unit) for the reagent product. Used for ordering, inventory management, and customer communication.. Valid values are `^[A-Z0-9]{6,20}$`',
    `coa_required_flag` BOOLEAN COMMENT 'Indicates whether a COA (Certificate of Analysis) is required for each LOT (Lot Number) of this reagent. True indicates COA must be issued; False indicates no COA requirement. COAs document QC test results and compliance.',
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
    `crispr_construct_id` BIGINT COMMENT 'Foreign key linking to research.crispr_construct. Business justification: A manufactured lot of a CRISPR reagent (guide RNA, Cas9 protein, RNP complex) traces directly to the crispr_construct design record. GMP/GLP traceability from physical lot to molecular design is a reg',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: GMP lot release process requires each lot to be released against a specific regulatory approval. QA teams track which approval governs a lots disposition. A genomics-biotech QA expert would expect th',
    `inbound_delivery_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_delivery. Business justification: In GMP genomics biotech, reagent lots created from incoming materials must trace to the specific inbound delivery for cold-chain verification (temperature_excursion_flag), customs clearance status, an',
    `labeling_id` BIGINT COMMENT 'Foreign key linking to regulatory.labeling. Business justification: GMP manufacturing requires each lot to be labeled per the approved labeling version in effect at manufacture date. Labeling version traceability per lot is a regulatory requirement for IVD reagents; a',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Regulatory traceability requires each reagent lot to be traceable to its manufacturing establishment registration. Country-of-origin declarations, import/export compliance, and regulatory submissions ',
    `product_bom_id` BIGINT COMMENT 'Foreign key linking to product.product_bom. Business justification: GMP lot traceability requires recording which BOM version governed a reagent lots manufacture. Regulatory audits and deviation investigations in genomics biotech demand direct lot-to-BOM traceability',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Reagent lots are manufactured outputs requiring traceability to the GMP production batch that created them. Production_batch captures execution-level data (actual yield, deviations, QC checkpoints) es',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Reagent lots are frequently manufactured for specific R&D projects (custom synthesis, project-specific formulations). Critical for project cost allocation, technology transfer tracking, and tracing re',
    `research_protocol_id` BIGINT COMMENT 'Foreign key linking to research.research_protocol. Business justification: GLP/GxP lot manufacturing and release requires traceability to the governing research protocol. Lot production, sampling, and testing procedures are protocol-driven; audit trails and regulatory submis',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: GMP lots are frequently manufactured for specific customer contracts or reserved for strategic accounts. Critical for contract fulfillment tracking, consignment inventory management, and regulatory tr',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Manufacturing lots are produced against specific SKUs for GMP traceability. Required for lot genealogy, recall execution, inventory valuation (COGS by SKU), and regulatory batch record linkage. Founda',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to reagent.storage_location. Business justification: A reagent lot has a primary or current storage location for GMP traceability and quarantine management. While inventory_balance tracks lot-location combinations for quantity purposes, the lot master r',
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
    `accreditation_id` BIGINT COMMENT 'Foreign key linking to customer.accreditation. Business justification: COAs issued to accredited labs (CAP, CLIA, ISO 15189) must reference the governing accreditation to confirm the reagent is authorized under that accreditation scope. Clinical genomics regulatory compl',
    `assay_development_id` BIGINT COMMENT 'Foreign key linking to research.assay_development. Business justification: CoAs for reagents used in assay development are archived as validation documentation evidence. Assay development teams in genomics biotech associate specific CoAs with the assay development record to ',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: GMP traceability requirement: the CoA for a released reagent lot must be directly traceable to the Electronic Batch Record (EBR) that documents its manufacture. Regulatory audits (21 CFR Part 211, ISO',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Certificates of Analysis are issued to specific customers for regulatory compliance and quality documentation. Customer-specific CoAs support audit trails for GxP customers and enable tracking of whic',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: GxP document control requires COAs to be issued to a named individual (lab director, QA manager), not just an account. Regulatory audits in clinical genomics demand contact-level COA receipt traceabil',
    `lot_id` BIGINT COMMENT 'Reference to the reagent or consumable lot for which this COA was issued. Links to the lot master record.',
    `primary_superseded_by_coa_id` BIGINT COMMENT 'Reference to the COA that supersedes this one, if applicable. Used when a COA is reissued due to corrections, additional testing, or updated specifications.',
    `qc_result_id` BIGINT COMMENT 'Foreign key linking to quality.qc_result. Business justification: COAs document QC test results for customer-facing release documentation. Each COA line item references specific QC results. Required for regulatory compliance and customer quality assurance in genomic',
    `qc_specification_id` BIGINT COMMENT 'Foreign key linking to reagent.qc_specification. Business justification: A Certificate of Analysis (COA) documents QC test results measured against defined acceptance specifications. The qc_specification product is the authoritative reference master for those acceptance cr',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: COAs issued under contract research or testing service agreements are contractual deliverables governed by the service agreements SLA, compliance terms, and IP clauses. Genomics biotech service labs ',
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
    `storage_conditions` STRING COMMENT 'Required storage conditions for the lot as documented in the COA (e.g., -20°C, 2-8°C, room temperature, protect from light). Critical for maintaining product integrity.',
    `test_date` DATE COMMENT 'Date on which the quality control testing was performed for this lot. May differ from issue date due to review and approval cycles.',
    `test_summary` STRING COMMENT 'High-level summary of tests performed, including test names and categories (e.g., identity, purity, potency, sterility). Provides quick overview of COA scope.',
    CONSTRAINT pk_coa PRIMARY KEY(`coa_id`)
) COMMENT 'Certificate of Analysis (COA) record for each reagent lot, documenting QC test results, acceptance criteria, pass/fail determinations, analytical method references, and authorized release signatures. Captures COA document number, issuing laboratory, test date, specification version, and GMP release authorization. Supports regulatory submission packages, customer-facing COA delivery, and ISO 13485 / GxP documentation requirements. Linked to the lot master and QC test results.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the physical or logical storage location. Primary key for the storage location master data.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: GMP storage locations exist within FDA/competent-authority registered establishments. Regulatory compliance reporting requires knowing which registered facility each storage location belongs to. Facil',
    `parent_location_storage_location_id` BIGINT COMMENT 'Reference to the parent storage location in a hierarchical storage structure. Enables nested location modeling such as freezer containing shelves containing racks.',
    `site_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_site. Business justification: Reagent storage locations (cold rooms, freezers, quarantine areas) are physically situated within manufacturing sites. Site-level inventory reporting, GMP site audits, environmental monitoring complia',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Reagent storage locations (ultra-low freezers, cold rooms) in genomics biotech facilities are physically situated within warehouse locations managed by the supply/WMS system. This link enables GMP zon',
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
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Consignment inventory held at customer sites must be tracked to the specific site address for cold-chain compliance audits, site-specific inventory reporting, and regulatory inspections. Multi-site ac',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Inventory balances are inherently lot-specific in GMP environments - each balance record represents quantity of a specific lot at a specific location. Currently inventory_balance has lot_number as STR',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Reagent inventory balances in GMP biotech must be traceable to the originating purchase order for financial reconciliation, GMP lot traceability, and inventory valuation audits. The existing `purchase',
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
    `clinical_specimen_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_specimen. Business justification: Reagent dispensing events for clinical specimen processing must be linked to the specimen for cost-per-test accounting, reagent consumption tracking, and lot traceability audits. Lab operations teams ',
    `coa_id` BIGINT COMMENT 'Foreign key linking to reagent.coa. Business justification: A dispensing event must verify and record the Certificate of Analysis for the reagent lot being dispensed — this is a GMP and chain-of-custody requirement in genomics biotech. The dispensing_event cur',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Reagents dispensed for customer service work, evaluation programs, or contract research require tracking destination account for cost recovery, service agreement compliance, and usage analytics. Suppo',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Cold-chain and hazmat compliance for reagent delivery requires knowing the exact customer site address (biosafety level, cold-chain eligibility, receiving hours). Multi-site accounts need site-specifi',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: GxP chain-of-custody for reagent dispensing requires recording the named authorized individual who received or authorized the dispensing. Existing customer_account_id covers account-level tracking; co',
    `experiment_id` BIGINT COMMENT 'Reference to the research or production experiment that consumed the reagent, if applicable.',
    `batch_record_id` BIGINT COMMENT 'Reference to the GMP batch production record that documents the use of this reagent in manufacturing. Required for FDA-regulated production.',
    `inventory_transaction_id` BIGINT COMMENT 'Foreign key linking to reagent.inventory_transaction. Business justification: A dispensing event is a specific material movement that generates or corresponds to a unified inventory transaction record. Linking dispensing_event to inventory_transaction provides full traceability',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Critical traceability link - every reagent dispensing event must be traceable to the specific lot (batch) used. Currently dispensing_event has lot_number as STRING but no FK to lot master. Adding lot_',
    `research_protocol_id` BIGINT COMMENT 'Foreign key linking to research.research_protocol. Business justification: GxP dispensing events are governed by a specific research protocol (SOP). Linking dispensing events to the protocol enables protocol compliance reporting, audit trail completeness, and deviation inves',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Dispensing events consume specific SKUs for cost allocation to experiments, work orders, or instruments. Required for usage analytics, replenishment triggers, and activity-based costing in genomics la',
    `storage_location_id` BIGINT COMMENT 'Storage location, facility, or inventory site from which the reagent was dispensed or transferred.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_order. Business justification: Reagent dispensing events in GMP manufacturing are executed against a specific work order driving material consumption. dispensing_event.work_order_number is a plain-text denormalization of this relat',
    `chain_of_custody_confirmed_flag` BOOLEAN COMMENT 'Indicates whether the material transfer was acknowledged and confirmed by the receiving party or system. Required for GMP audit trails.',
    `cold_chain_compliant_flag` BOOLEAN COMMENT 'Indicates whether the reagent was maintained within required temperature range during the movement event. Critical for temperature-sensitive materials like enzymes and CRISPR reagents.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the reagent consumption is charged. Supports activity-based costing and departmental expense tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dispensing event record was first created in the data system. Audit trail field for data lineage tracking.',
    `custody_confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the receiving party confirmed custody of the transferred material.',
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
    CONSTRAINT pk_dispensing_event PRIMARY KEY(`dispensing_event_id`)
) COMMENT 'Transactional record of each reagent material movement — including dispensing to experiments/assays, consumption by instruments, internal transfers between storage locations or facilities, and returns to stock. Captures event timestamp, movement type (dispense, transfer, return, inter-site shipment), operator ID, lot number, quantity moved, unit of measure, source location, destination (experiment, assay run, production work order, instrument, or storage location), transfer reason (lab request, cold-chain relocation, quarantine move), remaining lot quantity post-event, cold-chain compliance flag, and chain-of-custody confirmation. Supports full LOT traceability from receipt through consumption or relocation, GMP usage logs, inter-site transfer documentation, and LIMS-driven reagent tracking.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` (
    `qc_specification_id` BIGINT COMMENT 'Unique identifier for the QC specification record. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Approved QC specifications for IVD reagents are governed by the regulatory approval — the approved spec version must match what was filed. QA and regulatory teams track this link for change control an',
    `catalog_id` BIGINT COMMENT 'Reference to the reagent catalog item to which this QC specification applies. Links specification to specific reagent SKU.',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: QC specification updates (revised limits, new parameters, method changes) in GMP genomics environments must be authorized via Change Control. qc_specification.change_control_reference is a plain-text ',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer-specific QC specifications are standard in contract manufacturing and custom reagent development. Pharma customers require tailored acceptance criteria. Tracks which specifications apply to c',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.model. Business justification: Reagent QC specifications in genomics are frequently instrument-platform-specific — acceptance criteria (e.g., cluster density, error rate thresholds) differ by instrument model. Linking qc_specificat',
    `validation_study_id` BIGINT COMMENT 'Reference to the analytical method validation study that established the scientific basis for this specification. Links to validation protocol and report documentation.',
    `pipeline_version_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_version. Business justification: A reagent QC specification for sequencing-based tests (e.g., NGS identity testing) must mandate a specific validated bioinformatics pipeline version. Regulatory standards require this traceability: th',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Reagent QC acceptance criteria are derived from the product-level specification (e.g., Q30 threshold, read length, LOD). In genomics biotech, regulatory submissions and product development require tra',
    `production_routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_routing. Business justification: QC specifications in GMP genomics-biotech manufacturing are scoped to specific production routings — the routing defines process steps and the QC spec defines acceptance criteria for that process. Rou',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to quality.risk_assessment. Business justification: QC specification criticality levels and acceptance criteria in genomics biotech are derived from formal risk assessments (ICH Q9, FMEA). qc_specification.criticality_level and specification_rationale ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Quality specifications define acceptance criteria at the SKU level for manufacturing release. Required for QC testing protocols, batch disposition decisions, and specification change control. Each SKU',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Regulatory submission packages for IVD reagents include analytical QC specifications. Regulatory affairs teams track which QC specifications are included in which submission dossier for FDA/CE submiss',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: In GMP genomics biotech, QC specifications are frequently supplier-specific — acceptance criteria for purity, endotoxin, or sequencing-grade reagents differ by supplier. Regulatory audits and supplier',
    `test_method_id` BIGINT COMMENT 'Foreign key linking to quality.test_method. Business justification: Every QC specification in genomics reagent testing references a validated test method (qPCR, gel electrophoresis, spectrophotometry). qc_specification.test_method_name and test_method_sop_reference ar',
    `acceptance_criteria_type` STRING COMMENT 'Format of the acceptance criteria: numeric_range (min-max bounds), minimum_threshold (greater than or equal to), maximum_threshold (less than or equal to), pass_fail (binary result), qualitative (descriptive evaluation).. Valid values are `numeric_range|minimum_threshold|maximum_threshold|pass_fail|qualitative`',
    `analytical_parameter` STRING COMMENT 'Specific quality attribute being measured (e.g., Purity, Concentration, pH, Endotoxin Level, Enzyme Activity, Amplification Efficiency).',
    `applicable_product_grade` STRING COMMENT 'Regulatory grade of reagent to which this specification applies: RUO (Research Use Only), IVD (In Vitro Diagnostic), GMP (Good Manufacturing Practice), research (basic research), clinical (clinical trial use). Specifications may differ by grade.. Valid values are `RUO|IVD|GMP|research|clinical`',
    `approval_date` DATE COMMENT 'Date when the QC specification was formally approved by Quality Assurance (QA) for use in lot release testing.',
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
    `sample_size_requirement` STRING COMMENT 'Required sample size or sampling plan for the test (e.g., n=3 replicates, AQL 1.5, 10 units per lot). Supports statistical quality control.',
    `specification_code` STRING COMMENT 'Business identifier for the QC specification. Unique alphanumeric code used in quality documentation and Certificate of Analysis (COA) references.. Valid values are `^[A-Z0-9]{4,20}$`',
    `specification_rationale` STRING COMMENT 'Scientific and regulatory justification for the acceptance criteria limits. Documents the basis for specification setting (e.g., Based on method validation data showing 95% confidence interval, Aligned with USP monograph requirements).',
    `specification_status` STRING COMMENT 'Current lifecycle status of the QC specification: draft (in development), under_review (pending approval), approved (authorized for use), active (currently enforced), superseded (replaced by newer version), obsolete (no longer valid).. Valid values are `draft|under_review|approved|active|superseded|obsolete`',
    `specification_type` STRING COMMENT 'Category of QC specification defining the nature of the quality test: identity (confirms correct reagent), purity (contaminant levels), potency (biological activity), sterility (microbial contamination), endotoxin (bacterial toxin levels), functional (performance in assay).. Valid values are `identity|purity|potency|sterility|endotoxin|functional`',
    `specification_version` STRING COMMENT 'Version number of the QC specification following semantic versioning (e.g., 1.0, 2.1, 3.0.1). Supports change control and regulatory traceability.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `target_value` DECIMAL(18,2) COMMENT 'Nominal or target value for the analytical parameter. Represents the ideal measurement outcome within the specification range.',
    `test_frequency` STRING COMMENT 'Required frequency of testing for this specification: per_lot (every manufacturing lot), per_batch (every production batch), periodic (scheduled intervals), skip_lot (reduced testing per approved plan), continuous (in-process monitoring).. Valid values are `per_lot|per_batch|periodic|skip_lot|continuous`',
    `unit_of_measure` STRING COMMENT 'Unit of measurement for the analytical parameter (e.g., mg/mL, EU/mL, %, U/mg, Ct value, copies/µL). Null for qualitative or pass/fail tests.',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for numeric acceptance criteria. Null if not applicable (e.g., pass/fail tests).',
    CONSTRAINT pk_qc_specification PRIMARY KEY(`qc_specification_id`)
) COMMENT 'Reference master defining QC acceptance specifications for each reagent catalog item — including test method name, analytical parameter, specification type (identity, purity, potency, sterility, endotoxin, functional), acceptance criteria (numeric limits, pass/fail criteria), unit of measure, applicable regulatory standard, and specification version. Drives automated pass/fail evaluation of QC test results and supports method validation documentation.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` (
    `kit_component_id` BIGINT COMMENT 'Unique identifier for the kit component association record. Primary key for the kit_component entity.',
    `assay_development_id` BIGINT COMMENT 'Foreign key linking to research.assay_development. Business justification: Genomics kit components are designed and validated within an assay development program. The assay development record governs component selection, quantities, and compatibility requirements. This link ',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Kit component changes (substitutions, quantity adjustments, new critical components) in GMP genomics kits require formal Change Control authorization. kit_component.change_control_number is a plain-te',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Each kit component maps to an orderable SKU for procurement, component-level pricing, and supply chain planning. In genomics biotech, kit assembly teams and supply planners need direct component-to-SK',
    `catalog_id` BIGINT COMMENT 'Reference to the parent multi-component reagent kit catalog item. Links to the master kit product definition in the reagent catalog.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Kit parent must reference the commercial catalog item for BOM costing, pricing rollup, and product configuration management. Enables multi-level product structures and kit-to-catalog synchronization f',
    `primary_kit_substitute_component_catalog_id` BIGINT COMMENT 'Reference to an approved substitute component catalog item. Used when the primary component is unavailable or discontinued. Substitution must be validated and documented per Good Manufacturing Practice (GMP) change control procedures.',
    `validation_study_id` BIGINT COMMENT 'Reference to the validation study that qualified this component for inclusion in the kit. Links to Research and Development (R&D) documentation, analytical validation reports, and regulatory submission packages.',
    `assembly_instruction` STRING COMMENT 'Detailed instructions for incorporating this component into the kit during manufacturing assembly. Includes handling precautions, placement requirements, and Standard Operating Procedure (SOP) references for Good Manufacturing Practice (GMP) compliance.',
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

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` (
    `inventory_transaction_id` BIGINT COMMENT 'Unique identifier for the inventory transaction record. Primary key for the inventory transaction entity.',
    `asset_id` BIGINT COMMENT 'Sequencing instrument, array scanner, or laboratory equipment that consumed the reagent. Critical for tracking flow cell usage, library preparation kit consumption, and instrument-specific reagent utilization.',
    `catalog_id` BIGINT COMMENT 'Reference to the reagent catalog item involved in this transaction. Links to the master reagent definition including product specifications and regulatory classification.',
    `coa_id` BIGINT COMMENT 'Foreign key linking to reagent.coa. Business justification: Inventory transactions (goods receipts, transfers, adjustments) in a GMP-regulated genomics environment must reference the Certificate of Analysis for the lot being moved. The inventory_transaction cu',
    `storage_location_id` BIGINT COMMENT 'Storage location to which the reagent was moved. Null for goods issue or consumption transactions where material leaves inventory. References the storage location master data including facility, room, and environmental controls.',
    `experiment_id` BIGINT COMMENT 'Unique identifier for the research experiment or assay run that consumed the reagent. Enables tracking of reagent usage in Research Use Only (RUO) and Laboratory Developed Test (LDT) workflows.',
    `field_safety_action_id` BIGINT COMMENT 'Foreign key linking to regulatory.field_safety_action. Business justification: Recall and field safety action execution generates inventory transactions (quarantine, return, destruction movements). Linking inventory transactions to the triggering field safety action supports rec',
    `batch_record_id` BIGINT COMMENT 'Batch record identifier for Good Manufacturing Practice (GMP) regulated manufacturing operations. Links reagent consumption to specific production batches for regulatory compliance and traceability.',
    `inventory_balance_id` BIGINT COMMENT 'Foreign key linking to reagent.inventory_balance. Business justification: Each inventory transaction posts against a specific inventory balance record (identified by the combination of catalog, lot, storage location). Linking inventory_transaction.inventory_balance_id → inv',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Every inventory movement (goods receipt, transfer, consumption, adjustment) must be traceable to the specific lot being moved. Currently inventory_transaction has lot_number as STRING but no FK to lot',
    `primary_inventory_storage_location_id` BIGINT COMMENT 'Storage location from which the reagent was moved. Null for goods receipt transactions where material enters inventory from external sources. References the storage location master data including facility, room, and environmental controls.',
    `primary_reversed_transaction_inventory_transaction_id` BIGINT COMMENT 'Reference to the original inventory transaction that this record reverses or cancels. Null for original transactions. Populated for reversal entries to maintain audit trail.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Reagent inventory transactions (goods receipts, transfers) in GMP biotech are triggered by purchase orders. A proper FK enables PO-level transaction reporting, three-way match (PO/GR/invoice), and reg',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: All inventory movements (receipts, issues, transfers, adjustments) are recorded against SKUs. Foundation of perpetual inventory, COGS calculation, and inventory reconciliation in genomics ERP systems.',
    `supplier_id` BIGINT COMMENT 'Vendor or supplier from whom the reagent was received. Populated for goods receipt transactions. Used for supplier performance tracking and supply chain analytics.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_primary_superseded_by_coa_id` FOREIGN KEY (`primary_superseded_by_coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_qc_specification_id` FOREIGN KEY (`qc_specification_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`qc_specification`(`qc_specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ADD CONSTRAINT `fk_reagent_storage_location_parent_location_storage_location_id` FOREIGN KEY (`parent_location_storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_inventory_transaction_id` FOREIGN KEY (`inventory_transaction_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`inventory_transaction`(`inventory_transaction_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ADD CONSTRAINT `fk_reagent_kit_component_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ADD CONSTRAINT `fk_reagent_kit_component_primary_kit_substitute_component_catalog_id` FOREIGN KEY (`primary_kit_substitute_component_catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_inventory_balance_id` FOREIGN KEY (`inventory_balance_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`inventory_balance`(`inventory_balance_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_primary_inventory_storage_location_id` FOREIGN KEY (`primary_inventory_storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_primary_reversed_transaction_inventory_transaction_id` FOREIGN KEY (`primary_reversed_transaction_inventory_transaction_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`inventory_transaction`(`inventory_transaction_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`reagent` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `genomics_biotech_ecm`.`reagent` SET TAGS ('dbx_domain' = 'reagent');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` SET TAGS ('dbx_subdomain' = 'reagent_registry');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `assay_development_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Development Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `device_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `labeling_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `molecular_design_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Design Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `catalog_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog Number');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `catalog_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ALTER COLUMN `coa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Required Flag');
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
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` SET TAGS ('dbx_subdomain' = 'reagent_registry');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `crispr_construct_id` SET TAGS ('dbx_business_glossary_term' = 'Crispr Construct Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `labeling_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Establishment Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Research Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Reserved For Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `assay_development_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Development Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Issued To Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Issued To Contact Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `primary_superseded_by_coa_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Certificate of Analysis (COA) Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `qc_result_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Result Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `qc_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Test Date');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ALTER COLUMN `test_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Summary');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `parent_location_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Storage Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `inventory_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Balance Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Site Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `dispensing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Event Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `clinical_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Specimen Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensed To Contact Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Batch Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `inventory_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Transaction Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Research Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `chain_of_custody_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Confirmed Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `cold_chain_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ALTER COLUMN `custody_confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Custody Confirmed Timestamp');
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
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `qc_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Specification Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Item Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Method Validation Study Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `pipeline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `production_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Production Routing Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `acceptance_criteria_type` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Type');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `acceptance_criteria_type` SET TAGS ('dbx_value_regex' = 'numeric_range|minimum_threshold|maximum_threshold|pass_fail|qualitative');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `analytical_parameter` SET TAGS ('dbx_business_glossary_term' = 'Analytical Parameter');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `applicable_product_grade` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Grade');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `applicable_product_grade` SET TAGS ('dbx_value_regex' = 'RUO|IVD|GMP|research|clinical');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
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
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` SET TAGS ('dbx_subdomain' = 'reagent_registry');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `kit_component_id` SET TAGS ('dbx_business_glossary_term' = 'Kit Component Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `assay_development_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Development Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Component Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Kit Catalog Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Kit Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `primary_kit_substitute_component_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Component Catalog Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ALTER COLUMN `assembly_instruction` SET TAGS ('dbx_business_glossary_term' = 'Component Assembly Instruction');
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
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `inventory_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Transaction Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Storage Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `field_safety_action_id` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Action Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Batch Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `inventory_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Balance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `primary_inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `primary_reversed_transaction_inventory_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Transaction Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
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
