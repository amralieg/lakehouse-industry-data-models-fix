-- Schema for Domain: clinical | Business: Genomics Biotech | Version: v1_mvm
-- Generated on: 2026-05-06 15:33:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`clinical` COMMENT 'SSOT for clinical genomics assay management — IVD and LDT test catalog, CLIA/CAP-accredited test orders, clinical validity and analytical performance (LOD, sensitivity, specificity), patient-level genomic results, clinical report generation, variant interpretation records, and PHI-compliant clinical workflows. Bridges clinical laboratory operations with regulatory submissions and precision medicine applications.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` (
    `test_catalog_id` BIGINT COMMENT 'Primary key for test_catalog',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: IVD tests in the catalog must reference their FDA 510(k), De Novo, or CE-IVD regulatory approval to be offered clinically. Required for CLIA compliance and test menu management. Domain experts expect ',
    `assay_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_assay. Business justification: test_catalog is the authoritative master catalog of IVD/LDT tests. clinical_assay is the master reference table for clinical assays. The test_catalog entry represents the commercial/regulatory catalog',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: A clinical test catalog entry IS the commercial catalog item in genomics biotech — required for test menu pricing, product lifecycle management, and commercial ordering. test_catalog links to sku but ',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Test catalog updates (version changes, CPT code revisions, retired tests) are governed by formal change control in GxP genomics labs. The change_control_id links the catalog entry to the governing cha',
    `clia_accreditation_id` BIGINT COMMENT 'Foreign key linking to clinical.clia_accreditation. Business justification: Each test in the IVD catalog operates under specific CLIA accreditation credentials and scope. Currently test_catalog has clia_accreditation_scope as a string, but this should be normalized to FK to t',
    `device_identifier_id` BIGINT COMMENT 'Foreign key linking to regulatory.device_identifier. Business justification: FDA 21 CFR Part 830 and EU MDR/IVDR require every IVD test to have a UDI-DI assigned. The test catalog is the product-level entity that maps to a device identifier for GUDID submission, labeling compl',
    `ivd_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.ivd_registration. Business justification: Each IVD test in the catalog must be registered in applicable jurisdictions (FDA listing, EU EUDAMED, Health Canada). Market access decisions, geographic availability of tests, and regulatory renewal ',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.model. Business justification: Clinical test catalog entries are platform-specific (e.g., WGS on NovaSeq 6000). Test menu management, ordering eligibility, and capacity planning all require knowing which instrument model a test run',
    `pipeline_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline. Business justification: Test catalog entries specify which bioinformatics pipeline performs analysis — required for CAP/CLIA compliance, test menu management, and regulatory submissions. pipeline_version on test_catalog is',
    `software_release_id` BIGINT COMMENT 'Foreign key linking to product.software_release. Business justification: CLIA and CAP require clinical tests to reference the exact validated bioinformatics pipeline version. test_catalog.pipeline_version is a denormalized string; a proper FK to software_release enables re',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: IVD test catalog items are commercial products that should reference the product catalog. This enables pricing, ordering, and inventory management for clinical test kits. The test_code becomes redunda',
    `production_routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_routing. Business justification: IVD test kits are manufactured products requiring validated production routings for GMP compliance (21 CFR Part 820). Links test catalog entries to their manufacturing process definitions for regulato',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Clinical tests originate from R&D projects. Required for 21 CFR Part 820 design history file traceability, validation documentation linkage, and regulatory submission (510(k)/PMA) evidence. Domain exp',
    `qc_specification_id` BIGINT COMMENT 'Foreign key linking to reagent.qc_specification. Business justification: A clinical test catalog entry mandates minimum reagent QC specifications (purity, concentration) acceptable for the assay. Required for regulatory submissions (FDA 510(k), LDT documentation) and test ',
    `analytical_sensitivity_percent` DECIMAL(18,2) COMMENT 'Analytical performance metric: percentage of true positive results correctly identified by the assay (true positive rate).',
    `analytical_specificity_percent` DECIMAL(18,2) COMMENT 'Analytical performance metric: percentage of true negative results correctly identified by the assay (true negative rate).',
    `assay_type` STRING COMMENT 'Classification of the genomic assay methodology. WGS=Whole Genome Sequencing, WES=Whole Exome Sequencing, targeted_panel=focused gene panel, SNP_array=Single Nucleotide Polymorphism array, CRISPR_based=CRISPR gene editing assay, qPCR=Quantitative Polymerase Chain Reaction, NGS_panel=Next-Generation Sequencing panel. [ENUM-REF-CANDIDATE: WGS|WES|targeted_panel|SNP_array|CRISPR_based|qPCR|NGS_panel|cytogenetic|other — 9 candidates stripped; promote to reference product]',
    `assay_version_number` STRING COMMENT 'Version identifier for the assay configuration (e.g., v1.0, v2.1). Incremented when assay parameters, panel content, or pipeline change.. Valid values are `^v[0-9]+.[0-9]+(.[0-9]+)?$`',
    `cap_accreditation_flag` BOOLEAN COMMENT 'Indicates whether the test is performed in a CAP-accredited laboratory. True=CAP accredited, False=not CAP accredited.',
    `change_rationale` STRING COMMENT 'Business and technical justification for the assay version change (e.g., improved sensitivity, updated gene panel, regulatory requirement, pipeline optimization).',
    `clinical_validity_evidence` STRING COMMENT 'Summary of evidence supporting the clinical validity of the test (e.g., peer-reviewed publications, clinical trial data, professional guidelines).',
    `cpt_code` STRING COMMENT 'Five-digit CPT billing code used for reimbursement and insurance claims for the clinical test.. Valid values are `^[0-9]{5}$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this test catalog record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this test catalog record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this assay version became active and available for clinical ordering.',
    `intended_use_category` STRING COMMENT 'Regulatory classification of the test. IVD=In Vitro Diagnostic (FDA-cleared or CE-marked for clinical use), RUO=Research Use Only (not for clinical decision-making), LDT=Laboratory Developed Test (CLIA-validated for clinical use).. Valid values are `IVD|RUO|LDT`',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this test catalog record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this test catalog record was last updated.',
    `limit_of_detection` STRING COMMENT 'Analytical performance metric: the lowest quantity of analyte that can be reliably detected. Expressed with units (e.g., 5% variant allele frequency, 10 copies/mL).',
    `ordering_physician_specialty` STRING COMMENT 'Target physician specialties for which this test is intended (e.g., Medical Oncology, Genetic Counseling, Cardiology, Pediatrics). Multiple specialties may be listed.',
    `panel_gene_list_version` STRING COMMENT 'Version identifier for the gene panel content (applicable to targeted panels). Tracks which genes are included in this assay version.',
    `phi_compliant_flag` BOOLEAN COMMENT 'Indicates whether the test workflow and data handling are compliant with PHI protection requirements. True=compliant, False=not compliant.',
    `price_usd` DECIMAL(18,2) COMMENT 'List price of the clinical test in USD. Used for quotations, billing, and revenue recognition.',
    `reflex_testing_rules` STRING COMMENT 'Conditional logic for automatic follow-up testing based on initial results (e.g., if variant detected in gene X, reflex to confirmatory Sanger sequencing).',
    `reimbursement_eligible_flag` BOOLEAN COMMENT 'Indicates whether the test is eligible for insurance reimbursement. True=eligible, False=not eligible (patient pay only).',
    `retired_date` DATE COMMENT 'Date when this assay version was retired and no longer available for new orders. Nullable for currently active versions.',
    `specimen_type` STRING COMMENT 'Accepted biological specimen types for the assay (e.g., whole blood, saliva, buccal swab, tissue biopsy, FFPE tissue, plasma, serum). Multiple types may be listed as comma-separated values.',
    `test_description` STRING COMMENT 'Detailed description of the clinical assay, including methodology, clinical indications, and intended use statement.',
    `test_menu_category` STRING COMMENT 'Organizational category for grouping tests in the clinical test menu (e.g., Oncology, Cardiology, Rare Disease, Pharmacogenomics, Infectious Disease).',
    `test_name` STRING COMMENT 'Human-readable name of the clinical assay as displayed in test menus, requisition forms, and clinical reports.',
    `test_status` STRING COMMENT 'Current lifecycle status of the test in the catalog. active=available for ordering, inactive=temporarily unavailable, pending_approval=awaiting regulatory or internal approval, discontinued=permanently retired, under_review=undergoing quality or compliance review.. Valid values are `active|inactive|pending_approval|discontinued|under_review`',
    `turnaround_time_hours` STRING COMMENT 'Committed turnaround time from specimen receipt to report delivery, measured in hours. Used for SLA tracking and customer expectations.',
    `validation_status` STRING COMMENT 'Current validation state of the assay version. validated=analytical and clinical validation complete, in_validation=validation studies in progress, pending_validation=awaiting validation, failed_validation=did not meet acceptance criteria, not_required=validation not applicable.. Valid values are `validated|in_validation|pending_validation|failed_validation|not_required`',
    CONSTRAINT pk_test_catalog PRIMARY KEY(`test_catalog_id`)
) COMMENT 'Authoritative master catalog of all IVD (In Vitro Diagnostic) and LDT (Laboratory Developed Test) clinical assays offered by Genomics Biotech, including versioned assay configurations. Captures test code, test name, assay type (WGS, WES, targeted panel, SNP array, CRISPR-based), intended use (RUO vs IVD), regulatory clearance status (FDA 510(k)/PMA, CE-IVD), CLIA/CAP accreditation scope, specimen types accepted, TAT commitments, CPT billing codes, assay version history (version number, effective/retired dates, reference genome build, panel gene list version, pipeline version, validation status, change rationale), and reflex testing rules. SSOT for the clinical test menu and assay version traceability.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` (
    `assay_version_id` BIGINT COMMENT 'Unique identifier for each version of a clinical assay configuration. Primary key for the clinical assay version entity.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Each assay version must be covered by a specific regulatory approval (FDA clearance, CE-IVD marking). Labeling compliance, post-market obligations, and version retirement decisions all require knowing',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Assay versions specify approved suppliers for critical reagents as part of analytical validation and supply chain risk management. Enables supplier qualification tracking, dual-source strategies, and ',
    `assay_id` BIGINT COMMENT 'Reference to the parent clinical assay in the IVD (In Vitro Diagnostic) test catalog. Links this version to the base assay definition.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Clinical assay versions are commercial products requiring catalog linkage for pricing, regulatory classification, lifecycle management, and revenue recognition. Essential for product lifecycle trackin',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Assay version changes (pipeline updates, panel modifications, LOD changes, reference genome updates) require change control for impact assessment, validation, training, and regulatory submission. 21 C',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Assay versions must reference their governing SOPs, protocols, and validation documents for regulatory compliance (CLIA/CAP/FDA). Critical for version control and traceability of analytical methods to',
    `labeling_id` BIGINT COMMENT 'Foreign key linking to regulatory.labeling. Business justification: Each assay version has a specific approved labeling document (IFU, package insert) governing its intended use and performance claims. Regulatory change control requires linking assay version changes t',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Each assay version locks specific library prep kit as material for regulatory validation and reproducibility. Critical for version control, change management, regulatory submissions (510k/PMA), and en',
    `manufacturing_bom_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_bom. Business justification: Each assay version is tied to a specific manufacturing BOM defining reagent components. Change control for assay versions requires knowing which manufacturing BOM version was used. This is a real IVD/',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.model. Business justification: Assay versions are validated against a specific instrument model per CAP/CLIA requirements. Change control and revalidation are triggered when the instrument model changes. sequencing_platform and ',
    `molecular_design_id` BIGINT COMMENT 'Foreign key linking to research.molecular_design. Business justification: Each clinical assay version is built on a specific molecular design (probe set, primer panel, guide RNA). IP management and design change control require traceability from deployed assay version to th',
    `software_release_id` BIGINT COMMENT 'Foreign key linking to product.software_release. Business justification: Regulatory submissions (FDA, CLIA) require each assay version to reference the exact bioinformatics pipeline software release used. assay_version.bioinformatics_pipeline_version is a denormalized stri',
    `pipeline_version_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_version. Business justification: Each assay version is validated against a specific pipeline version — mandatory for CAP/CLIA and FDA IVD submissions. bioinformatics_pipeline_version on assay_version is a denormalized string; this ',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Clinical assay versions are manufactured as reagent batches. Traceability required for lot genealogy, adverse event investigations, and post-market surveillance per 21 CFR Part 820.65. Enables root ca',
    `qc_specification_id` BIGINT COMMENT 'Foreign key linking to reagent.qc_specification. Business justification: Each assay version locks in specific reagent QC specifications as part of analytical validation and change control. When an assay version is updated, the linked reagent QC spec change must be document',
    `submission_id` BIGINT COMMENT 'Identifier of the regulatory submission (FDA 510(k), PMA, or EU IVDR technical documentation) associated with this assay version. Links to regulatory approval documentation.',
    `research_protocol_id` BIGINT COMMENT 'Foreign key linking to research.research_protocol. Business justification: CAP/CLIA inspections require traceability from each deployed assay version to the validated research protocol specifying library prep, sequencing parameters, and bioinformatics pipeline. No existing c',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to quality.risk_assessment. Business justification: Each assay version requires a formal FMEA/risk assessment per ISO 13485 before clinical deployment. assay_version already links to change_control and controlled_document but not risk_assessment. This ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Assay versions require specific SKU linkage for lot traceability, regulatory compliance (21 CFR Part 820), inventory management, and configuration control. Critical for CLIA/CAP compliance and post-ma',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Each assay version is analytically validated against a specific product specification defining acceptance criteria (coverage depth, Q30, LOD). This FK is required for CLIA/CAP regulatory submissions a',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to clinical.test_catalog. Business justification: assay_version tracks versioned configurations of each clinical assay in the IVD test catalog. test_catalog is the authoritative master catalog entry. Each assay_version belongs to exactly one test_cat',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: Assay versions are validated against specific reagent batches; regulatory submissions (FDA 510k, LDT documentation) and change control records must cite the validated batch. Introducing a new batch re',
    `analytical_validation_date` DATE COMMENT 'Date when analytical validation study was completed and approved for this assay version. Required for regulatory submissions and laboratory accreditation.',
    `analytical_validation_status` STRING COMMENT 'Status of the analytical validation study for this assay version. Completed and approved status required before version can be activated for clinical use. Tracks compliance with CLIA and CAP requirements.. Valid values are `not_started|in_progress|completed|approved|failed`',
    `annotation_database_version` STRING COMMENT 'Version of the variant annotation database used for clinical interpretation (e.g., ClinVar version, dbSNP build, COSMIC version). Database version affects variant classification and clinical significance assignment.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this assay version was formally approved for clinical use. Part of the regulatory audit trail required for CLIA and CAP compliance.',
    `change_rationale` STRING COMMENT 'Business and technical justification for creating this new assay version. Documents reasons such as improved analytical performance, updated reference genome, regulatory requirement, or bug fix. Required for regulatory audit trail.',
    `clia_complexity` STRING COMMENT 'CLIA complexity categorization for this assay version. Waived tests have lowest complexity; high complexity tests require specialized personnel and quality systems. Determines laboratory accreditation requirements.. Valid values are `waived|moderate|high`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this assay version record was first created in the system. Part of the data lineage and audit trail.',
    `effective_date` DATE COMMENT 'Date when this assay version became or will become active for clinical use. All patient samples processed on or after this date use this version configuration.',
    `intended_use_statement` STRING COMMENT 'Regulatory-approved statement describing the clinical purpose and intended patient population for this assay version. Required for IVD labeling and marketing materials.',
    `library_preparation_protocol` STRING COMMENT 'Identifier or name of the library preparation protocol used for sample processing in this assay version. Links to detailed SOP (Standard Operating Procedure) documentation.',
    `lod_unit` STRING COMMENT 'Unit of measure for the LOD value (e.g., percent allele fraction, copies per microliter, ng/mL). Provides context for interpreting the LOD value.',
    `lod_value` DECIMAL(18,2) COMMENT 'Analytical sensitivity expressed as the lowest quantity of analyte (e.g., variant allele fraction, copy number) that can be reliably detected. Critical performance characteristic for IVD assays.',
    `minimum_coverage_depth` STRING COMMENT 'Minimum sequencing read depth required for confident variant calling in this assay version. Expressed as number of reads covering a genomic position. Critical QC (Quality Control) parameter for NGS (Next-Generation Sequencing) assays.',
    `minimum_phred_score` STRING COMMENT 'Minimum base quality score (Phred score) threshold for variant calling. Higher scores indicate higher confidence in base calls. Typical clinical thresholds are Q30 or higher.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this assay version record was last updated. Tracks configuration changes and supports change control processes.',
    `multiplexing_strategy` STRING COMMENT 'Strategy used for pooling multiple samples in a single sequencing run. Single index uses one barcode; dual index uses two barcodes for higher sample throughput and reduced index hopping.. Valid values are `none|single_index|dual_index|unique_dual_index`',
    `panel_gene_list_version` STRING COMMENT 'Version identifier of the curated gene list or panel used in this assay configuration. Tracks which genes are included in targeted sequencing or array-based assays. Essential for clinical validity documentation.',
    `retired_date` DATE COMMENT 'Date when this assay version was retired from active clinical use. Null if the version is still active or planned. Critical for traceability of which version was used for historical patient results.',
    `sensitivity_percentage` DECIMAL(18,2) COMMENT 'Percentage of true positive results correctly identified by the assay (true positives divided by true positives plus false negatives). Key analytical performance metric for clinical validity.',
    `specificity_percentage` DECIMAL(18,2) COMMENT 'Percentage of true negative results correctly identified by the assay (true negatives divided by true negatives plus false positives). Key analytical performance metric for clinical validity.',
    `target_read_length` STRING COMMENT 'Target length of sequencing reads in base pairs for this assay version. Affects ability to detect structural variants and map reads to repetitive regions.',
    `test_classification` STRING COMMENT 'Regulatory classification of the test: IVD (In Vitro Diagnostic) for FDA-cleared or CE-marked tests, LDT (Laboratory Developed Test) for CLIA-validated tests, or RUO (Research Use Only) for non-clinical tests.. Valid values are `IVD|LDT|RUO`',
    `turnaround_time_hours` STRING COMMENT 'Target time from sample receipt to report delivery for this assay version, measured in hours. Used for SLA (Service Level Agreement) tracking and operational planning.',
    `variant_calling_algorithm` STRING COMMENT 'Name and version of the primary variant calling algorithm used in this assay version (e.g., GATK HaplotypeCaller, FreeBayes, VarScan). Algorithm choice affects sensitivity and specificity of variant detection.',
    `version_number` STRING COMMENT 'Semantic version number of the clinical assay configuration (e.g., 1.0, 2.1, 3.0.1). Follows semantic versioning convention to track major and minor changes.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `version_status` STRING COMMENT 'Current lifecycle state of this assay version. Draft indicates under development; validation indicates undergoing analytical validation; active indicates approved for clinical use; deprecated indicates superseded but still in use; retired indicates no longer in use; withdrawn indicates removed from catalog due to regulatory or quality issues.. Valid values are `draft|validation|active|deprecated|retired|withdrawn`',
    CONSTRAINT pk_assay_version PRIMARY KEY(`assay_version_id`)
) COMMENT 'Tracks versioned configurations of each clinical assay in the IVD test catalog — capturing assay version number, effective date, retired date, reference genome build (GRCh38/hg38, T2T), panel gene list version, bioinformatics pipeline version, analytical validation status, and change rationale. Enables traceability of which assay version was used for any given patient result. Supports regulatory audit and post-market surveillance requirements.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`test_order` (
    `test_order_id` BIGINT COMMENT 'Unique identifier for the clinical test order. Primary key for the test order entity.',
    `account_id` BIGINT COMMENT 'Unique identifier for the healthcare institution or facility that placed the test order. Links to institution master data.',
    `aliquot_id` BIGINT COMMENT 'Foreign key linking to sample.aliquot. Business justification: In genomics labs, a test order consumes a specific aliquot (not just the parent specimen). CAP/CLIA audit trails and chain-of-custody reporting require traceability from test order to the exact physic',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Clinical test orders must be performed under a valid regulatory approval (FDA clearance, CLIA waiver, LDT exemption). Required for billing, reimbursement, and regulatory audit trails. CAP/CLIA inspect',
    `assay_version_id` BIGINT COMMENT 'Foreign key linking to clinical.assay_version. Business justification: test_order must reference the specific assay_version used to process the order. This is critical for clinical traceability — regulatory and CLIA requirements mandate knowing exactly which version of a',
    `authorized_orderer_id` BIGINT COMMENT 'Foreign key linking to clinical.authorized_orderer. Business justification: Test orders must link to the authorized orderer registry for credential verification, test menu access control, and regulatory compliance. Currently test_order only has ordering_physician_name and ord',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Test orders must reference catalog items for accurate billing, reimbursement code mapping (CPT/HCPCS), pricing, and revenue recognition. Essential for claims processing, revenue cycle management, and ',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Test orders require a validated specimen collection/shipping address for cold-chain logistics and courier routing. Genomics labs must link orders to customer.address to enforce cold-chain eligibility ',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to quality.complaint. Business justification: Customer complaints about genomic test results, TAT failures, or specimen handling are always traceable to a specific test order in genomics lab operations. quality.complaint has account_id and sku_id',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Test orders consume specific materials during execution; tracking material per order enables COGS calculation, inventory depletion, lot genealogy for regulatory traceability, and material usage varian',
    `contact_id` BIGINT COMMENT 'Unique identifier for the physician who ordered the clinical test. Links to physician master data.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Commercial clinical testing services (IVD tests sold to customers) should reference the sales order that initiated the test. This links clinical operations to commercial order fulfillment. The test_or',
    `accreditation_id` BIGINT COMMENT 'Foreign key linking to customer.accreditation. Business justification: Regulatory compliance requires verifying the ordering account holds valid CLIA/CAP accreditation before accepting a test order. cap_accreditation_number and clia_number are denormalized accreditation ',
    `patient_id` BIGINT COMMENT 'Unique identifier for the patient for whom the clinical test is ordered. Links to patient master data.',
    `performing_laboratory_id` BIGINT COMMENT 'Unique identifier for the CLIA-certified laboratory performing the clinical test. Links to laboratory master data.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Research-use-only (RUO) test orders executed under IRB protocols must link to research projects for consent verification, data use authorization tracking, research billing reconciliation, and IRB comp',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Send-out tests performed by external reference labs (suppliers) require tracking for performance monitoring, TAT compliance, quality metrics, and cost management. Enables supplier scorecard for refere',
    `sample_specimen_id` BIGINT COMMENT 'Foreign key linking to sample.sample_specimen. Business justification: Test orders reference the biobank specimen being analyzed. Real business need: LIMS workflow tracking, specimen consumption auditing, and regulatory compliance for clinical testing operations.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Enterprise genomics customers execute test orders under volume service agreements governing pricing tiers, TAT SLAs, and billing terms. Linking test_order to service_agreement enables contract complia',
    `study_id` BIGINT COMMENT 'Foreign key linking to research.study. Business justification: Research coordinators track test order completion against study enrollment milestones and research billing. test_order has rd_project_id but no direct study_id; study-level enrollment tracking require',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to clinical.test_catalog. Business justification: test_order is the core transactional record for a CLIA/CAP-accredited clinical test order. It has catalog_item_id → product.catalog_item (cross-domain product catalog) but lacks a direct in-domain lin',
    `accession_number` STRING COMMENT 'Unique laboratory-assigned identifier for the specimen associated with this test order. Used for specimen tracking throughout the laboratory workflow.. Valid values are `^[A-Z0-9]{8,20}$`',
    `accessioned_date` TIMESTAMP COMMENT 'Date and time when the specimen was accessioned into the Laboratory Information Management System (LIMS).',
    `actual_tat_hours` DECIMAL(18,2) COMMENT 'Actual turnaround time in hours from specimen receipt to result reporting. Used for performance monitoring and Service Level Agreement (SLA) compliance.',
    `billing_status` STRING COMMENT 'Current status of billing and reimbursement for the clinical test order.. Valid values are `pending|submitted|approved|denied|paid`',
    `clinical_indication` STRING COMMENT 'Clinical reason or indication for ordering the test, typically including symptoms, suspected conditions, or family history. Protected Health Information (PHI) under HIPAA.',
    `completed_date` TIMESTAMP COMMENT 'Date and time when the clinical test was completed and results were finalized.',
    `consent_date` DATE COMMENT 'Date when patient informed consent was obtained for the clinical genomic test.',
    `consent_status` STRING COMMENT 'Status of patient informed consent for the clinical genomic test. Required for genetic testing under HIPAA and state genetic privacy laws.. Valid values are `obtained|pending|declined|not_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test order record was first created in the system. Used for audit trail and data lineage.',
    `icd10_code` STRING COMMENT 'ICD-10 diagnosis code associated with the clinical indication for the test. Used for billing and medical necessity documentation. Protected Health Information (PHI) under HIPAA.. Valid values are `^[A-Z][0-9]{2}(.[0-9]{1,4})?$`',
    `insurance_authorization_number` STRING COMMENT 'Prior authorization number obtained from the patients insurance provider for coverage of the clinical test.. Valid values are `^AUTH-[A-Z0-9]{8,20}$`',
    `irb_protocol_number` STRING COMMENT 'IRB protocol number if the test order is part of a research study. Required for research use of clinical specimens.. Valid values are `^IRB-[A-Z0-9]{6,15}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the test order record was last modified in the system. Used for audit trail and data lineage.',
    `order_date` TIMESTAMP COMMENT 'Date and time when the clinical test order was placed by the ordering physician or institution.',
    `order_number` STRING COMMENT 'Business-facing unique order number for the clinical test order. Used for customer communication and order tracking.. Valid values are `^ORD-[0-9]{10}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the clinical test order in the laboratory workflow.. Valid values are `received|accessioned|in_progress|completed|cancelled|on_hold`',
    `ordering_institution_name` STRING COMMENT 'Name of the healthcare institution or facility that placed the test order.',
    `ordering_physician_npi` STRING COMMENT 'National Provider Identifier (NPI) for the ordering physician. Required for billing and regulatory reporting.. Valid values are `^[0-9]{10}$`',
    `patient_gender` STRING COMMENT 'Gender of the patient as recorded for clinical purposes. Protected Health Information (PHI) under HIPAA.. Valid values are `male|female|other|unknown`',
    `patient_medical_record_number` STRING COMMENT 'Medical record number assigned by the ordering institution for the patient. Protected Health Information (PHI) under HIPAA.. Valid values are `^MRN-[A-Z0-9]{6,15}$`',
    `priority` STRING COMMENT 'Priority level for processing the test order. STAT indicates immediate/emergency processing, urgent indicates expedited processing, routine indicates standard turnaround time (TAT).. Valid values are `STAT|urgent|routine`',
    `received_date` TIMESTAMP COMMENT 'Date and time when the test order was received by the laboratory.',
    `reported_date` TIMESTAMP COMMENT 'Date and time when the clinical test results were reported to the ordering physician.',
    `required_tat_hours` STRING COMMENT 'Required turnaround time in hours from specimen receipt to result reporting, based on test type and priority.',
    `specimen_collection_date` TIMESTAMP COMMENT 'Date and time when the specimen was collected from the patient.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected for the clinical test (e.g., blood, saliva, tissue biopsy).. Valid values are `blood|saliva|tissue|buccal_swab|bone_marrow|other`',
    `test_price_usd` DECIMAL(18,2) COMMENT 'List price of the clinical test in USD. Used for billing and revenue recognition.',
    CONSTRAINT pk_test_order PRIMARY KEY(`test_order_id`)
) COMMENT 'Core transactional record representing a CLIA/CAP-accredited clinical test order placed for a patient specimen. Captures ordering physician, ordering institution, patient demographics (PHI-compliant), test(s) ordered, clinical indication (ICD-10 codes), specimen accession number, priority (STAT vs routine), order date, required TAT, insurance/billing authorization, consent status, and IRB protocol reference where applicable. SSOT for clinical test order lifecycle.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`patient` (
    `patient_id` BIGINT COMMENT 'Unique identifier for the patient record within the clinical genomics system. Primary key for patient entity. Serves as the single source of truth for patient identity across all clinical workflows.',
    `address_line_1` STRING COMMENT 'Primary street address line for the patient. Used for clinical report mailing, specimen collection coordination, and patient identification. Subject to HIPAA PHI geographic subdivision restrictions for de-identification.',
    `address_line_2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number. Optional field used for complete patient address information.',
    `biological_sex` STRING COMMENT 'Biological sex of the patient as recorded for clinical genomic testing purposes. Critical for sex-chromosome analysis (X/Y), X-linked variant interpretation, and assay-specific quality control. Distinct from gender identity.. Valid values are `male|female|unknown`',
    `city` STRING COMMENT 'City of patient residence. Used for clinical report delivery and geographic analysis of patient populations. Subject to HIPAA de-identification rules for populations under 20,000.',
    `communication_preference` STRING COMMENT 'Patients preferred method for receiving clinical reports and test result notifications. Used to respect patient communication preferences and ensure HIPAA-compliant delivery of Protected Health Information (PHI).. Valid values are `email|phone|mail|patient portal|no contact`',
    `consent_date` DATE COMMENT 'Date when patient consent was obtained for clinical genomic testing. Used for consent validity tracking, audit trails, and regulatory compliance verification. Format: yyyy-MM-dd.',
    `consent_status` STRING COMMENT 'Current status of patient consent for clinical genomic testing and data usage. Tracks whether patient has provided informed consent, declined, or withdrawn consent. Critical for HIPAA authorization and GDPR lawful basis compliance.. Valid values are `consented|declined|pending|withdrawn|expired`',
    `consent_version` STRING COMMENT 'Version identifier of the consent form signed by the patient. Used to track which consent language and terms the patient agreed to, critical for regulatory audits and consent re-validation workflows.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of patient residence. Used for international clinical report delivery, regulatory compliance tracking, and cross-border genomic data sharing governance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient record was first created in the clinical genomics system. Used for audit trails, data lineage tracking, and regulatory compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `date_of_birth` DATE COMMENT 'Date of birth of the patient. Critical for patient identification, age-based clinical interpretation of genomic variants, pediatric vs adult assay selection, and HIPAA-compliant de-identification workflows. Format: yyyy-MM-dd.',
    `de_identification_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this patient record has been de-identified according to HIPAA Safe Harbor or Expert Determination methods. True indicates PHI has been removed for research or secondary use. Critical for genomic data sharing and research applications.',
    `email_address` STRING COMMENT 'Primary email address for patient communication. Used for secure clinical report delivery, test result notifications, and consent documentation. Must comply with HIPAA-compliant secure messaging requirements.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `ethnicity` STRING COMMENT 'Self-reported ethnicity of the patient. Used for population-specific genomic variant interpretation, ancestry-based allele frequency assessment, and precision medicine applications. Complements race data for clinical genomics analysis.',
    `first_name` STRING COMMENT 'Legal first name of the patient as recorded in the healthcare system. Used for patient identification, clinical report generation, and communication. Subject to HIPAA Protected Health Information (PHI) controls.',
    `gdpr_data_subject_rights_flag` BOOLEAN COMMENT 'Boolean flag indicating whether patient has exercised GDPR data subject rights (right to access, rectification, erasure, restriction, portability, or objection). True indicates active data subject request requiring special handling.',
    `gender_identity` STRING COMMENT 'Self-identified gender of the patient. Used for patient communication preferences and respectful clinical interactions. Distinct from biological sex used for genomic analysis.. Valid values are `male|female|non-binary|other|prefer not to say|unknown`',
    `guardian_email` STRING COMMENT 'Email address for the patients guardian or healthcare proxy. Used for secure clinical report delivery and communication when patient cannot receive reports directly.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `guardian_name` STRING COMMENT 'Full name of legal guardian or healthcare proxy authorized to make decisions on behalf of the patient. Required for pediatric patients and patients lacking decision-making capacity. Used for consent documentation and clinical report delivery.',
    `guardian_phone` STRING COMMENT 'Primary contact phone number for the patients guardian or healthcare proxy. Used for clinical report delivery, critical result communication, and consent verification when patient cannot be reached directly.. Valid values are `^+?[1-9]d{1,14}$`',
    `guardian_relationship` STRING COMMENT 'Type of relationship between the guardian/proxy and the patient. Used to verify legal authority for consent and clinical decision-making in pediatric and incapacitated patient cases.. Valid values are `parent|legal guardian|healthcare proxy|power of attorney|other`',
    `hipaa_authorization_flag` BOOLEAN COMMENT 'Boolean flag indicating whether patient has provided HIPAA authorization for use and disclosure of Protected Health Information (PHI) for clinical genomic testing and research purposes. True indicates authorization granted.',
    `insurance_group_number` STRING COMMENT 'Group number associated with the patients health insurance policy. Used for insurance verification and claims processing for clinical genomic testing services.',
    `insurance_policy_number` STRING COMMENT 'Patients health insurance policy or member identification number. Used for insurance verification, prior authorization, and claims submission for clinical genomic testing. Subject to HIPAA PHI controls.',
    `insurance_provider` STRING COMMENT 'Name of the patients primary health insurance provider. Used for billing, prior authorization, and reimbursement workflows for clinical genomic testing services.',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified the patient record. Used for audit trails, accountability tracking, and regulatory compliance verification. Not patient PII.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient record was last updated or modified. Used for audit trails, change tracking, and data synchronization across clinical systems. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_name` STRING COMMENT 'Legal last name (surname/family name) of the patient. Used for patient identification, clinical report generation, and communication. Subject to HIPAA Protected Health Information (PHI) controls.',
    `middle_name` STRING COMMENT 'Middle name or initial of the patient. Optional field used for complete patient identification and to reduce matching errors in clinical workflows.',
    `mrn` STRING COMMENT 'Medical Record Number assigned by the healthcare institution. Unique patient identifier used across clinical systems for patient identification and record linkage. Critical for specimen tracking and clinical report delivery.. Valid values are `^[A-Z0-9]{6,20}$`',
    `ordering_facility_name` STRING COMMENT 'Name of the healthcare facility or institution that ordered the clinical genomic test. Used for clinical report delivery, billing, and regulatory compliance tracking.',
    `patient_status` STRING COMMENT 'Current lifecycle status of the patient record. Active indicates patient is eligible for new test orders. Inactive indicates patient has not had recent activity. Deceased triggers special handling for posthumous data access. Merged indicates record consolidated with another MRN.. Valid values are `active|inactive|deceased|merged|test`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of patient residence. Used for clinical report delivery and geographic analysis. Subject to HIPAA de-identification rules requiring aggregation to first 3 digits for populations under 20,000.',
    `preferred_language` STRING COMMENT 'Preferred language for patient communication and clinical report delivery. Used to ensure culturally competent care and compliance with language access requirements. ISO 639-1 two-letter language codes recommended.',
    `primary_phone` STRING COMMENT 'Primary contact phone number for the patient. Used for clinical report delivery notifications, critical result communication, and patient consent verification. Subject to HIPAA PHI controls.. Valid values are `^+?[1-9]d{1,14}$`',
    `race` STRING COMMENT 'Self-reported race of the patient. Used for population-specific variant frequency analysis, ancestry-informed variant interpretation, and clinical genomics research. Critical for accurate Minor Allele Frequency (MAF) assessment and pathogenicity classification.',
    `referring_physician_name` STRING COMMENT 'Name of the physician or healthcare provider who referred the patient for clinical genomic testing. Used for clinical report delivery, result interpretation consultation, and billing. Not classified as patient PII.',
    `referring_physician_npi` STRING COMMENT 'National Provider Identifier (NPI) of the referring physician. 10-digit unique identifier used for healthcare provider identification, clinical report routing, and billing compliance. Required for CLIA-compliant test reporting.. Valid values are `^[0-9]{10}$`',
    `research_participation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether patient has consented to participate in genomic research studies. True indicates patient data and specimens may be used for IRB-approved research beyond clinical care. Distinct from clinical testing consent.',
    `state_province` STRING COMMENT 'State or province of patient residence. Used for clinical report delivery, regulatory compliance tracking, and state-specific Laboratory Developed Test (LDT) requirements.',
    CONSTRAINT pk_patient PRIMARY KEY(`patient_id`)
) COMMENT 'PHI-compliant master record for patients whose specimens are submitted for clinical genomic testing. Stores de-identified and identified patient demographics (name, DOB, sex, race/ethnicity, MRN), consent records, HIPAA authorization status, GDPR data subject rights flags, guardian/proxy relationships, and patient communication preferences. Governed under HIPAA/GDPR data handling policies. SSOT for patient identity within the clinical domain.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` (
    `clinical_specimen_id` BIGINT COMMENT 'Unique identifier for the clinical specimen record. Primary key for the clinical specimen entity.',
    `aliquot_id` BIGINT COMMENT 'Foreign key linking to sample.aliquot. Business justification: A clinical specimen received for testing is physically derived from a specific LIMS aliquot. Linking clinical_specimen to aliquot enables pre-analytical QC traceability, freeze-thaw cycle tracking, an',
    `authorized_orderer_id` BIGINT COMMENT 'Foreign key linking to clinical.authorized_orderer. Business justification: clinical_specimen has ordering_physician_name and ordering_physician_npi as denormalized string fields. authorized_orderer is the master registry of physicians authorized to order clinical genomic tes',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Specimen collection and processing consumes collection tubes, preservatives, extraction kits tracked as materials. Enables preanalytical workflow tracking, material lot traceability for quality invest',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Chain-of-custody and cold-chain compliance tracking require linking each specimen to the validated customer site address where it was collected. collection_site is a denormalized address field. Role-p',
    `parent_specimen_clinical_specimen_id` BIGINT COMMENT 'Identifier of the parent specimen if this record represents an aliquot or derivative specimen. Null for original specimens. Enables traceability of specimen lineage.',
    `patient_id` BIGINT COMMENT 'Unique identifier for the patient from whom the specimen was collected. Links specimen to patient demographics and clinical history. Protected Health Information (PHI) under HIPAA.',
    `qc_result_id` BIGINT COMMENT 'Foreign key linking to quality.qc_result. Business justification: Specimen preanalytical QC (DNA concentration, DIN, RIN, hemolysis index, clotting) generates qc_results that must be traceable to the specimen for acceptance/rejection decisions and preanalytical proc',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: CLIA/FDA lot-level traceability requires knowing which reagent lot processed each clinical specimen. Enables reagent recall impact assessment (which patient specimens were processed with recalled lot',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Specimens are processed using reagent batches. Batch traceability required for quality investigations when QC failures occur, enabling lot-specific CAPA and customer notifications. Critical for ISO 15',
    `sample_specimen_id` BIGINT COMMENT 'Foreign key linking to sample.sample_specimen. Business justification: Clinical specimens derive from biobank specimens for diagnostic testing. Real business need: CAP/CLIA chain-of-custody requirements, specimen provenance tracking, and quality control traceability in c',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to reagent.storage_location. Business justification: Clinical specimens are stored in the same cold-chain infrastructure as reagents. CLIA requires documented specimen storage conditions (temperature zone, humidity). The plain text storage_location co',
    `study_id` BIGINT COMMENT 'Foreign key linking to research.study. Business justification: Clinical specimens enrolled in IRB-approved research studies must be tracked for IRB compliance reporting and study enrollment dashboards. No existing column on clinical_specimen references research.s',
    `test_order_id` BIGINT COMMENT 'Unique identifier for the clinical test order associated with this specimen. Links specimen to the ordered IVD/LDT assay and clinical indication.',
    `accession_number` STRING COMMENT 'Unique laboratory-assigned identifier for specimen tracking through the clinical workflow. Externally-known business identifier used across LIMS, clinical reports, and regulatory submissions.. Valid values are `^[A-Z0-9]{8,20}$`',
    `aliquot_count` STRING COMMENT 'Number of aliquots created from the original specimen for testing, storage, or repeat analysis. Used for inventory management and specimen tracking.',
    `chain_of_custody_events` STRING COMMENT 'Comma-separated or structured log of chain-of-custody events tracking specimen handling from collection through testing. Includes timestamps, handler identifiers, and transfer locations. Critical for forensic and regulatory compliance.',
    `clinical_indication` STRING COMMENT 'Clinical reason or diagnosis code for ordering the genomic test. Examples: suspected hereditary cancer syndrome, pharmacogenomic screening, prenatal diagnosis. Used for test appropriateness review and variant interpretation.',
    `clotting_observed` BOOLEAN COMMENT 'Boolean flag indicating whether clotting was observed in the specimen upon receipt. Clotted specimens may yield insufficient DNA or introduce bias in cell-free DNA assays.',
    `collection_date` DATE COMMENT 'Date when the specimen was collected from the patient. Critical for calculating turnaround time (TAT) and pre-analytical stability assessment.',
    `collection_site_clia_number` STRING COMMENT 'CLIA certification number of the collection site if applicable. Required for regulatory compliance when collection site is a certified laboratory.. Valid values are `^[0-9]{2}D[0-9]{7}$`',
    `collection_time` TIMESTAMP COMMENT 'Precise timestamp when the specimen was collected from the patient. Used for time-sensitive pre-analytical quality assessments and cfDNA stability calculations.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding specimen collection, handling, quality, or special circumstances. Used for communication between laboratory staff and for audit documentation.',
    `consent_date` DATE COMMENT 'Date when patient consent was obtained for genomic testing. Used for audit trails and regulatory compliance verification.',
    `consent_obtained` BOOLEAN COMMENT 'Boolean flag indicating whether informed consent was obtained from the patient for genomic testing and data use. Required for compliance with IRB protocols and GDPR.',
    `container_type` STRING COMMENT 'Type of collection container or tube used for specimen transport. Examples: EDTA tube, PAXgene tube, Streck tube, OMNIgene tube, formalin jar. Impacts pre-analytical quality and DNA/RNA stability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this specimen record was first created in the LIMS. Used for audit trails and data lineage tracking.',
    `expiration_date` DATE COMMENT 'Date after which the specimen is no longer suitable for testing due to degradation or stability limits. Based on specimen type, storage conditions, and assay requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this specimen record was last modified in the LIMS. Used for audit trails and change tracking.',
    `preanalytical_qc_status` STRING COMMENT 'Overall pre-analytical quality control assessment status. Indicates whether specimen meets quality thresholds for downstream testing (Phred Score, DIN, RIN, hemolysis, clotting).. Valid values are `passed|failed|pending|not_applicable`',
    `quantity_received` DECIMAL(18,2) COMMENT 'Quantity of specimen received by the laboratory. May differ from collected volume due to aliquoting or partial submission. Unit depends on specimen type (ml for liquid, mg for tissue).',
    `quantity_unit` STRING COMMENT 'Unit of measure for the specimen quantity. Varies by specimen type: ml for blood/saliva, mg for tissue, ug for extracted DNA/RNA, cells for cell suspensions, slides for FFPE.. Valid values are `ml|mg|ug|cells|slides`',
    `received_date` DATE COMMENT 'Date when the specimen was received and accessioned by the clinical laboratory. Start point for laboratory TAT calculations.',
    `received_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the specimen was received and logged into the LIMS. Used for chain-of-custody documentation and pre-analytical time tracking.',
    `rejection_reason` STRING COMMENT 'Reason for specimen rejection if QC failed or specimen was deemed unsuitable for testing. Examples: insufficient volume, hemolyzed, mislabeled, expired transport time. Null if specimen was accepted.',
    `source_anatomical_site` STRING COMMENT 'Anatomical site or body location from which the specimen was collected. Examples: peripheral blood, bone marrow, lung tissue, colon biopsy. Critical for pathology correlation and variant interpretation.',
    `specimen_status` STRING COMMENT 'Current state of the specimen in the clinical laboratory workflow. Tracks progression from receipt through testing to final disposition.. Valid values are `received|in_processing|qc_passed|qc_failed|consumed|archived`',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected for genomic testing. Defines the material source for DNA/RNA extraction and sequencing.. Valid values are `blood|saliva|buccal_swab|ffpe|cfdna|tissue`',
    `storage_condition` STRING COMMENT 'Current storage temperature and condition for the specimen. Critical for maintaining specimen integrity and meeting pre-analytical quality requirements.. Valid values are `room_temp|refrigerated|frozen_minus20|frozen_minus80|liquid_nitrogen`',
    `volume_collected_ml` DECIMAL(18,2) COMMENT 'Volume of specimen collected in milliliters. Critical for determining sufficiency for testing and for calculating input quantities for library preparation.',
    CONSTRAINT pk_clinical_specimen PRIMARY KEY(`clinical_specimen_id`)
) COMMENT 'Clinical-domain representation of a patient specimen submitted for IVD/LDT testing. Captures specimen accession number, specimen type (blood, saliva, FFPE, cfDNA, buccal swab), collection date, collection site, volume/quantity, pre-analytical QC status (Phred Score thresholds, DIN, RIN), chain-of-custody events, storage conditions, and linkage to the patient and test order. Complements the sample domain SSOT with clinical-specific pre-analytical metadata.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` (
    `analytical_validation_id` BIGINT COMMENT 'Unique identifier for the analytical validation record. Primary key for the analytical validation entity.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Analytical validations are cited as supporting evidence in regulatory approvals (FDA 510(k)/PMA, CE-IVD technical file). Post-market surveillance and approval renewal require tracing which validations',
    `assay_development_id` BIGINT COMMENT 'Foreign key linking to research.assay_development. Business justification: Analytical validation studies validate specific assay development efforts. Required for regulatory submissions (510(k), PMA, LDT notifications), CLIA complexity determination, and CAP accreditation. L',
    `assay_version_id` BIGINT COMMENT 'Foreign key linking to clinical.assay_version. Business justification: analytical_validation records LOD, sensitivity, specificity, and other performance metrics for a specific clinical assay version. The existing ivd_test_catalog_id links to the catalog entry, but valid',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Validation studies are product-specific; catalog linkage essential for regulatory submissions (FDA 510k, IVDR technical files), product specification documentation, and lifecycle management. Critical ',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.deviation. Business justification: Deviations during analytical validation studies (reagent lot failures, instrument malfunctions, protocol departures) must be formally documented per CLIA/CAP and ISO 13485. analytical_validation has n',
    `equipment_qualification_id` BIGINT COMMENT 'Foreign key linking to manufacturing.equipment_qualification. Business justification: CLIA/CAP and FDA IVD regulations require that equipment used during analytical validation studies is formally qualified. Analytical validation reports must reference equipment qualification status; th',
    `test_catalog_id` BIGINT COMMENT 'Reference to the clinical assay being validated. Links this validation study to the specific assay version under evaluation.',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.model. Business justification: FDA/CLIA mandate that analytical validation studies document the specific instrument model used. Validation is platform-specific; a model change requires revalidation. This FK enables regulatory trace',
    `performing_laboratory_id` BIGINT COMMENT 'Foreign key linking to clinical.performing_laboratory. Business justification: analytical_validation records the analytical performance validation data for each clinical assay version. Validation studies are conducted at specific CLIA/CAP-accredited performing laboratories. This',
    `pipeline_version_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_version. Business justification: Analytical validations are performed against a specific pipeline version — directly required for FDA IVD submissions and CAP inspection documentation. No current FK exists; the assay_version path is i',
    `controlled_document_id` BIGINT COMMENT 'Reference to the controlled document containing the detailed validation study protocol. Links to document management system for version control and audit trail.',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: CLIA/FDA regulatory submissions require traceability from analytical validation results to the exact production batch of reagents/kits used. Genomics diagnostics QA teams routinely need this link to i',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: FDA/CLIA analytical validation studies must document the exact reagent lots used during validation. This is a named regulatory requirement for LDT and IVD submissions — the validation report must cite',
    `submission_id` BIGINT COMMENT 'Reference identifier for the FDA 510(k), PMA, or EMA submission that includes this validation data. Links validation records to regulatory approval documentation.',
    `research_protocol_id` BIGINT COMMENT 'Foreign key linking to research.research_protocol. Business justification: FDA and CAP regulatory submissions require traceability from analytical validation results to the governing research protocol defining methodology and acceptance criteria. No existing column on analyt',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to quality.risk_assessment. Business justification: Analytical validation protocols require a risk assessment (FMEA per CLSI EP23) to define acceptance criteria and identify failure modes before study execution. This FK links the validation study to it',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Analytical validation studies are performed against defined product specifications (LOD, sensitivity, specificity thresholds). CLIA/CAP and FDA IVD regulations require traceability from validation res',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: Analytical validation studies must document the exact reagent batch used; batch-to-batch variability is a key validation parameter per CLIA/CAP/FDA guidance. This FK enables regulatory audit traceabil',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: CLIA/CAP/FDA analytical validation reports must document the specific reagent materials used during validation studies. Reagent identity is a required element of validation documentation; supplier or ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Analytical validation studies must document the reagent supplier; a supplier change post-validation requires comparability testing per CLIA/CAP requirements. Supplier qualification status directly aff',
    `validation_study_id` BIGINT COMMENT 'Business identifier for the validation study protocol. Used for cross-referencing with study design documents and regulatory submissions.',
    `acceptance_criteria` STRING COMMENT 'Pre-defined performance thresholds that the assay must meet to pass validation. Includes specific numeric criteria for sensitivity, specificity, precision, accuracy, and other performance metrics.',
    `accuracy_bias` DECIMAL(18,2) COMMENT 'Systematic deviation of assay results from the true or reference value, expressed as a percentage. Positive bias indicates overestimation; negative bias indicates underestimation.',
    `analytical_sensitivity` DECIMAL(18,2) COMMENT 'Proportion of true positive results correctly identified by the assay, expressed as a percentage. Measures the assays ability to detect the target analyte when present.',
    `analytical_specificity` DECIMAL(18,2) COMMENT 'Proportion of true negative results correctly identified by the assay, expressed as a percentage. Measures the assays ability to correctly identify samples without the target analyte.',
    `approving_scientist_name` STRING COMMENT 'Full name of the qualified scientist or laboratory director who approved the validation study. Required for regulatory documentation and audit trails.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, deviations from protocol, or special considerations identified during the validation study. Used for capturing context not covered by structured fields.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this validation record was first created in the system. Part of the audit trail for data governance and compliance.',
    `intended_use` STRING COMMENT 'Regulatory classification of the assay. IVD (In Vitro Diagnostic) for FDA-cleared tests; RUO (Research Use Only) for non-clinical applications; LDT (Laboratory Developed Test) for CLIA-validated in-house assays.. Valid values are `ivd|ruo|ldt`',
    `interference_result` STRING COMMENT 'Overall determination of whether tested substances interfere with assay performance. No interference indicates acceptable performance; interference detected requires mitigation or sample rejection criteria; conditionally acceptable indicates interference only at extreme concentrations.. Valid values are `no_interference|interference_detected|conditionally_acceptable`',
    `interference_substances_tested` STRING COMMENT 'Comma-separated list of endogenous and exogenous substances evaluated for potential interference with assay performance. Common interferents include hemoglobin, lipids, bilirubin, and common medications.',
    `linearity_r_squared` DECIMAL(18,2) COMMENT 'Coefficient of determination for the linearity study regression analysis. Values closer to 1.0 indicate stronger linear relationship. Typical acceptance criterion is R² ≥ 0.95.',
    `linearity_range_lower` DECIMAL(18,2) COMMENT 'Lower boundary of the concentration range over which the assay demonstrates a linear relationship between input and output. Defines the minimum reportable value.',
    `linearity_range_unit` STRING COMMENT 'Unit of measurement for the linearity range boundaries. Must be consistent with LOD unit and assay measurement unit.',
    `linearity_range_upper` DECIMAL(18,2) COMMENT 'Upper boundary of the concentration range over which the assay demonstrates a linear relationship between input and output. Defines the maximum reportable value before dilution is required.',
    `lod_unit` STRING COMMENT 'Unit of measurement for the LOD value. Common units include ng/mL, copies/mL, percentage, or variant allele frequency depending on assay type.',
    `lod_value` DECIMAL(18,2) COMMENT 'Lowest concentration or quantity of analyte that can be reliably detected by the assay. Critical performance metric for regulatory approval and clinical interpretation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this validation record was last modified. Tracks changes for audit trail and data lineage purposes.',
    `pass_fail_determination` STRING COMMENT 'Final determination of whether the assay met all acceptance criteria. Pass indicates full approval for clinical use; fail requires remediation; conditional pass indicates approval with specific limitations or monitoring requirements.. Valid values are `pass|fail|conditional_pass`',
    `precision_repeatability` DECIMAL(18,2) COMMENT 'Coefficient of variation for within-run precision, expressed as a percentage. Measures consistency of results when the same sample is tested multiple times under identical conditions by the same operator.',
    `precision_reproducibility` DECIMAL(18,2) COMMENT 'Coefficient of variation for between-run precision, expressed as a percentage. Measures consistency of results across different runs, days, operators, and reagent lots.',
    `reference_population_description` STRING COMMENT 'Demographic and clinical characteristics of the population used to establish the reference range. Includes age range, sex distribution, ethnicity, and health status criteria.',
    `reference_range_lower` DECIMAL(18,2) COMMENT 'Lower boundary of the normal or expected range for the analyte in the reference population. Used for clinical interpretation of patient results.',
    `reference_range_unit` STRING COMMENT 'Unit of measurement for the reference range boundaries. Must be consistent with assay reporting unit.',
    `reference_range_upper` DECIMAL(18,2) COMMENT 'Upper boundary of the normal or expected range for the analyte in the reference population. Used for clinical interpretation of patient results.',
    `replicate_count` STRING COMMENT 'Number of replicate measurements performed for each sample in the validation study. Higher replicate counts improve precision estimates.',
    `sample_size` STRING COMMENT 'Total number of samples or replicates tested in the validation study. Adequate sample size is critical for statistical power and regulatory acceptance.',
    `validation_approval_date` DATE COMMENT 'Date when the validation study was formally approved by the laboratory director or quality assurance team. Authorizes the assay for clinical use or regulatory submission.',
    `validation_completion_date` DATE COMMENT 'Date when all validation testing was completed and results were finalized. Marks the end of the experimental phase before review and approval.',
    `validation_start_date` DATE COMMENT 'Date when the validation study was initiated. Used for tracking study duration and regulatory submission timelines.',
    `validation_status` STRING COMMENT 'Current lifecycle status of the validation study. Tracks progression from planning through execution to final approval or failure determination.. Valid values are `planned|in_progress|completed|approved|failed|on_hold`',
    `validation_type` STRING COMMENT 'Category of validation study performed. Initial validation establishes performance characteristics; revalidation confirms continued performance after changes; verification confirms manufacturer claims; method comparison evaluates against reference methods; bridging validates changes to existing validated assays.. Valid values are `initial|revalidation|verification|method_comparison|bridging`',
    CONSTRAINT pk_analytical_validation PRIMARY KEY(`analytical_validation_id`)
) COMMENT 'Records the analytical performance validation data for each clinical assay version — including LOD (Limit of Detection), analytical sensitivity, analytical specificity, precision (repeatability/reproducibility), accuracy, linearity, interference studies, and reference range establishment. Captures validation study design, number of replicates, acceptance criteria, pass/fail determination, validation date, and approving scientist. Required for CLIA/CAP accreditation and FDA/EMA regulatory submissions.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` (
    `genomic_result_id` BIGINT COMMENT 'Unique identifier for the genomic result record. Primary key for patient-level genomic findings generated from clinical assay runs.',
    `alignment_result_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.alignment_result. Business justification: Clinical results depend on alignment quality (coverage depth, mapping rate, uniformity). Linking enables QC validation workflows, troubleshooting failed clinical results based on alignment metrics, an',
    `assay_qc_run_id` BIGINT COMMENT 'Reference to the clinical assay run that generated this genomic result. Links to the laboratory execution event.',
    `assay_version_id` BIGINT COMMENT 'Reference to the clinical assay definition (IVD or LDT test catalog entry) used to generate this result.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_asset. Business justification: Clinical genomic results must maintain complete audit trail to the specific instrument that generated the sequencing data. Required for CAP/CLIA inspections, result investigations, and regulatory subm',
    `clinical_specimen_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_specimen. Business justification: genomic_result is generated from a completed clinical assay run on a patient specimen. It has sample_specimen_id → sample.sample_specimen (cross-domain) but lacks a direct link to clinical_specimen — ',
    `extraction_id` BIGINT COMMENT 'Foreign key linking to sample.extraction. Business justification: Genomic results must be traceable to the specific extraction used (input mass, purity, RIN score) for analytical validity assessment, variant calling QC, and regulatory submissions. This is a fundamen',
    `library_id` BIGINT COMMENT 'Foreign key linking to sequencing.library. Business justification: Genomic results (variants, CNVs) are derived from specific sequencing libraries. Essential for linking clinical findings back to the molecular data source, required for variant validation, reanalysis ',
    `patient_id` BIGINT COMMENT 'Unique identifier for the patient associated with this genomic result. Protected Health Information (PHI) under HIPAA.',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_run. Business justification: Clinical genomic results must trace to the exact bioinformatics pipeline execution that generated them. Essential for regulatory traceability (21 CFR Part 11), result validation, reanalysis workflows,',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Genomic results from research cohorts/studies link to originating projects for publication data sets, data sharing agreement compliance, IRB protocol adherence, and research billing. Essential for res',
    `report_id` BIGINT COMMENT 'Reference to the clinical report document that contains this genomic result. Links to the patient-facing report generation system.',
    `sequencing_run_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_run. Business justification: Genomic results are generated from specific sequencing runs. Essential for data lineage, quality tracking (correlating result quality with run QC metrics), and troubleshooting. Required for investigat',
    `study_id` BIGINT COMMENT 'Foreign key linking to research.study. Business justification: De-identified genomic results contributed to research studies (variant frequency cohorts, pharmacogenomics) require direct study linkage for cohort aggregation and publication. genomic_result has rd_p',
    `test_order_id` BIGINT COMMENT 'Reference to the clinical test order that requested this genomic analysis. Links to the ordering workflow.',
    `variant_call_result_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.variant_call_result. Business justification: Clinical genomic results report specific variants identified by bioinformatics variant calling. Direct link enables result verification, supports reanalysis when variant calling algorithms are updated',
    `variant_knowledge_base_id` BIGINT COMMENT 'Foreign key linking to clinical.variant_knowledge_base. Business justification: When a genomic result identifies a clinically significant variant, it should link to the curated internal knowledge base entry for that variant (if one exists). This provides access to historical obse',
    `acmg_classification_criteria` STRING COMMENT 'ACMG/AMP evidence codes applied during variant interpretation (e.g., PVS1, PS1, PM2, PP3). Documents the rationale for clinical significance classification.',
    `alternate_allele` STRING COMMENT 'The variant nucleotide sequence detected in the patient sample. Uses IUPAC nucleotide codes.',
    `chromosome` STRING COMMENT 'Chromosome on which the genomic variant is located. Uses standard nomenclature (1-22, X, Y, MT for mitochondrial).. Valid values are `^(chr)?([1-9]|1[0-9]|2[0-2]|X|Y|MT?)$`',
    `clinical_significance` STRING COMMENT 'ACMG/AMP classification of the variants clinical significance. Indicates the variants role in disease causation.. Valid values are `pathogenic|likely_pathogenic|uncertain_significance|likely_benign|benign`',
    `clinvar_accession` STRING COMMENT 'ClinVar database accession number for this variant. Links to public repository of variant-disease relationships.. Valid values are `^(VCV|RCV|SCV)[0-9]+`',
    `cosmic_accession` STRING COMMENT 'COSMIC database identifier for somatic variants. Used for oncology and cancer genomics results.. Valid values are `^COSM[0-9]+$`',
    `coverage_depth` STRING COMMENT 'Number of sequencing reads covering this genomic position. Quality metric indicating confidence in the variant call.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this genomic result record was first created in the system. Audit trail for data lineage.',
    `dbsnp_accession` STRING COMMENT 'dbSNP reference SNP cluster identifier (rsID) for this variant. Standard identifier for known genetic variants.. Valid values are `^rs[0-9]+$`',
    `disease_association` STRING COMMENT 'Known disease or phenotype associations for this variant. References conditions linked to the genetic finding.',
    `filter_status` STRING COMMENT 'Quality filter status applied during variant calling. PASS indicates the variant met all quality thresholds.. Valid values are `PASS|low_quality|low_coverage|strand_bias|failed`',
    `genomic_position_end` BIGINT COMMENT 'Ending chromosomal coordinate of the variant in base pairs. For single nucleotide variants, equals start position. Uses GRCh38 reference genome coordinates.',
    `genomic_position_start` BIGINT COMMENT 'Starting chromosomal coordinate of the variant in base pairs. Uses GRCh38 reference genome coordinates.',
    `hgvs_coding` STRING COMMENT 'HGVS notation for the variant at the coding DNA level (c. notation). Standard nomenclature for describing sequence variants.',
    `hgvs_protein` STRING COMMENT 'HGVS notation for the variant at the protein level (p. notation). Describes the predicted amino acid change.',
    `incidental_finding_flag` BOOLEAN COMMENT 'Indicates whether this result is an incidental or secondary finding not directly related to the primary test indication. Important for patient consent and reporting workflows.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this genomic result record was last updated. Tracks amendments, corrections, or status changes.',
    `maf_gnomad` DECIMAL(18,2) COMMENT 'Minor allele frequency of this variant in the gnomAD population database. Indicates how common the variant is in the general population.',
    `pharmacogenomic_implication` STRING COMMENT 'Clinical pharmacogenomic guidance associated with this variant. Describes drug response, dosing recommendations, or contraindications. Protected Health Information (PHI).',
    `phred_quality_score` DECIMAL(18,2) COMMENT 'Phred-scaled quality score for the variant call. Higher scores indicate greater confidence in the accuracy of the call.',
    `reference_allele` STRING COMMENT 'The nucleotide sequence present in the reference genome at this position. Uses IUPAC nucleotide codes.',
    `reporting_date` DATE COMMENT 'Date when the genomic result was officially reported to the ordering physician or patient. Key milestone for turnaround time (TAT) tracking.',
    `result_interpretation` STRING COMMENT 'Clinical interpretation narrative provided by the laboratory director or genetic counselor. Explains the clinical significance of the finding. Protected Health Information (PHI).',
    `result_status` STRING COMMENT 'Current lifecycle status of the genomic result. Indicates whether the result is preliminary, finalized, or has been modified.. Valid values are `preliminary|final|amended|corrected|cancelled`',
    `result_type` STRING COMMENT 'Classification of the genomic finding. Indicates the category of variant or genetic marker detected by the clinical assay.. Valid values are `snp_genotype|cnv_call|somatic_variant|germline_variant|pharmacogenomic_result|structural_variant`',
    `result_value` DECIMAL(18,2) COMMENT 'The primary genomic finding value. Format varies by result type: genotype call (e.g., A/G), copy number (e.g., 3), variant notation (e.g., c.1234G>A). Protected Health Information (PHI).',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the genomic result was reviewed and approved by qualified personnel.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the laboratory director, pathologist, or genetic counselor who reviewed and approved this result.',
    `variant_allele_frequency` DECIMAL(18,2) COMMENT 'Fraction of sequencing reads supporting the alternate allele at this position. Used to assess variant heterogeneity and quality.',
    `variant_classification` STRING COMMENT 'Functional classification of the variant based on its predicted impact on the gene product. [ENUM-REF-CANDIDATE: missense|nonsense|frameshift|splice_site|synonymous|intronic|utr|intergenic — 8 candidates stripped; promote to reference product]',
    `variant_database_version` STRING COMMENT 'Version identifier of the variant annotation databases (ClinVar, gnomAD, dbSNP) used for interpretation. Critical for result reproducibility.',
    `zygosity` STRING COMMENT 'Zygosity status of the detected variant. Indicates whether the variant is present on one or both chromosomes.. Valid values are `homozygous|heterozygous|hemizygous|not_applicable`',
    CONSTRAINT pk_genomic_result PRIMARY KEY(`genomic_result_id`)
) COMMENT 'Patient-level genomic result record generated from a completed clinical assay run. Stores result type (SNP genotype, CNV call, somatic variant, germline variant, pharmacogenomic result), result value, zygosity, chromosomal coordinates (GRCh38), gene symbol, transcript ID, HGVS nomenclature, ClinVar accession, MAF from gnomAD, coverage depth at locus, Phred quality score, result status (preliminary/final/amended/corrected), and reporting date. Core clinical output entity.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` (
    `variant_interpretation_id` BIGINT COMMENT 'Unique identifier for the clinical variant interpretation record. Primary key.',
    `assay_version_id` BIGINT COMMENT 'Reference to the clinical assay under which this variant was interpreted.',
    `clinical_specimen_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_specimen. Business justification: variant_interpretation captures the clinical classification of a genomic variant found in a patient specimen. It has sample_specimen_id → sample.sample_specimen (cross-domain) but lacks a direct link ',
    `genomic_result_id` BIGINT COMMENT 'Foreign key linking to clinical.genomic_result. Business justification: variant_interpretation captures the ACMG/AMP classification of a genomic variant. Each interpretation is performed on a specific genomic_result record (the raw variant call output). While variant_inte',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Variant interpretation must reference the specific version of ACMG guidelines, internal SOPs, or ClinGen expert panel recommendations used. Regulatory requirement for defensibility of clinical signifi',
    `library_id` BIGINT COMMENT 'Foreign key linking to sequencing.library. Business justification: Variant interpretations trace back to the library that generated the variant call. Required for clinical validation workflows, reanalysis when classifications change, and investigating discrepancies b',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Variant interpretations generated during research studies (not clinical service) link to projects for publication, knowledge base curation, ClinVar submissions, and research data sharing. Distinguishe',
    `report_id` BIGINT COMMENT 'Foreign key linking to clinical.report. Business justification: variant_interpretation has a report_inclusion_flag indicating whether the interpretation should be included in the clinical report. Adding report_id FK directly links each variant interpretation to th',
    `test_order_id` BIGINT COMMENT 'Reference to the clinical test order for which this variant interpretation was performed.',
    `variant_annotation_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.variant_annotation. Business justification: Clinical variant interpretations (ACMG classification) leverage bioinformatics annotations (SIFT, PolyPhen, CADD, ClinVar, gnomAD MAF). Essential for clinical decision support, ensures interpretations',
    `variant_call_result_id` BIGINT COMMENT 'Reference to the bioinformatics variant call that this interpretation is based on.',
    `variant_knowledge_base_id` BIGINT COMMENT 'Foreign key linking to clinical.variant_knowledge_base. Business justification: variant_interpretation classifies a genomic variant per ACMG/AMP guidelines. The variant_knowledge_base is the curated internal knowledge base of clinically significant variants. Interpreters consult ',
    `accreditation_scope` STRING COMMENT 'Regulatory accreditation scope under which this interpretation was performed: CLIA (Clinical Laboratory Improvement Amendments), CAP (College of American Pathologists), ISO 15189, CE-IVD (Conformité Européenne In Vitro Diagnostic), or RUO (Research Use Only).. Valid values are `CLIA|CAP|ISO_15189|CE_IVD|RUO`',
    `acmg_classification` STRING COMMENT 'Clinical significance classification per ACMG/AMP guidelines: pathogenic, likely pathogenic, VUS (Variant of Uncertain Significance), likely benign, or benign.. Valid values are `pathogenic|likely_pathogenic|VUS|likely_benign|benign`',
    `acmg_evidence_codes` STRING COMMENT 'Comma-separated list of ACMG/AMP evidence codes applied to support the classification (e.g., PVS1, PS1, PM2, PP3, BA1, BS1, BP4).',
    `allele_frequency` DECIMAL(18,2) COMMENT 'Population allele frequency of this variant from reference databases (e.g., gnomAD).',
    `alternate_allele` STRING COMMENT 'The observed variant nucleotide sequence that differs from the reference.',
    `chromosome` STRING COMMENT 'Chromosome on which the variant is located (1-22, X, Y, M/MT).. Valid values are `^(chr)?(1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|X|Y|M|MT)$`',
    `classification_version` STRING COMMENT 'Version number of the classification, incremented when the interpretation is updated or reclassified.',
    `clinical_significance` STRING COMMENT 'Narrative description of the clinical significance of the variant, including disease association and expected phenotype.',
    `clinvar_accession` STRING COMMENT 'ClinVar accession number for this variant if previously submitted.',
    `clinvar_classification` STRING COMMENT 'Clinical significance classification from ClinVar database.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant interpretation record was first created in the system.',
    `disease_association` STRING COMMENT 'Name of the disease or condition associated with this variant (e.g., Cystic Fibrosis, Hereditary Breast and Ovarian Cancer Syndrome).',
    `genomic_position` BIGINT COMMENT 'Genomic coordinate of the variant on the reference genome.',
    `guideline_version` STRING COMMENT 'Version of the ACMG/AMP or other clinical guidelines used for this interpretation (e.g., ACMG 2015, ClinGen 2018).',
    `inheritance_pattern` STRING COMMENT 'Mode of inheritance for the disease associated with this variant: autosomal dominant, autosomal recessive, X-linked dominant, X-linked recessive, mitochondrial, or multifactorial.. Valid values are `autosomal_dominant|autosomal_recessive|X_linked_dominant|X_linked_recessive|mitochondrial|multifactorial`',
    `interpretation_date` DATE COMMENT 'Date when the variant interpretation was completed.',
    `interpretation_rationale` STRING COMMENT 'Detailed rationale and evidence summary supporting the variant classification, including literature references and functional studies.',
    `interpretation_status` STRING COMMENT 'Current lifecycle status of the interpretation: draft, final, amended, reviewed, or archived.. Valid values are `draft|final|amended|reviewed|archived`',
    `literature_references` STRING COMMENT 'Comma-separated list of PubMed IDs (PMIDs) or DOIs of publications supporting the interpretation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant interpretation record was last modified.',
    `mondo_accession` STRING COMMENT 'MONDO ontology identifier for the associated disease.',
    `omim_accession` STRING COMMENT 'OMIM identifier for the associated disease or phenotype.',
    `phi_flag` BOOLEAN COMMENT 'Indicates whether this record contains Protected Health Information subject to HIPAA regulations.',
    `population_database` STRING COMMENT 'Name of the population frequency database used (e.g., gnomAD, 1000 Genomes, ExAC).',
    `reference_allele` STRING COMMENT 'The nucleotide sequence in the reference genome at this position.',
    `report_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this variant interpretation should be included in the clinical report delivered to the ordering physician.',
    `review_date` DATE COMMENT 'Date when the interpretation was last reviewed or updated.',
    `variant_consequence` STRING COMMENT 'Predicted functional consequence of the variant on the protein (e.g., missense, nonsense, frameshift, splice site, synonymous).',
    `variant_identifier` STRING COMMENT 'Human-readable identifier for the genomic variant, typically in HGVS notation (e.g., NM_000059.3:c.1521_1523delCTT).',
    `variant_type` STRING COMMENT 'Type of genomic variant: SNV (Single Nucleotide Variant), insertion, deletion, indel, duplication, inversion, CNV (Copy Number Variation), or structural. [ENUM-REF-CANDIDATE: SNV|insertion|deletion|indel|duplication|inversion|CNV|structural — 8 candidates stripped; promote to reference product]',
    `zygosity` STRING COMMENT 'Zygosity status of the variant in the patient: heterozygous, homozygous, hemizygous, or compound heterozygous.. Valid values are `heterozygous|homozygous|hemizygous|compound_heterozygous`',
    CONSTRAINT pk_variant_interpretation PRIMARY KEY(`variant_interpretation_id`)
) COMMENT 'Clinical variant interpretation record capturing the classification of a genomic variant per ACMG/AMP guidelines (Pathogenic, Likely Pathogenic, VUS, Likely Benign, Benign), evidence codes applied (PVS1, PS1-4, PM1-6, PP1-5, BA1, BS1-4, BP1-7), interpretation rationale, disease association (OMIM/MONDO), inheritance pattern, clinical significance narrative, interpreting molecular pathologist, review date, and classification version. SSOT for variant-level clinical interpretation.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`report` (
    `report_id` BIGINT COMMENT 'Unique identifier for the clinical genomics report. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Report delivery and billing reconciliation require knowing which customer account receives each report. ordering_facility_name is a denormalized account field. Genomics lab operations track report del',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Clinical reports must cite the regulatory approval/clearance of the assay to establish legal defensibility and intended use compliance. Required for medical-legal review and payer audits. Standard pra',
    `assay_version_id` BIGINT COMMENT 'Foreign key linking to clinical.assay_version. Business justification: report contains assay_name and assay_version as denormalized string fields. Adding assay_version_id FK links the finalized clinical report to the exact assay version used, enabling regulatory traceabi',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_asset. Business justification: Clinical reports document testing methodology including the specific instrument used, especially for IVD assays where instrument serial number and validation status are part of regulatory documentatio',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Clinical report templates and interpretation format documents are controlled documents under CLIA/CAP accreditation. The report product has no existing controlled_document link. Linking report to its ',
    `patient_id` BIGINT COMMENT 'Foreign key linking to clinical.patient. Business justification: report is the finalized clinical genomics report delivered to the ordering physician and patient. While report.test_order_id → test_order → patient_id provides an indirect path, a direct patient_id FK',
    `software_release_id` BIGINT COMMENT 'Foreign key linking to product.software_release. Business justification: Clinical genomics reports must document the exact pipeline software version used for variant calling — required by CAP/CLIA and for regulatory audit. report.pipeline_version is a denormalized string; ',
    `pipeline_version_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_version. Business justification: Clinical genomics reports must document the exact pipeline version used — a CAP/CLIA and regulatory requirement for audit trails and report amendments. pipeline_version on report is a denormalized s',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Research reports (non-clinical service) issued under IRB protocols link to projects for regulatory compliance, publication data sets, and data sharing agreements. Distinguishes research reports from c',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: CAP/CLIA compliance requires clinical reports to be traceable to the reagent lot used to generate results. Genomics diagnostic reports must document reagent lot information; this link enables lot-leve',
    `sequencing_run_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_run. Business justification: Clinical reports must cite the sequencing run that generated the reported data. Regulatory requirement for diagnostic reporting under CLIA/CAP - reports must include sufficient detail to trace finding',
    `study_id` BIGINT COMMENT 'Foreign key linking to research.study. Business justification: Clinical reports for research study participants must reference the study for IRB compliance, data sharing obligations, and study closeout reporting. report has rd_project_id but no direct study_id; d',
    `test_order_id` BIGINT COMMENT 'Reference to the clinical test order that generated this report.',
    `amended_content` STRING COMMENT 'Description of the specific content that was amended, corrected, or added in this version of the report.',
    `amendment_date` DATE COMMENT 'Date the amendment was made to the report.',
    `amendment_notification_status` STRING COMMENT 'Status of notification to the ordering physician regarding the amendment (pending, notified, acknowledged).. Valid values are `pending|notified|acknowledged`',
    `amendment_reason` STRING COMMENT 'Detailed explanation of the reason for the amendment, including what was changed and why.',
    `amendment_type` STRING COMMENT 'Type of amendment applied to the report (e.g., correction of error, addendum with new information, clarification, retraction).. Valid values are `correction|addendum|clarification|retraction`',
    `assay_name` STRING COMMENT 'Name of the clinical genomics assay performed (e.g., Whole Exome Sequencing (WES), targeted gene panel).',
    `assay_version` STRING COMMENT 'Version identifier of the assay used, including pipeline and reagent versions.',
    `authorizing_pathologist_credentials` STRING COMMENT 'Professional credentials of the authorizing pathologist (e.g., MD, PhD, FACMG).',
    `authorizing_pathologist_name` STRING COMMENT 'Full name of the board-certified pathologist or laboratory director who authorized and electronically signed the report.',
    `clinical_interpretation` STRING COMMENT 'Detailed clinical interpretation narrative explaining the significance of the findings, disease associations, and clinical context.',
    `confirmatory_testing_recommended_flag` BOOLEAN COMMENT 'Indicates whether confirmatory testing (e.g., Sanger sequencing) is recommended to validate the findings.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created the clinical report record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the clinical report record was first created in the system.',
    `delivery_method` STRING COMMENT 'Method by which the report was delivered to the ordering physician and patient (e.g., Electronic Health Record (EHR) integration, secure portal, encrypted email).. Valid values are `ehr_integration|secure_portal|email|fax|mail`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time the report was delivered to the ordering physician.',
    `electronic_signature` STRING COMMENT 'Electronic signature or digital signature token of the authorizing pathologist, ensuring report authenticity and non-repudiation.',
    `finalized_timestamp` TIMESTAMP COMMENT 'Date and time the report was finalized and authorized for release.',
    `format` STRING COMMENT 'Format in which the clinical report is delivered (e.g., PDF, HL7 FHIR, HL7 v2).. Valid values are `pdf|hl7_fhir|hl7_v2|xml`',
    `genetic_counseling_recommended_flag` BOOLEAN COMMENT 'Indicates whether genetic counseling is recommended for the patient based on the findings.',
    `language` STRING COMMENT 'Language in which the clinical report is written (e.g., English, Spanish, French), using ISO 639-1 two-letter codes.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the clinical report record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the clinical report record was last modified.',
    `ordering_physician_name` STRING COMMENT 'Full name of the physician who ordered the clinical genomics test.',
    `ordering_physician_npi` STRING COMMENT 'National Provider Identifier (NPI) of the ordering physician, used for billing and regulatory tracking.',
    `patient_date_of_birth` DATE COMMENT 'Date of birth of the patient, used for identity verification and age-related clinical interpretation.',
    `patient_identifier` STRING COMMENT 'De-identified or pseudonymized patient identifier compliant with Protected Health Information (PHI) regulations.',
    `patient_sex` STRING COMMENT 'Biological sex of the patient, relevant for sex-linked genetic variant interpretation.. Valid values are `male|female|unknown`',
    `phi_compliant_flag` BOOLEAN COMMENT 'Indicates whether the report has been reviewed and confirmed to be compliant with Protected Health Information (PHI) regulations.',
    `recommendations` STRING COMMENT 'Clinical recommendations provided to the ordering physician, including genetic counseling, confirmatory testing, family screening, or treatment implications.',
    `report_number` STRING COMMENT 'Externally-visible unique report identifier used for physician and patient communication.',
    `report_status` STRING COMMENT 'Current lifecycle status of the clinical report.. Valid values are `draft|preliminary|final|amended|corrected|retracted`',
    `result_summary` STRING COMMENT 'High-level summary of the genomic test result: positive (pathogenic variant detected), negative (no pathogenic variant detected), inconclusive, or Variant of Uncertain Significance (VUS) detected.. Valid values are `positive|negative|inconclusive|variant_of_uncertain_significance`',
    `specimen_collection_date` DATE COMMENT 'Date the specimen was collected from the patient.',
    `specimen_type` STRING COMMENT 'Type of biological specimen analyzed (e.g., whole blood, saliva, tissue biopsy).',
    `turnaround_time_hours` STRING COMMENT 'Actual turnaround time from specimen receipt to report finalization, measured in hours.',
    `variant_findings_summary` STRING COMMENT 'Textual summary of key variant findings included in the report, listing genes and variant classifications.',
    `version` STRING COMMENT 'Version number of this report, incremented with each amendment or correction.',
    CONSTRAINT pk_report PRIMARY KEY(`report_id`)
) COMMENT 'Finalized clinical genomics report delivered to the ordering physician and patient, including full amendment lifecycle. Captures report ID, associated test order, patient demographics summary, assay name and version, result summary (positive/negative/inconclusive/VUS), variant findings included, clinical interpretation narrative, recommendations (genetic counseling, confirmatory testing, treatment implications), report format (PDF/HL7 FHIR), delivery method, delivery timestamp, report status (draft/final/amended/corrected/retracted), electronic signature of authorizing pathologist, amendment history (amendment type, reason, amended content, amendment date, notification status to ordering physician). Supports CLIA/CAP amendment tracking requirements and patient safety audit trails.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` (
    `variant_knowledge_base_id` BIGINT COMMENT 'Unique identifier for the variant knowledge base entry. Primary key for the curated internal repository of clinically significant variants observed in Genomics Biotechs patient population.',
    `assay_development_id` BIGINT COMMENT 'Foreign key linking to research.assay_development. Business justification: Variant curation teams trace clinical significance classifications in the knowledge base to the assay development program that generated supporting functional evidence. ClinVar submissions require thi',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Variant knowledge base updates (reclassifications, new evidence incorporation, ACMG criteria changes) require formal change control in GxP genomics labs per CAP/ACMG guidelines. This FK links VKB entr',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Variant knowledge base curation must follow documented SOPs for evidence evaluation, ACMG criteria application, literature review, and ClinVar submission. Required for CAP molecular pathology accredit',
    `study_id` BIGINT COMMENT 'Foreign key linking to research.study. Business justification: ACMG variant classification audits and ClinVar submissions require traceability from knowledge base entries to the internal research study that generated supporting case-control or functional genomics',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Internal variant databases track which variants were included in regulatory submission evidence packages (analytical/clinical validation). Required for maintaining traceability between curated knowled',
    `acmg_classification` STRING COMMENT 'Current ACMG/AMP clinical significance classification of the variant. Represents the most recent expert interpretation of the variants pathogenicity.. Valid values are `pathogenic|likely pathogenic|uncertain significance|likely benign|benign`',
    `acmg_classification_date` DATE COMMENT 'Date when the current ACMG classification was assigned. Critical for tracking classification currency and reanalysis requirements.',
    `acmg_criteria_applied` STRING COMMENT 'Comma-separated list of ACMG/AMP evidence codes applied in the classification (e.g., PVS1, PS3, PM2, PP3). Documents the evidence basis for the classification.',
    `alternate_allele` STRING COMMENT 'Alternate nucleotide sequence observed at the variant position. Represents the variant allele.',
    `chromosome` STRING COMMENT 'Chromosome on which the variant is located (e.g., chr17, chrX, chrMT). Follows standard chromosome nomenclature.. Valid values are `^(chr)?([1-9]|1[0-9]|2[0-2]|X|Y|MT?)$`',
    `clingen_expert_panel_name` STRING COMMENT 'Name of the ClinGen expert panel that reviewed this variant (e.g., Hereditary Cancer Clinical Domain Working Group). Null if not reviewed by ClinGen.',
    `clingen_expert_panel_review_status` STRING COMMENT 'Status of ClinGen expert panel review for this variant. Indicates whether the variant has been evaluated by a disease-specific expert panel.. Valid values are `not reviewed|under review|reviewed|approved|disputed`',
    `clinical_actionability` STRING COMMENT 'Assessment of whether the variant has clinical management implications (e.g., surveillance, prophylactic surgery, targeted therapy). Guides clinical decision-making.. Valid values are `actionable|potentially actionable|not actionable|unknown`',
    `clinvar_submission_date` DATE COMMENT 'Date when the variant interpretation was submitted to ClinVar. Null if not yet submitted.',
    `clinvar_submission_status` STRING COMMENT 'Status of Genomics Biotechs submission of this variant interpretation to ClinVar. Tracks regulatory and data-sharing compliance.. Valid values are `not submitted|submitted|accepted|under review|rejected`',
    `clinvar_variation_accession` STRING COMMENT 'ClinVar accession number for this variant (e.g., VCV000012345). Links to the public ClinVar database entry.',
    `created_by_user` STRING COMMENT 'User ID or name of the individual who created this variant entry. Audit trail for accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant knowledge base entry was first created in the system. Audit trail for data lineage.',
    `disease_association` STRING COMMENT 'Primary disease or clinical condition associated with this variant (e.g., Hereditary Breast and Ovarian Cancer Syndrome, Lynch Syndrome). Represents the clinical phenotype linked to the variant.',
    `evidence_level` STRING COMMENT 'Overall strength of evidence supporting the variant-disease association. Aggregates multiple evidence types per ACMG framework.. Valid values are `strong|moderate|supporting|limited|conflicting`',
    `functional_impact_prediction` STRING COMMENT 'Computational prediction of the variants functional impact on protein function. Aggregated from tools such as SIFT, PolyPhen-2, and CADD.. Valid values are `deleterious|tolerated|unknown`',
    `genomic_position` BIGINT COMMENT 'Genomic coordinate position of the variant on the reference genome. Represents the start position of the variant in base pairs.',
    `inheritance_pattern` STRING COMMENT 'Mode of inheritance for the disease associated with this variant. Critical for family risk assessment and genetic counseling.. Valid values are `autosomal dominant|autosomal recessive|X-linked|mitochondrial|unknown`',
    `internal_allele_frequency` DECIMAL(18,2) COMMENT 'Allele frequency of this variant within Genomics Biotechs tested population. Calculated as observation count divided by total alleles tested. Proprietary metric for internal variant prioritization.',
    `internal_notes` STRING COMMENT 'Free-text field for curator notes, interpretation rationale, or internal discussion points. Not included in external submissions or patient reports.',
    `internal_observation_count` STRING COMMENT 'Number of times this variant has been observed in Genomics Biotechs patient population. Proprietary frequency data distinct from public databases.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the individual who last modified this variant entry. Audit trail for change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant knowledge base entry was last updated. Tracks the currency of the interpretation.',
    `last_review_date` DATE COMMENT 'Date when this variant interpretation was last reviewed by a curator. Used to trigger periodic reanalysis per ACMG guidelines (recommended every 2 years).',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next periodic review of this variant interpretation. Supports compliance with reanalysis requirements.',
    `penetrance` STRING COMMENT 'Likelihood that individuals carrying this variant will develop the associated disease. Important for risk counseling.. Valid values are `high|moderate|low|variable|unknown`',
    `phi_compliant_flag` BOOLEAN COMMENT 'Indicates whether this variant entry has been de-identified and is compliant with HIPAA PHI requirements for data sharing. True if PHI-compliant.',
    `population_allele_frequency` DECIMAL(18,2) COMMENT 'Allele frequency in the general population as reported by gnomAD or other population databases. Used for variant filtering and classification.',
    `protein_change` STRING COMMENT 'HGVS protein-level notation for the amino acid change caused by the variant (e.g., p.Arg273His). Null for non-coding variants.',
    `reference_allele` STRING COMMENT 'Reference nucleotide sequence at the variant position as defined by the reference genome build.',
    `reference_genome_build` STRING COMMENT 'Reference genome assembly version used for variant coordinates (e.g., GRCh37, GRCh38). Critical for coordinate liftover and data integration.. Valid values are `GRCh37|GRCh38|hg19|hg38`',
    `supporting_literature_pubmed_ids` STRING COMMENT 'Comma-separated list of PubMed identifiers (PMIDs) for publications supporting the variant interpretation. Provides evidence traceability.',
    `transcript_consequence` STRING COMMENT 'Predicted effect of the variant on the transcript (e.g., missense_variant, frameshift_variant, splice_donor_variant). Uses Sequence Ontology terms.',
    `variant_identifier_hgvs` STRING COMMENT 'Standardized HGVS nomenclature for the genomic variant (e.g., NM_000059.3:c.274G>T). This is the canonical identifier used for variant representation across clinical genomics systems.. Valid values are `^[A-Z]{2}_[0-9]+.[0-9]+:[cgmnpr]..+$`',
    `variant_status` STRING COMMENT 'Current lifecycle status of this variant knowledge base entry. Active entries are used in clinical reporting; archived entries are retained for historical reference.. Valid values are `active|under review|archived|deprecated`',
    `variant_type` STRING COMMENT 'Classification of the variant by structural type: single nucleotide variant (SNV), insertion, deletion, indel, duplication, or inversion.. Valid values are `SNV|insertion|deletion|indel|duplication|inversion`',
    CONSTRAINT pk_variant_knowledge_base PRIMARY KEY(`variant_knowledge_base_id`)
) COMMENT 'Curated internal knowledge base of clinically significant variants observed in Genomics Biotechs patient population — capturing variant identifier (HGVS), gene, disease association, ACMG classification history, internal observation frequency, supporting literature (PubMed IDs), ClinVar submission status, expert panel review status (ClinGen), last review date, and curator identity. Distinct from the reference domains public variant databases — this is the proprietary clinical interpretation repository.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` (
    `clia_accreditation_id` BIGINT COMMENT 'Unique identifier for the CLIA or CAP accreditation record. Primary key for the accreditation entity. Role: MASTER_AGREEMENT.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to quality.audit. Business justification: CLIA inspections are formal regulatory audits that must be tracked in the audit system for findings, CAPAs, and follow-up. Required for CLIA compliance (42 CFR 493) and audit trail of regulatory inter',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: CLIA-accredited laboratories performing IVD testing must also maintain FDA establishment registration. Regulatory compliance audits cross-reference CLIA certificates with FDA establishment records. A ',
    `performing_laboratory_id` BIGINT COMMENT 'Foreign key linking to clinical.performing_laboratory. Business justification: clia_accreditation is the master record of CLIA and CAP accreditation credentials for a laboratory. performing_laboratory is the entity that holds these credentials. This FK establishes the direct rel',
    `site_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_site. Business justification: CLIA certificates are issued to specific physical laboratory/manufacturing sites. In genomics biotech, manufacturing sites performing clinical testing must hold CLIA certificates. This link enables co',
    `accreditation_fee_amount_usd` DECIMAL(18,2) COMMENT 'The total fee amount paid or due for the accreditation or certificate, expressed in US dollars. Includes application fees, inspection fees, and annual maintenance fees.',
    `accreditation_fee_payment_status` STRING COMMENT 'Current status of payment for accreditation fees. Tracks whether fees have been paid, are pending, or are overdue, which may impact accreditation standing.. Valid values are `Paid|Pending|Overdue|Waived|Refunded`',
    `accreditation_scope` STRING COMMENT 'Detailed description of the scope of testing authorized under this accreditation. Includes test categories, specialty areas, complexity levels (waived, moderate, high), and specific analytes or methodologies covered.',
    `accreditation_status` STRING COMMENT 'Current lifecycle status of the accreditation. Indicates whether the laboratory is currently authorized to perform clinical testing under this accreditation.. Valid values are `Active|Suspended|Revoked|Expired|Pending Renewal|Under Review`',
    `certificate_number` STRING COMMENT 'The externally-issued unique certificate or accreditation number assigned by CLIA or CAP. Business identifier for the accreditation agreement.',
    `certificate_type` STRING COMMENT 'Classification of the accreditation or certificate type. Indicates the regulatory framework and scope of laboratory operations permitted.. Valid values are `CLIA Certificate of Waiver|CLIA Certificate of Compliance|CLIA Certificate of Accreditation|CAP Accreditation|State License`',
    `complexity_level` STRING COMMENT 'The CLIA complexity categorization of tests authorized under this accreditation. Determines regulatory requirements for personnel, quality control, and proficiency testing.. Valid values are `Waived|Moderate Complexity|High Complexity`',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this accreditation record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this accreditation record was first created in the system. Used for audit trail and data lineage tracking.',
    `deficiencies_cited_count` STRING COMMENT 'The total number of deficiencies or non-conformances identified during the most recent inspection. Used to assess compliance risk and prioritize corrective actions.',
    `deficiency_summary` STRING COMMENT 'Narrative summary of the deficiencies or non-conformances cited during the most recent inspection. Includes checklist item references, severity classification, and areas requiring corrective action.',
    `effective_date` DATE COMMENT 'The date on which the accreditation or certificate became valid and the laboratory was authorized to begin or continue clinical testing operations under this credential.',
    `expiration_date` DATE COMMENT 'The date on which the accreditation or certificate expires and must be renewed. Nullable for indefinite or rolling accreditations pending inspection cycles.',
    `inspection_outcome` STRING COMMENT 'The overall result or finding from the most recent inspection. Indicates whether the laboratory met all requirements, had minor recommendations, or had deficiencies requiring corrective action.. Valid values are `Accredited|Accredited with Recommendations|Conditional|Deficiencies Cited|Failed`',
    `issuing_body` STRING COMMENT 'The regulatory or accrediting organization that issued the certificate. Examples include CMS (Centers for Medicare & Medicaid Services), CAP (College of American Pathologists), state health departments, or other approved accrediting organizations.. Valid values are `CMS|CAP|State Agency|Joint Commission|COLA`',
    `laboratory_address` STRING COMMENT 'The physical address of the clinical laboratory facility. Required for regulatory reporting, inspection scheduling, and certificate issuance. Organizational contact data classified as confidential.',
    `laboratory_clia_number` STRING COMMENT 'The unique 10-digit CLIA identification number assigned to the laboratory by CMS. This is the primary regulatory identifier for the laboratory and is distinct from the certificate number.',
    `laboratory_name` STRING COMMENT 'The official name of the clinical laboratory holding this accreditation. Used for regulatory reporting, certificate display, and external communications.',
    `last_inspection_date` DATE COMMENT 'The date of the most recent on-site inspection or survey conducted by the accrediting body or regulatory agency. Critical for tracking compliance cycles and renewal timelines.',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this accreditation record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this accreditation record was last updated or modified. Used for audit trail, change tracking, and data quality monitoring.',
    `next_inspection_due_date` DATE COMMENT 'The scheduled or anticipated date for the next on-site inspection or survey. Used for proactive compliance planning and resource allocation.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context related to the accreditation record. May include special conditions, historical context, or internal tracking information.',
    `pt_analyte_test_system` STRING COMMENT 'The specific analyte, test system, or specialty area evaluated through proficiency testing. Examples include Glucose, HbA1c, Molecular Oncology, Cytogenetics, or specific gene panels.',
    `pt_corrective_action_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether corrective action is required in response to unsuccessful proficiency testing performance. True indicates corrective action is required; False indicates acceptable performance.',
    `pt_enrollment_period` STRING COMMENT 'The time period or cycle for which the laboratory is enrolled in the proficiency testing program. Typically expressed as a year or year-quarter (e.g., 2024-Q1, 2024 Annual).',
    `pt_graded_outcome` STRING COMMENT 'The overall graded outcome or performance result for the proficiency testing cycle. Indicates whether the laboratory met acceptable performance criteria for the analyte or test system.. Valid values are `Successful|Unsuccessful|Partial Success|Not Graded|Pending`',
    `pt_program_name` STRING COMMENT 'The name of the proficiency testing program in which the laboratory is enrolled. Examples include CAP Surveys, ARUP Proficiency Testing, or other CMS-approved PT providers.',
    `pt_results_submitted_count` STRING COMMENT 'The number of proficiency testing results or reports submitted by the laboratory during the enrollment period. Used to verify compliance with PT submission requirements.',
    `pt_sample_sets_received` STRING COMMENT 'The number of proficiency testing sample sets or challenges received by the laboratory during the enrollment period. Used to track PT participation completeness.',
    `pt_score_percent` DECIMAL(18,2) COMMENT 'The percentage score achieved by the laboratory on the proficiency testing challenge. Calculated as the number of acceptable results divided by the total number of challenges, expressed as a percentage.',
    `pt_submission_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the laboratory submitted proficiency testing results by the required deadline. True indicates on-time submission; False indicates late or missing submission.',
    `pt_submission_deadline` DATE COMMENT 'The deadline by which proficiency testing results must be submitted to the PT provider. Used to track compliance with PT submission timelines and avoid late submission penalties.',
    `renewal_application_date` DATE COMMENT 'The date on which the laboratory submitted the renewal application for the accreditation or certificate. Used to track renewal cycle timelines and compliance with submission deadlines.',
    `renewal_workflow_status` STRING COMMENT 'Current status of the accreditation renewal process. Tracks the laboratorys progress through the renewal application, review, and approval workflow.. Valid values are `Not Started|Application Submitted|Under Review|Approved|Denied|Pending Payment`',
    `test_specialty_areas` STRING COMMENT 'Comma-separated list of specialty areas or disciplines covered by the accreditation (e.g., Molecular Pathology, Cytogenetics, Clinical Chemistry, Hematology, Microbiology). Defines the breadth of clinical testing capabilities.',
    CONSTRAINT pk_clia_accreditation PRIMARY KEY(`clia_accreditation_id`)
) COMMENT 'Master record of CLIA and CAP accreditation credentials and associated proficiency testing compliance for the clinical laboratory. Captures certificate type (CLIA Certificate of Compliance, CAP accreditation), certificate number, issuing body, accreditation scope (test categories, specialty areas), effective date, expiration date, inspection date, deficiencies cited, corrective action status, renewal workflow status, proficiency testing enrollment (PT program name, analyte/test system evaluated, enrollment period, sample sets, results submitted, graded outcomes, corrective action references, submission deadline compliance). SSOT for laboratory accreditation standing and PT compliance tracking.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` (
    `clinical_consent_record_id` BIGINT COMMENT 'Unique identifier for the clinical consent record. Primary key for tracking patient consent throughout the clinical genomics workflow.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Clinical labs track institutional account affiliations for consent management in research collaborations and IRB protocol compliance. Required for institutional consent reporting, HIPAA business assoc',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Consent records must reference the specific IRB-approved consent form version used. Regulatory requirement for human subjects research (45 CFR 46) and clinical testing (CLIA/CAP). Critical for audit t',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Consent records must be linked to the consenting physician contact for HIPAA/GDPR compliance audits and recontact workflows. consenting_physician_name and consenting_physician_npi are denormalized con',
    `irb_submission_id` BIGINT COMMENT 'Foreign key linking to research.irb_submission. Business justification: Consent records must link to specific IRB submissions for audit trails, protocol version compliance, continuing review documentation, and regulatory inspections (FDA, OHRP). Required for human subject',
    `patient_id` BIGINT COMMENT 'Unique identifier linking this consent record to the patient in the clinical system. Required for PHI-compliant consent tracking.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Consent records link to research projects for data use authorization tracking, HIPAA compliance, research participant enrollment verification, and project-level consent reporting. Essential for resear',
    `study_id` BIGINT COMMENT 'Foreign key linking to research.study. Business justification: IRB continuing review requires each consent record to be directly traceable to the research study it covers. clinical_consent_record has irb_submission_id and rd_project_id but no direct study_id; def',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Research consent records link to regulatory submissions (IND, IDE, 510k validation studies) when patient samples are used for regulatory evidence generation. Required for IRB compliance and FDA audit ',
    `test_order_id` BIGINT COMMENT 'Foreign key linking to clinical.test_order. Business justification: clinical_consent_record captures patient informed consent for clinical genomic testing. It has patient_id but lacks a direct link to the specific test_order it covers. Consent is obtained for specific',
    `audit_trail_reference` STRING COMMENT 'Reference identifier to the detailed audit trail log for this consent record. Required for 21 CFR Part 11 compliance and regulatory inspections.',
    `biobanking_permitted_flag` BOOLEAN COMMENT 'Indicates whether patient consented to long-term storage of biological samples for future research or testing. Required for biorepository management.',
    `consent_date` DATE COMMENT 'Date when the patient provided informed consent. Used to determine consent validity period and regulatory compliance timelines.',
    `consent_document_number` STRING COMMENT 'Business identifier for the consent document. Used for audit trails and regulatory submissions.. Valid values are `^[A-Z0-9]{8,20}$`',
    `consent_expiration_date` DATE COMMENT 'Date when the consent expires and must be renewed. Null for consents without expiration. Required for time-limited research protocols.',
    `consent_language` STRING COMMENT 'ISO 639-3 three-letter language code indicating the language in which consent was obtained. Required for multilingual patient populations and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `consent_location` STRING COMMENT 'Physical or virtual location where consent was obtained (clinic name, hospital, telehealth platform). Required for audit trails and regulatory compliance.',
    `consent_method` STRING COMMENT 'Method by which consent was obtained from the patient or legal guardian. Determines documentation and audit requirements.. Valid values are `written_paper|electronic_signature|verbal_documented|guardian_written|guardian_electronic`',
    `consent_scope_description` STRING COMMENT 'Detailed description of what the patient consented to, including specific tests, data usage, and sharing permissions. Required for informed consent documentation.',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent record. Determines whether genomic testing and data usage are permissible.. Valid values are `active|withdrawn|expired|pending|revoked|superseded`',
    `consent_type` STRING COMMENT 'Category of consent provided by the patient. Determines scope of permissible genomic testing and data usage.. Valid values are `germline_testing|somatic_testing|research_use|biobanking|incidental_findings|data_sharing`',
    `consent_version` STRING COMMENT 'Version identifier of the consent form template used. Required for tracking consent form changes over time and ensuring regulatory compliance.. Valid values are `^v[0-9]{1,3}.[0-9]{1,3}$`',
    `consenting_party_name` STRING COMMENT 'Full legal name of the individual who provided consent. Required for legal documentation and audit trails.',
    `consenting_party_type` STRING COMMENT 'Relationship of the person providing consent to the patient. Required for minors, incapacitated patients, or legally authorized representatives.. Valid values are `patient|legal_guardian|parent|healthcare_proxy|court_appointed`',
    `created_by_user` STRING COMMENT 'User identifier of the person who created this consent record. Required for accountability and audit trails.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was first created in the system. Required for audit trails and data lineage tracking.',
    `data_sharing_permitted_flag` BOOLEAN COMMENT 'Indicates whether patient consented to sharing of de-identified genomic data with external databases or research consortia. Required for NIH and GDPR compliance.',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether this consent record meets GDPR requirements for EU patients. Required for international genomic testing operations.',
    `germline_testing_permitted_flag` BOOLEAN COMMENT 'Indicates whether patient consented to germline genomic testing (inherited variants). Critical for test ordering and result interpretation.',
    `incidental_findings_return_flag` BOOLEAN COMMENT 'Indicates whether patient consented to receive incidental or secondary findings from genomic testing. Required per ACMG guidelines for return of results.',
    `interpreter_used_flag` BOOLEAN COMMENT 'Indicates whether a medical interpreter was used during the consent process. Required for documenting informed consent quality and regulatory compliance.',
    `irb_approval_date` DATE COMMENT 'Date when the IRB approved the consent form and protocol. Used to validate consent form currency and regulatory compliance.',
    `irb_protocol_number` STRING COMMENT 'IRB protocol number under which this consent was obtained. Required for research use and clinical trial genomic testing.. Valid values are `^IRB-[A-Z0-9]{6,15}$`',
    `last_modified_by_user` STRING COMMENT 'User identifier of the person who last modified this consent record. Required for accountability and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was last modified. Required for audit trails and change tracking.',
    `phi_compliant_flag` BOOLEAN COMMENT 'Indicates whether this consent record meets all HIPAA PHI protection requirements. Used for compliance audits and data governance.',
    `recontact_permitted_flag` BOOLEAN COMMENT 'Indicates whether patient consented to be recontacted for future research opportunities or updated findings. Required for longitudinal genomic studies.',
    `regulatory_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the regulatory jurisdiction governing this consent. Required for multi-country genomic testing operations.. Valid values are `^[A-Z]{3}$`',
    `research_use_permitted_flag` BOOLEAN COMMENT 'Indicates whether patient consented to use of genomic data for research purposes beyond clinical care. Required for NIH data sharing compliance.',
    `signature_reference` STRING COMMENT 'Reference identifier to the stored signature artifact (electronic or scanned paper). Used for audit and legal verification purposes.',
    `somatic_testing_permitted_flag` BOOLEAN COMMENT 'Indicates whether patient consented to somatic genomic testing (tumor/acquired variants). Required for oncology genomic testing workflows.',
    `withdrawal_date` DATE COMMENT 'Date when patient withdrew consent. Null if consent has not been withdrawn. Required for GDPR right to withdraw and HIPAA compliance.',
    `withdrawal_method` STRING COMMENT 'Method by which patient communicated withdrawal of consent. Required for audit trail and regulatory compliance. Null if consent not withdrawn.. Valid values are `written|verbal|electronic|email|phone`',
    `withdrawal_reason` STRING COMMENT 'Free-text explanation of why patient withdrew consent. Used for quality improvement and regulatory reporting. Null if consent not withdrawn.',
    `witness_name` STRING COMMENT 'Full name of the witness who observed the consent process. Required for certain consent types and regulatory jurisdictions. Null if witness not required.',
    `witness_signature_reference` STRING COMMENT 'Reference identifier to the stored witness signature artifact. Required for certain consent types. Null if witness not required.',
    CONSTRAINT pk_clinical_consent_record PRIMARY KEY(`clinical_consent_record_id`)
) COMMENT 'PHI-compliant record of patient informed consent for clinical genomic testing — capturing consent type (germline testing, somatic testing, research use, biobanking, return of incidental findings), consent version, consent date, method of consent (written/electronic), patient or guardian signature reference, IRB protocol number, withdrawal status, and withdrawal date. Required for HIPAA compliance, GDPR data subject rights, and NIH Genomic Data Sharing Policy adherence.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` (
    `assay_qc_run_id` BIGINT COMMENT 'Unique identifier for the quality control run record. Primary key for the assay QC run entity.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: QC runs validate assay performance within specifications established in the regulatory approval (LOD, sensitivity, specificity). Required for demonstrating continued compliance with approval condition',
    `assay_development_id` BIGINT COMMENT 'Foreign key linking to research.assay_development. Business justification: QC scientists trace assay QC run results back to the originating assay development record to investigate deviations and make lot release decisions. Regulatory submissions require this traceability. No',
    `assay_version_id` BIGINT COMMENT 'Foreign key linking to clinical.assay_version. Business justification: assay_qc_run is a QC run record for a clinical assay batch or sequencing run. It has ivd_test_catalog_id → test_catalog but lacks a direct link to the specific assay_version being quality-controlled. ',
    `asset_id` BIGINT COMMENT 'Reference to the sequencing instrument or analysis platform on which the QC run was performed. Critical for instrument-specific performance tracking and calibration.',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Repeated assay QC run failures trigger CAPA initiation per CLIA/CAP requirements. assay_qc_run has capa_initiated_flag and capa_reference_number (denormalized text) — replacing with a proper FK to qua',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: QC runs validate specific commercial test products; catalog linkage required for lot release decisions, regulatory submissions (validation reports), and product-specific quality metrics tracking per C',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to instrument.configuration. Business justification: Assay QC runs must be traceable to the exact instrument configuration (software version, run parameters, enabled modules) for reproducibility and CLIA/CAP compliance. Configuration changes can invalid',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: QC run failures (coverage depth, contamination, control failures, Westgard rule violations) are the primary source of quality deviations in clinical genomics labs. Must link for root cause analysis, C',
    `flow_cell_id` BIGINT COMMENT 'Unique identifier of the flow cell used in the sequencing run. Tracks consumable lot-level performance and enables traceability for NGS quality issues.',
    `test_catalog_id` BIGINT COMMENT 'Reference to the clinical test catalog entry for which this QC run was performed. Links to the specific assay version and test definition.',
    `performing_laboratory_id` BIGINT COMMENT 'Foreign key linking to clinical.performing_laboratory. Business justification: assay_qc_run is a QC run performed at a specific CLIA/CAP-accredited laboratory. The performing_laboratory is the entity responsible for executing the QC run and making lot release decisions. This FK ',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_run. Business justification: Assay QC runs validate clinical test performance using bioinformatics pipeline outputs (positive/negative controls, coverage metrics, contamination checks). Links QC metrics to the pipeline execution ',
    `sample_specimen_id` BIGINT COMMENT 'Identifier of the positive control sample included in the QC run. Used to verify assay sensitivity and detect false negatives.',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: QC runs consume reagent batches; lot-to-lot performance tracking required for release decisions and trending analysis. Replaces denormalized reagent_lot_number with proper FK for batch genealogy and s',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: QC runs validate specific reagent materials/lots before clinical use; material-level tracking enables lot release decisions, regulatory compliance (CLIA/CAP), and investigation of QC failures linked t',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Clinical QC runs must trace to specific reagent lots (library prep kits, sequencing reagents) for regulatory compliance, lot release decisions, and root cause analysis when QC failures occur. Critical',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: GMP-compliant genomics labs must trace QC run results to the specific received supply batch of reagents. This enables lot-level failure investigations, batch recall responses, and lot release decision',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: QC run data (precision, accuracy, control performance) is included in regulatory submissions as analytical performance evidence for FDA 510(k)/PMA and CE-IVD technical files. Regulatory affairs teams ',
    `sequencing_run_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_run. Business justification: Clinical assay QC runs validate sequencing run quality for diagnostic use. Regulatory requirement for CLIA/CAP compliance - QC controls must be traceable to the sequencing run they validate. Essential',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: QC lot release decisions in genomics labs are made by comparing run metrics against product specification acceptance criteria. assay_qc_run.acceptance_criteria_version signals this relationship exists',
    `acceptance_criteria_version` STRING COMMENT 'Version identifier of the acceptance criteria document used to evaluate this QC run. Ensures traceability to validated QC thresholds.',
    `capa_initiated_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a CAPA workflow was initiated as a result of this QC run failure or out-of-specification result.',
    `cluster_density` DECIMAL(18,2) COMMENT 'Number of clusters per square millimeter on the flow cell. Optimal density ensures adequate signal intensity without overcrowding that degrades quality.',
    `contamination_check_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of cross-sample contamination detected through allele frequency analysis or sample fingerprinting. Values above threshold trigger QC failure.',
    `coverage_uniformity_percent` DECIMAL(18,2) COMMENT 'Percentage of target bases covered at a uniform depth, indicating consistency of sequencing across the target region. Low uniformity may indicate technical issues.',
    `created_by_user` STRING COMMENT 'Username or identifier of the laboratory personnel who created this QC run record. Part of the audit trail required for CLIA and CAP compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this QC run record was first created in the laboratory information management system.',
    `duplicate_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of sequencing reads identified as PCR or optical duplicates. High duplicate rates reduce effective coverage and may indicate library complexity issues.',
    `error_rate_percent` DECIMAL(18,2) COMMENT 'Estimated sequencing error rate based on PhiX control or known reference sequences. Monitors instrument and reagent performance over time.',
    `failure_reason` STRING COMMENT 'Detailed explanation of why the QC run failed, including which metrics or controls did not meet acceptance criteria. Used for root cause analysis and CAPA.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the laboratory personnel who last modified this QC run record. Maintains complete audit trail for regulatory inspections.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this QC run record was last updated. Supports audit trail and change tracking for regulatory compliance.',
    `library_prep_kit_lot` STRING COMMENT 'Lot number of the library preparation kit used for sample processing prior to sequencing. Tracks consumable quality impact on QC metrics.',
    `lot_release_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this QC run supports lot release decisions for reagents or consumables. Used in manufacturing quality control workflows.',
    `mean_coverage_depth` DECIMAL(18,2) COMMENT 'Average number of sequencing reads covering each base position across the target region. Key metric for assessing sequencing quality and variant calling confidence.',
    `negative_control_result` STRING COMMENT 'Pass/fail determination for the negative control sample. Failure indicates potential contamination or specificity issues.. Valid values are `pass|fail|indeterminate`',
    `no_template_control_result` STRING COMMENT 'Pass/fail determination for the no-template control. Detects reagent contamination or carryover from previous runs.. Valid values are `pass|fail|indeterminate`',
    `on_target_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of sequencing reads that align to the intended target regions. Low on-target rates indicate library preparation or capture efficiency issues.',
    `positive_control_result` STRING COMMENT 'Pass/fail determination for the positive control sample. Failure indicates potential assay sensitivity issues requiring investigation.. Valid values are `pass|fail|indeterminate`',
    `q30_score_percent` DECIMAL(18,2) COMMENT 'Percentage of bases with Phred quality score of 30 or higher, indicating base call accuracy of 99.9% or better. Industry standard metric for sequencing quality.',
    `qc_run_number` STRING COMMENT 'Business identifier for the QC run, typically formatted as a human-readable run number used in laboratory documentation and CLIA compliance records.',
    `qc_status` STRING COMMENT 'Overall pass/fail determination for the QC run based on acceptance criteria evaluation. Determines whether patient samples from this run can be reported.. Valid values are `pass|fail|conditional_pass|under_review`',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this QC run data is included in regulatory submissions to FDA, EMA, or other governing bodies for assay validation or post-market surveillance.',
    `review_comments` STRING COMMENT 'Free-text comments from the reviewing scientist documenting observations, conditional pass justifications, or follow-up actions required.',
    `review_timestamp` TIMESTAMP COMMENT 'Timestamp when the reviewing scientist completed their evaluation and signed off on the QC run. Establishes audit trail for regulatory compliance.',
    `run_completion_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the QC run completed all processing steps and generated final metrics.',
    `run_date` DATE COMMENT 'The calendar date on which the QC run was executed in the clinical laboratory.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the QC run was initiated on the sequencing instrument or analysis platform.',
    `westgard_rule_evaluation` STRING COMMENT 'Result of Westgard multi-rule statistical QC evaluation applied to control samples. Documents which Westgard rules (1-2s, 1-3s, 2-2s, R-4s, 4-1s, 10x) were triggered, if any.',
    CONSTRAINT pk_assay_qc_run PRIMARY KEY(`assay_qc_run_id`)
) COMMENT 'Quality control run record for a clinical assay batch or sequencing run — capturing QC run ID, assay version, run date, instrument ID, reagent lot numbers, control sample results (positive, negative, no-template), QC metrics (coverage uniformity, on-target rate, duplicate rate, mean coverage depth, contamination check), Westgard rule evaluation, pass/fail determination per acceptance criteria, and reviewing scientist sign-off. Supports CLIA QC documentation, Westgard multi-rule monitoring, and lot release decisions. Links failed QC runs to CAPA workflows.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` (
    `authorized_orderer_id` BIGINT COMMENT 'Primary key for authorized_orderer',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Ordering physicians are credentialed and affiliated with healthcare institution accounts for test authorization, billing coordination, and regulatory compliance. Essential for clinical lab operations:',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: An authorized orderer (credentialed ordering physician) maps directly to a CRM contact record. Genomics biotech operations require this link for sales engagement, report delivery preference management',
    `study_id` BIGINT COMMENT 'Foreign key linking to research.study. Business justification: Authorized orderers acting as principal investigators on research studies require study-specific ordering privileges. irb_protocol_number on authorized_orderer is a denormalized string reference to th',
    `billing_npi` STRING COMMENT 'NPI used for billing and reimbursement purposes. May differ from ordering NPI if billing is handled by a group practice or institution.. Valid values are `^[0-9]{10}$`',
    `cap_accredited_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the provider is affiliated with a CAP-accredited laboratory or institution. Used for quality assurance and accreditation reporting.',
    `clia_ordering_privilege` BOOLEAN COMMENT 'Boolean flag indicating whether the provider is authorized to order high-complexity CLIA tests. True if provider meets CLIA personnel qualifications for ordering genomic assays.',
    `consent_on_file_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a signed provider agreement and consent for test ordering is on file. Required before first test order can be accepted.',
    `created_by_user` STRING COMMENT 'User ID or name of the system user who created the authorized orderer record. Audit trail for accountability and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorized orderer record was first created in the system. Audit trail for data lineage and compliance reporting.',
    `credentialing_expiration_date` DATE COMMENT 'Date when the current credentialing verification expires and re-verification is required. Triggers proactive outreach for credential renewal.',
    `credentialing_notes` STRING COMMENT 'Free-text notes documenting special credentialing circumstances, verification sources, or exceptions granted during the credentialing process.',
    `credentialing_verification_date` DATE COMMENT 'Date when the providers credentials, licenses, and ordering privileges were last verified by the laboratory credentialing team. CLIA requires periodic re-verification.',
    `credentials` STRING COMMENT 'Professional credentials and degree designation of the ordering provider. Determines ordering authority scope for high-complexity genomic testing under CLIA regulations. [ENUM-REF-CANDIDATE: MD|DO|PhD|MS|CGC|LCGC|NP|PA|DVM|PharmD — 10 candidates stripped; promote to reference product]',
    `dea_number` STRING COMMENT 'DEA registration number for providers authorized to prescribe controlled substances. Optional field used for comprehensive provider identity verification.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `ehr_facility_code` STRING COMMENT 'Unique facility or organization identifier within the EHR system. Used for HL7 message routing and result interface mapping.',
    `ehr_system_name` STRING COMMENT 'Name of the EHR system used by the provider or institution (e.g., Epic, Cerner, Allscripts). Required for HL7 interface configuration and automated result delivery.',
    `email_address` STRING COMMENT 'Primary email address for the ordering provider. Used for electronic report delivery, test status notifications, and critical result alerts.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for secure report delivery. Legacy delivery channel still required by many institutions for PHI-compliant document transmission.',
    `first_name` STRING COMMENT 'Legal first name of the authorized ordering provider as registered with state medical board and credentialing authority.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the system user who last modified the authorized orderer record. Audit trail for change tracking and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorized orderer record was last updated. Tracks changes to credentialing status, contact information, or ordering privileges.',
    `last_name` STRING COMMENT 'Legal last name of the authorized ordering provider as registered with state medical board and credentialing authority.',
    `middle_name` STRING COMMENT 'Middle name or initial of the authorized ordering provider. Optional field for full legal name matching.',
    `npi` STRING COMMENT 'Ten-digit unique identification number issued by the Centers for Medicare and Medicaid Services (CMS) to healthcare providers in the United States. Required for CLIA-compliant test ordering and billing.. Valid values are `^[0-9]{10}$`',
    `ordering_status` STRING COMMENT 'Current status of the providers authorization to order clinical genomic tests. Active status required for test order acceptance. Inactive or revoked status blocks new orders.. Valid values are `active|inactive|suspended|pending_verification|revoked`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the ordering provider. Required for critical result notification and clinical consultation per CLIA requirements.',
    `report_delivery_method` STRING COMMENT 'Preferred method for delivering clinical genomic test reports to the ordering provider. Determines routing logic for automated report distribution.. Valid values are `ehr_integration|secure_portal|fax|email|mail`',
    `specialty` STRING COMMENT 'Primary medical specialty or practice area of the ordering provider (e.g., Medical Genetics, Oncology, Cardiology, Genetic Counseling). Used for test menu filtering and clinical decision support.',
    `state_license_expiration_date` DATE COMMENT 'Expiration date of the state medical license. Monitored for proactive re-credentialing and to prevent test orders from providers with lapsed licenses.',
    `state_license_number` STRING COMMENT 'State-issued medical license number for the ordering provider. Required for verification of ordering authority and CLIA compliance validation.',
    `state_license_state` STRING COMMENT 'Two-letter state code of the jurisdiction that issued the medical license. Determines geographic ordering authority and cross-state practice limitations.. Valid values are `^[A-Z]{2}$`',
    `subspecialty` STRING COMMENT 'Subspecialty or fellowship-trained area of focus within the primary specialty (e.g., Molecular Genetic Pathology, Pediatric Oncology). Provides additional context for test appropriateness validation.',
    `tax_number` STRING COMMENT 'Federal tax identification number (EIN or SSN) for the provider or practice. Used for billing, invoicing, and 1099 reporting.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `test_menu_access_level` STRING COMMENT 'Level of access to the clinical genomic test catalog based on provider credentials and specialty. Determines which tests the provider is authorized to order.. Valid values are `full|restricted|specialty_limited|research_only`',
    CONSTRAINT pk_authorized_orderer PRIMARY KEY(`authorized_orderer_id`)
) COMMENT 'Master registry of physicians, genetic counselors, and clinical institutions authorized to order clinical genomic tests — capturing provider NPI, name, credentials, specialty, institutional affiliation, CLIA ordering privileges, state licensure verification, preferred report delivery method (EHR/fax/portal), active/inactive status, and credentialing verification date. Required for CLIA compliance (only authorized providers may order high-complexity tests) and report delivery routing. Distinct from customer domain accounts — this is the clinical credentialing and ordering authority registry.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`assay` (
    `assay_id` BIGINT COMMENT 'Primary key for clinical_assay',
    `assay_development_id` BIGINT COMMENT 'Foreign key linking to research.assay_development. Business justification: Product lifecycle management requires direct traceability from the deployed clinical assay to the R&D assay development program that produced it, for IVD regulatory submissions and post-market surveil',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Clinical assays are governed by master SOPs and assay design documents that are controlled documents under CLIA/CAP. clinical_assay has no controlled_document link (assay_version has one, but the pare',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.model. Business justification: Clinical assays are developed and validated for a specific instrument model/platform. The platform plain-text column is a denormalized reference to instrument.model. Proper FK enables assay lifecycl',
    `predecessor_clinical_assay_id` BIGINT COMMENT 'Self-referencing FK on clinical_assay (predecessor_clinical_assay_id)',
    `analytical_validity` STRING COMMENT 'Evidence level supporting the analytical performance of the assay.',
    `assay_category` STRING COMMENT 'High‑level clinical domain the assay serves.',
    `assay_code` STRING COMMENT 'External catalog code or identifier used to reference the assay in laboratory information systems.',
    `assay_name` STRING COMMENT 'Human‑readable name of the clinical assay.',
    `assay_type` STRING COMMENT 'Technology category of the assay (e.g., next‑generation sequencing, polymerase chain reaction).',
    `billing_cpt_code` STRING COMMENT 'Current CPT code used for billing the assay to insurers.',
    `clia_capability` STRING COMMENT 'CLIA classification indicating the complexity level of the assay.',
    `clinical_assay_description` STRING COMMENT 'Detailed narrative describing the assay purpose, methodology, and clinical utility.',
    `clinical_validity` STRING COMMENT 'Evidence level supporting the clinical relevance of the assay results.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assay record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the assay price.',
    `detection_method` STRING COMMENT 'Method used to detect variants (e.g., hybrid capture, amplicon, SNP array).',
    `development_phase` STRING COMMENT 'Current stage of the assay in the product lifecycle.',
    `effective_date` DATE COMMENT 'Date on which the assay version became active for clinical ordering.',
    `interpretation_guidelines` STRING COMMENT 'Standardized rules for interpreting assay results and reporting.',
    `is_approved` BOOLEAN COMMENT 'True if the assay has received all required regulatory approvals for clinical use.',
    `is_companion_assay` BOOLEAN COMMENT 'Indicates whether the assay is a companion diagnostic for a specific therapy.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the assay within the laboratory workflow.',
    `limit_of_detection` DECIMAL(18,2) COMMENT 'Lowest variant allele frequency that can be reliably detected, expressed as a proportion.',
    `notes` STRING COMMENT 'Free‑form field for additional comments, caveats, or version‑specific remarks.',
    `owner` STRING COMMENT 'Internal team or department responsible for assay maintenance.',
    `price` DECIMAL(18,2) COMMENT 'Standard list price for the assay before discounts.',
    `regulatory_status` STRING COMMENT 'Regulatory classification of the assay for clinical use.',
    `reimbursement_status` STRING COMMENT 'Insurance reimbursement eligibility for the assay.',
    `retirement_date` DATE COMMENT 'Date on which the assay was withdrawn from clinical use, if applicable.',
    `sample_requirements` STRING COMMENT 'Specific collection, volume, or preservation requirements for the specimen.',
    `sensitivity_percent` DECIMAL(18,2) COMMENT 'Proportion of true positive variants correctly identified, expressed as a percentage.',
    `specificity_percent` DECIMAL(18,2) COMMENT 'Proportion of true negative results correctly reported, expressed as a percentage.',
    `specimen_type` STRING COMMENT 'Biological specimen accepted for the assay.',
    `storage_requirements` STRING COMMENT 'Temperature and handling conditions required for assay reagents and samples.',
    `subcategory` STRING COMMENT 'More granular classification within the primary assay category.',
    `target_gene` STRING COMMENT 'Gene(s) or genomic region that the assay is designed to detect or analyze.',
    `target_region` STRING COMMENT 'Specific genomic coordinates or exons targeted by the assay.',
    `technology` STRING COMMENT 'Underlying laboratory technology (e.g., sequencing, PCR, microarray).',
    `turnaround_time_days` STRING COMMENT 'Typical number of calendar days from sample receipt to result delivery.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the assay record.',
    `version` STRING COMMENT 'Version identifier for the assay, reflecting updates to protocol or analysis pipeline.',
    CONSTRAINT pk_assay PRIMARY KEY(`assay_id`)
) COMMENT 'Master reference table for clinical_assay. Referenced by clinical_assay_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` (
    `performing_laboratory_id` BIGINT COMMENT 'Primary key for performing_laboratory',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: External performing laboratories (reference labs, hospital labs) are customer accounts with service agreements and billing relationships. Genomics biotech operations require linking performing labs to',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: FDA 21 CFR Part 807 and EU IVDR require every performing laboratory to be registered as an establishment. Regulatory compliance reporting, inspection readiness, and facility-level post-market obligati',
    `parent_performing_laboratory_id` BIGINT COMMENT 'Self-referencing FK on performing_laboratory (parent_performing_laboratory_id)',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to quality.risk_assessment. Business justification: Each performing laboratory requires an operational risk assessment covering biosafety, data integrity, and capacity per ISO 13485 and CLIA requirements. This FK enables risk-stratified lab oversight, ',
    `site_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_site. Business justification: In genomics biotech, performing laboratories are co-located with or operate within manufacturing sites (especially for LDTs and IVDs). This link enables capacity planning, site compliance reporting, a',
    `accreditation_body` STRING COMMENT 'Regulatory or standards body that granted accreditation.',
    `accreditation_status` STRING COMMENT 'Accreditation lifecycle state for the laboratory.',
    `address_line1` STRING COMMENT 'Primary street address of the laboratory facility.',
    `cap_accredited` BOOLEAN COMMENT 'Indicates whether the laboratory is accredited by the College of American Pathologists.',
    `capacity_samples_per_day` STRING COMMENT 'Maximum number of samples the laboratory can process in a single day.',
    `city` STRING COMMENT 'City where the laboratory is located.',
    `clia_certified` BOOLEAN COMMENT 'Indicates whether the laboratory holds a CLIA certification.',
    `consent_required` BOOLEAN COMMENT 'Indicates whether patient consent is required for using samples processed by this laboratory.',
    `contact_person_name` STRING COMMENT 'Name of the primary contact person at the laboratory.',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the laboratory.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the laboratory record was first created in the system.',
    `data_retention_days` STRING COMMENT 'Number of days laboratory data is retained before archival or deletion, per compliance policy.',
    `effective_from` DATE COMMENT 'Date when the current accreditation became effective.',
    `effective_until` DATE COMMENT 'Date when the current accreditation expires or is scheduled for renewal.',
    `email_address` STRING COMMENT 'Primary contact email for the laboratory.',
    `instrument_count` STRING COMMENT 'Total number of analytical instruments owned by the laboratory.',
    `lab_code` STRING COMMENT 'External business identifier assigned to the laboratory (e.g., internal catalog or regulatory code).',
    `lab_type` STRING COMMENT 'Category of laboratory based on its primary function.',
    `limit_of_detection` DECIMAL(18,2) COMMENT 'Smallest analyte concentration reliably detectable by the laboratorys assays.',
    `operational_hours` STRING COMMENT 'Standard operating schedule of the laboratory.',
    `performing_laboratory_description` STRING COMMENT 'Free‑form text describing the laboratorys capabilities, specialties, and services.',
    `performing_laboratory_name` STRING COMMENT 'Human‑readable name of the laboratory.',
    `performing_laboratory_status` STRING COMMENT 'Current operational status of the laboratory.',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the laboratory.',
    `sensitivity_percent` DECIMAL(18,2) COMMENT 'Proportion of true positive results expressed as a percentage.',
    `specificity_percent` DECIMAL(18,2) COMMENT 'Proportion of true negative results expressed as a percentage.',
    `state_province` STRING COMMENT 'State or province of the laboratory location.',
    `throughput_per_day` STRING COMMENT 'Average number of samples actually processed per day.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the laboratory record.',
    CONSTRAINT pk_performing_laboratory PRIMARY KEY(`performing_laboratory_id`)
) COMMENT 'Master reference table for performing_laboratory. Referenced by performing_laboratory_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` (
    `test_site_authorization_id` BIGINT COMMENT 'Primary key for the test_site_authorization association',
    `performing_laboratory_id` BIGINT COMMENT 'Foreign key linking to the performing laboratory site authorized to run this test',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to the authorized clinical assay version in the test catalog',
    `accreditation_scope` STRING COMMENT 'The specific CLIA or CAP accreditation scope that covers this test at this laboratory site (e.g., CLIA High Complexity - Molecular Pathology, CAP Genomics Checklist). Distinct from the lab-level accreditation status.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this test-site authorization record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this test-site authorization became active and the laboratory was permitted to perform this assay. Tied to CLIA certificate scope effective date for this test at this site.',
    `expiry_date` DATE COMMENT 'Date when this test-site authorization expires or is scheduled for renewal, aligned with accreditation renewal cycles.',
    `is_active_offering` BOOLEAN COMMENT 'Indicates whether this test-site authorization is currently active and available for clinical order routing. False indicates the authorization has been suspended, expired, or retired.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this test-site authorization record was last updated.',
    `test_menu_access_level` STRING COMMENT 'Operational classification of how this test is offered at this site. ROUTINE=standard clinical offering; SEND_OUT=performed here on behalf of another site; RESEARCH_ONLY=not for clinical reporting; RESTRICTED=limited ordering criteria; VALIDATION=under validation, not yet live.',
    `turnaround_time_hours` STRING COMMENT 'Turnaround time commitment in hours for this specific test at this specific laboratory site. May differ from the catalog-level TAT due to site capacity, instrument availability, or logistics.',
    CONSTRAINT pk_test_site_authorization PRIMARY KEY(`test_site_authorization_id`)
) COMMENT 'This association product represents the Contract between test_catalog and performing_laboratory. It captures the governed authorization of a specific clinical assay version at a specific CLIA/CAP-certified laboratory site. Each record defines one test-lab authorization with its own lifecycle, accreditation scope, turnaround time commitment, and menu access level — attributes that exist only in the context of this specific test-site pairing and cannot reside on either the test catalog or the laboratory master alone.. Existence Justification: In clinical genomics operations, a single test (e.g., WGS, targeted panel) can be authorized and performed at multiple CLIA-certified laboratory sites, and each laboratory site is authorized to perform multiple tests. This is not a derived analytical correlation — genomics companies with multi-site operations actively govern which tests are authorized at which sites, with distinct effective dates, turnaround time commitments, and accreditation scope per site-test combination. The business explicitly manages this as a laboratory test offering or test site authorization — a recognized operational concept with its own lifecycle.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_assay_id` FOREIGN KEY (`assay_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay`(`assay_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_clia_accreditation_id` FOREIGN KEY (`clia_accreditation_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`clia_accreditation`(`clia_accreditation_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_assay_id` FOREIGN KEY (`assay_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay`(`assay_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_authorized_orderer_id` FOREIGN KEY (`authorized_orderer_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`authorized_orderer`(`authorized_orderer_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`patient`(`patient_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_authorized_orderer_id` FOREIGN KEY (`authorized_orderer_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`authorized_orderer`(`authorized_orderer_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_parent_specimen_clinical_specimen_id` FOREIGN KEY (`parent_specimen_clinical_specimen_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`clinical_specimen`(`clinical_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`patient`(`patient_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_assay_qc_run_id` FOREIGN KEY (`assay_qc_run_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_qc_run`(`assay_qc_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_clinical_specimen_id` FOREIGN KEY (`clinical_specimen_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`clinical_specimen`(`clinical_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`patient`(`patient_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_report_id` FOREIGN KEY (`report_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`report`(`report_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_variant_knowledge_base_id` FOREIGN KEY (`variant_knowledge_base_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base`(`variant_knowledge_base_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_clinical_specimen_id` FOREIGN KEY (`clinical_specimen_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`clinical_specimen`(`clinical_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_genomic_result_id` FOREIGN KEY (`genomic_result_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`genomic_result`(`genomic_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_report_id` FOREIGN KEY (`report_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`report`(`report_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_variant_knowledge_base_id` FOREIGN KEY (`variant_knowledge_base_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base`(`variant_knowledge_base_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`patient`(`patient_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ADD CONSTRAINT `fk_clinical_clia_accreditation_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`patient`(`patient_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay` ADD CONSTRAINT `fk_clinical_assay_predecessor_clinical_assay_id` FOREIGN KEY (`predecessor_clinical_assay_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay`(`assay_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ADD CONSTRAINT `fk_clinical_performing_laboratory_parent_performing_laboratory_id` FOREIGN KEY (`parent_performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` ADD CONSTRAINT `fk_clinical_test_site_authorization_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` ADD CONSTRAINT `fk_clinical_test_site_authorization_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`clinical` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `genomics_biotech_ecm`.`clinical` SET TAGS ('dbx_domain' = 'clinical');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` SET TAGS ('dbx_subdomain' = 'assay_management');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `assay_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Assay Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `clia_accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Clia Accreditation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `device_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `ivd_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Ivd Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `software_release_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Software Release Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `production_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Production Routing Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `qc_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Qc Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `analytical_sensitivity_percent` SET TAGS ('dbx_business_glossary_term' = 'Analytical Sensitivity Percentage');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `analytical_specificity_percent` SET TAGS ('dbx_business_glossary_term' = 'Analytical Specificity Percentage');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `assay_type` SET TAGS ('dbx_business_glossary_term' = 'Assay Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `assay_version_number` SET TAGS ('dbx_business_glossary_term' = 'Assay Version Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `assay_version_number` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `cap_accreditation_flag` SET TAGS ('dbx_business_glossary_term' = 'College of American Pathologists (CAP) Accreditation Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `change_rationale` SET TAGS ('dbx_business_glossary_term' = 'Change Rationale');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `clinical_validity_evidence` SET TAGS ('dbx_business_glossary_term' = 'Clinical Validity Evidence');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `cpt_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `cpt_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `intended_use_category` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Category');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `intended_use_category` SET TAGS ('dbx_value_regex' = 'IVD|RUO|LDT');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `limit_of_detection` SET TAGS ('dbx_business_glossary_term' = 'Limit of Detection (LOD)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `ordering_physician_specialty` SET TAGS ('dbx_business_glossary_term' = 'Ordering Physician Specialty');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `panel_gene_list_version` SET TAGS ('dbx_business_glossary_term' = 'Panel Gene List Version');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `phi_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `price_usd` SET TAGS ('dbx_business_glossary_term' = 'Test Price in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `reflex_testing_rules` SET TAGS ('dbx_business_glossary_term' = 'Reflex Testing Rules');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `reimbursement_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `retired_date` SET TAGS ('dbx_business_glossary_term' = 'Retired Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `test_description` SET TAGS ('dbx_business_glossary_term' = 'Test Description');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `test_menu_category` SET TAGS ('dbx_business_glossary_term' = 'Test Menu Category');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Test Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|discontinued|under_review');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) in Hours');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|in_validation|pending_validation|failed_validation|not_required');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` SET TAGS ('dbx_subdomain' = 'assay_management');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `assay_version_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Assay Version Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Reagent Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `assay_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Assay Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `labeling_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Library Prep Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `manufacturing_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Bom Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `molecular_design_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Design Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `software_release_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Software Release Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `pipeline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `qc_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Qc Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Research Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Validated Reagent Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `analytical_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Analytical Validation Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `analytical_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Analytical Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `analytical_validation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|approved|failed');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `annotation_database_version` SET TAGS ('dbx_business_glossary_term' = 'Variant Annotation Database Version');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Version Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `change_rationale` SET TAGS ('dbx_business_glossary_term' = 'Version Change Rationale');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `clia_complexity` SET TAGS ('dbx_business_glossary_term' = 'CLIA (Clinical Laboratory Improvement Amendments) Complexity Level');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `clia_complexity` SET TAGS ('dbx_value_regex' = 'waived|moderate|high');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `intended_use_statement` SET TAGS ('dbx_business_glossary_term' = 'Clinical Intended Use Statement');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `library_preparation_protocol` SET TAGS ('dbx_business_glossary_term' = 'Library Preparation Protocol Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `lod_unit` SET TAGS ('dbx_business_glossary_term' = 'Limit of Detection (LOD) Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `lod_value` SET TAGS ('dbx_business_glossary_term' = 'Limit of Detection (LOD) Value');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `minimum_coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Minimum Coverage Depth Threshold');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `minimum_phred_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Phred Quality Score');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `multiplexing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Sample Multiplexing Strategy');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `multiplexing_strategy` SET TAGS ('dbx_value_regex' = 'none|single_index|dual_index|unique_dual_index');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `panel_gene_list_version` SET TAGS ('dbx_business_glossary_term' = 'Gene Panel List Version');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `retired_date` SET TAGS ('dbx_business_glossary_term' = 'Version Retirement Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `sensitivity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Clinical Sensitivity Percentage');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `specificity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Clinical Specificity Percentage');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `target_read_length` SET TAGS ('dbx_business_glossary_term' = 'Target Sequencing Read Length');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `test_classification` SET TAGS ('dbx_business_glossary_term' = 'Test Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `test_classification` SET TAGS ('dbx_value_regex' = 'IVD|LDT|RUO');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Target Turnaround Time (TAT) in Hours');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `variant_calling_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Variant Calling Algorithm Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Assay Version Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Lifecycle Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|validation|active|deprecated|retired|withdrawn');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` SET TAGS ('dbx_subdomain' = 'patient_testing');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Institution Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `aliquot_id` SET TAGS ('dbx_business_glossary_term' = 'Aliquot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `assay_version_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `authorized_orderer_id` SET TAGS ('dbx_business_glossary_term' = 'Physician Panel Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Consumed Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Physician Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Accreditation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `performing_laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Laboratory Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lab Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `sample_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Specimen Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Specimen Accession Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `accession_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `accessioned_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Accessioned Date and Time');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `actual_tat_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Turnaround Time (TAT) in Hours');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|approved|denied|paid');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Test Completion Date and Time');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'obtained|pending|declined|not_required');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `icd10_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Code');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `icd10_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9]{1,4})?$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `icd10_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `icd10_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `insurance_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Prior Authorization Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `insurance_authorization_number` SET TAGS ('dbx_value_regex' = '^AUTH-[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `insurance_authorization_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_value_regex' = '^IRB-[A-Z0-9]{6,15}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Placement Date and Time');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Test Order Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^ORD-[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Test Order Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'received|accessioned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `ordering_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Ordering Institution Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `ordering_physician_npi` SET TAGS ('dbx_business_glossary_term' = 'Ordering Physician National Provider Identifier (NPI)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `ordering_physician_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `patient_gender` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `patient_gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `patient_gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `patient_medical_record_number` SET TAGS ('dbx_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `patient_medical_record_number` SET TAGS ('dbx_value_regex' = '^MRN-[A-Z0-9]{6,15}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `patient_medical_record_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `patient_medical_record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Test Order Priority');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'STAT|urgent|routine');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Order Received Date and Time');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Results Reported Date and Time');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `required_tat_hours` SET TAGS ('dbx_business_glossary_term' = 'Required Turnaround Time (TAT) in Hours');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `specimen_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Date and Time');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `specimen_type` SET TAGS ('dbx_value_regex' = 'blood|saliva|tissue|buccal_swab|bone_marrow|other');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `test_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Test Price in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ALTER COLUMN `test_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` SET TAGS ('dbx_subdomain' = 'patient_testing');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `biological_sex` SET TAGS ('dbx_business_glossary_term' = 'Biological Sex');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `biological_sex` SET TAGS ('dbx_value_regex' = 'male|female|unknown');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|phone|mail|patient portal|no contact');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consented|declined|pending|withdrawn|expired');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Patient Date of Birth (DOB)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `de_identification_flag` SET TAGS ('dbx_business_glossary_term' = 'De-Identification Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Patient Email Address');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Patient Ethnicity');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Patient First Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `gdpr_data_subject_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Data Subject Rights Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `gender_identity` SET TAGS ('dbx_value_regex' = 'male|female|non-binary|other|prefer not to say|unknown');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `gender_identity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `guardian_email` SET TAGS ('dbx_business_glossary_term' = 'Guardian Email Address');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `guardian_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `guardian_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `guardian_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `guardian_name` SET TAGS ('dbx_business_glossary_term' = 'Guardian or Proxy Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `guardian_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `guardian_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `guardian_phone` SET TAGS ('dbx_business_glossary_term' = 'Guardian Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `guardian_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `guardian_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `guardian_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `guardian_relationship` SET TAGS ('dbx_business_glossary_term' = 'Guardian Relationship Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `guardian_relationship` SET TAGS ('dbx_value_regex' = 'parent|legal guardian|healthcare proxy|power of attorney|other');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `hipaa_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Authorization Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `insurance_group_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Group Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `insurance_group_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Insurance Provider Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `insurance_provider` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Last Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Middle Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `mrn` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `ordering_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Ordering Facility Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `patient_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Record Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `patient_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deceased|merged|test');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Language');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `primary_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `race` SET TAGS ('dbx_business_glossary_term' = 'Patient Race');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `referring_physician_name` SET TAGS ('dbx_business_glossary_term' = 'Referring Physician Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `referring_physician_npi` SET TAGS ('dbx_business_glossary_term' = 'Referring Physician National Provider Identifier (NPI)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `referring_physician_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `research_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Research Participation Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` SET TAGS ('dbx_subdomain' = 'patient_testing');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `clinical_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Specimen Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `aliquot_id` SET TAGS ('dbx_business_glossary_term' = 'Aliquot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `authorized_orderer_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Orderer Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Kit Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Site Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `parent_specimen_clinical_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Specimen Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `qc_result_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Result Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `sample_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Specimen Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accession Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `accession_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `aliquot_count` SET TAGS ('dbx_business_glossary_term' = 'Aliquot Count');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `chain_of_custody_events` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Events Log');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `clotting_observed` SET TAGS ('dbx_business_glossary_term' = 'Clotting Observed Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `collection_site_clia_number` SET TAGS ('dbx_business_glossary_term' = 'Collection Site Clinical Laboratory Improvement Amendments (CLIA) Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `collection_site_clia_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}D[0-9]{7}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `collection_time` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Specimen Comments');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Obtained Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Container Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `preanalytical_qc_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Analytical Quality Control (QC) Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `preanalytical_qc_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Specimen Quantity Received');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Specimen Quantity Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'ml|mg|ug|cells|slides');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Receipt Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Receipt Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Specimen Rejection Reason');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `source_anatomical_site` SET TAGS ('dbx_business_glossary_term' = 'Specimen Source Anatomical Site');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `specimen_status` SET TAGS ('dbx_business_glossary_term' = 'Specimen Lifecycle Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `specimen_status` SET TAGS ('dbx_value_regex' = 'received|in_processing|qc_passed|qc_failed|consumed|archived');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_value_regex' = 'blood|saliva|buccal_swab|ffpe|cfdna|tissue');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Specimen Storage Condition');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'room_temp|refrigerated|frozen_minus20|frozen_minus80|liquid_nitrogen');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ALTER COLUMN `volume_collected_ml` SET TAGS ('dbx_business_glossary_term' = 'Specimen Volume Collected (Milliliters)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` SET TAGS ('dbx_subdomain' = 'assay_management');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `analytical_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Validation ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `assay_development_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Development Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `assay_version_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `equipment_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Qualification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Assay ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `performing_laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Laboratory Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `pipeline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol Document ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Research Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Validated Reagent Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Reagent Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Reagent Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `accuracy_bias` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Bias Percentage');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `analytical_sensitivity` SET TAGS ('dbx_business_glossary_term' = 'Analytical Sensitivity');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `analytical_specificity` SET TAGS ('dbx_business_glossary_term' = 'Analytical Specificity');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `approving_scientist_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Scientist Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Validation Comments');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Classification');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `intended_use` SET TAGS ('dbx_value_regex' = 'ivd|ruo|ldt');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `interference_result` SET TAGS ('dbx_business_glossary_term' = 'Interference Study Result');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `interference_result` SET TAGS ('dbx_value_regex' = 'no_interference|interference_detected|conditionally_acceptable');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `interference_substances_tested` SET TAGS ('dbx_business_glossary_term' = 'Interference Substances Tested');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `linearity_r_squared` SET TAGS ('dbx_business_glossary_term' = 'Linearity R-Squared Coefficient');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `linearity_range_lower` SET TAGS ('dbx_business_glossary_term' = 'Linearity Range Lower Limit');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `linearity_range_unit` SET TAGS ('dbx_business_glossary_term' = 'Linearity Range Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `linearity_range_upper` SET TAGS ('dbx_business_glossary_term' = 'Linearity Range Upper Limit');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `lod_unit` SET TAGS ('dbx_business_glossary_term' = 'Limit of Detection (LOD) Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `lod_value` SET TAGS ('dbx_business_glossary_term' = 'Limit of Detection (LOD) Value');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `pass_fail_determination` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Determination');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `pass_fail_determination` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `precision_repeatability` SET TAGS ('dbx_business_glossary_term' = 'Precision Repeatability Coefficient of Variation (CV)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `precision_reproducibility` SET TAGS ('dbx_business_glossary_term' = 'Precision Reproducibility Coefficient of Variation (CV)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `reference_population_description` SET TAGS ('dbx_business_glossary_term' = 'Reference Population Description');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `reference_range_lower` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Lower Limit');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `reference_range_unit` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `reference_range_upper` SET TAGS ('dbx_business_glossary_term' = 'Reference Range Upper Limit');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `replicate_count` SET TAGS ('dbx_business_glossary_term' = 'Replicate Count');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Validation Sample Size');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `validation_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `validation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `validation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Start Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|approved|failed|on_hold');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_business_glossary_term' = 'Validation Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_value_regex' = 'initial|revalidation|verification|method_comparison|bridging');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` SET TAGS ('dbx_subdomain' = 'genomic_reporting');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `genomic_result_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Result Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `alignment_result_id` SET TAGS ('dbx_business_glossary_term' = 'Alignment Result Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `assay_qc_run_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Assay Run Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `assay_version_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Assay Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `clinical_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Specimen Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `extraction_id` SET TAGS ('dbx_business_glossary_term' = 'Extraction Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `library_id` SET TAGS ('dbx_business_glossary_term' = 'Library Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Report Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `variant_call_result_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Call Result Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `variant_knowledge_base_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Knowledge Base Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `acmg_classification_criteria` SET TAGS ('dbx_business_glossary_term' = 'ACMG (American College of Medical Genetics and Genomics) Classification Criteria');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `alternate_allele` SET TAGS ('dbx_business_glossary_term' = 'Alternate Allele');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `chromosome` SET TAGS ('dbx_business_glossary_term' = 'Chromosome');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `chromosome` SET TAGS ('dbx_value_regex' = '^(chr)?([1-9]|1[0-9]|2[0-2]|X|Y|MT?)$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_business_glossary_term' = 'Clinical Significance');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_value_regex' = 'pathogenic|likely_pathogenic|uncertain_significance|likely_benign|benign');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `clinvar_accession` SET TAGS ('dbx_business_glossary_term' = 'ClinVar Accession Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `clinvar_accession` SET TAGS ('dbx_value_regex' = '^(VCV|RCV|SCV)[0-9]+');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `cosmic_accession` SET TAGS ('dbx_business_glossary_term' = 'COSMIC (Catalogue of Somatic Mutations in Cancer) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `cosmic_accession` SET TAGS ('dbx_value_regex' = '^COSM[0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Coverage Depth');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `dbsnp_accession` SET TAGS ('dbx_business_glossary_term' = 'dbSNP (Database of Single Nucleotide Polymorphisms) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `dbsnp_accession` SET TAGS ('dbx_value_regex' = '^rs[0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `disease_association` SET TAGS ('dbx_business_glossary_term' = 'Disease Association');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `filter_status` SET TAGS ('dbx_business_glossary_term' = 'Variant Filter Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `filter_status` SET TAGS ('dbx_value_regex' = 'PASS|low_quality|low_coverage|strand_bias|failed');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `genomic_position_end` SET TAGS ('dbx_business_glossary_term' = 'Genomic Position End');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `genomic_position_start` SET TAGS ('dbx_business_glossary_term' = 'Genomic Position Start');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `hgvs_coding` SET TAGS ('dbx_business_glossary_term' = 'HGVS (Human Genome Variation Society) Coding Nomenclature');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `hgvs_protein` SET TAGS ('dbx_business_glossary_term' = 'HGVS (Human Genome Variation Society) Protein Nomenclature');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `incidental_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Incidental Finding Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `maf_gnomad` SET TAGS ('dbx_business_glossary_term' = 'Minor Allele Frequency (MAF) from gnomAD');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `pharmacogenomic_implication` SET TAGS ('dbx_business_glossary_term' = 'Pharmacogenomic Implication');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `pharmacogenomic_implication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `pharmacogenomic_implication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `phred_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Phred Quality Score');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `reference_allele` SET TAGS ('dbx_business_glossary_term' = 'Reference Allele');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Result Reporting Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Clinical Result Interpretation');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|amended|corrected|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `result_type` SET TAGS ('dbx_business_glossary_term' = 'Genomic Result Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `result_type` SET TAGS ('dbx_value_regex' = 'snp_genotype|cnv_call|somatic_variant|germline_variant|pharmacogenomic_result|structural_variant');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Genomic Result Value');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `result_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `result_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `variant_allele_frequency` SET TAGS ('dbx_business_glossary_term' = 'Variant Allele Frequency (VAF)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `variant_classification` SET TAGS ('dbx_business_glossary_term' = 'Variant Classification');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `variant_database_version` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Version');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `zygosity` SET TAGS ('dbx_business_glossary_term' = 'Variant Zygosity');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ALTER COLUMN `zygosity` SET TAGS ('dbx_value_regex' = 'homozygous|heterozygous|hemizygous|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` SET TAGS ('dbx_subdomain' = 'genomic_reporting');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `variant_interpretation_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Interpretation ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `assay_version_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Assay ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `clinical_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Specimen Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `genomic_result_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Result Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Guideline Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `library_id` SET TAGS ('dbx_business_glossary_term' = 'Library Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Report Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `variant_annotation_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Annotation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `variant_call_result_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Call Result ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `variant_knowledge_base_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Knowledge Base Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `accreditation_scope` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `accreditation_scope` SET TAGS ('dbx_value_regex' = 'CLIA|CAP|ISO_15189|CE_IVD|RUO');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `acmg_classification` SET TAGS ('dbx_business_glossary_term' = 'ACMG (American College of Medical Genetics and Genomics) Classification');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `acmg_classification` SET TAGS ('dbx_value_regex' = 'pathogenic|likely_pathogenic|VUS|likely_benign|benign');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `acmg_evidence_codes` SET TAGS ('dbx_business_glossary_term' = 'ACMG (American College of Medical Genetics and Genomics) Evidence Codes');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `allele_frequency` SET TAGS ('dbx_business_glossary_term' = 'Allele Frequency');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `alternate_allele` SET TAGS ('dbx_business_glossary_term' = 'Alternate Allele');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `chromosome` SET TAGS ('dbx_business_glossary_term' = 'Chromosome');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `chromosome` SET TAGS ('dbx_value_regex' = '^(chr)?(1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|X|Y|M|MT)$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `classification_version` SET TAGS ('dbx_business_glossary_term' = 'Classification Version');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_business_glossary_term' = 'Clinical Significance');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `clinvar_accession` SET TAGS ('dbx_business_glossary_term' = 'ClinVar Accession');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `clinvar_classification` SET TAGS ('dbx_business_glossary_term' = 'ClinVar Classification');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `disease_association` SET TAGS ('dbx_business_glossary_term' = 'Disease Association');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `genomic_position` SET TAGS ('dbx_business_glossary_term' = 'Genomic Position');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `guideline_version` SET TAGS ('dbx_business_glossary_term' = 'Guideline Version');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `inheritance_pattern` SET TAGS ('dbx_business_glossary_term' = 'Inheritance Pattern');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `inheritance_pattern` SET TAGS ('dbx_value_regex' = 'autosomal_dominant|autosomal_recessive|X_linked_dominant|X_linked_recessive|mitochondrial|multifactorial');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `interpretation_date` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `interpretation_rationale` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Rationale');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_value_regex' = 'draft|final|amended|reviewed|archived');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `literature_references` SET TAGS ('dbx_business_glossary_term' = 'Literature References');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `mondo_accession` SET TAGS ('dbx_business_glossary_term' = 'MONDO (Monarch Disease Ontology) ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `omim_accession` SET TAGS ('dbx_business_glossary_term' = 'OMIM (Online Mendelian Inheritance in Man) ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `phi_flag` SET TAGS ('dbx_business_glossary_term' = 'PHI (Protected Health Information) Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `population_database` SET TAGS ('dbx_business_glossary_term' = 'Population Database');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `reference_allele` SET TAGS ('dbx_business_glossary_term' = 'Reference Allele');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `report_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Report Inclusion Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `variant_consequence` SET TAGS ('dbx_business_glossary_term' = 'Variant Consequence');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `variant_identifier` SET TAGS ('dbx_business_glossary_term' = 'Variant Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `variant_type` SET TAGS ('dbx_business_glossary_term' = 'Variant Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `zygosity` SET TAGS ('dbx_business_glossary_term' = 'Zygosity');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ALTER COLUMN `zygosity` SET TAGS ('dbx_value_regex' = 'heterozygous|homozygous|hemizygous|compound_heterozygous');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` SET TAGS ('dbx_subdomain' = 'genomic_reporting');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Report Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `assay_version_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `software_release_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Software Release Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `pipeline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `amended_content` SET TAGS ('dbx_business_glossary_term' = 'Amended Content');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `amendment_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notification Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `amendment_notification_status` SET TAGS ('dbx_value_regex' = 'pending|notified|acknowledged');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'correction|addendum|clarification|retraction');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `assay_name` SET TAGS ('dbx_business_glossary_term' = 'Assay Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `assay_version` SET TAGS ('dbx_business_glossary_term' = 'Assay Version');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `authorizing_pathologist_credentials` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Pathologist Credentials');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `authorizing_pathologist_name` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Pathologist Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `clinical_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Clinical Interpretation Narrative');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `confirmatory_testing_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Confirmatory Testing Recommended Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Report Delivery Method');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'ehr_integration|secure_portal|email|fax|mail');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Delivery Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `electronic_signature` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `electronic_signature` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Finalized Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Report Format');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'pdf|hl7_fhir|hl7_v2|xml');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `genetic_counseling_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Genetic Counseling Recommended Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Report Language');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `ordering_physician_name` SET TAGS ('dbx_business_glossary_term' = 'Ordering Physician Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `ordering_physician_npi` SET TAGS ('dbx_business_glossary_term' = 'Ordering Physician National Provider Identifier (NPI)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `ordering_physician_npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `patient_date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Patient Date of Birth');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `patient_date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `patient_date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `patient_identifier` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `patient_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `patient_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `patient_sex` SET TAGS ('dbx_business_glossary_term' = 'Patient Biological Sex');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `patient_sex` SET TAGS ('dbx_value_regex' = 'male|female|unknown');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `patient_sex` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `patient_sex` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `phi_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Clinical Recommendations');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Report Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|amended|corrected|retracted');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `result_summary` SET TAGS ('dbx_business_glossary_term' = 'Result Summary');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `result_summary` SET TAGS ('dbx_value_regex' = 'positive|negative|inconclusive|variant_of_uncertain_significance');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `specimen_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) in Hours');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `variant_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Variant Findings Summary');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Report Version Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` SET TAGS ('dbx_subdomain' = 'genomic_reporting');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `variant_knowledge_base_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Knowledge Base ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `assay_development_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Development Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Curation Sop Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `acmg_classification` SET TAGS ('dbx_business_glossary_term' = 'American College of Medical Genetics and Genomics (ACMG) Classification');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `acmg_classification` SET TAGS ('dbx_value_regex' = 'pathogenic|likely pathogenic|uncertain significance|likely benign|benign');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `acmg_classification_date` SET TAGS ('dbx_business_glossary_term' = 'ACMG Classification Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `acmg_criteria_applied` SET TAGS ('dbx_business_glossary_term' = 'ACMG Criteria Applied');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `alternate_allele` SET TAGS ('dbx_business_glossary_term' = 'Alternate Allele');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `chromosome` SET TAGS ('dbx_business_glossary_term' = 'Chromosome');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `chromosome` SET TAGS ('dbx_value_regex' = '^(chr)?([1-9]|1[0-9]|2[0-2]|X|Y|MT?)$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `clingen_expert_panel_name` SET TAGS ('dbx_business_glossary_term' = 'ClinGen Expert Panel Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `clingen_expert_panel_review_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Genome Resource (ClinGen) Expert Panel Review Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `clingen_expert_panel_review_status` SET TAGS ('dbx_value_regex' = 'not reviewed|under review|reviewed|approved|disputed');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `clinical_actionability` SET TAGS ('dbx_business_glossary_term' = 'Clinical Actionability');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `clinical_actionability` SET TAGS ('dbx_value_regex' = 'actionable|potentially actionable|not actionable|unknown');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `clinvar_submission_date` SET TAGS ('dbx_business_glossary_term' = 'ClinVar Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `clinvar_submission_status` SET TAGS ('dbx_business_glossary_term' = 'ClinVar Submission Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `clinvar_submission_status` SET TAGS ('dbx_value_regex' = 'not submitted|submitted|accepted|under review|rejected');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `clinvar_variation_accession` SET TAGS ('dbx_business_glossary_term' = 'ClinVar Variation ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `created_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `disease_association` SET TAGS ('dbx_business_glossary_term' = 'Disease Association');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `evidence_level` SET TAGS ('dbx_business_glossary_term' = 'Evidence Level');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `evidence_level` SET TAGS ('dbx_value_regex' = 'strong|moderate|supporting|limited|conflicting');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `functional_impact_prediction` SET TAGS ('dbx_business_glossary_term' = 'Functional Impact Prediction');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `functional_impact_prediction` SET TAGS ('dbx_value_regex' = 'deleterious|tolerated|unknown');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `genomic_position` SET TAGS ('dbx_business_glossary_term' = 'Genomic Position');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `inheritance_pattern` SET TAGS ('dbx_business_glossary_term' = 'Inheritance Pattern');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `inheritance_pattern` SET TAGS ('dbx_value_regex' = 'autosomal dominant|autosomal recessive|X-linked|mitochondrial|unknown');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `internal_allele_frequency` SET TAGS ('dbx_business_glossary_term' = 'Internal Allele Frequency');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `internal_observation_count` SET TAGS ('dbx_business_glossary_term' = 'Internal Observation Count');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `penetrance` SET TAGS ('dbx_business_glossary_term' = 'Penetrance');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `penetrance` SET TAGS ('dbx_value_regex' = 'high|moderate|low|variable|unknown');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `phi_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `population_allele_frequency` SET TAGS ('dbx_business_glossary_term' = 'Population Allele Frequency');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `protein_change` SET TAGS ('dbx_business_glossary_term' = 'Protein Change');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `reference_allele` SET TAGS ('dbx_business_glossary_term' = 'Reference Allele');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `reference_genome_build` SET TAGS ('dbx_business_glossary_term' = 'Reference Genome Build');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `reference_genome_build` SET TAGS ('dbx_value_regex' = 'GRCh37|GRCh38|hg19|hg38');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `supporting_literature_pubmed_ids` SET TAGS ('dbx_business_glossary_term' = 'Supporting Literature PubMed IDs');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `transcript_consequence` SET TAGS ('dbx_business_glossary_term' = 'Transcript Consequence');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `variant_identifier_hgvs` SET TAGS ('dbx_business_glossary_term' = 'Human Genome Variation Society (HGVS) Variant Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `variant_identifier_hgvs` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}_[0-9]+.[0-9]+:[cgmnpr]..+$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `variant_status` SET TAGS ('dbx_business_glossary_term' = 'Variant Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `variant_status` SET TAGS ('dbx_value_regex' = 'active|under review|archived|deprecated');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `variant_type` SET TAGS ('dbx_business_glossary_term' = 'Variant Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ALTER COLUMN `variant_type` SET TAGS ('dbx_value_regex' = 'SNV|insertion|deletion|indel|duplication|inversion');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` SET TAGS ('dbx_subdomain' = 'assay_management');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `clia_accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Accreditation ID');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `performing_laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Laboratory Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `accreditation_fee_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Fee Amount (USD)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `accreditation_fee_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `accreditation_fee_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Fee Payment Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `accreditation_fee_payment_status` SET TAGS ('dbx_value_regex' = 'Paid|Pending|Overdue|Waived|Refunded');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `accreditation_scope` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'Active|Suspended|Revoked|Expired|Pending Renewal|Under Review');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Certificate Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'CLIA Certificate of Waiver|CLIA Certificate of Compliance|CLIA Certificate of Accreditation|CAP Accreditation|State License');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `complexity_level` SET TAGS ('dbx_business_glossary_term' = 'Test Complexity Level');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `complexity_level` SET TAGS ('dbx_value_regex' = 'Waived|Moderate Complexity|High Complexity');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `deficiencies_cited_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiencies Cited Count');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `deficiency_summary` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Summary');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'Accredited|Accredited with Recommendations|Conditional|Deficiencies Cited|Failed');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `issuing_body` SET TAGS ('dbx_value_regex' = 'CMS|CAP|State Agency|Joint Commission|COLA');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `laboratory_address` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Address');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `laboratory_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `laboratory_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `laboratory_clia_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Clinical Laboratory Improvement Amendments (CLIA) Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Notes');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `pt_analyte_test_system` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing (PT) Analyte or Test System');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `pt_corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing (PT) Corrective Action Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `pt_enrollment_period` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing (PT) Enrollment Period');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `pt_graded_outcome` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing (PT) Graded Outcome');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `pt_graded_outcome` SET TAGS ('dbx_value_regex' = 'Successful|Unsuccessful|Partial Success|Not Graded|Pending');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `pt_program_name` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing (PT) Program Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `pt_results_submitted_count` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing (PT) Results Submitted Count');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `pt_sample_sets_received` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing (PT) Sample Sets Received');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `pt_score_percent` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing (PT) Score Percentage');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `pt_submission_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing (PT) Submission Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `pt_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Testing (PT) Submission Deadline');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `renewal_application_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `renewal_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Workflow Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `renewal_workflow_status` SET TAGS ('dbx_value_regex' = 'Not Started|Application Submitted|Under Review|Approved|Denied|Pending Payment');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ALTER COLUMN `test_specialty_areas` SET TAGS ('dbx_business_glossary_term' = 'Test Specialty Areas');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` SET TAGS ('dbx_subdomain' = 'patient_testing');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `clinical_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Consent Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `irb_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Irb Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `biobanking_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Biobanking Permitted Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_document_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language Code');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_location` SET TAGS ('dbx_business_glossary_term' = 'Consent Location');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'written_paper|electronic_signature|verbal_documented|guardian_written|guardian_electronic');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope Description');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'active|withdrawn|expired|pending|revoked|superseded');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'germline_testing|somatic_testing|research_use|biobanking|incidental_findings|data_sharing');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_value_regex' = '^v[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consenting_party_name` SET TAGS ('dbx_business_glossary_term' = 'Consenting Party Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consenting_party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consenting_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consenting_party_type` SET TAGS ('dbx_business_glossary_term' = 'Consenting Party Type');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `consenting_party_type` SET TAGS ('dbx_value_regex' = 'patient|legal_guardian|parent|healthcare_proxy|court_appointed');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `data_sharing_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Permitted Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `germline_testing_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Germline Testing Permitted Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `incidental_findings_return_flag` SET TAGS ('dbx_business_glossary_term' = 'Incidental Findings Return Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `interpreter_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_value_regex' = '^IRB-[A-Z0-9]{6,15}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `phi_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `recontact_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Recontact Permitted Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Code');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `research_use_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Research Use Permitted Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Signature Reference Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `signature_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `somatic_testing_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Somatic Testing Permitted Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `withdrawal_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Method');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `withdrawal_method` SET TAGS ('dbx_value_regex' = 'written|verbal|electronic|email|phone');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Reason');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `witness_signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Reference');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ALTER COLUMN `witness_signature_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` SET TAGS ('dbx_subdomain' = 'assay_management');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `assay_qc_run_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Quality Control (QC) Run Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `assay_development_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Development Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `assay_version_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Instrument Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `flow_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Flow Cell Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'In Vitro Diagnostic (IVD) Test Catalog Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `performing_laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Laboratory Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `sample_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Positive Control Sample Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Supply Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `acceptance_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Version');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `capa_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Initiated Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `cluster_density` SET TAGS ('dbx_business_glossary_term' = 'Cluster Density');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `contamination_check_percent` SET TAGS ('dbx_business_glossary_term' = 'Contamination Check Percentage');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `coverage_uniformity_percent` SET TAGS ('dbx_business_glossary_term' = 'Coverage Uniformity Percentage');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `duplicate_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Read Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `error_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Error Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Failure Reason');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `library_prep_kit_lot` SET TAGS ('dbx_business_glossary_term' = 'Library Preparation Kit Lot Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `lot_release_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Lot Release Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `mean_coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Mean Coverage Depth');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `negative_control_result` SET TAGS ('dbx_business_glossary_term' = 'Negative Control Result Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `negative_control_result` SET TAGS ('dbx_value_regex' = 'pass|fail|indeterminate');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `no_template_control_result` SET TAGS ('dbx_business_glossary_term' = 'No Template Control (NTC) Result Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `no_template_control_result` SET TAGS ('dbx_value_regex' = 'pass|fail|indeterminate');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `on_target_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Target Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `positive_control_result` SET TAGS ('dbx_business_glossary_term' = 'Positive Control Result Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `positive_control_result` SET TAGS ('dbx_value_regex' = 'pass|fail|indeterminate');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `q30_score_percent` SET TAGS ('dbx_business_glossary_term' = 'Q30 Phred Quality Score Percentage');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `qc_run_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Run Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `qc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `qc_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|under_review');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Comments');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `run_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Run Completion Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Run Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Run Start Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ALTER COLUMN `westgard_rule_evaluation` SET TAGS ('dbx_business_glossary_term' = 'Westgard Multi-Rule Evaluation Result');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` SET TAGS ('dbx_subdomain' = 'assay_management');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `authorized_orderer_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Orderer Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `billing_npi` SET TAGS ('dbx_business_glossary_term' = 'Billing National Provider Identifier (NPI)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `billing_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `billing_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `billing_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `cap_accredited_flag` SET TAGS ('dbx_business_glossary_term' = 'College of American Pathologists (CAP) Accredited Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `clia_ordering_privilege` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Ordering Privilege');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `consent_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent on File Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `credentialing_notes` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Notes');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `credentialing_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Verification Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `credentials` SET TAGS ('dbx_business_glossary_term' = 'Professional Credentials');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `dea_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `dea_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `dea_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `ehr_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) Facility Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `ehr_system_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) System Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Provider Email Address');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Provider Fax Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Provider First Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Last Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Middle Name');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `ordering_status` SET TAGS ('dbx_business_glossary_term' = 'Ordering Authorization Status');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `ordering_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification|revoked');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Provider Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `report_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Report Delivery Method');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `report_delivery_method` SET TAGS ('dbx_value_regex' = 'ehr_integration|secure_portal|fax|email|mail');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Medical Specialty');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `state_license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'State License Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `state_license_number` SET TAGS ('dbx_business_glossary_term' = 'State Medical License Number');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `state_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `state_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `state_license_state` SET TAGS ('dbx_business_glossary_term' = 'State License Issuing State');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `state_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `subspecialty` SET TAGS ('dbx_business_glossary_term' = 'Medical Subspecialty');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `tax_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `test_menu_access_level` SET TAGS ('dbx_business_glossary_term' = 'Test Menu Access Level');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ALTER COLUMN `test_menu_access_level` SET TAGS ('dbx_value_regex' = 'full|restricted|specialty_limited|research_only');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay` SET TAGS ('dbx_subdomain' = 'assay_management');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay` ALTER COLUMN `assay_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Assay Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay` ALTER COLUMN `assay_development_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Development Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay` ALTER COLUMN `predecessor_clinical_assay_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` SET TAGS ('dbx_subdomain' = 'assay_management');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `performing_laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Laboratory Identifier');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `parent_performing_laboratory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` SET TAGS ('dbx_subdomain' = 'assay_management');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` SET TAGS ('dbx_association_edges' = 'clinical.test_catalog,clinical.performing_laboratory');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` ALTER COLUMN `test_site_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Test Site Authorization - Test Site Authorization Id');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` ALTER COLUMN `performing_laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Test Site Authorization - Performing Laboratory Id');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Site Authorization - Test Catalog Id');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` ALTER COLUMN `accreditation_scope` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` ALTER COLUMN `is_active_offering` SET TAGS ('dbx_business_glossary_term' = 'Active Offering Flag');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` ALTER COLUMN `test_menu_access_level` SET TAGS ('dbx_business_glossary_term' = 'Test Menu Access Level');
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_site_authorization` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Site-Specific TAT Commitment');
